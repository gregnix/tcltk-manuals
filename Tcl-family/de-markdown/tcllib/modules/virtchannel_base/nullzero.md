---
CommandName: tcl::chan::nullzero
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - /dev/null
 - /dev/zero
 - null
 - reflected channel
 - tip 219
 - virtual channel
 - zero
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcl::chan::nullzero – Kombination aus Null- und Zero-Kanälen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::chan::nullzero]{.lit} [1.1]{.optlit} 
[::tcl::chan::nullzero]{.cmd} 
:::

# BESCHREIBUNG

Das Paket **tcl::chan::nullzero** enthält einen Befehl zum Erstellen von Kanälen, bei denen es sich um eine Kombination aus Null- und Null-Geräten handelt. Diese vergessen sofort alles, was an sie geschrieben wird, und geben beim Auslesen einen unendlichen Strom von Nullzeichen zurück.

Die entsprechenden Pakete lauten **tcl::chan::null** und **tcl::chan::zero**.

Die interne Klasse „**TclOO**“, die den Kanal-Handler implementiert, ist eine Unterklasse des Rahmens „**tcl::chan::events**“.

# API

**::tcl::chan::nullzero**
: Dieser Befehl erstellt einen neuen Null-Null-Kanal und gibt dessen Handle zurück.


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
