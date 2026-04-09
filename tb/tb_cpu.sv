`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2026 07:29:37 PM
// Design Name: 
// Module Name: tb_cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_cpu();

    // 时钟和复位信号
    logic clk;
    logic rst;

    // 实例化CPU顶层模块
    cpu_top cpu_top_inst(
        .clk(clk),
        .rst(rst)
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz时钟
    end

    // 复位信号生成
    initial begin
        rst = 1; // 初始复位
        #20 rst = 0; // 20ns后释放复位

        #20000; // 运行一段时间后结束仿真
        $finish;
    end
endmodule
