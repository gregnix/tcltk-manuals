---
CommandName: md5crypt
ManualSection: n
Version: 1.2.0
TclPart: tcllib
TclDescription: MD5-based password encryption
Links:
 - md5
Keywords:
 - hashing
 - md5
 - md5crypt
 - message-digest
 - security
Copyright:
 - Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
---

# Name

md5crypt - MD5-based password encryption

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [md5]{.lit} [2.0]{.lit} 
[package]{.cmd} [require]{.sub} [md5crypt]{.lit} [1.2.0]{.optlit} 
[::md5crypt::md5crypt]{.cmd} [password]{.arg} [salt]{.arg} 
[::md5crypt::aprcrypt]{.cmd} [password]{.arg} [salt]{.arg} 
[::md5crypt::salt]{.cmd} [length]{.optarg} 
:::

# Description

This package provides an implementation of the MD5-crypt password encryption algorithm as pioneered by FreeBSD and currently in use as a replacement for the unix crypt(3) function in many modern systems. An implementation of the closely related Apache MD5-crypt is also available. The output of these commands are compatible with the BSD and OpenSSL implementation of md5crypt and the Apache 2 htpasswd program.

# Commands

**::md5crypt::md5crypt** *password* *salt*
: Generate a BSD compatible md5-encoded password hash from the plaintext password and a random salt (see SALT).

**::md5crypt::aprcrypt** *password* *salt*
: Generate an Apache compatible md5-encoded password hash from the plaintext password and a random salt (see SALT).

**::md5crypt::salt** ?*length*?
: Generate a random salt string suitable for use with the **md5crypt** and **aprcrypt** commands.


# Salt

The salt passed to either of the encryption schemes implemented here is checked to see if it begins with the encryption scheme magic string (either "\$1\$" for MD5-crypt or "\$apr1\$" for Apache crypt). If so, this is removed. The remaining characters up to the next \$ and up to a maximum of 8 characters are then used as the salt. The salt text should probably be restricted to the set of ASCII alphanumeric characters plus "./" (dot and forward-slash) - this is to preserve maximum compatibility with the unix password file format.

If a password is being generated rather than checked from a password file then the **salt** command may be used to generate a random salt.

# Examples

```
% md5crypt::md5crypt password 01234567
$1$01234567$b5lh2mHyD2PdJjFfALlEz1
```

```
% md5crypt::aprcrypt password 01234567
$apr1$01234567$IXBaQywhAhc0d75ZbaSDp/
```

```
% md5crypt::md5crypt password [md5crypt::salt]
$1$dFmvyRmO$T.V3OmzqeEf3hqJp2WFcb.
```

# Bugs, ideas, feedback

If you find errors in this document or bugs or problems with the package it describes, or if you want to suggest improvements for the documentation or the package, please use the [Tcllib Trackers](http://core.tcl.tk/tcllib/reportlist) and specify *md5crypt* as the category.

When proposing code changes, please provide *unified diffs*, i.e the output of **diff -u**.

Note further that *attachments* are strongly preferred over inlined patches. Attachments can be made by going to the **Edit** form of the ticket immediately after its creation, and then using the left-most button in the secondary navigation bar.

# Category

Hashes, checksums, and encryption

# Copyright

```
Copyright (c) 2003, Pat Thoyts <patthoyts@users.sourceforge.net>
```
