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
// Description: 
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
    input logic [`RegAddrBus] rs1addr,
    input logic [`RegAddrBus] rs2addr,
    input logic [`RegAddrBus] rdaddr,
    input logic [`RegBus] wdata,
    input logic wen,
    output logic [`RegBus] rs1data,
    output logic [`RegBus] rs2data
    );

    reg [`RegBus] regs [1:`RegNum-1];

    always_comb begin : rs_read
        if(rst == 1'b1) begin 
            rs1data = 0;
            rs2data = 0;
            // rst时读出0
        end
        else begin
            rs1data = (rs1addr != 0) ? regs[rs1addr] : 0;
            rs2data = (rs2addr != 0) ? regs[rs2addr] : 0;
            // x0寄存器永远为0，所以读出时如果地址为0则直接输出0，不需要访问regs数组
        end
        
    end : rs_read

    always_ff @(posedge clk) begin : reg_write
        if(rst == 1'b1) begin 
            integer i;
            for(i = 1; i < `RegNum; i = i + 1) begin
                regs[i] <= 0;
            end
            //rst时写入0
        end
        else if(wen == 1'b1 && rdaddr != 0) begin
            regs[rdaddr] <= wdata;
            //写寄存器时，如果wen有效且地址不为0，则写入数据
        end
    end : reg_write


endmodule
