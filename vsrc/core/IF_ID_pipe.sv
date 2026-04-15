`timescale 1ns / 1ps

`include "define.vh"

module IF_ID_pipe (
    //控制信号
    input logic clk,
    input logic rst,
    input logic insert_bubble_to_ID, // 来自分支单元的信号,下一周期在ID阶段为气泡
    input logic hold_ID, // 保持ID阶段不变,保持住load-use冒险的后面的use,让use停住一周期

    //数据通路
    input logic [31:0] in_instruction, // 来自IF阶段的指令
    input logic [31:0] in_pc, // 来自IF阶段的PC值
    output logic [31:0] out_instruction, // 传递给ID阶段的指令
    output logic [31:0] out_pc // 传递给ID阶段
);

    logic reset_reg;
    assign reset_reg = rst | insert_bubble_to_ID;//冲刷掉或rst都是重置寄存器

    always_ff @(posedge clk) begin
        if (reset_reg) begin
            out_instruction <= 32'h0000_0000; // 气泡指令,在ID阶段被解析为nop
            out_pc <= 32'h0000_0000; // PC值也重置为0,虽然这个值在ID阶段不太重要,但保持一致性
        end
        else if (hold_ID) begin
            out_instruction <= out_instruction; // 保持当前指令不变
            out_pc <= out_pc; // 保持当前PC值不变,让ID阶段保持不变
        end
        else begin
            out_instruction <= in_instruction; // 正常传递IF阶段的指令到ID阶段
            out_pc <= in_pc; // 正常传递IF阶段的PC值到ID阶段
        end
    end


endmodule