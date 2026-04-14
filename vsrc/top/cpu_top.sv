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

    core_top core_top(
        .clk(clk),
        .rst(rst)
    );

    ins_mem ins_mem(
        clka(clk),
        addra(next_pc[14:2]), // 地址线，word地址
        douta(persent_inst) // 指令输出
    );


    data_mem data_mem(
        .clka(clk),
        .dina(dram_sd_out), // 数据输入
        .douta(dram_ld_in), // 数据输出
        .addra(dram_addr_out[13:2]), // 地址线，word地址
        .wea(dram_we_byte), // 字节写使能
        .ena(dram_we || dram_re) // 使能，读或写都要使能
    );


endmodule


