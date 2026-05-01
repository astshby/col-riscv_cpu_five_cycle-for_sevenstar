import os
import subprocess
import binascii

# 编译和链接汇编文件
print("Assembling and linking...")
subprocess.run([
    "riscv64-unknown-elf-as", "-march=rv32i", "-mabi=ilp32", 
    "riscv-tests/tests/rom.asm", "-o", "riscv-tests/tests/rom.o"
], check=True)

subprocess.run([
    "riscv64-unknown-elf-ld", "-m", "elf32lriscv", "-Ttext", "0x0", 
    "riscv-tests/tests/rom.o", "-o", "riscv-tests/tests/rom.elf"
], check=True)

subprocess.run([
    "riscv64-unknown-elf-objcopy", "-O", "binary", 
    "riscv-tests/tests/rom.elf", "riscv-tests/tests/rom.bin"
], check=True)

# 将二进制转换为 COE
print("Generating rom.coe...")
with open("riscv-tests/tests/rom.bin", "rb") as f:
    data = f.read()

# 确保长度是 4 的倍数 (32-bit word)
if len(data) % 4 != 0:
    data += b'\x00' * (4 - len(data) % 4)

words = []
for i in range(0, len(data), 4):
    word_int = int.from_bytes(data[i:i+4], byteorder='little')
    words.append(f"{word_int:08X}")

coe_content = "memory_initialization_radix=16;\nmemory_initialization_vector=\n"
coe_content += ",\n".join(words) + ";\n"

with open("riscv-tests/tests/rom.coe", "w") as f:
    f.write(coe_content)

# 生成 RAM 的初始化数据 (1加到10，步长1)
# start=1 (0x1), end=10 (0xA), step=1 (0x1), 占位 result=0 (0x0)
print("Generating ram.coe and ram.hex...")
ram_words = ["00000001", "0000000A", "00000001", "00000000"]

# RAM COE
ram_coe_content = "memory_initialization_radix=16;\nmemory_initialization_vector=\n"
ram_coe_content += ",\n".join(ram_words) + ";\n"
with open("riscv-tests/tests/ram.coe", "w") as f:
    f.write(ram_coe_content)

# RAM HEX (用于 Vivado 的纯十六进制文件形式，如果有需要)
with open("riscv-tests/tests/ram.hex", "w") as f:
    f.write("\n".join(ram_words) + "\n")

print("Done!")
