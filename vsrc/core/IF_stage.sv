`timescale 1ns / 1ps

`include "define.vh"

module IF_stage (
    input  logic        clk,
    input  logic        rst,
    input  logic        hold,       // 来自分支单元的stall信号,发生停顿
    input  logic        jump,       // 来自ID阶段分支单元的jump信号，表示需要跳转
    input  logic [31:0] jump_addr,  // 来自ID阶段分支单元的jump地址
    output logic [31:0] present_PC // 当前PC值，传递给IF/ID寄存器
);

    logic [31:0] PC_4, next_PC;
    assign PC_4 = present_PC + 32'h4;

    // =========================================================================
    // 核心新增：启动标志位 (First Cycle Flag)
    // 作用：在 rst 释放后的第一个时钟周期内保持为 1，强行将 next_PC 锁在 0 地址
    // =========================================================================
    logic first_cycle_flag;

    always_ff @(posedge clk) begin
        if (rst) begin
            first_cycle_flag <= 1'b1; // 复位时，标志位拉高
        end else begin
            first_cycle_flag <= 1'b0; // 复位释放后的下一个时钟沿，标志位清零
        end
    end

    // =========================================================================
    // PC 寄存器更新
    // =========================================================================
    always_ff @(posedge clk) begin
        if (rst) begin
            present_PC <= 32'h0000_0000; 
        end
        else if (hold) begin
            present_PC <= present_PC; 
        end
        else begin
            present_PC <= next_PC;
        end
    end

    // =========================================================================
    // next_PC 组合逻辑计算
    // =========================================================================
    always_comb begin
        // 注意这里：只要是 rst 期间，或者刚解除 rst 的第一个周期，强制发 0 地址
        if (rst || first_cycle_flag) begin
            next_PC = 32'h0000_0000;
        end
        else if (jump) begin
            next_PC = jump_addr; 
        end
        else begin
            next_PC = PC_4;
        end
    end

endmodule