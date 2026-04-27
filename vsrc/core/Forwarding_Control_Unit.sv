`timescale 1ns / 1ps

`include "define.vh"

module Forwarding_Control_Unit(
    // -----------------------------------------
    // 监听：需要数据的消费者 (Consumers)
    // -----------------------------------------
    // ID 阶段需要旁路 (为了提前判断分支)
    input logic [`REG_ADDR_WIDTH-1:0] rs1_addr_ID,
    input logic [`REG_ADDR_WIDTH-1:0] rs2_addr_ID,

    // EX 阶段需要旁路 (ALU 的正常运算)
    input logic [`REG_ADDR_WIDTH-1:0] rs1_addr_EX,
    input logic [`REG_ADDR_WIDTH-1:0] rs2_addr_EX,

    // MEM 阶段需要旁路 (Store 写入的 rs2 数据)
    input logic [`REG_ADDR_WIDTH-1:0] rs2_addr_MEM,

    // -----------------------------------------
    // 监听：产生最新数据的生产者 (Producers)
    // -----------------------------------------
    input logic [`REG_ADDR_WIDTH-1:0] rd_addr_MEM,     // MEM 阶段产生的将要写回的目标寄存器
    input logic       reg_write_MEM,   // MEM 阶段是否要写寄存器

    input logic [`REG_ADDR_WIDTH-1:0] rd_addr_WB,      // WB 阶段产生的将要写回的目标寄存器
    input logic       reg_write_WB,    // WB 阶段是否要写寄存器

    // -----------------------------------------
    // 输出：各级 MUX 的选择信号 (给对应的数据通路)
    // -----------------------------------------
    // 00: 原路径 (寄存器/流水寄存器), 01: 来自 WB 阶段 (次新), 10: 来自 MEM 阶段 (最新)
    output logic [1:0] forward_A_sel_ID,
    output logic [1:0] forward_B_sel_ID,
    
    output logic [1:0] forward_A_sel_EX,
    output logic [1:0] forward_B_sel_EX,
    
    // 0: 原路径, 1: 来自 WB 阶段的最新数据 (解决 Load 紧跟 Store 背靠背)
    output logic       forward_data_sel_MEM
);

    always_comb begin
        // EX 阶段 ALU 前递逻辑
        // EX MUX A (优先级：MEM > WB)
        if (reg_write_MEM && (rd_addr_MEM != 5'b0) && (rd_addr_MEM == rs1_addr_EX)) begin
            forward_A_sel_EX = `FWD_MEM;
        end else if (reg_write_WB && (rd_addr_WB != 5'b0) && (rd_addr_WB == rs1_addr_EX)) begin
            forward_A_sel_EX = `FWD_WB;
        end else begin
            forward_A_sel_EX = `FWD_ORIG;
        end

        // EX MUX B
        if (reg_write_MEM && (rd_addr_MEM != 5'b0) && (rd_addr_MEM == rs2_addr_EX)) begin
            forward_B_sel_EX = `FWD_MEM;
        end else if (reg_write_WB && (rd_addr_WB != 5'b0) && (rd_addr_WB == rs2_addr_EX)) begin
            forward_B_sel_EX = `FWD_WB;
        end else begin
            forward_B_sel_EX = `FWD_ORIG;
        end

        // ID 阶段 Branch/JALR 前递逻辑
        // ID MUX A
        if (reg_write_MEM && (rd_addr_MEM != 5'b0) && (rd_addr_MEM == rs1_addr_ID)) begin
            forward_A_sel_ID = `FWD_MEM;
        end else if (reg_write_WB && (rd_addr_WB != 5'b0) && (rd_addr_WB == rs1_addr_ID)) begin
            forward_A_sel_ID = `FWD_WB;
        end else begin
            forward_A_sel_ID = `FWD_ORIG;
        end

        // ID MUX B
        if (reg_write_MEM && (rd_addr_MEM != 5'b0) && (rd_addr_MEM == rs2_addr_ID)) begin
            forward_B_sel_ID = `FWD_MEM;
        end else if (reg_write_WB && (rd_addr_WB != 5'b0) && (rd_addr_WB == rs2_addr_ID)) begin
            forward_B_sel_ID = `FWD_WB;
        end else begin
            forward_B_sel_ID = `FWD_ORIG;
        end

        // MEM 阶段 Store 数据前递逻辑
        // 解决背靠背的 Load -> Store 冒险。只有 WB 阶段的数据可能前递给 MEM。
        if (reg_write_WB && (rd_addr_WB != 5'b0) && (rd_addr_WB == rs2_addr_MEM)) begin
            forward_data_sel_MEM = 1'b1;
        end else begin
            forward_data_sel_MEM = 1'b0;
        end
    end

endmodule