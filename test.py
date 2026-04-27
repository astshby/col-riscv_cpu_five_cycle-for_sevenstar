# test_my_design.py (simple)

import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

@cocotb.test()
async def isa_test(dut):
    """Try accessing the design."""
    clk = Clock(dut.clk, 1, "ns")
    # Use predictor is not in col-*, ignore or set to 0 if it exists
    try:
        dut.uut.usePredictor.value = 0
    except:
        pass
    cocotb.start_soon(clk.start())
    for i in range(1):
        dut.rst.value = 1
        await Timer(1, "ns")
    dut.rst.value = 0
    
    while(True):
        await Timer(1, "ns")
        # Check if 0xDEADC0DE is written to register file
        try:
            wen = dut.uut.core_top.ID_stage.regfile.wen.value
            wdata = dut.uut.core_top.ID_stage.regfile.wdata.value
            if wen == 1 and wdata == 0xDEADC0DE:
                break
        except:
            pass