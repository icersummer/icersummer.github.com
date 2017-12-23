---
layout: post
title: "Ubuntu CommandLine"
date: 2013-07-10 12:09:03 -0800
comments: true
categories: [oldblog, Ubuntu] 
---

***

**X-Window模式**

使用VM安装Ubuntu，如果使用X-window启动方式，会占用过多内存，而且操作方式并不是很方便，所以修改配置，使其可以启动直接进入命令行模式。

可以通过X-window登陆后，运行如下命令如下：

'''
$sudo gedit /etc/default/grub

--修改行
$GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"为

$GRUB_CMDLINE_LINUX_DEFAULT="quiet splash text"

$sudo update-grub

$sudo reboot
'''

***

**CMD启动X-Window**

命令行方式登录进入系统后，可以通过$startx命令进入图形界面

- 在系统终端（比如VMWare中）执行$startx，系统直接启动图形界面；

- 在Terminal端（如Putty或SecureCRT）中执行$startx，则系统终端会启动图形界面，而SecureCRT端则只有类log输出：

```
hduser@ubuntu:~$ startx
xauth:  file /home/hduser/.Xauthority does not exist

X: user not authorized to run the X server, aborting.
sudo startx
xinit: giving up
xinit: unable to connect to X server: No such file or directory
xinit: server error
hduser@ubuntu:~$ sudo startx
[sudo] password for hduser: 


X.Org X Server 1.11.3
Release Date: 2011-12-16
X Protocol Version 11, Revision 0
Build Operating System: Linux 2.6.24-29-server i686 Ubuntu
Current Operating System: Linux ubuntu 3.2.0-23-generic-pae #36-Ubuntu SMP Tue Apr 10 22:19:09 UTC 2012 i686
Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.2.0-23-generic-pae root=UUID=4594ceba-abdf-430c-9f6e-910d0ad98e52 ro quiet splash text
Build Date: 04 April 2012  11:58:38PM
xorg-server 2:1.11.4-0ubuntu10 (For technical support please see http://www.ubuntu.com/support) 
Current version of pixman: 0.24.4
        Before reporting problems, check http://wiki.x.org
        to make sure that you have the latest version.
Markers: (--) probed, (**) from config file, (==) default setting,
        (++) from command line, (!!) notice, (II) informational,
        (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.0.log", Time: Fri Aug  2 00:11:15 2013
(==) Using system config directory "/usr/share/X11/xorg.conf.d"
(EE) open /dev/fb0: No such file or directory
(EE) vmware(0): Device is not screen object capable.
^Cxinit: connection to X server lost

waiting for X server to shut down .... ddxSigGiveUp: Closing log
Server terminated successfully (0). Closing log file.
.
xinit: unexpected signal 2
```

Ctrl+C退出。

***

只是不能直接由X-Window切换回CMD，只能够执行命令reboot进行返回：

```
hduser@ubuntu:~$ sudo reboot -h 0
[sudo] password for hduser: 

Broadcast message from hduser@ubuntu
        (/dev/pts/0) at 0:56 ...

The system is going down for reboot NOW!
```

EOF.
