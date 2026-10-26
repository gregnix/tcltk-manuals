---
CommandName: term::send
title: term::send
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - character output
 - control
 - terminal
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::send – Allgemeine Ausgabe an Terminals

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [term::send]{.lit} [0.2]{.optlit}
[::term::send::wrch]{.cmd} [chan]{.arg} [str]{.arg}
[::term::send::wr]{.cmd} [str]{.arg}
:::

# Beschreibung

Dieses Paket stellt die grundlegendsten Befehle zum Senden von Zeichen an ein Terminal bereit. Im Wesentlichen handelt es sich dabei um praktische Wrapper für den integrierten Befehl **puts**.

**::term::send::wrch** *chan* *str*
: Sendet den Text *str* an den durch das Handle *chan* festgelegten Kanal. Im Gegensatz zum integrierten Befehl **puts** beendet dieser Befehl die Zeichenfolge nicht mit einem Zeilenendezeichen. Außerdem erzwingt er ein Leeren der internen Tcl- und Betriebssystem-Puffer, um sicherzustellen, dass die Zeichen sofort verarbeitet werden.

**::term::send::wr** *str*
: Dieser Befehl entspricht dem Befehl **::term::send::wrch**, mit dem Unterschied, dass der Zielkanal fest auf *stdout* festgelegt ist.


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
