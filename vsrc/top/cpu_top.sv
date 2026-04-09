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

    input logic clk,
    input logic rst
    );

    localparam ROM_BASE = 32'h8000_0000;
    localparam RAM_BASE = 32'h8000_1000; // 确保link.ld 中 .data 段是从这里开始的(tohost)

    logic [31:0] inst; // 指令输入
    logic [31:0] pc;   // PC输出
    logic [31:0] dram_ld_in; // 从DRAM读出的数据输入
    logic [31:0] dram_sd_out; // 要写入DRAM的数据输出
    logic [3:0] dram_we_out; // DRAM的字节写使能输出
    logic [31:0] dram_addr_out; // DRAM地址输出
    logic dram_we; // DRAM写使能输出
    logic dram_re; // DRAM读使能输出

    // 内核
    core_top core_top_inst(
        .clk(clk),
        .rst(rst),

        // 连接指令输入和PC输出 ROM
        .inst(inst), // 连接指令输入
        .pc(pc),   // 连接PC输出

        //连接数据输入输出 RAM
        .dram_ld_in(dram_ld_in), // 连接从DRAM读出的数据输入
        .dram_sd_out(dram_sd_out), // 连接要写入DRAM的数据输出
        .dram_we_out(dram_we_out), // 连接DRAM的字节写使能输出
        .dram_addr_out(dram_addr_out), // 连接DRAM地址输出
        .dram_we(dram_we), // 连接DRAM写使能输出
        .dram_re(dram_re) // 连接DRAM读使能输出
    );


    logic [31:0] rom_addr;
    logic [31:0] ram_addr;   
    assign rom_addr = pc - ROM_BASE; // 计算ROM地址
    assign ram_addr = dram_addr_out - RAM_BASE; // 计算RAM地址

    // 指令存储器（ROM）ip核实例
    // 应该是异步的 不应该用时钟信号
    inst_ROM_ip inst_rom_inst(
        .a(rom_addr[14:2]),  // 连接PC输出的高12位作为地址输入
        .spo(inst)  // 连接指令输出
    );

    // 数据存储器（RAM）ip核实例
    RAM_ip ram_inst(
        .addra(ram_addr[14:2]), // 连接RAM地址的高12位作为地址输入
        .clka(clk), // 连接时钟信号
        .dina(dram_sd_out), // 连接要写入DRAM的数据输入
        .wea(dram_we_out), // 连接DRAM的字节写使能输入
        .douta(dram_ld_in), // 连接从DRAM读出的数据输出
        .ena(dram_we), // 连接DRAM写使能输入
        .enr(dram_re) // 连接DRAM读使能输入
    );


endmodule


