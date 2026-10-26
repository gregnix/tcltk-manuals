---
CommandName: otp
ManualSection: n
Version: 1.1.0
TclPart: tcllib
TclDescription: RFC 2289 A One-Time Password System
Links:
 - SASL
 - md4
 - md5
 - ripemd160
 - sha1
Keywords:
 - hashing
 - message-digest
 - password
 - rfc 2289
 - security
Copyright:
 - Copyright (c) 2006, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

otp - One-Time Passwords

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [otp]{.lit} [1.1.0]{.optlit} 
[::otp::otp-md4]{.cmd} [-hex]{.optarg} [-words]{.optarg} [-seed]{.arg} [seed]{.arg} [-count]{.arg} [count]{.arg} [data]{.arg} 
[::otp::otp-md5]{.cmd} [-hex]{.optarg} [-words]{.optarg} [-seed]{.arg} [seed]{.arg} [-count]{.arg} [count]{.arg} [data]{.arg} 
[::otp::otp-sha1]{.cmd} [-hex]{.optarg} [-words]{.optarg} [-seed]{.arg} [seed]{.arg} [-count]{.arg} [count]{.arg} [data]{.arg} 
[::otp::otp-rmd160]{.cmd} [-hex]{.optarg} [-words]{.optarg} [-seed]{.arg} [seed]{.arg} [-count]{.arg} [count]{.arg} [data]{.arg} 
:::

# Description

This package is an implementation in Tcl of the One-Time Password system as described in RFC 2289 (1). This system uses message-digest algorithms to sequentially hash a passphrase to create single-use passwords. The resulting data is then provided to the user as either hexadecimal digits or encoded using a dictionary of 2048 words. This system is used by OpenBSD for secure login and can be used as a SASL mechanism for authenticating users.

In this implementation we provide support for four algorithms that are included in the tcllib distribution: MD5 (2), MD4 (3), RIPE-MD160 (4) and SHA-1 (5).

# Commands

**::otp::otp-md4** ?*-hex*? ?*-words*? *-seed seed* *-count count* *data*
: ...see next...

**::otp::otp-md5** ?*-hex*? ?*-words*? *-seed seed* *-count count* *data*
: ...see next...

**::otp::otp-sha1** ?*-hex*? ?*-words*? *-seed seed* *-count count* *data*
: ...see next...

**::otp::otp-rmd160** ?*-hex*? ?*-words*? *-seed seed* *-count count* *data*
: 


# Examples

```
% otp::otp-md5 -count 99 -seed host67821 "My Secret Pass Phrase"
(binary gibberish)
% otp::otp-md5 -words -count 99 -seed host67821 "My Secret Pass Phrase"
SOON ARAB BURG LIMB FILE WAD
% otp::otp-md5 -hex -count 99 -seed host67821 "My Secret Pass Phrase"
e249b58257c80087
```

# References

**\[1\]**
: Haller, N. et al., "A One-Time Password System", RFC 2289, February 1998. *http://www.rfc-editor.org/rfc/rfc2289.txt*

**\[2\]**
: Rivest, R., "The MD5 Message-Digest Algorithm", RFC 1321, MIT and RSA Data Security, Inc, April 1992. (*http://www.rfc-editor.org/rfc/rfc1321.txt*)

**\[3\]**
: Rivest, R., "The MD4 Message Digest Algorithm", RFC 1320, MIT, April 1992. (*http://www.rfc-editor.org/rfc/rfc1320.txt*)

**\[4\]**
: H. Dobbertin, A. Bosselaers, B. Preneel, "RIPEMD-160, a strengthened version of RIPEMD" *http://www.esat.kuleuven.ac.be/~cosicart/pdf/AB-9601/AB-9601.pdf*

**\[5\]**
: "Secure Hash Standard", National Institute of Standards and Technology, U.S. Department Of Commerce, April 1995. (*http://www.itl.nist.gov/fipspubs/fip180-1.htm*)


# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *otp* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2006, Pat Thoyts <patthoyts@users.sourceforge.net>
```
