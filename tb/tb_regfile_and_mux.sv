`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 01:57:51 PM
// Design Name: 
// Module Name: tb_regfile_and_mux
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


module tb_regfile_and_mux();

    // ==========================================
    // 1. 定义测试信号 (虚拟电线)
    // ==========================================
    // 时钟与复位
    logic clk;
    logic rst;

    // RegFile 控制信号
    logic [`RegAddrBus] rs1addr;
    logic [`RegAddrBus] rs2addr;
    logic [`RegAddrBus] rdaddr;
    logic wen;
    
    // MUX 数据源输入
    logic [`RF_WSEL_WIDTH-1:0] rf_wsel;
    logic [31:0] DRAM_wb;
    logic [31:0] alu_c;
    logic [31:0] pc4;
    logic [31:0] sext;

    // 观察输出信号
    logic [`RegBus] rs1data;
    logic [`RegBus] rs2data;

    // 连接 MUX 输出和 RegFile 输入的内部连线
    logic [31:0] wdata_wire; 

    // ==========================================
    // 2. 模块实例化
    // ==========================================
    
    // 实例化 MUX
    regfile_wd_MUX U_MUX (
        .rf_wsel (rf_wsel),
        .DRAM_wb (DRAM_wb),
        .alu_c   (alu_c),
        .pc4     (pc4),
        .sext    (sext),
        .wd      (wdata_wire)  // 输出连到 wdata_wire
    );

    // 实例化寄存器堆
    regfile U_REGFILE (
        .clk     (clk),
        .rst     (rst),
        .rs1addr (rs1addr),
        .rs2addr (rs2addr),
        .rdaddr  (rdaddr),
        .wdata   (wdata_wire), // 接收来自 MUX 的数据
        .wen     (wen),
        .rs1data (rs1data),
        .rs2data (rs2data)
    );

    // ==========================================
    // 3. 生成时钟
    // ==========================================
    always #10 clk = ~clk; // 周期 20ns

    // ==========================================
    // 4. 测试脚本 (Test Sequence)
    // ==========================================
    initial begin
        $display("================================================");
        $display("       RegFile & MUX Combined Testbench         ");
        $display("================================================");

        // --- 初始化 ---
        clk = 0;
        rst = 1;
        wen = 0;
        rs1addr = 0; rs2addr = 0; rdaddr = 0;
        rf_wsel = 0;
        
        // 准备好各路数据源的值（模拟各部件算出的结果）
        alu_c   = 32'hAAAA_1111;
        DRAM_wb = 32'hBBBB_2222;
        pc4     = 32'hCCCC_3333;
        sext    = 32'hDDDD_4444;

        // 等待复位完成
        #25 rst = 0; 

        // --------------------------------------------------------
        // 测试 1：选择 ALU 结果写入 x1 (模拟 ADD 指令)
        // --------------------------------------------------------
        $display("\n--- Test 1: Write ALU Result to x1 ---");
        rf_wsel = `RF_WSEL_ALUC; // MUX 选择 ALU
        rdaddr  = 5'd1;          // 目标寄存器 x1
        wen     = 1;             // 使能写入
        #20 wen = 0;             // 停止写入
        
        rs1addr = 5'd1; #1;      // 读出 x1 检查
        $display("x1 expected: %h, actual: %h", alu_c, rs1data);


        // --------------------------------------------------------
        // 测试 2：选择 DRAM 结果写入 x2 (模拟 LW 指令)
        // --------------------------------------------------------
        $display("\n--- Test 2: Write DRAM Result to x2 ---");
        rf_wsel = `RF_WSEL_DRAM; // MUX 选择 DRAM
        rdaddr  = 5'd2;          // 目标寄存器 x2
        wen     = 1;
        #20 wen = 0;
        
        rs1addr = 5'd2; #1;
        $display("x2 expected: %h, actual: %h", DRAM_wb, rs1data);


        // --------------------------------------------------------
        // 测试 3：选择 PC+4 写入 x3 (模拟 JAL 指令)
        // --------------------------------------------------------
        $display("\n--- Test 3: Write PC+4 to x3 ---");
        rf_wsel = `RF_WSEL_PC4;  // MUX 选择 PC4
        rdaddr  = 5'd3;          // 目标寄存器 x3
        wen     = 1;
        #20 wen = 0;
        
        rs1addr = 5'd3; #1;
        $display("x3 expected: %h, actual: %h", pc4, rs1data);


        // --------------------------------------------------------
        // 测试 4：选择 SEXT 写入 x4 (模拟 LUI 指令)
        // --------------------------------------------------------
        $display("\n--- Test 4: Write SEXT to x4 ---");
        rf_wsel = `RF_WSEL_SEXT; // MUX 选择 SEXT
        rdaddr  = 5'd4;          // 目标寄存器 x4
        wen     = 1;
        #20 wen = 0;
        
        rs1addr = 5'd4; #1;
        $display("x4 expected: %h, actual: %h", sext, rs1data);


        // --------------------------------------------------------
        // 测试 5：尝试写入 x0 (硬连线为0，不应被修改)
        // --------------------------------------------------------
        $display("\n--- Test 5: Attempt to Write x0 ---");
        rf_wsel = `RF_WSEL_ALUC; // MUX 选择 ALU
        rdaddr  = 5'd0;          // 目标寄存器 x0
        wen     = 1;
        #20 wen = 0;
        
        rs1addr = 5'd0; #1;
        $display("x0 expected: 00000000, actual: %h", rs1data);


        // --------------------------------------------------------
        // 测试 6：同时读两个写好的寄存器
        // --------------------------------------------------------
        $display("\n--- Test 6: Dual Read (x1 and x4) ---");
        rs1addr = 5'd1; 
        rs2addr = 5'd4; 
        #1; // 稍微等一下组合逻辑
        $display("rs1 (x1): %h, rs2 (x4): %h", rs1data, rs2data);

        $display("================================================");
        $display("                 Testbench Done                 ");
        $display("================================================");
        
        #20 $finish;
    end

endmodule