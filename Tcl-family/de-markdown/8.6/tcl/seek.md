---
CommandName: seek
ManualSection: n
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - open(n)
 - close(n)
 - gets(n)
 - tell(n)
 - Tcl_StandardChannels(3)
Keywords:
 - access position
 - file
 - seek
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

seek - Ändert die Zugriffsposition eines offenen Kanals

# ÜBERSICHT

::: {.synopsis} :::
[seek]{.cmd} [channelId]{.arg} [offset]{.arg} [origin]{.optarg} 
:::

# BESCHREIBUNG

Der Befehl **seek** wurde durch den Befehl **chan seek** ersetzt, der die gleiche Syntax und die gleichen Optionen unterstützt.

# BEISPIELE

Eine Datei zweimal lesen:

```
set f [open file.txt]
set data1 [read $f]
seek $f 0
set data2 [read $f]
close $f
# $data1 eq $data2, wenn die Datei nicht verändert wurde
```

Die letzten 10 Bytes einer Datei lesen:

```
set f [open file.data]
# Funktioniert garantiert mit Binärdaten, kann bei anderen Kodierungen scheitern...
fconfigure $f -translation binary
seek $f -10 end
set data [read $f 10]
close $f
```
