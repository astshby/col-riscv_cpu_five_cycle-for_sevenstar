`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 07:29:29 PM
// Design Name: 
// Module Name: alu_op
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


module alu_op(
    input logic opcode_6,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    input logic [`ALU_SEL_WIDTH-1:0] alu_sel,
    output logic [`ALU_OP_WIDTH-1:0] alu_opcode
    );

    // I指令没有sub
    // 保持others，传入opcode

    always_comb begin
        case (alu_sel)

            `ALU_SEL_ADD: alu_opcode = `ALU_ADD;

            `ALU_SEL_OTHERS: begin

                case (funct3)
                   `FUNCT3_ADD_SUB: begin
                        if(opcode_6) begin
                             if(funct7[5]) alu_opcode = `ALU_SUB;
                             else alu_opcode = `ALU_ADD;
                        end
                        else alu_opcode = `ALU_ADD;
                    end
                    `FUNCT3_AND: alu_opcode = `ALU_AND;
                    `FUNCT3_OR: alu_opcode = `ALU_OR;
                    `FUNCT3_XOR: alu_opcode = `ALU_XOR;
                    `FUNCT3_SLL: alu_opcode = `ALU_SLL;
                    `FUNCT3_SRL_SRA: begin
                        if(funct7[5]) alu_opcode = `ALU_SRA;
                        else alu_opcode = `ALU_SRL;
                        end
                    `FUNCT3_SLT: alu_opcode = `ALU_SLT;
                    `FUNCT3_SLTU: alu_opcode = `ALU_SLTU;
                    default: alu_opcode = `ALU_NOP;
                endcase

            end

            `ALU_SEL_NO: alu_opcode = `ALU_NOP;

            default: alu_opcode = `ALU_NOP;

        endcase
    end
endmodule
