---
CommandName: base32::hex
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Base32 encoding
Links:
 - binary
 - encoding
Keywords:
 - base32
 - hex
 - rfc4648
Copyright:
---

# Name

base32::hex - base32 extended hex encoding

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [base32::core]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [base32::hex]{.lit} [0.2]{.optlit} 
[::base32::hex::encode]{.cmd} [bstring]{.arg} 
[::base32::hex::decode]{.cmd} [estring]{.arg} 
:::

# Description

This package provides commands for encoding and decoding binary strings to and from the extended hex base32 encoding as specified in [RFC 4648](https://datatracker.ietf.org/doc/html/rfc4648).

(Note that Tcl’s built-in [binary](https://www.tcl-lang.org/man/tcl/TclCmd/binary.html) command provides simple encoding and decoding of bytes to and from pairs of hex digits.)

# Api

**::base32::hex::encode** *bstring*
: Returns an extended hex base32-encoded version of the binary string *bstring* as its result. The result may be padded at the end with **=** characters to ensure that the result’s length is a multiple of eight. The encoder will throw an error if *bstring* is neither a binary string, nor a string containing only 7-bit ASCII.

**::base32::hex::decode** *estring*
: Returns a binary string that has been extended hex base32-decoded from the *estring*. Note that while the encoder produces only uppercase characters, this decoder is case-insensitive, i.e., more permissive. The decoder may throw an error on invalid input. For example, if:


**•**
: the input contains characters which are not valid for extended hex base32-encoded data;

**•**
: the length of the input is not a multiple of eight;

**•**
: padding appears in the middle rather than at the end of the input;

**•**
: the padding’s length is not exactly one, three, four, or six characters.


It is also possible to have invalid input that does *not* throw an error—for example, plain text that doesn’t do any of the things listed above.

# Code map

The code map used to convert 5-bit sequences is shown below, with the numeric ID of the bit sequences to the left and the character used to encode it to the right. The important feature of the extended hex mapping is that the first 16 codes map to the digits and hex characters.

```
	0 0    9 9        18 I   27 R
	1 1   10 A        19 J   28 S
	2 2   11 B        20 K   29 T
	3 3   12 C        21 L   30 U
	4 4   13 D        22 M   31 V
	5 5   14 E        23 N
	6 6   15 F        24 O
	7 7        16 G   25 P
	8 8        17 H   26 Q
```

# Examples

This example shows how to encode and decode a Tcl string to and from extended hex base32, taking account of the fact that the extended hex base32 commands work in terms of binary strings.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
set bytes [encoding convertto utf-8 $UTF8_LINE]
set enc32 [::base32::hex::encode $bytes]
set dec32 [::base32::hex::decode $enc32]
set line [encoding convertfrom utf-8 $dec32]
puts "base32::hex='$enc32' [expr {$UTF8_LINE eq $line}]"
=>
base32::hex='PQAC7DP0SA09OLBKCOMJHOK0JKGE56CUSA2A8===' 1
```

If the original string is 7-bit ASCII the conversions to and from raw bytes using the **encoding** command are not needed. For example:

```
const ASCII_LINE "! 7-bit ASCII {~^}"
set enc32 [::base32::hex::encode $ASCII_LINE]
set dec32 [::base32::hex::decode $enc32]
set line [encoding convertfrom utf-8 $dec32]
puts "base32::hex='$enc32' [expr {$ASCII_LINE eq $line}]"
=>
base32::hex='44G3EBB2D5Q20GAJ8D4KI83RFPF7Q===' 1
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
