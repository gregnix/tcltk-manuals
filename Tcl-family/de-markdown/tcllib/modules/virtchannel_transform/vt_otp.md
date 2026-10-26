---
CommandName: tcl::transform::otp
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - channel transformation
 - cipher
 - decryption
 - encryption
 - one time pad
 - otp
 - reflected channel
 - tip 230
 - transformation
 - virtual channel
 - xor
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcl::transform::otp – Verschlüsselung mittels Einmal-Pad

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::transform::core]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::transform::otp]{.lit} [1.1]{.optlit} 
[::tcl::transform::otp]{.cmd} [chan]{.arg} [keychanw]{.arg} [keychanr]{.arg} 
:::

# BESCHREIBUNG

Das Paket **tcl::transform::otp** enthält einen Befehl zum Erstellen einer Kanal-Transformation, die extern bereitgestellte Einmal-Chiffrierschlüssel verwendet, um die Verschlüsselung (beim Schreiben) und die Entschlüsselung (beim Lesen) durchzuführen.

Eine damit verbundene Transformation in diesem Modul ist **tcl::transform::rot**.

Die interne Klasse „**TclOO**“, die den Handler für Transformationen implementiert, ist eine Unterklasse des Rahmens „**tcl::transform::core**“.

# API

**::tcl::transform::otp** *chan* *keychanw* *keychanr*
: Dieser Befehl erstellt eine auf dem Kanal *chan* basierende Verschlüsselungstransformation nach dem One-Time-Pad-Prinzip und gibt deren Handle zurück. Die beiden Kanäle *keychanw* und *keychanr* enthalten die One-Time-Pads für die Schreib- bzw. Leserichtung. Ihre Inhalte werden gelesen und mit den Bytes, die in den Kanal geschrieben bzw. aus ihm gelesen werden, XOR-verknüpft.


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
