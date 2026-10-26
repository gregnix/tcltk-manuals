---
CommandName: unicode::data
ManualSection: n
Version: 1.1.1
TclPart: tcllib
TclDescription: Preparation of Internationalized Strings
Keywords:
 - stringprep
 - unicode
Copyright:
 - Copyright (c) 2007, Sergei Golovan <sgolovan@nes.ru>
---

# NAME

unicode::data – unicode-Datentabellen, generiert, intern

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [unicode::data]{.lit} [1.1.1]{.lit} 
:::

# BESCHREIBUNG

Das Paket **unicode::data** ist ein Hilfspaket für **unicode** und stellt diesem die Datentabellen bereit, die es für seine Funktionen braucht. Es ist ein *internes* Paket, auf das nicht eigenständig zugegriffen werden sollte. Deshalb hat es auch keine öffentlich dokumentierte API. Seine Implementierung wird durch ein Skript erzeugt.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *stringprep* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# COPYRIGHT

```
Copyright (c) 2007, Sergei Golovan <sgolovan@nes.ru>
```
