`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Module Name: csrUnit
// Description: CSR 操作运算单元 (纯组合逻辑，EX 阶段的 CSR "ALU")
//   根据完整 funct3 区分六种 CSR 指令，计算新 CSR 值
//   csrRead/csrWrite 受 rd=x0 / rs1=x0 条件门控
//////////////////////////////////////////////////////////////////////////////////

module csrUnit (
    input  logic [`REG_ADDR_WIDTH-1:0] r1Addr,    // rs1 地址 (用于 rs1=x0 检测)
    input  logic [`REG_ADDR_WIDTH-1:0] rdAddr,    // rd 地址  (用于 rd=x0 检测)
    input  logic csrOp,                            // CSR 操作标志 (来自 control.sv)
    input  logic [2:0] funct3,                     // 完整 funct3，用 define.vh 宏解码
    input  logic [`REG_WIDTH-1:0] csr,             // CSR 旧值 (经前递)
    input  logic [`REG_WIDTH-1:0] rs1Uimm,         // rs1 数据 或 零扩展立即数 (zimm)

    output logic [`REG_WIDTH-1:0] csrResult,       // 计算得到的 CSR 新值
    output logic csrRead,                          // CSR 读使能
    output logic csrWrite                          // CSR 写使能
);

    logic csrReadIn, csrWriteIn;
    logic nrdIs0, nrIs0;

    assign nrdIs0 = |rdAddr;    // rd != x0
    assign nrIs0  = |r1Addr;   // rs1/zimm != 0
    assign csrRead  = csrReadIn  & csrOp;
    assign csrWrite = csrWriteIn & csrOp;

    always_comb begin
        // 安全默认值
        csrReadIn  = 1'b0;
        csrWriteIn = 1'b0;
        csrResult  = {`REG_WIDTH{1'b0}};

        case (funct3)
            // CSRRW / CSRRWI: 新值 = rs1 (或 zimm)
            `FUNCT3_CSRRW,
            `FUNCT3_CSRRWI: begin
                csrReadIn  = nrdIs0;   // rd=x0 时不读 (RISC-V 规范优化)
                csrWriteIn = 1'b1;
                csrResult  = rs1Uimm;
            end
            // CSRRS / CSRRSI: 新值 = csr | rs1 (或 zimm)
            `FUNCT3_CSRRS,
            `FUNCT3_CSRRSI: begin
                csrReadIn  = 1'b1;
                csrWriteIn = nrIs0;    // rs1=x0 / zimm=0 时不写 (只读)
                csrResult  = csr | rs1Uimm;
            end
            // CSRRC / CSRRCI: 新值 = csr & ~rs1 (或 ~zimm)
            `FUNCT3_CSRRC,
            `FUNCT3_CSRRCI: begin
                csrReadIn  = 1'b1;
                csrWriteIn = nrIs0;    // rs1=x0 / zimm=0 时不写 (只读)
                csrResult  = csr & (~rs1Uimm);
            end
            default: ;  // 保持默认值
        endcase
    end

endmodule
