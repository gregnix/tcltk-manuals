---
CommandName: unicode
title: unicode
ManualSection: n
Version: 1.1.1
TclPart: tcllib
TclDescription: Unicode normalization
Links:
 - stringprep(n)
Keywords:
 - normalization
 - unicode
Copyright:
 - Copyright (c) 2007, Sergei Golovan <sgolovan@nes.ru>
---

# Name

unicode - Implementation of Unicode normalization

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [unicode]{.lit} [1.1.1]{.lit}
[::unicode::normalizeS]{.cmd} [form]{.arg} [string]{.arg}
[::unicode::fromstring]{.cmd} [string]{.arg}
[::unicode::tostring]{.cmd} [codepointsList]{.arg}
[::unicode::normalize]{.cmd} [form]{.arg} [codepointsList]{.arg}
:::

# Description

This is a Tcl implementation of Unicode normalization commands.

*Note* that if normalization alone is insufficient (e.g., for string comparisons), the **stringprep** package may prove useful.

# API

The *form* argument in the commands listed below must be a string that has one of the following values: **D** (canonical decomposition), **C** (canonical decomposition, followed by canonical composition), **KD** (compatibility decomposition), or **KC** (compatibility decomposition, followed by canonical composition).

**::unicode::normalizeS** *form* *string*
: Returns a possibly modified copy of *string*, normalized in accordance with the given *form*.

    This is a convenience for: *::unicode::tostring* \[*unicode::normalize $form* \[*::unicode::fromstring $string*\]\].

**::unicode::fromstring** *string*
: Returns a list of integer Unicode code points representing the characters in *string*.

    (These integer code points are used in **unicode** for internal string representation.)

**::unicode::tostring** *codepointsList*
: Returns a string whose characters are those corresponding to the *codepointsList* of integers.

    Every integer that is a valid Unicode code point is represented in the returned string by the corresponding Unicode character. Any integer that is not a valid Unicode code point is represented using the Unicode replacement character �, U+FFFD, unless it is sufficiently big, in which case an error is thrown.

**::unicode::normalize** *form* *codepointsList*
: Returns a possibly modified copy of the *codepointsList* of integers (which must all be valid Unicode code points), normalized according to the given normalization *form*.


# Examples

Some Unicode characters have more than one representation in a Unicode encoding such as UTF-8. Normally, this is not a problem *within* a programming language, since the language will typically always use the same representation for any given character. But for data read in from files or other external sources, any of the possible representations could be used. So in these cases normalization may be needed.

Here is an example of the problem:

```
set a "Å"
set b "\u212B"
set c [encoding convertfrom utf-8 \xC3\x85]
set d [encoding convertfrom utf-8 \xE2\x84\xAB]
set e [encoding convertfrom utf-8 \x41\xCC\x8A]
set s [join [list $a $b $c $d $e] ""]
puts "s=$s a=b→[expr {$a eq $b}] a=c→[expr {$a eq $c}] a=d→[expr {$a eq $d}] a=e→[expr {$a eq $e}] b=c→[expr {$a eq $d}] b=d→[expr {$a eq $d}] b=e→[expr {$a eq $e}] c=d→[expr {$a eq $d}] c=e→[expr {$a eq $e}]"
=>
s=ÅÅÅÅÅ a=b→0 a=c→1 a=d→0 a=e→0 b=c→0 b=d→0 b=e→0 c=d→0 c=e→0
```

The above output shows that although all the characters are the same, they have different UTF-8 representations and do *not* compare equal.

The solution is to normalize. For example:

```
set t [unicode::normalizeS KC $s]
set a [string index $t 0]
set b [string index $t 1]
set c [string index $t 2]
set d [string index $t 3]
set e [string index $t 4]
puts "t=$t a=b→[expr {$a eq $b}] a=c→[expr {$a eq $c}] a=d→[expr {$a eq $d}] a=e→[expr {$a eq $e}] b=c→[expr {$a eq $d}] b=d→[expr {$a eq $d}] b=e→[expr {$a eq $e}] c=d→[expr {$a eq $d}] c=e→[expr {$a eq $e}]"
=>
t=ÅÅÅÅÅ a=b→1 a=c→1 a=d→1 a=e→1 b=c→1 b=d→1 b=e→1 c=d→1 c=e→1
```

After normalization all the characters have the same representation and correctly compare as equal.

## Legacy examples

```
% ::unicode::fromstring "\u0410\u0411\u0412\u0413"
1040 1041 1042 1043
% ::unicode::tostring {49 50 51 52 53}
12345
%
```

```
% ::unicode::normalize D {7692 775}
68 803 775
% ::unicode::normalizeS KD "\u1d2c"
A
%
```

# References

1. "Unicode Standard Annex #15: Unicode Normalization Forms", (<http://unicode.org/reports/tr15/>)


# Authors

Sergei Golovan

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *stringprep* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Copyright

```
Copyright (c) 2007, Sergei Golovan <sgolovan@nes.ru>
```
