---
CommandName: map::box::store::memory
title: map::box::store::memory
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - center
 - geo/box
 - diameter
 - geo/box
 - geo/box pixels
 - zoom
 - geo/box
 - center
 - geo/box
 - diameter
 - geo/box
 - memory store
 - geo/box
 - perimeter length
 - length
 - geo/box
 - perimeter
 - map
 - memory store
 - geo/box
 - perimeter length
 - geo/box
 - pixels
 - zoom
 - geo/box
 - store
 - geo/box
 - memory
 - zoom
 - geo/box pixels
Copyright:
---

# Name

map::box::store::memory – In-Memory-Speicher für Geo-/Box-Definitionen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [map::box::store::memory]{.lit} [0.1]{.optlit}
:::

# Beschreibung

Dieses Paket stellt einen In-Memory-Speicher für *geo/box*-Definitionen bereit, wobei die Berechnung der erweiterten Attribute zwischengespeichert wird.

Die Basisdaten werden aus einem Backing-Store abgerufen. Ein [map::box::store::fs][box-store-fs] oder ein damit API-kompatibles Produkt.

# API

# Beispiel

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *map* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Kategorie

Kartenanzeige und Hilfsmittel


[box-store-fs]: box-store-fs.md
