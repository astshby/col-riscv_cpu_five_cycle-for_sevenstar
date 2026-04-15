`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2026 11:36:55 AM
// Design Name: 
// Module Name: branch_unit
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


module branch_unit(
    input  logic [31:0] inst,         // 当前 ID 阶段的指令
    input  logic [31:0] pc,           // 当前指令的 PC 值
    input  logic [31:0] rs1data,      // 经过前递(Forwarding)处理后的 rs1 数据
    input  logic [31:0] rs2data,      // 经过前递(Forwarding)处理后的 rs2 数据
    input  logic [31:0] imm,          // 外部立即数生成单元算好的立即数
    
    output logic        branch_taken, // 1: 发生跳转; 0: 不跳转 (顺序执行)
    output logic [31:0] branch_target // 计算出的跳转目标地址
    );

    // 提取指令中的关键字段
    wire [6:0] opcode = inst[6:0];
    wire [2:0] funct3 = inst[14:12];

    // 定义指令的 Opcode
    localparam OPCODE_BRANCH = 7'b1100011; // B-type: beq, bne, blt, bge, bltu, bgeu
    localparam OPCODE_JAL    = 7'b1101111; // J-type: jal
    localparam OPCODE_JALR   = 7'b1100111; // I-type: jalr

    // 有符号数的比较逻辑预处理 (帮助综合工具生成更优的比较器)
    wire signed [31:0] rs1_signed = $signed(rs1data);
    wire signed [31:0] rs2_signed = $signed(rs2data);

    logic cmp_res; // 比较结果，1表示条件满足，0表示条件不满足

    // 组合逻辑计算跳转条件和目标地址
    always_comb begin
        // 默认不跳转，目标地址为 0
        branch_taken  = 1'b0;
        branch_target = 32'b0;

        case (opcode)
            // -----------------------------------------------------
            // 1. 无条件跳转: JAL
            // -----------------------------------------------------
            OPCODE_JAL: begin
                branch_taken  = 1'b1;
                branch_target = pc + imm;
            end

            // -----------------------------------------------------
            // 2. 无条件跳转: JALR
            // 注意: JALR 的目标地址是 (rs1 + imm)，并且要把最低位清零
            // -----------------------------------------------------
            OPCODE_JALR: begin
                branch_taken  = 1'b1;
                branch_target = (rs1data + imm) & ~32'h0000_0001;
            end

            // -----------------------------------------------------
            // 3. 条件分支: B-Type
            // -----------------------------------------------------
            OPCODE_BRANCH: begin
                branch_target = pc + imm; // B-Type 的目标地址都是 PC + imm
                
                // 优化后的分支条件判断
                case (funct3[2:1])
                    2'b00: cmp_res = (rs1data == rs2data);       // EQ
                    2'b10: cmp_res = (rs1_signed < rs2_signed);  // LT (有符号)
                    2'b11: cmp_res = (rs1data < rs2data);        // LTU (无符号)
                    default: cmp_res = 1'b0;
                endcase
                
                // funct3[0] 为 1 时，异或操作会翻转结果 (EQ->NEQ, LT->GE, LTU->GEU)
                branch_taken = cmp_res ^ funct3[0];

            end

            default: begin
                branch_taken  = 1'b0;
                branch_target = 32'b0;
            end
        endcase
    end

endmodule

