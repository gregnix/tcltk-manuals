---
CommandName: seek
title: seek
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

# Name

seek - Ändert die Zugriffsposition eines offenen Kanals

# Übersicht

::: {.synopsis} :::
[seek]{.cmd} [channelId]{.arg} [offset]{.arg} [origin]{.optarg}
:::

# Beschreibung

Ändert die aktuelle Zugriffsposition für *channelId*.

*ChannelId* muss eine Kennung für einen geöffneten Kanal sein, z. B. einen Tcl-Standardkanal (**stdin**, **stdout** oder **stderr**), den Rückgabewert eines Aufrufs von [open] oder [socket] oder das Ergebnis eines Kanalerzeugungsbefehls einer Tcl-Erweiterung.

Die Argumente *offset* und *origin* geben die Position an, an der der nächste Lese- oder Schreibvorgang für *channelId* stattfindet. *Offset* muss eine Ganzzahl sein (kann negativ sein) und *origin* muss eines der folgenden sein:

**start**
: Die neue Zugriffsposition liegt *offset* Bytes vom Anfang der zugrunde liegenden Datei oder des Geräts entfernt.

**current**
: Die neue Zugriffsposition liegt *offset* Bytes von der aktuellen Zugriffsposition entfernt; ein negatives *offset* verschiebt die Zugriffsposition rückwärts in der zugrunde liegenden Datei oder dem Gerät.

**end**
: Die neue Zugriffsposition liegt *offset* Bytes vom Ende der Datei oder des Geräts entfernt. Ein negatives *offset* setzt die Zugriffsposition vor das Dateiende, ein positives *offset* hinter das Dateiende.


Das Argument *origin* ist standardmäßig **start**.

Der Befehl leert die gesamte gepufferte Ausgabe für den Kanal, bevor er zurückkehrt, auch wenn der Kanal im nicht blockierenden Modus ist. Außerdem verwirft er gepufferte und ungelesene Eingabe. Der Befehl gibt eine leere Zeichenkette zurück. Ein Fehler tritt auf, wenn der Befehl auf Kanäle angewendet wird, deren zugrunde liegende Datei oder Gerät keine Positionierung unterstützt.

Beachten Sie, dass *offset*-Werte Byte-Offsets sind, keine Zeichen-Offsets. Sowohl **seek** als auch [tell] arbeiten in Bytes, nicht in Zeichen, im Gegensatz zu [read].

# Beispiele

Eine Datei zweimal lesen:

```
set f [open file.txt]
set data1 [read $f]
seek $f 0
set data2 [read $f]
close $f
# $data1 eq $data2 if the file wasn't updated
```

Die letzten 10 Bytes einer Datei lesen:

```
set f [open file.data]
# This is guaranteed to work with binary data but
# may fail with other encodings...
fconfigure $f -translation binary
seek $f -10 end
set data [read $f 10]
close $f
```


[open]: open.md
[read]: read.md
[socket]: socket.md
[tell]: tell.md
