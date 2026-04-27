`timescale 1ns / 1ps

`include "define.vh"

//////////////////////////////////////////////////////////////////////////////////
// Module Name: control
// Description: 主控制/解码单元
//   根据 opcode 生成流水线各级所需的控制信号。
//   输出 branch_type 替代原 is_jump_or_branch，消除 branch_unit 的重复解码。
//////////////////////////////////////////////////////////////////////////////////

module control(
    input  logic [6:0] opcode,

    output logic [`Sext_OP_WIDTH-1:0]  gen_imm_op,
    output logic [`ALU_SEL_WIDTH-1:0]  alu_sel,
    output logic [`ALUA_SEL_WIDTH-1:0] alua_sel,
    output logic [`ALUB_SEL_WIDTH-1:0] alub_sel,
    output logic [`RF_WSEL_WIDTH-1:0]  reg_w_sel,
    output logic reg_write,
    output logic mem_read,
    output logic mem_write,
    output logic csr_op,  // CSR 操作标志

    // 用于pipeline control unit的信号
    output logic use_rs1,
    output logic use_rs2,
    output logic [`BRANCH_TYPE_WIDTH-1:0] branch_type   // 分支类型 (替代 is_jump_or_branch)
    );

    always_comb begin : main_con

        // 统一信号初始化，防止产生锁存器 (Latch)
        gen_imm_op  = `Sext_R;
        alu_sel     = `ALU_SEL_ADD;
        alua_sel    = `ALUA_SEL_RD1;
        alub_sel    = `ALUB_SEL_RD2;
        reg_w_sel   = `RF_WSEL_ALUC;
        reg_write   = 0;
        mem_read    = 0;
        mem_write   = 0;
        csr_op      = 0;
        use_rs1     = 0;
        use_rs2     = 0;
        branch_type = `BRANCH_NONE;

        case(opcode)

            // R型算术指令 (ADD, SUB, AND 等)：需要 rs1 和 rs2
            `OPCODE_R: begin
                gen_imm_op  = `Sext_R;
                alu_sel     = `ALU_SEL_OTHERS;
                alua_sel    = `ALUA_SEL_RD1;
                alub_sel    = `ALUB_SEL_RD2;
                reg_w_sel   = `RF_WSEL_ALUC;
                reg_write   = 1;
                use_rs1     = 1;
                use_rs2     = 1;
            end

            // I型算术指令 (ADDI, ANDI 等)：需要 rs1 和 立即数
            `OPCODE_I_REG: begin
                gen_imm_op  = `Sext_I;
                alu_sel     = `ALU_SEL_OTHERS;
                alua_sel    = `ALUA_SEL_RD1;
                alub_sel    = `ALUB_SEL_SEXT;
                reg_w_sel   = `RF_WSEL_ALUC;
                reg_write   = 1;
                use_rs1     = 1;
            end

            // Load 指令 (LW, LB 等)：需要 rs1 做基址算地址
            `OPCODE_I_LOAD: begin
                gen_imm_op  = `Sext_I;
                alu_sel     = `ALU_SEL_ADD;
                alua_sel    = `ALUA_SEL_RD1;
                alub_sel    = `ALUB_SEL_SEXT;
                reg_w_sel   = `RF_WSEL_DRAM;
                reg_write   = 1;
                mem_read    = 1;
                use_rs1     = 1;
            end

            // Store 指令 (SW, SB 等)：需要 rs1 算基址
            `OPCODE_S: begin
                gen_imm_op  = `Sext_S;
                alu_sel     = `ALU_SEL_ADD;
                alua_sel    = `ALUA_SEL_RD1;
                alub_sel    = `ALUB_SEL_SEXT;
                mem_write   = 1;
                use_rs1     = 1;
            end

            // Branch 指令 (BEQ, BNE 等)：需要 rs1 和 rs2 进行比较
            `OPCODE_B: begin
                gen_imm_op  = `Sext_B;
                alu_sel     = `ALU_SEL_NO;
                alua_sel    = `ALUA_SEL_RD1;
                alub_sel    = `ALUB_SEL_RD2;
                use_rs1     = 1;
                use_rs2     = 1;
                branch_type = `BRANCH_B;
            end

            // JALR 指令：需要 rs1 的值加上立即数作为跳转目标
            `OPCODE_JALR: begin
                gen_imm_op  = `Sext_I;
                alu_sel     = `ALU_SEL_NO;
                alua_sel    = `ALUA_SEL_RD1;
                alub_sel    = `ALUB_SEL_SEXT;
                reg_w_sel   = `RF_WSEL_PC4;
                reg_write   = 1;
                use_rs1     = 1;
                branch_type = `BRANCH_JALR;
            end

            // JAL 指令：直接用 PC 加立即数跳转，不读 rs1/rs2
            `OPCODE_JAL: begin
                gen_imm_op  = `Sext_J;
                alu_sel     = `ALU_SEL_NO;
                alua_sel    = `ALUA_SEL_ZERO;
                alub_sel    = `ALUB_SEL_ZERO;
                reg_w_sel   = `RF_WSEL_PC4;
                reg_write   = 1;
                branch_type = `BRANCH_JAL;
            end

            // LUI 指令：把立即数装到高位
            `OPCODE_LUI: begin
                gen_imm_op  = `Sext_U;
                alu_sel     = `ALU_SEL_NO;
                alua_sel    = `ALUA_SEL_ZERO;
                alub_sel    = `ALUB_SEL_ZERO;
                reg_w_sel   = `RF_WSEL_SEXT;
                reg_write   = 1;
            end

            // AUIPC 指令：PC 加上高位立即数
            `OPCODE_AUIPC: begin
                gen_imm_op  = `Sext_U;
                alu_sel     = `ALU_SEL_ADD;
                alua_sel    = `ALUA_SEL_PC;
                alub_sel    = `ALUB_SEL_SEXT;
                reg_w_sel   = `RF_WSEL_ALUC;
                reg_write   = 1;
            end

            // CSR 指令 (CSRRW/CSRRS/CSRRC/CSRRWI/CSRRSI/CSRRCI)
            `OPCODE_SYSTEM: begin
                gen_imm_op  = `Sext_I;    // gen_imm 输出不用于 CSR, 但保持合法
                alu_sel     = `ALU_SEL_NO;
                reg_w_sel   = `RF_WSEL_CSR;
                reg_write   = 1;          // CSR 旧值 → rd
                csr_op      = 1;
                use_rs1     = 1;          // 保守策略: CSRRxI 也标记
            end

            // 默认情况 (异常/空指令/气泡)
            default: begin
                alu_sel     = `ALU_SEL_NO;
            end

        endcase

    end : main_con
endmodule
