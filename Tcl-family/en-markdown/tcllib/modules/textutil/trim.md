---
CommandName: textutil::trim
title: textutil::trim
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - prefix
 - regular expression
 - string
 - trimming
Copyright:
---

# Name

textutil::trim - Procedures to trim strings

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [textutil::trim]{.lit} [0.8]{.optlit}
[::textutil::trim::trim]{.cmd} [string]{.arg} [regexp]{.optarg}
[::textutil::trim::trimleft]{.cmd} [string]{.arg} [regexp]{.optarg}
[::textutil::trim::trimright]{.cmd} [string]{.arg} [regexp]{.optarg}
[::textutil::trim::trimPrefix]{.cmd} [string]{.arg} [prefix]{.arg}
[::textutil::trim::trimEmptyHeading]{.cmd} [string]{.arg}
:::

# Description

The **textutil::trim** package provides commands that trim strings in various ways, including using arbitrary regular expressions.

To trim strings of sets of characters (such as whitespace), use the built-in [string](https://www.tcl-lang.org/man/tcl/TclCmd/string.html) command’s **trim**, **trimleft**, **trimright** subcommands.

# API

**::textutil::trim::trim** *string* ?*regexp*?
: Returns a copy of *string* with any leading or trailing substring that matches *regexp* removed from the *string* if does not contain newlines, or from *every line* within the *string* if it contains newlines. The *regexp* defaults to *\[ \\t\]+*. This default will remove leading and trailing spaces and tabs from the *string* if it does not contain newlines, or from *every line* within the *string* if it contains newlines.

**::textutil::trim::trimleft** *string* ?*regexp*?
: Returns a copy of *string* with any leading substring that matches *regexp* removed from the *string* if does not contain newlines, or from *every line* within the *string* if it contains newlines. The *regexp* defaults to *\[ \\t\]+*. This default will remove leading spaces and tabs from the *string* if it does not contain newlines, or from *every line* within the *string* if it contains newlines.

**::textutil::trim::trimright** *string* ?*regexp*?
: Returns a copy of *string* with any trailing substring that matches *regexp* removed from the *string* if does not contain newlines, or from *every line* within the *string* if it contains newlines. The *regexp* defaults to *\[ \\t\]+*. This default will remove trailing spaces and tabs from the *string* if it does not contain newlines, or from *every line* within the *string* if it contains newlines.

**::textutil::trim::trimPrefix** *string* *prefix*
: Returns a copy of *string* with *prefix* removed from the start if it is present; otherwise returns *string* unchanged.

    Contrast this command with the built-in [string](https://www.tcl-lang.org/man/tcl/TclCmd/string.html) command’s **trim**, **trimleft**, **trimright** subcommands which remove all characters in a given set of characters passed as a string.

**::textutil::trim::trimEmptyHeading** *string*
: Returns a copy of *string* with any leading blank lines (including lines containing only whitespace) removed.


# Examples

The following examples show some of the **::textutil::trim** package’s commands in action.

The following **proc** is used by some of the examples below.

```
proc replace_ws s { regsub -all { } [regsub -all \t [regsub -all \n $s ⏎] →] ▴ }
```

This example shows the use of **::textutil::trim::trimEmptyHeading** and **::textutil::trim::trim**.

```
const LINES1 "\t\n Alpha\t\n Beta \t\n Gamma \t\n"
puts "== const =============================\n[replace_ws $LINES1]"
set line [::textutil::trim::trimEmptyHeading $LINES1]
puts "== textutil::trim::trimEmptyHeading ==\n[replace_ws $line]"
set line [string trimleft $LINES1]
puts "== string trimleft ===================\n[replace_ws $line]"
set line [::textutil::trim::trim $LINES1]
puts "== textutil::trim::trim ==============\n[replace_ws $line]"
=>
== const =============================
→⏎▴Alpha→⏎▴Beta▴→⏎▴Gamma▴→⏎
== textutil::trim::trimEmptyHeading ==
▴Alpha→⏎▴Beta▴→⏎▴Gamma▴→⏎
== string trimleft ===================
Alpha→⏎▴Beta▴→⏎▴Gamma▴→⏎
== textutil::trim::trim ==============
⏎Alpha⏎Beta⏎Gamma⏎
```

Notice the subtle difference in behavior between **::textutil::trim::trimEmptyHeading** and **string trimleft**.

This example shows the use of the built-in **string trim** in combination with and **::textutil::trim::trim**.

```
const LINES2 [string trim "\t\n Delta\t\n Epsilon \t\n Zeta \t\n"]
puts "== const =============================\n[replace_ws $LINES2]"
set line [::textutil::trim::trim $LINES2]
puts "== textutil::trim::trim ==============\n[replace_ws $line]"
=>
== const =============================
Delta→⏎▴Epsilon▴→⏎▴Zeta
== textutil::trim::trim ==============
Delta⏎Epsilon⏎Zeta
```

This example contrasts the built-in **string trim** with **::textutil::trim::trimPrefix**.

```
const PATH /home/homer
puts "const='$PATH'"
puts "string trim \$PATH /home='[string trim $PATH /home]'"
puts "string trim \$PATH /home='[string trim $PATH ehmo/]'"
puts "::textutil::trim::trimPrefix \$PATH /home='[::textutil::trim::trimPrefix $PATH /home]'"
const LINE mimic
puts "string trim \$LINE mic='[string trim $LINE mic]'"
puts "::textutil::trim::trimPrefix \$LINE mic='[::textutil::trim::trimPrefix $LINE mic]'"
=>
const='/home/homer'
string trim $PATH /home='r'
string trim $PATH /home='r'
::textutil::trim::trimPrefix $PATH /home='/homer'
string trim $LINE mic=''
::textutil::trim::trimPrefix $LINE mic='mimic'
```

For the **PATH** examples, the **string trim** command trims all the individual characters that are in the string "/home", i.e., "/", "h", "o", "m", "e". The order of the characters in the string don’t matter as the "ehmo/" example shows. Compare this with **::textutil::trim::trimPrefix** which trims the literal string "/home".

For the **LINE** examples, the **string trim** command trims all the individual characters that are in the string "mic", i.e., "m", "i", "c". Compare this with **::textutil::trim::trimPrefix** which trims the literal string "mic"; but since the **LINE** doesn’t start with "mic", nothing is trimmed and the string is returned unchanged.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
