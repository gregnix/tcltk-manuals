---
CommandName: throw
title: throw
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Forward compatibility implementation of [throw]
Links:
 - error(n)
Keywords:
 - error
 - return
 - throw
Copyright:
 - Copyright (c) 2015 Miguel Martínez López, BSD licensed
---

# Name

throw - throw - Throw an error exception with a message

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [throw]{.lit} [1.1]{.optlit}
[::throw]{.cmd} [error\_code]{.arg} [error\_message]{.arg}
:::

# Description

This package provides a forward-compatibility implementation of Tcl 8.6's **throw** command (TIP 329), for Tcl 8.5. The code was directly pulled from Tcl 8.6 revision ?, when try/finally was implemented as Tcl procedure instead of in C.

**::throw** *error\_code* *error\_message*
: throw is merely a reordering of the arguments of the error command. It throws an error with the indicated error code and error message.


# Examples

```
throw {MYERROR CODE} "My error message"
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *try* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Utility

# Copyright

```
Copyright (c) 2015 Miguel Martínez López, BSD licensed
```
