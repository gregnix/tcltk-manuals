---
CommandName: textutil::wcswidth
title: textutil::wcswidth
ManualSection: n
Version: 35.3
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - character type
 - character width
 - double-wide character
 - prefix
 - regular expression
 - string
Copyright:
---

# Name

textutil::wcswidth - Procedures to compute terminal width of strings

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [textutil::wcswidth]{.lit} [35.3]{.optlit}
[::textutil::wcswidth]{.cmd} [string]{.arg}
[::textutil::wcswidth\_char]{.cmd} [codepoint]{.arg}
[::textutil::wcswidth\_type]{.cmd} [codepoint]{.arg}
:::

# Description

The **textutil::wcswidth** package provides commands that report character types, character widths, and string widths, in the context of terminal (console) output.

This package’s data, and therefore its underlying the functionality, is based on the Unicode database file <http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt>.

# API

This package’s commands account for double-width characters from the various Asian and other scripts.

**::textutil::wcswidth** *string*
: Returns the number of character cells needed by the given *string* when output to a terminal.

**::textutil::wcswidth\_char** *codepoint*
: Returns the number of character cells needed by the given *codepoint* Unicode character when output to a terminal.

    *Important*: The *codepoint* Unicode character must be specified as an integer.

**::textutil::wcswidth\_type** *codepoint*
: Returns the character type of the specified *codepoint* Unicode character.

    The returned value is a string containing one of the following constants: **A**, **F**, **H**, **N**, **Na**, or **W**, as specified in <http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt>.

    *Important*: The *codepoint* Unicode character must be specified as an integer.


# Examples

This example shows all three commands in action.

```
const LINE "Δ÷☕M☔ℤ"
puts "string length  = [string length $LINE]"
puts "terminal width = [textutil::wcswidth $LINE]"
foreach char [split $LINE ""] {
    set cp [scan $char %c]
    set pad [string repeat " " [expr {2 - [textutil::wcswidth_char $cp]}]]
    puts [format "%-2s%sU+%04X %s" $char $pad $cp [textutil::wcswidth_type $cp]]
}
=>
string length  = 6
terminal width = 8
Δ  U+0394 A
÷  U+00F7 A
☕ U+2615 W
M  U+004D N
☔ U+2614 W
ℤ  U+2124 N
```

On a terminal using a monospaced font, the output shown above lines up *perfectly*; any “wobble” seen on this page is an artifact.

Note that if **pad** was set to **" "**, i.e., taking no account of the character widths, the output would *not* line up, e.g.:

```
string length  = 6
terminal width = 8
Δ  U+0394 A
÷  U+00F7 A
☕  U+2615 W
M  U+004D N
☔  U+2614 W
ℤ  U+2124 N
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
