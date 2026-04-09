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


    always_comb begin : alu_others
        case (alu_sel)
            `ALU_SEL_ADD: alu_opcode = `ALU_ADD;
            `ALU_SEL_SUB:begin
                case(funct3)
                    `FUNCT3_BEQ: alu_opcode = `ALU_BEQ;
                    `FUNCT3_BNE: alu_opcode = `ALU_BNE;
                    `FUNCT3_BLT: alu_opcode = `ALU_BLT;
                    `FUNCT3_BLTU: alu_opcode = `ALU_BLTU;
                    `FUNCT3_BGE: alu_opcode = `ALU_BGE;
                    `FUNCT3_BGEU: alu_opcode = `ALU_BGEU;
                    default:alu_opcode = 0;
                endcase
            end 
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
                    default: alu_opcode = 0;
                endcase 
            end
            default: alu_opcode = 0;
        endcase
    end : alu_others
endmodule
