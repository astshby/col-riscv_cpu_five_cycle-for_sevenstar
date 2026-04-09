`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2026 03:22:00 PM
// Design Name: 
// Module Name: inst_ROM_ip
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

module inst_ROM_ip (
    input  wire [12:0] a,    // 13位地址线 (对应 pc[14:2]，容量 8192 * 4B = 32KB)
    output wire [31:0] spo   // 32位指令输出
);

    // 声明二维存储器数组 (纯净定义，不包含任何 initial 块)
    // 综合工具会自动将这种纯粹的只读数组推断为 ROM
    reg [31:0] rom_mem [0:8191];

    // ==========================================
    // 异步读取逻辑 (纯组合逻辑)
    // ==========================================
    // 地址一旦给到，指令立刻输出，无时钟延迟
    assign spo = rom_mem[a];

endmodule