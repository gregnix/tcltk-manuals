---
CommandName: coroutine::auto
title: coroutine::auto
ManualSection: n
Version: 1.3
TclPart: tcllib
TclDescription: Coroutine utilities
Keywords:
 - after
 - channel
 - coroutine
 - events
 - exit
 - gets
 - global
 - green threads
 - read
 - threads
 - update
 - vwait
Copyright:
 - Copyright (c) 2010-2014 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

coroutine::auto – Automatische Erkennung von Ereignissen und IO-Coroutinen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [coroutine::auto]{.lit} [1.3]{.lit}
[package]{.cmd} [require]{.sub} [coroutine]{.lit} [1.4]{.lit}
:::

# Beschreibung

Das Paket **coroutine::auto** bietet keine Befehle oder andere direkt sichtbare Funktionen. Es baut auf dem Paket **coroutine** auf und fängt verschiedene integrierte Befehle des Tcl-Kerns ab, um jeden Code, der diese verwendet, „coroutine-unabhängig“ zu machen, d. h. so, dass er ohne Änderungen sowohl innerhalb als auch außerhalb einer Coroutine ausgeführt werden kann.

Die von diesem Paket betroffenen Befehle sind

- **after**
- **exit**
- **gets**
- **global**
- **puts**
- **read**
- **socket**
- **update**
- **vwait**


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *coroutine* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Coroutine

# Copyright

```
Copyright (c) 2010-2014 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
