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
    input logic rst,
    output logic [31:0] PC

);

    logic [31:0] next_PC_to_ins_mem;
    logic [31:0] instruction_from_memory;
    logic [31:0] data_store; // MEM阶段要写入数据存储器的数据
    logic [31:0] data_load;  // 从数据存储器读出的数据
    logic [31:0] data_addr;  // MEM阶段访问数据存储器的地址
    logic [3:0] data_we_byte; // MEM阶段访问数据存储器的字节写使能
    logic mem_ena; // MEM阶段访问数据存储器的使能信号
    logic ena_ins_mem; // 连接指令存储器的使能信号

    core_top core_top(
        .clk(clk),
        .rst(rst),

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
        .clka(clk),
        .addra(PC[13:2]), // 地址线，word地址
        .douta(instruction_from_memory), // 指令输出
        .ena(ena_ins_mem)
    );


    data_mem data_mem(
        .clka(clk),
        .dina(data_store), // 数据输入
        .douta(data_load), // 数据输出
        .addra(data_addr[13:2]), // 地址线，word地址
        .wea(data_we_byte), // 字节写使能
        .ena(mem_ena) // 使能，读或写都要使能
    );


endmodule


