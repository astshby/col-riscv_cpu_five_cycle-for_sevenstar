`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2026 03:08:59 PM
// Design Name: 
// Module Name: tb_IF
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

module tb_IF();

    // 接口信号声明
    logic        clk;
    logic        rst;
    logic        hold;
    logic        jump;
    logic [31:0] jump_addr;
    logic [31:0] present_PC;
    logic [31:0] next_PC;

    // 例化被测模块 (UUT)
    IF_stage uut (
        .clk        (clk),
        .rst        (rst),
        .hold       (hold),
        .jump       (jump),
        .jump_addr  (jump_addr),
        .present_PC (present_PC),
        .next_PC    (next_PC)
    );

    // 生成时钟 (周期 10ns)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 激励进程
    initial begin
        // 1. 初始化输入
        rst       = 1'b1;
        hold      = 1'b0;
        jump      = 1'b0;
        jump_addr = 32'h0;

        // 2. 保持复位一段时间
        #22; 
        
        // 3. 释放复位 (特意选在非时钟沿释放，模拟真实的异步释放场景)
        // 观察重点：此时 next_PC 应该继续保持为 0，直到下一个时钟上升沿过去
        rst = 1'b0;
        $display("[%0t] Reset released", $time);

        // 4. 正常运行几个周期 (预期 present_PC: 0 -> 4 -> 8 -> 12)
        #40;

        // 5. 模拟发生 Load-Use 停顿 (Hold)
        // 观察重点：present_PC 和 next_PC 都应该保持不变
        $display("[%0t] Asserting Hold", $time);
        hold = 1'b1;
        #20;
        hold = 1'b0;
        $display("[%0t] De-asserting Hold", $time);

        // 6. 正常运行两个周期
        #20;

        // 7. 模拟发生分支跳转 (Jump)
        // 观察重点：next_PC 应该立刻变为 target_addr
        $display("[%0t] Asserting Jump to 0x100", $time);
        jump = 1'b1;
        jump_addr = 32'h0000_0100;
        #10;
        jump = 1'b0;
        
        // 8. 跳转后继续正常运行 (预期 present_PC: 100 -> 104 -> 108)
        #30;

        // 结束仿真
        $display("[%0t] Simulation Finished", $time);
        $finish;
    end

endmodule