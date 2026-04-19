`timescale 1ns / 1ps

`include "define.vh"

module MEM_WB_pipe (
    input logic clk,
    input logic rst,


    input logic [31:0] in_PC, // 来自 MEM 阶段的 PC (jal jalr 指令可能需要写回 PC+4)
    input logic [31:0] in_alu_result, // 写回的计算结果
    input logic [31:0] in_rd_ld, // 写回的 Load 数据 (这时序上特殊 不用寄存一级)
    input logic [31:0] in_imm, // 来自 MEM 阶段的立即数
    input logic in_reg_write, // MEM 阶段是否要写寄存器
    input logic [`RF_WSEL_WIDTH-1:0] in_reg_w_sel, // MEM 阶段寄存器写回选择信号
    input logic [4:0] in_rd_addr, // MEM 阶段的目的寄存器地址 (写回时需要)

    output logic [31:0] out_PC,
    output logic [31:0] out_alu_result,
    output logic [31:0] out_rd_ld,
    output logic [31:0] out_imm,
    output logic out_reg_write,
    output logic [`RF_WSEL_WIDTH-1:0] out_reg_w_sel,
    output logic [4:0] out_rd_addr


);

    always_ff @(posedge clk) begin
        if (rst) begin
            out_PC <= 32'h0000_0000;
            out_alu_result <= 32'h0000_0000;
            out_imm <= 32'h0000_0000;
            out_reg_write <= 0;
            out_reg_w_sel <= 0;
            out_rd_addr <= 5'b00000;
        end else begin
            out_PC <= in_PC;
            out_alu_result <= in_alu_result;
            out_imm <= in_imm;
            out_reg_write <= in_reg_write;
            out_reg_w_sel <= in_reg_w_sel;
            out_rd_addr <= in_rd_addr;
        end
    end

    assign out_rd_ld = in_rd_ld; // Load 数据直接传递，不需要寄存一级

endmodule