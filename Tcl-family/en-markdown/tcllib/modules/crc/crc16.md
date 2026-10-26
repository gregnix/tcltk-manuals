---
CommandName: crc16
ManualSection: n
Version: 1.1.5
TclPart: tcllib
TclDescription: Cyclic Redundancy Checks
Links:
 - cksum(n)
 - crc32(n)
 - sum(n)
Keywords:
 - checksum
 - cksum
 - crc
 - crc16
 - crc32
 - cyclic redundancy check
 - data integrity
 - security
Copyright:
 - Copyright (c) 2002, 2017, Pat Thoyts
---

# Name

crc16 - Perform a 16bit Cyclic Redundancy Check

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [crc16]{.lit} [1.1.5]{.optlit} 
[::crc::crc16]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::crc16]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::crc-ccitt]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::crc-ccitt]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::xmodem]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::xmodem]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::kermit]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::kermit]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::modbus]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::modbus]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::mcrf4xx]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::mcrf4xx]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::genibus]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::genibus]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::crc-x25]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::crc-x25]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::crc-sdlc]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::crc-sdlc]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::crc-usb]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::crc-usb]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::buypass]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::buypass]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::umts]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::umts]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::gsm]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::gsm]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::unknown2]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::unknown2]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::maxim]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::maxim]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::unknown3]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::unknown3]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::unknown4]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::unknown4]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
[::crc::cms]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} [--]{.lit} [message]{.arg} 
[::crc::cms]{.cmd} [-format format]{.optarg} [-seed value]{.optarg} [-implementation procname]{.optarg} -filename [file]{.arg} 
:::

# Description

This package provides a Tcl-only implementation of the CRC algorithms based upon information provided at http://www.microconsultants.com/tips/crc/crc.txt There are a number of permutations available for calculating CRC checksums and this package can handle all of them. Defaults are set up for the most common cases.

# Commands

**::crc::crc16** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::crc16** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::crc-ccitt** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::crc-ccitt** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::xmodem** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::xmodem** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::kermit** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::kermit** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::modbus** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::modbus** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::mcrf4xx** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::mcrf4xx** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::genibus** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::genibus** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::crc-x25** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::crc-x25** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::crc-sdlc** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::crc-sdlc** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::crc-usb** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::crc-usb** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::buypass** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::buypass** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::umts** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::umts** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::gsm** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::gsm** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::unknown2** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::unknown2** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::maxim** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::maxim** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::unknown3** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::unknown3** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::unknown4** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::unknown4** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: ...see next...

**::crc::cms** ?-format *format*? ?-seed *value*? ?-implementation *procname*? **--** *message*
: ...see next...

**::crc::cms** ?-format *format*? ?-seed *value*? ?-implementation *procname*? -filename *file*
: The command takes either string data or a file name and returns a checksum value calculated using the CRC algorithm. The command used sets up the CRC polynomial, initial value and bit ordering for the desired standard checksum calculation. The result is formatted using the *format*(n) specifier provided or as an unsigned integer (%u) by default. A number of common polynomials are in use with the CRC algorithm and the most commonly used of these are included in this package. For convenience each of these has a command alias in the crc namespace. It is possible to implement the CRC-32 checksum using this crc16 package as the implementation is sufficiently generic to extend to 32 bit checksums. As an example this has been done already - however this is not the fastest method to implement this algorithm in Tcl and a separate **crc32** package is available.


# Options

-filename *name*
: Return a checksum for the file contents instead of for parameter data.

-format *string*
: Return the checksum using an alternative format template.

-seed *value*
: Select an alternative seed value for the CRC calculation. The default is 0 for the CRC16 calculation and 0xFFFF for the CCITT version. This can be useful for calculating the CRC for data structures without first converting the whole structure into a string. The CRC of the previous member can be used as the seed for calculating the CRC of the next member. It is also used for accumulating a checksum from fragments of a large message (or file)

-implementation *procname*
: This hook is provided to allow users to provide their own implementation (perhaps a C compiled extension). The procedure specfied is called with two parameters. The first is the data to be checksummed and the second is the seed value. An integer is expected as the result. The package provides some implementations of standard CRC polynomials for the XMODEM, CCITT and the usual CRC-16 checksum. For convenience, additional commands have been provided that make use of these implementations.

**--**
: Terminate option processing. Please note that using the option termination flag is important when processing data from parameters. If the binary data looks like one of the options given above then the data will be read as an option if this marker is not included. Always use the *--* option termination flag before giving the data argument.


# Examples

```
% crc::crc16 -- "Hello, World!"
64077
```

```
% crc::crc-ccitt -- "Hello, World!"
26586
```

```
% crc::crc16 -format 0x%X -- "Hello, World!"
0xFA4D
```

```
% crc::crc16 -file crc16.tcl
51675
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
Copyright (c) 2002, 2017, Pat Thoyts
```
