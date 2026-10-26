---
CommandName: rc4
ManualSection: n
Version: 1.2.0
TclPart: tcllib
TclDescription: RC4 Stream Cipher
Links:
 - aes(n)
 - blowfish(n)
 - des(n)
Keywords:
 - arcfour
 - data integrity
 - encryption
 - rc4
 - security
 - stream cipher
Copyright:
 - Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

rc4 - Implementation of the RC4 stream cipher

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [rc4]{.lit} [1.2.0]{.optlit} 
[::rc4::rc4]{.cmd} [-hex]{.optarg} [-key]{.arg} [keyvalue]{.arg} [-command lst]{.optarg} [-out channel]{.optarg} \[ [-in]{.arg} [channel]{.arg} | [-infile]{.arg} [filename]{.arg} | [string]{.arg} \] 
[::rc4::RC4Init]{.cmd} [keydata]{.arg} 
[::rc4::RC4]{.cmd} [Key]{.arg} [data]{.arg} 
[::rc4::RC4Final]{.cmd} [Key]{.arg} 
:::

# Description

This package is an implementation in Tcl of the RC4 stream cipher developed by Ron Rivest of RSA Data Security Inc. The cipher was a trade secret of RSA but was reverse-engineered and published to the internet in 1994. It is used in a number of network protocols for securing communications. To evade trademark restrictions this cipher is sometimes known as ARCFOUR.

# Commands

**::rc4::rc4** ?*-hex*? *-key keyvalue* ?*-command lst*? ?*-out channel*? \[ *-in channel* | *-infile filename* | *string* \]
: Perform the RC4 algorithm on either the data provided by the argument or on the data read from the *-in* channel. If an *-out* channel is given then the result will be written to this channel. Giving the *-hex* option will return a hexadecimal encoded version of the result if not using an *-out* channel. The data to be processes can be specified either as a string argument to the rc4 command, or as a filename or a pre-opened channel. If the *-infile* argument is given then the file is opened, the data read and processed and the file is closed. If the *-in* argument is given then data is read from the channel until the end of file. The channel is not closed. If the *-out* argument is given then the processing result is written to this channel. If *-command* is provided then the rc4 command does not return anything. Instead the command provided is called with the rc4 result data appended as the final parameter. This is most useful when reading from Tcl channels as a fileevent is setup on the channel and the data processed in chunks Only one of *-infile*, *-in* or *string* should be given.


# Programming interface

**::rc4::RC4Init** *keydata*
: Initialize a new RC4 key. The *keydata* is any amount of binary data and is used to initialize the cipher internal state.

**::rc4::RC4** *Key* *data*
: Encrypt or decrypt the input data using the key obtained by calling **RC4Init**.

**::rc4::RC4Final** *Key*
: This should be called to clean up resources associated with *Key*. Once this function has been called the key is destroyed.


# Examples

```
% set keydata [binary format H* 0123456789abcdef]
% rc4::rc4 -hex -key $keydata HelloWorld
3cf1ae8b7f1c670b612f
% rc4::rc4 -key $keydata [binary format H* 3cf1ae8b7f1c670b612f]
HelloWorld
```

```
 set Key [rc4::RC4Init "key data"]
 append ciphertext [rc4::RC4 $Key $plaintext]
 append ciphertext [rc4::RC4 $Key $additional_plaintext]
 rc4::RC4Final $Key
```

```
 proc ::Finish {myState data} {
     DoStuffWith $myState $data
 }
 rc4::rc4 -in $socket -command [list ::Finish $ApplicationState]
```

# Authors

Pat Thoyts

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *rc4* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
```
