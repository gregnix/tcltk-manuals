---
CommandName: base32
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Base32 encoding
Links:
 - encoding
Keywords:
 - base32
 - rfc3548
 - rfc4648
Copyright:
---

# Name

base32 - base32 standard encoding

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [base32::core]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [base32]{.lit} [0.2]{.optlit} 
[::base32::encode]{.cmd} [bstring]{.arg} 
[::base32::decode]{.cmd} [estring]{.arg} 
:::

# Description

This package provides commands for encoding and decoding binary strings to and from the standard base32 encoding as specified in [RFC 4648](https://datatracker.ietf.org/doc/html/rfc4648) *(and also the older* [RFC 3548](https://datatracker.ietf.org/doc/html/rfc3548))*.*

# Api

**::base32::encode** *bstring*
: Returns a base32-encoded version of the binary string *bstring* as its result. The result may be padded at the end with **=** characters to ensure that the result’s length is a multiple of eight. The encoder will throw an error if *bstring* is neither a binary string, nor a string containing only 7-bit ASCII.

**::base32::decode** *estring*
: Returns a binary string that has been base32-decoded from the *estring*. Note that while the encoder produces only uppercase characters, this decoder is case-insensitive, i.e., more permissive. The decoder may throw an error on invalid input. For example, if:


**•**
: the input contains characters which are not valid for base32-encoded data;

**•**
: the length of the input is not a multiple of eight;

**•**
: padding appears in the middle rather than at the end of the input;

**•**
: the padding’s length is not exactly one, three, four, or six characters.


It is also possible to have invalid input that does *not* throw an error—for example, plain text that doesn’t do any of the things listed above.

# Code map

The code map used to convert 5-bit sequences is shown below, with the numeric ID of the bit sequences to the left and the character used to encode it to the right. Note that the characters "0" and "1" are *not* used by the encoding, to avoid confusion with "O", "o" and "l" (L).

```
	0 A    9 J   18 S   27 3
	1 B   10 K   19 T   28 4
	2 C   11 L   20 U   29 5
	3 D   12 M   21 V   30 6
	4 E   13 N   22 W   31 7
	5 F   14 O   23 X
	6 G   15 P   24 Y
	7 H   16 Q   25 Z
	8 I   17 R   26 2
```

# Examples

This example shows how to encode and decode a Tcl string to and from base32, taking account of the fact that the base32 commands work in terms of binary strings.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
set bytes [encoding convertto utf-8 $UTF8_LINE]
set enc32 [::base32::encode $bytes]
set dec32 [::base32::decode $enc32]
set line [encoding convertfrom utf-8 $dec32]
puts "base32='$enc32' [expr {$UTF8_LINE eq $line}]"
=>
base32='Z2KMHNZA4KAJYVLUMYWTRYUATUQOFGM64KCKI===' 1
```

If the original string is 7-bit ASCII the conversions to and from raw bytes using the built-in [encoding](https://www.tcl-lang.org/man/tcl/TclCmd/encoding.html) command are not needed. For example:

```
const ASCII_LINE "! 7-bit ASCII {~^}"
set enc32 [::base32::encode $ASCII_LINE]
set dec32 [::base32::decode $enc32]
set line [encoding convertfrom utf-8 $dec32]
puts "base32='$enc32' [expr {$ASCII_LINE eq $line}]"
=>
base32='EEQDOLLCNF2CAQKTINEUSID3PZPH2===' 1
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *base32* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing

# Copyright

```
Public domain
```
