`timescale 1ns / 1ps

`include "define.vh"

module EX_stage (
    input logic [31:0] PC,
    input logic [31:0] rs1data,
    input logic [31:0] rs2data,
    input logic [31:0] imm,
    input logic [`ALU_OP_WIDTH-1:0] alu_opcode,
    input logic [`ALUA_SEL_WIDTH-1:0] alua_sel,
    input logic [`ALUB_SEL_WIDTH-1:0] alub_sel,

    // 旁路输入：来自外部 Forwarding control 的控制信号和数据
    input logic [1:0]  forward_A_sel_EX,      // 来自外部 Forwarding Unit
    input logic [1:0]  forward_B_sel_EX,      // 来自外部 Forwarding Unit
    input logic [31:0] forward_data_from_MEM, // 最新数据 (通常来自 EX/MEM 出来的 ALU 结果)
    input logic [31:0] forward_data_from_WB,  // 次新数据 (通常来自要写回 Regfile 的最终结果)

    // alu计算结果
    output logic [31:0] alu_result,
    
    // 对于 Store 指令，它要存入内存的 rs2 数据可能在 EX 阶段被旁路修正了
    // 所以必须把修正后的 rs2 数据继续往后传给 EX_MEM_pipe
    output logic [31:0] forwarded_rs2data_to_store // 修正后的 rs2 数据，传递给 EX/MEM 寄存器 (用于 Store 指令) 
);

    // ==========================================
    // 内部线网：用于连接 MUX 和 ALU_MUX
    // ==========================================
    logic [31:0] forwarded_rs1data;
    logic [31:0] forwarded_rs2data;
    logic [31:0] A; // ALU输入A
    logic [31:0] B; // ALU输入B

    // ==========================================
    // 1. 旁路选择器
    // ==========================================
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

    // ==========================================
    // 2. ALU_MUX
    // ==========================================
    alu_mux alu_mux(
        .rd1      (forwarded_rs1data), // 注意：这里喂的是 fwd_mux 吐出来的修正数据！
        .rd2      (forwarded_rs2data), // 注意：这里喂的是 fwd_mux 吐出来的修正数据！
        .pc       (PC),
        .gen_imm  (imm),
        .alua_sel (alua_sel),          
        .alub_sel (alub_sel),          
        .A        (A),
        .B        (B)
    );

    // ==========================================
    // 3. ALU 运算单元
    // ==========================================
    alu alu(
        .A          (A),
        .B          (B),
        .alu_opcode (alu_opcode),
        .result     (alu_result)
    );

endmodule