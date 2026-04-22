`timescale 1ns / 1ps
`include "define.vh"

module fortb_ins_mem (
    input  logic        clka,
    input  logic        ena,         
    input  logic [11:0] addra,       
    output logic [31:0] douta = 32'h00000013 // 默认 NOP 防呆
);

    // 16KB 指令存储
    logic [31:0] rom_array [0:4095];

    always_ff @(posedge clka) begin
        if (ena) begin
            douta <= rom_array[addra];
        end
    end

endmodule
