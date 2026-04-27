`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 07:28:32 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input wire [`ALU_OP_WIDTH-1:0] alu_opcode,
    input [`REG_WIDTH-1:0] A,
    input [`REG_WIDTH-1:0] B,
    output reg [`REG_WIDTH-1:0] result
    );

    always_comb begin : alu_calculate

        case (alu_opcode)//根据ALU_OPCODE的值进行不同的运算
            `ALU_ADD: result = A + B;
            `ALU_SUB: result = A + ~B + 1;
            `ALU_AND: result = A & B;
            `ALU_OR: result = A | B;
            `ALU_XOR: result = A ^ B;
            `ALU_SLL: result = A << B[4:0];
            `ALU_SRL: result = A >> B[4:0];
            `ALU_SRA: result = $signed(A) >>> B[4:0];
            `ALU_SLT: result = ($signed(A) < $signed(B)) ? 1 : 0;
            `ALU_SLTU: result = (A < B) ? 1 : 0;
            default: result = 0;
        endcase
        
    end : alu_calculate
endmodule
