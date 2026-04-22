`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/22/2026 01:35:52 PM
// Design Name:
// Module Name: mem_mux_s
// Project Name:
// Target Devices:
// Tool Versions:
// Description: Store 侧存储器接口 (原 mem_mux 的 store 部分，留在 MEM 阶段)
//
//////////////////////////////////////////////////////////////////////////////////

`include "define.vh"

module mem_mux_s(
    input  logic        mem_re,
    input  logic        mem_we,
    input  logic [2:0]  funct3,
    input  logic [1:0]  addr,         // alu_result[1:0]
    input  logic [31:0] rs2_sd_in,    // 前递修正后的 store 数据

    output logic        ena_out,      // BRAM 芯片使能
    output logic [3:0]  we_out,       // 字节写使能
    output logic [31:0] dram_sd_out   // 对齐后的写入数据
);

    assign ena_out = mem_re | mem_we;

    always_comb begin : store_sel
        we_out      = 4'b0000;
        dram_sd_out = 32'd0;

        if (mem_we) begin
            case (funct3[1:0])
                `DRAM_SEL_B: begin
                    dram_sd_out = {4{rs2_sd_in[7:0]}};
                    we_out = (addr[1]) ? ((addr[0]) ? 4'b1000 : 4'b0100) :
                                         ((addr[0]) ? 4'b0010 : 4'b0001) ;
                end
                `DRAM_SEL_H: begin
                    dram_sd_out = {2{rs2_sd_in[15:0]}};
                    we_out = (addr[1]) ? 4'b1100 : 4'b0011;
                end
                `DRAM_SEL_W: begin
                    dram_sd_out = rs2_sd_in;
                    we_out = 4'b1111;
                end
                default: begin
                    dram_sd_out = 32'd0;
                    we_out = 4'b0000;
                end
            endcase
        end
    end : store_sel

endmodule
