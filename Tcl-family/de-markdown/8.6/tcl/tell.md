---
CommandName: tell
title: tell
ManualSection: n
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - open(n)
 - close(n)
 - gets(n)
 - seek(n)
 - Tcl_StandardChannels(3)
Keywords:
 - access position
 - channel
 - seeking
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

tell - Gibt die aktuelle Zugriffsposition eines offenen Kanals zurück

# Übersicht

::: {.synopsis} :::
[tell]{.cmd} [channelId]{.arg}
:::

# Beschreibung

Gibt eine Ganzzahl-Zeichenkette mit der aktuellen Zugriffsposition in *channelId* zurück. Der Wert ist ein Byte-Offset, der an [seek] übergeben werden kann, um den Kanal auf eine bestimmte Position zu setzen. Beachten Sie, dass dieser Wert in Bytes angegeben ist, nicht in Zeichen wie bei [read]. Für Kanäle, die keine Positionierung unterstützen, ist der Rückgabewert -1.

*channelId* muss eine Kennung für einen geöffneten Kanal sein, z. B. einen Tcl-Standardkanal (**stdin**, **stdout** oder **stderr**), den Rückgabewert von [open] oder [socket] oder das Ergebnis eines Kanalerzeugungsbefehls einer Tcl-Erweiterung.

# Beispiele

Eine Zeile von einem Dateikanal nur lesen, wenn sie mit **foobar** beginnt:

```
# Save the offset in case we need to undo the read...
set offset [tell $chan]
if {[read $chan 6] eq "foobar"} {
    gets $chan line
} else {
    set line {}
    # Undo the read...
    seek $chan $offset
}
```


[open]: open.md
[read]: read.md
[seek]: seek.md
[socket]: socket.md
