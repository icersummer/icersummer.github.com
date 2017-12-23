---
layout: post
title: "创建Solr UI应用"
date: 2014-04-02 20:12:03 -0800
comments: true
categories: [oracle, Markdown] 
---

~$ git clone git://github.com/imathis/octopress.git hellosummer_blog

git push origin branchName
git remote add -t master -f origin https://github.com/hellosummer/hellosummer.github.com.git
$git remote add origin git@github:YourGithubID/work.git

git checkout -b feature_x
git push origin <branch>

不同情况的提交：

1.checkout新项目，修改，提交
//在当前目录下建立solrLearning目录，并克隆成功solrLearning项目
$ git clone git://github.com/icersummer/solrLearning.git solrLearning
//如下命令checkin成功
$ git push https://github.com/icersummer/solrLearning.git master
Username for 'https://github.com':
Password for 'https://icersummer@github.com':
To https://github.com/icersummer/solrLearning.git
   dcfaaac..16d9c7e  master -> master

2.已存在的checkout的项目，拉取最新，修改，提交
git pull

3.建立分支，修改，提交

4.已存在分支，拉取最新，修改，提交

5.合并其他分支到Master分支
git merge <branch>

6.回滚本地未提交改动
git checkout -- <filename>

7.覆盖本地所有改动与提交
git fetch origin




实用小贴士

内建的图形化 git：
gitk
彩色的 git 输出：
git config color.ui true
显示历史记录时，每个提交的信息只显示一行：
git config format.pretty oneline
交互式添加文件到暂存区：
git add -i
