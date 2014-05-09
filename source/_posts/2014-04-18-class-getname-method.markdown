---
layout: post
title: "Class.getName() 的返回值说明"
date: 2014-04-18 20:12:03 -0800
comments: true
categories: [scp, linux, centos, ubuntu] 
---


refer url: [link](http://docs.oracle.com/javase/6/docs/api/java/lang/Class.html#getName%28%29)

 Examples:

     String.class.getName()
         returns "java.lang.String"
     byte.class.getName()
         returns "byte"
     (new Object[3]).getClass().getName()
         returns "[Ljava.lang.Object;"
     (new int[3][4][5][6][7][8][9]).getClass().getName()
         returns "[[[[[[[I"

在我的代码中出现如下信息： 

	obj : [B@34be51e8
	classname : [B


a single [ means an array of

L followed by a fully qualified class name (e.g. java/lang/Object) is the class name terminated by semicolon ;

so [Ljava.lang.object; means Object[]    


class [B 

class [Lcom.sun.mail.imap.IMAPMessage; 

class [C 

class [I 

class [Ljava.lang.Object; 

[B is array of primitive byte

[C is array of primitive char

[I is array of primitive int

[Lx is array of type x

Here is the entire list: [link on SOF](http://stackoverflow.com/questions/1040868/java-syntax-and-meaning-behind-b1ef9157-binary-address)

    B - byte
    C - char
    D - double
    F - float
    I - int
    J - long
    Lfully-qualified-class; - between an L and a ; is the full class name, using / as the delimiter between packages (for example, Ljava/lang/String;)
    S - short
    Z - boolean
    [ - one [ for every dimension of the array
    (argument types)return-type - method signature, such as (I)V, with the additional pseudo-type of V for void method
