`timescale 1ns / 1ps

`include "define.vh"

module IF_stage (
    input wire clk,
    input wire rst
    
);

    logic [31:0] present_PC,next_PC;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            present_PC <= 32'h0000_0000;
        end else begin
            present_PC <= next_PC;
        end
    end

    NPC npc(
        .pc(present_PC),
        .npc_op(),  // 这里需要连接控制信号
        .en_branch(),  // 这里需要连接控制信号
        .offset(),  // 这里需要连接立即数
        .alu_num(),  // 这里需要连接ALU的输出
        .npc(next_PC),
        .pc_add4()  // 这里可以连接到其他模块，如果需要的话
    );

    //怎么感觉好多东西都需要重构很多???




endmodule