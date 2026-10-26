---
CommandName: textutil::tabify
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - formatting
 - string
 - tabstops
Copyright:
---

# Name

textutil::tabify - Procedures to (un)tabify strings

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [textutil::tabify]{.lit} [0.8]{.optlit} 
[::textutil::tabify::tabify]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::tabify::tabify2]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::tabify::untabify]{.cmd} [string]{.arg} [count]{.optarg} 
[::textutil::tabify::untabify2]{.cmd} [string]{.arg} [count]{.optarg} 
:::

# Description

The **textutil::tabify** package provides commands for converting tabs to spaces or spaces to tabs in strings.

# Api

**::textutil::tabify::tabify** *string* ?*count*?
: Returns a copy of *string* with any substring of *count* space characters replaced by a horizontal tab. The *count* defaults to 8.

**::textutil::tabify::tabify2** *string* ?*count*?
: Returns a copy of *string* with substrings of *count* *or fewer* space characters replaced by a horizontal tab using a text editor like algorithm. The *count* defaults to 8. The algorithm used by this command treats each line in *string* as if it had notional tabstops every *count* columns. (So, if *count* is **8**, at columns **8**, **16**, **24**, ….) Only sequences of *two or more* space characters that occur immediately before a notional tabstop are replaced with a tab.

**::textutil::tabify::untabify** *string* ?*count*?
: Returns a copy of *string* with every horizontal tab replaced by *count* spaces. The *count* defaults to 8.

**::textutil::tabify::untabify2** *string* ?*count*?
: Returns a copy of *string* with horizontal tabs replaced by *count* *or fewer* space characters using a text editor like algorithm. The *count* defaults to 8. This command is the counterpart to **::textutil::tabify::tabify2**. The algorithm used by this command treats each line in *string* as if it had notional tabstops every *count* columns. (So, if *count* is **8**, at columns **8**, **16**, **24**, ….) Instead of blindly replacing each horizontal tab with *count* spaces, each horizontal tab at a notional tabstop is replaced by enough spaces to reach the next notional tabstop. There is one asymmetry though: A tab may be replaced by a single space, but not the other way around.


# Examples

The following examples show some of the **::textutil::tabify** package’s commands in action.

The examples make use of a tiny helper command to make spaces and tabs distinct and visible:

```
proc replace_tab_spc s { regsub -all { } [regsub -all \t $s →] ▴ }
```

This example shows the **::textutil::tabify::tabify** command in action.

```
const LINES1 "    if \{\$x\} \{\n        puts 1\n    \}"
puts "=== original ===\n[replace_tab_spc $LINES1]\n"
set tabbed [::textutil::tabify::tabify $LINES1]
puts "=== 8spc→tab ===\n[replace_tab_spc $tabbed]\n"
set tabbed [::textutil::tabify::tabify $LINES1 4]
puts "=== 4spc→tab ===\n[replace_tab_spc $tabbed]\n"
=>
=== original ===
▴▴▴▴if▴{$x}▴{
▴▴▴▴▴▴▴▴puts▴1
▴▴▴▴}

=== 8spc→tab ===
▴▴▴▴if▴{$x}▴{
→puts▴1
▴▴▴▴}

=== 4spc→tab ===
→if▴{$x}▴{
→→puts▴1
→}
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
