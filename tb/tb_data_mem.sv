`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2026 07:26:09 PM
// Design Name: 
// Module Name: tb_data_mem
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

module tb_data_mem();

    // =======================================================
    // 信号定义
    // =======================================================
    reg         clka;
    reg         ena;
    reg  [3:0]  wea;
    reg  [11:0] addra;
    reg  [31:0] dina;
    wire [31:0] douta;

    // =======================================================
    // 时钟生成 (100MHz)
    // =======================================================
    initial begin
        clka = 0;
        forever #5 clka = ~clka; 
    end

    // =======================================================
    // 例化 IP 核
    // 确保组件名与你的 IP 名字完全一致：data_mem
    // =======================================================
    data_mem uut (
        .clka  (clka),
        .ena   (ena),
        .wea   (wea),
        .addra (addra),
        .dina  (dina),
        .douta (douta)
    );

    // =======================================================
    // Task 封装：使测试用例更像伪代码，方便阅读
    // =======================================================
    
    // 写操作 Task
    task write_word;
        input [11:0] t_addr;
        input [31:0] t_data;
        input [3:0]  t_wea; // 暴露 wea 方便测试字节写
        begin
            @(posedge clka); // 对齐此时钟上升沿
            ena   = 1'b1;
            wea   = t_wea;
            addra = t_addr;
            dina  = t_data;
        end
    endtask

    // 读操作 Task
    task read_word;
        input [11:0] t_addr;
        begin
            @(posedge clka);
            ena   = 1'b1;
            wea   = 4'b0000; // 读操作必须拉低写使能
            addra = t_addr;
        end
    endtask

    // 空闲 Task：失能 RAM，保持时钟推进
    task idle_cycle;
        input integer cycles;
        integer i;
        begin
            for (i = 0; i < cycles; i = i + 1) begin
                @(posedge clka);
                ena = 1'b0;
                wea = 4'b0000;
            end
        end
    endtask

    // =======================================================
    // 激励主进程
    // =======================================================
    initial begin
        // 1. 初始化
        ena   = 0;
        wea   = 0;
        addra = 0;
        dina  = 0;
        
        #50; // 等待全局复位结束

        // ===================================================
        // 场景 1：基础的独立写和独立读
        // 目的：观察 BRAM 的固有读延迟 (通常表现为 1 或 2 个时钟周期后 douta 出数据)
        // ===================================================
        $display("--- Scenario 1: Basic Write and Read ---");
        write_word(12'h001, 32'h11223344, 4'b1111);
        idle_cycle(2); // 停两个周期，波形上看得更清晰
        read_word(12'h001);
        idle_cycle(3);

        // ===================================================
        // 场景 2：字节写使能测试 (Byte Write Enable)
        // 目的：验证 wea[3:0] 如何单独控制每一个 Byte
        // ===================================================
        $display("--- Scenario 2: Byte Write Enable ---");
        write_word(12'h002, 32'hAAAAAAAA, 4'b1111); // 先写满 4 个字节
        idle_cycle(1);
        write_word(12'h002, 32'hBB0000BB, 4'b1001); // 仅覆盖最高字节和最低字节
        idle_cycle(1);
        read_word(12'h002); // 预期读出结果：32'hBBAAAABB
        idle_cycle(3);

        // ===================================================
        // 场景 3：连续的流水线写和读 (Burst)
        // 目的：观察连续无缝操作下，时钟流水线是如何吃数据的
        // ===================================================
        $display("--- Scenario 3: Continuous Write and Read ---");
        write_word(12'h010, 32'hA0A0A0A0, 4'b1111);
        write_word(12'h011, 32'hA1A1A1A1, 4'b1111);
        write_word(12'h012, 32'hA2A2A2A2, 4'b1111);
        
        // 紧接着无缝连续读
        read_word(12'h010);
        read_word(12'h011);
        read_word(12'h012);
        idle_cycle(3);

        // ===================================================
        // 场景 4：同地址读写冲突测试 (Operating Mode Test)
        // 目的：Vivado BRAM 有三种模式 WRITE_FIRST, READ_FIRST, NO_CHANGE。
        // 此测试观察连续操作同一地址时，douta 输出的是旧值还是新值。
        // ===================================================
        $display("--- Scenario 4: Write-Read Conflict / RAW ---");
        // 先写一个底色数据
        write_word(12'h020, 32'hDEADBEEF, 4'b1111);
        idle_cycle(2);
        
        // 紧接着：读该地址 -> 写该地址新数据 -> 读该地址
        read_word (12'h020);                         // 应该输出 DEADBEEF
        write_word(12'h020, 32'h88889999, 4'b1111);  // 观察此时 douta 是什么？(Write_First模式下会立刻看到新数据)
        read_word (12'h020);                         // 应该输出 88889999
        idle_cycle(5);

        $display("Simulation Finished.");
        $finish;
    end

endmodule