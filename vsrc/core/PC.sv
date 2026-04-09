`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2026 06:12:07 PM
// Design Name: 
// Module Name: PC
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

module PC(
    input logic clk,
    input logic rst,
    input logic [31:0] npc,
    output logic [31:0] pc
    );

    logic flag; //开机强行延迟一拍，相当与给rom反应时间，不要给我乱码了

    always_ff @( posedge clk or posedge rst) begin : pc_updata
        if(rst == `RstEnable) begin
            pc <= 32'h8000_0000;
            flag <= 1'b1;
        end
        else if(flag) begin
            pc <= 32'h8000_0000;
            flag <= 1'b0;
        end
        else pc <= npc;

    end : pc_updata

endmodule
