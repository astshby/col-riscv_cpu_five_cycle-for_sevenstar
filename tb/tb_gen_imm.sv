`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 06:04:43 PM
// Design Name: 
// Module Name: tb_imm_gen
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



module tb_gen_imm();

    // 1. 声明连接模块的信号
    logic [24:0] tb_inst;
    logic [`Sext_OP_WIDTH-1:0]  tb_gen_imm_op;
    logic [31:0] tb_imm;

    // 2. 实例化你的立即数生成器
    gen_imm u_gen_imm (
        .inst   (tb_inst),
        .gen_imm_op(tb_gen_imm_op),
        .imm    (tb_imm)
    );

    // 3.Task 的用法：类似于 C 语言的 void 函数
    // 专门用来封装重复的测试步骤，内部可以包含时间延迟 (#10)=
    task test_and_check(
        input [24:0] test_inst, 
        input [`Sext_OP_WIDTH-1:0]  test_op, 
        input [31:0] expected_imm,
        input string test_name
    );
    begin
        // 赋予激励信号
        tb_inst    = test_inst;
        tb_gen_imm_op = test_op;
        
        // 延迟 10ns，等待组合逻辑生成结果
        #10; 
        
        // $display 的用法：类似于 C 语言的 printf
        if (tb_imm == expected_imm) begin
            $display("[PASS] %s -> 算出的立即数: 0x%h", test_name, tb_imm);
        end else begin
            $display("[FAIL] %s -> 期待: 0x%h, 实际算出: 0x%h", test_name, expected_imm, tb_imm);
        end
    end
    endtask

    
    // 4.仿真
    initial begin

        // R 型指令（无立即数，应为 0）
        test_and_check(25'b0000000_0000_00000_000_00000_1, `Sext_R, 32'h0000_0000, "R-Type (0)");

        // I 型指令 (例如 addi x1, x2, -1)
        test_and_check(25'b1111_1111_1111_0000_0000_0000_0, `Sext_I, 32'hFFFF_FFFF, "I-Type (-1)");

        // S 型指令 (例如 sw x1, 8(x2))
        test_and_check(25'b0000_0000_0000_0000_0001_0100_0, `Sext_S, 32'h0000_0008, "S-Type (8)");

        // U 型指令 (例如 lui x1, 0x12345000)
        test_and_check(25'b0001001_00011_01000_101_00000, `Sext_U, 32'h1234_5000, "U-Type (0x12345000)");
        
        // B 型指令立即数 14（经典 beq 分支偏移）
        test_and_check(25'b0000000_00000_00000_000_10100, `Sext_B, 32'h0000_0014, "B-Type (14)");

        // J 型指令立即数最大正数 0xFFFFE
        test_and_check(25'b0111111_11111_11111_111_11111, `Sext_J, 32'h000F_FFFE, "J-Type (0xFFFFE)");
        
        //  $finish：通知仿真器结束运行
        #10 $finish; 
    end

endmodule
