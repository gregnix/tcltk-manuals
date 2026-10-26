---
CommandName: vfslib
ManualSection: n
Version: 1.0
TclPart: Vfslib
TclDescription: Tcl-only Virtual File Systems
Keywords:
 - vfs
 - vfslib
 - filesystem
 - zip
 - tar
 - webdav
 - namespace
 - ftp
 - http
 - file
Copyright:
 - Copyright (c) 2001, Vince Darley
---

# Name

::vfslib - Procedures to interact with virtual filesystems

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} 

[package]{.cmd} [require]{.sub} [vfs]{.lit} [1.2.1]{.optlit} 

[package]{.cmd} [require]{.sub} [vfs::zip]{.lit} [1.0]{.optlit} 

[package]{.cmd} [require]{.sub} [vfs::mk4]{.lit} [1.6]{.optlit} 

[package]{.cmd} [require]{.sub} [vfs::tar]{.lit} [0.9]{.optlit} 

[package]{.cmd} [require]{.sub} [vfs::ftp]{.lit} [1.0]{.optlit} 

[package]{.cmd} [require]{.sub} [vfs::ns]{.lit} [1.0]{.optlit} 

[package]{.cmd} [require]{.sub} [vfs::webdav]{.lit} [0.1]{.optlit} 

[package]{.cmd} [require]{.sub} [vfs::http]{.lit} [0.5]{.optlit} 

[package]{.cmd} [require]{.sub} [vfs::urltype]{.lit} [1.0]{.optlit} 

[vfs::zip::Mount]{.cmd} [path]{.arg} [to]{.arg} 

[vfs::ftp::Mount]{.cmd} [path]{.arg} [to]{.arg} 

[vfs::tar::Mount]{.cmd} [path]{.arg} [to]{.arg} 

[vfs::http::Mount]{.cmd} [path]{.arg} [to]{.arg} 

[vfs::mk4::Mount]{.cmd} [path]{.arg} [to]{.arg} 

[vfs::ns::Mount]{.cmd} [path]{.arg} [to]{.arg} 

[vfs::urltype::Mount]{.cmd} [type]{.arg} 
:::

# Description

The **::vfs** package includes a library of Tcl code, implementing a number of different virtual filesystems.  Each of these exists as its own package, and can be accessed through **package require vfs::NAME**.  The whole set of virtual filesystems is known informally as 'vfslib'

# Supported vfs types

The current supported types are ftp, tar, http, zip, mk4, ns, webdav.  In addition there is the ability to mount any 'urltype' as a new volume, provided an appropriate vfs is supported.  This means that you can treat 'ftp://', 'http://' and 'file://' urls as files.  To do this, simply evaluate the command

*vfs::urltype::Mount ftp*

for instance.  Any access inside the new volume will result in an attempt to require a package through 'package require vfs::\${type}', which must therefore exist, or errors will be thrown.

# Limitations

Most of the vfs types listed above have not been very well debugged as yet.  Please test them!
