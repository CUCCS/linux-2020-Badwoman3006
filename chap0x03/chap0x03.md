# 第三章：Linux服务器系统管理基础

##实验目的

* 实践system相关命令


##软件环境

* 虚拟机VirtualBox

* Ubuntu 18.04 Server 64bit

## 实验过程

* 命令篇
  https://asciinema.org/a/8JdsE12nHSx1sOy90zUAE9PPL

* 实战篇
  https://asciinema.org/a/9TTp84NbIjm9UK45eHIqjZP6E

##自查清单

####1、如何添加一个用户并使其具备sudo执行程序的权限？

    adduser xxx

    xxx ALL=(ALL) ALL

####2、如何将一个用户添加到一个用户组？

    usermod -a username -G groupname

####3、如何查看当前系统的分区表和文件系统详细信息？
    sudo fdisk -l
    sudo cfdisk   （查看当前系统分区表）

    df -a(文件系统详细信息)

####4、如何实现开机自动挂载Virtualbox的共享目录分区？
    在文件 /etc/rc.local 中（用root用户）追加如下命令 
    mount -t vboxsf sharingtest /mnt/share
    virtualbox中设置共享文件夹可直接勾选自动挂载

####5、基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？
    增加容量：lvreduce -L +size /dev/dir
    减少容量：lvreduce -L -size /dev/dir

####6、如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？

    [Service]
    ExecStartPost=<脚本1路径> 
    ExecStartPost=<脚本2路径>

####7、如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？

    [Service]
    Restart=always

## 参考资料
    [Systemd 入门教程：命令篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)
    [Systemd 入门教程：实战篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)