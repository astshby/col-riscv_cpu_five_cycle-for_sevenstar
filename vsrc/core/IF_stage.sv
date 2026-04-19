`timescale 1ns / 1ps

`include "define.vh"

module IF_stage (
    input logic clk,
    input logic rst,
    input logic hold,  // 来自分支单元的stall信号,发生停顿
    input logic jump,   // 来自ID阶段分支单元的jump信号，表示需要跳转
    input logic [31:0] jump_addr, // 来自ID阶段分支单元的jump地址
    output logic [31:0] present_PC, // 当前PC值，传递给IF/ID寄存器
    output logic [31:0] next_PC // 计算得到的下一个PC值，传递给指令存储器
);
    logic [31:0] PC_4; // 当前PC加4的值，指向下一条指令的地址
    assign PC_4 = present_PC + 32'h4; // 当前PC加4，指向下一条指令的地址

    always_ff @(posedge clk) begin//rst时候 会重置为npc设置的0地址
        if (rst) begin
            present_PC <= next_PC; 
            // 在 rst 时, 将 present_PC 重置为 next_PC
            // next_PC 设置为起始地址
        end
        else if (hold) begin
            present_PC <= present_PC; // 保持当前PC不变
        end
        else begin
            present_PC <= next_PC;
        end
    end

    always_comb begin
        if (rst) begin
            next_PC = 32'h0000_0000;
            //在rst时,在下一个上升沿PC被重置为0
            //同时指令存储器也会取出0地址的指令,保证程序从0地址开始执行
        end
        else if (jump) begin
            next_PC = jump_addr; 
            // 在需要跳转时,下一个上升沿将PC更新为jump_addr,实现跳转
        end
        else begin
            next_PC = PC_4;
            // 正常情况下,PC每次增加4,指向下一条指令
        end
    end





endmodule