---
CommandName: ascii85
title: ascii85
ManualSection: n
Version: 1.1.1
TclPart: tcllib
TclDescription: Text encoding & decoding binary data
Keywords:
 - ascii85
 - encoding
Copyright:
 - Copyright (c) 2010, Emiliano Gavilán
---

# Name

ascii85 - ascii85-encode/decode binary data

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [ascii85]{.lit} [1.1]{.optlit}
[::ascii85::encode]{.cmd} [[-maxlen]{.lit} [maxlen]{.arg}]{.optarg} [[-wrapchar]{.lit} [wrapchar]{.arg}]{.optarg} [bstring]{.arg}
[::ascii85::decode]{.cmd} [estring]{.arg}
:::

# Description

This package provides commands for encoding and decoding binary strings to and from the ascii85 encoding. (This encoding is also known as base85.)

# API

**::ascii85::encode** ?**-maxlen** *maxlen*? ?**-wrapchar** *wrapchar*? *bstring*
: Returns an ascii85-encoded version of the binary string *bstring* as its result.

    The result string contains the *wrapchar* character after every *maxlen* characters of output. The *wrapchar* defaults to newline and *maxlen* defaults to 76. To prevent wrapping, set *maxlen* to **0**.

    The command will throw an error if *maxlen* is not an integer or is negative, or if *bstring* is neither a binary string, nor a string containing only 7-bit ASCII.

**::ascii85::decode** *estring*
: Returns a binary string that has been ascii85-decoded from the *estring*. Any whitespace (spaces, tabs, newlines) in *estring* is ignored.


# Examples

This example shows how to encode and decode a Tcl string to and from ascii85, taking account of the fact that the ascii85 commands work in terms of binary strings.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
set bytes [encoding convertto utf-8 $UTF8_LINE]
set enc85 [::ascii85::encode $bytes]
set dec85 [::ascii85::decode $enc85]
set line [encoding convertfrom utf-8 $dec85]
puts "ascii85='$enc85' [expr {$UTF8_LINE eq $line}]"
=>
ascii85='cBQ5U+Q@pA<HMh)39#IZ+QAf\ie4*' 1
```

If the original string is 7-bit ASCII the conversions to and from raw bytes using the built-in **encoding** command are not needed. For example:

```
const ASCII_LINE "! 7-bit ASCII {~^}"
set enc85 [::ascii85::encode $ASCII_LINE]
set dec85 [::ascii85::decode $enc85]
set line [encoding convertfrom utf-8 $dec85]
puts "ascii85='$enc85' [expr {$ASCII_LINE eq $line}]"
=>
ascii85='+Wr]q@VKp,5uU-B8K`A/?@;' 1
```

Wrapping can be prevented so that no whitespace is introduced:

```
ascii85::encode [string repeat xyz 24]
=>
G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G
^4U[H$X^\H?a^]
ascii85::encode -maxlen 0 [string repeat xyz 24]
=>
G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]G^4U[H$X^\H?a^]
```

# References

1. <http://en.wikipedia.org/wiki/Ascii85>

2. Postscript Language Reference Manual, 3rd Edition, page 131. <http://www.adobe.com/devnet/postscript/pdfs/PLRM.pdf>


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *base64* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing

# Copyright

```
Copyright (c) 2010, Emiliano Gavilán
```
