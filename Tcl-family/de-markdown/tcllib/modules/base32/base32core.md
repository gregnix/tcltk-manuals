---
CommandName: base32::core
title: base32::core
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Base32 encoding
Keywords:
 - base32
Copyright:
---

# Name

base32::core – Erweiterung der grundlegenden Base32-Zuordnungen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [base32::core]{.lit} [0.2]{.optlit}
[::base32::core::define]{.cmd} [map]{.arg} [forwvar]{.arg} [backwvar]{.arg} [ivar]{.arg}
[::base32::core::valid]{.cmd} [string]{.arg} [pattern]{.arg} [mvar]{.arg}
:::

# Beschreibung

Dieses Paket stellt allgemeine Befehle zur Erstellung vollständiger Base32-Zuordnungen bereit, ausgehend von einer grundlegenden Zuordnung, die lediglich die Codes und die zugehörigen Zeichen auflistet. Die hier erstellten vollständigen Zuordnungen – sowohl die reguläre als auch die inverse – bilden Bitfolgen ab und werden von diesen zurückabgebildet und berücksichtigen zudem die Teilzuordnungen am Ende einer Zeichenkette.

*Dies ist im Wesentlichen ein internes Paket für Implementierer von Base32-Kodierern und -Dekodierern. Reguläre Benutzer benötigen dieses Paket nicht.*

# API

**::base32::core::define** *map* *forwvar* *backwvar* *ivar*
: Dieser Befehl berechnet vollständige Vorwärts- und Rückwärtsabbildungen (Inverse) aus der Basis-*map* und speichert diese in den Variablen, die durch *forwvar* bzw. *backwvar* benannt sind. Außerdem erstellt er ein Regexp-Muster zur Erkennung ungültiger Zeichen in einer vermeintlich Base32-kodierten Eingabe und speichert dieses in der durch *ivar* benannten Variablen.

**::base32::core::valid** *string* *pattern* *mvar*
: Dieser Befehl prüft, ob die Eingabe *string* eine gültige Base32-kodierte Zeichenkette ist, und zwar anhand des von **::base32::core::define** erzeugten *pattern* ungültiger Zeichen sowie einiger weiterer allgemeiner Regeln.

    Das Ergebnis des Befehls ist ein boolescher Flag. Sein Wert lautet **True** bei einem gültigen *string* und andernfalls **False**. Im letzteren Fall wird eine Fehlermeldung, die das Problem mit der Eingabe beschreibt, in der durch *mvar* benannten Variablen gespeichert. Die Variable wird nicht verändert, wenn die Eingabe als gültig befunden wurde.

    Die vom Befehl überprüften Regeln gehen über die Ablehnung ungültiger Zeichen hinaus und lauten wie folgt:

    1. Die Länge der Eingabe ist kein Vielfaches von acht,

    2. Der Innenabstand erscheint nicht am Ende der Eingabe, sondern in der Mitte,

    3. Der Innenabstand hat keine Länge von sechs, vier, drei oder einem Zeichen,



# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *base32* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Textverarbeitung

# Copyright

```
Public domain
```
