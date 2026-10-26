---
CommandName: eof
title: eof
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - open(n)
 - close(n)
 - fblocked(n)
 - Tcl_StandardChannels(3)
Keywords:
 - channel
 - end of file
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

eof - Prüft auf Dateiende-Bedingung eines Kanals

# Übersicht

::: {.synopsis} :::
[eof]{.cmd} [channelId]{.arg}
:::

# Beschreibung

Gibt 1 zurück, wenn während der letzten Eingabeoperation auf *channelId* (z. B. [gets]) eine Dateiende-Bedingung aufgetreten ist, sonst 0.

*channelId* muss eine Kennung für einen geöffneten Kanal sein, z. B. einen Tcl-Standardkanal (**stdin**, **stdout** oder **stderr**), den Rückgabewert von [open] oder [socket] oder das Ergebnis eines Kanalerzeugungsbefehls einer Tcl-Erweiterung.

# Beispiele

Liest den Inhalt einer Datei zeilenweise und gibt ihn aus:

```
set f [open somefile.txt]
while {1} {
    set line [gets $f]
    if {[eof $f]} {
        close $f
        break
    }
    puts "Read line: $line"
}
```

Liest den Inhalt einer Datei in Datensätzen fester Größe:

```
set f [open somefile.dat]
fconfigure $f -translation binary
set recordSize 40
while {1} {
    set record [read $f $recordSize]
    if {[eof $f]} {
        close $f
        break
    }
    puts "Read record: $record"
}
```


[gets]: gets.md
[open]: open.md
[socket]: socket.md
