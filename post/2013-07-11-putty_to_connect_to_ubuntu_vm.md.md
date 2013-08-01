-- FileName : 2013-07-11-putty_to_connect_to_ubuntu_vm.md.md

## Putty连接VM中的Ubuntu问题及解决

问题：

VMWare中安装了Ubuntu，通过配置使其命令行模式启动；启动后通过$ifconfig获得其IP，通过Putty中设置IP、Port 22 访问报错，错误信息“不会出现登录界面，几秒钟后弹出窗口-Network error : Connection Refused”.

解决：

1. 可能没有开启ssh-server服务：

命令$ sudo apt-get install openssh-server

安装成功；之后还是之前同样的错误、不能Putty连接；

2. 安装openssh-client，但是Ubuntu缺省已经安装了openssh-client。

$sudo apt-get insall openssh-client

3. 确认sshserver已经启动：

$ps -e | grep ssh

如果没有看到ssh，则手动启动 $sudo /etc/init.d/ssh start (or $sudo service ssh start)

4. Putty依旧不能访问

关闭windows7防火墙，全部关闭，应该是windows禁止了通过22端口访问；可以连接成功。

5. VM Ubuntu端口改变问题

配置成功后，通过Putty连接没有问题，但是发现每过一段时间，就回出现连接丢失的现象；几次三番后，发现其IP在动态改变；解决办法是在VM Setting中修改Network Adapter方式，NAT -> Bridged。

（NAT: Used to share the host's IP address; Bridged: Connected directly to the physical network）

6. 其它说明

ssh-server配置文件位于/etc/ssh/sshd_config文件，可以修改ssh的服务端口，默认是22,；修改后重启ssh服务： $sudo /etc/init.d/ssh restart

7. 遗留问题

只能通过IP+Port的方式访问，如何才能通过hostname访问呢？

8. JDK下载，通过curl

8.1 安装 curl：$sudo apt-get curl

