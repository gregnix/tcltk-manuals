---
CommandName: cksum
title: cksum
ManualSection: n
Version: 1.1.5
TclPart: tcllib
TclDescription: Cyclic Redundancy Checks
Links:
 - crc32(n)
 - sum(n)
Keywords:
 - checksum
 - cksum
 - crc
 - crc32
 - cyclic redundancy check
 - data integrity
 - security
Copyright:
 - Copyright (c) 2002, Pat Thoyts
---

# Name

cksum - Calculate a cksum(1) compatible checksum

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [cksum]{.lit} [1.1.5]{.optlit}
[::crc::cksum]{.cmd} [-format format]{.optarg} [-chunksize size]{.optarg} \[ [-channel]{.arg} [chan]{.arg} | [-filename]{.arg} [file]{.arg} | [string]{.arg} \]
[::crc::CksumInit]{.cmd}
[::crc::CksumUpdate]{.cmd} [token]{.arg} [data]{.arg}
[::crc::CksumFinal]{.cmd} [token]{.arg}
:::

# Description

This package provides a Tcl implementation of the cksum(1) algorithm based upon information provided at in the GNU implementation of this program as part of the GNU Textutils 2.0 package.

# Commands

**::crc::cksum** ?*-format format*? ?*-chunksize size*? \[ *-channel chan* | *-filename file* | *string* \]
: The command takes string data or a channel or file name and returns a checksum value calculated using the **cksum(1)** algorithm. The result is formatted using the *format*(n) specifier provided or as an unsigned integer (%u) by default.


# Options

-channel *name*
: Return a checksum for the data read from a channel. The command will read data from the channel until the **eof** is true. If you need to be able to process events during this calculation see the [Programming interface] section

-filename *name*
: This is a convenience option that opens the specified file, sets the encoding to binary and then acts as if the *-channel* option had been used. The file is closed on completion.

-format *string*
: Return the checksum using an alternative format template.


# Programming interface

The cksum package implements the checksum using a context variable to which additional data can be added at any time. This is expecially useful in an event based environment such as a Tk application or a web server package. Data to be checksummed may be handled incrementally during a **fileevent** handler in discrete chunks. This can improve the interactive nature of a GUI application and can help to avoid excessive memory consumption.

**::crc::CksumInit**
: Begins a new cksum context. Returns a token ID that must be used for the remaining functions. An optional seed may be specified if required.

**::crc::CksumUpdate** *token* *data*
: Add data to the checksum identified by token. Calling *CksumUpdate $token "abcd"* is equivalent to calling *CksumUpdate $token "ab"* followed by *CksumUpdate $token "cb"*. See [Examples].

**::crc::CksumFinal** *token*
: Returns the checksum value and releases any resources held by this token. Once this command completes the token will be invalid. The result is a 32 bit integer value.


# Examples

```
% crc::cksum "Hello, World!"
2609532967
```

```
% crc::cksum -format 0x%X "Hello, World!"
0x9B8A5027
```

```
% crc::cksum -file cksum.tcl
1828321145
```

```
% set tok [crc::CksumInit]
% crc::CksumUpdate $tok "Hello, "
% crc::CksumUpdate $tok "World!"
% crc::CksumFinal $tok
2609532967
```

# Authors

Pat Thoyts

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *crc* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2002, Pat Thoyts
```
