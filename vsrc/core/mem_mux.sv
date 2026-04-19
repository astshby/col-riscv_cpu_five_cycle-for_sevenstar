`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 07:31:56 PM
// Design Name: 
// Module Name: mem_mux
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


module mem_mux(
    input  logic mem_re,    
    input  logic mem_we,     
    input  logic [2:0] funct3,
    input  logic [1:0] addr,         // 地址的最低两位 (data_addr[1:0])
    input  logic [31:0] rs2_sd_in,   // 准备写入的数据 (store_data)
    input  logic [31:0] dram_ld_in,  // 从 BRAM 读出的原始 32 位数据
    
    // --- 修改后的输出接口 ---
    output logic        ena_out,     // 统一的芯片使能 (接 data_mem 的 ena)
    output logic [3:0]  we_out,      // 字节写使能 (接 data_mem 的 wea)
    output logic [31:0] dram_sd_out, // 对齐后的写入数据 (接 data_mem 的 dina)
    output logic [31:0] rd_ld_out    // 截取/符号扩展后给寄存器的数据
);

    // ==========================================
    // 统一使能信号：只要有读或写请求，就使能 BRAM
    // ==========================================
    assign ena_out = mem_re | mem_we;

    // ==========================================
    // Load 逻辑：从 32 位数据中截取需要的 Byte/Halfword 并扩展
    // ==========================================
    logic ext_val;
    logic [7:0] ext_byte;
    logic [15:0] ext_half;
    
    always_comb begin : load_sel 
        rd_ld_out = 32'b0;
        
        // 注意：这里删除了 re_out，因为不需要了
        if(mem_re) begin
            case (funct3[1:0])
                `DRAM_SEL_B: begin
                    ext_byte = (addr[1]) ? ((addr[0]) ? dram_ld_in[31:24] : dram_ld_in[23:16]):
                                            ((addr[0]) ? dram_ld_in[15:8] : dram_ld_in[7:0]) ;
                    ext_val = funct3[2] ? 1'b0 : ext_byte[7]; 
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
        end
    end : load_sel    
    
    // ==========================================
    // Store 逻辑：生成写数据副本和对应的 4-bit 字节使能
    // ==========================================
    always_comb begin : store_sel
        we_out = 4'b0000;  // 默认不写
        dram_sd_out = 32'd0;
        
        if(mem_we) begin
            case(funct3[1:0])
                `DRAM_SEL_B: begin
                    dram_sd_out = {4{rs2_sd_in[7:0]}};    
                    we_out = (addr[1]) ? ((addr[0]) ? 4'b1000 : 4'b0100):
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
                 
                default:begin
                    dram_sd_out = 32'd0;
                    we_out = 4'b0000;
                end 
            endcase         
        end
    end : store_sel

endmodule