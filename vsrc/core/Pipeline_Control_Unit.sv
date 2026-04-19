`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2026 01:55:09 AM
// Design Name: 
// Module Name: Pipeline_Control_Unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 全局流水线控制与仲裁单元 (带精准依赖检测)
// 
//////////////////////////////////////////////////////////////////////////////////

module Pipeline_Control_Unit(
    // -----------------------------------------
    // 监听：ID 阶段的指令信息
    // -----------------------------------------
    input logic [4:0] rs1_addr_ID,
    input logic [4:0] rs2_addr_ID,
    
    input logic       use_rs1_ID,        // 当前 ID 阶段指令是否真正使用 rs1
    input logic       use_rs2_ID,        // 当前 ID 阶段指令是否真正使用 rs2
    
    input logic       is_jump_or_branch_ID,      // 当前 ID 阶段指令是否是 Branch/JAL/JALR
    input logic       branch_taken_raw,  // ID 阶段 branch_unit 的原始跳转请求

    // -----------------------------------------
    // 监听：EX 阶段的指令信息
    // -----------------------------------------
    input logic [4:0] rd_addr_EX,       
    input logic       mem_read_EX,      
    input logic       reg_write_EX,     

    // -----------------------------------------
    // 监听：MEM 阶段的指令信息
    // -----------------------------------------
    input logic [4:0] rd_addr_MEM,      
    input logic       mem_read_MEM,     

    // -----------------------------------------
    // 输出：全局流水线控制信号 (给 core_top)
    // -----------------------------------------
    output logic PC_jump,                  // 1: 允许 PC 跳转
    output logic PC_hold,                  // 1: 停顿 PC
    output logic ID_hold,                  // 1: 停顿 IF/ID 寄存器
    output logic insert_bubble_to_ID,      // 1: 冲刷 IF/ID 寄存器 (分支预测失败时清除错取的指令)
    output logic insert_bubble_to_EX       // 1: 清空 ID/EX 流水线寄存器 (插气泡解决数据依赖)
);

    // =========================================================================
    // 第一步：统一计算是否需要停顿 (Stall Request)
    // 引入了 use_rs1 和 use_rs2 进行精确匹配，彻底消除假停顿
    // =========================================================================
    logic stall_req;
    
    always_comb begin
        stall_req = 1'b0; // 默认不停顿

        // 冲突情况 1：经典 Load-Use 冒险
        // EX 阶段是 Load，且它的目标寄存器(rd) 被当前 ID 阶段真实使用到了
        if (mem_read_EX && (rd_addr_EX != 5'b0) && 
           ((use_rs1_ID && (rd_addr_EX == rs1_addr_ID)) || 
            (use_rs2_ID && (rd_addr_EX == rs2_addr_ID)))) begin
            stall_req = 1'b1;
        end
        
        // 冲突情况 2：ALU 紧跟 Branch / JALR 
        // ID 阶段是跳转指令，且 EX 阶段的 ALU 正在算它真实需要的值
        else if (is_jump_or_branch_ID && reg_write_EX && (rd_addr_EX != 5'b0) &&
                ((use_rs1_ID && (rd_addr_EX == rs1_addr_ID)) || 
                 (use_rs2_ID && (rd_addr_EX == rs2_addr_ID)))) begin
            stall_req = 1'b1;
        end
        
        // 冲突情况 3：Load 间隔一个再是 Branch / JALR 
        // ID 阶段是跳转指令，且 MEM 阶段的 Load 还没把它真实需要的数据写回
        else if (is_jump_or_branch_ID && mem_read_MEM && (rd_addr_MEM != 5'b0) &&
                ((use_rs1_ID && (rd_addr_MEM == rs1_addr_ID)) || 
                 (use_rs2_ID && (rd_addr_MEM == rs2_addr_ID)))) begin
            stall_req = 1'b1;
        end
    end

    // =========================================================================
    // 第二步：全局控制信号仲裁 (优先级：Stall > Jump > 正常流转)
    // =========================================================================
    // 得出分支以后 
    // 1.应该让PC跳转 
    // 2.让IF/ID寄存器插入一个气泡
    // 得出lu冒险以后 (包括分支指令的lu冒险和普通指令的lu冒险)
    // 1.应该让PC保持不变 
    // 2.让IF/ID寄存器保持 (就是现在ID还会在下一周期干一样的事情,这样等待就解决了冒险) 
    // 3.还应该给ID/EX寄存器插入气泡

    always_comb begin
        // 默认状态：不跳转，不停顿，不插气泡
        PC_jump             = 1'b0;
        PC_hold             = 1'b0;
        ID_hold             = 1'b0;
        insert_bubble_to_ID = 1'b0;
        insert_bubble_to_EX = 1'b0;

        if (stall_req) begin
            // 优先级 1：发生真实的数据冲突，必须停顿！
            // 此时 branch_taken_raw 哪怕是 1 也是失效的
            PC_jump             = 1'b0; 
            PC_hold             = 1'b1; 
            ID_hold             = 1'b1; 
            insert_bubble_to_ID = 1'b0; 
            insert_bubble_to_EX = 1'b1; 
        end
        else if (branch_taken_raw) begin
            // 优先级 2：没有数据冲突，且判定需要跳转
            PC_jump             = 1'b1; 
            PC_hold             = 1'b0; 
            ID_hold             = 1'b0; 
            insert_bubble_to_ID = 1'b1; // 冲刷掉错误取出的指令
            insert_bubble_to_EX = 1'b0; 
        end
        else begin
            // 优先级 3：正常顺序执行
            // 保持上面的默认 0 状态即可
        end
    end

endmodule