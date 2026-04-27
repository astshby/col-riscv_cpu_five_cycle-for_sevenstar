`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/19/2026 01:54:42 PM
// Design Name:
// Module Name: Forwarding_ID
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


module Forwarding_ID(
    // --- GPR 前递控制信号 (来自 Forwarding_Control_Unit) ---
    input  logic [1:0]  forward_A_sel_ID,     // 控制 rs1 的选择
    input  logic [1:0]  forward_B_sel_ID,     // 控制 rs2 的选择

    // --- GPR 数据源 ---
    input  logic [`REG_WIDTH-1:0] original_rs1data,     // 原路径数据 (刚从 Regfile 读出的 rs1)
    input  logic [`REG_WIDTH-1:0] original_rs2data,     // 原路径数据 (刚从 Regfile 读出的 rs2)
    input  logic [`REG_WIDTH-1:0] forward_data_from_WB, // 次新数据 (来自 WB 阶段)
    input  logic [`REG_WIDTH-1:0] forward_data_from_MEM,// 最新数据 (来自 MEM 阶段)

    // --- GPR 输出 (给 Branch Unit) ---
    output logic [`REG_WIDTH-1:0] forwarded_rs1data,    // 修正后的 rs1 数据
    output logic [`REG_WIDTH-1:0] forwarded_rs2data,    // 修正后的 rs2 数据

    // --- CSR 前递 (EX > MEM > WB > csrFile, 零 stall) ---
    input  logic [`REG_WIDTH-1:0] csr_raw_data,          // csrFile 直接读出的值
    input  logic [`CSR_ADDR_WIDTH-1:0] csr_addr_ID,      // 当前 ID 阶段 CSR 读地址
    // 来自 EX 阶段
    input  logic csr_we_EX,
    input  logic [`CSR_ADDR_WIDTH-1:0] csr_addr_EX,
    input  logic [`REG_WIDTH-1:0] csr_result_new_EX,
    // 来自 MEM 阶段
    input  logic csr_we_MEM,
    input  logic [`CSR_ADDR_WIDTH-1:0] csr_addr_MEM,
    input  logic [`REG_WIDTH-1:0] csr_result_new_MEM,
    // 来自 WB 阶段
    input  logic csr_we_WB,
    input  logic [`CSR_ADDR_WIDTH-1:0] csr_addr_WB,
    input  logic [`REG_WIDTH-1:0] csr_result_new_WB,
    // CSR 输出
    output logic [`REG_WIDTH-1:0] csr_data_old           // 前递后的 CSR 旧值
);

    // ==========================================
    // GPR rs1 旁路选择
    // ==========================================
    always_comb begin
        case (forward_A_sel_ID)
            `FWD_ORIG: forwarded_rs1data = original_rs1data;       // 原路返回
            `FWD_WB:   forwarded_rs1data = forward_data_from_WB;   // 旁路 WB
            `FWD_MEM:  forwarded_rs1data = forward_data_from_MEM;  // 旁路 MEM
            default:   forwarded_rs1data = original_rs1data;
        endcase
    end

    // ==========================================
    // GPR rs2 旁路选择
    // ==========================================
    always_comb begin
        case (forward_B_sel_ID)
            `FWD_ORIG: forwarded_rs2data = original_rs2data;
            `FWD_WB:   forwarded_rs2data = forward_data_from_WB;
            `FWD_MEM:  forwarded_rs2data = forward_data_from_MEM;
            default:   forwarded_rs2data = original_rs2data;
        endcase
    end

    // ==========================================
    // CSR 前递多路选择 (csrFile 无写穿透，必须前递)
    //   优先级: EX > MEM > WB > csrFile
    // ==========================================
    always_comb begin
        if (csr_we_EX && (csr_addr_EX == csr_addr_ID))
            csr_data_old = csr_result_new_EX;
        else if (csr_we_MEM && (csr_addr_MEM == csr_addr_ID))
            csr_data_old = csr_result_new_MEM;
        else if (csr_we_WB && (csr_addr_WB == csr_addr_ID))
            csr_data_old = csr_result_new_WB;
        else
            csr_data_old = csr_raw_data;
    end

endmodule