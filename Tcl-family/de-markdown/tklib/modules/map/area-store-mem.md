---
CommandName: map::area::store::memory
title: map::area::store::memory
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - center
 - geo/area
 - diameter
 - geo/area
 - geo/area pixels
 - zoom
 - geo/area
 - center
 - geo/area
 - diameter
 - geo/area
 - memory store
 - geo/area
 - perimeter length
 - length
 - geo/area
 - perimeter
 - map
 - memory store
 - geo/area
 - perimeter length
 - geo/area
 - pixels
 - zoom
 - geo/area
 - store
 - geo/area
 - memory
 - zoom
 - geo/area pixels
Copyright:
---

# Name

map::area::store::memory – In-Memory-Speicher für Geo-/Flächendefinitionen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [map::area::store::memory]{.lit} [0.1]{.optlit}
:::

# Beschreibung

Dieses Paket bietet einen In-Memory-Speicher für *geo/area*-Definitionen mit einer zwischengespeicherten Berechnung der erweiterten Attribute.

Die Basisdaten werden aus einem Backing-Store abgerufen. Ein [map::area::store::fs][area-store-fs] oder ein damit API-kompatibles Produkt.

# API

# Beispiel

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *map* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Kategorie

Kartenanzeige und Hilfsmittel


[area-store-fs]: area-store-fs.md
