---
CommandName: term::ansi::code::macros
title: term::ansi::code::macros
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - ansi
 - control
 - frame
 - menu
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::ansi::code::macros – Makro-Sequenzen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [textutil::repeat]{.lit}
[package]{.cmd} [require]{.sub} [textutil::tabify]{.lit}
[package]{.cmd} [require]{.sub} [term::ansi::code::macros]{.lit} [0.2]{.optlit}
[::term::ansi::code::macros::names]{.cmd}
[::term::ansi::code::macros::import]{.cmd} [ns]{.optarg} [arg...]{.optarg}
[::term::ansi::code::macros::menu]{.cmd} [menu]{.arg}
[::term::ansi::code::macros::frame]{.cmd} [string]{.arg}
:::

# Beschreibung

Dieses Paket bietet übergeordnete Steuersequenzen für komplexere Formen.

# API

## Introspektion

**::term::ansi::code::macros::names**
: Dieser Befehl dient der Introspektion. Er gibt als Ergebnis eine Liste zurück, die die Namen aller Attributbefehle enthält.

**::term::ansi::code::macros::import** ?*ns*? ?*arg*...?
: Dieser Befehl importiert einige oder alle Attributbefehle in den Namespace *ns*. Standardmäßig ist dies der Namespace *macros*. Beachten Sie, dass es sich hierbei um einen relativen Namespace handelt, wodurch der importierte Befehl in einem Kind-Namespace des aktuellen Namespaces landet. Standardmäßig werden alle Befehle importiert; dies kann jedoch eingeschränkt werden, indem die Namen der gewünschten Befehle nach dem Namespace-Argument aufgeführt werden.


## Sequenzen

**::term::ansi::code::macros::menu** *menu*
: Die Beschreibung eines Menüs wird in einen formatierten rechteckigen Textblock umgewandelt, wobei die Menübefehlszeichen durch fetten roten Text hervorgehoben werden. Das Ergebnis wird als Ergebnis des Befehls zurückgegeben.

    Die Beschreibung, *menu*, ist ein Dictionary, das Menübezeichnungen den entsprechenden Befehlszeichen zuordnet.

**::term::ansi::code::macros::frame** *string*
: Der in der Zeichenkette enthaltene Textabschnitt wird nach der Normalisierung interner Tabulatoren am rechten Rand mit Leerzeichen aufgefüllt und anschließend in einen Rahmen aus Box-Grafiken eingefügt. Das Ergebnis wird als Ergebnis des Befehls zurückgegeben.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *term* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Terminalsteuerung

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
