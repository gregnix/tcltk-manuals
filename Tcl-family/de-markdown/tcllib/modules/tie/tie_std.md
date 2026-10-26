---
CommandName: tie
ManualSection: n
Version: 1.3
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - array
 - database
 - file
 - metakit
 - persistence
 - tie
 - untie
Copyright:
 - Copyright (c) 2008-2021 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tie – Array-Persistenz, Standarddatenquellen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tie::std::log]{.lit} [1.2]{.optlit} 
[package]{.cmd} [require]{.sub} [tie::std::array]{.lit} [1.2]{.optlit} 
[package]{.cmd} [require]{.sub} [tie::std::rarray]{.lit} [1.2]{.optlit} 
[package]{.cmd} [require]{.sub} [tie::std::file]{.lit} [1.2]{.optlit} 
[package]{.cmd} [require]{.sub} [tie::std::growfile]{.lit} [1.2]{.optlit} 
[package]{.cmd} [require]{.sub} [tie::std::dsource]{.lit} [1.2]{.optlit} 
:::

# BESCHREIBUNG

Bei den in diesem Dokument als Anforderungen aufgeführten Paketen handelt es sich um interne Pakete, die die Standarddatenquellen des Pakets **tie** bereitstellen, wie im Abschnitt *STANDARD-DATENQUELLENTYPEN* der Dokumentation zu **tie** beschrieben.

Sie werden automatisch von **tie** geladen und registriert, wenn dieses selbst aufgerufen wird; daher ist es nicht erforderlich, sie separat anzufordern, obwohl dies möglich ist.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *tie* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge

# COPYRIGHT

```
Copyright (c) 2008-2021 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
