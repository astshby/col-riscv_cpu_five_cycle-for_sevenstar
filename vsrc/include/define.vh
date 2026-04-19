// Annotate this macro before synthesis
// `define RUN_TRACE

// Reg状态,包含基础定义与写回数据选择
`define RegAddrBus 4:0
`define RegBus 31:0
`define RegNum 32
`define RstEnable 1
`define RstDisable 0

`define RF_WSEL_WIDTH 3
`define RF_WSEL_ALUC 0
`define RF_WSEL_DRAM 1
`define RF_WSEL_PC4 2
`define RF_WSEL_SEXT 3
`define RF_WSEL_CSR 4     // 体值需要根据您的实现调

// PC与nextPC状态，ALU应该是jalr的
`define NPC_SEL_WIDTH 2
`define NPC_SEL_NEXT 0
`define NPC_SEL_BRANCH 1
`define NPC_SEL_ALU 2
`define NPC_SEL_JAL 3


// ALU状态
// SELA,SELB是对两个入口的选择，SEL是粗选择
// OP是操作码，没有分两个来操控
`define ALU_SEL_WIDTH 2
`define ALU_SEL_ADD 0
`define ALU_SEL_SUB 1
`define ALU_SEL_OTHERS 2

`define ALUA_SEL_WIDTH 2
`define ALUA_SEL_RD1 0
`define ALUA_SEL_PC 1
`define ALUA_SEL_ZERO  2     //不一定需要，可能lui与jal的无效计算(如果不算最好)

`define ALUB_SEL_WIDTH 2
`define ALUB_SEL_RD2 0
`define ALUB_SEL_SEXT 1
`define ALUB_SEL_ZERO 2       //不一定需要，可能lui与jal的无效计算(如果不算最好) 
`define ALU_PASS_A       4'b1111  // 具体值需要根据您的实现调整

`define ALU_OP_WIDTH 4
`define ALU_ADD 0
`define ALU_SUB 1
`define ALU_AND 2
`define ALU_OR 3
`define ALU_XOR 4
`define ALU_SLL 5
`define ALU_SRL 6
`define ALU_SRA 7
`define ALU_SLT 8
`define ALU_SLTU 9
`define ALU_NOP 15


// DRAM操作与状态
`define DRAM_SEL_WIDTH 2
`define DRAM_SEL_B 0
`define DRAM_SEL_H 1
`define DRAM_SEL_W 2
// 为了测试方便写的,实际用不到
`define DRAM_SEL_LB 0
`define DRAM_SEL_LH 1
`define DRAM_SEL_LW 2
`define DRAM_SEL_LBU 4
`define DRAM_SEL_LHU 5
`define DRAM_SEL_SB 0
`define DRAM_SEL_SH 1
`define DRAM_SEL_SW 2


// inst状态,
// p1:模式选择器
// p2:操作码硬编码
// p3:fuct7 fuct3
`define Sext_OP_WIDTH 3
`define Sext_R 0
`define Sext_I 1
`define Sext_S 2
`define Sext_B 3
`define Sext_U 4
`define Sext_J 5
`define Sext_CSR 6

`define OPCODE_CSR 7'b1110011
`define OPCODE_R 7'b0110011
`define OPCODE_I_REG 7'b0010011
`define OPCODE_I_LOAD 7'b0000011
`define OPCODE_S 7'b0100011
`define OPCODE_B 7'b1100011
`define OPCODE_JALR 7'b1100111
`define OPCODE_JAL 7'b1101111
`define OPCODE_LUI 7'b0110111
`define OPCODE_AUIPC 7'b0010111

// 第一个是给ecall，ebreak，mret用的
// `define FUNCT3_CALL_RET 3'b000
`define FUNCT3_ADD_SUB 3'b000
`define FUNCT3_AND 	3'b111
`define FUNCT3_OR 	3'b110
`define FUNCT3_XOR 	3'b100
`define FUNCT3_SLL 	3'b001
`define FUNCT3_SRL_SRA  3'b101
`define FUNCT3_SLT 	3'b010
`define FUNCT3_SLTU	3'b011

`define FUNCT3_LB_SB 	    3'b000
`define FUNCT3_LBU  	3'b100
`define FUNCT3_LH_SH	    3'b001
`define FUNCT3_LHU  	3'b101
`define FUNCT3_LW_SW	    3'b010

`define FUNCT3_JALR	3'b000

`define FUNCT3_BEQ	    3'b000
`define FUNCT3_BNE	    3'b001
`define FUNCT3_BLT	    3'b100
`define FUNCT3_BLTU	3'b110
`define FUNCT3_BGE	    3'b101
`define FUNCT3_BGEU	3'b111

`define FUNCT7_ADD  7'b0000000
`define FUNCT7_SUB 	7'b0100000
`define FUNCT7_AND 	7'b0000000
`define FUNCT7_OR 	7'b0000000
`define FUNCT7_XOR 	7'b0000000
`define FUNCT7_SLL 	7'b0000000
`define FUNCT7_SRL 	7'b0000000
`define FUNCT7_SRA 	7'b0100000
`define FUNCT7_SLT 	7'b0000000
`define FUNCT7_SLTU	7'b0000000
`define FUNCT7_SLLI	7'b0000000
`define FUNCT7_SRLI	7'b0000000
`define FUNCT7_SRAI	7'b0100000

// 用于外设与内存地址空间 
`define DIGIT 12'h000
`define LED 12'h060
`define SWITCH 12'h070

`define PERI_ADDR_DIG   32'hFFFF_F000
`define PERI_ADDR_LED   32'hFFFF_F060
`define PERI_ADDR_SW    32'hFFFF_F070
`define PERI_ADDR_BTN   32'hFFFF_F078


// CSRRW related
// CSRRW 相关，最重要的，其中也与ALU_A有关
`define OPCODE_SYSTEM    7'b1110011
`define FUNCT3_CSRRW     3'b001
// `define ALU_PASS_A       4'b1111  // 具体值需要根据您的实现调整

