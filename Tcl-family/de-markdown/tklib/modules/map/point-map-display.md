---
CommandName: map::point::map-display
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - addon
 - point display
 - map display
 - map
Copyright:
---

# NAME

map::point::map-display – Map Action Engine – Ebene zur Darstellung von Punktdefinitionen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.6-]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::edit::points]{.lit} 
[package]{.cmd} [require]{.sub} [debug]{.lit} 
[package]{.cmd} [require]{.sub} [debug::caller]{.lit} 
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [map::point::map-display]{.lit} [0.1]{.optlit} 
:::

# BESCHREIBUNG

Dieses Paket enthält einen Zusatz zu **map::display**, der das Verhalten der Karte erweitert. Dieser Zusatz zeigt eine Menge von *geo/point*-Definitionen. Nur die sichtbaren Punkte belegen Canvas-Ressourcen (Elemente).

# API

# BEISPIEL

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *map* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# KATEGORIE

Kartenanzeige und Hilfsmittel
