`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 06:04:43 PM
// Design Name: 
// Module Name: tb_control
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

module tb_control();
    logic [6:0] tb_opcode;
    logic [`Sext_OP_WIDTH-1:0] tb_gen_imm_op;
    logic [`NPC_SEL_WIDTH-1:0] tb_npc_op;
    logic [`ALU_SEL_WIDTH-1:0] tb_alu_sel;
    logic [`ALUA_SEL_WIDTH-1:0] tb_alua_sel;
    logic [`ALUB_SEL_WIDTH-1:0] tb_alub_sel;
    logic [`RF_WSEL_WIDTH-1:0] tb_reg_w_sel;
    logic tb_reg_we;
    logic tb_dram_re; 
    logic tb_dram_we;

    control u_control(
        .opcode(tb_opcode),
        .gen_imm_op(tb_gen_imm_op),
        .npc_op(tb_npc_op),
        .alu_sel(tb_alu_sel),
        .alua_sel(tb_alua_sel),
        .alub_sel(tb_alub_sel),
        .reg_w_sel(tb_reg_w_sel),
        .reg_we(tb_reg_we),
        .dram_re(tb_dram_re),
        .dram_we(tb_dram_we)
    );

    task check_ctrl(
        input [6:0] op,
        input tb_exp_reg_we, input tb_exp_mem_we, input tb_exp_mem_re,
        input string test_name
    );
    begin
        tb_opcode = op;
        #10;
        // 这里为了精简，主要检查最致命的三个使能信号
        if (tb_reg_we == tb_exp_reg_we && tb_dram_we == tb_exp_mem_we && tb_dram_re == tb_exp_mem_re) begin
            $display("[PASS] %s -> RegWE:%b MemWE:%b MemRE:%b", test_name, tb_reg_we, tb_dram_we, tb_dram_re);
        end else begin
            $display("[FAIL] %s -> EXPECTED RegWE:%b MemWE:%b MemRE:%b | GOT RegWE:%b MemWE:%b MemRE:%b", 
                     test_name, tb_exp_reg_we, tb_exp_mem_we, tb_exp_mem_re, tb_reg_we, tb_dram_we, tb_dram_re);
        end
    end
    endtask

    initial begin
        check_ctrl(`OPCODE_R,       1'b1,  1'b0,  1'b0,  "R-Type (add/sub)");
        check_ctrl(`OPCODE_I_REG,   1'b1,  1'b0,  1'b0,  "I-Type (addi)");
        check_ctrl(`OPCODE_I_LOAD,  1'b1,  1'b0,  1'b1,  "Load (lw/lb)");
        check_ctrl(`OPCODE_S,       1'b0,  1'b1,  1'b0,  "Store (sw/sb)");
        check_ctrl(`OPCODE_B,       1'b0,  1'b0,  1'b0,  "Branch (beq)");
        check_ctrl(`OPCODE_JAL,     1'b1,  1'b0,  1'b0,  "Jump (jal)");
        #10 $finish;
    end
endmodule
