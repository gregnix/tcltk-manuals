---
CommandName: tcl::chan::zero
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - /dev/zero
 - reflected channel
 - tip 219
 - virtual channel
 - zero
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcl::chan::zero – Zero Kanal

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::chan::zero]{.lit} [1.1]{.optlit} 
[::tcl::chan::zero]{.cmd} 
:::

# BESCHREIBUNG

Das Paket **tcl::chan::zero** stellt einen Befehl zur Erstellung von Nullkanälen bereit, d. h. von schreibgeschützten Kanälen, die beim Lesen einen unendlichen Strom von Nullzeichen geben. Dies entspricht den Nullkanälen des Pakets **Memchan**, mit dem Unterschied, dass dieses in reinem Tcl und nicht in C geschrieben ist. Andererseits ist ist **Memchan** mit Tcl 8.4 und früheren Versionen kompatibel, während dieses Paket Tcl 8.5 oder höher sowie TclOO erfordert.

Die entsprechenden Pakete lauten **tcl::chan::null** und **tcl::chan::nullzero**.

Die interne Klasse „**TclOO**“, die den Kanal-Handler implementiert, ist eine Unterklasse des Rahmens „**tcl::chan::events**“.

# API

**::tcl::chan::zero**
: Dieser Befehl erstellt einen neuen Nullkanal und gibt dessen Handle zurück.


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
