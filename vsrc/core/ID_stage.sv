`timescale 1ns / 1ps

`include "define.vh"

module ID_stage (
    input logic clk,
    input logic rst,
    input logic [31:0] instruction, // 来自IF/ID寄存器的指令
    input logic [31:0] pc,          // 来自IF/ID寄存器
    input logic [4:0]  rd_addr_WB,       // 来自WB阶段的写回数据
    input logic [31:0] rd_data_WB,       // 来自WB阶段的写回数据
    input logic wen,                // 来自WB阶段的写使能

    // 来自EX阶段的信息 用于前递给branch单元 用于判断load-use冒险
    input logic reg_write_EX,
    input logic mem_read_EX,
    input logic [4:0] rd_addr_EX,
    input logic [31:0] alu_result_EX,

    // 来自MEM阶段的信息 用于前递给branch单元 用于判断load-use冒险
    input logic reg_write_MEM,
    input logic mem_read_MEM,
    input logic [4:0] rd_addr_MEM,
    input logic [31:0] result_MEM,

    output logic [31:0] rs1data_from_regfile, // 从寄存器堆读出的trs1数据传向
    output logic [31:0] rs2data_from_regfile, // 从寄存器堆读出的rs2数据
    output logic [31:0] imm,

    output logic branch_taken,  // 分支单元的分支结果，传递给IF阶段和IF/ID寄存器 让IF更新 让ID阶段插入气泡
    output logic [31:0] branch_target // 分支单元计算得到的分支目标地址，传递给IF阶段

);

    logic [31:0] rs1data_after_forwarding; // 前递单元处理后的rs1数据，传递给分支单元进行比较
    logic [31:0] rs2data_after_forwarding; // 前递单元处理后的rs2数据，传递给分支单元进行比较
    logic lu_conflict_from_branch_forwarding; // 来自分支前递单元的Load-Use冒险冲突信号，传递给IF/ID寄存器以插入气泡

    // 现在还没想好得出lu冒险以后怎么发出控制信号
    // branch_taken 这个也没有想好
    // 其他的译码模块还没有做出来呢

    // 寄存器堆 (具有内部数据穿透功能)
    regfile regfile(
        .clk(clk),
        .rst(rst),
        .rs1addr(instruction[19:15]),
        .rs2addr(instruction[24:20]),
        .rdaddr(rd_addr_WB),
        .wdata(rd_data_WB),
        .wen(wen),
        .rs1data(rs1data_from_regfile),
        .rs2data(rs2data_from_regfile)
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
        .rs1data(rs1data_after_forwarding), // 连接分支前递单元的输出，确保分支单元使用前递后的数据进行比较
        .rs2data(rs2data_after_forwarding),//这两个应该接上前递单元的多选的结果
        .imm(imm),
        .branch_taken(branch_taken),
        .branch_target(branch_target)
    );

    // 分支前递单元 (解决分支指令的前递和产生 Load-Use 停顿)
    branch_forwarding_unit branch_forwarding_unit(
        // 来自 ID 阶段的信息
        .instruction_ID(instruction),
        .rs1_data_regfile(rs1data_from_regfile), // 直接使用寄存器堆输出的原始数据，前递单元内部会处理
        .rs2_data_regfile(rs2data_from_regfile), // 直接使用寄存器堆输出的原始数据，前递单元内部会处理
        // EX 阶段信息 (需要从EX阶段的ID/EX寄存器中获取，这里只是示例信号)
        .reg_write_EX(reg_write_EX), // EX阶段指令是否写寄存器
        .mem_read_EX(mem_read_EX),  // EX阶段指令是否是Load
        .rd_addr_EX(rd_addr_EX),   // EX阶段指令的目的寄存器地址
        .alu_result_EX(alu_result_EX),// EX阶段的ALU结果（用于前递）
        // MEM 阶段信息 (需要从MEM阶段的EX/MEM寄存器中获取，这里只是示例信号)
        .reg_write_MEM(reg_write_MEM), // MEM阶段指令是否写寄存器
        .mem_read_MEM(mem_read_MEM),  // MEM阶段指令是否是Load
        .rd_addr_MEM(rd_addr_MEM),   // MEM阶段指令的目的寄存器地址
        .result_MEM(result_MEM),    // MEM阶段的结果（用于前递）
        // 输出到分支单元和ID阶段其他部分
        .rs1_forwarded_ID(rs1data_after_forwarding), // 前递后的RS1数据，直接覆盖原始数据输出
        .rs2_forwarded_ID(rs2data_after_forwarding), // 前递后的RS2数据，直接覆盖原始数据输出
        .lu_conflict_from_branch_forwarding(lu_conflict_from_branch_forwarding) // Load-Use冒险冲突信号，传递给ID阶段以插入气泡
    );

endmodule

//对于load-use冒险,如果ID阶段是use指令,EX阶段是load指令,则需要在ID阶段插入一个气泡,保持住use指令不动,让load指令先执行完,解决冒险
//这个里面需要实现具体的逻辑是在IF_ID解析出ID当前是use ID_EX解析出EX当前是load,如果满足条件就发出insert_bubble_to_ID信号,
//让IF_ID在下一个周期插入一个气泡,保持住use指令不动,让load指令先执行完,解决冒险
//也能设置一个寄存器 就存一下上一个是不是load(到时候看时序)
