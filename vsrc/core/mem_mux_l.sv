`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/22/2026 01:36:37 PM
// Design Name:
// Module Name: mem_mux_l
// Project Name:
// Target Devices:
// Tool Versions:
// Description: Load 侧字节提取与符号扩展 (原 mem_mux 的 load 部分，放在 WB 阶段)
//
//////////////////////////////////////////////////////////////////////////////////

`include "define.vh"

module mem_mux_l(
    input  logic [2:0]  funct3,
    input  logic [1:0]  addr,         // alu_result[1:0]
    input  logic [31:0] dram_ld_in,   // BRAM 原始 32 位读出数据

    output logic [31:0] rd_ld_out     // 截取/符号扩展后的 load 数据
);

    logic        ext_val;
    logic [7:0]  ext_byte;
    logic [15:0] ext_half;

    always_comb begin : load_sel
        rd_ld_out = 32'b0;
        ext_val   = 1'b0;
        ext_byte  = 8'b0;
        ext_half  = 16'b0;

        case (funct3[1:0])
            `DRAM_SEL_B: begin
                ext_byte = (addr[1]) ? ((addr[0]) ? dram_ld_in[31:24] : dram_ld_in[23:16]) :
                                        ((addr[0]) ? dram_ld_in[15:8]  : dram_ld_in[7:0]) ;
                ext_val  = funct3[2] ? 1'b0 : ext_byte[7];
                rd_ld_out = {{24{ext_val}}, ext_byte};
            end

            `DRAM_SEL_H: begin
                ext_half = (addr[1]) ? dram_ld_in[31:16] : dram_ld_in[15:0];
                ext_val  = funct3[2] ? 1'b0 : ext_half[15];
                rd_ld_out = {{16{ext_val}}, ext_half};
            end

            `DRAM_SEL_W: begin
                rd_ld_out = dram_ld_in;
            end

            default: begin
                rd_ld_out = 32'b0;
            end
        endcase
    end : load_sel

endmodule
