#!/bin/bash

# ==============================================================================
# Vivado TCL 修复脚本 (正则自适应路径版)
# 用法: ./fix_tcl.sh ./cpu-five.tcl
# ==============================================================================

# 1. 参数校验
if [ -z "$1" ]; then
    echo "使用错误！请输入要修改的 TCL 文件路径。"
    echo "用法: $0 <文件路径.tcl>"
    exit 1
fi

TCL_FILE="$1"

if [ ! -f "$TCL_FILE" ]; then
    echo "【致命错误】找不到文件: $TCL_FILE"
    exit 1
fi

echo "开始扫描并修复 TCL 脚本: $TCL_FILE ..."
MODIFIED=0

# ==============================================================================
# 修改 1: 寻找并替换 origin_dir
# ==============================================================================
# 使用 grep 检查是否存在准确的 set origin_dir "."
if grep -q 'set origin_dir "\."' "$TCL_FILE"; then
    # 使用 sed 进行原址替换 (-i)
    sed -i 's/set origin_dir "\."/set origin_dir "\.\."/g' "$TCL_FILE"
    echo "  -> [成功] 已将 origin_dir 从 \".\" 修改为 \"..\""
    MODIFIED=1
else
    echo "  -> [跳过] 未发现 'set origin_dir \".\"' (可能已被修改或不存在)"
fi

# ==============================================================================
# 修改 2: 正则匹配并替换自定义 IP 路径 (针对每个人不同的绝对路径)
# ==============================================================================
# 正则说明：匹配 -value "任何非引号的内容" 
# [^"]* 就相当于你说的通配符，它会吃掉从 "/home/linxiaoyuan/..." 到 "/Users/xxx/..." 的任何路径
REGEX_IP_LOC='set_property -name "customized_default_ip_location" -value "[^"]*" -objects \$obj'

if grep -E -q "$REGEX_IP_LOC" "$TCL_FILE"; then
    # sed 正则替换，把 -value 里面的乱七八糟路径，统统替换为 ${origin_dir}/ip
    # 注意 \/ 是转义斜杠，\$obj 是转义美元符号
    sed -i -E 's/set_property -name "customized_default_ip_location" -value "[^"]*" -objects \$obj/set_property -name "customized_default_ip_location" -value "${origin_dir}\/ip" -objects \$obj/g' "$TCL_FILE"
    echo "  -> [成功] 已将定制 IP 路径正则替换为 \"\${origin_dir}/ip\""
    MODIFIED=1
else
    echo "  -> [跳过] 未发现 customized_default_ip_location 的配置串 (可能已被修改或不存在)"
fi

# ==============================================================================
# 结束报告
# ==============================================================================
echo "--------------------------------------------------------"
if [ $MODIFIED -eq 1 ]; then
    echo "修复完成！你的 TCL 脚本现在是团队通用版了。"
else
    echo "扫描完毕！文件非常健康，不需要任何修改。"
fi
