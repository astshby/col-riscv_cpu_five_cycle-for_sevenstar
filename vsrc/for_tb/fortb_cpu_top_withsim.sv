`timescale 1ns / 1ps
`include "define.vh"

module fortb_cpu_top_withsim(
    input  logic clk,
    input  logic rst,
    output logic [31:0] PC
);

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

    // UART 劫持：如果地址是 0xFFFFFFFC 且是写操作，则拦截
    logic is_uart_write;
    assign is_uart_write = mem_ena && (|data_we_byte) && (data_addr == 32'hFFFF_FFFC);

    // 送往真实 RAM 的写使能信号：如果是串口写，屏蔽真实 RAM 的写操作
    logic [3:0] real_ram_we;
    assign real_ram_we = is_uart_write ? 4'b0000 : data_we_byte;

    fortb_ins_mem ins_mem(
        .clka(clk),
        .addra(PC[15:2]), // 映射到 64K 的地址空间 (14位地址线)
        .douta(instruction_from_memory),
        .ena(ena_ins_mem)
    );

    fortb_data_mem data_mem(
        .clka(clk),
        .dina(data_store),
        .douta(data_load),
        .addra(data_addr[15:2]), // 映射到 64K 的地址空间 (14位地址线)
        .wea(real_ram_we),
        .ena(mem_ena)
    );

    // 串口仿真黑盒
    simUart uart(
        .clk(clk),
        .rst(rst),
        .data(data_store[7:0]),
        .wEn(is_uart_write)
    );

endmodule