---
CommandName: des
ManualSection: n
Version: 1.2
TclPart: tcllib
TclDescription: Data Encryption Standard (DES)
Links:
 - aes(n)
 - blowfish(n)
 - md5(n)
 - rc4(n)
 - sha1(n)
Keywords:
 - 3DES
 - DES
 - block cipher
 - data integrity
 - encryption
 - security
Copyright:
 - Copyright (c) 2005, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

des - Implementation of the DES and triple-DES ciphers

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [des]{.lit} [1.2]{.lit} 
[::DES::des]{.cmd} [-mode \[ecb|cbc|cfb|ofb\]]{.optarg} [-dir \[encrypt|decrypt\]]{.optarg} [-key]{.arg} [keydata]{.arg} [-iv vector]{.optarg} [-hex]{.optarg} [-weak]{.optarg} [-out channel]{.optarg} [-chunksize size]{.optarg} \[ [-in]{.arg} [channel]{.arg} | [data]{.arg} \] 
[::DES::Init]{.cmd} [mode]{.arg} [keydata]{.arg} [iv]{.arg} [weak]{.optarg} 
[::DES::Encrypt]{.cmd} [Key]{.arg} [data]{.arg} 
[::DES::Decrypt]{.cmd} [Key]{.arg} [data]{.arg} 
[::DES::Reset]{.cmd} [Key]{.arg} [iv]{.arg} 
[::DES::Final]{.cmd} [Key]{.arg} 
:::

# Description

This is an implementation in Tcl of the Data Encryption Standard (DES) as published by the U.S. National Institute of Standards and Technology (NIST) \[1\]. This implementation also supports triple DES (3DES) extension to DES. DES is a 64-bit block cipher that uses a 56-bit key. 3DES uses a 168-bit key. DES has now officially been superceeded by AES but is in common use in many protocols.

The tcllib implementation of DES and 3DES uses an implementation by Mac Cody and is available as a separate download from \[2\]. For anyone concerned about the details of exporting this code please see the TclDES web pages. The tcllib specific code is a wrapper to the TclDES API that presents same API for the DES cipher as for other ciphers in the library.

# Commands

**::DES::des** ?*-mode \[ecb|cbc|cfb|ofb\]*? ?*-dir \[encrypt|decrypt\]*? *-key keydata* ?*-iv vector*? ?*-hex*? ?*-weak*? ?*-out channel*? ?*-chunksize size*? \[ *-in channel* | *data* \]
: Perform the **DES** algorithm on either the data provided by the argument or on the data read from the *-in* channel. If an *-out* channel is given then the result will be written to this channel. The *-key* option must be given. This parameter takes a binary string of 8 bytes in length and is used to generate the key schedule. In DES only 56 bits of key data are used. The highest bit from each byte is discarded. The *-mode* and *-dir* options are optional and default to cbc mode and encrypt respectively. The initialization vector *-iv* takes an 8 byte binary argument. This defaults to all zeros. See **MODES OF OPERATION** for more about *-mode* and the use of the initialization vector. DES is a 64-bit block cipher. This means that the data must be provided in units that are a multiple of 8 bytes.


# Programming interface

Internal state is maintained in an opaque structure that is returned from the **Init** function. In ECB mode the state is not affected by the input but for other modes some input dependent state is maintained and may be reset by calling the **Reset** function with a new initialization vector value.

**::DES::Init** *mode* *keydata* *iv* ?*weak*?
: Construct a new DES key schedule using the specified key data and the given initialization vector. The initialization vector is not used with ECB mode but is important for other usage modes. See **MODES OF OPERATION**. There are a small number of keys that are known to be weak when used with DES. By default if such a key is passed in then an error will be raised. If there is a need to accept such keys then the *weak* parameter can be set true to avoid the error being thrown.

**::DES::Encrypt** *Key* *data*
: Use a prepared key acquired by calling **Init** to encrypt the provided data. The data argument should be a binary array that is a multiple of the DES block size of 8 bytes. The result is a binary array the same size as the input of encrypted data.

**::DES::Decrypt** *Key* *data*
: Decipher data using the key. Note that the same key may be used to encrypt and decrypt data provided that the initialization vector is reset appropriately for CBC mode.

**::DES::Reset** *Key* *iv*
: Reset the initialization vector. This permits the programmer to re-use a key and avoid the cost of re-generating the key schedule where the same key data is being used multiple times.

**::DES::Final** *Key*
: This should be called to clean up resources associated with *Key*. Once this function has been called the key may not be used again.


# Modes of operation

**Electronic Code Book (ECB)**
: ECB is the basic mode of all block ciphers. Each block is encrypted independently and so identical plain text will produce identical output when encrypted with the same key. Any encryption errors will only affect a single block however this is vulnerable to known plaintext attacks.

**Cipher Block Chaining (CBC)**
: CBC mode uses the output of the last block encryption to affect the current block. An initialization vector of the same size as the cipher block size is used to handle the first block. The initialization vector should be chosen randomly and transmitted as the first block of the output. Errors in encryption affect the current block and the next block after which the cipher will correct itself. CBC is the most commonly used mode in software encryption.

**Cipher Feedback (CFB)**
: CFB mode can be used to convert block ciphers into stream ciphers. In CFB mode the initialization vector is encrypted and the output is then xor'd with the plaintext stream. The result is then used as the initialization vector for the next round. Errors will affect the current block and the next block.

**Output Feedback (OFB)**
: OFB is similar to CFB except that the output of the cipher is fed back into the next round and not the xor'd plain text. This means that errors only affect a single block but the cipher is more vulnerable to attack.


# Examples

```
% set ciphertext [DES::des -mode cbc -dir encrypt -key $secret $plaintext]
% set plaintext [DES::des -mode cbc -dir decrypt -key $secret $ciphertext]
```

```
set iv [string repeat \\0 8]
set Key [DES::Init cbc \\0\\1\\2\\3\\4\\5\\6\\7 $iv]
set ciphertext [DES::Encrypt $Key "somedata"]
append ciphertext [DES::Encrypt $Key "moredata"]
DES::Reset $Key $iv
set plaintext [DES::Decrypt $Key $ciphertext]
DES::Final $Key
```

# References

**\[1\]**
: "Data Encryption Standard", Federal Information Processing Standards Publication 46-3, 1999, (*http://csrc.nist.gov/publications/fips/fips46-3/fips46-3.pdf*)

**\[2\]**
: "TclDES: munitions-grade Tcl scripting" *http://tcldes.sourceforge.net/*


# Authors

Jochen C Loewer, Mac Cody, Pat Thoyts

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *des* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2005, Pat Thoyts <patthoyts@users.sourceforge.net>
```
