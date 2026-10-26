---
CommandName: blowfish
title: blowfish
ManualSection: n
Version: 1.0.6
TclPart: tcllib
TclDescription: Blowfish Block Cipher
Links:
 - 3des
 - des
 - rc4
Keywords:
 - block cipher
 - blowfish
 - cryptography
 - encryption
 - security
Copyright:
 - Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

blowfish - Implementation of the Blowfish block cipher

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [blowfish]{.lit} [1.0.6]{.optlit}
[::blowfish::blowfish]{.cmd} [-mode \[ecb|cbc\]]{.optarg} [-dir \[encrypt|decrypt\]]{.optarg} [-key]{.arg} [keydata]{.arg} [-iv vector]{.optarg} [-out channel]{.optarg} [-chunksize size]{.optarg} [-pad padchar]{.optarg} \[ [-in]{.arg} [channel]{.arg} | [--]{.optarg} [data]{.arg} \]
[::blowfish::Init]{.cmd} [mode]{.arg} [keydata]{.arg} [iv]{.arg}
[::blowfish::Encrypt]{.cmd} [Key]{.arg} [data]{.arg}
[::blowfish::Decrypt]{.cmd} [Key]{.arg} [data]{.arg}
[::blowfish::Reset]{.cmd} [Key]{.arg} [iv]{.arg}
[::blowfish::Final]{.cmd} [Key]{.arg}
:::

# Description

This package is an implementation in Tcl of the Blowfish algorithm developed by Bruce Schneier \[1\]. Blowfish is a 64-bit block cipher designed to operate quickly on 32 bit architectures and accepting a variable key length. This implementation supports ECB and CBC mode blowfish encryption.

# Commands

**::blowfish::blowfish** ?*-mode \[ecb|cbc\]*? ?*-dir \[encrypt|decrypt\]*? *-key keydata* ?*-iv vector*? ?*-out channel*? ?*-chunksize size*? ?*-pad padchar*? \[ *-in channel* | ?*--*? *data* \]
: Perform the **blowfish** algorithm on either the data provided by the argument or on the data read from the *-in* channel. If an *-out* channel is given then the result will be written to this channel.

    The *-key* option must be given. This parameter takes a binary string of variable length and is used to generate the **blowfish** key schedule. You should be aware that creating a key schedule is quite an expensive operation in blowfish so it is worth reusing the key where possible. See **Reset**.

    The *-mode* and *-dir* options are optional and default to cbc mode and encrypt respectively. The initialization vector *-iv* takes an 8 byte binary argument which defaults to 8 zeros. See [Modes of operation] for more about available modes and their uses.

    Blowfish is a 64-bit block cipher. This means that the data must be provided in units that are a multiple of 8 bytes. The **blowfish** command will by default add nul characters to pad the input data to a multiple of 8 bytes if necessary. The programming api commands will never add padding and instead will raise an error if the input is not a multiple of the block size. The *-pad* option can be used to change the padding character or to disable padding if the empty string is provided as the argument.


# Programming interface

**::blowfish::Init** *mode* *keydata* *iv*
: Construct a new blowfish key schedule using the specified key data and the given initialization vector. The initialization vector is not used with ECB mode but is important for CBC mode. See [Modes of operation] for details about cipher modes.

**::blowfish::Encrypt** *Key* *data*
: Use a prepared key acquired by calling **Init** to encrypt the provided data. The data argument should be a binary array that is a multiple of the block size of 8 bytes. The result is a binary array the same size as the input of encrypted data.

**::blowfish::Decrypt** *Key* *data*
: Decipher data using the key. Note that the same key may be used to encrypt and decrypt data provided that the initialization vector is reset appropriately for CBC mode.

**::blowfish::Reset** *Key* *iv*
: Reset the initialization vector. This permits the programmer to re-use a key and avoid the cost of re-generating the key schedule where the same key data is being used multiple times.

**::blowfish::Final** *Key*
: This should be called to clean up resources associated with *Key*. Once this function has been called the key may not be used again.


# Modes of operation

Electronic Code Book (ECB)
: ECB is the basic mode of all block ciphers. Each block is encrypted independently and so identical plain text will produce identical output when encrypted with the same key. Any encryption errors will only affect a single block however this is vulnerable to known plaintext attacks.

Cipher Block Chaining (CBC)
: CBC mode uses the output of the last block encryption to affect the current block. An initialization vector of the same size as the cipher block size is used to handle the first block. The initialization vector should be chosen randomly and transmitted as the first block of the output. Errors in encryption affect the current block and the next block after which the cipher will correct itself. CBC is the most commonly used mode in software encryption.


# Examples

```
% blowfish::blowfish -hex -mode ecb -dir encrypt -key secret01 "hello, world!"
d0d8f27e7a374b9e2dbd9938dd04195a
```

```
 set Key [blowfish::Init cbc $eight_bytes_key_data $eight_byte_iv]
 append ciphertext [blowfish::Encrypt $Key $plaintext]
 append ciphertext [blowfish::Encrypt $Key $additional_plaintext]
 blowfish::Final $Key
```

# References

1. Schneier, B. "Applied Cryptography, 2nd edition", 1996, ISBN 0-471-11709-9, pub. John Wiley & Sons.


# Authors

Frank Pilhofer, Pat Thoyts

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *blowfish* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
```
