---
layout: post
title: "正则表达式"
date: 2014-04-22 16:46:03 -0800
comments: true
categories: [regex, java] 
---

^cell\d  :

^[1-9]\d+$ 

^：表示匹配起始位置

\d+: 0-9的数字，个数为任意个

$: 匹配末尾

. : any character

[abc] : any of the characters a,b,or c (same as a|b|c)

[^abc]: any character except a,b, and c (negation)

[a-zA-Z]: any character a through z or A through Z (range)

[abc[hij]]: any of a,b,c,h,j,j (same as a|b|c|h|i|j) (union)

[a-z&&[hij]]: either h,I, or j (insersection)

\s : a whitespace character (space, tab, newline, form feed, carriage return)

\S : a non-whitespace character ([^\s])

\d : a numberic digit [0-9]

\D : a non-digit [0-9]

\w : a word character [a-zA-Z_0-9]

\W : a non-word chacter [^\w]

正则表达式的百度百科详细解释[link](http://baike.baidu.com/view/94238.htm)