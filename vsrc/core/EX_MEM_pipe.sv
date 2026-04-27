`timescale 1ns / 1ps

`include "define.vh"

module EX_MEM_pipe (
    input logic clk,
    input logic rst,

    input logic [`REG_WIDTH-1:0] in_PC,
    input logic [`REG_ADDR_WIDTH-1:0] in_rd_addr,
    input logic [`REG_ADDR_WIDTH-1:0] in_rs2_addr,
    input logic [`REG_WIDTH-1:0] in_rs2_data, // 来自 EX 阶段的 rs2 数据 (可能被前递单元修正过)
    input logic [`REG_WIDTH-1:0] in_alu_result, // 来自 EX 阶段的 ALU 结果
    input logic [`RF_WSEL_WIDTH-1:0] in_reg_w_sel,
    input logic in_reg_write,
    input logic in_mem_read,
    input logic in_mem_write,
    input logic [2:0] in_func3, 
    input logic [`REG_WIDTH-1:0] in_imm,

    // CSR 信号
    input logic in_csr_we,
    input logic [`CSR_ADDR_WIDTH-1:0] in_csr_addr,
    input logic [`REG_WIDTH-1:0] in_csr_data_old,
    input logic [`REG_WIDTH-1:0] in_csr_result_new,

    output logic [`REG_WIDTH-1:0] out_PC,
    output logic [`REG_ADDR_WIDTH-1:0] out_rd_addr,
    output logic [`REG_ADDR_WIDTH-1:0] out_rs2_addr,
    output logic [`REG_WIDTH-1:0] out_rs2_data, // 传递给 MEM 阶段的 rs2 数据 (用于 Store 指令)
    output logic [`REG_WIDTH-1:0] out_alu_result, // 传递给 MEM 阶段的 ALU 结果 mem的地址
    output logic [`RF_WSEL_WIDTH-1:0] out_reg_w_sel,
    output logic out_reg_write,
    output logic out_mem_read,
    output logic out_mem_write,
    output logic [2:0] out_func3,
    output logic [`REG_WIDTH-1:0] out_imm,

    // CSR 信号
    output logic out_csr_we,
    output logic [`CSR_ADDR_WIDTH-1:0] out_csr_addr,
    output logic [`REG_WIDTH-1:0] out_csr_data_old,
    output logic [`REG_WIDTH-1:0] out_csr_result_new
);

    always_ff @(posedge clk) begin
        if (rst) begin
            out_PC <= 32'h0000_0000;
            out_rd_addr <= 5'h0;
            out_rs2_addr <= 5'h0;
            out_rs2_data <= 32'h0000_0000;
            out_alu_result <= 32'h0000_0000;
            out_reg_w_sel <= 0;
            out_reg_write <= 0;
            out_mem_read <= 0;
            out_mem_write <= 0;
            out_func3 <= 3'h0;
            out_imm <= 32'h0000_0000;
            out_csr_we <= 0;
            out_csr_addr <= {`CSR_ADDR_WIDTH{1'b0}};
            out_csr_data_old <= {`REG_WIDTH{1'b0}};
            out_csr_result_new <= {`REG_WIDTH{1'b0}};
        end else begin
            out_PC <= in_PC;
            out_rd_addr <= in_rd_addr;
            out_rs2_addr <= in_rs2_addr;
            out_rs2_data <= in_rs2_data;
            out_alu_result <= in_alu_result;
            out_reg_w_sel <= in_reg_w_sel;
            out_reg_write <= in_reg_write;
            out_mem_read <= in_mem_read;
            out_mem_write <= in_mem_write;
            out_func3 <= in_func3;
            out_imm <= in_imm;
            out_csr_we <= in_csr_we;
            out_csr_addr <= in_csr_addr;
            out_csr_data_old <= in_csr_data_old;
            out_csr_result_new <= in_csr_result_new;
        end
    end
endmodule