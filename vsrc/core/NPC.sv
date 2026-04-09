`timescale 1ns / 1ps

`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2026 06:12:07 PM
// Design Name: 
// Module Name: NPC
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

module NPC(
    input logic [31:0] pc,
    input logic [1:0] npc_op,  // 控制信号一定得有
    input logic en_branch,  //npc_op在解码就发出，这个用于判断是否跳转
    input logic [31:0] offset,  //B与jal的都要过Sext，就用这个了
    input logic [31:0] alu_num,  //jarl专供
    output logic [31:0] npc,    
    output logic [31:0] pc_add4  // for jal，jalr，auipc

    );

    logic [31:0] pc_offset;
    assign pc_add4 = pc + 32'h4;
    assign pc_offset = pc + offset;   //虽然消耗面积，但是更快

    always_comb begin : pc_next_comb
        case(npc_op)
            `NPC_SEL_NEXT: npc = pc_add4;
            `NPC_SEL_BRANCH: begin
                if(en_branch) npc = pc_offset;
                else npc = pc_add4;
            end
            `NPC_SEL_ALU: npc = alu_num;
            `NPC_SEL_JAL: npc = pc_offset;
            default: npc = pc_add4;
        endcase 
    end : pc_next_comb

endmodule
