`timescale 1ns / 1ps

`include "define.vh"

module EX_stage (
    input logic [`REG_WIDTH-1:0] PC,
    input logic [`REG_WIDTH-1:0] rs1data,
    input logic [`REG_WIDTH-1:0] rs2data,
    input logic [`REG_WIDTH-1:0] imm,
    input logic [`ALU_OP_WIDTH-1:0] alu_opcode,
    input logic [`ALUA_SEL_WIDTH-1:0] alua_sel,
    input logic [`ALUB_SEL_WIDTH-1:0] alub_sel,

    // CSR 相关输入 (来自 ID_EX_pipe)
    input logic [`REG_ADDR_WIDTH-1:0] rs1_addr, // 用于 csrUnit rs1=x0 检测 和 zimm
    input logic [`REG_ADDR_WIDTH-1:0] rd_addr,  // 用于 csrUnit rd=x0 检测
    input logic [2:0]  funct3,                   // 用于 csrUnit 操作类型 和 zimm 选择
    input logic csr_op,                          // CSR 操作标志
    input logic [`REG_WIDTH-1:0] csr_data_old,  // CSR 旧值 (经 ID 阶段前递)

    // 旁路输入：来自外部 Forwarding control 的控制信号和数据
    input logic [1:0]  forward_A_sel_EX,      // 来自外部 Forwarding Unit
    input logic [1:0]  forward_B_sel_EX,      // 来自外部 Forwarding Unit
    input logic [`REG_WIDTH-1:0] forward_data_from_MEM, // 最新数据 (通常来自 EX/MEM 出来的 ALU 结果)
    input logic [`REG_WIDTH-1:0] forward_data_from_WB,  // 次新数据 (通常来自要写回 Regfile 的最终结果)

    // alu计算结果
    output logic [`REG_WIDTH-1:0] alu_result,
    
    // 对于 Store 指令，它要存入内存的 rs2 数据可能在 EX 阶段被旁路修正了
    // 所以必须把修正后的 rs2 数据继续往后传给 EX_MEM_pipe
    output logic [`REG_WIDTH-1:0] forwarded_rs2data_to_store, // 修正后的 rs2 数据，传递给 EX/MEM 寄存器 (用于 Store 指令)

    // CSR 输出 (传递给 EX_MEM_pipe)
    output logic csr_we,                          // CSR 写使能 (csrUnit 计算)
    output logic [`REG_WIDTH-1:0] csr_result_new  // CSR 新值 (csrUnit 计算)
);

    // 用于连接 MUX 和 ALU_MUX
    logic [`REG_WIDTH-1:0] forwarded_rs1data;
    logic [`REG_WIDTH-1:0] forwarded_rs2data;
    logic [`REG_WIDTH-1:0] A; // ALU输入A
    logic [`REG_WIDTH-1:0] B; // ALU输入B

    // 旁路选择器
    Forwarding_EX fwd_EX(
        .forward_A_sel_EX      (forward_A_sel_EX),
        .forward_B_sel_EX      (forward_B_sel_EX),
        .original_rs1data      (rs1data),               // 接入原始输入
        .original_rs2data      (rs2data),               // 接入原始输入
        .forward_data_from_WB  (forward_data_from_WB),
        .forward_data_from_MEM (forward_data_from_MEM),
        .forwarded_rs1data     (forwarded_rs1data),     // 吐出修正后的数据
        .forwarded_rs2data     (forwarded_rs2data)      // 吐出修正后的数据
    );

    // 将修正后的 rs2 数据接出，送往 EX_MEM_pipe
    assign forwarded_rs2data_to_store = forwarded_rs2data;

    // ALU_MUX
    alu_mux alu_mux(
        .rd1      (forwarded_rs1data), // 注意：这里喂的是 fwd_mux 的修正数据！
        .rd2      (forwarded_rs2data), // 注意：这里喂的是 fwd_mux 的修正数据！
        .pc       (PC),
        .gen_imm  (imm),
        .alua_sel (alua_sel),          
        .alub_sel (alub_sel),          
        .A        (A),
        .B        (B)
    );

    // 3. ALU 运算单元
    alu alu(
        .A          (A),
        .B          (B),
        .alu_opcode (alu_opcode),
        .result     (alu_result)
    );

    // CSR: zimm 多路选择器 + csrUnit
    // CSRRxI (funct3[2]=1) 用零扩展立即数 {27'b0, rs1_addr}
    // CSRRW/S/C (funct3[2]=0) 用前递后的 rs1 数据
    logic [`REG_WIDTH-1:0] csr_rs1_or_zimm;
    assign csr_rs1_or_zimm = funct3[2] ? {27'b0, rs1_addr} : forwarded_rs1data;

    csrUnit csrUnit_inst(
        .r1Addr    (rs1_addr),
        .rdAddr    (rd_addr),
        .csrOp     (csr_op),
        .funct3    (funct3),            // 完整 3 位，用 define.vh 宏解码
        .csr       (csr_data_old),      // 经 ID 阶段前递的 CSR 旧值
        .rs1Uimm   (csr_rs1_or_zimm),
        .csrResult (csr_result_new),
        .csrRead   (),                  // 暂不使用读使能
        .csrWrite  (csr_we)
    );

endmodule