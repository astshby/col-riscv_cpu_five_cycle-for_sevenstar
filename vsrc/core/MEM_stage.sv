`timescale 1ns / 1ps

`include "define.vh"

module MEM_stage (
    input logic mem_re,    // MEM阶段是否要读数据存储器
    input logic mem_we,    // MEM阶段是否要写数据存储器
    input logic [2:0] funct3, // MEM阶段指令的 funct3 字段
    input logic [31:0] alu_result,      // MEM阶段访问数据存储器的地址
    input logic [31:0] rs2_sd_in,   // MEM阶段准备写入的数据 (store_data)
    output logic [31:0] rd_ld_out,  // 从 BRAM 读出的原始 32 位数据经过处理后给寄存器的数据


    // 连接到 data_mem 的接口
    output logic [31:0] data_store, // MEM阶段要写入数据存储器的数据
    input logic [31:0] data_load,  // 从数据存储器读出的数据
    output logic [31:0] data_addr,  // MEM阶段访问数据存储器的地址
    output logic [3:0] data_we_byte, // MEM阶段访问数据存储器的字节写使能
    output logic mem_ena // MEM阶段访问数据存储器的使能信号
    
);
    assign data_addr = alu_result; // MEM阶段访问数据存储器的地址直接来自 ALU 结果

    mem_mux mem_mux(
        .mem_re(mem_re),    // MEM阶段是否要读数据存储器 (由控制单元生成)
        .mem_we(mem_we),    // MEM阶段是否要写数据存储器 (由控制单元生成)
        .funct3(funct3),    // MEM阶段指令的 funct3 字段 (由控制单元生成)
        .addr(alu_result[1:0]),      // MEM阶段访问数据存储器的地址的最低两位 (由 ALU 结果提供)
        .rs2_sd_in(rs2_sd_in),   // MEM阶段准备写入的数据 (来自 EX_MEM_pipe 的 rs2 数据)
        .dram_ld_in(data_load),  // 从 BRAM 读出的原始 32 位数据
        
        .ena_out(mem_ena),     // 统一的芯片使能 (接 data_mem 的 ena)
        .we_out(data_we_byte),      // 字节写使能 (接 data_mem 的 wea)
        .dram_sd_out(data_store), // 对齐后的写入数据 (接 data_mem 的 dina)
        .rd_ld_out(rd_ld_out)    // 截取/符号扩展后给寄存器的数据 (传回 EX_MEM_pipe 再传给 WB 阶段)
    );

endmodule