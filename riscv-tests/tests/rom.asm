    .text
    .globl _start
_start:
    # 寄存器清零 (初始化)
    li x1, 0
    li x2, 0
    li x3, 0
    li x4, 0

    # 假设数据存储器(RAM)基地址从 0x00000000 开始
    # 根据我们存放的 RAM 初始化数据：
    # 0(x0) = start (起始值，例如 1)
    # 4(x0) = end   (结束值，例如 10)
    # 8(x0) = step  (步长，例如 1)
    
    lw x5, 0(x0)    # x5 = start
    lw x6, 4(x0)    # x6 = end
    lw x7, 8(x0)    # x7 = step
    
    li x8, 0        # x8 = sum (累加器清零)

loop:
    bgeu x5, x6, loop_done  # 如果 x5 >= x6 (无符号)，其实应该用带符号或检查是否到达，为了包含边界使用 bgt 或分别比较，这里使用如果 start > end 就跳出
    # 为了包含 end (如 1加到10=55)，使用 bgt：
    # 因为没有标准 bgt 伪指令对应的直接指令，汇编器会自动转换为 blt x6, x5, loop_done
    bgt x5, x6, loop_done

    add x8, x8, x5  # sum = sum + start
    add x5, x5, x7  # start = start + step
    j loop          # 跳转回 loop

loop_done:
    sw x8, 12(x0)   # 将算出的和 (sum) 存入 RAM 的 12(x0) 地址处
    
halt:
    j halt          # 死循环，代表程序结束
