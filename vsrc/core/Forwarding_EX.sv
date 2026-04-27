`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/19/2026 02:38:03 AM
// Design Name:
// Module Name: Forwarding_MUX_Unit_EX
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


module Forwarding_EX(
    input logic [1:0]  forward_A_sel_EX,
    input logic [1:0]  forward_B_sel_EX,

    input logic [`REG_WIDTH-1:0] original_rs1data,
    input logic [`REG_WIDTH-1:0] original_rs2data,

    input logic [`REG_WIDTH-1:0] forward_data_from_WB,
    input logic [`REG_WIDTH-1:0] forward_data_from_MEM,

    output logic [`REG_WIDTH-1:0] forwarded_rs1data,
    output logic [`REG_WIDTH-1:0] forwarded_rs2data
);

    always_comb begin
        case (forward_A_sel_EX)
            `FWD_ORIG: forwarded_rs1data = original_rs1data;       
            `FWD_WB: forwarded_rs1data = forward_data_from_WB;   
            `FWD_MEM: forwarded_rs1data = forward_data_from_MEM;  
            default: forwarded_rs1data = original_rs1data;
        endcase
    end

    always_comb begin
        case (forward_B_sel_EX)
            `FWD_ORIG: forwarded_rs2data = original_rs2data;
            `FWD_WB: forwarded_rs2data = forward_data_from_WB;
            `FWD_MEM: forwarded_rs2data = forward_data_from_MEM;
            default: forwarded_rs2data = original_rs2data;
        endcase
    end

endmodule
