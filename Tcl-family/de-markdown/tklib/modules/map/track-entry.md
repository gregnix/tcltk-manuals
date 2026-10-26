---
CommandName: map::track::entry
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - addon
 - track entry
 - map display
 - map
Copyright:
---

# NAME

map::track::entry – Map Action Engine – Track-Eingabe

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::edit::polyline]{.lit} 
[package]{.cmd} [require]{.sub} [debug]{.lit} 
[package]{.cmd} [require]{.sub} [debug::caller]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit} 
[package]{.cmd} [require]{.sub} [map::track::entry]{.lit} [0.1]{.optlit} 
:::

# BESCHREIBUNG

Dieses Paket enthält einen Zusatz zu **map::display**, der das Verhalten der Karte erweitert. Mit diesem Zusatz lässt sich eine offene Folge von Punkten eingeben, also ein *geo/track*.

# API

# BEISPIEL

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *map* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# KATEGORIE

Kartenanzeige und Hilfsmittel
