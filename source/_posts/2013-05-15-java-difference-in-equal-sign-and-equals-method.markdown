---
layout: post
title: "Java, Difference in == and equals "
date: 2013-05-15 01:09:03 -0800
comments: true
categories: [oldblog, Java, Equals] 
---

从DB读取字段tmp，它是个空值("")， 但是在应用(tmp!=null && tmp!="")时总是返回true，而且可以得到 tmp.length() = 1；但是在测试中发现 tmp.equals("")和 ""=="" 都能够正常的返回true；

需要从本质上学习一下2个问题：
1. equals 和 == 的异同、用在哪里；
2. string(空值、非空值)值比较可以使用==吗？