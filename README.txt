首次配置（只需要做一次）
   git clone github_link
   cd col-riscv_cpu_five_cycle-for_sevenstar
   mkdir vivado-workspace
   cd vivado-workspace
   vivado -mode batch -source ../cpu-five.tcl

日常写代码
1.更新到最新版本:
   git checkout main
   git pull origin main

2.创建你的分支:
   git checkout -b <branch_name>

3.打开 Vivado工作：
   git checkout -b <branch_name>
   cd vivado-workspace
   rm cpu...
   vivado -mode batch -source ../cpu-five.tcl
   vivado ...
   注意：只修改 vsrc/ 里面的代码，千万别改外面的东西！

4.检查你的修改（随时可以）：
   git status  （红色的字就是你修改过的文件）

5.修改vivado的tcl：
   write_project_tcl -force ../cpu-five.tcl
   手动修改set origin_dir "."为 set origin_dir ".."
   手动修改ip核的读取定位为 ${origin_dir}/ip
   搜索你的用户名 找到所有绝对位置 改为相对位置
   (可以使用py脚本)

代码更新：
1.暂存并提交你的修改：
   git add .
   git commit -m "feat: 完成了 ALU 模块的加法运算"

2.把你的分支推送到云端：
   git push origin <branch_name>
   注意：不接受不PR提交到main

3.发起PR：
   去 GitHub 网页版，你会看到一个醒目的绿色按钮 "Compare & pull request"。
   点击它，写明你改了什么，然后等我来 Review 代码并合并
   (注意：你写你的内容，我修改时候Squash and merge为一次提交)

4.PR成功：  
   合并完成后，本地执行：
   git checkout main
   git pull origin main
   git branch -d dev-decoder
   git push origin --delete dev-decoder  #忘记删除网络分支再用这个

绝对不可触碰的红线
1.绝对不要把 vivado-workspace 里的任何东西 add 进 Git！(.gitignore 已经保护了，但别手动强加)
2.同一天绝对不能修改同一个 .v 文件，否则合并时会爆炸！
3.千万不要自己强行合并主分支！
