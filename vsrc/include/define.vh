// 如需 trace 调试，综合前注释掉
// `define RUN_TRACE

// 基础宽度定义
`define REG_WIDTH       32      // 通用寄存器数据宽度
`define REG_ADDR_WIDTH   5      // 通用寄存器地址宽度 (2^5 = 32 个)
`define RegNum          32      // 通用寄存器个数
`define RstEnable        1
`define RstDisable       0

// 写回数据选择 (regfile_wd_MUX)
`define RF_WSEL_WIDTH  3
`define RF_WSEL_ALUC   0        // ALU 运算结果
`define RF_WSEL_DRAM   1        // 数据存储器 Load 数据
`define RF_WSEL_PC4    2        // PC + 4 (JAL/JALR 链接地址)
`define RF_WSEL_SEXT   3        // 符号扩展立即数 (LUI)
`define RF_WSEL_CSR    4        // CSR 旧值写回 rd

// 分支类型 (control.sv 输出, branch_unit.sv 输入, 消除重复解码)
`define BRANCH_TYPE_WIDTH 2
`define BRANCH_NONE  2'b00      // 非跳转指令
`define BRANCH_JAL   2'b01      // JAL  (无条件, target = PC + imm)
`define BRANCH_JALR  2'b10      // JALR (无条件, target = rs1 + imm)
`define BRANCH_B     2'b11      // B-type (条件分支)

// ALU 控制信号
// ALU 粗选择 (control.sv 根据 opcode 决定)
`define ALU_SEL_WIDTH  2
`define ALU_SEL_ADD    0        // 强制加法 (Load/Store 地址计算, AUIPC)
`define ALU_SEL_SUB    1        // 强制减法 
`define ALU_SEL_OTHERS 2        // 由 funct3/funct7 精细选择 (R/I 算术)
`define ALU_SEL_NO     3        // ALU 不参与 (Branch/Jump/LUI)

// ALU A 端口选择
`define ALUA_SEL_WIDTH 2
`define ALUA_SEL_RD1   0        // rs1 数据
`define ALUA_SEL_PC    1        // 当前 PC (AUIPC)
`define ALUA_SEL_ZERO  2        // 零 (LUI/JAL 不用 ALU)

// ALU B 端口选择
`define ALUB_SEL_WIDTH 2
`define ALUB_SEL_RD2   0        // rs2 数据
`define ALUB_SEL_SEXT  1        // 符号扩展立即数
`define ALUB_SEL_ZERO  2        // 零 (LUI/JAL 不用 ALU)

// ALU 操作码 (alu_op.sv 根据 funct3/funct7 生成)
`define ALU_OP_WIDTH   4
`define ALU_ADD        0
`define ALU_SUB        1
`define ALU_AND        2
`define ALU_OR         3
`define ALU_XOR        4
`define ALU_SLL        5
`define ALU_SRL        6
`define ALU_SRA        7
`define ALU_SLT        8
`define ALU_SLTU       9
`define ALU_NOP       15

// 数据存储器操作 (mem_mux_l / mem_mux_s)
`define DRAM_SEL_WIDTH 2
`define DRAM_SEL_B     0        // Byte
`define DRAM_SEL_H     1        // Halfword
`define DRAM_SEL_W     2        // Word

// 立即数生成模式 (gen_imm.sv)
`define Sext_OP_WIDTH  3
`define Sext_R         0
`define Sext_I         1
`define Sext_S         2
`define Sext_B         3
`define Sext_U         4
`define Sext_J         5

// RISC-V 指令编码
// Opcode
`define OPCODE_R       7'b0110011
`define OPCODE_I_REG   7'b0010011
`define OPCODE_I_LOAD  7'b0000011
`define OPCODE_S       7'b0100011
`define OPCODE_B       7'b1100011
`define OPCODE_JALR    7'b1100111
`define OPCODE_JAL     7'b1101111
`define OPCODE_LUI     7'b0110111
`define OPCODE_AUIPC   7'b0010111
`define OPCODE_SYSTEM  7'b1110011   // CSR 指令
// Funct3 — 算术/逻辑
`define FUNCT3_ADD_SUB  3'b000
`define FUNCT3_AND      3'b111
`define FUNCT3_OR       3'b110
`define FUNCT3_XOR      3'b100
`define FUNCT3_SLL      3'b001
`define FUNCT3_SRL_SRA  3'b101
`define FUNCT3_SLT      3'b010
`define FUNCT3_SLTU     3'b011
// Funct3 — Load/Store
`define FUNCT3_LB_SB    3'b000
`define FUNCT3_LBU      3'b100
`define FUNCT3_LH_SH    3'b001
`define FUNCT3_LHU      3'b101
`define FUNCT3_LW_SW    3'b010
// Funct3 — JALR
`define FUNCT3_JALR     3'b000
// Funct3 — Branch
`define FUNCT3_BEQ      3'b000
`define FUNCT3_BNE      3'b001
`define FUNCT3_BLT      3'b100
`define FUNCT3_BLTU     3'b110
`define FUNCT3_BGE      3'b101
`define FUNCT3_BGEU     3'b111
// Funct7
`define FUNCT7_ADD      7'b0000000
`define FUNCT7_SUB      7'b0100000
`define FUNCT7_AND      7'b0000000
`define FUNCT7_OR       7'b0000000
`define FUNCT7_XOR      7'b0000000
`define FUNCT7_SLL      7'b0000000
`define FUNCT7_SRL      7'b0000000
`define FUNCT7_SRA      7'b0100000
`define FUNCT7_SLT      7'b0000000
`define FUNCT7_SLTU     7'b0000000
`define FUNCT7_SLLI     7'b0000000
`define FUNCT7_SRLI     7'b0000000
`define FUNCT7_SRAI     7'b0100000

// CSR 子系统
`define CSR_ADDR_WIDTH  12      // CSR 地址宽度 (RISC-V 标准 12 位)
// Funct3 — CSR 寄存器形式
`define FUNCT3_CSRRW    3'b001
`define FUNCT3_CSRRS    3'b010
`define FUNCT3_CSRRC    3'b011
// Funct3 — CSR 立即数形式
`define FUNCT3_CSRRWI   3'b101
`define FUNCT3_CSRRSI   3'b110
`define FUNCT3_CSRRCI   3'b111

// 前递 MUX 选择信号 (Forwarding_Control_Unit 输出)
`define FWD_SEL_WIDTH  2
`define FWD_ORIG       2'b00    // 原路径 (寄存器堆/流水寄存器)
`define FWD_WB         2'b01    // 来自 WB 阶段 (次新)
`define FWD_MEM        2'b10    // 来自 MEM 阶段 (最新)

// 外设地址映射
`define PERI_ADDR_DIG   32'hFFFF_F000
`define PERI_ADDR_LED   32'hFFFF_F060
`define PERI_ADDR_SW    32'hFFFF_F070
`define PERI_ADDR_BTN   32'hFFFF_F078
