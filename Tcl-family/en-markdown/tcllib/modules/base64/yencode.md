---
CommandName: yencode
title: yencode
ManualSection: n
Version: 1.1.4
TclPart: tcllib
TclDescription: Text encoding & decoding binary data
Keywords:
 - encoding
 - yEnc
 - ydecode
 - yencode
Copyright:
 - Copyright (c) 2002, Pat Thoyts
---

# Name

yencode - Y-encode/decode binary data

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [yencode]{.lit} [1.1.4]{.optlit}
[::yencode::encode]{.cmd} [bstring]{.arg}
[::yencode::decode]{.cmd} [estring]{.arg}
[::yencode::yencode]{.cmd} [[-name]{.lit} [string]{.arg}]{.optarg} [[-line]{.lit} [integer]{.arg}]{.optarg} [[-crc32]{.lit} [boolean]{.arg}]{.optarg} ([-file]{.lit} [filename]{.arg} | [--]{.optlit} [bstring]{.arg})
[::yencode::ydecode]{.cmd} ([-file]{.lit} [filename]{.arg} | [--]{.optlit} [estring]{.arg})
:::

# Description

This package provides a Tcl-only implementation of the yEncode file encoding used for Usenet messages. This encoding packs binary data into a format that requires an 8-bit clean transmission layer but that escapes characters special to the *NNTP* posting protocols. See <http://www.yenc.org> for the encoding’s details.

# API

**::yencode::encode** *bstring*
: Returns a yEncoded version of the binary string *bstring* as its result.

    The command will throw an error if *bstring* is neither a binary string, nor a string containing only 7-bit ASCII.

**::yencode::decode** *estring*
: Returns a binary string that has been yEncode-decoded from the *estring*.

**::yencode::yencode** ?**-name** *string*? ?**-line** *integer*? ?**-crc32** *boolean*? (**-file** *filename* | ?**--**? *bstring*)
: Returns a wrapped yEncoded version of the data in the file specified by **-file** *filename* or by the binary string *bstring* as its result.

    Each wrapped yEncoded result consists of a header, body, and trailer. The header is a line starting with **=ybegin** followed by a line length of form **line=***length*, the size of the original data (in bytes) of form **size=***size*, and the name of the original file of form **name=***filename*, all space-separated. The body is the yEncoded data. The trailer is a line starting with **=yend** followed by the size of the original data of form **size=***size*, and optionally (but recommended), a CRC32 checksum value of form **crc32=***checksum*, all space-separated.

**::yencode::ydecode** (**-file** *filename* | ?**--**? *estring*)
: Returns a list of 3-element lists of filename, file size, yEncode-decoded bytes, from the file specified by **-file** *filename* or from the *estring*.


## Options

**-file** *filename*
: Cause the **yencode** or **ydecode** commands to read their data from the named file rather that taking a binary string parameter.

**-name** *string*
: The yEncoded data header line contains the original file name to be used when unpacking the data. Use this option to change this from the default of "default.bin".

**-line** *integer*
: The yEncoded header line specifies the line length used for the encoding, and which defaults to 128. Use this option to set a different line length. Note that NNTP imposes a 1000 character line length limit and some systems may have trouble with more than 255 characters per line.

**-crc32** *boolean*
: When encoding this package puts a cyclic redundancy check (CRC) value in the trailer as recommended in the yEncode specification. This can be prevented by using this option and passing a false value for *boolean*, e.g., **0**.


# Examples

*The yEncoded data is not shown in the examples because it is just raw bytes.*

This example shows how to yEncode and yEncode-decode a Tcl string, taking account of the fact that the yEncode commands work in terms of binary strings.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
set bytes [encoding convertto utf-8 $UTF8_LINE]
set ency [::yencode::encode $bytes]
set decy [::yencode::decode $ency]
set line [encoding convertfrom utf-8 $decy]
puts "[expr {$UTF8_LINE eq $line}]"
=>
1
```

If the original string is 7-bit ASCII the conversions to and from raw bytes using the built-in **encoding** command are not needed. For example:

```
const ASCII_LINE "! 7-bit ASCII {~^}"
set ency [::yencode::encode $ASCII_LINE]
set decy [::yencode::decode $ency]
set line [encoding convertfrom utf-8 $decy]
puts "[expr {$ASCII_LINE eq $line}]"
=>
1
```

This example shows how to create a yEncoded byte string and write it to a file.

```
set bytes [encoding convertto utf-8 $UTF8_LINE]
set ency [::yencode::yencode -name test.y $bytes]
writeFile test.y binary $ency
puts $ency
=>
=ybegin line=128 size=23 name=test.y
    … raw binary data elided …
=yend size=23 crc32=fc01071
```

This example shows how to read a file containing one or more yEncoded files.

```
foreach lst [::yencode::ydecode $ency] {
    lassign $lst name size decy
    set line [encoding convertfrom utf-8 $decy]
    puts "name=$name size=$size line='$line'"
}
=>
name=test.y size=23 line='Δ÷ “Utf-8” ♞ℤ'
```

# References

1. <http://www.yenc.org/yenc-draft.1.3.txt>


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *base64* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Text processing

# Copyright

```
Copyright (c) 2002, Pat Thoyts
```
