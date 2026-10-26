---
CommandName: tool::dict_ensemble
ManualSection: n
Version: 0.4.2
TclPart: tcllib
TclDescription: Standardized OO Framework for development
Keywords:
 - TOOL
 - TclOO
Copyright:
 - Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
---

# NAME

tool::dict_ensemble – Dictionary-Tools

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tool]{.lit} [0.4.2]{.optlit} 
:::

*object* *ensemble* **add** *field*

# BESCHREIBUNG

Der Befehl **dict_ensemble** ist ein Schlüsselwort, das durch **tool** hinzugefügt wurde. Er definiert eine öffentliche Variable (die als Dict gespeichert ist) sowie eine Zugriffsfunktion, mit der die in diesem Dict gespeicherten Werte bearbeitet und abgerufen werden können.

*object* *ensemble* **add** *field*
: \] *value* *Wert ...*\] Fügt Elemente zu einer Liste hinzu, die über das *field* „leaf“ des von diesem Ensemble verwalteten Dicts gepflegt wird. Deklariert eine Variable *name*, die als Array initialisiert wird und mit *contents* für Objekte dieser Klasse sowie für alle Objekte von Klassen, die von dieser Klasse abgeleitet sind, gefüllt wird.


# AUTOREN

Sean Woods

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *tool* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Hilfsprogramme

# COPYRIGHT

```
Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
```
