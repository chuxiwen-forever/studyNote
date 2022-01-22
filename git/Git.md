



# Git



## 初始化Git

查看git版本命令  **git --version**

设置用户名  **git config --global user.name "xxx"**

设置邮箱   **git config --global user.email "xxx@xx.com"**



## 操作本地仓库

工作区  -->  暂存区 --> 本地库

初始化仓库  **git init**

将文件提交到暂存区   **git add "文件名"  --> git add w.txt**

> 提交全部文件   **git add .**

将暂存区的内容提交到本地库  **git commit -m "xxx"**

查看暂存区状态  **git status**

查看提交记录   **git log** 

> 拓展
>
> 下一页   空格
>
> 上一页   b
>
> 退出日志浏览 q
>
> 日志信息在一行显示   **git log --pretty=oneline**
>
> 将日志信息更简便的显示  **git log --oneline**
>
> 多了日志指针信息   **git reflog**

选择跳转的版本  **git reset --hard "索引号"  --> git reset --hard 6dst**

> 拓展
>
> 下面参数都可以重置本地库
>
> --hard   重置工作区和暂存区
>
> --mixed  重置暂存区，不重置工作区
>
> --soft  工作区和暂存区都不重置

比对工作区和暂存区中的不一致  git diff  "文件名"  --> git diff 1.txt

> 比对所有文件  git diff 
>
> 比对暂存区和本地库中代码 git diff  "索引号"



## 分支相关操作

查看分支  **git branch -v**

> 查看全部分支包括远程   **git branch -a**
>
> 查看远程分支名称  **git branch -r**

创建分支 **git branch "分支名称"**

切换分支  **git checkout "分支名称"**

合并分支 **git merge "分支名称"**

删除分支  **git branch -D "分支名称"**

改变分支名称  **git branch -m "旧名" "新名"**





## 远程到GitHub

查看远程别名  **git remote -v**

添加远程仓库  **git  remote add "别名"  "github仓库地址"**

把本地库的文件推送到远程  **git push "别名" "分支"**

> 远程和本地都只有一个分支 **git push**
>
> 注意：远程和本地绑定时需要先进行同步
>
> **git pull "别名" "分支"**

克隆远程代码  **git clone "仓库地址"**

推送新的分支到远程  **git push --set-upstream "别名" "分支名称"**

删除远程分支  **git push "别名" --delete "分支名称"**





## 团队多人合作

抓取远程库的代码   **git fetch "别名" "分支"**

进入远程库检查  **git checkout "别名"/"分支"**

合并远程库的文件  **git merge  "别名"/"分支"**

> 合并fetch和merge操作  **git  pull "别名"  "分支"**
>
> 拓展
>
> 合并不相关仓库代码
>
> **git pull "远程仓库地址" "分支" --allow-unrelated-histories**
>
> 进行代码推送
>
> **git push -u "远程仓库地址" "分支" -f**



## 跨团队合作

主要是github上的操作

这里略



## SSH免密码

获取ssh公钥和私钥  **ssh-keygen -t rsa -C "github申请的邮箱"**

