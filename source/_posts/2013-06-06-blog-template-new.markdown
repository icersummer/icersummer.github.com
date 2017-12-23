---
layout: post
title: "题目-title"
date: 2013-06-06 11:09:03 -0800
comments: true
categories: [oldblog, Template] 
---

新的模版，增加了两段文字， category、tags，同时这两段文字也出现在index.json中，便于阅读、查阅。

===

代码展示：
```python
print "hello, world."
```

模版正文开始

# 正文题目
- category：吐槽
- tags：life

---

正文在继续，文章第一行。

通过空行来换行，这是新的一行。

第三段，在SNS里看到了你的动态：

>你说你爱了不不该爱的人，你的人生充满伤痕。

下一段，收到某人的短信：

>重要：新创建应用需要通过审核必须使用OAuth2.0和新版接口。 新版接口迁移指南 新版接口文档 OAuth2.0开发指南。微博基础数据接口 (Rest API)。获取下行数据集(timeline)接口： statuses/public_timeline 获取最新的公共微博消息；    statuses/friends_timeline 获取当前登录用户及其所关注用户的最新微博消息 (别名: statuses/home_timeline)；    statuses/user_timeline 获取用户发布的微博消息列表；    statuses/mentions 获取@当前用户的微博列表；    statuses/comments_timeline 获取当前用户发送及收到的评论列表；    statuses/comments_by_me 获取当前用户发出的评论；；    statuses/comments_to_me 获取当前用户收到的评论 
>第二个大于号
>第三个大于号

>多个大于号并不会换行，而是自动关联到了一起。

如果在段落中插入一段Flash MV，可以放出吗：

<p style="text-align:center"><embed src="http://www.xiami.com/widget/0_374459/singlePlayer.swf" type="application/x-shockwave-flash" width="257" height="33" wmode="transparent"></embed></p>

分析Flash代码：应该是能够在Git Pages中显现，而不能在Github中浏览时显现。

