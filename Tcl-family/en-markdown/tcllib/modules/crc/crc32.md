---
CommandName: crc32
title: crc32
ManualSection: n
Version: 1.3.4
TclPart: tcllib
TclDescription: Cyclic Redundancy Checks
Links:
 - cksum(n)
 - crc16(n)
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

crc32 - Perform a 32bit Cyclic Redundancy Check

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [crc32]{.lit} [1.3.4]{.optlit}
[::crc::crc32]{.cmd} [[-format]{.lit} [format]{.arg}]{.optarg} [[-seed]{.lit} [value]{.arg}]{.optarg} \[ [-channel]{.arg} [chan]{.arg} | [-filename]{.arg} [file]{.arg} | [message]{.arg} \]
[::crc::Crc32Init]{.cmd} [seed]{.optarg}
[::crc::Crc32Update]{.cmd} [token]{.arg} [data]{.arg}
[::crc::Crc32Final]{.cmd} [token]{.arg}
:::

# Description

This package provides a Tcl implementation of the CRC-32 algorithm based upon information provided at <http://www.naaccr.org/standard/crc32/document.html> If either the **critcl** package or the **Trf** package are available then a compiled version may be used internally to accelerate the checksum calculation.

# Commands

**::crc::crc32** ?-format *format*? ?-seed *value*? \[ *-channel chan* | *-filename file* | *message* \]
: The command takes either string data or a channel or file name and returns a checksum value calculated using the CRC-32 algorithm. The result is formatted using the *format*(n) specifier provided. The default is to return the value as an unsigned integer (format %u).


# Options

-channel *name*
: Return a checksum for the data read from a channel. The command will read data from the channel until the **eof** is true. If you need to be able to process events during this calculation see the [Programming interface] section

-filename *name*
: This is a convenience option that opens the specified file, sets the encoding to binary and then acts as if the *-channel* option had been used. The file is closed on completion.

-format *string*
: Return the checksum using an alternative format template.

-seed *value*
: Select an alternative seed value for the CRC calculation. The default is 0xffffffff. This can be useful for calculating the CRC for data structures without first converting the whole structure into a string. The CRC of the previous member can be used as the seed for calculating the CRC of the next member. Note that the crc32 algorithm includes a final XOR step. If incremental processing is desired then this must be undone before using the output of the algorithm as the seed for further processing. A simpler alternative is to use the [Programming interface] which is intended for this mode of operation.


# Programming interface

The CRC-32 package implements the checksum using a context variable to which additional data can be added at any time. This is expecially useful in an event based environment such as a Tk application or a web server package. Data to be checksummed may be handled incrementally during a **fileevent** handler in discrete chunks. This can improve the interactive nature of a GUI application and can help to avoid excessive memory consumption.

**::crc::Crc32Init** ?*seed*?
: Begins a new CRC32 context. Returns a token ID that must be used for the remaining functions. An optional seed may be specified if required.

**::crc::Crc32Update** *token* *data*
: Add data to the checksum identified by token. Calling *Crc32Update $token "abcd"* is equivalent to calling *Crc32Update $token "ab"* followed by *Crc32Update $token "cb"*. See [Examples].

**::crc::Crc32Final** *token*
: Returns the checksum value and releases any resources held by this token. Once this command completes the token will be invalid. The result is a 32 bit integer value.


# Examples

```
% crc::crc32 "Hello, World!"
3964322768
```

```
% crc::crc32 -format 0x%X "Hello, World!"
0xEC4AC3D0
```

```
% crc::crc32 -file crc32.tcl
483919716
```

```
% set tok [crc::Crc32Init]
% crc::Crc32Update $tok "Hello, "
% crc::Crc32Update $tok "World!"
% crc::Crc32Final $tok
3964322768
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
