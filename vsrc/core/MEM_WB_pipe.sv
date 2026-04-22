`timescale 1ns / 1ps

`include "define.vh"

module MEM_WB_pipe (
    input logic clk,
    input logic rst,

    input logic [31:0] in_PC,
    input logic [31:0] in_alu_result,
    input logic [31:0] in_imm,
    input logic in_reg_write,
    input logic [`RF_WSEL_WIDTH-1:0] in_reg_w_sel,
    input logic [4:0] in_rd_addr,
    input logic [2:0] in_func3, // Load 字节提取需要，传给 WB 阶段

    output logic [31:0] out_PC,
    output logic [31:0] out_alu_result,
    output logic [31:0] out_imm,
    output logic out_reg_write,
    output logic [`RF_WSEL_WIDTH-1:0] out_reg_w_sel,
    output logic [4:0] out_rd_addr,
    output logic [2:0] out_func3
);

    always_ff @(posedge clk) begin
        if (rst) begin
            out_PC <= 32'h0000_0000;
            out_alu_result <= 32'h0000_0000;
            out_imm <= 32'h0000_0000;
            out_reg_write <= 0;
            out_reg_w_sel <= 0;
            out_rd_addr <= 5'b00000;
            out_func3 <= 3'b000;
        end else begin
            out_PC <= in_PC;
            out_alu_result <= in_alu_result;
            out_imm <= in_imm;
            out_reg_write <= in_reg_write;
            out_reg_w_sel <= in_reg_w_sel;
            out_rd_addr <= in_rd_addr;
            out_func3 <= in_func3;
        end
    end

endmodule
