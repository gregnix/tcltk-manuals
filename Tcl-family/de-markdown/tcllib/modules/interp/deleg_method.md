---
CommandName: deleg_method
title: deleg_method
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Interpreter utilities
Keywords:
 - comm
 - delegation
 - interpreter
 - method
 - snit
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

deleg\_method – Erstellung von Kommunikationsdelegaten (snit-Methoden)

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [interp::delegate::method]{.lit} [0.3]{.optlit}
[::interp::delegate::method]{.cmd} [-async]{.optlit} [name]{.arg} [arguments]{.arg} [comm]{.arg} [id]{.arg}
:::

# Beschreibung

Dieses Paket stellt einen einzigen Befehl zur Verwendung innerhalb einer Definition vom Typ **snit** (d. h. eigentlich **snit::macro**) bereit, zur bequemen Erstellung von Methoden, die die eigentliche Arbeit über einen vom Paket **comm** erstellten „Kanal“ an einen entfernten Standort weiterleiten.

# API

**::interp::delegate::method** ?**-async**? *name* *arguments* *comm* *id*
: Dieser Befehl erstellt eine Methode mit dem Namen *name*. Alle Aufrufe dieser Methode leiten die eigentliche Arbeit an den Remote-Standort weiter, der durch den Kanal *comm* und die Endpunkt-ID *id* identifiziert wird.

    Der Name der vom Delegator aufgerufenen Remote-Methode ist identisch mit dem Namen der Methode selbst.

    Normalerweise marshallt die generierte Methode die *arguments* und gibt das Ergebnis der Remote-Methode als ihr eigenes Ergebnis zurück. Wenn jedoch die Option **-async** festgelegt wurde, wartet die generierte Methode nicht auf ein Ergebnis und gibt es sofort zurück.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *interp* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
