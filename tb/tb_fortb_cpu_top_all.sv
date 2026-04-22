`timescale 1ns / 1ps
`include "define.vh"

module tb_fortb_cpu_top_all();
    // ==========================================
    // 1. 基础信号与时钟生成
    // ==========================================
    logic clk;
    logic rst;
    logic [31:0] PC_from_IF;

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz
    end

    // ==========================================
    // 2. 例化 CPU 顶层 
    // ==========================================
    fortb_cpu_top u_top(
        .clk(clk),
        .rst(rst),
        .PC(PC_from_IF)
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

    // 【修复】无论 PC 从 0 还是 8000_0000 启动，我们只抓取低 16 位地址的特征值 1000
    localparam TOHOST_OFFSET = 16'h1000;

    // ==========================================
    // 4. 自动化测试引擎主循环
    // ==========================================
    initial begin
        fd = $fopen("../../../../../../riscv-tests/test_list.txt", "r");
        if (fd == 0) begin
            $display("【致命错误】找不到 test_list.txt！请检查路径。");
            $finish;
        end

        while ($fscanf(fd, "%s", test_name) == 1) begin
            test_count++;
            rom_path = {"../../../../../../riscv-tests/rom/", test_name, ".hex"};
            ram_path = {"../../../../../../riscv-tests/ram/", test_name, ".hex"};

            $display("--------------------------------------------------");
            $display("[%0d] 正在启动测试: %s", test_count, test_name);

            // CPU 复位刹车
            rst = 1;

            // 【新增安全机制】彻底清空上一轮残留内存，防止长程序污染短程序！
            for (int i = 0; i < 4096; i++) begin
                u_top.ins_mem.rom_array[i]  = 32'h0;
                u_top.data_mem.ram_array[i] = 32'h0;
            end

            // 灌入新的测试程序
            $readmemh(rom_path, u_top.ins_mem.rom_array);
            $readmemh(ram_path, u_top.data_mem.ram_array);

            #20;
            rst = 0; // 释放复位，发车

            fork
                begin : bus_monitor
                    forever begin
                        @(posedge clk);
                        // 【修复核心】使用掩码截取低 16 位进行监控，完美解决 PC 地址偏移导致的误判
                        if ((|u_top.data_we_byte) && (u_top.data_addr[15:0] == TOHOST_OFFSET)) begin
                            if (u_top.data_store == 32'h1) begin
                                $display("    -> [SUCCESS] %s 完美通过！", test_name);
                                pass_count++;
                            end else begin
                                $display("    -> [FAILED] %s 阵亡在第 %0d 个用例！(Err Code: %0h)", 
                                         test_name, u_top.data_store >> 1, u_top.data_store);
                            end
                            break; // 结束当前程序的监控
                        end
                    end
                end
                
                begin : watchdog_timer
                    #500000; // 500us 强制叫停
                    $display("    -> [TIMEOUT] %s 跑飞或陷入死锁！", test_name);
                end
            join_any
            
            disable fork;
            #50; // 缓冲时间，进入下一个测试
        end

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