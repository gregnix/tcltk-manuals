---
CommandName: deleg_proc
title: deleg_proc
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Interpreter utilities
Keywords:
 - comm
 - delegation
 - interpreter
 - procedure
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

deleg\_proc – Erstellung von Kommunikationsdelegaten (Prozeduren)

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [interp::delegate::proc]{.lit} [0.3]{.optlit}
[::interp::delegate::proc]{.cmd} [-async]{.optlit} [name]{.arg} [arguments]{.arg} [comm]{.arg} [id]{.arg}
:::

# Beschreibung

Dieses Paket stellt einen einzigen Befehl zur Verfügung, mit dem sich Prozeduren bequem erstellen lassen, die die eigentliche Arbeit über einen vom Paket **comm** erstellten „Kanal“ an einen entfernten Standort weiterleiten.

# API

**::interp::delegate::proc** ?**-async**? *name* *arguments* *comm* *id*
: Dieser Befehl erstellt eine Prozedur mit dem Namen *name* und gibt deren vollqualifizierten Namen zurück. Alle Aufrufe dieser Prozedur leiten die eigentliche Arbeit an den Remote-Standort weiter, der durch den Kommunikationskanal *comm* und die Endpunkt-ID *id* identifiziert wird.

    Der Name der vom Delegator aufgerufenen Remote-Prozedur lautet \[Namespace tail *name*\]. Das heißt, die Namespace-Informationen werden aus dem Aufruf entfernt.

    Normalerweise marshallt die generierte Prozedur die *arguments* und gibt das Ergebnis der Remote-Prozedur als ihr eigenes Ergebnis zurück. Wenn jedoch die Option **-async** festgelegt wurde, wartet die generierte Prozedur nicht auf ein Ergebnis und gibt es sofort zurück.


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
