---
CommandName: base64
ManualSection: n
Version: 2.6.1
TclPart: tcllib
TclDescription: Text encoding & decoding binary data
Keywords:
 - base64
 - encoding
Copyright:
 - Copyright (c) 2000, Eric Melski
 - Copyright (c) 2001, Miguel Sofer
---

# Name

base64 - base64-encode/decode binary data

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [base64]{.lit} [2.6.1]{.optlit} 
[::base64::encode]{.cmd} [-maxlen maxlen]{.optarg} [-wrapchar wrapchar]{.optarg} [bstring]{.arg} 
[::base64::decode]{.cmd} [estring]{.arg} 
:::

# Description

This package provides commands for encoding and decoding binary strings to and from the standard base64 encoding as specified in [RFC 4648](https://datatracker.ietf.org/doc/html/rfc4648).

*It is recommended that for new code the built-in* [binary](https://www.tcl-lang.org/man/tcl/TclCmd/binary.html) *subcommands for encoding and decoding base64 (introduced in Tcl 8.6), are used in preference to this package’s commands.*

## Beware: variations in decoding behaviour

Tcl 8.6 introduced built-in support for encoding and decoding base64 using subcommands of the [binary](https://www.tcl-lang.org/man/tcl/TclCmd/binary.html) command:

```
    binary encode base64
    binary decode base64
```

Beware that although these subcommands have the same signatures as the commands provided by this package, the decoders are *not behaviourally compatible*.

The built-in [binary decode base64](https://www.tcl-lang.org/man/tcl/TclCmd/binary.html) subcommand accepts the option **-strict**, enabling the user to choose between strict and nonstrict modes. In strict mode invalid characters, and partial data at the end of the input are reported as errors. In nonstrict mode they are ignored. (See [RFC 2045](https://www.rfc-editor.org/rfc/rfc2045#section-6.8).)

The implementations provided by this package do not offer control over strictness. Instead they mix strict and nonstrict. Partial data at the end of the input is reported as an error, but invalid characters are ignored.

By default this package’s encoder wraps using newlines after every 76 characters of output. The built-in [binary encode base64](https://www.tcl-lang.org/man/tcl/TclCmd/binary.html) subcommand defaults to not wrapping, but does support wrapping using a **-maxlen** option.

# Api

**::base64::encode** ?**-maxlen** *maxlen*? ?**-wrapchar** *wrapchar*? *bstring*
: Returns a base64-encoded version of the binary string *bstring* as its result. The result string contains the *wrapchar* character after every *maxlen* characters of output. The *wrapchar* defaults to newline and *maxlen* defaults to 76. To prevent wrapping, set *maxlen* to **0**. The command will throw an error if *maxlen* is not an integer or is negative, or if *bstring* is neither a binary string, nor a string containing only 7-bit ASCII.

**::base64::decode** *estring*
: Returns a binary string that has been base64-decoded from the *estring*. Any invalid characters or whitespace (spaces, tabs, newlines) in *estring* are ignored.


# Implementation notes

This package contains three different implementations for base64 encoding and decoding, and chooses among them based on the environment it finds itself in.

All three implementations have the same behaviour. See also **Beware: Variations in decoding behaviour** at the beginning of this document.

**\[1\]**
: If Tcl 8.6 or higher is found the commands are implemented in terms of the then-available built-in commands.

**\[2\]**
: If the [Trf](https://wiki.tcl-lang.org/page/Trf) extension can be loaded the commands are implemented in terms of its commands.

**\[3\]**
: If neither of the above are possible a Tcl-only implementation is used. This is much slower.


# Examples

This example shows how to encode and decode a Tcl string to and from base64, taking account of the fact that the base64 commands work in terms of binary strings.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
# Legacy (this package)
set bytes [encoding convertto utf-8 $UTF8_LINE]
set enc64 [::base64::encode $bytes]
set dec64 [::base64::decode $enc64]
set line [encoding convertfrom utf-8 $dec64]
puts "base64='$enc64' [expr {$UTF8_LINE eq $line}]"
=>
base64='zpTDtyDigJxVdGYtOOKAnSDimZ7ihKQ=' 1
# Modern (using built-in binary subcommands)
set bytes [encoding convertto utf-8 $UTF8_LINE]
set enc64 [binary encode base64 $bytes]
set dec64 [binary decode base64 $enc64]
set line [encoding convertfrom utf-8 $dec64]
puts "base64='$enc64' [expr {$UTF8_LINE eq $line}]"
=>
base64='zpTDtyDigJxVdGYtOOKAnSDimZ7ihKQ=' 1
```

If the original string is 7-bit ASCII the conversions to and from raw bytes using the built-in [encoding](https://www.tcl-lang.org/man/tcl/TclCmd/encoding.html) command are not needed. For example:

```
const ASCII_LINE "! 7-bit ASCII {~^}"
# Legacy (this package)
set enc64 [::base64::encode $ASCII_LINE]
set dec64 [::base64::decode $enc64]
set line [encoding convertfrom utf-8 $dec64]
puts "base64='$enc64' [expr {$ASCII_LINE eq $line}]"
=>
base64='ISA3LWJpdCBBU0NJSSB7fl59' 1
# Modern (using built-in binary subcommands)
set enc64 [binary encode base64 $ASCII_LINE]
set dec64 [binary decode base64 $enc64]
set line [encoding convertfrom utf-8 $dec64]
puts "base64='$enc64' [expr {$ASCII_LINE eq $line}]"
=>
base64='ISA3LWJpdCBBU0NJSSB7fl59' 1
```

Wrapping can be prevented so that no whitespace is introduced:

```
base64::encode [string repeat xyz 20]
=>
eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6
eHl6eHl6eHl6
base64::encode -maxlen 0 [string repeat xyz 20]
=>
eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6eHl6
```

Note that the built-in [binary encode base64](https://www.tcl-lang.org/man/tcl/TclCmd/binary.html) subcommand defaults to not wrapping, but will wrap if the **-maxlen** option is used.

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *base64* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing

# Copyright

```
Copyright (c) 2000, Eric Melski
Copyright (c) 2001, Miguel Sofer
```
