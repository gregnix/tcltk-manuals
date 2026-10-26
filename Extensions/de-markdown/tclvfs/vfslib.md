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

# NAME

::vfslib - Prozeduren für virtuelle Dateisysteme

# ÜBERSICHT

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

# BESCHREIBUNG

Das Paket **::vfs** enthält eine Bibliothek aus Tcl-Code mit mehreren virtuellen Dateisystemen. Jedes davon ist ein eigenes Paket und wird mit **package require vfs::NAME** geladen. Die ganze Sammlung heißt informell 'vfslib'.

# UNTERSTÜTZTE VFS-ARTEN

Derzeit unterstützt sind ftp, tar, http, zip, mk4, ns und webdav. Dazu lässt sich jeder 'urltype' als neues Volume einhängen, sofern ein passendes vfs vorhanden ist. Damit lassen sich URLs der Form 'ftp://', 'http://' und 'file://' wie Dateien behandeln. Dafür wird zum Beispiel der Befehl

*vfs::urltype::Mount ftp*

ausgewertet. Jeder Zugriff im neuen Volume versucht, ein Paket mit 'package require vfs::\${type}' zu laden. Das Paket muss vorhanden sein, sonst entsteht ein Fehler.

# EINSCHRÄNKUNGEN

Die meisten der genannten vfs-Arten sind noch wenig geprüft. Sie sind zu testen.
