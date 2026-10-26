---
CommandName: map::display
title: map::display
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - display
 - map
 - map
 - map display
Copyright:
---

# Name

map::display – Widget zur Kartenanzeige

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [canvas::sqmap]{.lit}
[package]{.cmd} [require]{.sub} [canvas::zoom]{.lit}
[package]{.cmd} [require]{.sub} [crosshair]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [widget::scrolledwindow]{.lit}
[package]{.cmd} [require]{.sub} [map::display]{.lit} [0.1]{.optlit}
:::

# Beschreibung

Dieses Paket stellt ein Karten-Widget mit dem Grundverhalten Ziehen, Zentrieren und Zoom +/− bereit. Die Kacheln kommen von einem einstellbaren Anbieter wie [map::provider::osm][provider-osm] oder von jedem dazu API-kompatiblen Anbieter. An das Widget lassen sich Bausteine anbinden, die weiteres Verhalten liefern, etwa die Anzeige von geo/\*-Ressourcen oder deren Bearbeitung.

# API

# Beispiel

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *map* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Kategorie

Kartenanzeige und Hilfsmittel


[provider-osm]: provider-osm.md
