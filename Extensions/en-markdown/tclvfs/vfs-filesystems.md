---
CommandName: vfs-filesystems
title: vfs-filesystems
ManualSection: n
Version: 1.0
TclPart: vfs-filesystems
TclDescription: Tcl-level Virtual Filesystems
Links:
 - vfs
 - vfs-fsapi
Keywords:
 - file
 - filesystem
 - ftp
 - http
 - metakit
 - namespace
 - tar
 - vfs
 - vfslib
 - webdav
 - zip
Copyright:
 - Copyright (c) 2001-2003 Vince Darley <vincentdarley@users.sourceforge.net>
 - Copyright (c) 2003 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

vfs-filesystems - Filesystems provided by tclvfs

# Synopsis

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit}
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
[vfs::mk4::Mount]{.cmd} [path]{.arg} [to]{.arg}
[vfs::tar::Mount]{.cmd} [path]{.arg} [to]{.arg}
[vfs::ftp::Mount]{.cmd} [path]{.arg} [to]{.arg}
[vfs::ns::Mount]{.cmd} [path]{.arg} [to]{.arg}
[vfs::webdav::Mount]{.cmd} [path]{.arg} [to]{.arg}
[vfs::http::Mount]{.cmd} [path]{.arg} [to]{.arg}
[vfs::urltype::Mount]{.cmd} [path]{.arg} [to]{.arg}
:::

# Description

The package **vfs** provides not only the means to implement a virtual filesystem at the tcl level, but also a number of ready to be used filesystems as well.

Each of these filesystem exists as its own package, and can be accessed through **package require vfs::NAME**. The whole set of these virtual filesystems is known informally as '*vfslib*'.

# Supported vfs types

Currently supported are ftp, tar, http, zip, mk4, ns, and webdav. In addition there is the ability to mount any 'urltype' as a new directory, provided an appropriate vfs is supported.  This means that you can treat urls based on the schemes *ftp://*, *http://* and *file://* as files.  To do this, simply evaluate the command **vfs::urltype::Mount ftp** for example.  Any access inside the new volume will result in an attempt to require a package through **package require vfs::${type}**, which must therefore exist, or errors will be thrown. If a filesystem is loaded, use the associated command listed below to mount a source for that filesystem as a tcl directory.

**vfs::zip::Mount** *path* *to*
: Mount the zip file *path* as directory *to*.

**vfs::mk4::Mount** *path* *to*
: Mount the metakit database file file *path* as directory *to*.

**vfs::tar::Mount** *path* *to*
: Mount the tar file *path* as directory *to*.

**vfs::ftp::Mount** *path* *to*
: Mount the ftp url *path* as directory *to*.

**vfs::ns::Mount** *path* *to*
: Mount the tcl namespace *path* as directory *to*.

**vfs::webdav::Mount** *path* *to*
: Mount the webdav url *path* as directory *to*.

**vfs::http::Mount** *path* *to*
: Mount the http url *path* as directory *to*.

**vfs::urltype::Mount** *path* *to*
: Mount the url *path*, of type *urltype* as directory *to*.


# Limitations

Most of the vfs types listed above have not been very well debugged as yet.  Please test them!

# Copyright

```
Copyright (c) 2001-2003 Vince Darley <vincentdarley@users.sourceforge.net>
Copyright (c) 2003 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
