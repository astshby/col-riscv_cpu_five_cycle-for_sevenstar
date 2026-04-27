`timescale 1ns / 1ps

`include "define.vh"

module ID_EX_pipe (
    input logic clk,
    input logic rst,
    input logic insert_bubble_to_EX, // 来自分支单元的信号,下一周期在EX阶段为气泡
    input logic hold_EX,

    input logic [`REG_WIDTH-1:0] in_PC,
    input logic [`REG_ADDR_WIDTH-1:0] in_rs1_addr,
    input logic [`REG_ADDR_WIDTH-1:0] in_rs2_addr,
    input logic [`REG_ADDR_WIDTH-1:0] in_rd_addr,
    input logic [`REG_WIDTH-1:0] in_rs1data,
    input logic [`REG_WIDTH-1:0] in_rs2data,
    input logic [`REG_WIDTH-1:0] in_imm,
    input logic [`ALU_OP_WIDTH-1:0] in_alu_opcode,
    input logic [`ALUA_SEL_WIDTH-1:0] in_alua_sel,
    input logic [`ALUB_SEL_WIDTH-1:0] in_alub_sel,
    input logic [`RF_WSEL_WIDTH-1:0] in_reg_w_sel,
    input logic in_reg_write,
    input logic in_mem_read,
    input logic in_mem_write,
    input logic [2:0] in_func3,

    // CSR 信号
    input logic in_csr_op,
    input logic [`CSR_ADDR_WIDTH-1:0] in_csr_addr,
    input logic [`REG_WIDTH-1:0] in_csr_data_old,

    // 性能计数器追踪
    input logic in_valid,
    input logic in_is_control_xfer,

    output logic [`REG_WIDTH-1:0] out_PC,
    output logic [`REG_ADDR_WIDTH-1:0] out_rs1_addr,
    output logic [`REG_ADDR_WIDTH-1:0] out_rs2_addr,
    output logic [`REG_ADDR_WIDTH-1:0] out_rd_addr,
    output logic [`REG_WIDTH-1:0] out_rs1data,
    output logic [`REG_WIDTH-1:0] out_rs2data,
    output logic [`REG_WIDTH-1:0] out_imm,
    output logic [`ALU_OP_WIDTH-1:0] out_alu_opcode,
    output logic [`ALUA_SEL_WIDTH-1:0] out_alua_sel,
    output logic [`ALUB_SEL_WIDTH-1:0] out_alub_sel,
    output logic [`RF_WSEL_WIDTH-1:0] out_reg_w_sel,
    output logic out_reg_write,
    output logic out_mem_read,
    output logic out_mem_write,
    output logic [2:0] out_func3,

    // CSR 信号
    output logic out_csr_op,
    output logic [`CSR_ADDR_WIDTH-1:0] out_csr_addr,
    output logic [`REG_WIDTH-1:0] out_csr_data_old,

    // 性能计数器追踪
    output logic out_valid,
    output logic out_is_control_xfer
);

    logic reset_reg;
    assign reset_reg = rst | insert_bubble_to_EX; // 冲刷掉或rst都是重置寄存器

    always_ff @(posedge clk) begin
        if (reset_reg) begin
            out_PC <= 32'h0000_0000; // 气泡指令,在EX阶段被解析为nop
            out_rs1_addr <= 5'h0;
            out_rs2_addr <= 5'h0;
            out_rd_addr <= 5'h0;
            out_rs1data <= 32'h0000_0000;
            out_rs2data <= 32'h0000_0000;
            out_imm <= 32'h0000_0000;
            out_alu_opcode <= `ALU_NOP; // nop指令的ALU操作码
            out_alua_sel <= `ALUA_SEL_RD1; // 虽然这个值在EX阶段不太重要,但保持一致性
            out_alub_sel <= `ALUB_SEL_RD2; // 虽然这个值在EX阶段不太重要,但保持一致性
            out_reg_w_sel <= `RF_WSEL_ALUC; // 虽然这个值在EX阶段不太重要,但保持一致性
            out_reg_write <= 0; // nop指令不写寄存器
            out_mem_read <= 0; // nop指令不读内存
            out_mem_write <= 0; // nop指令不写内存
            out_func3 <= 3'h0;
            out_csr_op <= 0;
            out_csr_addr <= {`CSR_ADDR_WIDTH{1'b0}};
            out_csr_data_old <= {`REG_WIDTH{1'b0}};
            out_valid <= 1'b0;
            out_is_control_xfer <= 1'b0;
        end
        else if (hold_EX) begin
            out_PC <= out_PC; // 保持当前PC值不变
            out_rs1_addr <= out_rs1_addr; // 保持当前rs1地址不变
            out_rs2_addr <= out_rs2_addr; // 保持当前rs2地址不变
            out_rd_addr <= out_rd_addr; // 保持当前rd地址不变
            out_rs1data <= out_rs1data; // 保持当前rs1数据不变
            out_rs2data <= out_rs2data; // 保持当前rs2数据不变
            out_imm <= out_imm; // 保持当前立即数不变
            out_alu_opcode <= out_alu_opcode; // 保持当前ALU操作码不变
            out_alua_sel <= out_alua_sel; // 保持当前ALUA选择信号不变
            out_alub_sel <= out_alub_sel; // 保持当前ALUB选择信号不变
            out_reg_w_sel <= out_reg_w_sel; // 保持当前寄存器写选择信号不变
            out_reg_write <= out_reg_write; // 保持当前寄存器写使能信号不变
            out_mem_read <= out_mem_read; // 保持当前内存读使能信号不变
            out_mem_write <= out_mem_write; // 保持当前内存写使能信号不变
            out_func3 <= out_func3;
            out_csr_op <= out_csr_op;
            out_csr_addr <= out_csr_addr;
            out_csr_data_old <= out_csr_data_old;
            out_valid <= out_valid;
            out_is_control_xfer <= out_is_control_xfer;
        end
        else begin
            out_PC <= in_PC; // 正常传递ID阶段的PC值到EX阶段
            out_rs1_addr <= in_rs1_addr; // 正常传递ID阶段的rs1地址到EX阶段
            out_rs2_addr <= in_rs2_addr; // 正常传递ID阶段的rs2地址到EX阶段
            out_rd_addr <= in_rd_addr; // 正常传递ID阶段的rd地址到EX阶段
            out_rs1data <= in_rs1data; // 正常传递ID阶段的rs1数据到EX阶段
            out_rs2data <= in_rs2data; // 正常传递ID阶段的rs2数据到EX阶段
            out_imm <= in_imm; // 正常传递ID阶段的立即数到EX阶段
            out_alu_opcode <= in_alu_opcode; // 正常传递ID阶段的ALU操作码到EX阶段
            out_alua_sel <= in_alua_sel; // 正常传递ID阶段的ALUA选择信号到EX阶段
            out_alub_sel <= in_alub_sel; // 正常传递ID阶段的ALUB选择信号到EX阶段
            out_reg_w_sel <= in_reg_w_sel; // 正常传递ID阶段的寄存器写选择信号到EX阶段
            out_reg_write <= in_reg_write; // 正常传递ID阶段的寄存器写使能信号到EX阶段
            out_mem_read <= in_mem_read; // 正常传递ID阶段的内存读使能信号到EX阶段
            out_mem_write <= in_mem_write; // 正常传递ID阶段的内存写使能信号到EX阶段
            out_func3 <= in_func3;
            out_csr_op <= in_csr_op;
            out_csr_addr <= in_csr_addr;
            out_csr_data_old <= in_csr_data_old;
            out_valid <= in_valid;
            out_is_control_xfer <= in_is_control_xfer;
        end
    end

endmodule