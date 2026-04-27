`timescale 1ns/1ps
module TB;

  // Clock and Reset
  logic clk;
  logic rst;

  // Testing hooks for cocotb (Ignored by col-* core but kept for script compatibility)
  logic usePredictor;

  // Instantiate the CPU with memories and simUart
  logic [31:0] PC;

  fortb_cpu_top_withsim uut (
    .clk(clk),
    .rst(rst),
    .PC(PC)
  );

  initial begin
    $dumpfile("build/dump.fst");
    $dumpvars(0, TB);
  end

endmodule