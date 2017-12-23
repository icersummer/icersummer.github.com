---
layout: post
title: "[Ubuntu] 怎样修改计算机名字"
date: 2013-11-06 20:25:03 -0800
comments: true
categories: [oldblog, Ubuntu] 
---


按下 Ctrl - Alt - T 组合键，打开终端。 当终端打开，输入下列命令，使用gedit编辑hostname文件

sudo gedit /etc/hostname

接下来，无论旧的计算机名字是什么，换一个新的吧。例如，如果你想要你的计算机名字为“RDOMNU”，先删除文件内容，输入 RDOMNU，然后保存文件。

然后，再输入下列命令来打开hosts文件

sudo gedit /etc/hosts

更改第二行箭头标记位置的值，使它与你刚才输入的计算机名字相符，完成后保存文件。

![Ubunbu hosts](../images/ubuntu-hostname.png)

重启，显示新的名字。

`$ sudo reboot -h 0`

参考链接：

* http://linux.cn/thread/11846/1/1/

* http://www.liberiangeek.net/2013/10/daily-ubuntu-tips-change-computer-name/