---
CommandName: math::roman
title: math::roman
ManualSection: 1.1
Version: tcllib
TclPart: Tcl Math Library
TclDescription:
Keywords:
 - conversion
 - integer
 - roman numeral
Copyright:
 - Copyright (c) 2005 Kenneth Green <kenneth.green@gmail.com>
---

# Name

math::roman - Tools for creating and manipulating roman numerals

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [math::roman]{.lit} [1.1]{.optlit}
[::math::roman::toroman]{.cmd} [i]{.arg}
[::math::roman::tointeger]{.cmd} [r]{.arg}
[::math::roman::sort]{.cmd} [list]{.arg}
[::math::roman::expr]{.cmd} [args]{.arg}
:::

# Description

**::math::roman** is a pure-Tcl library for converting between integers and roman numerals. It also provides utility functions for sorting and performing arithmetic on roman numerals.

This code was originally harvested from the Tcler's wiki at <http://wiki.tcl.tk/1823> and as such is free for any use for any purpose. Many thanks to the ingeneous folk who devised these clever routines and generously contributed them to the Tcl community.

While written and tested under Tcl 8.3, I expect this library will work under all 8.x versions of Tcl.

# Commands

**::math::roman::toroman** *i*
: Convert an integer to roman numerals. The result is always in upper case. The value zero is converted to an empty string.

**::math::roman::tointeger** *r*
: Convert a roman numeral into an integer.

**::math::roman::sort** *list*
: Sort a list of roman numerals from smallest to largest.

**::math::roman::expr** *args*
: Evaluate an expression where the operands are all roman numerals.


Of these commands both *toroman* and *tointeger* are exported for easier use. The other two are not, as they could interfer or be confused with existing Tcl commands.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *math :: roman* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Mathematics

# Copyright

```
Copyright (c) 2005 Kenneth Green <kenneth.green@gmail.com>
```
