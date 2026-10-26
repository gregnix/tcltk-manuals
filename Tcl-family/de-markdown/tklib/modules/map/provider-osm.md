---
CommandName: map::provider::osm
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - map
 - mapnik
 - openstreetmap
 - provider
 - tiles
 - tile provider
Copyright:
---

# NAME

map::provider::osm – Kachel-Anbieter, der OpenStreetMap Mapnik als Quelle nutzt

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit} 
[package]{.cmd} [require]{.sub} [debug]{.lit} 
[package]{.cmd} [require]{.sub} [debug::caller]{.lit} 
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit} 
[package]{.cmd} [require]{.sub} [map::slippy::cache]{.lit} 
[package]{.cmd} [require]{.sub} [map::slippy::fetcher]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [map::provider::osm]{.lit} [0.1]{.optlit} 
:::

# BESCHREIBUNG

Dieses Paket enthält einen Kachel-Provider, der für die Verwendung mit **map::display** geeignet ist. Es nutzt OpenStreetMap Mapnik als Quelle und speichert die abgerufenen Kacheln im lokalen Dateisystem zwischen.

# API

# BEISPIEL

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *map* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# KATEGORIE

Kartenanzeige und Hilfsmittel
