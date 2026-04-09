`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 05:49:00 PM
// Design Name: 
// Module Name: control
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


module control(
    input logic [6:0] opcode,
    output logic [`Sext_OP_WIDTH-1:0] gen_imm_op,
    output logic [`NPC_SEL_WIDTH-1:0] npc_op,
    output logic [`ALU_SEL_WIDTH-1:0] alu_sel,
    output logic [`ALUA_SEL_WIDTH-1:0] alua_sel,
    output logic [`ALUB_SEL_WIDTH-1:0] alub_sel,
    output logic [`RF_WSEL_WIDTH-1:0] reg_w_sel,
    output logic reg_we,
    output logic dram_re,
    output logic dram_we
    );
    always_comb begin : main_con
        
        // 统一信号初始化,注意必须在一个always_comb里面
        gen_imm_op = `Sext_R;
        npc_op = `NPC_SEL_NEXT;
        alu_sel = `ALU_SEL_ADD; 
        alua_sel = `ALUA_SEL_RD1;
        alub_sel = `ALUB_SEL_RD2;
        reg_w_sel = `RF_WSEL_ALUC;
        reg_we = 0;
        dram_re = 0;
        dram_we = 0;
        
        case(opcode)
            
            `OPCODE_R: begin
                gen_imm_op = `Sext_R;
                npc_op = `NPC_SEL_NEXT;
                alu_sel = `ALU_SEL_OTHERS;
                alua_sel = `ALUA_SEL_RD1;
                alub_sel = `ALUB_SEL_RD2;
                reg_w_sel = `RF_WSEL_ALUC;
                reg_we = 1;
                dram_re = 0;
                dram_we = 0;
            end
            
            `OPCODE_I_REG: begin
                gen_imm_op = `Sext_I;
                npc_op = `NPC_SEL_NEXT;
                alu_sel = `ALU_SEL_OTHERS;
                alua_sel = `ALUA_SEL_RD1;
                alub_sel = `ALUB_SEL_SEXT;
                reg_w_sel = `RF_WSEL_ALUC;
                reg_we = 1;
                dram_re = 0;
                dram_we = 0;
            end

            `OPCODE_I_LOAD: begin
                gen_imm_op = `Sext_I;
                npc_op = `NPC_SEL_NEXT;
                alu_sel = `ALU_SEL_ADD;
                alua_sel = `ALUA_SEL_RD1;
                alub_sel = `ALUB_SEL_SEXT;
                reg_w_sel = `RF_WSEL_DRAM;
                reg_we = 1;
                dram_re = 1;
                dram_we = 0;
            end

            `OPCODE_S: begin
                gen_imm_op = `Sext_S;
                npc_op = `NPC_SEL_NEXT;
                alu_sel = `ALU_SEL_ADD;
                alua_sel = `ALUA_SEL_RD1;
                alub_sel = `ALUB_SEL_SEXT;
                reg_w_sel = `RF_WSEL_ALUC;
                reg_we = 0;
                dram_re = 0;
                dram_we = 1;
            end

            `OPCODE_B: begin
                gen_imm_op = `Sext_B;
                npc_op = `NPC_SEL_BRANCH;
                alu_sel = `ALU_SEL_SUB;
                alua_sel = `ALUA_SEL_RD1;
                alub_sel = `ALUB_SEL_RD2;
                reg_w_sel = `RF_WSEL_ALUC;
                reg_we = 0;
                dram_re = 0;
                dram_we = 0;
            end

            `OPCODE_JALR: begin
                gen_imm_op = `Sext_I;
                npc_op = `NPC_SEL_ALU;
                alu_sel = `ALU_SEL_ADD;
                alua_sel = `ALUA_SEL_RD1;
                alub_sel = `ALUB_SEL_SEXT;
                reg_w_sel = `RF_WSEL_PC4;
                reg_we = 1;
                dram_re = 0;
                dram_we = 0;
            end

            `OPCODE_JAL: begin
                gen_imm_op = `Sext_J;
                npc_op = `NPC_SEL_JAL;
                alu_sel = `ALU_SEL_ADD;
                alua_sel = `ALUA_SEL_ZERO;
                alub_sel = `ALUB_SEL_ZERO;
                reg_w_sel = `RF_WSEL_PC4;
                reg_we = 1;
                dram_re = 0;
                dram_we = 0;
            end

            `OPCODE_LUI: begin
                gen_imm_op = `Sext_U;
                npc_op = `NPC_SEL_NEXT;
                alu_sel = `ALU_SEL_ADD;
                alua_sel = `ALUA_SEL_ZERO;
                alub_sel = `ALUB_SEL_ZERO;
                reg_w_sel = `RF_WSEL_SEXT;
                reg_we = 1;
                dram_re = 0;
                dram_we = 0;
            end
            
            `OPCODE_AUIPC: begin
                gen_imm_op = `Sext_U;
                npc_op = `NPC_SEL_NEXT;
                alu_sel = `ALU_SEL_ADD;
                alua_sel = `ALUA_SEL_PC;
                alub_sel = `ALUB_SEL_SEXT;
                reg_w_sel = `RF_WSEL_ALUC;
                reg_we = 1;
                dram_re = 0;
                dram_we = 0;
            end

            default:begin
                gen_imm_op = `Sext_R;
                npc_op = `NPC_SEL_NEXT;
                alu_sel = `ALU_SEL_ADD;
                alua_sel = `ALUA_SEL_RD1;
                alub_sel = `ALUB_SEL_RD2;
                reg_w_sel = `RF_WSEL_ALUC;
                reg_we = 0;
                dram_re = 0;
                dram_we = 0;
            end
            
        endcase

    end : main_con
endmodule
