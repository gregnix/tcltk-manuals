---
CommandName: tcl::transform::crc32
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - checksum
 - crc32
 - reflected channel
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcl::transform::crc32 – CRC32-Transformation

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::transform::crc32]{.lit} [1.1]{.optlit} 
[::tcl::transform::crc32]{.cmd} [chan]{.arg} [-option]{.lit} [value...]{.arg} 
:::

# BESCHREIBUNG

Das Paket **tcl::transform::crc32** stellt einen Befehl zur Verfügung, der eine Kanal-Transformation erstellt, welche die gelesenen und geschriebenen Bytes unverändert durchlässt (wie **tcl::transform::identity**), jedoch zusätzlich kontinuierlich die CRC32-Prüfsummen der Daten berechnet, die es in jeder Richtung verarbeitet hat, und diese in Tcl-Variablen speichert, die bei der Erstellung festgelegt wurden. Bei der betreffenden Prüfsumme handelt es sich um die CRC32-Prüfsumme von zlib.

Zu diesem Modul gehörende Transformationen sind **tcl::transform::adler32**, **tcl::transform::counter**, **tcl::transform::identity** und **tcl::transform::observe**.

Die interne Klasse „**TclOO**“, die den Handler für Transformationen implementiert, ist eine Unterklasse des Rahmens „**tcl::transform::core**“.

# API

**::tcl::transform::crc32** *chan* **-option** *value*...
: Dieser Befehl erstellt eine CRC32-Prüfsummen-Transformation für den Kanal *chan* und gibt dessen Handle zurück. Die zulässigen Optionen sind


**-read-variable** varname
: Der Wert der Option ist der Name einer globalen Variablen oder einer Variablen im Namespace; dies ist der Speicherort, an dem die Transformation die CRC32-Prüfsumme der aus dem Kanal gelesenen Daten speichern muss. Wird kein Wert angegeben oder eine leere Zeichenkette verwendet, wird die Prüfsumme der Lesedirektion nicht gespeichert.

**-write-variable** varname
: Der Wert der Option ist der Name einer globalen Variablen oder einer Variablen im Namespace; dies ist der Speicherort, an dem die Transformation die CRC32-Prüfsumme der in den Kanal geschriebenen Daten speichern muss. Wird kein Wert angegeben oder eine leere Zeichenkette verwendet, wird die Prüfsumme der Schreibrichtung nicht gespeichert.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *virtchannel* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Kanäle

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
