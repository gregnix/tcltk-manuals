---
CommandName: textutil::repeat
title: textutil::repeat
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - blanks
 - repetition
 - string
Copyright:
---

# Name

textutil::repeat - Procedures to repeat strings.

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [textutil::repeat]{.lit} [0.8]{.optlit}
[::textutil::repeat::strRepeat]{.cmd} [text]{.arg} [count]{.arg}
[::textutil::repeat::blank]{.cmd} [count]{.arg}
:::

# Description

The **textutil::repeat** package provides commands to generate strings by repeating a string multiple times.

# API

**::textutil::repeat::strRepeat** *text* *count*
: Returns a string containing the *text* repeated *count* times.

    The repetitions are joined with no separators between them. A value of *count* *<= 0* causes the command to return an empty string.

    *Note*: If the Tcl core this package is loaded in provides the **string repeat** command, then this command will be implemented in its terms, for maximum speed. Otherwise a fast Tcl implementation is used.

**::textutil::repeat::blank** *count*
: Returns a string containing *count* spaces.

    This is a convenience for calling **::textutil::repeat::strRepeat** with **" "** as its first argument.


# Examples

This tiny example shows the **::textutil::repeat** package’s commands in action.

```
puts [::textutil::repeat::strRepeat = 22]
puts =[::textutil::repeat::blank 20]=
=>
======================
=                    =
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
