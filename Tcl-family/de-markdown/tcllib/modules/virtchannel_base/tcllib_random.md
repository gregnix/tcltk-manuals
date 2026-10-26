---
CommandName: tcl::chan::random
title: tcl::chan::random
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - /dev/random
 - random
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::random – Zufälliger Kanal

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::random]{.lit} [1.1]{.optlit}
[::tcl::chan::random]{.cmd} [seed]{.arg}
:::

# Beschreibung

Das Paket **tcl::chan::random** stellt einen Befehl zur Verfügung, mit dem zufällige Kanäle erstellt werden können, d. h. schreibgeschützte Kanäle, die beim Auslesen einen unendlichen Strom pseudozufälliger Zeichen geben. Dies ähnelt den Zufallskanälen des Pakets **Memchan**, mit dem Unterschied, dass dieses in reinem Tcl und nicht in C geschrieben ist und zudem einen wesentlich einfacheren Generator verwendet. Andererseits ist **Memchan** mit Tcl 8.4 und früheren Versionen kompatibel, während dieses Paket Tcl 8.5 oder höher sowie TclOO erfordert.

Die interne Klasse „**TclOO**“, die den Kanal-Handler implementiert, ist eine Unterklasse des Rahmens „**tcl::chan::events**“.

# API

**::tcl::chan::random** *seed*
: Dieser Befehl erstellt einen neuen Zufallskanal und gibt dessen Handle zurück. Der Startwert ist eine Liste von Ganzzahlen, die zur Initialisierung des internen Rückkopplungs-Schieberegisters des Generators verwendet wird.


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
