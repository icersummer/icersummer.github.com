---
layout: post
title: "SCP命令的使用"
date: 2014-04-15 20:12:03 -0800
comments: true
categories: [scp, linux, centos, ubuntu] 
---

**复制文件**

SCP命令用于在Linux间拷贝文件，（可以在拷贝过程中重命名）

scp [可选参数] file_source file_target

从本地复制到远程：

scp local_file remote_username@remote_ip:remote_folder

scp local_file remote_username@remote_ip:remote_folder

scp local_file remote_ip:remote_folder

scp local_file remote_ip:remote_file

用法示例：

user1 in centos, user2 in ubuntu

copy file1 from centos to ubuntu

```
$scp /home/user1/downloads/file1 user2@ubuntu_ip:/home/user2/
type in the password of user2
```

**复制目录**

scp -r local_folder remote_username@remote_ip:remote_folder


**从远程复制到本地**

scp remote_user@remote_ip:remote_file locale_file_path

scp -r remote_user@remote_ip:remote_folder locale_folder_path

