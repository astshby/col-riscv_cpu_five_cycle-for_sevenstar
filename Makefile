XLEN ?= 64
RISCV_GCC ?= riscv$(XLEN)-unknown-elf-gcc
RISCV_OBJCOPY ?= riscv$(XLEN)-unknown-elf-objcopy

BUILD_DIR = build
BSP_DIR = bsp

# 全局 C 编译参数 (含兼容老代码的规则)
CFLAGS = -march=rv32i_zicsr -mabi=ilp32 -O3 -fno-inline -std=gnu99 \
         -Wno-implicit-function-declaration -Wno-implicit-int \
         -fno-builtin-printf -fno-common -falign-functions=4 \
         -nostdlib -nostartfiles -T $(BSP_DIR)/link.ld

# Cocotb 仿真环境变量配置
export SIM_BUILD = $(BUILD_DIR)/sim_build
export WAVES = 1
export COCOTB_RESULTS_FILE = $(BUILD_DIR)/results.xml
export MODULE = test
export TOPLEVEL = TB
export VERILOG_SOURCES = $(PWD)/vsrc/top/*.sv $(PWD)/vsrc/core/*.sv $(PWD)/vsrc/for_tb/*.sv
export SIM = verilator
export TOPLEVEL_LANG = verilog
export EXTRA_ARGS = --trace --trace-structs --trace-fst --timing -j 8 -I$(PWD)/vsrc/include
export PYTHONDONTWRITEBYTECODE = 1

# riscv-tests (官方汇编测试集) 的指令列表与目标文件
RISCV_TESTS_LIST = add addi xori xor andi and auipc beq bge bgeu blt bltu bne jalr jal j lb lbu lh lhu lui lw ori or sb sh simple slli sll slti slt srai sra srli srl sub sw
RISCV_TEST_OBJS = $(addprefix $(BUILD_DIR)/riscv-tests/, $(addsuffix .o, $(RISCV_TESTS_LIST)))

# 默认目标：执行冒烟测试
all: smoke

smoke: prepare
	$(RISCV_GCC) $(CFLAGS) $(BSP_DIR)/boot_c.S test.c -o $(BUILD_DIR)/rv32i_test.elf
	@$(MAKE) run_sim TEST_NAME=smoke

dhrystone: prepare
	$(RISCV_GCC) $(CFLAGS) $(BSP_DIR)/boot_c.S dhrystone/*.c dhrystone/*.S -o $(BUILD_DIR)/rv32i_test.elf
	@$(MAKE) run_sim TEST_NAME=dhrystone

riscv-tests: prepare $(RISCV_TEST_OBJS)
	$(RISCV_GCC) $(CFLAGS) $(BSP_DIR)/boot_asm.S $(RISCV_TEST_OBJS) -o $(BUILD_DIR)/rv32i_test.elf
	@$(MAKE) run_sim TEST_NAME=riscv-tests

# riscv-tests 汇编文件的编译规则定义
$(BUILD_DIR)/riscv-tests/%.o: riscv-tests/rv32ui/%.S
	@mkdir -p $(dir $@)
	$(RISCV_GCC) $(CFLAGS) -c -o $@ -DTEST_FUNC_NAME=$* -DTEST_FUNC_TXT='"$*"' -DTEST_FUNC_RET=$*_ret $<

# 准备工作：创建 build 目录和 log 目录
prepare:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)/log

# 核心仿真流程：提取指令与数据，生成 mem 文件，并拉起 Verilator 和 Cocotb 仿真，并把精简结果重定向到报告中
run_sim:
	$(RISCV_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/rv32i_test.elf $(BUILD_DIR)/code.bin
	$(RISCV_OBJCOPY) -O binary -j .data -j .sdata $(BUILD_DIR)/rv32i_test.elf $(BUILD_DIR)/data.bin
	hexdump -v -e '1/4 "%08x\n"' $(BUILD_DIR)/code.bin > $(BUILD_DIR)/code.mem
	hexdump -v -e '1/4 "%08x\n"' $(BUILD_DIR)/data.bin > $(BUILD_DIR)/data.mem
	@echo "--- 仿真开始 ---" | tee $(BUILD_DIR)/log/$(TEST_NAME)_simulation_report.txt
	@$(MAKE) -s -f $(shell cocotb-config --makefiles)/Makefile.sim 2>&1 | tee -a $(BUILD_DIR)/log/$(TEST_NAME)_simulation_report.txt
	@echo "--- 报告提取 ---"
	@grep -E "Total Cycles|Number of Control Xfers|Number of Instructions|Wrong Branches|CPI:|Misprediction Rate|DMIPS/MHz|\.\.ok|\.\.error" $(BUILD_DIR)/log/$(TEST_NAME)_simulation_report.txt > $(BUILD_DIR)/log/$(TEST_NAME)_summary_report.txt || true
	@echo "报告已生成在: $(BUILD_DIR)/log/$(TEST_NAME)_summary_report.txt"

# 清理构建目录
clean:
	rm -rf $(BUILD_DIR) *.mem *.bin *.elf *dump* __pycache__ results.xml dump.fst sim_build
