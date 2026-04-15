`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2026 02:41:34 PM
// Design Name: 
// Module Name: branch_forwarding_unit
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

module branch_forwarding_unit(
    // 1. 来自 ID 阶段的指令信息
    input  logic [31:0] instruction_ID,   // 传入完整指令，由本模块自己判断依赖
    input  logic [31:0] rs1_data_regfile,   //WB会穿透
    input  logic [31:0] rs2_data_regfile, 

    // 2. 来自 EX 阶段 (上一条指令) 的信息
    input  logic        reg_write_EX,     
    input  logic        mem_read_EX,      
    input  logic [4:0]  rd_addr_EX,       
    input  logic [31:0] alu_result_EX,    

    // 3. 来自 MEM 阶段 (上上条指令) 的信息
    input  logic        reg_write_MEM,    
    input  logic        mem_read_MEM,     
    input  logic [4:0]  rd_addr_MEM,      
    input  logic [31:0] result_MEM,       

    // 4. 输出信号
    output logic [31:0] rs1_forwarded_ID,
    output logic [31:0] rs2_forwarded_ID,
    output logic        lu_conflict_from_branch_forwarding 
    );

    // =========================================================================
    // 内部译码逻辑：提取操作码和寄存器地址，并判断是否真正使用了 rs1 / rs2
    // =========================================================================
    logic [6:0] opcode;
    logic [4:0] rs1_addr_ID;
    logic [4:0] rs2_addr_ID;
    
    logic use_rs1;
    logic use_rs2;
    logic is_jump_or_branch;

    assign opcode      = instruction_ID[6:0];
    assign rs1_addr_ID = instruction_ID[19:15];
    assign rs2_addr_ID = instruction_ID[24:20];

    always_comb begin
        // 默认不使用
        use_rs1 = 1'b0;
        use_rs2 = 1'b0;
        is_jump_or_branch = 1'b0;

        case (opcode)
            7'b1100011: begin // B-type (beq, bne, blt, bge, bltu, bgeu)
                use_rs1 = 1'b1;
                use_rs2 = 1'b1;
                is_jump_or_branch = 1'b1;
            end
            7'b1100111: begin // I-type (jalr)
                use_rs1 = 1'b1;
                use_rs2 = 1'b0; // jalr 不需要 rs2
                is_jump_or_branch = 1'b1;
            end
            7'b1101111: begin // J-type (jal)
                use_rs1 = 1'b0; // jal 都不需要
                use_rs2 = 1'b0;
                is_jump_or_branch = 1'b1;
            end
            default: begin
                is_jump_or_branch = 1'b0;
            end
        endcase
    end

    // =========================================================================
    // 停顿请求发生逻辑 (Load-Use Stall for Branch) - 精确匹配
    // =========================================================================
    always_comb begin
        lu_conflict_from_branch_forwarding = 1'b0;

        if (is_jump_or_branch == 1'b1) begin
            // 情况 1: EX 阶段是 Load
            if (mem_read_EX == 1'b1 && rd_addr_EX != 5'b0) begin
                // 只有在当前指令真正在使用该寄存器时，才引发停顿
                if ((use_rs1 && (rd_addr_EX == rs1_addr_ID)) || 
                    (use_rs2 && (rd_addr_EX == rs2_addr_ID))) begin
                    lu_conflict_from_branch_forwarding = 1'b1;
                end
            end
            
            // 情况 2: MEM 阶段是 Load
            else if (mem_read_MEM == 1'b1 && rd_addr_MEM != 5'b0) begin
                if ((use_rs1 && (rd_addr_MEM == rs1_addr_ID)) || 
                    (use_rs2 && (rd_addr_MEM == rs2_addr_ID))) begin
                    lu_conflict_from_branch_forwarding = 1'b1;
                end
            end
        end
    end

    // =========================================================================
    // 前递逻辑
    // (这里即使不判断 use_rs1/use_rs2 也没关系，因为如果没用到，前递了错误数据也不会被采纳。
    //  但为了代码逻辑的严谨，依然可以用 rs1_addr_ID 去匹配)
    // =========================================================================
    always_comb begin
        // RS1 前递
        if (reg_write_EX == 1'b1 && mem_read_EX == 1'b0 && rd_addr_EX != 5'b0 && rd_addr_EX == rs1_addr_ID) begin
            // EX 阶段的指令写寄存器，并且不是 Load 指令，且目标寄存器地址不为 0，且与当前 ID 阶段的 rs1 地址匹配
            rs1_forwarded_ID = alu_result_EX;
        end 
        else if (reg_write_MEM == 1'b1 && mem_read_MEM == 1'b0 && rd_addr_MEM != 5'b0 && rd_addr_MEM == rs1_addr_ID) begin
            // MEM 阶段的指令写寄存器，并且不是 Load 指令，且目标寄存器地址不为 0，且与当前 ID 阶段的 rs1 地址匹配
            rs1_forwarded_ID = result_MEM;
        end 
        else begin
            rs1_forwarded_ID = rs1_data_regfile;
        end

        // RS2 前递
        if (reg_write_EX == 1'b1 && mem_read_EX == 1'b0 && rd_addr_EX != 5'b0 && rd_addr_EX == rs2_addr_ID) begin
            // EX 阶段的指令写寄存器，并且不是 Load 指令，且目标寄存器地址不为 0，且与当前 ID 阶段的 rs2 地址匹配
            rs2_forwarded_ID = alu_result_EX;
        end 
        else if (reg_write_MEM == 1'b1 && mem_read_MEM == 1'b0 && rd_addr_MEM != 5'b0 && rd_addr_MEM == rs2_addr_ID) begin
            // MEM 阶段的指令写寄存器，并且不是 Load 指令，且目标寄存器地址不为 0，且与当前 ID 阶段的 rs2 地址匹配
            rs2_forwarded_ID = result_MEM;
        end 
        else begin
            rs2_forwarded_ID = rs2_data_regfile;
        end
    end

endmodule