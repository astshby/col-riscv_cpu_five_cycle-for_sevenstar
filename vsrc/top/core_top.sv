`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2026 08:39:06 PM
// Design Name: 
// Module Name: core_top
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


module core_top(
    input logic clk,
    input logic rst
    );

    IF_stage IF_stage(
        
    );

    IF_ID_pipe IF_ID_pipe(
        .clk(clk),
        .rst(rst)
    );

    ID_stage ID_stage(
    );

    ID_EX_pipe ID_EX_pipe(
        .clk(clk),
        .rst(rst)
    );

    EX_stage EX_stage(
    );

    EX_MEM_pipe EX_MEM_pipe(
        .clk(clk),
        .rst(rst)
    );

    MEM_stage MEM_stage(
    );

    MEM_WB_pipe MEM_WB_pipe(
        .clk(clk),
        .rst(rst)
    );

    WB_stage WB_stage(
    );


endmodule