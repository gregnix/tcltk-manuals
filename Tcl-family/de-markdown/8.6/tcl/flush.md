---
CommandName: flush
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - open(n)
 - socket(n)
 - Tcl_StandardChannels(3)
Keywords:
 - blocking
 - buffer
 - channel
 - flush
 - nonblocking
 - output
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

flush - Leert die gepufferte Ausgabe eines Kanals

# ÜBERSICHT

::: {.synopsis} :::
[flush]{.cmd} [channelId]{.arg} 
:::

# BESCHREIBUNG

Leert alle für *channelId* gepufferte Ausgabe.

*channelId* muss eine Kennung für einen geöffneten Kanal sein, z. B. einen Tcl-Standardkanal (**stdout** oder **stderr**), den Rückgabewert von **open** oder **socket** oder das Ergebnis eines Kanalerzeugungsbefehls einer Tcl-Erweiterung. Der Kanal muss zum Schreiben geöffnet worden sein.

Ist der Kanal im blockierenden Modus, kehrt der Befehl erst zurück, wenn die gesamte gepufferte Ausgabe in den Kanal geschrieben wurde. Ist der Kanal im nicht-blockierenden Modus, kann der Befehl zurückkehren, bevor die gesamte gepufferte Ausgabe geleert ist; der Rest wird im Hintergrund geleert, sobald die zugrunde liegende Datei oder das Gerät Daten aufnehmen kann.

# BEISPIELE

Fordert den Benutzer auf, seinen Namen auf der Konsole einzugeben:

```
puts -nonewline "Please type your name: "
flush stdout
gets stdin name
puts "Hello there, $name!"
```
