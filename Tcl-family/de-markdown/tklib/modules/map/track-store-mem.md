---
CommandName: map::track::store::memory
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - center
 - geo/track
 - diameter
 - geo/track pixels
 - zoom
 - memory store
 - perimeter length
 - length
 - perimeter
 - map
 - pixels
 - store
 - memory
Copyright:
---

# NAME

map::track::store::memory – In-Memory-Speicher für Geo-/Track-Definitionen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit} 
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit} 
[package]{.cmd} [require]{.sub} [debug]{.lit} 
[package]{.cmd} [require]{.sub} [debug::caller]{.lit} 
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [map::track::store::memory]{.lit} [0.1]{.optlit} 
:::

# BESCHREIBUNG

Dieses Paket stellt einen In-Memory-Speicher für *geo/track*-Definitionen bereit, mit einer zwischengespeicherten Berechnung der erweiterten Attribute.

Die Basisdaten werden aus einem Backing-Store abgerufen. Ein **map::track::store::fs** oder ein damit API-kompatibles Produkt.

# API

# BEISPIEL

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *map* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# KATEGORIE

Kartenanzeige und Hilfsmittel
