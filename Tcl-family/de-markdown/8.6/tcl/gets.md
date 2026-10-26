---
CommandName: gets
title: gets
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - eof(n)
 - fblocked(n)
 - Tcl_StandardChannels(3)
Keywords:
 - blocking
 - channel
 - end of file
 - end of line
 - line
 - non-blocking
 - read
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

gets - Liest eine Zeile aus einem Kanal

# Übersicht

::: {.synopsis} :::
[gets]{.cmd} [channelId]{.arg} [varName]{.optarg}
:::

# Beschreibung

Dieser Befehl liest die nächste Zeile von *channelId*, gibt alles in der Zeile bis (aber nicht einschließlich) der/den Zeilenende-Zeichen zurück und verwirft die Zeilenende-Zeichen.

*channelId* muss eine Kennung für einen geöffneten Kanal sein, z. B. den Tcl-Standard-Eingabekanal (**stdin**), den Rückgabewert von [open] oder [socket] oder das Ergebnis eines Kanalerzeugungsbefehls einer Tcl-Erweiterung. Der Kanal muss zum Lesen geöffnet worden sein.

Ist *varName* weggelassen, wird die Zeile als Ergebnis des Befehls zurückgegeben. Ist *varName* angegeben, wird die Zeile in die Variable dieses Namens gelegt und der Rückgabewert ist die Anzahl der zurückgegebenen Zeichen.

Tritt beim Suchen nach einem Zeilenende Dateiende auf, gibt der Befehl alle bis zum Dateiende verfügbaren Eingaben zurück. Ist *channelId* im nicht-blockierenden Modus und steht keine vollständige Zeile zur Verfügung, gibt der Befehl eine leere Zeichenkette zurück und verbraucht keine Eingabe. Ist *varName* angegeben und wird eine leere Zeichenkette in *varName* wegen Dateiende oder unzureichender Daten im nicht-blockierenden Modus zurückgegeben, ist der Rückgabezähler -1. Beachten Sie: Ist *varName* nicht angegeben, können Dateiende und „keine vollständige Zeile verfügbar“ dasselbe Ergebnis liefern wie eine Eingabezeile, die nur aus Zeilenende-Zeichen besteht. Die Befehle [eof] und [fblocked] unterscheiden diese drei Fälle.

# Beispiele

Dieses Beispiel liest eine Datei zeilenweise und gibt sie mit der aktuellen Zeilennummer am Zeilenanfang aus.

```
set chan [open "some.file.txt"]
set lineNumber 0
while {[gets $chan line] >= 0} {
    puts "[incr lineNumber]: $line"
}
close $chan
```


[eof]: eof.md
[fblocked]: fblocked.md
[open]: open.md
[socket]: socket.md
