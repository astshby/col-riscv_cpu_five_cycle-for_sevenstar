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

    // 连接指令输入和PC输出 ROM
    input logic [31:0] inst,
    output logic [31:0] pc,

    //连接数据输入输出 RAM
    input logic [31:0] dram_ld_in, // 从dram读出的数据
    output logic [31:0] dram_sd_out, // 要写入dram的数据
    output logic [3:0]  dram_we_out, // dram的字节写使能
    output logic [31:0] dram_addr_out, // dram地址输出
    output logic dram_we, // dram写使能
    output logic dram_re // dram读使能

    );

    assign dram_addr_out = {alu_c[31:2], 2'b0}; // 内存地址由ALU计算结果提供

    // PC相关信号
    logic [31:0] npc, pc_add4;
    logic [1:0] npc_op;

    // PC模块
    PC pc_module(
        .clk(clk),
        .rst(rst),
        .npc(npc),
        .pc(pc) 
    );


    // NPC模块
    NPC npc_module(
        .pc(pc),
        .npc_op(npc_op),  // 连接NPC操作信号
        .en_branch(alu_c[0]),  // B类型指令的分支使能信号 ALU计算的最低位
        .offset(imm),  // jal 连接立即数输出 PC = PC + offset
        .alu_num(alu_c),  // jalr 连接ALU结果信号 PC = rs1 + offset
        .npc(npc),
        .pc_add4(pc_add4)  // 可以连接到其他模块需要PC+4的地方
    );

    // Control模块
    control control_module(
        .opcode(inst[6:0]),  // 从指令中提取opcode
        .gen_imm_op(gen_imm_op),  // 连接立即数生成操作信号
        .npc_op(npc_op),  // 连接NPC操作信号
        .alu_sel(alu_sel),  // 连接ALU选择信号
        .alua_sel(alua_sel),  // 连接ALU A输入选择信号
        .alub_sel(alub_sel),  // 连接ALU B输入选择信号
        .reg_w_sel(reg_w_sel),  // 连接寄存器写入数据选择信号
        .reg_we(reg_we),  // 连接寄存器写使能信号
        .dram_re(dram_re),  // 连接DRAM读使能信号
        .dram_we(dram_we)   // 连接DRAM写使能信号
    );


    // 立即数信号
    logic [31:0] imm;
    logic [`Sext_OP_WIDTH-1:0] gen_imm_op; // 连接立即数生成操作信号

    // 立即数生成模块
    gen_imm gen_imm_module(
        .inst(inst[31:7]),  // 连接指令的相关部分
        .gen_imm_op(gen_imm_op),  // 连接立即数生成操作信号
        .imm(imm)  // 连接立即数输出信号
    );


    // 寄存器文件相关信号
    logic [31:0] rs1data, rs2data, wdata; // 寄存器文件的输入输出信号
    logic reg_we; // 寄存器写使能信号
    logic [`RF_WSEL_WIDTH-1:0] reg_w_sel; // 寄存器写入数据选择信号

    // regfile模块
    regfile regfile_module(
        .clk(clk),
        .rst(rst),
        .rs1addr(inst[19:15]),  // 连接指令中的rs1地址
        .rs2addr(inst[24:20]),  // 连接指令中的rs2地址
        .rdaddr(inst[11:7]),  // 连接指令中的rd地址
        .wdata(wdata),  // 连接写入寄存器的数据
        .wen(reg_we),  // 连接寄存器写使能信号
        .rs1data(rs1data),  // 连接寄存器文件的rs1数据输出
        .rs2data(rs2data)   // 连接寄存器文件的rs2数据输出
    );

    // regfile模块的写数据选择逻辑
    regfile_wd_MUX regfile_wd_mux_moudle(
        .rf_wsel(reg_w_sel),  // 连接寄存器写入数据选择信号
        .DRAM_wb(rd_ld_out),  // 连接从DRAM读出的数据
        .alu_c(alu_c),  // 连接ALU计算结果
        .pc4(pc_add4),  // 连接PC+4的值
        .sext(imm),  // 连接立即数（经过符号扩展）
        .wd(wdata)  // 连接寄存器文件的写数据输出
    );


    // ALU信号
    logic [`ALU_OP_WIDTH-1:0] alu_op;
    logic [31:0] alua, alub, alu_c; // ALU输入和输出信号
    logic [`ALUA_SEL_WIDTH-1:0] alua_sel, alub_sel; // ALU A和B输入选择信号
    logic [`ALU_SEL_WIDTH-1:0] alu_sel; // ALU操作选择信号

    // ALU模块
    alu alu_module(
        .alu_opcode(alu_op),  // 连接ALU操作码输出
        .A(alua),  // 连接ALU A输入
        .B(alub),  // 连接ALU B输入
        .result(alu_c)  // 连接ALU计算结果输出
    );

    // ALU输入选择逻辑
    alu_mux alu_mux_module(
        .rd1(rs1data),  // 连接寄存器文件的rs1数据输出
        .rd2(rs2data),  // 连接寄存器文件的rs2数据输出
        .pc(pc),  // 连接当前PC值
        .gen_imm(imm),  // 连接立即数（经过符号扩展）
        .alua_sel(alua_sel),  // 连接ALU A输入选择信号
        .alub_sel(alub_sel),  // 连接ALU B输入选择信号
        .A(alua),  // 连接ALU A输入
        .B(alub)   // 连接ALU B输入
    );

    // ALU操作码生成模块
    alu_op alu_op_module(
        .opcode_6(inst[5]),  // 连接指令中的opcode的第6位（区分R型和I型）
        .funct3(inst[14:12]),  // 连接指令中的funct3字段
        .funct7(inst[31:25]),  // 连接指令中的funct7字段
        .alu_sel(alu_sel),  // 连接ALU选择信号
        .alu_opcode(alu_op)  // 连接ALU操作码输出
    );
    

    // mem_mux模块相关信号
    logic dram_re; // DRAM读写使能信号
    logic [31:0] rd_ld_out; // 从DRAM读出的数据输出
    logic [3:0] dram_re_out; // DRAM字节读使能输出

    // 内存访问选择模块
    mem_mux mem_mux_module(
        .mem_re(dram_re),  // 连接DRAM读使能信号
        .mem_we(dram_we),  // 连接DRAM写使能信号
        .funct3(inst[14:12]),  // 连接指令中的funct3字段
        .addr(alu_c[1:0]),  // 连接ALU计算结果的最低两位作为地址偏移
        .rs2_sd_in(rs2data),  // 连接寄存器文件的rs2数据输出作为store数据输入
        .dram_ld_in(dram_ld_in),  // 连接从DRAM读出的数据
        .we_out(dram_we_out),  // 连接DRAM字节片选使能
        .re_out(dram_re_out),  // 连接DRAM字节读使能
        .dram_sd_out(dram_sd_out),  // 连接要写入DRAM的数据输出
        .rd_ld_out(rd_ld_out)  // 连接从DRAM读出的数据输出（经过处理）
    );

endmodule