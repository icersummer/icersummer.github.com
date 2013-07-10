##Ubuntu CommandLine

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

EOF.
