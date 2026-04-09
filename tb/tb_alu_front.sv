`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 10:49:07 PM
// Design Name: 
// Module Name: tb_alu_front
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

// 测试两个alu前端相关模块
module tb_alu_front();
    // 信号声明 - alu_mux
    logic [`RegBus] tb_rd1, tb_rd2;
    logic [31:0] tb_pc, tb_gen_imm, tb_A, tb_B;
    logic [`ALUA_SEL_WIDTH-1:0] tb_alua_sel;
    logic [`ALUB_SEL_WIDTH-1:0] tb_alub_sel;

    alu_mux u_mux(
        .rd1(tb_rd1), .rd2(tb_rd2), .pc(tb_pc), .gen_imm(tb_gen_imm),
        .alua_sel(tb_alua_sel), .alub_sel(tb_alub_sel),
        .A(tb_A), .B(tb_B)
    );

    // 信号声明 - alu_op
    logic [2:0] tb_funct3;
    logic [6:0] tb_funct7;
    logic [`ALU_SEL_WIDTH-1:0] tb_alu_sel;
    logic [`ALU_OP_WIDTH-1:0] tb_alu_op;

    alu_op u_op(
        .funct3(tb_funct3), .funct7(tb_funct7), .alu_sel(tb_alu_sel), .alu_op(tb_alu_op)
    );

    task test_mux(
        input [`ALUA_SEL_WIDTH-1:0] sa, input [`ALUB_SEL_WIDTH-1:0] sb,
        input [31:0] exp_A, input [31:0] exp_B, input string name
    );
    begin
        tb_alua_sel = sa; tb_alub_sel = sb;
        #10;
        if (tb_A == exp_A && tb_B == exp_B) $display("[PASS] MUX: %s", name);
        else $display("[FAIL] MUX: %s | Got A:%h B:%h", name, tb_A, tb_B);
    end
    endtask

    task test_op(
        input [`ALU_SEL_WIDTH-1:0] sel, input [2:0] f3, input [6:0] f7,
        input [`ALU_OP_WIDTH-1:0] exp_op, input string name
    );
    begin
        tb_alu_sel = sel; tb_funct3 = f3; tb_funct7 = f7;
        #10;
        if (tb_alu_op == exp_op) $display("[PASS] OP: %s -> %d", name, tb_alu_op);
        else $display("[FAIL] OP: %s | Exp:%d Got:%d", name, exp_op, tb_alu_op);
    end
    endtask

    initial begin
        tb_rd1 = 32'h1111; tb_rd2 = 32'h2222; tb_pc = 32'h3333; tb_gen_imm = 32'h4444;

        // 测试 MUX
        test_mux(`ALUA_SEL_RD1, `ALUB_SEL_RD2,  32'h1111, 32'h2222, "R-Type (RD1, RD2)");
        test_mux(`ALUA_SEL_PC,  `ALUB_SEL_SEXT, 32'h3333, 32'h4444, "AUIPC (PC, SEXT)");
        test_mux(`ALUA_SEL_ZERO,`ALUB_SEL_ZERO, 32'h0000, 32'h0000, "LUI (ZERO, ZERO)");

        // 测试 ALU_OP 二级译码
        test_op(`ALU_SEL_ADD,    3'b000, 7'b0000000, `ALU_ADD, "Force ADD (e.g. Load/Store)");
        test_op(`ALU_SEL_SUB,    3'b000, 7'b0000000, `ALU_BEQ, "Branch (BEQ)");
        test_op(`ALU_SEL_OTHERS, 3'b000, 7'b0000000, `ALU_ADD, "R-Type (ADD)");
        test_op(`ALU_SEL_OTHERS, 3'b000, 7'b0100000, `ALU_SUB, "R-Type (SUB)");
        test_op(`ALU_SEL_OTHERS, 3'b111, 7'b0000000, `ALU_AND, "R-Type (AND)");
        #10 $finish;
    end
endmodule
