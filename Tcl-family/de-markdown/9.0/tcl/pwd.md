---
CommandName: pwd
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - cd(n)
 - glob(n)
 - filename(n)
Keywords:
 - working directory
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

pwd - Gibt den absoluten Pfad des aktuellen Arbeitsverzeichnisses zurück

# ÜBERSICHT

::: {.synopsis} :::
[pwd]{.cmd} 
:::

# BESCHREIBUNG

Gibt den absoluten Pfadnamen des aktuellen Arbeitsverzeichnisses zurück.

# BEISPIELE

Manchmal ist es nützlich, für einen externen Befehl mit **exec** in ein bekanntes Verzeichnis zu wechseln, während die Anwendung normalerweise im Verzeichnis weiterläuft, in dem sie gestartet wurde (sofern der Benutzer nichts anderes angibt), um Verwirrung zu vermeiden. Dazu speichert man das aktuelle Verzeichnis während des externen Befehls und wechselt danach zurück:

```
set tarFile [file normalize somefile.tar]
set savedDir [pwd]
cd /tmp
exec tar -xf $tarFile
cd $savedDir
```
