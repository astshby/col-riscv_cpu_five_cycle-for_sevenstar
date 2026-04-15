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
    // 1. 来自 ID 阶段当前指令的信息
    input  logic        is_branch_ID,     // 必须引入此信号，避免错把普通指令也当成分支来 Stalled
    input  logic [4:0]  rs1_addr_ID,
    input  logic [4:0]  rs2_addr_ID,
    input  logic [31:0] rs1_data_regfile, // 从寄存器堆读出的原始数据 (包含 WB 阶段的穿透值)
    input  logic [31:0] rs2_data_regfile, 

    // 2. 来自 EX 阶段 (上一条指令) 的信息
    input  logic        reg_write_EX,     
    input  logic        mem_read_EX,      // EX阶段是否是 Load 指令
    input  logic [4:0]  rd_addr_EX,       
    input  logic [31:0] alu_result_EX,    // EX阶段的 ALU 计算结果

    // 3. 来自 MEM 阶段 (上上条指令) 的信息
    input  logic        reg_write_MEM,    
    input  logic        mem_read_MEM,     // MEM阶段是否是 Load 指令
    input  logic [4:0]  rd_addr_MEM,      
    input  logic [31:0] result_MEM,       // MEM阶段的 ALU 计算结果

    // 4. 输出给 branch_unit 的数据，以及给控制单元的停顿信号
    output logic [31:0] rs1_forwarded_ID,
    output logic [31:0] rs2_forwarded_ID,
    output logic        lu_conflict_from_branch_forwarding // Load-Use 停顿请求信号
    );

    // =========================================================================
    // 停顿请求发生逻辑 (Load-Use Stall for Branch)
    // =========================================================================
    always_comb begin
        lu_conflict_from_branch_forwarding = 1'b0;

        // 只有当前 ID 阶段是分支指令时，才需要为此产生专门的 Stall
        if (is_branch_ID == 1'b1) begin
            // 情况 1: 上一条是 Load (目前在 EX 阶段) -> 需要停顿 2 个周期
            if (mem_read_EX == 1'b1 && rd_addr_EX != 5'b0 && 
               (rd_addr_EX == rs1_addr_ID || rd_addr_EX == rs2_addr_ID)) begin
                lu_conflict_from_branch_forwarding = 1'b1;
            end
            
            // 情况 2: 上上条是 Load (目前在 MEM 阶段) -> 需要停顿 1 个周期
            // 注意：因为同步 Mem，数据在 MEM 算不出来，必须等到 WB 阶段穿透，所以这里依然要停顿！
            else if (mem_read_MEM == 1'b1 && rd_addr_MEM != 5'b0 && 
                    (rd_addr_MEM == rs1_addr_ID || rd_addr_MEM == rs2_addr_ID)) begin
                lu_conflict_from_branch_forwarding = 1'b1;
            end
        end
    end

    // =========================================================================
    // RS1 的前递逻辑 (剔除 Load 指令的无效结果)
    // =========================================================================
    always_comb begin
        // 注意这里加了 mem_read_EX == 1'b0 的条件。
        // 如果是 Load 指令，我们不能前递无效数据，而是靠上面的 lu_conflict 产生 Stall，等写穿透。
        if (reg_write_EX == 1'b1 && mem_read_EX == 1'b0 && rd_addr_EX != 5'b0 && rd_addr_EX == rs1_addr_ID) begin
            rs1_forwarded_ID = alu_result_EX;
        end 
        else if (reg_write_MEM == 1'b1 && mem_read_MEM == 1'b0 && rd_addr_MEM != 5'b0 && rd_addr_MEM == rs1_addr_ID) begin
            rs1_forwarded_ID = result_MEM;
        end 
        else begin
            // 发生停顿期间，这里会输出旧值，但这没关系，因为 Stall 使能会导致此时算出的跳转信号被丢弃。
            // 当 Load 进入 WB 阶段，Stall 释放，这里就会直接读出 rs1_data_regfile (也就是完美穿透的新值)
            rs1_forwarded_ID = rs1_data_regfile;
        end
    end

    // =========================================================================
    // RS2 的前递逻辑 (与 RS1 一致)
    // =========================================================================
    always_comb begin
        if (reg_write_EX == 1'b1 && mem_read_EX == 1'b0 && rd_addr_EX != 5'b0 && rd_addr_EX == rs2_addr_ID) begin
            rs2_forwarded_ID = alu_result_EX;
        end 
        else if (reg_write_MEM == 1'b1 && mem_read_MEM == 1'b0 && rd_addr_MEM != 5'b0 && rd_addr_MEM == rs2_addr_ID) begin
            rs2_forwarded_ID = result_MEM;
        end 
        else begin
            rs2_forwarded_ID = rs2_data_regfile;
        end
    end

endmodule
