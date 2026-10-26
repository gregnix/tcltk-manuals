---
CommandName: page_util_quote
title: page_util_quote
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Parser generator tools
Keywords:
 - page
 - parser generator
 - quoting
 - text processing
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

page\_util\_quote – page-Hilfsprogramme zur Zeichenquotierung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [page::util::quote]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[::page::util::quote::unquote]{.cmd} [char]{.arg}
[::page::util::quote::quote'tcl]{.cmd} [char]{.arg}
[::page::util::quote::quote'tclstr]{.cmd} [char]{.arg}
[::page::util::quote::quote'tclcom]{.cmd} [char]{.arg}
:::

# Beschreibung

Dieses Paket stellt einige Hilfsbefehle bereit, die Zeichen in verschiedene Formen umwandeln.

# API

**::page::util::quote::unquote** *char*
: Ein Zeichen, wie es ein PEG-Prozessor in einem abstrakten Syntaxbaum speichert (siehe die Pakete **grammar::peg::interpreter**, **grammar::me** und ihre Beziehungen), also in einer quotierten Form, wird in das entsprechende Tcl-Zeichen umgewandelt. Das Zeichen wird als Ergebnis des Befehls zurückgegeben.

**::page::util::quote::quote'tcl** *char*
: Dieser Befehl nimmt ein Tcl-Zeichen (interne Darstellung) entgegen und wandelt es in eine Zeichenkette um, die vom Tcl-Parser akzeptiert wird, das betreffende Zeichen wiederherstellt und im 7-Bit-ASCII-Format vorliegt. Die Zeichenkette wird als Ergebnis dieses Befehls zurückgegeben.

**::page::util::quote::quote'tclstr** *char*
: Dieser Befehl nimmt ein Tcl-Zeichen (interne Darstellung) entgegen und wandelt es in eine Zeichenkette um, die der Tcl-Parser akzeptiert und die eine für Menschen lesbare Darstellung des betreffenden Zeichens erzeugt. Die Zeichenkette wird als Ergebnis dieses Befehls zurückgegeben.

    Die Zeichenkette verwendet keine nicht druckbaren Zeichen. Sie kann Backslash-Quotierung verwenden. Zeichen aus dem oberen UTF-Bereich werden quotiert, um Probleme mit den nach wie vor verbreiteten ASCII-Terminals zu vermeiden. Es wird davon ausgegangen, dass die Zeichenkette in doppelten Anführungszeichen verwendet wird.

**::page::util::quote::quote'tclcom** *char*
: Dieser Befehl nimmt ein Tcl-Zeichen (interne Darstellung) entgegen und wandelt es in eine Zeichenkette um, die vom Tcl-Parser akzeptiert wird, wenn sie innerhalb eines Tcl-Kommentars verwendet wird. Die Zeichenkette wird als Ergebnis dieses Befehls zurückgegeben.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *page* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Page-Parsergenerator

# Copyright

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
