---
CommandName: textutil::patch
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Text and string utilities
Keywords:
 - diff -ruN
 - diff
 - unified format
 - fossil
 - git
 - patch
 - unified format diff
Copyright:
---

# Name

textutil::patch - Application of uni-diff patches to directory trees

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [textutil::patch]{.lit} [0.2]{.optlit} 
[::textutil::patch::apply]{.cmd} [basedirectory]{.arg} [striplevel]{.arg} [patch]{.arg} [reportcmd]{.arg} 
:::

**{\*}reportcmd** **apply** *filename*

**{\*}reportcmd** **fail** *filename* *hunk* *expected* *seen*

**{\*}reportcmd** **fail-already** *filename* *hunk*

# Description

This package provides a single command which applies a patch in [unified diff format](https://www.gnu.org/software/diffutils/manual/html_node/Detailed-Unified.html) to the files in a directory tree.

# Api

**::textutil::patch::apply** *basedirectory* *striplevel* *patch* *reportcmd*
: Applies the *patch* (i.e., the text of the actual patch, not a filename) to the files in the *basedirectory* using the specified *striplevel*, and reports actions with calls to the command prefix *reportcmd*. Returns an empty string. The *striplevel* argument is equivalent to the [patch](https://www.man7.org/linux/man-pages/man1/patch.1.html) command’s **-p** (or **--strip**) option with a value of *striplevel*. Throws an error if *patch* cannot be parsed, or if nothing is done to the files in *basedirectory*. Actions that occur during the patching, including the inability to apply a hunk, are reported through the command prefix *reportcmd*. Files with problems are left unchanged, while files without problems—whether they are processed before or after problem files—will be changed in accordance with the *patch*. Each call to the command prefix can take one of three possible forms:


**{\*}reportcmd** **apply** *filename*
: This call is made at the start of each patch apply and is passed the *filename* of the file being patched. An attempt is made to apply all collected hunks for the *filename*.

**{\*}reportcmd** **fail** *filename* *hunk* *expected* *seen*
: This call is made every time the application of a hunk fails. The command is passed the *filename* being processed, the *hunk* number, what the *expected* text was, and what the text that was actually *seen* is.

**{\*}reportcmd** **fail-already** *filename* *hunk*
: This call is made every time the application of a hunk fails due to the given *hunk* number having *already* been applied to the *filename*.


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
