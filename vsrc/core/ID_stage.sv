`timescale 1ns / 1ps

`include "define.vh"

module ID_stage (
    input logic clk,
    input logic rst,
    input logic [31:0] instruction, // 来自IF/ID寄存器的指令
    input logic [31:0] pc, // 来自IF/ID寄存器
    input logic [31:0] wdata, // 来自WB阶段的写回数据
    input logic wen, // 来自WB阶段的写使能

    output logic [31:0] rs1data,
    output logic [31:0] rs2data,
    output logic [31:0] imm,

    output logic branch_taken,  // 分支单元的分支结果，传递给IF阶段和IF/ID寄存器
                                // 让IF更新 让ID阶段插入气泡
    output logic [31:0] branch_target // 分支单元计算得到的分支目标地址，传递给IF阶段

);


    // 寄存器堆 (具有内部数据穿透功能)
    regfile regfile(
        .clk(clk),
        .rst(rst),
        .rs1addr(instruction[19:15]),
        .rs2addr(instruction[24:20]),
        .rdaddr(instruction[11:7]),
        .wdata(wdata),
        .wen(wen),
        .rs1data(rs1data),
        .rs2data(rs2data)
    );


    // 立即数生成模块 (直接从指令中解析出立即数)
    gen_imm gen_imm(
        .instruction(instruction),
        .imm_out(imm)
    );

    // 分支单元 (计算是否分支和目标地址)
    branch_unit branch_unit(
        .inst(instruction),
        .pc(pc),
        .rs1data(),
        .rs2data(),//这两个应该接上前递单元的多选的结果
        .imm(imm),
        .branch_taken(branch_taken),
        .branch_target(branch_target)
    );

endmodule

//对于load-use冒险,如果ID阶段是use指令,EX阶段是load指令,则需要在ID阶段插入一个气泡,保持住use指令不动,让load指令先执行完,解决冒险
//这个里面需要实现具体的逻辑是在IF_ID解析出ID当前是use ID_EX解析出EX当前是load,如果满足条件就发出insert_bubble_to_ID信号,
//让IF_ID在下一个周期插入一个气泡,保持住use指令不动,让load指令先执行完,解决冒险
//也能设置一个寄存器 就存一下上一个是不是load(到时候看时序)
