`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Module Name: branch_unit
// Description: 分支判断与目标地址计算
//   接收 control.sv 预解码的 branch_type (2-bit)，消除 7-bit opcode 重复解码，
//   缩短 ID 阶段关键路径。
//////////////////////////////////////////////////////////////////////////////////

module branch_unit(
    input  logic [`BRANCH_TYPE_WIDTH-1:0] branch_type, // 来自 control.sv 的预解码分支类型
    input  logic [2:0]                    funct3,      // instruction[14:12]，直接接线
    input  logic [`REG_WIDTH-1:0] pc,           // 当前指令的 PC 值
    input  logic [`REG_WIDTH-1:0] rs1data,      // 经过前递处理后的 rs1 数据
    input  logic [`REG_WIDTH-1:0] rs2data,      // 经过前递处理后的 rs2 数据
    input  logic [`REG_WIDTH-1:0] imm,          // 立即数生成单元的输出

    output logic        branch_taken, // 1: 发生跳转; 0: 不跳转
    output logic [`REG_WIDTH-1:0] branch_target // 计算出的跳转目标地址
    );

    // 有符号数比较预处理
    wire signed [`REG_WIDTH-1:0] rs1_signed = $signed(rs1data);
    wire signed [`REG_WIDTH-1:0] rs2_signed = $signed(rs2data);

    logic cmp_res;

    // 2-bit branch_type case 替代原 7-bit opcode case，减少一级解码延迟
    always_comb begin
        branch_taken  = 1'b0;
        branch_target = {`REG_WIDTH{1'b0}};
        cmp_res       = 1'b0;

        case (branch_type)
            // JAL: 无条件跳转, target = PC + imm
            `BRANCH_JAL: begin
                branch_taken  = 1'b1;
                branch_target = pc + imm;
            end

            // JALR: 无条件跳转, target = (rs1 + imm) & ~1
            `BRANCH_JALR: begin
                branch_taken  = 1'b1;
                branch_target = (rs1data + imm) & ~32'h0000_0001;
            end

            // B-type: 条件分支, target = PC + imm
            `BRANCH_B: begin
                branch_target = pc + imm;

                case (funct3[2:1])
                    2'b00: cmp_res = (rs1data == rs2data);       // EQ
                    2'b10: cmp_res = (rs1_signed < rs2_signed);  // LT (有符号)
                    2'b11: cmp_res = (rs1data < rs2data);        // LTU (无符号)
                    default: cmp_res = 1'b0;
                endcase

                // funct3[0]=1 时翻转结果 (EQ→NEQ, LT→GE, LTU→GEU)
                branch_taken = cmp_res ^ funct3[0];
            end

            default: begin
                branch_taken  = 1'b0;
                branch_target = {`REG_WIDTH{1'b0}};
            end
        endcase
    end

endmodule
