---
layout: post
title: "Oracle命令集合"
date: 2013-10-23 20:23:03 -0800
comments: true
categories: [oldblog, Oracle] 
---


1. 查询表结构基本信息

```
select * from user_tables;

select * from user_tab_comments;

select * from user_tables t, user_tab_comments c where t.table_name = c.table_name and t.table_name = 'INDEXSTATUS';
```

2. 查询表的所有列及其属性

```
select t.COLUMN_NAME,
 
       t.DATA_TYPE,
 
       t.DATA_LENGTH,
 
       t.DATA_PRECISION,
 
       t.NULLABLE,
 
       t.COLUMN_ID,
 
       c.COMMENTS
 
  from user_tab_columns t, user_col_comments c
 
 where t.table_name = c.table_name
 
   and t.column_name = c.column_name
 
   and t.table_name = '表名'
 
   order by t.COLUMN_ID ;
```

3  . 查找表的主键（包括名称，构成列）

select cu.*,c.DATA_TYPE
 
  from user_cons_columns cu, user_constraints au,user_tab_columns c
 
 where cu.constraint_name = au.constraint_name
 
   and c.COLUMN_NAME = cu.column_name
 
   and c.TABLE_NAME = cu.table_name
 
   and au.constraint_type = 'P'
 
   and au.table_name = '表名'
  
4 . 查找表的所有索引（包括索引名，类型，构成列）
 
select t.*, i.index_type
 
  from user_ind_columns t, user_indexes i
 
 where t.index_name = i.index_name
 
   and t.table_name = i.table_name
 
   and t.table_name = '表名'
 
5.查找表的唯一性约束（包括名称，构成列）
 
select column_name
 
  from user_cons_columns cu, user_constraints au
 
 where cu.constraint_name = au.constraint_name
 
   and au.constraint_type = 'U'
 
   and au.table_name = '表名'
 
6. 查找表的外键（包括名称，引用表的表名和对应的键名，下面是分成多步查询）
 
select *
 
  from user_constraints c
 
 where c.constraint_type = 'R'
 
   and c.table_name = '表名'
 
7. 查询外键约束的列名
 
select * from user_cons_columns cl where cl.constraint_name = '外键名称'
 
8.查询引用表的键的列名
 
select * from user_cons_columns cl where cl.constraint_name = '外键引用表的键名'
 

参考来源：Linux公社网站(www.linuxidc.com)  http://www.linuxidc.com/Linux/2012-02/54944.htm

获取某张表上建立的Trigger

select * from all_triggers where table_name = upper('tableName');

若在SQLPLUS下创建Procedure、Function，需要在末尾或者SQL文件末尾加入'/'，如下：
CREATE FUNCTION GETEMPSALARY (EMPNUMBER IN INTEGER) RETURN INTEGER
IS
DECLARE
EMPSALARY INTEGER;
BEGIN
SELECT SAL INTO EMPSALARY FROM EMP WHERE EMP.EMPNO = EMPNUMBER;
RETURN EMPSALARY;
END GETEMPSALARY;
/
You need to add a slash (/) at the end of the create procedure/package/function statements.

在Procedure中这样写是不行的：
DBMS_OUTPUT.PUT_LINE(half || ' lines of Seaonal Log & Costsheet inserted.'); -- & is a meaning symbol
其中的&符号和is单词都会被解析，它们都是Oracle关键字。

更改system用户密码
1. sqlplus / as sysdba;
2. alter user system identified by admin;

Oracle中查处相关表的索引、主键、约束：
--get index
select * from user_indexes where TABLE_NAME = UPPER('table_name')
select * from all_indexes where TABLE_NAME = UPPER('lcsSeasonalChangeLog');
TODO: user_indexes, all_indexes 什么区别？
--get PK, Constraints
select * from all_constraints where TABLE_NAME = UPPER('tbl_name');



外一篇：
SQLServer下根据已存在表创建新表：
select * into my_table from exist_table;
若表已存在：
insert into my_table select * from exist_table;
参考：http://www.w3schools.com/sql/sql_select_into.asp
