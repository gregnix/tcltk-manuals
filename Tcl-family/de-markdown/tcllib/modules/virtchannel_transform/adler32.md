---
CommandName: tcl::transform::adler32
title: tcl::transform::adler32
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - adler32
 - channel transformation
 - checksum
 - reflected channel
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::adler32 – Adler32-Transformation

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::transform::adler32]{.lit} [1.1]{.optlit}
[::tcl::transform::adler32]{.cmd} [chan]{.arg} [-option]{.lit} [value...]{.arg}
:::

# Beschreibung

Das Paket **tcl::transform::adler32** stellt einen Befehl zur Verfügung, der eine Kanal-Transformation erstellt, welche die gelesenen und geschriebenen Bytes unverändert durchlässt (wie **tcl::transform::identity**), jedoch zusätzlich kontinuierlich die Adler-32-Prüfsummen der Daten berechnet, die es in jeder Richtung verarbeitet hat, und diese in Tcl-Variablen speichert, die bei der Erstellung festgelegt wurden.

Zu diesem Modul gehörende Transformationen sind **tcl::transform::counter**, **tcl::transform::crc32**, **tcl::transform::identity** und **tcl::transform::observe**.

Die interne Klasse „**TclOO**“, die den Handler für Transformationen implementiert, ist eine Unterklasse des Rahmens „**tcl::transform::core**“.

# API

**::tcl::transform::adler32** *chan* **-option** *value*...
: Dieser Befehl erstellt eine Adler32-Prüfsummentransformation auf dem Kanal *chan* und gibt dessen Handle zurück. Die zulässigen Optionen sind

    **-read-variable** varname
    : Der Wert der Option ist der Name einer globalen Variablen oder einer Variablen im Namespace; dies ist der Speicherort, an dem die Transformation die Adler-32-Prüfsumme der aus dem Kanal gelesenen Daten speichern muss.

        Wird kein Wert angegeben oder eine leere Zeichenkette verwendet, wird die Prüfsumme der Lesedirektion nicht gespeichert.

    **-write-variable** varname
    : Der Wert der Option ist der Name einer globalen Variablen oder einer Variablen im Namespace; dies ist der Speicherort, an dem die Transformation die Adler-32-Prüfsumme der in den Kanal geschriebenen Daten speichern muss.

        Wird kein Wert angegeben oder eine leere Zeichenkette verwendet, wird die Prüfsumme der Schreibrichtung nicht gespeichert.



# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *virtchannel* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Kanäle

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
