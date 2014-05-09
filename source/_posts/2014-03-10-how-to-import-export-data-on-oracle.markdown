---
layout: post
title: "导入、导出Oracle数据"
date: 2014-03-10 20:12:03 -0800
comments: true
categories: [oracle, Markdown] 
---

导出数据： exp myadmin/myadmin@myinstace
(data store on c:\backup.dmp)

导入数据：
sqlplus / as sysdba; 
(问题TBD: 为什么有的命令行可以运行并登录sqlplus / as sysdba; 而有的机器却报错，而且只能通过输入用户名密码的方式登录如：sqlplus system/password as sysdba; 区别和设置在哪里。)
create user vjtest identified by vjtest;
grant dba to vjtest;

imp fromuser myadmin touser vjtest file=c:\backup.dmp
(在提问中输入用户名、密码：vjtest, vjtest)

同一用户的话使用：imp fromuser myadmin touser myadmin file=c:\backup.dmp

added in Apr.16th

执行报错：

```
D:\Users\vjia>imp system/syspwd fromuser=itadmin touser=testdb file=c:\data_dmp.dmp full=y

Import: Release 11.2.0.1.0 - Production on Wed Apr 16 12:33:35 2014

Copyright (c) 1982, 2009, Oracle and/or its affiliates.  All rights reserved.


IMP-00058: ORACLE error 12560 encountered
ORA-12560: TNS:protocol adapter error
IMP-00000: Import terminated unsuccessfully
```

错误原因在于：

(参考这里)[http://www.orafaq.com/forum/t/175836/]

```
ORA-12560: TNS:protocol adapter error
The database is local to the machine you try to execute this command and your ORACLE_SID is not set.
ORA-12154: TNS:could not resolve the connect identifier specified
The database is remote from the machine you try to execute this command and your tnsname.ora does not know the entry you gave (orclimpl)
In first case, set ORACLE_SID; in latter one, add the entry in your tnsnames.ora (and check there is a listener on database server).
```

解决方法就是：设置Oracle SID后再试

```
D:\Users\vjia>set ORACLE_SID=scottfeb

D:\Users\vjia>imp system/syspwd fromuser=itadmin touser=testdb file=c:\data_dmp.dmp full=y

Import: Release 11.2.0.1.0 - Production on Wed Apr 16 13:30:10 2014

Copyright (c) 1982, 2009, Oracle and/or its affiliates.  All rights reserved.


Connected to: Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

Export file created by EXPORT:V11.02.00 via conventional path

Warning: the objects were exported by ITADMIN, not by you

import done in WE8MSWIN1252 character set and UTF8 NCHAR character set
import server uses AL32UTF8 character set (possible charset conversion)
. importing ITADMIN's objects into TESTDB
. . importing table                         "TEAM"       2789 rows imported
. . importing table         			   "TEAMD"          0 rows imported
About to enable constraints...
Import terminated successfully with warnings.
```

