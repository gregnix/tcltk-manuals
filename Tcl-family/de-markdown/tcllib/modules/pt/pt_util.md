---
CommandName: pt::util
title: pt::util
ManualSection: n
Version: 1.2
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - EBNF
 - LL(k)
 - PEG
 - TDPL
 - context-free languages
 - expression
 - grammar
 - matching
 - parser
 - parsing expression
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - state
 - top-down parsing languages
 - transducer
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

pt::util – Allgemeine Hilfsbefehle

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::ast]{.lit} [1.2]{.optlit}
[::pt::util]{.cmd} [error2readable]{.lit} [error]{.arg} [text]{.arg}
[::pt::util]{.cmd} [error2position]{.lit} [error]{.arg} [text]{.arg}
[::pt::util]{.cmd} [error2text]{.lit} [error]{.arg}
:::

# Beschreibung

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket stellt allgemeine Hilfsbefehle bereit.

Dies ist ein unterstützendes Paket in der Kernschicht der Parser-Tools.

Bild: arch\_core\_support

# API

**::pt::util** **error2readable** *error* *text*
: Dieser Befehl nimmt die strukturierte Form eines Syntaxfehlers *error* – wie er von Parser-Laufzeitumgebungen ausgelöst wird – sowie den Eingabetext *text* entgegen, der diesen Fehler verursacht hat, und gibt eine Zeichenkette zurück, die den Fehler in einer für Menschen lesbaren Form beschreibt.

    Der Eingabetext *text* wird benötigt, um die Zeichenposition des Fehlers in ein besser lesbares Zeilen-/Spaltenformat umzuwandeln und Auszüge aus dem Eingabetext rund um die Fehlerposition bereitzustellen.

**::pt::util** **error2position** *error* *text*
: Dieser Befehl nimmt die strukturierte Form eines Syntaxfehlers *error*, wie Parser-Laufzeitumgebungen ihn auslösen, und den Eingabetext *text*, der den Fehler verursacht hat, und gibt eine Liste aus zwei Elementen zurück: Zeilennummer und Spaltenindex der Zeichenposition des Fehlers in der Eingabe, in dieser Reihenfolge.

**::pt::util** **error2text** *error*
: Dieser Befehl nimmt die strukturierte Form eines Syntaxfehlers *error*, wie Parser-Laufzeitumgebungen ihn auslösen, und gibt eine Liste von Zeichenfolgen zurück. Jede beschreibt eine mögliche erwartete Eingabe in einer für Menschen lesbaren Form.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pt* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Parser und Grammatiken

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
