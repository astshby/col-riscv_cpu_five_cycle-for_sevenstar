`timescale 1ns / 1ps

`include "define.vh"

module WB_stage(
    // -----------------------------------------
    // 输入：来自 MEM/WB 流水线寄存器
    // -----------------------------------------
    input  logic [31:0] PC,          // 当前指令的 PC
    input  logic [31:0] alu_result,  // ALU 计算结果
    input  logic [31:0] rd_ld,       // 从 Data Memory 读出的数据
    input  logic [31:0] imm,         // 立即数 (LUI 指令等需要)
    
    input  logic [`RF_WSEL_WIDTH-1:0] reg_w_sel, // 写回数据选择控制信号

    // -----------------------------------------
    // 输出：送往 ID 阶段 (写入寄存器堆) 和 Forwarding Unit
    // -----------------------------------------
    output logic [31:0] wb_data      // 最终决定写回寄存器的 32 位数据
);

    // 计算 PC + 4 (用于 JAL, JALR 指令的返回地址写回)
    logic [31:0] pc4;
    assign pc4 = PC + 32'd4;

    // 例化你写好的写回多路选择器
    regfile_wd_MUX regfile_wd_MUX_inst(
        .rf_wsel (reg_w_sel),
        .DRAM_wb (rd_ld),
        .alu_c   (alu_result),
        .pc4     (pc4),
        .sext    (imm),
        .wd      (wb_data)
    );

endmodule