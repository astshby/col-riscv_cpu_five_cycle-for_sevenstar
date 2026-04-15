`timescale 1ns / 1ps

`include "define.vh"

module ID_stage (
    input logic clk,
    input logic rst,

    // 来自IF/ID寄存器的信息
    input logic [31:0] instruction, // 来自IF/ID寄存器的指令
    input logic [31:0] pc,          // 来自IF/ID寄存器

    // 来自EX阶段的信息 用于前递给branch单元 用于判断load-use冒险
    input logic reg_write_EX,
    input logic mem_read_EX,
    input logic [4:0] rd_addr_EX,
    input logic [31:0] alu_result_EX,

    // 来自MEM阶段的信息 用于前递给branch单元 用于判断load-use冒险
    input logic reg_write_MEM,
    input logic mem_read_MEM,
    input logic [4:0] rd_addr_MEM,
    input logic [31:0] result_MEM,

    // 来自WB阶段的信息 写回(有穿透)
    input logic [4:0]  rd_addr_WB,       // 来自WB阶段的写回数据
    input logic [31:0] rd_data_WB,       // 来自WB阶段的写回数据
    input logic wen,                // 来自WB阶段的写使能

    // 跳转,气泡,停顿控制信号输出
    output logic PC_jump,
    output logic PC_hold,
    output logic ID_hold,
    output logic insert_bubble_to_ID,
    output logic insert_bubble_to_EX,
    output logic [31:0] branch_target, // 分支单元计算得到的分支目标地址，传递给IF阶段

    // 传递给EX阶段的信息
    output logic [31:0] rs1data_from_regfile, // 从寄存器堆读出的trs1数据(有WB穿透)
    output logic [31:0] rs2data_from_regfile, // 从寄存器堆读出的rs2数据
    output logic [31:0] imm,

);

    logic [31:0] rs1data_after_forwarding; // 前递单元处理后的rs1数据，传递给分支单元进行比较
    logic [31:0] rs2data_after_forwarding; // 前递单元处理后的rs2数据，传递给分支单元进行比较

    logic branch_taken; // 分支单元计算得到的分支是否成立信号
    logic lu_conflict_from_branch_forwarding; // 来自分支前递单元的Load-Use冒险冲突信号
    logic lu_conflict_from_xxx; // 其他可能的Load-Use冒险冲突信号（例如来自普通前递单元的冲突）


    // 得出分支以后 
    // 1.应该让PC跳转 
    // 2.让IF/ID寄存器插入一个气泡
    // 得出lu冒险以后 (包括分支指令的lu冒险和普通指令的lu冒险)
    // 1.应该让PC保持不变 
    // 2.让IF/ID寄存器保持 (就是现在ID还会在下一周期干一样的事情,这样等待就解决了冒险) 
    // 3.还应该给ID/EX寄存器插入气泡


    // 停顿的优先级大于让pc跳转,因为如果有停顿,说明分支指令的条件还没有准备好,这个时候pc跳转了是错的,保持pc不变,等条件准备好了再跳转
    always_comb begin
        if(lu_conflict_from_branch_forwarding || lu_conflict_from_xxx)begin
            PC_jump = 1'b0; // Load-Use冒险发生了，不发生分支跳转
            PC_hold = 1'b1; // 发生Load-Use冒险，保持PC不变
            ID_hold = 1'b1; // 发生Load-Use冒险，保持ID阶段不变
            insert_bubble_to_ID = 1'b0; // ID阶段不需要插入气泡
            insert_bubble_to_EX = 1'b1; // 发生Load-Use冒险，插入一个气泡到EX阶段
        end
        else if (branch_taken) begin
            PC_jump = 1'b1; // 发生分支，PC需要跳转
            PC_hold = 1'b0; 
            ID_hold = 1'b0; // 分支发生了，ID阶段不需要保持不变
            insert_bubble_to_ID = 1'b1; // 发生分支，插入一个气泡到ID阶段，刚取到的指令不要了
            insert_bubble_to_EX = 1'b0; 
            // 这个时候IF/ID寄存器会被冲刷掉，下一周期ID阶段会是一个nop指令
        end
        else begin
            PC_jump = 1'b0; 
            PC_hold = 1'b0;
            ID_hold = 1'b0;
            insert_bubble_to_ID = 1'b0; 
            insert_bubble_to_EX = 1'b0; 
            // 正常情况，不发生分支也没有冒险
        end
    end

    // 寄存器堆 (具有内部数据穿透功能)
    regfile regfile(
        .clk(clk),
        .rst(rst),
        .rs1addr(instruction[19:15]),
        .rs2addr(instruction[24:20]),
        .rdaddr(rd_addr_WB),
        .wdata(rd_data_WB),
        .wen(wen),
        .rs1data(rs1data_from_regfile),
        .rs2data(rs2data_from_regfile)
    );


    // 立即数生成模块 (直接从指令中解析出立即数)
    gen_imm gen_imm(
        .instruction(instruction),
        .imm_out(imm)
    );

    // 分支单元 (计算是否分支和目标地址)
    branch_unit branch_unit(
        .inst(instruction),
        .pc(pc),
        .rs1data(rs1data_after_forwarding), // 连接分支前递单元的输出，确保分支单元使用前递后的数据进行比较
        .rs2data(rs2data_after_forwarding),//这两个应该接上前递单元的多选的结果
        .imm(imm),
        .branch_taken(branch_taken),
        .branch_target(branch_target)
    );

    // 分支前递单元 (解决分支指令的前递和产生 Load-Use 停顿)
    branch_forwarding_unit branch_forwarding_unit(
        // 来自 ID 阶段的信息
        .instruction_ID(instruction),
        .rs1_data_regfile(rs1data_from_regfile), // 直接使用寄存器堆输出的原始数据，前递单元内部会处理
        .rs2_data_regfile(rs2data_from_regfile), // 直接使用寄存器堆输出的原始数据，前递单元内部会处理
        // EX 阶段信息 (需要从EX阶段的ID/EX寄存器中获取，这里只是示例信号)
        .reg_write_EX(reg_write_EX), // EX阶段指令是否写寄存器
        .mem_read_EX(mem_read_EX),  // EX阶段指令是否是Load
        .rd_addr_EX(rd_addr_EX),   // EX阶段指令的目的寄存器地址
        .alu_result_EX(alu_result_EX),// EX阶段的ALU结果（用于前递）
        // MEM 阶段信息 (需要从MEM阶段的EX/MEM寄存器中获取，这里只是示例信号)
        .reg_write_MEM(reg_write_MEM), // MEM阶段指令是否写寄存器
        .mem_read_MEM(mem_read_MEM),  // MEM阶段指令是否是Load
        .rd_addr_MEM(rd_addr_MEM),   // MEM阶段指令的目的寄存器地址
        .result_MEM(result_MEM),    // MEM阶段的结果（用于前递）
        // 输出到分支单元和ID阶段其他部分
        .rs1_forwarded_ID(rs1data_after_forwarding), // 前递后的RS1数据，直接覆盖原始数据输出
        .rs2_forwarded_ID(rs2data_after_forwarding), // 前递后的RS2数据，直接覆盖原始数据输出
        .lu_conflict_from_branch_forwarding(lu_conflict_from_branch_forwarding) // Load-Use冒险冲突信号，传递给ID阶段以插入气泡
    );

endmodule

// 其他类型的load-use冒险的判断 就看ID是add EX是load 
// 那就 PC ID hold, ID/EX插入气泡,让ID阶段保持不变,load走到了mem
// 再到下周期时候 add在EX load 在rb 这个时候前递就好了