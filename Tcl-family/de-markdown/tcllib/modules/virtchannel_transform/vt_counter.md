---
CommandName: tcl::transform::counter
title: tcl::transform::counter
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - counter
 - reflected channel
 - tip 230
 - transformation
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::transform::counter – Transformation

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::transform::counter]{.lit} [1.1]{.optlit}
[::tcl::transform::counter]{.cmd} [chan]{.arg} [-option]{.lit} [value...]{.arg}
:::

# Beschreibung

Das Paket **tcl::transform::counterr** stellt einen Befehl bereit, der eine Kanal-Transformation erstellt, welche die gelesenen und geschriebenen Bytes unverändert weiterleitet (wie **tcl::transform::identity**), jedoch zusätzlich die Bytes zählt, die in jeder Richtung verarbeitet wurden, und diese Zählwerte in Tcl-Variablen speichert, die bei der Erstellung festgelegt werden.

Zu diesem Modul gehörende Transformationen sind **tcl::transform::adler32**, **tcl::transform::crc32**, **tcl::transform::identity** und **tcl::transform::observe**.

Die interne Klasse „**TclOO**“, die den Handler für Transformationen implementiert, ist eine Unterklasse des Rahmens „**tcl::transform::core**“.

# API

**::tcl::transform::counter** *chan* **-option** *value*...
: Dieser Befehl erstellt eine Zählertransformation auf dem Kanal *chan* und gibt deren Handle zurück. Die zulässigen Optionen sind

    **-read-variable** varname
    : Der Wert der Option ist der Name einer globalen Variablen oder einer Variablen im Namespace; dies ist der Speicherort, an dem die Transformation die Byteanzahl der aus dem Kanal gelesenen Daten speichern muss.

        Wird kein Wert angegeben oder eine leere Zeichenkette verwendet, wird der Zähler der Lese-Richtung nicht gespeichert.

    **-write-variable** varname
    : Der Wert der Option ist der Name einer globalen Variablen oder einer Variablen im Namespace; dies ist der Speicherort, an dem die Transformation die Byteanzahl der in den Kanal geschriebenen Daten speichern muss.

        Wird kein Wert angegeben oder eine leere Zeichenkette verwendet, wird der Zähler der Schreibrichtung nicht gespeichert.



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
