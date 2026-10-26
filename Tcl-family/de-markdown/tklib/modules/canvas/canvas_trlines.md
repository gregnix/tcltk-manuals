---
CommandName: canvas::track::lines
title: canvas::track::lines
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - crosshair
 - rubberband
 - tracking
Copyright:
---

# Name

canvas::track::lines – Verwaltung einer Gruppe von Gummiband-Leinen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::tag]{.lit} [0.1]{.optlit}
[::canvas::track]{.cmd} [lines]{.lit} [objectName]{.arg} [canvas]{.arg}
[objectName]{.cmd} [destroy]{.lit}
[objectName]{.cmd} [start]{.lit} [current]{.arg} [p...]{.arg}
[objectName]{.cmd} [move]{.lit} [current]{.arg}
[objectName]{.cmd} [done]{.lit}
:::

# Beschreibung

Dieses Paket enthält eine Klasse, die das Zeichnen einer Reihe von Halbkreuzlinien (Gummibandlinien) verwaltet.

# API für Klassen

**::canvas::track** **lines** *objectName* *canvas*
: Dieser Befehl („Klasse“) erstellt und konfiguriert eine neue Instanz des Trackers mit dem Namen *objectName*. Die Instanz wird mit dem angegebenen *canvas*-Widget verbunden.

    Das Ergebnis des Befehls ist der vollqualifizierte Name der Instanz.


# Instanz-API

Instanzen dieser Klasse stellen die folgende API bereit:

**objectName** **destroy**
: Diese Methode löscht die Instanz und gibt alle ihre internen Ressourcen frei.

    Bei diesem Vorgang werden die Elemente, die die verfolgten Linien darstellen, gelöscht. Der zugehörige Canvas wird dabei nicht gelöscht.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

**objectName** **start** *current* *p*...
: Diese Methode startet die Verfolgung einer Reihe von Linien, wobei jede Linie einem Punkt *p* zugeordnet ist, der den Zielendpunkt der jeweiligen Linie legt. Alle Linien haben *current* als gemeinsamen Endpunkt.

    Beachten Sie, dass eine zuvor verfolgte Gruppe von Linien entfernt wird.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Jeder Punkt wird durch eine Liste mit zwei Elementen angegeben, die seine x- und y-Koordinaten in dieser Reihenfolge enthält.

**objectName** **move** *current*
: Diese Methode aktualisiert den gemeinsamen Endpunkt aller Gummibänder und zeichnet diese neu.

    Das Ergebnis der Methode ist eine leere Zeichenkette.

    Der Punkt wird durch eine Liste mit zwei Elementen festgelegt, die seine x- und y-Koordinaten in dieser Reihenfolge enthält.

**objectName** **done**
: Diese Methode beendet die Verfolgung der aktuellen Zeilengruppe und entfernt diese aus dem Canvas.


# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
