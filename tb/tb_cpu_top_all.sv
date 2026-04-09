`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2026 03:26:03 PM
// Design Name: 
// Module Name: tb_cpu_top_all
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

module tb_cpu_top_all();

    // ==========================================
    // 1. 基础信号与时钟生成
    // ==========================================
    logic clk;
    logic rst;

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz
    end

    // ==========================================
    // 2. 例化 CPU 顶层
    // ==========================================
    cpu_top u_top(
        .clk(clk),
        .rst(rst)
    );

    // ==========================================
    // 3. 测试环境配置
    // ==========================================
    int fd;
    string test_name;
    string rom_path;
    string ram_path;
    int test_count = 0;
    int pass_count = 0;
    
    // 你的 tohost 物理地址
    localparam TOHOST_ADDR = 32'h8000_1000; 

    // ==========================================
    // 4. 自动化测试引擎主循环
    // ==========================================
    initial begin
        // 打开你的测试列表 (请确保路径匹配你的真实环境)
        fd = $fopen("../../../../../../riscv_tests/test_list.txt", "r");
        if (fd == 0) begin
            $display("【致命错误】找不到 test_list.txt！请检查路径。");
            $finish;
        end

        // 循环读取每一行测试名字
        while ($fscanf(fd, "%s", test_name) == 1) begin
            test_count++;
            
            // 动态拼接 .hex 文件路径
            rom_path = {"../../../../../../riscv_tests/rom/", test_name, ".hex"};
            ram_path = {"../../../../../../riscv_tests/ram/", test_name, ".hex"};

            $display("--------------------------------------------------");
            $display("[%0d] 正在启动测试: %s", test_count, test_name);

            // CPU 复位刹车
            rst = 1;

            // ==========================================
            // 【神级操作：跨层级直接灌入数组】
            // 因为现在是我们手写的纯 Verilog 模块，路径变得极其清爽！
            // ==========================================
            // 将机器码灌入 ROM 的 rom_mem 数组
            $readmemh(rom_path, u_top.inst_rom_inst.rom_mem);
            // 将数据段灌入 RAM 的 ram_mem 数组
            $readmemh(ram_path, u_top.ram_inst.ram_mem);

            #20;
            rst = 0; // 释放复位，CPU 狂飙开始

            // ==========================================
            // 并行监控系统 (总线嗅探裁判 + 超时看门狗)
            // ==========================================
            fork
                begin : bus_monitor
                    forever begin
                        @(posedge clk);
                        // 发现 CPU 企图写入 tohost 地址
                        if (u_top.core_top_inst.dram_we && u_top.core_top_inst.dram_addr_out == TOHOST_ADDR) begin
                            
                            // 开箱验货，检查结果
                            if (u_top.core_top_inst.dram_sd_out == 32'h1) begin
                                $display("    -> [SUCCESS] %s 完美通过！", test_name);
                                pass_count++;
                            end else begin
                                $display("    -> [FAILED] %s 阵亡在第 %0d 个用例！(Err Code: %0h)", 
                                         test_name,
                                         u_top.core_top_inst.dram_sd_out >> 1, 
                                         u_top.core_top_inst.dram_sd_out);
                            end
                            break; // 结束当前程序的监控，准备跑下一个
                        end
                    end
                end
                
                begin : watchdog_timer
                    #500000; // 500us 强制叫停机制
                    $display("    -> [TIMEOUT] %s 跑飞或陷入死锁！", test_name);
                end
            join_any
            
            // 掐断未完成的后台进程
            disable fork; 

            // 清理上一轮的 RAM 垃圾数据，避免对下一个测试造成污染 (选做)
            // u_top.ram_inst.ram_mem[0] = 32'h0; 
            
            #50; // 缓冲时间
        end

        // 最终战报
        $display("==================================================");
        $display(" 批量自动化测试全部结束！");
        $display(" 总计挑战: %0d 条", test_count);
        $display(" 成功通关: %0d 条", pass_count);
        $display(" 阵亡数量: %0d 条", test_count - pass_count);
        $display("==================================================");
        
        $fclose(fd);
        $finish;
    end

endmodule
