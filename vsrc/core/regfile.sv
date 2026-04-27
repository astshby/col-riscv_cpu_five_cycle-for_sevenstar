`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 11:23:39 AM
// Design Name: 
// Module Name: regfile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description:  带有内部数据穿透（Write-Through）的寄存器堆
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module regfile(
    input logic clk,
    input logic rst,
    input logic [`REG_ADDR_WIDTH-1:0] rs1addr,
    input logic [`REG_ADDR_WIDTH-1:0] rs2addr,
    input logic [`REG_ADDR_WIDTH-1:0] rdaddr,
    input logic [`REG_WIDTH-1:0] wdata,
    input logic wen,
    output logic [`REG_WIDTH-1:0] rs1data,
    output logic [`REG_WIDTH-1:0] rs2data
    );

    // 声明31个32位寄存器，地址从1到31（0号寄存器硬件恒为0）
    reg [`REG_WIDTH-1:0] regs [1:31];

    // 读端口 - 组合逻辑
    always_comb begin : rs_read
        if (rst == 1'b1) begin 
            rs1data = 32'b0;
            rs2data = 32'b0;
        end else begin
            // RS1 读出逻辑与穿透判断
            if (rs1addr == 5'b0) begin
                rs1data = 32'b0;
            end else if ((wen == 1'b1) && (rs1addr == rdaddr)) begin
                rs1data = wdata;  // 写穿透：直接读出正在写入的新数据
            end else begin
                rs1data = regs[rs1addr];
            end

            // RS2 读出逻辑与穿透判断
            if (rs2addr == 5'b0) begin
                rs2data = 32'b0;
            end else if ((wen == 1'b1) && (rs2addr == rdaddr)) begin
                rs2data = wdata;  // 写穿透：直接读出正在写入的新数据
            end else begin
                rs2data = regs[rs2addr];
            end
        end
    end : rs_read

    // 写端口 - 时序逻辑
    always_ff @(posedge clk) begin : reg_write
        if (rst == 1'b1) begin 
            integer i;
            for(i = 1; i < `RegNum; i = i + 1) begin
                regs[i] <= 32'b0;
            end
        end
        else if (wen == 1'b1 && rdaddr != 5'b0) begin
            regs[rdaddr] <= wdata;
        end
    end : reg_write

endmodule