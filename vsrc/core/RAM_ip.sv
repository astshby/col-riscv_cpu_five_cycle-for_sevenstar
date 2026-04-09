`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2026 05:25:58 PM
// Design Name: 
// Module Name: RAM_ip
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


module RAM_ip (
    input  wire        clka,    // 时钟信号
    input  wire        ena,     // 模块写使能信号 (Enable)
    input  wire        enr,     // 模块读使能信号 (Read Enable)
    input  wire [3:0]  wea,     // 4位字节写使能 (Write Enable)
    input  wire [11:0] addra,   // 12位地址线 (Address)
    input  wire [31:0] dina,    // 32位数据输入 (Data In)
    output wire [31:0] douta    // 32位数据输出 (Data Out)
);

    // 声明一个深度为 4096，宽度为 32 位的存储器数组 (4096 * 4字节 = 16KB)
    reg [31:0] ram_mem [0:4095];

    // ==========================================
    // 1. 同步写入逻辑 (带字节使能)
    // ==========================================
    always @(posedge clka) begin
        // 只有在 ena (总使能) 为高时，才允许写入
        if (ena) begin
            if (wea[0]) ram_mem[addra][7:0]   <= dina[7:0];
            if (wea[1]) ram_mem[addra][15:8]  <= dina[15:8];
            if (wea[2]) ram_mem[addra][23:16] <= dina[23:16];
            if (wea[3]) ram_mem[addra][31:24] <= dina[31:24];
        end
    end

    // ==========================================
    // 2. 异步读取逻辑 (组合逻辑，单周期 CPU 必须用这个)
    // ==========================================
    // 地址一旦变化，数据立刻输出；如果 enr 为 0，输出全 0 (模拟未使能状态)
    assign douta = enr ? ram_mem[addra] : 32'h00000000;

endmodule
