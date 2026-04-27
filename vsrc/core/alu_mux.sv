`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 07:18:35 PM
// Design Name: 
// Module Name: alu_mux
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


module alu_mux(
    input logic [`REG_WIDTH-1:0] rd1,
    input logic [`REG_WIDTH-1:0] rd2,
    input logic [`REG_WIDTH-1:0] pc,
    input logic [`REG_WIDTH-1:0] gen_imm,
    input logic [`ALUA_SEL_WIDTH-1:0] alua_sel,
    input logic [`ALUB_SEL_WIDTH-1:0] alub_sel,
    output logic [`REG_WIDTH-1:0] A,
    output logic [`REG_WIDTH-1:0] B
    );
    
        always_comb begin : alua_sel_block
            case (alua_sel) 
                `ALUA_SEL_RD1: A = rd1;
                `ALUA_SEL_PC: A = pc;
                `ALUA_SEL_ZERO: A = 32'h0;  // 添加这一行
                default: A = 32'h0;
            endcase
        end : alua_sel_block

        always_comb begin : alub_sel_block     
            case (alub_sel) 
                `ALUB_SEL_RD2: B = rd2;
                `ALUB_SEL_SEXT: B = gen_imm;
                `ALUB_SEL_ZERO: B = 32'h0;  // 添加这一行
                default: B = 32'h0;
            endcase
        end : alub_sel_block

endmodule
