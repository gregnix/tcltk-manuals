---
CommandName: map::mark
title: map::mark
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - location marking
 - map
 - mark location
Copyright:
---

# Name

map::mark – Map Action Engine – Einen Punkt markieren

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [map::mark]{.lit} [0.1]{.optlit}
:::

# Beschreibung

Dieses Paket enthält einen Zusatz zu [map::display][display], der das Verhalten der Karte erweitert. Mit diesem Zusatz lassen sich Orte markieren, also *geo/point*s. Die markierten Orte werden über eine Rückruffunktion gemeldet.

# API

# Beispiel

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *map* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Kategorie

Kartenanzeige und Hilfsmittel


[display]: display.md
