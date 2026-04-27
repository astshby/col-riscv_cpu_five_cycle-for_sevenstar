`timescale 1ns / 1ps

`include "define.vh"

module ID_stage (
    input logic clk,
    input logic rst,

    // 来自IF/ID寄存器的信息
    input logic [`REG_WIDTH-1:0] instruction, // 来自IF/ID寄存器的指令
    input logic [`REG_WIDTH-1:0] pc,          // 来自IF/ID寄存器

    // 分支单元计算得到的分支目标地址，传递给IF阶段
    output logic [`REG_WIDTH-1:0] branch_target,

    // 来自WB阶段的信息 写回(有穿透)
    input logic [`REG_ADDR_WIDTH-1:0] rd_addr_WB,       // 来自WB阶段的写回数据
    input logic [`REG_WIDTH-1:0] rd_data_WB,       // 来自WB阶段的写回数据
    input logic wen,                // 来自WB阶段的写使能

    // 传递给pipeline control unit的信号，告诉它当前指令是否需要使用rs1和rs2，是否是分支指令
    output logic use_rs1,
    output logic use_rs2,
    output logic is_jump_or_branch, // 当前指令是否是分支或跳转
    output logic branch_taken, // 分支单元计算得到的分支是否成立信号，传递给pipeline control unit 再去看是不是真跳转

    // forwarding相关信号
    input logic [`REG_WIDTH-1:0] forward_data_from_MEM, // 来自MEM阶段的前递数据
    input logic [1:0] forward_A_sel_ID, // rs1的前递选择信号
    input logic [1:0] forward_B_sel_ID, // rs2的前递选择信号

    // 传递给EX阶段的信息
    output logic [`REG_ADDR_WIDTH-1:0] rs1_addr,
    output logic [`REG_ADDR_WIDTH-1:0] rs2_addr,
    output logic [`REG_ADDR_WIDTH-1:0] rd_addr,
    output logic [`REG_WIDTH-1:0] rs1data_from_regfile, // 从寄存器堆读出的rs1数据(有WB穿透)
    output logic [`REG_WIDTH-1:0] rs2data_from_regfile, // 从寄存器堆读出的rs2数据
    output logic [`REG_WIDTH-1:0] imm,
    output logic [`ALU_OP_WIDTH-1:0] alu_opcode,
    output logic [`ALUA_SEL_WIDTH-1:0] alua_sel,
    output logic [`ALUB_SEL_WIDTH-1:0] alub_sel,
    output logic [`RF_WSEL_WIDTH-1:0] reg_w_sel,
    output logic reg_write,
    output logic mem_read,
    output logic mem_write,
    output logic [2:0] func3, // 传递给 MEM 阶段的 funct3 字段

    // === CSR 写回接口 (来自 WB 阶段，同时用于 csrFile 写端口和 WB 级前递) ===
    input logic csr_we_WB,
    input logic [`CSR_ADDR_WIDTH-1:0] csr_addr_WB,
    input logic [`REG_WIDTH-1:0] csr_result_new_WB,

    // === CSR 前递接口 (来自 EX/MEM 阶段，用于 CSR-CSR RAW 零 stall 前递) ===
    input logic csr_we_EX,
    input logic [`CSR_ADDR_WIDTH-1:0] csr_addr_EX,
    input logic [`REG_WIDTH-1:0] csr_result_new_EX,
    input logic csr_we_MEM,
    input logic [`CSR_ADDR_WIDTH-1:0] csr_addr_MEM,
    input logic [`REG_WIDTH-1:0] csr_result_new_MEM,

    // === 性能计数器输入 (连接 csrFile 的硬件计数器) ===
    input logic perf_wrong_branch,
    input logic perf_valid_inst,
    input logic perf_control_xfer,

    // === CSR 信号输出 (传给 ID_EX_pipe) ===
    output logic csr_op,
    output logic [`CSR_ADDR_WIDTH-1:0] csr_addr,
    output logic [`REG_WIDTH-1:0] csr_data_old
);

    logic [`REG_WIDTH-1:0] forwarded_rs1data; // 前递单元处理后的rs1数据，传递给分支单元进行比较
    logic [`REG_WIDTH-1:0] forwarded_rs2data; // 前递单元处理后的rs2数据，传递给分支单元进行比较

    logic [`Sext_OP_WIDTH-1:0] gen_imm_op;
    logic [`ALU_SEL_WIDTH-1:0] alu_sel;
    logic [`BRANCH_TYPE_WIDTH-1:0] branch_type; // control.sv 输出的分支类型

    // CSR 内部信号
    logic [`REG_WIDTH-1:0] csr_raw_data; // csrFile 直接读出的值 (未经前递)

    assign rs1_addr = instruction[19:15];
    assign rs2_addr = instruction[24:20];
    assign rd_addr = instruction[11:7];
    assign func3 = instruction[14:12]; // 从指令中解析出 funct3 字段，传递给 MEM 阶段
    assign is_jump_or_branch = |branch_type; // 由 branch_type 派生
    assign csr_addr = instruction[31:20]; // 12 位 CSR 地址

    // 控制单元 (根据指令的opcode生成控制信号)
    control control(
        .opcode(instruction[6:0]),

        .gen_imm_op(gen_imm_op),
        .alu_sel(alu_sel),
        .alua_sel(alua_sel),
        .alub_sel(alub_sel),
        .reg_w_sel(reg_w_sel),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .use_rs1(use_rs1),
        .use_rs2(use_rs2),
        .branch_type(branch_type),
        .csr_op(csr_op)
    );

    alu_op alu_op(
        .opcode_6(instruction[5]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .alu_sel(alu_sel),
        .alu_opcode(alu_opcode)
    );

    // 寄存器堆 (具有内部数据穿透功能)
    regfile regfile(
        .clk(clk),
        .rst(rst),
        .rs1addr(rs1_addr),
        .rs2addr(rs2_addr),
        .rdaddr(rd_addr_WB),
        .wdata(rd_data_WB),
        .wen(wen),
        .rs1data(rs1data_from_regfile),
        .rs2data(rs2data_from_regfile)
    );


    // 立即数生成模块 (直接从指令中解析出立即数)
    gen_imm gen_imm(
        .inst(instruction[31:7]), // 传入指令的高25位
        .gen_imm_op(gen_imm_op),
        .imm_out(imm)
    );

    // 分支单元 (使用预解码的 branch_type，消除重复 opcode 解码)
    branch_unit branch_unit(
        .branch_type(branch_type),
        .funct3(instruction[14:12]),
        .pc(pc),
        .rs1data(forwarded_rs1data), // 连接分支前递单元的输出，确保分支单元使用前递后的数据进行比较
        .rs2data(forwarded_rs2data),
        .imm(imm),
        .branch_taken(branch_taken),
        .branch_target(branch_target)
    );


    // 前递多选器 (GPR + CSR 统一前递，选择最终传递给分支单元和 CSR 通路的数据)
    Forwarding_ID fwd_ID(
        .forward_A_sel_ID(forward_A_sel_ID),
        .forward_B_sel_ID(forward_B_sel_ID),

        .original_rs1data(rs1data_from_regfile),
        .original_rs2data(rs2data_from_regfile),
        .forward_data_from_WB(rd_data_WB),
        .forward_data_from_MEM(forward_data_from_MEM),

        .forwarded_rs1data(forwarded_rs1data),
        .forwarded_rs2data(forwarded_rs2data),

        // CSR 前递 (EX > MEM > WB > csrFile)
        .csr_raw_data(csr_raw_data),
        .csr_addr_ID(csr_addr),
        .csr_we_EX(csr_we_EX),
        .csr_addr_EX(csr_addr_EX),
        .csr_result_new_EX(csr_result_new_EX),
        .csr_we_MEM(csr_we_MEM),
        .csr_addr_MEM(csr_addr_MEM),
        .csr_result_new_MEM(csr_result_new_MEM),
        .csr_we_WB(csr_we_WB),
        .csr_addr_WB(csr_addr_WB),
        .csr_result_new_WB(csr_result_new_WB),
        .csr_data_old(csr_data_old)
    );

    // ==========================================
    // CSR 寄存器堆 (组合读，时序写，含硬件性能计数器)
    // ==========================================
    csrFile csrFile_inst(
        .clk          (clk),
        .wEn          (csr_we_WB),
        .wData        (csr_result_new_WB),
        .wAddr        (csr_addr_WB),
        .wrongBranch  (perf_wrong_branch),
        .validInst    (perf_valid_inst),
        .controlXfer  (perf_control_xfer),
        .readAddr     (csr_addr[3:0]),    // 16 项，取低 4 位寻址
        .csr          (csr_raw_data)
    );

endmodule
