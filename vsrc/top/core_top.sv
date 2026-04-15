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
    input logic rst,

    output logic [31:0] next_PC, // 传递给指令存储器(core以外)
    input logic [31:0] instruction_from_memory  
    );

    logic [31:0] PC_from_IF; 
    logic [31:0] instruction_to_ID; 
    logic [31:0] PC_to_ID; 
    //这样子命名看着连线清晰 form/to_某一个流水级

    IF_stage IF_stage(
        .clk(clk),
        .rst(rst),
        .stall(),
        .jump(),
        .jump_addr(),
        .present_PC(PC_from_IF),// 传递给IF/ID寄存器
        .next_PC(next_PC)  // 传递给指令存储器(core以外)
    );

    IF_ID_pipe IF_ID_pipe(
        .clk(clk),
        .rst(rst),
        .insert_bubble_to_ID(),
        .hold_ID(),
        .in_instruction(instruction_from_memory),
        .in_pc(PC_from_IF),
        .out_instruction(instruction_to_ID),
        .out_pc(PC_to_ID)
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