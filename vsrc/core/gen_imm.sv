`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2026 11:56:43 PM
// Design Name: 
// Module Name: imm_gen
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


module gen_imm(
    input logic [24:0] inst,
    input logic [`Sext_OP_WIDTH-1:0] gen_imm_op,
    output logic [31:0] imm
    );

    always_comb begin : gen_imm_block
        case(gen_imm_op)
            `Sext_I: imm = {{20{inst[24]}}, inst[24:13]};
            `Sext_S: imm = {{20{inst[24]}}, inst[24:18], inst[4:0]};
            `Sext_B: imm = {{20{inst[24]}}, inst[0], inst[23:18], inst[4:1], 1'b0};
            `Sext_U: imm = {inst[24:5], 12'b0};
            `Sext_J: imm = {{12{inst[24]}}, inst[12:5], inst[13], inst[23:14], 1'b0};
            default : imm = 32'b0;
        endcase
    end : gen_imm_block
    
endmodule
