`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2026 08:25:29 PM
// Design Name: 
// Module Name: regfile_wd_MUX
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


module regfile_wd_MUX(
    input [`RF_WSEL_WIDTH-1:0] rf_wsel,
    input [`REG_WIDTH-1:0] DRAM_wb,
    input [`REG_WIDTH-1:0] alu_c,
    input [`REG_WIDTH-1:0] pc4,
    input [`REG_WIDTH-1:0] sext,
    input [`REG_WIDTH-1:0] csr_data_old,  // CSR 旧值 (写回 rd)
    output reg [`REG_WIDTH-1:0] wd
    );

    always @(*) begin
        case (rf_wsel)
            `RF_WSEL_ALUC: wd = alu_c;
            `RF_WSEL_DRAM: wd = DRAM_wb;
            `RF_WSEL_PC4:  wd = pc4;
            `RF_WSEL_SEXT: wd = sext;
            `RF_WSEL_CSR:  wd = csr_data_old;
            default: wd = 0;
        endcase
    end
endmodule
