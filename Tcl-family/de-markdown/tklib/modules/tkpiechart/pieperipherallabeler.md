---
CommandName: piePeripheralLabeler
title: piePeripheralLabeler
ManualSection: n
Version: 6.6
TclPart: tklib
TclDescription: piePeripheralLabeler class
Links:
 - canvasLabel
 - pie
 - pieBoxLabeler
Keywords:
 - canvas
 - labeler
 - pie
 - slice
Copyright:
 - Copyright (c) 1995-2004 Jean-Luc Fontaine <jfontain@free.fr>
---

# Name

piePeripheralLabeler – Labeler-Klasse von tkpiechart mit Beschriftung am Rand

# Übersicht

::: {.synopsis} :::
[stooop::new]{.cmd} [piePeripheralLabeler]{.lit} [canvas]{.arg} [options]{.optarg}
[switched::configure]{.cmd} [piePeripheralLabelerObject]{.arg} [options]{.optarg}
[switched::cget]{.cmd} [piePeripheralLabelerObject]{.arg} [option]{.arg}
:::

# Beschreibung

Das Labeler-Objekt mit Beschriftung am Rand setzt die Segmentbeschriftungen eines Objekts **pie** und wird dem Konstruktor von pie über die Option **-labeler** übergeben. Siehe die Handbuchseite der Klasse **pie**.

Die Beschreibungstexte der Segmente stehen in 2 Spalten unter der Kreisdiagrammgrafik. Die Segmentwerte stehen neben dem Segment und folgen ihm, wenn das Kreisdiagramm aktualisiert wird. Jeder Beschreibungstext steht rechts von einem Rechteck, dessen Hintergrundfarbe zum zugehörigen Segment passt. Jede Beschreibungsbeschriftung ist ein canvasLabel-Objekt.

Ein Objekt **piePeripheralLabeler** muss nicht gelöscht werden. Die Klasse pie erledigt das.

**stooop::new** **piePeripheralLabeler** *canvas* ?options?
: Erzeugt ein piePeripheralLabeler-Objekt im angegebenen Tk-Canvas. Zurückgegeben wird der Objektbezeichner, in diesem Dokument *piePeripheralLabelerObject*.

**switched::configure** *piePeripheralLabelerObject* ?options?
: Konfiguriert ein piePeripheralLabeler-Objekt oder gibt alle Optionen mit ihren aktuellen Werten zurück, wenn keine Optionen übergeben werden.

**switched::cget** *piePeripheralLabelerObject* *option*
: Gibt einen Optionswert des angegebenen piePeripheralLabeler-Objekts zurück.


# Optionen

**-font** value
: Eine Schrift für die Segmentbeschriftungen. Fehlt die Angabe, ist die Schrift systemabhängig.

**-justify** value
: Ausrichtung der Beschriftungen in der eigenen Spalte. Einer von *left*, *center* oder *right*. Voreingestellt ist *left*. Ist die Ausrichtung *right*, fluchten die rechten Kanten aller Spaltenbeschriftungen.

**-offset** value
: Abstand zwischen der Kreisdiagrammgrafik und der nächsten Segmentbeschriftung. Der Wert hat eine der Formen aus dem Abschnitt *KOORDINATEN* der Handbuchseite **canvas**.

**-smallfont**
: Eine Schrift für die Segmentwerte. Gewöhnlich eine kleine Schrift, damit sich die Werte nicht überdecken, wenn zwei Segmente sehr nah beieinander liegen. Fehlt die Angabe, gilt die Schrift der Beschreibungsbeschriftung, Option **-font**.

**-widestvaluetext**
: Eine Zeichenkette maximaler Breite für die Segmentwerte, die um das Kreisdiagramm neben den Segmenten stehen, damit beim Setzen von Breite und Höhe genug Platz für diese Wertbeschriftungen bleibt. Voreingestellt ist 00.0. Zum Beispiel kann der Wert „00.00 %“ sein.


# Tags

Der Labeler hat das folgende besondere Tag. Einzelheiten stehen auf der Handbuchseite **canvas** im Abschnitt *ITEM-IDS UND TAGS*:

- piePeripheralLabeler(piePeripheralLabelerObject)


# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *tkpiechart* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Copyright

```
Copyright (c) 1995-2004 Jean-Luc Fontaine <jfontain@free.fr>
```
