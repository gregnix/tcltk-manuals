---
CommandName: ripemd128
ManualSection: n
Version: 1.0.6
TclPart: tcllib
TclDescription: RIPEMD Message-Digest Algorithm
Links:
 - md4
 - md5
 - ripemd160
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

ripemd128 - RIPEMD-128 Message-Digest Algorithm

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [ripemd128]{.lit} [1.0.6]{.optlit} 
[::ripemd::ripemd128]{.cmd} [-hex]{.optarg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \] 
[::ripemd::hmac128]{.cmd} [-hex]{.optarg} [-key]{.arg} [key]{.arg} \[ [-channel]{.arg} [channel]{.arg} | [-file]{.arg} [filename]{.arg} | [string]{.arg} \] 
[::ripemd::RIPEMD128Init]{.cmd} 
[::ripemd::RIPEMD128Update]{.cmd} [token]{.arg} [data]{.arg} 
[::ripemd::RIPEMD128Final]{.cmd} [token]{.arg} 
[::ripemd::RIPEHMAC128Init]{.cmd} [key]{.arg} 
[::ripemd::RIPEHMAC128Update]{.cmd} [token]{.arg} [data]{.arg} 
[::ripemd::RIPEHMAC128Final]{.cmd} [token]{.arg} 
:::

# Description

This package is an implementation in Tcl of the RIPEMD-128 message-digest algorithm (1). This algorithm takes an arbitrary quantity of data and generates a 128-bit message digest from the input. The RIPEMD-128 algorithm is based upon the MD4 algorithm (2, 4) but has been cryptographically strengthened against weaknesses that have been found in MD4 (4). RIPEMD-128 has been designed to be a drop-in replacement for MD4 and MD5 (5). If security is the major consideration, then RIPEMD-160 or SHA1 should be considered.

This package will use **Trf** to accelerate the digest computation if available. In the absence of an accelerator package the pure-Tcl implementation will be used.

*BEWARE* The commands in this package expect binary data as their input. When a **-file** is provided then this is ensured by the commands themselves, as they open the referenced file in binary mode. When literal data, or a **-channel** are provided instead, then the command's *caller is responsible* for ensuring this fact. The necessary conversion command is **encoding convertto utf-8 \$string**.

*ATTENTION*, there is a *Tcl 9 COMPATIBILITY ISSUE* here.

*Tcl 8.x silently mishandles* non-binary input by cutting it internally to size. I.e. by only using the low byte of a higher unicode point. No error is thrown, the *result is simply wrong*.

*Tcl 9 throws an error* instead, i.e.

```
expected byte sequence but character <location> was ...
```

# Commands

**::ripemd::ripemd128** ?*-hex*? \[ *-channel channel* | *-file filename* | *string* \]
: Calculate the RIPEMD-128 digest of the data given in string. This is returned as a binary string by default. Giving the *-hex* option will return a hexadecimal encoded version of the digest. The data to be hashed can be specified either as a string argument to the ripemd128 command, or as a filename or a pre-opened channel. If the *-filename* argument is given then the file is opened, the data read and hashed and the file is closed. If the *-channel* argument is given then data is read from the channel until the end of file. The channel is not closed. Only one of *-file*, *-channel* or *string* should be given.

**::ripemd::hmac128** ?*-hex*? *-key key* \[ *-channel channel* | *-file filename* | *string* \]
: Calculate an Hashed Message Authentication digest (HMAC) using the RIPEMD-128 digest algorithm. HMACs are described in RFC 2104 (6) and provide a RIPEMD-128 digest that includes a key. All options other than *-key* are as for the **::ripemd::ripemd128** command.


# Programming interface

For the programmer, hash functions can be viewed as a bucket into which one pours data. When you have finished, you extract a value that is uniquely derived from the data that was poured into the bucket. The programming interface to the hash operates on a token (equivalent to the bucket). You call **RIPEMD128Init** to obtain a token and then call **RIPEMD128Update** as many times as required to add data to the hash. To release any resources and obtain the hash value, you then call **RIPEMD128Final**. An equivalent set of functions gives you a keyed digest (HMAC).

If you have **critcl** and have built the **tcllibc** package then the implementation of the hashing function will be performed by compiled code. Alternatively if both the Trf and Memchan extensions are available then these will be used. Finally the package will revert to a pure-Tcl implementation.  The programming interface remains the same, however.

**::ripemd::RIPEMD128Init**
: Begins a new RIPEMD-128 hash. Returns a token ID that must be used for the remaining functions.

**::ripemd::RIPEMD128Update** *token* *data*
: Add data to the hash identified by token. Calling *RIPEMD128Update \$token "abcd"* is equivalent to calling *RIPEMD128Update \$token "ab"* followed by *RIPEMD128Update \$token "cb"*. See **EXAMPLES**.

**::ripemd::RIPEMD128Final** *token*
: Returns the hash value and releases any resources held by this token. Once this command completes the token will be invalid. The result is a binary string of 16 bytes representing the 128 bit RIPEMD-128 digest value.

**::ripemd::RIPEHMAC128Init** *key*
: This is equivalent to the **::ripemd::RIPEMD128Init** command except that it requires the key that will be included in the HMAC.

**::ripemd::RIPEHMAC128Update** *token* *data*
: ...see next...

**::ripemd::RIPEHMAC128Final** *token*
: These commands are identical to the RIPEMD128 equivalent commands.


# Examples

```
% ripemd::ripemd128 -hex "Tcl does RIPEMD-128"
3cab177bae65205d81e7978f63556c63
```

```
% ripemd::hmac128 -hex -key Sekret "Tcl does RIPEMD-128"
b359dc5971a05beea0be7b106b30e389
```

```
% set tok [ripemd::RIPEMD128Init]
::ripemd::1
% ripemd::RIPEMD128Update $tok "Tcl "
% ripemd::RIPEMD128Update $tok "does "
% ripemd::RIPEMD128Update $tok "RIPEMD-128"
% ripemd::Hex [ripemd::RIPEMD128Final $tok]
3cab177bae65205d81e7978f63556c63
```

# References

**\[1\]**
: H. Dobbertin, A. Bosselaers, B. Preneel, "RIPEMD-160, a strengthened version of RIPEMD" *http://www.esat.kuleuven.ac.be/~cosicart/pdf/AB-9601/AB-9601.pdf*

**\[2\]**
: Rivest, R., "The MD4 Message Digest Algorithm", RFC 1320, MIT, April 1992. (*http://www.rfc-editor.org/rfc/rfc1320.txt*)

**\[3\]**
: Rivest, R., "The MD4 message digest algorithm", in A.J.  Menezes and S.A. Vanstone, editors, Advances in Cryptology - CRYPTO '90 Proceedings, pages 303-311, Springer-Verlag, 1991.

**\[4\]**
: Dobbertin, H., "Cryptanalysis of MD4", Journal of Cryptology vol 11 (4), pp. 253-271 (1998)

**\[5\]**
: Rivest, R., "The MD5 Message-Digest Algorithm", RFC 1321, MIT and RSA Data Security, Inc, April 1992. (*http://www.rfc-editor.org/rfc/rfc1321.txt*)

**\[6\]**
: Krawczyk, H., Bellare, M. and Canetti, R. "HMAC: Keyed-Hashing for Message Authentication", RFC 2104, February 1997. (*http://www.rfc-editor.org/rfc/rfc2104.txt*)


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
