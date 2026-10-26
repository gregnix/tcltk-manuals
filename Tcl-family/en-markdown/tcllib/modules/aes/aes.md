---
CommandName: aes
ManualSection: n
Version: 1.2.2
TclPart: tcllib
TclDescription: Advanced Encryption Standard (AES)
Links:
 - blowfish(n)
 - des(n)
 - md5(n)
 - sha1(n)
Keywords:
 - aes
 - block cipher
 - data integrity
 - encryption
 - security
Copyright:
 - Copyright (c) 2005, Pat Thoyts <patthoyts@users.sourceforge.net>
 - Copyright (c) 2012-2014, Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

aes - Implementation of the AES block cipher

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [aes]{.lit} [1.2.2]{.optlit} 
[::aes::aes]{.cmd} [-mode \[ecb|cbc\]]{.optarg} [-dir \[encrypt|decrypt\]]{.optarg} [-key]{.arg} [keydata]{.arg} [-iv vector]{.optarg} [-hex]{.optarg} [-out channel]{.optarg} [-chunksize size]{.optarg} \[ [-in]{.arg} [channel]{.arg} | [--]{.optlit} [data]{.arg} \] 
[::aes::Init]{.cmd} [mode]{.arg} [keydata]{.arg} [iv]{.arg} 
[::aes::Encrypt]{.cmd} [Key]{.arg} [data]{.arg} 
[::aes::Decrypt]{.cmd} [Key]{.arg} [data]{.arg} 
[::aes::Reset]{.cmd} [Key]{.arg} [iv]{.arg} 
[::aes::Final]{.cmd} [Key]{.arg} 
:::

# Description

This is a Tcl implementation of the Advanced Encryption Standard (AES) as published by the U.S. National Institute of Standards and Technology \[1\]. AES is a 128-bit block cipher with a variable key size of 128, 192 or 256 bits. This implementation supports CBC and ECB modes.

# Commands

**::aes::aes** ?*-mode \[ecb|cbc\]*? ?*-dir \[encrypt|decrypt\]*? *-key keydata* ?*-iv vector*? ?*-hex*? ?*-out channel*? ?*-chunksize size*? \[ *-in channel* | ?**--**? *data* \]
: Perform the **aes** algorithm on either the data provided by the argument or on the data read from the *-in* channel. If an *-out* channel is given then the result will be written to this channel. The *-key* option must be given. This parameter takes a binary string of either 16, 24 or 32 bytes in length and is used to generate the key schedule. The *-mode* and *-dir* options are optional and default to CBC mode and encrypt respectively. The initialization vector *-iv* takes a 16 byte binary argument which defaults to all zeros. See **MODES OF OPERATION** for more about available modes and their uses. Since AES is a 128-bit block cipher, the data must be provided in units that are a multiple of 16 bytes.


# Programming interface

Internal state is maintained in an opaque structure that is returned from the **Init** function. For CBC mode some input dependent state is maintained and may be reset by calling the **Reset** function with a new initialization vector value. In ECB mode the state is not affected by the input.

**::aes::Init** *mode* *keydata* *iv*
: Construct a new AES key schedule using the specified key data and the given initialization vector. The initialization vector is important for CBC mode; it is not used with ECB mode. See **MODES OF OPERATION** for details about cipher modes.

**::aes::Encrypt** *Key* *data*
: Use a prepared key acquired by calling **Init** to encrypt the provided data. The data argument should be a binary array that is a multiple of the AES block size of 16 bytes. The result is a binary array the same size as the input of encrypted data.

**::aes::Decrypt** *Key* *data*
: Decipher data using the key. Note that the same key may be used to encrypt and decrypt data provided that the initialization vector is reset appropriately for CBC mode.

**::aes::Reset** *Key* *iv*
: Reset the initialization vector. This permits the programmer to re-use a key and avoid the cost of re-generating the key schedule where the same key data is being used multiple times.

**::aes::Final** *Key*
: This should be called to clean up resources associated with *Key*. Once this function has been called the key may not be used again.


# Modes of operation

**Cipher Block Chaining (CBC)**
: CBC mode uses the output of the last block encryption to affect the current block. An initialization vector of the same size as the cipher block size is used to handle the first block. The initialization vector should be chosen randomly and transmitted as the first block of the output. Errors in encryption affect the current block and the next block after which the cipher will correct itself. CBC is the most commonly used mode in software encryption, and this module’s default mode of operation.

**Electronic Code Book (ECB)**
: ECB is the basic mode of all block ciphers. Each block is encrypted independently and so identical plain text will produce identical output when encrypted with the same key. Any encryption errors will only affect a single block. *This mode is vulnerable to known plaintext attacks.*


# Examples

```
% set nil_block [string repeat \\0 16]
% aes::aes -hex -mode cbc -dir encrypt -key $nil_block $nil_block
66e94bd4ef8a2c3b884cfa59ca342b2e
```

```
set Key [aes::Init cbc $sixteen_bytes_key_data $sixteen_byte_iv]
append ciphertext [aes::Encrypt $Key $plaintext]
append ciphertext [aes::Encrypt $Key $additional_plaintext]
aes::Final $Key
```

# References

**\[1\]**
: "Advanced Encryption Standard", Federal Information Processing Standards Publication 197, 2001 (*http://csrc.nist.gov/publications/fips/fips197/fips-197.pdf*)


# Authors

Thorsten Schloermann, Pat Thoyts

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *aes* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2005, Pat Thoyts <patthoyts@users.sourceforge.net>
Copyright (c) 2012-2014, Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
