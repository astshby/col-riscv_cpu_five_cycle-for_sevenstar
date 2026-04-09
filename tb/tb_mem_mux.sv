`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 10:51:23 PM
// Design Name: 
// Module Name: tb_mem_mux
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

`timescale 1ns / 1ps

module tb_mem_mux();
    logic tb_mem_re, tb_mem_we;
    logic [2:0] tb_funct3;
    logic [1:0] tb_addr; 
    logic [31:0] tb_rs2_sd_in, tb_dram_ld_in;
    logic [3:0] tb_we_out;
    logic [31:0] tb_dram_sd_out, tb_rd_ld_out;

    mem_mux u_mem(
        .mem_re(tb_mem_re), .mem_we(tb_mem_we), .funct3(tb_funct3),
        .addr(tb_addr), .rs2_sd_in(tb_rs2_sd_in), .dram_ld_in(tb_dram_ld_in),
        .we_out(tb_we_out), .dram_sd_out(tb_dram_sd_out), .rd_ld_out(tb_rd_ld_out)
    );

    // 测试 Load 逻辑
    task test_load(
        input [2:0] f3, input [1:0] addr, input [31:0] dram_data,
        input [31:0] exp_rd, input string name
    );
    begin
        tb_mem_re = 1'b1; tb_mem_we = 1'b0;
        tb_funct3 = f3; tb_addr = addr; tb_dram_ld_in = dram_data;
        #10;
        if (tb_rd_ld_out == exp_rd) $display("[PASS] LOAD: %s", name);
        else $display("[FAIL] LOAD: %s | Exp:%h Got:%h", name, exp_rd, tb_rd_ld_out);
    end
    endtask

    // 测试 Store 逻辑
    task test_store(
        input [2:0] f3, input [1:0] addr, input [31:0] rs2_data,
        input [3:0] exp_we, input string name
    );
    begin
        tb_mem_re = 1'b0; tb_mem_we = 1'b1;
        tb_funct3 = f3; tb_addr = addr; tb_rs2_sd_in = rs2_data;
        #10;
        // 注意：Store 只关心 we_out 是否精确，dram_sd_out 只要包含了正确的数据就行
        if (tb_we_out == exp_we) $display("[PASS] STORE: %s -> WE:%b", name, tb_we_out);
        else $display("[FAIL] STORE: %s | ExpWE:%b GotWE:%b", name, exp_we, tb_we_out);
    end
    endtask

    initial begin
        
        // --- LOAD 测试 (假设内存吐出 32'h88776655) ---
        // LB 读取地址 00 的字节 (0x55)，正数符号扩展应为 0x00000055
        test_load(`DRAM_SEL_LB, 2'b00, 32'h8877_6655, 32'h0000_0055, "LB addr=00 (0x55)");
        // LB 读取地址 11 的字节 (0x88)，负数符号扩展应为 0xFFFFFF88
        test_load(`DRAM_SEL_LB, 2'b11, 32'h8877_6655, 32'hFFFF_FF88, "LB addr=11 (0x88 sign-ext)");
        // LBU 读取地址 11 的字节 (0x88)，无符号扩展应为 0x00000088
        test_load(`DRAM_SEL_LBU,2'b11, 32'h8877_6655, 32'h0000_0088, "LBU addr=11 (0x88 zero-ext)");
        // LH 读取地址 10 的半字 (0x8877)，负数符号扩展应为 0xFFFF8877
        test_load(`DRAM_SEL_LH, 2'b10, 32'h8877_6655, 32'hFFFF_8877, "LH addr=10 (0x8877 sign-ext)");
        
        // --- STORE 测试 (假设我们要写入 0xAABBCCDD) ---
        // SB 写地址 01，WE 应该只有第 1 位拉高: 4'b0010
        test_store(`DRAM_SEL_SB, 2'b01, 32'hAABB_CCDD, 4'b0010, "SB addr=01 (Byte Write)");
        // SH 写地址 10，WE 应该高两位拉高: 4'b1100
        test_store(`DRAM_SEL_SH, 2'b10, 32'hAABB_CCDD, 4'b1100, "SH addr=10 (Half Write)");
        // SW 写入全字，WE 应该全高: 4'b1111
        test_store(`DRAM_SEL_SW, 2'b00, 32'hAABB_CCDD, 4'b1111, "SW (Word Write)");
        
        #10 $finish;
    end
endmodule
