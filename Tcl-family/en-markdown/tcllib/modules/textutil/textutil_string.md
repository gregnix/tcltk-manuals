---
CommandName: textutil::string
title: textutil::string
ManualSection: n
Version: 0.9
TclPart: tcllib
TclDescription: Text and string utilities, macro processing
Links:
 - regexp(n)
 - split(n)
 - string(n)
Keywords:
 - capitalize
 - chop
 - common prefix
 - formatting
 - prefix
 - string
 - uncapitalize
Copyright:
---

# Name

textutil::string - Procedures to manipulate texts and strings.

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [textutil::string]{.lit} [0.9]{.optlit}
[::textutil::string::chop]{.cmd} [string]{.arg}
[::textutil::string::tail]{.cmd} [string]{.arg}
[::textutil::string::cap]{.cmd} [string]{.arg}
[::textutil::string::capEachWord]{.cmd} [string]{.arg}
[::textutil::string::uncap]{.cmd} [string]{.arg}
[::textutil::string::longestCommonPrefixList]{.cmd} [list]{.arg}
[::textutil::string::longestCommonPrefix]{.cmd} [string...]{.optarg}
:::

# Description

The **textutil::string** package provides miscellaneous string manipulation commands.

To see how to find a common path from a list of paths, see the last of the [Examples].

# API

**::textutil::string::chop** *string*
: Returns a copy of *string* with the last character removed.

**::textutil::string::tail** *string*
: Returns a copy of *string* with the first character removed.

**::textutil::string::cap** *string*
: Returns a copy of *string* with the first character capitalized.

**::textutil::string::capEachWord** *string*
: Returns a copy of *string* with the first character of every word capitalized.

**::textutil::string::uncap** *string*
: Returns a copy of *string* with the first character lowercased.

**::textutil::string::longestCommonPrefixList** *list*
: Returns the longest common prefix of the strings in the given *list*.

    If no argument is given, the empty string is returned.

**::textutil::string::longestCommonPrefix** ?*string*...?
: Returns the longest common prefix of the string arguments, *string*, ….

    If a single string is given, it is returned since it is its own longest common prefix. If no argument is given, the empty string is returned.


# Examples

The following examples show some of the **::textutil::string** package’s commands in action.

This first example shows all the commands that work on a single string.

```
const LINE "has the σαβ cogs"
puts "“$LINE” const"
set line [::textutil::string::chop $LINE]
puts "“$line” chop"
set line [::textutil::string::tail $line]
puts "“$line” tail"
set line [::textutil::string::cap $line]
puts "“$line” cap"
set line [::textutil::string::capEachWord $line]
puts "“$line” capEachWord"
set line [::textutil::string::uncap $line]
puts "“$line” uncap"
=>
“has the σαβ cogs” const
“has the σαβ cog” chop
“as the σαβ cog” tail
“As the σαβ cog” cap
“As The Σαβ Cog” capEachWord
“as The Σαβ Cog” uncap
```

This example shows the longest common prefix commands in use.

```
const LIST [list handbag handcuff handful handle handy]
puts “[::textutil::string::longestCommonPrefixList $LIST]”
puts “[::textutil::string::longestCommonPrefix king queen knave]”
puts “[::textutil::string::longestCommonPrefix king kin kind kinks]”
=>
“hand”
“”
“kin”
```

This example shows how to use the **::textutil::string::longestCommonPrefixList** command to find the common path from a list of paths.

```
proc longestCommonPath paths {
    const SEP [file separator]
    set path [::textutil::string::longestCommonPrefixList $paths]
    if {[string index $path end] ne $SEP} {
        if {[set j [string last $SEP $path]] > -1} {
            set path [string range $path 0 $j-1]
        }
    }
    if {$path ne $SEP} { set path [string trimright $path $SEP] }
    return $path
}

const PATHS [list /home/sally/music /home/sally/museums /home/sally/musings]
puts [::textutil::string::longestCommonPrefixList $PATHS]
puts [longestCommonPath $PATHS]
puts [longestCommonPath [list /bin / /sbin]]
=>
/home/sally/mus
/home/sally
/
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *textutil* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing
