---
CommandName: debug::timestamp
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: debug narrative
Keywords:
 - debug
 - log
 - narrative
 - timestamps
 - trace
Copyright:
 - Copyright (c) 200?, Colin McCormack, Wub Server Utilities
 - Copyright (c) 2012, Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

debug::timestamp – Debug-Erzählung – Zeitstempel

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [debug::timestamp]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [debug]{.lit} [1.0.7]{.optlit} 
[debug]{.cmd} [timestamp]{.sub} 
:::

# BESCHREIBUNG

# API

**debug** **timestamp**
: Diese Methode gibt Zeitangaben in Millisekunden seit einer Basislinie oder dem letzten Aufruf zurück und eignet sich daher besonders für ein tag-spezifisches Präfix, um automatisch Aufruferinformationen für alle Verwendungen des Tags bereitzustellen. Oder in einer Nachricht, wenn nur an bestimmten Plätzen solche Details benötigt werden.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *debug* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Debugging, Ablaufverfolgung und Protokollierung

# COPYRIGHT

```
Copyright (c) 200?, Colin McCormack, Wub Server Utilities
Copyright (c) 2012, Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
