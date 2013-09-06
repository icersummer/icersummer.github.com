## Markdown常用语法、格式简介 - 03

加粗

*粗体1*
**粗体2**
***粗体3***

标题

#标题1#
##标题2##
###标题3###

黑体

<b>黑体</b>

斜体

_斜体_

分割线

***

列表

- 列表项目1
- 列表项目2
- 列表项目3

单行代码

`这里是单行代码`

多行代码

```Java
或者rb，
或者HTML
  空格二
      空格四
  结束
```

引用

>引用内容，分别显示；
>无空行第二引用，附于第一段；

>换行，则新行。

***

源代码格式

***

加粗

```Java
*粗体1*
**粗体2**
**粗体3**
```

标题

```Java
#标题1#
##标题2##
```

有序编号显示

1. 第一行
2. 第二行
3. 第三行
1. 第四行 (行前的数字其实不起作用)

嵌套编号

1. Dog
    1. German Shepherd
	2. Belgian Shepherd
	    1. Malinois
		2. Groenendael
		3. Tervuren
2. Cat
    1. Siberian
    2. Siamese

规则就是：

```
<b>Advanced lists: Nesting</b>	

To put other Markdown blocks in a list; just indent four spaces for each nesting level.
```

//TODO ， 这篇文章研究 http://www.macdrifter.com/2012/04/writing-in-markdown-lists.html

双行分隔符
========

单行分隔符
----------

图片嵌入(比文字超链多了惊叹号)

![screen shot](https://github.com/icersummer)

使用单行分隔符的Code Sample
---------------------------

The file [`HELLOWORLD.JAVA`](http://icersummer.github.io) is created by example in Sep.2nd. 注意这里的Helloworld所被包围的效果。

四个空格可以构造缩进、包围效果、并且无需换行：

    123467
	这个世界
	http://github.com/icersummer
	nowthat
	
> 这是一个引用。

下面引用中无序列表：

> 有趣的现象：

> - 列表1

> - comment list

> - comment list 002

> More details.

