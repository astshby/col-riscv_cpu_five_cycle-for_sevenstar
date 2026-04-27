`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Module Name: csrFile
// Description: 16 项 CSR 寄存器堆
//   组合读 (readAddr → csr)，时序写 (wEn + wAddr + wData)
//   寄存器 0-3 为硬件性能计数器，每周期自动累加:
//     [0] wrongBranch  分支预测错误次数
//     [1] controlXfer  控制流转移次数
//     [2] validInst    有效指令数
//     [3] cycle        周期计数 (每拍 +1)
//   注意: 计数器累加优先级高于软件写入 (reg 0-2), reg 3 软件写入优先
//////////////////////////////////////////////////////////////////////////////////

module csrFile #(
    parameter int REG_SIZE = 16
)(
    input  logic clk,

    // 写端口 (来自 WB 阶段)
    input  logic wEn,
    input  logic [`REG_WIDTH-1:0] wData,
    input  logic [`CSR_ADDR_WIDTH-1:0] wAddr,

    // 硬件性能计数器输入
    input  logic wrongBranch,
    input  logic validInst,
    input  logic controlXfer,

    // 读端口 (组合逻辑，取低 4 位寻址)
    input  logic [3:0] readAddr,
    output logic [`REG_WIDTH-1:0] csr
);

    logic [`REG_WIDTH-1:0] csRegisters [REG_SIZE-1:0];

    // 组合读
    assign csr = csRegisters[readAddr];

    always_ff @(posedge clk) begin
        // cycle 计数 (每拍 +1)
        csRegisters[3] <= csRegisters[3] + 1;

        // 软件写入 (对 reg 3 可覆盖 cycle 计数)
        if (wEn)
            csRegisters[wAddr[3:0]] <= wData;

        // 硬件计数器累加 (对 reg 0-2 覆盖软件写入)
        csRegisters[0] <= csRegisters[0] + {{(`REG_WIDTH-1){1'b0}}, wrongBranch};
        csRegisters[1] <= csRegisters[1] + {{(`REG_WIDTH-1){1'b0}}, controlXfer};
        csRegisters[2] <= csRegisters[2] + {{(`REG_WIDTH-1){1'b0}}, validInst};
    end

endmodule
