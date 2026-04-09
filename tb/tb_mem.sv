`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 08:17:42 PM
// Design Name: 
// Module Name: tb_mem
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


module tb_mem();

    // ==========================================
    // 1. 基础时钟信号
    // ==========================================
    logic clk;
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // ==========================================
    // 2. TB 驱动的控制信号 (模拟 CPU 发出的指令)
    // ==========================================
    logic mem_re;
    logic mem_we;
    logic [2:0] funct3;
    logic [31:0] dram_addr_out;
    logic [31:0] rs2_sd_in;

    // ==========================================
    // 3. 内部连接线 (连接 mem_mux 和 RAM_ip)
    // ==========================================
    logic [31:0] dram_ld_in;   // RAM 吐给 MUX 的数据
    logic [3:0]  dram_we_out;  // MUX 算出来的字节写使能
    logic [31:0] dram_sd_out;  // MUX 算出来的写入数据
    logic [31:0] rd_ld_out;    // MUX 算出来最终给 CPU 寄存器的数据

    // ==========================================
    // 4. 模块例化：Mem_MUX
    // ==========================================
    mem_mux u_mem_mux(
        .mem_re(mem_re),    
        .mem_we(mem_we),     
        .funct3(funct3),
        .addr(dram_addr_out[1:0]), // 取物理地址的最低两位计算偏移
        .rs2_sd_in(rs2_sd_in),   
        .dram_ld_in(dram_ld_in), 
        .we_out(dram_we_out),      
        .dram_sd_out(dram_sd_out),   
        .rd_ld_out(rd_ld_out)          
    );

    // ==========================================
    // 5. 模块例化：Vivado BRAM IP
    // ==========================================
    localparam RAM_BASE = 32'h8000_1000;
    wire [31:0] ram_phy_addr = dram_addr_out - RAM_BASE; 

    RAM_ip ram_inst(
        .addra(ram_phy_addr[14:2]), 
        .clka(clk), 
        .dina(dram_sd_out), 
        .wea(dram_we_out), 
        .douta(dram_ld_in), 
        .ena(mem_we),
        .enr(mem_re) 
    );

    // ==========================================
    // 6. 核心 Task：优雅处理 BRAM 延迟的读写函数
    // ==========================================
    
    // 写内存 Task
    task write_ram(input [31:0] waddr, input [2:0] f3, input [31:0] wdata, input string msg);
    begin
        @(negedge clk); // 在下降沿准备数据，最稳定
        dram_addr_out = waddr;
        funct3 = f3;
        rs2_sd_in = wdata;
        mem_we = 1;
        mem_re = 0;
        
        @(posedge clk); // BRAM 在这个上升沿吃进数据
        
        @(negedge clk); // 撤销信号
        mem_we = 0;
        $display("[STORE - %s] 向地址 %h 写入 %h", msg, waddr, wdata);
    end
    endtask

    // 读内存 Task
    task read_ram(input [31:0] raddr, input [2:0] f3, input string msg);
    begin
        @(negedge clk); 
        dram_addr_out = raddr;
        funct3 = f3;
        mem_re = 1;
        mem_we = 0;
        
        @(posedge clk); // 第 1 个上升沿：BRAM 锁存地址
        @(posedge clk); // 第 2 个上升沿：BRAM 吐出数据
        
        #1; // 给纯组合逻辑的 mem_mux 留 1ns 的计算时间
        $display("[LOAD  - %s] 从地址 %h 读取 -> 结果: %h", msg, raddr, rd_ld_out);
        
        mem_re = 0;
    end
    endtask

    // ==========================================
    // 7. 测试主战场 (你要求的测试用例)
    // ==========================================
    initial begin
        // 初始化信号
        mem_re = 0;
        mem_we = 0;
        dram_addr_out = 0;
        funct3 = 0;
        rs2_sd_in = 0;

        #20;
        $readmemh("../../../../../../riscv_tests/ram/sb_copy.hex", ram_inst.ram_mem);

        #20;
        $display("\n========== 阶段 1：在 0x80002000 埋下测试种子 ==========");
        // 埋入数据 32'hA5A5_89AB (测试符号位扩展的绝佳数据)
        write_ram(32'h8000_2000, 3'b010, 32'hA5A5_89AB, "SW");

        $display("\n========== 阶段 2：测试 5 种 Load 指令 (目标 0x80002000) ==========");
        // LB (取最低字节 0xAB，符号扩展应为 0xFFFFFFAB)
        read_ram(32'h8000_2000, 3'b000, "LB"); 
        
        // LBU (取最低字节 0xAB，零扩展应为 0x000000AB)
        read_ram(32'h8000_2000, 3'b100, "LBU"); 
        
        // LH (取低半字 0x89AB，符号扩展应为 0xFFFF89AB)
        read_ram(32'h8000_2000, 3'b001, "LH"); 
        
        // LHU (取低半字 0x89AB，零扩展应为 0x000089AB)
        read_ram(32'h8000_2000, 3'b101, "LHU"); 
        
        // LW (全字读取，应为 0xA5A589AB)
        read_ram(32'h8000_2000, 3'b010, "LW"); 

        $display("\n========== 阶段 3：测试 3 种 Store 并在 0x8000100x 验证 ==========");
        // SB (存入 1 个字节 0x11 到 0x80001000)
        write_ram(32'h8000_1000, 3'b000, 32'hFFFF_FF11, "SB");
        
        // SH (存入半字 0x2233 到 0x80001004)
        write_ram(32'h8000_1004, 3'b001, 32'hFFFF_2233, "SH");
        
        // SW (存入全字 0x44556677 到 0x80001008)
        write_ram(32'h8000_1008, 3'b010, 32'h4455_6677, "SW");

        $display("\n========== 阶段 4：用 LW 统一读取验证刚才的 Store ==========");
        read_ram(32'h8000_1000, 3'b010, "验证 SB"); // 期待低位出现 11
        read_ram(32'h8000_1004, 3'b010, "验证 SH"); // 期待低位出现 2233
        read_ram(32'h8000_1008, 3'b010, "验证 SW"); // 期待全字 44556677

        $display("\n========== 测试完毕 ==========\n");
        $finish;
    end

endmodule
