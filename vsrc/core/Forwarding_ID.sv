`timescale 1ns / 1ps
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
// --- 控制信号 (来自全局 Forwarding_Unit) ---
    input  logic [1:0]  forward_A_sel_ID,     // 控制 rs1 的选择
    input  logic [1:0]  forward_B_sel_ID,     // 控制 rs2 的选择

    // --- 数据源 ---
    input  logic [31:0] original_rs1data,     // 原路径数据 (刚从 Regfile 读出的 rs1)
    input  logic [31:0] original_rs2data,     // 原路径数据 (刚从 Regfile 读出的 rs2)
    
    input  logic [31:0] forward_data_from_WB, // 次新数据 (来自 WB 阶段准备写回的数据)
    input  logic [31:0] forward_data_from_MEM,// 最新数据 (来自 MEM 阶段的 ALU 结果等)

    // --- 输出给 Branch Unit 的数据 ---
    output logic [31:0] forwarded_rs1data,    // 修正后的 rs1 数据
    output logic [31:0] forwarded_rs2data     // 修正后的 rs2 数据
);

    // ==========================================
    // rs1 旁路选择
    // ==========================================
    always_comb begin
        case (forward_A_sel_ID)
            2'b00: forwarded_rs1data = original_rs1data;       // 原路返回 (寄存器堆自带 WB 穿透，这里默认是安全的旧值)
            2'b01: forwarded_rs1data = forward_data_from_WB;   // 旁路 WB (上上条指令的结果)
            2'b10: forwarded_rs1data = forward_data_from_MEM;  // 旁路 MEM (上一条指令的 ALU 结果)
            default: forwarded_rs1data = original_rs1data;
        endcase
    end

    // ==========================================
    // rs2 旁路选择
    // ==========================================
    always_comb begin
        case (forward_B_sel_ID)
            2'b00: forwarded_rs2data = original_rs2data;
            2'b01: forwarded_rs2data = forward_data_from_WB;
            2'b10: forwarded_rs2data = forward_data_from_MEM;
            default: forwarded_rs2data = original_rs2data;
        endcase
    end

endmodule