## how to setup Goagent in Chrome and Firefox


如何部署和使用goagent，以Windows为例：

--申请Google Appengine并创建appid。
--下载goagent最新版 https://code.google.com/p/goagent/
--修改local\proxy.ini中的[gae]下的appid=你的appid(多appid请用|隔开)
--双击server\uploader.bat(Mac/Linux上传方法请见FAQ)，上传成功后即可使用了(地址127.0.0.1:8087)
--chrome请安装SwitchySharp插件，然后导入这个设置https://goagent.googlecode.com/files/SwitchyOptions.bak，或备份下载地址
firefox请安装FoxyProxy，Firefox需要导入证书，方法请见FAQ

碰到的问题：
1. 不知道怎么回事，我的本机Chrome不能在store中安装SwitchySharp插件，看不到add this plugin按钮，总是出现链向Chrome下载页面的超链。
2. Firefox，安装FoxyProxy，设置如下：
	1.新建代理服务器：127.0.0.1:8087；
	2.选择工作模式：为全部URLs启用代理服务器“127.0.0.1:8087”。

参考列表：

1. Goagent官网地址: Goagent(https://code.google.com/p/goagent/), 有时需要https、或者越墙访问。
2. GoAgent图文设置教程： http://tieba.baidu.com/p/1953354996
