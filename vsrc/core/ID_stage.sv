`timescale 1ns / 1ps

`include "define.vh"

module ID_stage (
    input logic clk,
    input logic rst,

    // 来自IF/ID寄存器的信息
    input logic [31:0] instruction, // 来自IF/ID寄存器的指令
    input logic [31:0] pc,          // 来自IF/ID寄存器

    // 分支单元计算得到的分支目标地址，传递给IF阶段
    output logic [31:0] branch_target, 

    // 来自WB阶段的信息 写回(有穿透)
    input logic [4:0]  rd_addr_WB,       // 来自WB阶段的写回数据
    input logic [31:0] rd_data_WB,       // 来自WB阶段的写回数据
    input logic wen,                // 来自WB阶段的写使能

    // 传递给pipeline control unit的信号，告诉它当前指令是否需要使用rs1和rs2，是否是分支指令
    output logic use_rs1,
    output logic use_rs2,
    output logic is_jump_or_branch, // 当前指令是否是分支或跳转
    output logic branch_taken, // 分支单元计算得到的分支是否成立信号，传递给pipeline control unit 再去看是不是真跳转

    // forwarding相关信号
    input logic [31:0] forward_data_from_MEM, // 来自MEM阶段的前递数据
    input logic [1:0] forward_A_sel_ID, // rs1的前递选择信号
    input logic [1:0] forward_B_sel_ID, // rs2的前递选择信号

    // 传递给EX阶段的信息
    output logic [4:0] rs1_addr,
    output logic [4:0] rs2_addr,
    output logic [4:0] rd_addr,
    output logic [31:0] rs1data_from_regfile, // 从寄存器堆读出的trs1数据(有WB穿透)
    output logic [31:0] rs2data_from_regfile, // 从寄存器堆读出的rs2数据
    output logic [31:0] imm,
    output logic [`ALU_OP_WIDTH-1:0] alu_opcode,
    output logic [`ALUA_SEL_WIDTH-1:0] alua_sel,
    output logic [`ALUB_SEL_WIDTH-1:0] alub_sel,
    output logic [`RF_WSEL_WIDTH-1:0] reg_w_sel,
    output logic reg_write,
    output logic mem_read,
    output logic mem_write,
    output logic [2:0] func3 // 传递给 MEM 阶段的 funct3 字段 (由控制单元生成,通常是 ALU 操作码的最低三位)

);

    logic [31:0] forwarded_rs1data; // 前递单元处理后的rs1数据，传递给分支单元进行比较
    logic [31:0] forwarded_rs2data; // 前递单元处理后的rs2数据，传递给分支单元进行比较
  
    logic [`Sext_OP_WIDTH-1:0] gen_imm_op;
    logic [`ALU_SEL_WIDTH-1:0] alu_sel;

    assign rs1_addr = instruction[19:15];
    assign rs2_addr = instruction[24:20];
    assign rd_addr = instruction[11:7];
    assign func3 = instruction[14:12]; // 从指令中解析出 funct3 字段，传递给 MEM 阶段

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
        .is_jump_or_branch(is_jump_or_branch)
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

    // 分支单元 (计算是否分支和目标地址)
    branch_unit branch_unit(
        .inst(instruction),
        .pc(pc),
        .rs1data(forwarded_rs1data), // 连接分支前递单元的输出，确保分支单元使用前递后的数据进行比较
        .rs2data(forwarded_rs2data),//这两个应该接上前递单元的多选的结果
        .imm(imm),
        .branch_taken(branch_taken),
        .branch_target(branch_target)
    );


    // 前递多选器 (选择最终传递给分支单元的rs1和rs2数据)
    Forwarding_ID fwd_ID(
        .forward_A_sel_ID(forward_A_sel_ID),
        .forward_B_sel_ID(forward_B_sel_ID),

        .original_rs1data(rs1data_from_regfile),
        .original_rs2data(rs2data_from_regfile),
        .forward_data_from_WB(rd_data_WB),          //其实就是写回的数据
        .forward_data_from_MEM(forward_data_from_MEM),

        .forwarded_rs1data(forwarded_rs1data),
        .forwarded_rs2data(forwarded_rs2data)
    );

endmodule
