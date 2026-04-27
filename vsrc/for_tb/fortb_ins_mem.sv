`timescale 1ns / 1ps
`include "define.vh"

module fortb_ins_mem (
    input  logic        clka,
    input  logic        ena,         
    input  logic [13:0] addra,       
    output logic [31:0] douta = 32'h00000013 // 默认 NOP 防呆
);

    // 64KB 指令存储
    logic [31:0] rom_array [0:16383];

`ifndef SYNTHESIS
    initial begin
        $readmemh("build/code.mem", rom_array);
    end
`endif

    always_ff @(posedge clka) begin
        if (ena) begin
            douta <= rom_array[addra];
        end
    end

endmodule