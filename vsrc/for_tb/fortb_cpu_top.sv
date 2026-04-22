`timescale 1ns / 1ps
`include "define.vh"

module fortb_cpu_top(
    input  logic clk,
    input  logic rst,
    output logic [31:0] PC
);

    logic [31:0] next_PC_to_ins_mem;
    logic [31:0] instruction_from_memory;
    logic [31:0] data_store;
    logic [31:0] data_load;
    logic [31:0] data_addr;
    logic [3:0]  data_we_byte;
    logic        mem_ena;
    logic        ena_ins_mem;

    core_top core_top(
        .clk(clk),
        .rst(rst),
        .PC(PC),
        .instruction_from_memory(instruction_from_memory),
        .ena_ins_mem(ena_ins_mem),
        .data_store(data_store),
        .data_load(data_load),
        .data_addr(data_addr),
        .data_we_byte(data_we_byte),
        .mem_ena(mem_ena)
    );

    fortb_ins_mem ins_mem(
        .clka(clk),
        .addra(PC[13:2]), // 指令地址线，word地址
        .douta(instruction_from_memory),
        .ena(ena_ins_mem)
    );

    fortb_data_mem data_mem(
        .clka(clk),
        .dina(data_store),
        .douta(data_load),
        .addra(data_addr[13:2]), // 数据地址线，word地址映射
        .wea(data_we_byte),
        .ena(mem_ena)
    );

endmodule

