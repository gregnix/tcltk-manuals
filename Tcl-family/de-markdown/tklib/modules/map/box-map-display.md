---
CommandName: map::box::map-display
title: map::box::map-display
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Map display support
Keywords:
 - addon
 - box display
 - map display
 - box display
 - map display
 - addon
 - map
 - map display
 - addon
 - box display
Copyright:
---

# Name

map::box::map-display – Map Action Engine – Ebene zur Anzeige von Box-Definitionen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.6-]{.lit}
[package]{.cmd} [require]{.sub} [canvas::edit::rectangle]{.lit}
[package]{.cmd} [require]{.sub} [debug]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit}
[package]{.cmd} [require]{.sub} [map::slippy]{.lit} [0.8]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [map::box::map-display]{.lit} [0.1]{.optlit}
:::

# Beschreibung

Dieses Paket enthält einen Zusatz zu [map::display][display], der das Verhalten der Karte erweitert. Dieser Zusatz zeigt eine Menge von *geo/box*-Definitionen. Nur die sichtbaren Boxen belegen Canvas-Ressourcen (Elemente).

# API

# Beispiel

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *map* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Kategorie

Kartenanzeige und Hilfsmittel


[display]: display.md
