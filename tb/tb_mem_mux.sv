`timescale 1ns / 1ps

`include "define.vh"

module tb_mem_mux();
    // ==========================================
    // Store 侧信号 (mem_mux_s)
    // ==========================================
    logic        tb_mem_re, tb_mem_we;
    logic [2:0]  tb_funct3;
    logic [1:0]  tb_addr;
    logic [31:0] tb_rs2_sd_in;
    logic        tb_ena_out;
    logic [3:0]  tb_we_out;
    logic [31:0] tb_dram_sd_out;

    // ==========================================
    // Load 侧信号 (mem_mux_l)
    // ==========================================
    logic [31:0] tb_dram_ld_in;
    logic [31:0] tb_rd_ld_out;

    mem_mux_s u_store(
        .mem_re(tb_mem_re), .mem_we(tb_mem_we), .funct3(tb_funct3),
        .addr(tb_addr), .rs2_sd_in(tb_rs2_sd_in),
        .ena_out(tb_ena_out), .we_out(tb_we_out), .dram_sd_out(tb_dram_sd_out)
    );

    mem_mux_l u_load(
        .funct3(tb_funct3), .addr(tb_addr),
        .dram_ld_in(tb_dram_ld_in),
        .rd_ld_out(tb_rd_ld_out)
    );

    // ==========================================
    // Load 测试
    // ==========================================
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

    // ==========================================
    // Store 测试
    // ==========================================
    task test_store(
        input [2:0] f3, input [1:0] addr, input [31:0] rs2_data,
        input [3:0] exp_we, input string name
    );
    begin
        tb_mem_re = 1'b0; tb_mem_we = 1'b1;
        tb_funct3 = f3; tb_addr = addr; tb_rs2_sd_in = rs2_data;
        #10;
        if (tb_we_out == exp_we) $display("[PASS] STORE: %s -> WE:%b", name, tb_we_out);
        else $display("[FAIL] STORE: %s | ExpWE:%b GotWE:%b", name, exp_we, tb_we_out);
    end
    endtask

    // ==========================================
    // ena 测试
    // ==========================================
    task test_ena(
        input logic re, input logic we,
        input logic exp_ena, input string name
    );
    begin
        tb_mem_re = re; tb_mem_we = we;
        #10;
        if (tb_ena_out == exp_ena) $display("[PASS] ENA: %s", name);
        else $display("[FAIL] ENA: %s | Exp:%b Got:%b", name, exp_ena, tb_ena_out);
    end
    endtask

    initial begin
        // --- LOAD 测试 (假设内存吐出 32'h88776655) ---
        test_load(`DRAM_SEL_LB, 2'b00, 32'h8877_6655, 32'h0000_0055, "LB addr=00 (0x55)");
        test_load(`DRAM_SEL_LB, 2'b11, 32'h8877_6655, 32'hFFFF_FF88, "LB addr=11 (0x88 sign-ext)");
        test_load(`DRAM_SEL_LBU,2'b11, 32'h8877_6655, 32'h0000_0088, "LBU addr=11 (0x88 zero-ext)");
        test_load(`DRAM_SEL_LH, 2'b10, 32'h8877_6655, 32'hFFFF_8877, "LH addr=10 (0x8877 sign-ext)");
        test_load(`DRAM_SEL_LHU,2'b00, 32'h8877_6655, 32'h0000_6655, "LHU addr=00 (0x6655 zero-ext)");
        test_load(`DRAM_SEL_LW, 2'b00, 32'hDEAD_BEEF, 32'hDEAD_BEEF, "LW full word");

        // --- STORE 测试 (假设我们要写入 0xAABBCCDD) ---
        test_store(`DRAM_SEL_SB, 2'b01, 32'hAABB_CCDD, 4'b0010, "SB addr=01");
        test_store(`DRAM_SEL_SB, 2'b00, 32'hAABB_CCDD, 4'b0001, "SB addr=00");
        test_store(`DRAM_SEL_SB, 2'b10, 32'hAABB_CCDD, 4'b0100, "SB addr=10");
        test_store(`DRAM_SEL_SB, 2'b11, 32'hAABB_CCDD, 4'b1000, "SB addr=11");
        test_store(`DRAM_SEL_SH, 2'b00, 32'hAABB_CCDD, 4'b0011, "SH addr=00");
        test_store(`DRAM_SEL_SH, 2'b10, 32'hAABB_CCDD, 4'b1100, "SH addr=10");
        test_store(`DRAM_SEL_SW, 2'b00, 32'hAABB_CCDD, 4'b1111, "SW full word");

        // --- ENA 测试 ---
        test_ena(1'b0, 1'b0, 1'b0, "idle -> ena=0");
        test_ena(1'b1, 1'b0, 1'b1, "read -> ena=1");
        test_ena(1'b0, 1'b1, 1'b1, "write -> ena=1");
        test_ena(1'b1, 1'b1, 1'b1, "read+write -> ena=1");

        #10 $finish;
    end
endmodule
