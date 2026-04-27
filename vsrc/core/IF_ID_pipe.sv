`timescale 1ns / 1ps

`include "define.vh"

module IF_ID_pipe (
    //控制信号
    input logic clk,
    input logic rst,
    input logic insert_bubble_to_ID, // 来自分支单元的信号,下一周期在ID阶段为气泡
    input logic hold_ID, // 保持ID阶段不变,保持住load-use冒险的后面的use,让use停住一周期

    //数据通路
    input logic [`REG_WIDTH-1:0] in_instruction, // 来自IF阶段的指令
    input logic [`REG_WIDTH-1:0] in_pc, // 来自IF阶段的PC值
    output logic [`REG_WIDTH-1:0] out_instruction, // 传递给ID阶段的指令
    output logic [`REG_WIDTH-1:0] out_pc // 传递给ID阶段
);

    logic reset_reg;
    assign reset_reg = rst | insert_bubble_to_ID;//冲刷掉或rst都是重置寄存器

    // out_pc寄存器的更新逻辑
    always_ff @(posedge clk) begin
        if (reset_reg) begin
            out_pc <= 32'h0000_0000; // PC值也重置为0,虽然这个值在ID阶段不太重要,但保持一致性
        end
        else if (hold_ID) begin
            out_pc <= out_pc; // 保持当前PC值不变,让ID阶段保持不变
        end
        else begin
            out_pc <= in_pc; // 正常传递IF阶段的PC值到ID阶段
        end
    end

    // out_instruction更新，inst直接组合逻辑读出，当其读出时reset_reg以及随着下一条流走，
    // 所以需要reset_reg_next寄存器来保存reset_reg的值，使得传递的值与上个周期的reset_reg一致，是得对组合逻辑生效
    logic reset_reg_next;
    always_ff @(posedge clk) begin
        reset_reg_next <= reset_reg;
    end

    // 这里只有直接连线,不能生成寄存器 因为ins_mem是同步读的
    always_comb begin
        if (reset_reg_next) begin
            out_instruction = 32'h0000_0000; // 气泡指令,在ID阶段被解析为nop
        end
        else begin
            out_instruction = in_instruction; // 正常传递IF阶段的指令到ID阶段
        end
    end



endmodule