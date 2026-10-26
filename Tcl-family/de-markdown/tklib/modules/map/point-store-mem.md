---
CommandName: map::point::store::memory
title: map::point::store::memory
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - center
 - geo/point
 - diameter
 - geo/point
 - geo/point pixels
 - zoom
 - geo/point
 - center
 - geo/point
 - diameter
 - geo/point
 - memory store
 - geo/point
 - perimeter length
 - length
 - geo/point
 - perimeter
 - map
 - memory store
 - geo/point
 - perimeter length
 - geo/point
 - pixels
 - zoom
 - geo/point
 - store
 - geo/point
 - memory
 - zoom
 - geo/point pixels
Copyright:
---

# Name

map::point::store::memory – In-Memory-Speicher für Geo-/Punkt-Definitionen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [map::point::store::memory]{.lit} [0.1]{.optlit}
:::

# Beschreibung

Dieses Paket stellt einen In-Memory-Speicher für *geo/point*-Definitionen bereit, der eine zwischengespeicherte Berechnung erweiterter Attribute ermöglicht.

Die Basisdaten werden aus einem Backing-Store abgerufen. Ein [map::point::store::fs][point-store-fs] oder ein damit API-kompatibles Produkt.

# API

# Beispiel

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *map* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Kategorie

Kartenanzeige und Hilfsmittel


[point-store-fs]: point-store-fs.md
