`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2026 07:25:57 PM
// Design Name: 
// Module Name: tb_pc_npc
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

module tb_pc_npc(); // Testbench 永远没有输入输出端口

    // 1. 定义虚拟电线
    logic clk;
    logic rst;
    logic [31:0] current_pc;
    logic [31:0] next_pc;
    
    // 给 NPC 准备的假信号
    logic [1:0]  sim_npc_op;
    logic        sim_en_branch;
    logic [31:0] sim_offset;
    logic [31:0] sim_alu_num;
    logic [31:0] sim_pc_add4;

    // 2. 实例化
    PC U_PC (
        .clk(clk),
        .rst(rst),
        .npc(next_pc),   
        .pc(current_pc)  
    );

    NPC U_NPC (
        .pc(current_pc), 
        .npc_op(sim_npc_op),
        .en_branch(sim_en_branch),
        .offset(sim_offset),
        .alu_num(sim_alu_num),
        .npc(next_pc),   
        .pc_add4(sim_pc_add4)       
    );

    // 3. 生成虚拟时钟 (每 10ns 翻转一次)
    always #10 clk = ~clk;

    // 4. 编写测试剧本
    initial begin
        // 开机初始化
        clk = 0;
        rst = 1; // 触发复位 (根据你的定义可能是 1 也可能是 0)
        sim_npc_op = 0; sim_en_branch = 0; sim_offset = 0; sim_alu_num = 0;
        
        #25; // 等待 25ns
        rst = 0; // 撤销复位，系统开始运转
        
        // 剧本 1：让它正常跑几个周期 (PC 应该 80000000, 80000004, 80000008...)
        #50; 
        
        // 剧本 2：模拟一个跳转指令 (假设跳过 16 个字节)
        sim_npc_op = 1; // 假设 1 是 NPC_SEL_BRANCH
        sim_en_branch = 1; // 假装 ALU 比较结果相等
        sim_offset = 32'd16;
        
        #20; // 观察跳转是否成功
        
        // 恢复正常
        sim_npc_op = 0;
        sim_en_branch = 0;
        
        #50;
        $finish; // 结束仿真
    end

endmodule
