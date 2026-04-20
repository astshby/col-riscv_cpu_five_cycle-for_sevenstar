`timescale 1ns / 1ps

`include "define.vh"

module MEM_stage (
    input logic mem_re,    // MEM阶段是否要读数据存储器
    input logic mem_we,    // MEM阶段是否要写数据存储器
    input logic [2:0] funct3, // MEM阶段指令的 funct3 字段
    input logic [31:0] alu_result,      // MEM阶段访问数据存储器的地址
    input logic [31:0] rs2_sd_in,   // MEM阶段准备写入的数据 (store_data)
    output logic [31:0] rd_ld_out,  // 从 BRAM 读出的原始 32 位数据经过处理后给寄存器的数据

    // 写数据多选，用以产生正确的前递的数据
    input logic [31:0] PC,
    input logic [31:0] imm,
    input logic [`RF_WSEL_WIDTH-1:0] reg_w_sel,
    output logic [31:0] forward_data_output, // 真正正确的前递输出 (给 core_top 里的 Forwarding MUX)

    // load/store 数据前递相关输入
    input logic forward_data_sel_MEM,
    input logic [31:0] wb_data, // 来自 WB 阶段的前递数据

    // 连接到 data_mem 的接口
    output logic [31:0] data_store, // MEM阶段要写入数据存储器的数据
    input logic [31:0] data_load,  // 从数据存储器读出的数据
    output logic [31:0] data_addr,  // MEM阶段访问数据存储器的地址
    output logic [3:0] data_we_byte, // MEM阶段访问数据存储器的字节写使能
    output logic mem_ena // MEM阶段访问数据存储器的使能信号
);

    assign data_addr = alu_result; // MEM阶段访问数据存储器的地址直接来自 ALU 结果

    // =======================================================
    // 1. 处理 Store 指令在 MEM 阶段的写入数据前递 (Load -> Store 背靠背)
    // =======================================================
    logic [31:0] rs2_data_fwd;
    assign rs2_data_fwd = forward_data_sel_MEM ? wb_data : rs2_sd_in;

    // =======================================================
    // 2. 内存接口多路选择器 (保持不变)
    // =======================================================
    mem_mux mem_mux(
        .mem_re(mem_re),    
        .mem_we(mem_we),    
        .funct3(funct3),    
        .addr(alu_result[1:0]),      
        .rs2_sd_in(rs2_data_fwd),   
        .dram_ld_in(data_load),  
        
        .ena_out(mem_ena),     
        .we_out(data_we_byte),      
        .dram_sd_out(data_store), 
        .rd_ld_out(rd_ld_out)    
    );

    // =======================================================
    // 3. 生成精确的 MEM 阶段前递数据 (解决 test_6 的 Bug)
    // =======================================================
    // 计算 PC + 4，供 JAL/JALR 旁路使用
    logic [31:0] pc4;
    assign pc4 = PC + 32'd4;

    // 复用写回数据多选器，提前算好这根指令最终要写回的值
    regfile_wd_MUX fwd_data_mux(
        .rf_wsel (reg_w_sel),
        .DRAM_wb (32'h0), 
        .alu_c   (alu_result),
        .pc4     (pc4),
        .sext    (imm),
        .wd      (forward_data_output) // 输出真正的前递数据！
    );

endmodule