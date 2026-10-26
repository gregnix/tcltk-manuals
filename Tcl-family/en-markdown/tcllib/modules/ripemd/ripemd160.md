---
CommandName: ripemd160
title: ripemd160
ManualSection: n
Version: 1.0.7
TclPart: tcllib
TclDescription: RIPEMD Message-Digest Algorithm
Links:
 - md4
 - md5
 - ripemd128
 - sha1
Keywords:
 - RIPEMD
 - hashing
 - md4
 - message-digest
 - rfc 1320
 - rfc 1321
 - rfc 2104
 - security
Copyright:
 - Copyright (c) 2004, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

ripemd160 - RIPEMD-160 Message-Digest Algorithm

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [ripemd160]{.lit} [1.0.7]{.optlit}
[::ripemd::ripemd160]{.cmd} [-hex]{.optarg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \]
[::ripemd::hmac160]{.cmd} [-hex]{.optarg} [-key]{.arg} [key]{.arg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \]
[::ripemd::RIPEMD160Init]{.cmd}
[::ripemd::RIPEMD160Update]{.cmd} [token]{.arg} [data]{.arg}
[::ripemd::RIPEMD160Final]{.cmd} [token]{.arg}
[::ripemd::RIPEHMAC160Init]{.cmd} [key]{.arg}
[::ripemd::RIPEHMAC160Update]{.cmd} [token]{.arg} [data]{.arg}
[::ripemd::RIPEHMAC160Final]{.cmd} [token]{.arg}
:::

# Description

This package is an implementation in Tcl of the RIPEMD-160 message-digest algorithm (1). This algorithm takes an arbitrary quantity of data and generates a 160-bit message digest from the input. The RIPEMD-160 algorithm is based upon the MD4 algorithm (2, 4) but has been cryptographically strengthened against weaknesses that have been found in MD4 (4).

This package will use **cryptkit** or **Trf** to accelerate the digest computation if either package is available. In the absence of an accelerator package the pure-Tcl implementation will be used.

*BEWARE* The commands in this package expect binary data as their input. When a **-file** is provided then this is ensured by the commands themselves, as they open the referenced file in binary mode. When literal data, or a **-channel** are provided instead, then the command's *caller is responsible* for ensuring this fact. The necessary conversion command is **encoding convertto utf-8 $string**.

*ATTENTION*, there is a *Tcl 9 COMPATIBILITY ISSUE* here.

*Tcl 8.x silently mishandles* non-binary input by cutting it internally to size. I.e. by only using the low byte of a higher unicode point. No error is thrown, the *result is simply wrong*.

*Tcl 9 throws an error* instead, i.e.

```
expected byte sequence but character <location> was ...
```

# Commands

**::ripemd::ripemd160** ?*-hex*? \[ *-channel channel* | *-file filename* | *string* \]
: Calculate the RIPEMD-160 digest of the data given in string. This is returned as a binary string by default. Giving the *-hex* option will return a hexadecimal encoded version of the digest.

    The data to be hashed can be specified either as a string argument to the ripemd160 command, or as a filename or a pre-opened channel. If the *-filename* argument is given then the file is opened, the data read and hashed and the file is closed. If the *-channel* argument is given then data is read from the channel until the end of file. The channel is not closed.

    Only one of *-file*, *-channel* or *string* should be given.

**::ripemd::hmac160** ?*-hex*? *-key key* \[ *-channel channel* | *-file filename* | *string* \]
: Calculate an Hashed Message Authentication digest (HMAC) using the RIPEMD-160 digest algorithm. HMACs are described in RFC 2104 (5) and provide a RIPEMD-160 digest that includes a key. All options other than *-key* are as for the **::ripemd::ripemd160** command.


# Programming interface

For the programmer, hash functions can be viewed as a bucket into which one pours data. When you have finished, you extract a value that is uniquely derived from the data that was poured into the bucket. The programming interface to the hash operates on a token (equivalent to the bucket). You call **RIPEMD160Init** to obtain a token and then call **RIPEMD160Update** as many times as required to add data to the hash. To release any resources and obtain the hash value, you then call **RIPEMD160Final**. An equivalent set of functions gives you a keyed digest (HMAC).

**::ripemd::RIPEMD160Init**
: Begins a new RIPEMD-160 hash. Returns a token ID that must be used for the remaining functions.

**::ripemd::RIPEMD160Update** *token* *data*
: Add data to the hash identified by token. Calling *RIPEMD160Update $token "abcd"* is equivalent to calling *RIPEMD160Update $token "ab"* followed by *RIPEMD160Update $token "cb"*. See [Examples].

**::ripemd::RIPEMD160Final** *token*
: Returns the hash value and releases any resources held by this token. Once this command completes the token will be invalid. The result is a binary string of 16 bytes representing the 160 bit RIPEMD-160 digest value.

**::ripemd::RIPEHMAC160Init** *key*
: This is equivalent to the **::ripemd::RIPEMD160Init** command except that it requires the key that will be included in the HMAC.

**::ripemd::RIPEHMAC160Update** *token* *data*
: see below ...

**::ripemd::RIPEHMAC160Final** *token*
: These commands are identical to the RIPEMD160 equivalent commands.


# Examples

```
% ripemd::ripemd160 -hex "Tcl does RIPEMD-160"
0829dea75a1a7074c702896723fe37763481a0a7
```

```
% ripemd::hmac160 -hex -key Sekret "Tcl does RIPEMD-160"
bf0c927231733686731dddb470b64a9c23f7f53b
```

```
% set tok [ripemd::RIPEMD160Init]
::ripemd::1
% ripemd::RIPEMD160Update $tok "Tcl "
% ripemd::RIPEMD160Update $tok "does "
% ripemd::RIPEMD160Update $tok "RIPEMD-160"
% ripemd::Hex [ripemd::RIPEMD160Final $tok]
0829dea75a1a7074c702896723fe37763481a0a7
```

# References

1. H. Dobbertin, A. Bosselaers, B. Preneel, "RIPEMD-160, a strengthened version of RIPEMD" <http://www.esat.kuleuven.ac.be/~cosicart/pdf/AB-9601/AB-9601.pdf>

2. Rivest, R., "The MD4 Message Digest Algorithm", RFC 1320, MIT, April 1992. (<http://www.rfc-editor.org/rfc/rfc1320.txt>)

3. Rivest, R., "The MD4 message digest algorithm", in A.J.  Menezes and S.A. Vanstone, editors, Advances in Cryptology - CRYPTO '90 Proceedings, pages 303-311, Springer-Verlag, 1991.

4. Dobbertin, H., "Cryptanalysis of MD4", Journal of Cryptology vol 11 (4), pp. 253-271 (1998)

5. Krawczyk, H., Bellare, M. and Canetti, R. "HMAC: Keyed-Hashing for Message Authentication", RFC 2104, February 1997. (<http://www.rfc-editor.org/rfc/rfc2104.txt>)


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *ripemd* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2004, Pat Thoyts <patthoyts@users.sourceforge.net>
```
