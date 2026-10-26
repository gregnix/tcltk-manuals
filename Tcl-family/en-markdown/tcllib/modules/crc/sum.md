---
CommandName: sum
title: sum
ManualSection: n
Version: 1.1.3
TclPart: tcllib
TclDescription: Cyclic Redundancy Checks
Links:
 - cksum(n)
 - crc32(n)
 - sum(1)
Keywords:
 - checksum
 - cksum
 - crc
 - crc32
 - cyclic redundancy check
 - data integrity
 - security
 - sum
Copyright:
 - Copyright (c) 2002, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

sum - Calculate a sum(1) compatible checksum

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [sum]{.lit} [1.1.3]{.optlit}
[::crc::sum]{.cmd} [-bsd | -sysv]{.optarg} [-format fmt]{.optarg} [-chunksize size]{.optarg} \[ [-filename]{.arg} [file]{.arg} | [-channel]{.arg} [chan]{.arg} | [string]{.arg} \]
:::

# Description

This package provides a Tcl-only implementation of the sum(1) command which calculates a 16 bit checksum value from the input data.  The BSD sum algorithm is used by default but the SysV algorithm is also available.

# Commands

**::crc::sum** ?*-bsd* | *-sysv*? ?*-format fmt*? ?*-chunksize size*? \[ *-filename file* | *-channel chan* | *string* \]
: The command takes string data or a file name or a channel and returns a checksum value calculated using the **sum(1)** algorithm. The result is formatted using the *format*(n) specifier provided or as an unsigned integer (%u) by default.


# Options

-sysv
: The SysV algorithm is fairly naive. The byte values are summed and any overflow is discarded. The lowest 16 bits are returned as the checksum.  Input with the same content but different ordering will give the same result.

-bsd
: This algorithm is similar to the SysV version but includes a bit rotation step which provides a dependency on the order of the data values.

-filename *name*
: Return a checksum for the file contents instead of for parameter data.

-channel *chan*
: Return a checksum for the contents of the specified channel. The channel must be open for reading and should be configured for binary translation. The channel will no be closed on completion.

-chunksize *size*
: Set the block size used when reading data from either files or channels. This value defaults to 4096.

-format *string*
: Return the checksum using an alternative format template.


# Examples

```
% crc::sum "Hello, World!"
37287
```

```
% crc::sum -format 0x%X "Hello, World!"
0x91A7
```

```
% crc::sum -file sum.tcl
13392
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
Copyright (c) 2002, Pat Thoyts <patthoyts@users.sourceforge.net>
```
