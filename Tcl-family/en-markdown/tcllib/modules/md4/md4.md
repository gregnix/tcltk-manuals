---
CommandName: md4
ManualSection: n
Version: 1.0.8
TclPart: tcllib
TclDescription: MD4 Message-Digest Algorithm
Links:
 - md5
 - sha1
Keywords:
 - hashing
 - md4
 - message-digest
 - rfc 1320
 - rfc 1321
 - rfc 2104
 - security
Copyright:
 - Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

md4 - MD4 Message-Digest Algorithm

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [md4]{.lit} [1.0.8]{.optlit} 
[::md4::md4]{.cmd} [-hex]{.optarg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \] 
[::md4::hmac]{.cmd} [-hex]{.optarg} [-key]{.arg} [key]{.arg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \] 
[::md4::MD4Init]{.cmd} 
[::md4::MD4Update]{.cmd} [token]{.arg} [data]{.arg} 
[::md4::MD4Final]{.cmd} [token]{.arg} 
[::md4::HMACInit]{.cmd} [key]{.arg} 
[::md4::HMACUpdate]{.cmd} [token]{.arg} [data]{.arg} 
[::md4::HMACFinal]{.cmd} [token]{.arg} 
:::

# Description

This package is an implementation in Tcl of the MD4 message-digest algorithm as described in RFC 1320 (1) and (2). This algorithm takes an arbitrary quantity of data and generates a 128-bit message digest from the input. The MD4 algorithm is faster but potentially weaker than the related MD5 algorithm (3).

If you have **critcl** and have built the **tcllibc** package then the implementation of the hashing function will be performed by compiled code. Alternatively if **cryptkit** is available this will be used. If no accelerator package can be found then the pure-tcl implementation is used. The programming interface remains the same in all cases.

*BEWARE* The commands in this package expect binary data as their input. When a **-file** is provided then this is ensured by the commands themselves, as they open the referenced file in binary mode. When literal data, or a **-channel** are provided instead, then the command's *caller is responsible* for ensuring this fact. The necessary conversion command is **encoding convertto utf-8 \$string**.

*ATTENTION*, there is a *Tcl 9 COMPATIBILITY ISSUE* here.

*Tcl 8.x silently mishandles* non-binary input by cutting it internally to size. I.e. by only using the low byte of a higher unicode point. No error is thrown, the *result is simply wrong*.

*Tcl 9 throws an error* instead, i.e.

```
expected byte sequence but character <location> was ...
```

# Commands

**::md4::md4** ?*-hex*? \[ *-channel channel* | *-file filename* | *string* \]
: Calculate the MD4 digest of the data given in string. This is returned as a binary string by default. Giving the *-hex* option will return a hexadecimal encoded version of the digest. The data to be hashed can be specified either as a string argument to the md4 command, or as a filename or a pre-opened channel. If the *-filename* argument is given then the file is opened, the data read and hashed and the file is closed. If the *-channel* argument is given then data is read from the channel until the end of file. The channel is not closed. Only one of *-file*, *-channel* or *string* should be given.

**::md4::hmac** ?*-hex*? *-key key* \[ *-channel channel* | *-file filename* | *string* \]
: Calculate an Hashed Message Authentication digest (HMAC) using the MD4 digest algorithm. HMACs are described in RFC 2104 (4) and provide an MD4 digest that includes a key. All options other than *-key* are as for the **::md4::md4** command.


# Programming interface

For the programmer, the MD4 hash can be viewed as a bucket into which one pours data. When you have finished, you extract a value that is derived from the data that was poured into the bucket. The programming interface to the MD4 hash operates on a token (equivalent to the bucket). You call **MD4Init** to obtain a token and then call **MD4Update** as many times as required to add data to the hash. To release any resources and obtain the hash value, you then call **MD4Final**. An equivalent set of functions gives you a keyed digest (HMAC).

**::md4::MD4Init**
: Begins a new MD4 hash. Returns a token ID that must be used for the remaining functions.

**::md4::MD4Update** *token* *data*
: Add data to the hash identified by token. Calling *MD4Update \$token "abcd"* is equivalent to calling *MD4Update \$token "ab"* followed by *MD4Update \$token "cb"*. See **EXAMPLES**.

**::md4::MD4Final** *token*
: Returns the hash value and releases any resources held by this token. Once this command completes the token will be invalid. The result is a binary string of 16 bytes representing the 128 bit MD4 digest value.

**::md4::HMACInit** *key*
: This is equivalent to the **::md4::MD4Init** command except that it requires the key that will be included in the HMAC.

**::md4::HMACUpdate** *token* *data*
: ...see next...

**::md4::HMACFinal** *token*
: These commands are identical to the MD4 equivalent commands.


# Examples

```
% md4::md4 -hex "Tcl does MD4"
858da9b31f57648a032230447bd15f25
```

```
% md4::hmac -hex -key Sekret "Tcl does MD4"
c324088e5752872689caedf2a0464758
```

```
% set tok [md4::MD4Init]
::md4::1
% md4::MD4Update $tok "Tcl "
% md4::MD4Update $tok "does "
% md4::MD4Update $tok "MD4"
% md4::Hex [md4::MD4Final $tok]
858da9b31f57648a032230447bd15f25
```

# References

**\[1\]**
: Rivest, R., "The MD4 Message Digest Algorithm", RFC 1320, MIT, April 1992. (*http://www.rfc-editor.org/rfc/rfc1320.txt*)

**\[2\]**
: Rivest, R., "The MD4 message digest algorithm", in A.J.  Menezes and S.A. Vanstone, editors, Advances in Cryptology - CRYPTO '90 Proceedings, pages 303-311, Springer-Verlag, 1991.

**\[3\]**
: Rivest, R., "The MD5 Message-Digest Algorithm", RFC 1321, MIT and RSA Data Security, Inc, April 1992. (*http://www.rfc-editor.org/rfc/rfc1321.txt*)

**\[4\]**
: Krawczyk, H., Bellare, M. and Canetti, R. "HMAC: Keyed-Hashing for Message Authentication", RFC 2104, February 1997. (*http://www.rfc-editor.org/rfc/rfc2104.txt*)


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *md4* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
```
