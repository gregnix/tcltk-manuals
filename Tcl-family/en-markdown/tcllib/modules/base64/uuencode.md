---
CommandName: uuencode
ManualSection: n
Version: 1.1.6
TclPart: tcllib
TclDescription: Text encoding & decoding binary data
Keywords:
 - encoding
 - uuencode
Copyright:
 - Copyright (c) 2002, Pat Thoyts
---

# Name

uuencode - UU-encode/decode binary data

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [uuencode]{.lit} [1.1.6]{.optlit} 
[::uuencode::encode]{.cmd} [bstring]{.arg} 
[::uuencode::decode]{.cmd} [estring]{.arg} 
[::uuencode::uuencode]{.cmd} [-name string]{.optarg} [-mode octal]{.optarg} (-file [filename]{.arg} | [--]{.optlit} [bstring)]{.arg} 
[::uuencode::uudecode]{.cmd} (-file [filename]{.arg} | [--]{.optlit} [estring)]{.arg} 
:::

# Description

This package provides a Tcl-only implementation of the **uuencode(1p)** <https://www.man7.org/linux/man-pages/man1/uuencode.1p.html> and **uudecode(1p)** <https://www.man7.org/linux/man-pages/man1/uudecode.1p.html> commands. This encoding packs binary data into printable 7-bit ASCII characters.

# Api

**::uuencode::encode** *bstring*
: Returns a uuencoded version of the binary string *bstring* as its result. All the given bytes are encoded even if they exceed the uuencode maximum line length. If the number of input bytes is not a multiple of 3 then the string is padded with additional **\\x00** NUL bytes. The command will throw an error if *bstring* is neither a binary string, nor a string containing only 7-bit ASCII.

**::uuencode::decode** *estring*
: Returns a binary string that has been uuencode-decoded from the *estring*, including any padding **\\x00** NUL bytes at the end.

**::uuencode::uuencode** ?**-name** *string*? ?**-mode** *octal*? (**-file** *filename* |  ?**--**? *bstring*)
: Returns a wrapped uuencoded version of the data in the file specified by **-file** *filename* or by the binary string *bstring* as its result. Each wrapped uuencoded result consists of a header, body, and footer. The header is a line starting with **begin** followed by a suggested file mode and suggested filename. The body consists of lines of uuencoded data, each prefixed with a line length character. The footer is **end** on its own line. See **uuencode(1)** <https://www.man7.org/linux/man-pages/man1/uuencode.1p.html>.

**::uuencode::uudecode** (**-file** *filename* |  ?**--**? *estring*)
: Returns a list of 3-element lists of filename, file mode, uuencode-decoded bytes, from the file specified by **-file** *filename* or from the *estring*.


## Options

**-file** *filename*
: Cause the **uuencode** or **uudecode** commands to read their data from the named file rather that taking a binary string parameter.

**-name** *string*
: The uuencoded data header line contains the suggested file name to be used when unpacking the data. Use this option to change this from the default of "data.dat".

**-mode** *octal*
: The uuencoded data header line contains a suggested permissions bit pattern expressed as an octal string. To change the default of 0644 you can set this option. For instance, 0755 would be suitable for an executable. See **chmod(1)** <https://www.man7.org/linux/man-pages/man1/chmod.1.html>.


# Examples

The examples use the subcommand **string trimright** to trim any **\\x00** NUL bytes that may have been added during encoding. *Note however, that if the original binary strings might end with* **\\x00** NUL *bytes, a more sophisticated approach will be needed.*

This example shows how to uuencode and uudecode a Tcl string, taking account of the fact that the uuencode commands work in terms of binary strings.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
set bytes [encoding convertto utf-8 $UTF8_LINE]
set encuu [::uuencode::encode $bytes]
set decuu [string trimright [::uuencode::decode $encuu] \x00]
set line [encoding convertfrom utf-8 $decuu]
puts "uuencode='$encuu' [expr {$UTF8_LINE eq $line}]"
=>
uuencode='SI3#MR#B@)Q5=&8M..*`G2#BF9[BA*0`' 1
```

If the original string is 7-bit ASCII the conversions to and from raw bytes using the built-in **encoding** command are not needed. For example:

```
const ASCII_LINE "! 7-bit ASCII {~^}"
set encuu [::uuencode::encode $ASCII_LINE]
set decuu [string trimright [::uuencode::decode $encuu] \x00]
set line [encoding convertfrom utf-8 $decuu]
puts "uuencode='$encuu' [expr {$ASCII_LINE eq $line}]"
=>
uuencode='(2`W+6)I="!!4T-)22![?EY]' 1
```

This example shows how to create a uuencoded byte string and write it to a file.

```
const UTF8_LINE "Δ÷ “Utf-8” ♞ℤ"
set bytes [encoding convertto utf-8 $UTF8_LINE]
set encuu [::uuencode::uuencode -name test.uu $bytes]
writeFile test.uu binary $encuu
puts $encuu
=>
begin 644 test.uu
7SI3#MR#B@)Q5=&8M..*`G2#BF9[BA*0`
`
end
```

This example shows how to read a file containing one or more uuencoded files.

```
foreach lst [::uuencode::uudecode -file test.uu] {
    lassign $lst name mode decuu
    set decuu [string trimright $decuu \x00]
    set line [encoding convertfrom utf-8 $decuu]
    puts "name=$name mode=$mode line='$line'"
}
=>
name=test.uu mode=644 line='Δ÷ “Utf-8” ♞ℤ'
```

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
