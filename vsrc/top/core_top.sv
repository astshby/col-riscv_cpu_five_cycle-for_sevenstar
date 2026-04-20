`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2026 08:39:06 PM
// Design Name: 
// Module Name: core_top
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


module core_top(
    input logic clk,
    input logic rst,

    // 连接指令存储器的接口
    output logic [31:0] PC, // 传递给指令存储器(core以外)
    input logic [31:0] instruction_from_memory,
    output logic ena_ins_mem, // 连接指令存储器的使能信号

    // 连接数据存储器的接口
    output logic [31:0] data_store, // MEM阶段要写入数据存储器的数据
    input logic [31:0] data_load,  // 从数据存储器读出的数据
    output logic [31:0] data_addr,  // MEM阶段访问数据存储器的地址
    output logic [3:0] data_we_byte, // MEM阶段访问数据存储器的字节写使能
    output logic mem_ena // MEM阶段访问数据存储器的使能信号
    );

    logic [31:0] instruction_to_ID; 
    logic [31:0] PC_to_ID; 
    logic [31:0] branch_target;
    
    logic [4:0] rs1_addr_from_ID, rs2_addr_from_ID, rd_addr_from_ID;
    logic [31:0] rs1data_from_ID, rs2data_from_ID, imm_from_ID;
    logic [`ALU_OP_WIDTH-1:0] alu_opcode_from_ID;
    logic [`ALUA_SEL_WIDTH-1:0] alua_sel_from_ID;
    logic [`ALUB_SEL_WIDTH-1:0] alub_sel_from_ID;
    logic [`RF_WSEL_WIDTH-1:0] reg_w_sel_from_ID;
    logic reg_write_from_ID, mem_read_from_ID, mem_write_from_ID;
    logic [2:0] func3_from_ID;
    logic [4:0] rs1_addr_to_EX, rs2_addr_to_EX, rd_addr_to_EX;
    logic [31:0] PC_to_EX, rs1data_to_EX, rs2data_to_EX, imm_to_EX;
    logic [`ALU_OP_WIDTH-1:0] alu_opcode_to_EX;
    logic [`ALUA_SEL_WIDTH-1:0] alua_sel_to_EX;
    logic [`ALUB_SEL_WIDTH-1:0] alub_sel_to_EX;
    logic [`RF_WSEL_WIDTH-1:0] reg_w_sel_to_EX;
    logic reg_write_to_EX, mem_read_to_EX, mem_write_to_EX;
    logic [2:0] func3_to_EX;

    logic [31:0] alu_result_from_EX, fwd_rs2data_from_EX;

    logic [31:0] PC_to_MEM, imm_to_MEM;
    logic [4:0] rs2_addr_to_MEM, rd_addr_to_MEM;
    logic [31:0] rs2_data_to_MEM, alu_result_to_MEM;
    logic reg_write_to_MEM, mem_read_to_MEM, mem_write_to_MEM;
    logic [2:0] func3_to_MEM;
    logic [`RF_WSEL_WIDTH-1:0] reg_w_sel_to_MEM;

    logic [31:0] rd_ld_from_MEM;

    logic [31:0] PC_to_WB, alu_result_to_WB, rd_ld_from_WB, imm_to_WB;
    logic reg_write_to_WB;
    logic [`RF_WSEL_WIDTH-1:0] reg_w_sel_to_WB;
    logic [4:0] rd_addr_to_WB;

    logic [31:0] wb_data;

    logic [1:0] forward_A_sel_ID, forward_B_sel_ID;
    logic [1:0] forward_A_sel_EX, forward_B_sel_EX;
    logic forward_data_sel_MEM;
    logic [31:0] forward_data_from_MEM;


    logic use_rs1, use_rs2, is_jump_or_branch, branch_taken;
    logic PC_jump, PC_hold, hold_ID, insert_bubble_to_ID, insert_bubble_to_EX;

    assign ena_ins_mem = ~hold_ID;

    IF_stage IF_stage(
        .clk(clk),
        .rst(rst),
        .hold(PC_hold),
        .jump(PC_jump),
        .jump_addr(branch_target),
        .present_PC(PC)// 传递给IF/ID寄存器
    );

    IF_ID_pipe IF_ID_pipe(
        .clk(clk),
        .rst(rst),
        .insert_bubble_to_ID(insert_bubble_to_ID),
        .hold_ID(hold_ID),
        .in_instruction(instruction_from_memory),
        .in_pc(PC),
        .out_instruction(instruction_to_ID),
        .out_pc(PC_to_ID)
    );

    ID_stage ID_stage(
        .clk(clk),
        .rst(rst),

        .instruction(instruction_to_ID), // 来自IF/ID寄存器的指令
        .pc(PC_to_ID), // 来自IF/ID寄存器的PC值
        .branch_target(branch_target), // 分支单元计算得到的分支目标地址，传递给IF阶段

        .rd_addr_WB(rd_addr_to_WB), 
        .rd_data_WB(wb_data), 
        .wen(reg_write_to_WB), 

        .use_rs1(use_rs1),
        .use_rs2(use_rs2),
        .is_jump_or_branch(is_jump_or_branch),
        .branch_taken(branch_taken),

        .forward_data_from_MEM(forward_data_from_MEM),
        .forward_A_sel_ID(forward_A_sel_ID),
        .forward_B_sel_ID(forward_B_sel_ID),

        .rs1_addr(rs1_addr_from_ID), // 从指令中解析得到的源寄存器地址 rs1
        .rs2_addr(rs2_addr_from_ID), // 从指令中解析得到的源寄存器地址 rs2
        .rd_addr(rd_addr_from_ID), // 从指令中解析得到的目标寄存器地址
        .rs1data_from_regfile(rs1data_from_ID), // 从寄存器堆读出的trs1数据(有WB穿透)
        .rs2data_from_regfile(rs2data_from_ID), // 从寄存器堆读出的rs2数据
        .imm(imm_from_ID),
        .alu_opcode(alu_opcode_from_ID),
        .alua_sel(alua_sel_from_ID),
        .alub_sel(alub_sel_from_ID),
        .reg_w_sel(reg_w_sel_from_ID),
        .reg_write(reg_write_from_ID),
        .mem_read(mem_read_from_ID),
        .mem_write(mem_write_from_ID),
        .func3(func3_from_ID)
    );

    ID_EX_pipe ID_EX_pipe(
        .clk(clk),
        .rst(rst),
        .insert_bubble_to_EX(insert_bubble_to_EX),
        .hold_EX(1'b0), // 目前不考虑保持EX阶段不变的情况，后续如果需要可以添加hold_EX信号

        .in_PC(PC_to_ID),
        .in_rs1_addr(rs1_addr_from_ID),
        .in_rs2_addr(rs2_addr_from_ID),
        .in_rd_addr(rd_addr_from_ID),
        .in_rs1data(rs1data_from_ID),
        .in_rs2data(rs2data_from_ID),
        .in_imm(imm_from_ID),
        .in_alu_opcode(alu_opcode_from_ID),
        .in_alua_sel(alua_sel_from_ID),
        .in_alub_sel(alub_sel_from_ID),
        .in_reg_w_sel(reg_w_sel_from_ID),
        .in_reg_write(reg_write_from_ID),
        .in_mem_read(mem_read_from_ID),
        .in_mem_write(mem_write_from_ID),
        .in_func3(func3_from_ID),

        .out_PC(PC_to_EX),
        .out_rs1_addr(rs1_addr_to_EX),
        .out_rs2_addr(rs2_addr_to_EX),
        .out_rd_addr(rd_addr_to_EX), 
        .out_rs1data(rs1data_to_EX),
        .out_rs2data(rs2data_to_EX),
        .out_imm(imm_to_EX),
        .out_alu_opcode(alu_opcode_to_EX),
        .out_alua_sel(alua_sel_to_EX),
        .out_alub_sel(alub_sel_to_EX),
        .out_reg_w_sel(reg_w_sel_to_EX),
        .out_reg_write(reg_write_to_EX),
        .out_mem_read(mem_read_to_EX),
        .out_mem_write(mem_write_to_EX),
        .out_func3(func3_to_EX)
    );

    EX_stage EX_stage(
        .PC(PC_to_EX),
        .rs1data(rs1data_to_EX),
        .rs2data(rs2data_to_EX),
        .imm(imm_to_EX),
        .alu_opcode(alu_opcode_to_EX),
        .alua_sel(alua_sel_to_EX),
        .alub_sel(alub_sel_to_EX),

        .forward_A_sel_EX(forward_A_sel_EX), // 来自 Forwarding Unit 的控制信号
        .forward_B_sel_EX(forward_B_sel_EX), // 来自 Forwarding Unit 的控制信号
        .forward_data_from_MEM(forward_data_from_MEM), // 来自 MEM 阶段的最新数据 (通常是 ALU 结果或 Load 的数据)
        .forward_data_from_WB(wb_data),  // 来自 WB 阶段的最新数据 (通常是 ALU 结果或 Load 的数据)

        .alu_result(alu_result_from_EX), // ALU 运算结果，传递给 EX/MEM 寄存器
        .forwarded_rs2data_to_store(fwd_rs2data_from_EX) // 修正后的 rs2 数据，传递给 EX/MEM 寄存器 (用于 Store 指令)
    );

    EX_MEM_pipe EX_MEM_pipe(
        .clk(clk),
        .rst(rst),

        .in_PC(PC_to_EX),   
        .in_rd_addr(rd_addr_to_EX),
        .in_rs2_addr(rs2_addr_to_EX),
        .in_rs2_data(fwd_rs2data_from_EX), // 来自 EX 阶段的 rs2 数据 (可能被前递单元修正过)
        .in_alu_result(alu_result_from_EX), // 来自 EX 阶段的 ALU 结果
        .in_reg_write(reg_write_to_EX),
        .in_reg_w_sel(reg_w_sel_to_EX),
        .in_mem_read(mem_read_to_EX),
        .in_mem_write(mem_write_to_EX),
        .in_func3(func3_to_EX),
        .in_imm(imm_to_EX),


        .out_PC(PC_to_MEM),
        .out_rd_addr(rd_addr_to_MEM), 
        .out_rs2_addr(rs2_addr_to_MEM),
        .out_rs2_data(rs2_data_to_MEM), // 传递给 MEM 阶段的 rs2 数据 (用于 Store 指令)
        .out_alu_result(alu_result_to_MEM), // 传递给 MEM 阶段的 ALU 结果 mem的地址
        .out_reg_write(reg_write_to_MEM),
        .out_reg_w_sel(reg_w_sel_to_MEM),
        .out_mem_read(mem_read_to_MEM),
        .out_mem_write(mem_write_to_MEM),
        .out_func3(func3_to_MEM),
        .out_imm(imm_to_MEM)
    );

    MEM_stage MEM_stage(
        .mem_re(mem_read_to_MEM),    // MEM阶段是否要读数据存储器 (由控制单元生成)
        .mem_we(mem_write_to_MEM),    // MEM阶段是否要写数据存储器 (由控制单元生成)
        .funct3(func3_to_MEM), // MEM阶段指令的 funct3 字段 (由控制单元生成,通常是 ALU 操作码的最低三位)
        .alu_result(alu_result_to_MEM),      // MEM阶段访问数据存储器的地址 (来自 EX/MEM 寄存器的 ALU 结果)
        .rs2_sd_in(rs2_data_to_MEM),    // MEM阶段准备写入的数据 (store_data, WB前递或EX/MEM寄存器的rs2数据)
        .rd_ld_out(rd_ld_from_MEM),  // 从 BRAM 读出的原始 32 位数据经过处理后给寄存器的数据 (传回 EX_MEM_pipe 再传给 WB阶段)

        .PC(PC_to_MEM),
        .imm(imm_to_MEM),
        .reg_w_sel(reg_w_sel_to_MEM),
        .forward_data_output(forward_data_from_MEM),

        .forward_data_sel_MEM(forward_data_sel_MEM), // 来自 Forwarding Unit 的控制信号
        .wb_data(wb_data), // 来自 WB 阶段的前递数据

        .data_store(data_store),
        .data_load(data_load),
        .data_addr(data_addr),
        .data_we_byte(data_we_byte),
        .mem_ena(mem_ena)

    );

    MEM_WB_pipe MEM_WB_pipe(
        .clk(clk),
        .rst(rst),

        .in_PC(PC_to_MEM),
        .in_alu_result(alu_result_to_MEM), //  ALU 结果 
        .in_rd_ld(rd_ld_from_MEM), //  Load 数据
        .in_imm(imm_to_MEM), //  立即数
        .in_reg_write(reg_write_to_MEM), // 寄存器写使能
        .in_reg_w_sel(reg_w_sel_to_MEM), // 寄存器写回选择信号
        .in_rd_addr(rd_addr_to_MEM), // 来自 MEM 阶段的目的寄存器地址

        .out_PC(PC_to_WB), // 传递给 WB 阶段 (如果 WB 阶段需要 PC，可以从这里获取)
        .out_alu_result(alu_result_to_WB), // 传递给 WB 阶段的 ALU 结果
        .out_rd_ld(rd_ld_from_WB), // 传递给 WB 阶段的 Load 数据
        .out_imm(imm_to_WB), // 传递给 WB 阶段的立即数
        .out_reg_write(reg_write_to_WB), // 传递给 WB 阶段的寄存器写使能
        .out_reg_w_sel(reg_w_sel_to_WB), // 传递给 WB 阶段的寄存器写回选择信号
        .out_rd_addr(rd_addr_to_WB) // 传递给 WB 阶段的目的寄存器地址

    );

    WB_stage WB_stage(
        .PC(PC_to_WB), // 来自 MEM/WB 寄存器的 PC (如果 WB 阶段需要 PC，可以从这里获取)
        .alu_result(alu_result_to_WB), // 来自 MEM/WB 寄存器的 ALU 结果
        .rd_ld(rd_ld_from_WB), // 来自 MEM/WB 寄存器的 Load 数据
        .imm(imm_to_WB), // 来自 MEM/WB 寄存器的立即数
        .reg_w_sel(reg_w_sel_to_WB), // 来自 MEM/WB 寄存器的寄存器写回选择信号
        
        .wb_data(wb_data) // 最终决定写回寄存器的 32 位数据，传递给寄存器堆和 Forwarding Unit
    );

    Pipeline_Control_Unit pipeline_control_unit(
        .rs1_addr_ID(rs1_addr_from_ID),
        .rs2_addr_ID(rs2_addr_from_ID),
        .use_rs1_ID(use_rs1), // 由 ID_stage 根据指令类型和 rs1_addr 是否为 0 来生成
        .use_rs2_ID(use_rs2), // 由 ID_stage 根据指令类型和 rs2_addr 是否为 0 来生成
        .is_jump_or_branch_ID(is_jump_or_branch), // 由 ID_stage 根据指令 opcode 判断是否是跳转或分支指令
        .branch_taken_raw(branch_taken), // 由 ID_stage 的分支单元计算得到的原始分支跳转请求

        .rd_addr_EX(rd_addr_to_EX), // 来自 EX 阶段的目的寄存器地址 rd (ID/EX 寄存器传递)
        .mem_read_EX(mem_read_to_EX), // 来自 EX 阶段的 mem_read 信号 (ID/EX 寄存器传递)
        .reg_write_EX(reg_write_to_EX), // 来自 EX 阶段的 reg_write 信号 (ID/EX 寄存器传递)

        .rd_addr_MEM(rd_addr_to_MEM), // 来自 MEM 阶段的目的寄存器地址 rd (EX/MEM 寄存器传递)
        .mem_read_MEM(mem_read_to_MEM), // 来自 MEM 阶段的 mem_read 信号 (EX/MEM 寄存器传递)

        .PC_jump(PC_jump),
        .PC_hold(PC_hold),
        .ID_hold(hold_ID),
        .insert_bubble_to_ID(insert_bubble_to_ID),
        .insert_bubble_to_EX(insert_bubble_to_EX)
    );

    Forwarding_Control_Unit forwarding_control_unit(
        .rs1_addr_ID(rs1_addr_from_ID), // 来自 ID 阶段的源寄存器地址 rs1
        .rs2_addr_ID(rs2_addr_from_ID), // 来自 ID 阶段的源寄存器地址 rs2
        .rs1_addr_EX(rs1_addr_to_EX),   // 来自 EX 阶段的源寄存器地址 rs1 (ID/EX 寄存器传递)
        .rs2_addr_EX(rs2_addr_to_EX),   // 来自 EX 阶段的源寄存器地址 rs2 (ID/EX 寄存器传递)
        .rs2_addr_MEM(rs2_addr_to_MEM),  // 来自 MEM 阶段的源寄存器地址 rs2 (EX/MEM 寄存器传递)

        .rd_addr_MEM(rd_addr_to_MEM),   // 来自 MEM 阶段的目的寄存器地址 rd (EX/MEM 寄存器传递)
        .reg_write_MEM(reg_write_to_MEM), // 来自 MEM 阶段的寄存器写使能 (EX/MEM 寄存器传递)
        .rd_addr_WB(rd_addr_to_WB),    // 来自 WB 阶段的目的寄存器地址 rd (MEM/WB 寄存器传递)
        .reg_write_WB(reg_write_to_WB),  // 来自 WB 阶段的寄存器写使能 (MEM/WB 寄存器传递)

        .forward_A_sel_ID(forward_A_sel_ID), // 传递给 ID 阶段的旁路选择信号 (用于分支指令的比较)
        .forward_B_sel_ID(forward_B_sel_ID), // 传递给 ID 阶段的旁路选择信号 (用于分支指令的比较)
        .forward_A_sel_EX(forward_A_sel_EX), // 传递给 EX 阶段的旁路选择信号
        .forward_B_sel_EX(forward_B_sel_EX), // 传递给 EX 阶段的旁路选择信号
        .forward_data_sel_MEM(forward_data_sel_MEM) // 传递给 MEM 阶段的旁路选择信号

    );


endmodule