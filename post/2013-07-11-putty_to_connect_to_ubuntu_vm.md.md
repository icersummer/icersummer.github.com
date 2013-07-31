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


EOF.
