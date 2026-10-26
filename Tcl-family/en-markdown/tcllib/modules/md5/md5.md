---
CommandName: md5
ManualSection: n
Version: 2.0.9
TclPart: tcllib
TclDescription: MD5 Message-Digest Algorithm
Links:
 - md4
 - sha1
Keywords:
 - hashing
 - md5
 - message-digest
 - rfc 1320
 - rfc 1321
 - rfc 2104
 - security
Copyright:
 - Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

md5 - MD5 Message-Digest Algorithm

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [md5]{.lit} [2.0.9]{.optlit} 
[::md5::md5]{.cmd} [-hex]{.optarg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \] 
[::md5::hmac]{.cmd} [-hex]{.optarg} [-key]{.arg} [key]{.arg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \] 
[::md5::MD5Init]{.cmd} 
[::md5::MD5Update]{.cmd} [token]{.arg} [data]{.arg} 
[::md5::MD5Final]{.cmd} [token]{.arg} 
[::md5::HMACInit]{.cmd} [key]{.arg} 
[::md5::HMACUpdate]{.cmd} [token]{.arg} [data]{.arg} 
[::md5::HMACFinal]{.cmd} [token]{.arg} 
:::

# Description

This package is an implementation in Tcl of the MD5 message-digest algorithm as described in RFC 1321 (1). This algorithm takes an arbitrary quantity of data and generates a 128-bit message digest from the input. The MD5 algorithm is related to the MD4 algorithm (2) but has been strengthened against certain types of potential attack. MD5 should be used in preference to MD4 for new applications.

If you have **critcl** and have built the **tcllibc** package then the implementation of the hashing function will be performed by compiled code. Alternatively if you have either **cryptkit** or **Trf** then either of these is used to accelerate the digest computation. If no suitable compiled package is available then the pure-Tcl implementation is used. The programming interface remains the same in all cases.

*Note* the previous version of this package always returned a hex encoded string. This has been changed to simplify the programming interface and to make this version more compatible with other implementations. To obtain the previous usage, either explicitly specify package version 1 or use the *-hex* option to the **md5** command.

*BEWARE* The commands in this package expect binary data as their input. When a **-file** is provided then this is ensured by the commands themselves, as they open the referenced file in binary mode. When literal data, or a **-channel** are provided instead, then the command's *caller is responsible* for ensuring this fact. The necessary conversion command is **encoding convertto utf-8 \$string**.

*ATTENTION*, there is a *Tcl 9 COMPATIBILITY ISSUE* here.

*Tcl 8.x silently mishandles* non-binary input by cutting it internally to size. I.e. by only using the low byte of a higher unicode point. No error is thrown, the *result is simply wrong*.

*Tcl 9 throws an error* instead, i.e.

```
expected byte sequence but character <location> was ...
```

# Commands

**::md5::md5** ?*-hex*? \[ *-channel channel* | *-file filename* | *string* \]
: Calculate the MD5 digest of the binary data given in string. This is returned as a binary string by default. Giving the *-hex* option will return a hexadecimal encoded version of the digest. The data to be hashed can be specified either as a string argument to the **md5** command, or as a filename or a pre-opened channel. If the *-filename* argument is given then the file is opened, the data read and hashed and the file is closed. If the *-channel* argument is given then data is read from the channel until the end of file. The channel is not closed. Only one of *-file*, *-channel* or *string* should be given.

**::md5::hmac** ?*-hex*? *-key key* \[ *-channel channel* | *-file filename* | *string* \]
: Calculate an Hashed Message Authentication digest (HMAC) using the MD5 digest algorithm. HMACs are described in RFC 2104 (3) and provide an MD5 digest that includes a key. All options other than *-key* are as for the **::md5::md5** command.


# Programming interface

For the programmer, the MD5 hash can be viewed as a bucket into which one pours data. When you have finished, you extract a value that is derived from the data that was poured into the bucket. The programming interface to the MD5 hash operates on a token (equivalent to the bucket). You call **MD5Init** to obtain a token and then call **MD5Update** as many times as required to add data to the hash. To release any resources and obtain the hash value, you then call **MD5Final**. An equivalent set of functions gives you a keyed digest (HMAC).

**::md5::MD5Init**
: Begins a new MD5 hash. Returns a token ID that must be used for the remaining functions.

**::md5::MD5Update** *token* *data*
: Add data to the hash identified by token. Calling *MD5Update \$token "abcd"* is equivalent to calling *MD5Update \$token "ab"* followed by *MD5Update \$token "cb"*. See **EXAMPLES**.

**::md5::MD5Final** *token*
: Returns the hash value and releases any resources held by this token. Once this command completes the token will be invalid. The result is a binary string of 16 bytes representing the 128 bit MD5 digest value.

**::md5::HMACInit** *key*
: This is equivalent to the **::md5::MD5Init** command except that it requires the key that will be included in the HMAC.

**::md5::HMACUpdate** *token* *data*
: ...see next...

**::md5::HMACFinal** *token*
: These commands are identical to the MD5 equivalent commands.


# Examples

```
% md5::md5 -hex "Tcl does MD5"
8AAC1EE01E20BB347104FABB90310433
```

```
% md5::hmac -hex -key Sekret "Tcl does MD5"
35BBA244FD56D3EDF5F3C47474DACB5D
```

```
% set tok [md5::MD5Init]
::md5::1
% md5::MD5Update $tok "Tcl "
% md5::MD5Update $tok "does "
% md5::MD5Update $tok "MD5"
% md5::Hex [md5::MD5Final $tok]
8AAC1EE01E20BB347104FABB90310433
```

# References

**\[1\]**
: Rivest, R., "The MD5 Message-Digest Algorithm", RFC 1321, MIT and RSA Data Security, Inc, April 1992. (*http://www.rfc-editor.org/rfc/rfc1321.txt*)

**\[2\]**
: Rivest, R., "The MD4 Message Digest Algorithm", RFC 1320, MIT, April 1992. (*http://www.rfc-editor.org/rfc/rfc1320.txt*)

**\[3\]**
: Krawczyk, H., Bellare, M. and Canetti, R. "HMAC: Keyed-Hashing for Message Authentication", RFC 2104, February 1997. (*http://www.rfc-editor.org/rfc/rfc2104.txt*)


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *md5* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
```
