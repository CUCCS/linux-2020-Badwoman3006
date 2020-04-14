# 第二章实验

# 软件环境

## Ubuntu 18.04 Server 64bit

## 在asciinema注册一个账号，并在本地安装配置好asciinema

# 实验过程

## 首先需要下载好asciinema

## sudo apt-get install asciinema

## 完成本地连接

## asciinema auth

## 录制方式：

## asciinema rec(开始录屏)

## exit 或 ctrl-D(结束录屏)

# Vimtutor录像

# [第一课](https://asciinema.org/a/0ob2QvqPi1lch33YcfuhT7Cfm)

# [第二课](https://asciinema.org/a/ukyUDKUeyVxXeMNmTBlKhYleJ)

# [第三课](https://asciinema.org/a/cbaIq47RRSf4Vw2og8oQQ7B8J)

# [第四课](https://asciinema.org/a/8BucML0lor7YtYQWUh3WeGH5t)

# [第五课](https://asciinema.org/a/hgJeQyvEsqIN8qI1X6Q5I9whv)

# [第六课](https://asciinema.org/a/oiG1PTvFjp0ZmwpskvVGsPDik)

# [第七课](https://asciinema.org/a/Jngr8r4MekrtOTG5YmYjTjPbt)

***

#  vimtutor完成后的自查清单

## 你了解vim有哪几种工作模式？
vim一共有4个模式：

正常模式 (Normal-mode)

插入模式 (Insert-mode)

命令模式 (Command-mode)

可视模式 (Visual-mode)

## Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行？

下移10行：10j

移动到开始行：gg

移动到结束行：G

快速跳转到第N行：NG

## Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？

删除单个字符：x

删除单个单词：dw

光标删除到行尾：d$

单行：dd

当前行向下数N行：Ndd

## 如何在vim中快速插入N个空行？如何在vim中快速输入80个-？

N个空行：No ESC

80个-：80i- ESC

## 如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作？

撤销：u

重做：ctrl-R

## vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢？

当使用d删除后，删除的字符等会保留在编辑器中，按P即可粘贴，或者按V进入可视模式，选中之后按Y复制，P粘贴。

## 为了编辑一段文本你能想到哪几种操作方式（按键序列）？

O，o：在该行前后插入新的一行

a，i：插入（位置不同）

e：移动光标到下一个单词

大写R：置换多个字符

:s/xxx/xxx：替换（前替换后）/g全部替换

d：删除

## 查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法？

ctrl G

## 在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换？

正向查找：/  逆向：?

忽略大小写匹配搜索：:set ic

搜索结果高亮显示：:set hls is

匹配结果批量替换：:s/xxx/xxx/g

## 在文件中最近编辑过的位置来回快速跳转的方法？

上一次编辑的位置：Ctrl-i

下一次编辑的位置：Ctrl-o

## 如何把光标定位到各种括号的匹配项？例如：找到(, [, or {对应匹配的),], or }

光标对准括号，然后按%

## 在不退出vim的情况下执行一个外部程序的方法？

:!

## 如何使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法？如何在两个不同的分屏窗口中移动光标？

帮助： :help

ctrl W