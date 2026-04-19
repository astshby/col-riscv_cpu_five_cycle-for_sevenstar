`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 09:40:54 PM
// Design Name: 
// Module Name: tb_alu
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


module tb_alu();

    logic [`ALU_OP_WIDTH-1:0] alu_op;
    logic [31:0] A;
    logic [31:0] B;
    logic [31:0] result;

    alu alu (
        .alu_op(alu_op),
        .A(A),
        .B(B),
        .result(result)
    );

    initial begin
        $display("================================================");
        $display("               ALU Testbench Start              ");
        $display("================================================");

        // --------------------------------------------------------
        // 阶段 1：基础算术与逻辑运算 (使用常规正数)
        // --------------------------------------------------------
        A = 32'h00000005; // 5
        B = 32'h00000003; // 3
        $display("\n--- Stage 1: Basic Arithmetic & Logic (A=5, B=3) ---");

        alu_op = `ALU_ADD; #10; $display("ADD  : 5 + 3 = %d", result);
        alu_op = `ALU_SUB; #10; $display("SUB  : 5 - 3 = %d", result);
        alu_op = `ALU_AND; #10; $display("AND  : 5 & 3 = %d", result);
        alu_op = `ALU_OR;  #10; $display("OR   : 5 | 3 = %d", result);
        alu_op = `ALU_XOR; #10; $display("XOR  : 5 ^ 3 = %d", result);


        // --------------------------------------------------------
        // 阶段 2：移位运算 (引入负数以对比逻辑右移和算术右移)
        // --------------------------------------------------------
        A = 32'hFFFFFFF0; // -16 (补码)
        B = 32'h00000002; // 移动 2 位
        $display("\n--- Stage 2: Shift Operations (A=-16/0xFFFFFFF0, B=2) ---");

        alu_op = `ALU_SLL; #10; $display("SLL  : 逻辑左移结果 = %h", result);
        alu_op = `ALU_SRL; #10; $display("SRL  : 逻辑右移结果 = %h (高位补0)", result);
        alu_op = `ALU_SRA; #10; $display("SRA  : 算术右移结果 = %h (高位补符号位1)", result);


        // --------------------------------------------------------
        // 阶段 3：大小比较 (有符号 vs 无符号)
        // --------------------------------------------------------
        A = 32'hFFFFFFFF; // 有符号为 -1，无符号为 4294967295 (最大正数)
        B = 32'h00000005; // 5
        $display("\n--- Stage 3: Comparisons (A=-1/0xFFFFFFFF, B=5) ---");

        alu_op = `ALU_SLT;  #10; $display("SLT  : (-1 < 5) 有符号比较 = %b (预期: 1)", result[0]);
        alu_op = `ALU_SLTU; #10; $display("SLTU : (MAX < 5) 无符号比较 = %b (预期: 0)", result[0]);


        
        $display("================================================");
        $display("               ALU Testbench Done               ");
        $display("================================================");
        
        $finish; // 结束仿真
    end


endmodule
