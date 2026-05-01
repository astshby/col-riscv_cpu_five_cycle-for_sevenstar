`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 11:32:58 AM
// Design Name: 
// Module Name: cpu_top_for_rt
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


module cpu_top(
    input logic clk,       // 连接 XDC 里的 clk 引脚 (100MHz)
    input logic rst,       // 连接 XDC 里的 rst 引脚 (低电平有效，CPU_RESETN)
    output logic [15:0] LED // 输出到板子上的 16 个 LED 观察 PC 运行
);

    logic [31:0] PC;
    assign LED = PC[17:2]; // 我们观察 PC 的第 17 到 2 位（跳过低两位对齐位）

    logic [31:0] instruction_from_memory;
    logic [31:0] data_store; // MEM阶段要写入数据存储器的数据
    logic [31:0] data_load;  // 从数据存储器读出的数据
    logic [31:0] data_addr;  // MEM阶段访问数据存储器的地址
    logic [3:0] data_we_byte; // MEM阶段访问数据存储器的字节写使能
    logic mem_ena; // MEM阶段访问数据存储器的使能信号
    logic ena_ins_mem; // 连接指令存储器的使能信号

    // 锁相环 (PLL) 及时钟复位管理
    logic cpu_clk_50M;     // PLL 输出的时钟
    logic pll_locked;      // PLL 锁定信号
    logic rst_high;        // 适配 IP 的高电平复位
    // CPU内部复位逻辑：PLL没锁定或者按下了复位键（rst=0），则保持复位状态(core_top等的高电平复位)
    logic sys_rst_high;
    assign rst_high = ~rst;
    assign sys_rst_high = ~pll_locked | rst_high;


    // 核心实例化
    core_top core_top(
        .clk(cpu_clk_50M),     // 使用降频后的时钟
        .rst(sys_rst_high),    // 使用内部稳态高电平复位

        .PC(PC),
        .instruction_from_memory(instruction_from_memory),
        .ena_ins_mem(ena_ins_mem),

        .data_store(data_store),
        .data_load(data_load),
        .data_addr(data_addr),
        .data_we_byte(data_we_byte),
        .mem_ena(mem_ena)
    );

    ins_mem ins_mem(
        .clka(cpu_clk_50M),    // 内存也需要用这个时钟
        .addra(PC[15:2]), // 地址线，word地址
        .douta(instruction_from_memory), // 指令输出
        .ena(ena_ins_mem)
    );

    data_mem data_mem(
        .clka(cpu_clk_50M),    // 内存也需要用这个时钟
        .dina(data_store), // 数据输入
        .douta(data_load), // 数据输出
        .addra(data_addr[15:2]), // 地址线，word地址
        .wea(data_we_byte), // 字节写使能
        .ena(mem_ena) // 使能，读或写都要使能
    );

    // 锁相环例化的标准模板
    clk_wiz_0 pll_inst (
        // inputs
        .clk_in1 (clk),          // 连到 XDC 里的 100MHz 物理时钟
        .reset   (rst_high),     // 连到高电平复位信号
        // outputs
        .clk_out1(cpu_clk_50M),  // 这是产生的新时钟
        .locked  (pll_locked)    // 状态信号
    );

endmodule


