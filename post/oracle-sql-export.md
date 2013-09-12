## 使用SQLPlus导出结果集


SQL> spool d:\aa.txt
SQL> select * from dual;

D
-
X

SQL> spool off

输出到Excel文件

SQL> set termout off
SQL> set heading off
SQL> set pagesize 0
SQL> set verify off
SQL> set echo off
SQL> spool /tmp/aaa.csv
SQL> select id || ',' || name || ',' from test;   #多字个段分列存放在表格中
1,,
2,,
3,6,
,7,

SQL> spool off