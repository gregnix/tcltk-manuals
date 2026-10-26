---
CommandName: textutil::split
title: textutil::split
ManualSection: n
Version: 0.9
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - regular expression
 - split
 - string
Copyright:
---

# Name

textutil::split - Procedures to split texts

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [textutil::split]{.lit} [0.9]{.optlit}
[::textutil::split::splitn]{.cmd} [string]{.arg} [size]{.optarg}
[::textutil::split::splitx]{.cmd} [string]{.arg} [regexp]{.optarg}
:::

# Description

The **textutil::split** package provides commands that split strings into substrings by size, or by regular expression.

To split on a particular character or set of characters, use the built-in [split](https://www.tcl-lang.org/man/tcl/TclCmd/split.html) command. To split a string into its individual characters, use the built-in [split](https://www.tcl-lang.org/man/tcl/TclCmd/split.html) command with a second argument of **""**.

# API

**::textutil::split::splitn** *string* ?*size*?
: Returns a list of strings containing consecutive substrings of *string*, each *size* long—except for the last which will be shorter if *string*’s length is not an exact multiple of *size*. The *size* defaults to **1**, i.e., return a list of *string*’s characters; this is the same as calling the built-in [split](https://www.tcl-lang.org/man/tcl/TclCmd/split.html) command with a second argument of **""**.

    If *string* is empty, an empty list is returned. If *size* *<= 0*, an error will be thrown.

**::textutil::split::splitx** *string* ?*regexp*?
: Returns a list of strings containing consecutive substrings of *string* split according to the *regexp* regular expression which defaults to *\[\\t \\r\\n\]+* (tabs, spaces, newlines).

    *Note*: If *regexp* contains capturing parentheses, then the captured groups will be included in the result list as additional elements.

    If *string* is empty, an empty list is returned. If *regexp* is empty, the *string* is split at every character; this is the same as calling the built-in [split](https://www.tcl-lang.org/man/tcl/TclCmd/split.html) command with a second argument of **""**.


# Examples

The following examples show some of the **::textutil::split** package’s commands in action.

To help make the examples’ effects more visible, each element of the returned lists is bracketed using ❬ and ❭. For non-UTF-8 aware editors these can be replaced with **\\u276C** and **\\u276D**.

This first example shows how to split strings by size.

```
const LINE1 "α and ℤ"
set chars [::textutil::split::splitn $LINE1] ;# splits into characters
puts ❬[join $chars "❭ ❬"]❭
set chars [split $LINE1 ""] ;# splits into characters
puts ❬[join $chars "❭ ❬"]❭
set chunks [::textutil::split::splitn $LINE1 3]
puts ❬[join $chunks "❭ ❬"]❭
=>
❬α❭ ❬ ❭ ❬a❭ ❬n❭ ❬d❭ ❬ ❭ ❬ℤ❭
❬α❭ ❬ ❭ ❬a❭ ❬n❭ ❬d❭ ❬ ❭ ❬ℤ❭
❬α a❭ ❬nd ❭ ❬ℤ❭
```

This second example shows how to split strings by regexp.

```
const LINE2 "a, be , cat, done , eagle"
set chunks [::textutil::split::splitx $LINE2] ;# splits on [\t \r\n]+
puts ❬[join $chunks "❭ ❬"]❭
set chunks [::textutil::split::splitx $LINE2 {\s*,\s*}]
puts ❬[join $chunks "❭ ❬"]❭
set chunks [::textutil::split::splitx $LINE2 {\s*(,)\s*}]
puts ❬[join $chunks "❭ ❬"]❭
=>
❬a,❭ ❬be❭ ❬,❭ ❬cat,❭ ❬done❭ ❬,❭ ❬eagle❭
❬a❭ ❬be❭ ❬cat❭ ❬done❭ ❬eagle❭
❬a❭ ❬,❭ ❬be❭ ❬,❭ ❬cat❭ ❬,❭ ❬done❭ ❬,❭ ❬eagle❭
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
