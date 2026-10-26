---
CommandName: tell
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

# NAME

tell - Gibt die aktuelle Zugriffsposition eines offenen Kanals zurück

# ÜBERSICHT

::: {.synopsis} :::
[tell]{.cmd} [channelId]{.arg} 
:::

# BESCHREIBUNG

Der Befehl **tell** wurde durch den Befehl **chan tell** ersetzt, der die gleiche Syntax und die gleichen Optionen unterstützt.

# BEISPIEL

Eine Zeile von einem Dateikanal nur lesen, wenn sie mit **foobar** beginnt:

```
# Offset sichern, falls das Lesen rückgängig gemacht werden muss...
set offset [tell $chan]
if {[read $chan 6] eq "foobar"} {
    gets $chan line
} else {
    set line {}
    # Lesen rückgängig machen...
    seek $chan $offset
}
```
