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
    input  logic [1:0] addr,
    input  logic [31:0] rs2_sd_in,   // sd:store_data,ld:load_data
    input  logic [31:0] dram_ld_in, 
    output logic [3:0]  re_out,      // 片选使能
    output logic [3:0]  we_out,      // 片选使能
    output logic [31:0] dram_sd_out,   
    output logic [31:0] rd_ld_out          
);

    // load
    logic ext_val;
    logic [7:0] ext_byte;
    logic [15:0] ext_half;
    always_comb begin : load_sel 
        rd_ld_out = 32'b0;
        re_out = 4'b0000; //永远不要在不读取的时候读取
        
        if(mem_re) begin
            case (funct3[1:0])
                `DRAM_SEL_B: begin
                    ext_byte = (addr[1]) ? ((addr[0]) ? dram_ld_in[31:24] : dram_ld_in[23:16]):
                                            ((addr[0]) ? dram_ld_in[15:8] : dram_ld_in[7:0]) ;
                    ext_val = funct3[2] ? 1'b0 : ext_byte[7]; 
                    rd_ld_out = {{24{ext_val}}, ext_byte};
                    re_out = 4'b1111;
                end

                `DRAM_SEL_H: begin
                    ext_half = (addr[1]) ? dram_ld_in[31:16] : dram_ld_in[15:0];
                    ext_val  = funct3[2] ? 1'b0 : ext_half[15];
                    rd_ld_out = {{16{ext_val}}, ext_half};
                    re_out = 4'b1111;
                end

                `DRAM_SEL_W: begin
                    rd_ld_out = dram_ld_in;
                    re_out = 4'b1111;
                end

                default: begin
                    rd_ld_out = 32'b0;
                    re_out = 4'b0000;
                end
            endcase
        end
    end : load_sel    
    

    // store
    // 由于要选择数据，直接把32位复制多个供选择，we_out提供写使能
    always_comb begin : store_sel
        we_out = 4'b0000;  //永远不要在不写入的时候写入
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
