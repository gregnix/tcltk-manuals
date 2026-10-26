---
CommandName: sha1
ManualSection: n
Version: 2.0.5
TclPart: tcllib
TclDescription: SHA-x Message-Digest Algorithm
Links:
 - md4
 - md5
 - ripemd128
 - ripemd160
Keywords:
 - FIPS 180-1
 - hashing
 - message-digest
 - rfc 2104
 - security
 - sha1
Copyright:
 - Copyright (c) 2005, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

sha1 - SHA1 Message-Digest Algorithm

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [sha1]{.lit} [2.0.5]{.optlit} 
[::sha1::sha1]{.cmd} [-hex|-bin]{.optlit} \[ [-channel]{.lit} [channel]{.lit} | [-file]{.lit} [filename]{.lit} | [--]{.optlit} [string]{.arg} \] 
[::sha1::hmac]{.cmd} [key]{.arg} [string]{.arg} 
[::sha1::hmac]{.cmd} [-hex|-bin]{.optlit} [-key]{.lit} [key]{.lit} \[ [-channel]{.lit} [channel]{.lit} | [-file]{.lit} [filename]{.lit} | [--]{.optlit} [string]{.arg} \] 
[::sha1::SHA1Init]{.cmd} 
[::sha1::SHA1Update]{.cmd} [token]{.arg} [data]{.arg} 
[::sha1::SHA1Final]{.cmd} [token]{.arg} 
[::sha1::HMACInit]{.cmd} [key]{.arg} 
[::sha1::HMACUpdate]{.cmd} [token]{.arg} [data]{.arg} 
[::sha1::HMACFinal]{.cmd} [token]{.arg} 
:::

# Description

This package provides an implementation in Tcl of the SHA1 message-digest algorithm as specified by FIPS PUB 180-1 (1). This algorithm takes a message and generates a 160-bit digest from the input. The SHA1 algorithm is related to the MD4 algorithm (2) but has been strengthend against certain types of cryptographic attack. SHA1 should be used in preference to MD4 or MD5 in new applications.

This package also includes support for creating keyed message-digests using the HMAC algorithm from RFC 2104 (3) with SHA1 as the message-digest.

*BEWARE* The commands in this package expect binary data as their input. When a **-file** is provided then this is ensured by the commands themselves, as they open the referenced file in binary mode. When literal data, or a **-channel** are provided instead, then the command's *caller is responsible* for ensuring this fact. The necessary conversion command is **encoding convertto utf-8 \$string**.

*ATTENTION*, there is a *Tcl 9 COMPATIBILITY ISSUE* here.

*Tcl 8.x silently mishandles* non-binary input by cutting it internally to size. I.e. by only using the low byte of a higher unicode point. No error is thrown, the *result is simply wrong*.

*Tcl 9 throws an error* instead, i.e.

```
expected byte sequence but character <location> was ...
```

# Commands

**::sha1::sha1** ?**-hex|-bin**? \[ **-channel channel** | **-file filename** | ?**--**? *string* \]
: The command takes a message and returns the SHA1 digest of this message as a hexadecimal string. You may request the result as binary data by giving *-bin*. The data to be hashed can be specified either as a string argument to the **sha1** command, or as a filename or a pre-opened channel. If the *-filename* argument is given then the file is opened, the data read and hashed and the file is closed. If the *-channel* argument is given then data is read from the channel until the end of file. The channel is not closed. *NOTE* use of the channel or filename options results in the internal use of **vwait**. To avoid nested event loops in Tk or tclhttpd applications you should use the incremental programming API (see below). Only one of *-file*, *-channel* or *string* should be given. If the *string* to hash can be mistaken for an option (leading dash "-"), use the option **--** before it to terminate option processing and force interpretation as a string.

**::sha1::hmac** *key* *string*
: ...see next...

**::sha1::hmac** ?**-hex|-bin**? **-key key** \[ **-channel channel** | **-file filename** | ?**--**? *string* \]
: Calculate an Hashed Message Authentication digest (HMAC) using the SHA1 digest algorithm. HMACs are described in RFC 2104 (3) and provide an SHA1 digest that includes a key. All options other than *-key* are as for the **::sha1::sha1** command. If the *string* to hash can be mistaken for an option (leading dash "-"), use the option **--** before it to terminate option processing and force interpretation as a string.


# Programming interface

For the programmer, the SHA1 hash can be viewed as a bucket into which one pours data. When you have finished, you extract a value that is derived from the data that was poured into the bucket. The programming interface to the SHA1 hash operates on a token (equivalent to the bucket). You call **SHA1Init** to obtain a token and then call **SHA1Update** as many times as required to add data to the hash. To release any resources and obtain the hash value, you then call **SHA1Final**. An equivalent set of functions gives you a keyed digest (HMAC).

If you have **critcl** and have built the **tcllibc** package then the implementation of the hashing function will be performed by compiled code. Failing that if you have the **Trf** package then this can be used otherwise there is a pure-tcl equivalent. The programming interface remains the same in all cases.

**::sha1::SHA1Init**
: Begins a new SHA1 hash. Returns a token ID that must be used for the remaining functions.

**::sha1::SHA1Update** *token* *data*
: Add data to the hash identified by token. Calling *SHA1Update \$token "abcd"* is equivalent to calling *SHA1Update \$token "ab"* followed by *SHA1Update \$token "cb"*. See **EXAMPLES**.

**::sha1::SHA1Final** *token*
: Returns the hash value and releases any resources held by this token. Once this command completes the token will be invalid. The result is a binary string of 20 bytes representing the 160 bit SHA1 digest value.

**::sha1::HMACInit** *key*
: This is equivalent to the **::sha1::SHA1Init** command except that it requires the key that will be included in the HMAC.

**::sha1::HMACUpdate** *token* *data*
: ...see next...

**::sha1::HMACFinal** *token*
: These commands are identical to the SHA1 equivalent commands.


# Examples

```
% sha1::sha1 "Tcl does SHA1"
285a6a91c45a9066bf39fcf24425796ef0b2a8bf
```

```
% sha1::hmac Sekret "Tcl does SHA1"
ae6251fa51b95b18cba2be95eb031d07475ff03c
```

```
% set tok [sha1::SHA1Init]
::sha1::1
% sha1::SHA1Update $tok "Tcl "
% sha1::SHA1Update $tok "does "
% sha1::SHA1Update $tok "SHA1"
% sha1::Hex [sha1::SHA1Final $tok]
285a6a91c45a9066bf39fcf24425796ef0b2a8bf
```

# References

**\[1\]**
: "Secure Hash Standard", National Institute of Standards and Technology, U.S. Department Of Commerce, April 1995. (*http://www.itl.nist.gov/fipspubs/fip180-1.htm*)

**\[2\]**
: Rivest, R., "The MD4 Message Digest Algorithm", RFC 1320, MIT, April 1992. (*http://www.rfc-editor.org/rfc/rfc1320.txt*)

**\[3\]**
: Krawczyk, H., Bellare, M. and Canetti, R. "HMAC: Keyed-Hashing for Message Authentication", RFC 2104, February 1997. (*http://www.rfc-editor.org/rfc/rfc2104.txt*)


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *sha1* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2005, Pat Thoyts <patthoyts@users.sourceforge.net>
```
