import sys
import os

def modify_tcl_script(file_path):
    if not os.path.exists(file_path):
        print(f"找不到文件: {file_path}")
        return

    # 读取原始文件内容
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # ================= 修改区 =================
    
    # 修改 1: 替换 origin_dir
    old_str_1 = 'set origin_dir "."'
    new_str_1 = 'set origin_dir ".."'
    content = content.replace(old_str_1, new_str_1)

    # 修改 2: (你提到的第二个地方，可以直接在这里填入)
    old_str_2 = 'set_property -name "customized_default_ip_location" -value "/home/linxiaoyuan/cpu_collaboration/col-riscv_cpu_single_cycle-for_sevenstar/ip" -objects $obj'
    new_str_2 = 'set_property -name "customized_default_ip_location" -value "${origin_dir}/ip" -objects $obj'
    content = content.replace(old_str_2, new_str_2)
    
    # =========================================

    # 将修改后的内容写回文件
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(content)

    print(f"成功修改并保存了脚本: {file_path}")

if __name__ == "__main__":
    # 检查是否传入了文件路径
    if len(sys.argv) < 2:
        print("用法: python3 fix_tcl.py cpu-single.tcl")
    else:
        modify_tcl_script(sys.argv[1])
