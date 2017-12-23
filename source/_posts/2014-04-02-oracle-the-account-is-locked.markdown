---
layout: post
title: "解锁Oracle账号"
date: 2014-04-02 20:12:03 -0800
comments: true
categories: [oracle, Markdown] 
---

错误信息：

> ORA-28000
> Error: ORA-28000: the account is locked

> Cause: The user has entered wrong password consequently for maximum number of times specified by the user's profile parameter FAILED_LOGIN_ATTEMPTS, or the database administrator has locked the account.

> Action: Wait for PASSWORD_LOCK_TIME or contact the database administrator

解决办法：

> To unlock an user manually:
> ALTER USER username ACCOUNT UNLOCK;

> to change his password:
> alter user username identified by new_password;