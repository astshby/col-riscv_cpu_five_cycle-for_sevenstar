`timescale 1ns / 1ps

`include "define.vh"

module WB_stage(
    // -----------------------------------------
    // 输入：来自 MEM/WB 流水线寄存器
    // -----------------------------------------
    input  logic [`REG_WIDTH-1:0] PC,
    input  logic [`REG_WIDTH-1:0] alu_result,
    input  logic [`REG_WIDTH-1:0] imm,
    input  logic [2:0]  funct3,     // Load 字节提取控制

    input  logic [`RF_WSEL_WIDTH-1:0] reg_w_sel,
    input  logic [`REG_WIDTH-1:0] csr_data_old,  // CSR 旧值 (RF_WSEL_CSR 写回 rd)

    // 输入：来自 BRAM 的原始读出数据 (不经过 MEM_WB_pipe，BRAM 内部寄存器即流水寄存器)
    input  logic [`REG_WIDTH-1:0] data_load,

    // 输出：送往 ID 阶段 (写入寄存器堆) 和 Forwarding Unit
    output logic [`REG_WIDTH-1:0] wb_data
);

    // Load 数据提取 (mem_mux_l: LB/LBU/LH/LHU/LW)
    logic [`REG_WIDTH-1:0] load_data;

    mem_mux_l mem_mux_l(
        .funct3(funct3),
        .addr(alu_result[1:0]),
        .dram_ld_in(data_load),
        .rd_ld_out(load_data)
    );

    // 写回多路选择器
    logic [`REG_WIDTH-1:0] pc4;
    assign pc4 = PC + 32'd4;

    regfile_wd_MUX regfile_wd_MUX_inst(
        .rf_wsel       (reg_w_sel),
        .DRAM_wb       (load_data),
        .alu_c         (alu_result),
        .pc4           (pc4),
        .sext          (imm),
        .csr_data_old  (csr_data_old),
        .wd            (wb_data)
    );

endmodule
