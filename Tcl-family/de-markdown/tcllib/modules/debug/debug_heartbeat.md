---
CommandName: debug::heartbeat
title: debug::heartbeat
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: debug narrative
Keywords:
 - debug
 - heartbeat
 - log
 - narrative
 - trace
Copyright:
 - Copyright (c) 200?, Colin McCormack, Wub Server Utilities
 - Copyright (c) 2012, Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

debug::heartbeat – Debug-Erzählung – Heartbeat

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [debug::heartbeat]{.lit} [1.0.2]{.optlit}
[package]{.cmd} [require]{.sub} [debug]{.lit} [1]{.optlit}
[debug]{.cmd} [heartbeat]{.lit} [delta]{.optarg}
:::

# Beschreibung

# API

[debug] **heartbeat** ?*delta*?
: Diese Methode aktiviert oder deaktiviert einen Heartbeat, mit dem die Ereignisschleife einer ereignisbasierten Tcl-Anwendung überwacht wird.

    Sie reserviert für ihren Betrieb das Debug-Tag **heartbeat** und schreibt alle *delta* Millisekunden eine Meldung.

    Ein *delta* <= 0 deaktiviert den Heartbeat.

    Die vom Heartbeat erzeugte Meldung enthält einen Sequenzzähler und die Zeit in Millisekunden seit dem letzten Heartbeat, wodurch Einblicke in zeitliche Schwankungen und Abweichungen vom Nennwert *delta* gewonnen werden können.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *debug* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Debugging, Ablaufverfolgung und Protokollierung

# Copyright

```
Copyright (c) 200?, Colin McCormack, Wub Server Utilities
Copyright (c) 2012, Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[debug]: debug.md
