`timescale 1ns / 1ps
`include "define.vh"

module fortb_data_mem (
    input  logic        clka,
    input  logic        ena,         
    input  logic [3:0]  wea,         
    input  logic [11:0] addra,       
    input  logic [31:0] dina,        
    output logic [31:0] douta = 32'h00000000 
);

    // 16KB 数据存储
    logic [31:0] ram_array [0:4095];

    always_ff @(posedge clka) begin
        if (ena) begin
            // 完美映射 FPGA BRAM 行为：读写同源
            if (wea[0]) ram_array[addra][7:0]   <= dina[7:0];
            if (wea[1]) ram_array[addra][15:8]  <= dina[15:8];
            if (wea[2]) ram_array[addra][23:16] <= dina[23:16];
            if (wea[3]) ram_array[addra][31:24] <= dina[31:24];
            
            douta <= ram_array[addra];
        end
    end

endmodule