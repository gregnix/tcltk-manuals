---
CommandName: vfs-filesystems
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

# NAME

vfs-filesystems - Dateisysteme von tclvfs

# ÜBERSICHT

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

# BESCHREIBUNG

Das Paket **vfs** liefert nicht nur die Mittel, ein virtuelles Dateisystem auf Tcl-Ebene zu schreiben, sondern auch eine Reihe fertiger Dateisysteme.

Jedes dieser Dateisysteme ist ein eigenes Paket und wird mit **package require vfs::NAME** geladen. Die ganze Sammlung heißt informell *vfslib*.

# UNTERSTÜTZTE VFS-ARTEN

Derzeit unterstützt sind ftp, tar, http, zip, mk4, ns und webdav. Dazu lässt sich jeder 'urltype' als neues Verzeichnis einhängen, sofern ein passendes vfs vorhanden ist. Damit lassen sich URLs mit den Schemata *ftp://*, *http://* und *file://* wie Dateien behandeln. Dafür wird zum Beispiel der Befehl **vfs::urltype::Mount ftp** ausgewertet. Jeder Zugriff im neuen Volume versucht, ein Paket mit **package require vfs::\${type}** zu laden. Das Paket muss vorhanden sein, sonst entsteht ein Fehler. Ist ein Dateisystem geladen, hängt der zugehörige Befehl unten eine Quelle dieses Dateisystems als Tcl-Verzeichnis ein.

**vfs::zip::Mount** *path* *to*
: Hängt die Zip-Datei *path* als Verzeichnis *to* ein.

**vfs::mk4::Mount** *path* *to*
: Hängt die Metakit-Datenbankdatei *path* als Verzeichnis *to* ein.

**vfs::tar::Mount** *path* *to*
: Hängt die Tar-Datei *path* als Verzeichnis *to* ein.

**vfs::ftp::Mount** *path* *to*
: Hängt die FTP-URL *path* als Verzeichnis *to* ein.

**vfs::ns::Mount** *path* *to*
: Hängt den Tcl-Namespace *path* als Verzeichnis *to* ein.

**vfs::webdav::Mount** *path* *to*
: Hängt die WebDAV-URL *path* als Verzeichnis *to* ein.

**vfs::http::Mount** *path* *to*
: Hängt die HTTP-URL *path* als Verzeichnis *to* ein.

**vfs::urltype::Mount** *path* *to*
: Hängt die URL *path* vom Typ *urltype* als Verzeichnis *to* ein.


# EINSCHRÄNKUNGEN

Die meisten der genannten vfs-Arten sind noch wenig geprüft. Sie sind zu testen.

# COPYRIGHT

```
Copyright (c) 2001-2003 Vince Darley <vincentdarley@users.sourceforge.net>
Copyright (c) 2003 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