8.2 how to download Oracle JDK without browser: [https://gist.github.com/hgomez/4697585]

8.3 使用SecureCRT所带SFTP上传JDK至Ubuntu，版本jdk-7u25-linux-i586.tar.gz
```
vincent@ubuntu:~$ tar -xf jdk-7u25-linux-i586.tar.gz 
vincent@ubuntu:~$ ls
Desktop    examples.desktop            Music     Templates
Documents  jdk1.7.0_25                 Pictures  Videos
Downloads  jdk-7u25-linux-i586.tar.gz  Public
vincent@ubuntu:~$ cd jdk1.7.0_25/
vincent@ubuntu:~/jdk1.7.0_25$ cd bin
vincent@ubuntu:~/jdk1.7.0_25/bin$ ./java -version
java version "1.7.0_25"
Java(TM) SE Runtime Environment (build 1.7.0_25-b15)
Java HotSpot(TM) Client VM (build 23.25-b01, mixed mode)
```
配置JDK variables
```
vincent@ubuntu:~$ vi .bashrc

# export my own variables
JAVA_HOME=/home/vincent/jdk1.7.0_25
export JAVA_HOME
PATH=$PATH:$JAVA_HOME/bin
export PATH

vincent@ubuntu:~$ source .bashrc
vincent@ubuntu:~$ java -version
java version "1.7.0_25"
Java(TM) SE Runtime Environment (build 1.7.0_25-b15)
Java HotSpot(TM) Client VM (build 23.25-b01, mixed mode)
```

9. 安装Hadoop

9.1 [下载地址, http://mirror.cogentco.com/pub/apache/hadoop/common/hadoop-2.0.5-alpha/]

9.2 Setting up a Single Node Cluster, follow <B>Running Hadoop on Ubuntu Linux (Single-Node Cluster)</B> [http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-single-node-cluster/]

>  The main goal of this tutorial is to get a simple Hadoop installation up and running so that you can play around with the software and learn more about it.

9.3 添加Hadoop专用user
```
vincent@ubuntu:~$ sudo addgroup hadoop
[sudo] password for vincent: 
Adding group `hadoop' (GID 1001) ...
Done.
vincent@ubuntu:~$ sudo adduser --ingroup hadoop hduser
Adding user `hduser' ...
Adding new user `hduser' (1001) with group `hadoop' ...
Creating home directory `/home/hduser' ...
Copying files from `/etc/skel' ...
Enter new UNIX password: 
Retype new UNIX password: 
Sorry, passwords do not match
passwd: Authentication token manipulation error
passwd: password unchanged
Try again? [y/N] y
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
Changing the user information for hduser
Enter the new value, or press ENTER for the default
        Full Name []: hadoop user
        Room Number []: 
        Work Phone []: 
        Home Phone []: 
        Other []: 
Is the information correct? [Y/n] y
```

9.4 需要设置SSH远程自动登录，需要其他机器直接访问Hadoop node，configure it to allow SSH public key authentication. 参考[Ubuntu Guide, http://ubuntuguide.org/wiki/Ubuntu_Raring]

- (这个时候，考虑，是不是之前使用user vincent配置了Java环境变量是不是不对、应该配置为全局变量？ 后面再看。)

```
hduser@ubuntu:~$ ssh-keygen -t rsa -P ""
Generating public/private rsa key pair.
Enter file in which to save the key (/home/hduser/.ssh/id_rsa): 
Created directory '/home/hduser/.ssh'.
Your identification has been saved in /home/hduser/.ssh/id_rsa.
Your public key has been saved in /home/hduser/.ssh/id_rsa.pub.
The key fingerprint is:
9f:28:f3:80:ae:6c:64:d6:78:74:74:67:fa:21:91:f3 hduser@ubuntu
The key's randomart image is:
+--[ RSA 2048]----+
|         .       |
|      . = o      |
|     . . B       |
|    . . o E      |
|   + .  So .     |
|  = o.   o..     |
| + .. + . o      |
| ...   =         |
| .o..   .        |
+-----------------+
hduser@ubuntu:~$ ll
hduser@ubuntu:~$ cat .ssh/id_rsa.pub >> .ssh/authorized_keys

//测试是否可以无密码登录
hduser@ubuntu:~/.ssh$ ssh localhost 
The authenticity of host 'localhost (127.0.0.1)' can't be established.
ECDSA key fingerprint is 47:6b:7b:a6:e4:80:38:96:f9:9c:a3:58:48:f4:51:82.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'localhost' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)

 * Documentation:  https://help.ubuntu.com/

Last login: Wed Jul 31 01:38:45 2013 from gjia2d.ptcnet.ptc.com
hduser@ubuntu:~$ 
```

9.5 开始安装配置Hadoop

- 配置Hadoop user hduser 加入sudo权限中（需要这一步么？todo……）

```
vincent@ubuntu:/etc$ cd /etc/
vincent@ubuntu:/etc$ ll sudo*
-r--r----- 1 root root  767 Jul 31 02:17 sudoers

sudoers.d:
total 20
drwxr-xr-x   2 root root  4096 Apr 23  2012 ./
drwxr-xr-x 127 root root 12288 Jul 31 02:17 ../
-r--r-----   1 root root   753 Jan 31  2012 README
vincent@ubuntu:/etc$ sudo vi sudoers

// add sudo users
hduser ALL=(ALL) ALL
// sudoers文件的修改立即生效
```

- 添加Hadoop相关变量设置到hduser的$HOME/.bashrc

```
// vj, add Hadoop Variables
hduser@ubuntu:~$ vi .bashrc

HADOOP_HOME=/home/hduser/hadoop-2.0.5-alpha
export HADOOP_HOME
JAVA_HOME=/home/vincent/jdk1.7.0_25
export JAVA_HOME

//Some convenient aliases and functions for running Hadoop-related commands
unalias fs &> /dev/null
alias fs="hadoop fs"
unalias hls &> /dev/null
alias hls="fs -ls"

PATH=$PATH:$HADOOP_HOME/bin
export PATH

hduser@ubuntu:~$ hadoop version
Hadoop 2.0.5-alpha
Subversion http://svn.apache.org/repos/asf/hadoop/common -r 1488459
Compiled by jenkins on 2013-06-01T04:05Z
From source with checksum c8f4bd45ac25c31b815f311b32ef17
This command was run using /home/hduser/hadoop-2.0.5-alpha/share/hadoop/common/hadoop-common-2.0.5-alpha.jar
```

TODO：

- 当前时间显示是PDT时区(Wed Jul 31 01:46:14 PDT 2013)，如何配置显示东八区时间？

补充资料：

- Ubuntu Environment Variables [https://help.ubuntu.com/community/EnvironmentVariables]

- # What's Hadoop Distributed File System (HDFS)

> The Hadoop Distributed File System (HDFS) is a distributed file system designed to run on commodity hardware. It has many similarities with existing distributed file systems. However, the differences from other distributed file systems are significant. HDFS is highly fault-tolerant and is designed to be deployed on low-cost hardware. HDFS provides high throughput access to application data and is suitable for applications that have large data sets. HDFS relaxes a few POSIX requirements to enable streaming access to file system data. HDFS was originally built as infrastructure for the Apache Nutch web search engine project. HDFS is part of the Apache Hadoop project, which is part of the Apache Lucene project.

> <I><B>The Hadoop Distributed File System: Architecture and Design</B> - (hadoop.apache.org/hdfs/docs/…)[http://hadoop.apache.org/hdfs/docs/current/hdfs_design.html]</I>

EOF.
