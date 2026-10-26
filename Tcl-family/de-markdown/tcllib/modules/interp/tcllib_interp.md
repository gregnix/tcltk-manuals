---
CommandName: interp
ManualSection: n
Version: 0.1.3
TclPart: tcllib
TclDescription: Interpreter utilities
Keywords:
 - alias
 - empty interpreter
 - interpreter
 - method
 - snit
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

interp – Erstellung von Interp und Aliasing

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [interp]{.lit} [0.1.3]{.optlit} 
[::interp::createEmpty]{.cmd} [path]{.optarg} 
[::interp::snitLink]{.cmd} [path]{.arg} [methodlist]{.arg} 
[::interp::snitDictLink]{.cmd} [path]{.arg} [methoddict]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket bietet eine Reihe von Befehlen zur bequemen Erstellung von Tcl-Interpretern für eine stark eingeschränkte Ausführung.

# API

**::interp::createEmpty** ?*path*?
: Dieser Befehl erstellt einen leeren Tcl-Interpreter und gibt dessen Namen zurück. „Leer“ bedeutet, dass der neue Interpreter weder Namespaces noch Befehle enthält. Er ist ausschließlich für die Erstellung von Aliasen nützlich. Wenn ein *path* festgelegt wird, wird dieser als Name des neuen Interpreters verwendet.

**::interp::snitLink** *path* *methodlist*
: Dieser Befehl setzt voraus, dass er innerhalb einer Methode eines snit-Objekts aufgerufen wurde und dass der Befehl **mymethod** verfügbar ist. Er erweitert den durch *path* festgelegten Interpreter um Aliase für alle in der *methodlist* aufgeführten Methoden, wobei der Alias die Ausführung an die gleichnamige Methode des SNIT-Objekts weiterleitet, das diesen Befehl aufruft. Jedes Element von *methodlist* wird tatsächlich als Befehlspräfix interpretiert, wobei das erste Wort jedes Präfixes den Namen der Methode angibt, mit der eine Verknüpfung hergestellt werden soll. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::interp::snitDictLink** *path* *methoddict*
: Dieser Befehl verhält sich wie **::interp::snitLink**, mit dem Unterschied, dass er als Eingabe ein Dictionary verwendet, das Befehle Methoden zuordnet, und keine Liste von Methoden. Wie bei **::interp::snitLink** handelt es sich bei den Methodenverweisen tatsächlich um Befehlspräfixe. Dieser Befehl ermöglicht die Erstellung komplexerer Befehls-Methoden-Zuordnungen als **::interp::snitLink**. Das Ergebnis des Befehls ist die leere Zeichenkette.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *interp* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge

# COPYRIGHT

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
