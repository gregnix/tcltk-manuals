---
CommandName: read
ManualSection: n
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
 - eof(n)
 - fblocked(n)
 - fconfigure(n)
 - Tcl_StandardChannels(3)
Keywords:
 - blocking
 - channel
 - end of line
 - end of file
 - nonblocking
 - read
 - translation
 - encoding
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

read - Aus einem Kanal lesen

# ÜBERSICHT

::: {.synopsis} :::
[read]{.cmd} [-nonewline]{.optlit} [channelId]{.arg} 
[read]{.cmd} [channelId]{.arg} [numChars]{.arg} 
:::

# BESCHREIBUNG

In der ersten Form liest der Befehl **read** alle Daten aus *channelId* bis zum Dateiende. Ist die Option **-nonewline** gesetzt, wird das letzte Zeichen der Datei verworfen, falls es ein Zeilenumbruch ist. In der zweiten Form gibt das zusätzliche Argument an, wie viele Zeichen gelesen werden sollen. Genau so viele Zeichen werden gelesen und zurückgegeben, es sei denn, in der Datei verbleiben weniger als *numChars*; in diesem Fall werden alle verbleibenden Zeichen zurückgegeben. Ist der Kanal für eine Mehrbyte-Kodierung konfiguriert, kann die Anzahl gelesener Zeichen von der Anzahl gelesener Bytes abweichen.

*channelId* muss eine Kennung für einen geöffneten Kanal sein, z. B. den Tcl-Standard-Eingabekanal (**stdin**), den Rückgabewert von **open** oder **socket** oder das Ergebnis eines Kanalerzeugungsbefehls einer Tcl-Erweiterung. Der Kanal muss zum Lesen geöffnet worden sein.

Befindet sich *channelId* im nicht blockierenden Modus, liest der Befehl möglicherweise nicht so viele Zeichen wie angefordert: Sobald alle verfügbaren Eingabedaten gelesen sind, gibt der Befehl die verfügbaren Daten zurück, statt auf weitere Eingabe zu blockieren. Ist der Kanal für eine Mehrbyte-Kodierung konfiguriert, können in den internen Puffern noch Bytes verbleiben, die kein vollständiges Zeichen bilden. Diese Bytes werden erst zurückgegeben, wenn ein vollständiges Zeichen verfügbar ist oder das Dateiende erreicht wurde. Die Option **-nonewline** wird ignoriert, wenn der Befehl zurückkehrt, bevor das Dateiende erreicht ist.

**Read** wandelt Zeilenendesequenzen in der Eingabe gemäß der Option **-translation** des Kanals in Zeilenumbruchzeichen um. Siehe die Manpage **fconfigure** für eine Erläuterung, wie **fconfigure** die Eingabe verändert.

# VERWENDUNG MIT SERIELLEN SCHNITTSTELLEN

Für die meisten Anwendungen sollte ein mit einer seriellen Schnittstelle verbundener Kanal nicht blockierend konfiguriert werden: **fconfigure** *channelId* **-blocking** *0*. Dann verhält sich **read** weitgehend wie oben beschrieben. Bei blockierenden seriellen Ports ist Vorsicht geboten:

**read** *channelId numChars*
: In dieser Form blockiert **read**, bis *numChars* vom seriellen Port empfangen wurden.

**read** *channelId*
: In dieser Form blockiert **read**, bis das Dateiende-Zeichen empfangen wurde; siehe **fconfigure** **-eofchar**. Ist für den Kanal kein Dateiende-Zeichen konfiguriert, blockiert **read** unbegrenzt.


# BEISPIEL

Dieses Beispiel liest eine Datei auf einmal ein und zerlegt sie in eine Liste, wobei jede Zeile der Datei einem Listenelement entspricht:

```
set fl [open /proc/meminfo]
set data [read $fl]
close $fl
set lines [split $data \n]
```

