---
CommandName: pkg_dtplite
ManualSection: n
Version: 1.3.2
TclPart: tcllib
TclDescription: Documentation toolbox
Links:
 - docidx introduction
 - doctoc introduction
 - doctools introduction
Keywords:
 - HTML
 - TMML
 - conversion
 - docidx
 - doctoc
 - doctools
 - manpage
 - markup
 - nroff
Copyright:
 - Copyright (c) 2004-2013 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

pkg_dtplite – Leichtgewichtiger DocTools-Markup-Prozessor

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [dtplite]{.lit} [1.3.2]{.optlit} 
[dtplite::print-via]{.cmd} [cmd]{.arg} 
[dtplite::do]{.cmd} [arguments]{.arg} 
:::

# BESCHREIBUNG

Das in diesem Dokument beschriebene Paket **dtplite** ist die Grundlage der Anwendung **dtplite**. Es ist eine schlanke Hülle um die verschiedenen Pakete von **doctools**.

# BEFEHLE

**dtplite::print-via** *cmd*
: Leitet die Ausgaben des Pakets an das angegebene *cmd* um. Das Ergebnis des Befehls ist die leere Zeichenkette.

**dtplite::do** *arguments*
: Der Hauptbefehl nimmt eine *einzelne Liste* von *arguments* entgegen, verarbeitet sie und führt die angegebene Aktion aus. Das Ergebnis des Befehls ist die leere Zeichenkette. Die Syntax innerhalb der Liste *arguments* ist im Abschnitt *COMMAND LINE* der Dokumentation der Anwendung **dtplite** erläutert.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2004-2013 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
