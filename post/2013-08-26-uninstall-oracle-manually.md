## 手动卸载Oracle

直接使用安装完成后的Oracle自带的Uninstallation程序，也是可以部分完成我们所需的卸载功能，但是终究还是会遗留一部分需要手工参与的步骤。

而我今天所面临的问题是：2块硬盘，在上个礼拜其中一块硬盘罢工，幸好不是系统盘，免去了我要重装系统的麻烦；但麻烦的是损坏的F盘也是Oracle 11g所在磁盘，导致Oracle中服务及应用都不可使用。

虽然我手动将Oracle原有目录及文件（F:\app\user_name\...）拷贝了回去到原位置，但Oracle已然不能使用。尝试了2种方式去重装，没有成功：

- 运行Uninstallation，中止；

- 运行installation，企图覆盖原有程序，中止。

看到有些文章，说可以通过手动删除Oracle注册表项操作，但是不太想通过此种方式，但是在看到stackoverflow上一篇帖子后，处于对他们的信任，还是使用这种方式：

### Six-Step Process

- **Delete the Oracle services**: In the registry, go to \HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services and delete everything that starts with "Oracle"

- **Remove other Oracle stuff from the registry**: Go to \HKEY_LOCAL_MACHINE\SOFTWARE\ and delete the key ORACLE

- **Reboot**

- **Delete all the Oracle software** from the directories where you installed it

- **Delete the Oracle software inventory**: Delete the directory C:\Program Files\Oracle. You must do this no matter where you installed your Oracle software - the Oracle installer automatically writes information here.

- **Delete all shortcuts** from your Start menu.

参考链接： [How do I a manual uninstall of Oracle](http://stackoverflow.com/questions/83967/how-do-i-do-a-manual-uninstall-of-oracle)
