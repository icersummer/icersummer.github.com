---
layout: post
title: "OCTOPress增加Disqus评论"
date: 2014-04-22 14:56:03 -0800
comments: true
categories: [octopress, disqus] 
---

##OCTOPress增加Disqus评论

今日步骤：

1-使用WinSCP链接UbuntuSolr image，传输已更新数据。
--
传输之后

1.1-更新blog页面

	788  rake generate
	789  rake deploy


1.2-checkin、push更改到source分支
  
      792  cd source/  
      798  git add .
      799  git commit -m 'new entry'
      800* git commit -a
      801  git commit -m 'new entry'
      803  git push origin source

2-添加Disqus功能
--
非常简单，在文件_config.yml中，修改Disqus short name：

	disqus_short_name: vjgithubblog #注意这里中间一定有一个空格
	disqus_show_comment_count: false

这里的disqus short name可以在[这里](https://vjgithubblog.disqus.com/admin/settings/universalcode/)申请。

3-同時Octopress還提供了很多第三方插件，很容易配置並支持

> These third party integrations are already set up for you. Simply fill in the configurations and they'll be added to your site.
> 
    Github - List your github repositories in the sidebar
    Twitter - Add a button for sharing of posts and pages on Twitter
    Google Plus One - Setup sharing for posts and pages on Google's plus one network.
    Pinboard - Share your recent Pinboard bookmarks in the sidebar.
    Delicious - Share your recent Delicious bookmarks in the sidebar.
    Disqus Comments - Add your disqus short name to enable disqus comments on your site.
    Google Analytics - Add your tracking id to enable Google Analytics tracking for your site.
    Facebook - Add a Facebook like button

4-添加了Github repository显示：

`github_user: yourGithubName`

`github_show_profile_link: true`

5-添加了googlePlus链接：

`googleplus_user: 11509823689222118830` #这里的数字是点击自己的Google Plus Profile时显示的一串数字，不是GMail账户名。

