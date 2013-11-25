---
layout: post
title: "VBA/Marco in Excel"
date: 2013-09-06 20:15:03 -0800
comments: true
categories: [oldblog, Excel, Marco, VBA] 
---

示例1
-----
有一列数据1、2、3、6、6、8，把等于6的单元格用红色标出

```
Sub Macro1()
'
' Macro1 Macro
'

'
    ' add
    For x = 1 To Range("A65536").End(xlUp).Row '
        If Cells(x, 1) = 2180880 Then '
            Cells(x, 1).Interior.ColorIndex = 3
        End If
        
    Next x    
    
    'With Selection.Interior
    '    .Pattern = xlSolid
    '    .PatternColorIndex = xlAutomatic
    '    .Color = 65535
    '    .TintAndShade = 0
    '    .PatternTintAndShade = 0
    'End With
End Sub

```