---
CommandName: tcl::chan::cat
title: tcl::chan::cat
ManualSection: n
Version: 1.0.4
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - concatenation channel
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tcl::chan::cat – Verkettungskanal

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [TclOO]{.lit}
[package]{.cmd} [require]{.sub} [tcl::chan::core]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [tcl::chan::cat]{.lit} [1.0.4]{.optlit}
[::tcl::chan::cat]{.cmd} [chan...]{.arg}
:::

# Beschreibung

Das Paket **tcl::chan::cat** stellt einen Befehl zur Erstellung von Verkettungskanälen bereit. Dabei handelt es sich um nicht durchsuchbare Kanäle, die eine Liste untergeordneter Kanäle enthalten, deren Inhalte sie der Reihe nach geben, bis alle erschöpft sind. Auf diese Weise stellt der Kanal die Verkettung der Inhalte aller untergeordneten Kanäle dar.

Hinweis: Die erstellten Kanäle übernehmen die Verantwortung für die Kanäle, aus denen sie aufgebaut wurden. Sobald sie einen ihrer Kanäle vollständig ausgeschöpft haben, wird dieser geschlossen. Ebenso führt das Schließen des „cat“-Kanals dazu, dass alle ihm noch untergeordneten Kanäle geschlossen werden.

Die interne Klasse „**TclOO**“, die den Kanal-Handler implementiert, ist eine Unterklasse des Rahmens „**tcl::chan::core**“.

Die Ereignisbehandlung wird an den derzeit aktiven Kanal weitergeleitet.

# API

**::tcl::chan::cat** *chan*...
: Dieser Befehl erstellt den Verkettungskanal unter Verwendung aller angegebenen Kanäle und gibt dessen Handle zurück.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *virtchannel* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Kanäle

# Copyright

```
Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
