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
    input  logic [31:0] instruction,
    output logic [31:0] imm_out
    );

    // 提取 opcode 用于判断指令类型
    wire [6:0] opcode = instruction[6:0];

    always_comb begin
        case (opcode)
            // -----------------------------------------------------
            // I-Type: Load (0000011), ALU-I (0010011), JALR (1100111)
            // imm[11:0] = inst[31:20] -> 符号扩展到 32 位
            // -----------------------------------------------------
            7'b0000011, 7'b0010011, 7'b1100111: begin
                imm_out = { {20{instruction[31]}}, instruction[31:20] };
            end

            // -----------------------------------------------------
            // S-Type: Store (0100011)
            // imm[11:0] = inst[31:25], inst[11:7] -> 符号扩展到 32 位
            // -----------------------------------------------------
            7'b0100011: begin
                imm_out = { {20{instruction[31]}}, instruction[31:25], instruction[11:7] };
            end

            // -----------------------------------------------------
            // B-Type: Branch (1100011)
            // imm[12:1] = inst[31], inst[7], inst[30:25], inst[11:8]
            // 最低位补 0 -> 符号扩展到 32 位
            // -----------------------------------------------------
            7'b1100011: begin
                imm_out = { {20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0 };
            end

            // -----------------------------------------------------
            // U-Type: LUI (0110111), AUIPC (0010111)
            // imm[31:12] = inst[31:12]
            // 低 12 位补 0
            // -----------------------------------------------------
            7'b0110111, 7'b0010111: begin
                imm_out = { instruction[31:12], 12'b0 };
            end

            // -----------------------------------------------------
            // J-Type: JAL (1101111)
            // imm[20:1] = inst[31], inst[19:12], inst[20], inst[30:21]
            // 最低位补 0 -> 符号扩展到 32 位
            // -----------------------------------------------------
            7'b1101111: begin
                imm_out = { {12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0 };
            end

            // -----------------------------------------------------
            // 默认情况 (R-Type 等没有立即数的指令)
            // 输出 0 避免锁存器 (Latch)
            // -----------------------------------------------------
            default: begin
                imm_out = 32'b0;
            end
        endcase
    end

endmodule