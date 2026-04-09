`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 01:19:47 PM
// Design Name: 
// Module Name: tb_inst
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


module tb_inst();

    // ==========================================
    // 1. 基础时钟与复位生成
    // ==========================================
    logic clk;
    logic rst;

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz 时钟
    end

    initial begin
        rst = 1;
        #25;    // 保持复位一段时间
        rst = 0;
        
        #1000;  // 跑 1000ns 后自动停止，给你留足观察波形的时间
        $finish;
    end

    initial begin
        $readmemh("../../../../../../riscv_tests/rom/sb_copy.hex", inst_rom_inst.rom_mem);
    end

    // ==========================================
    // 2. 内部核心连线声明
    // ==========================================
    logic [31:0] pc;
    logic [31:0] npc;
    logic [31:0] pc_add4;
    logic [31:0] inst;

    // ==========================================
    // 3. 模块例化：PC (提供当前地址)
    // ==========================================
    PC pc_module(
        .clk(clk),
        .rst(rst),
        .npc(npc),
        .pc(pc) 
    );

    // ==========================================
    // 4. 模块例化：NPC (提供下一个地址)
    // ==========================================
    // 为了纯粹测试顺序取指，我们强行把跳转相关的控制信号绑死到不跳转的状态
    NPC npc_module(
        .pc(pc),
        .npc_op(2'b00),       // 假设 2'b00 是顺序执行 (PC+4)，请根据你的 define.vh 确认！
        .en_branch(1'b0),     // 强制关闭 B 类型分支跳转
        .offset(32'h0),       // 强制清零 Jal/分支 偏移量
        .alu_num(32'h0),      // 强制清零 Jalr 目标地址
        .npc(npc),
        .pc_add4(pc_add4) 
    );

    // ==========================================
    // 5. 核心逻辑：地址映射与 ROM 例化
    // ==========================================
    localparam ROM_BASE = 32'h8000_0000;
    logic [31:0] rom_addr;
    
    // 剥离 0x80000000 基地址，将其转化为 IP 核能理解的从 0 开始的物理偏移量
    assign rom_addr = pc - ROM_BASE; 

    // 例化 ROM IP 核
    // 这里的寻址切片 [14:2] 必须与你在 cpu_top.sv 中完全一致
    inst_ROM_ip inst_rom_inst(
        .a(rom_addr[14:2]), 
        .spo(inst) 
    );

endmodule