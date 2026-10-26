---
CommandName: pie
title: pie
ManualSection: n
Version: 6.6
TclPart: tklib
TclDescription: tkpiechart pie class
Links:
 - canvasLabel
 - pieBoxLabeler
 - piePeripheralLabeler
Keywords:
 - canvas
 - labeler
 - pie
 - slice
Copyright:
 - Copyright (c) 1995-2004 Jean-Luc Fontaine <jfontain@free.fr>
---

# Name

pie – 2D- oder 3D-Kreisdiagramm-Objekt in einem Canvas

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [stooop]{.lit} [4.1]{.lit}
[package]{.cmd} [require]{.sub} [switched]{.lit} [2.2]{.lit}
[package]{.cmd} [require]{.sub} [tkpiechart]{.lit} [6.6]{.lit}
[stooop::new]{.cmd} [pie]{.lit} [canvas]{.arg} [x]{.arg} [y]{.arg} [options]{.optarg}
[switched::configure]{.cmd} [pieObject]{.arg} [options]{.optarg}
[switched::cget]{.cmd} [pieObject]{.arg} [option]{.arg}
[stooop::delete]{.cmd} [pieObject]{.arg}
:::

pie::newSlice *pieObject* ?labelText?

pie::deleteSlice *pieObject* *sliceObject*

pie::sizeSlice *pieObject* *sliceObject* *unitShare* ?displayedValue?

pie::labelSlice *pieObject* *sliceObject* *string*

pie::selectedSlices *pieObject*

# Beschreibung

Ein pie-Objekt stellt eine Menge von Werten dar, gewöhnlich als Anteile an einer Summe. Jeder Wert ist ein farbiges Segment, mit zwei- oder dreidimensionalem Aussehen. Zu jedem Segment gehört eine Beschriftung mit dem Datennamen und ein Zahlenfeld mit dem prozentualen Anteil des Segments. Die Beschriftungen setzt das gewählte Labeler-Objekt, Option **-labeler**. Die Farbe jeder Beschriftung entspricht dem zugehörigen Segment.

Ein Kreisdiagramm besteht aus Tk-Canvas-Elementen in den Objekten **pieBoxLabeler**, **piePeripheralLabeler** und **canvasLabel**, die das pie-Objekt bilden. Der Konstruktor erzeugt das Kreisdiagramm selbst und sein Hintergrundsegment im übergeordneten Canvas. Sobald das pie-Objekt existiert, lassen sich Segmente erzeugen und in der Größe ändern. Beim Erzeugen muss das übergeordnete Tk-Widget **canvas** schon existieren.

Die Segmentfarben werden automatisch erzeugt, mit einer voreingestellten Farbliste für alle Kreisdiagramme, sofern nicht eine andere Liste gilt, Option **-colors**. Bei dreidimensionalem Aussehen ist die Kante eines Segments dunkler als die Oberseite, im selben Farbton.

**stooop::new** **pie** *canvas* *x* *y* ?options?
: Erzeugt ein pie-Objekt im angegebenen Tk-Canvas. Die linke obere Ecke des Kreisdiagramms liegt an den angegebenen Koordinaten im Canvas. Zurückgegeben wird der Bezeichner des pie-Objekts, in diesem Dokument *pieObject*.

**switched::configure** *pieObject* ?options?
: Konfiguriert ein „pie“-Objekt oder gibt alle Optionen mit ihren aktuellen Werten zurück, wenn keine Optionen als Parameter übergeben werden.

**switched::cget** *pieObject* *option*
: Gibt einen Wert für die Option für das angegebene Pie-Objekt zurück.

**stooop::delete** *pieObject*
: Löscht das angegebene Kreisdiagramm-Objekt.


# Überblick

Die Klasse „pie“ ist Teil der Erweiterung „tkpiechart“, die es dem Programmierer ermöglicht, 2D- oder 3D-Kreisdiagramme in einer Tcl/Tk-Anwendung zu erstellen und dynamisch zu aktualisieren. Das Paket „tkpiechart“ ist ausschließlich in Tcl geschrieben und nutzt dank des in „tcllib“ enthaltenen Pakets „stooop“ objektorientierte Techniken.

# Optionen

**-autoupdate** boolean
: Boolescher Wert. Legt fest, ob alle Segmente und ihre Beschriftungen neu gezeichnet werden, wenn sich eine Segmentgröße ändert. Voreingestellt eingeschaltet. Ausschalten und **pie::update** aufrufen, wenn viele Segmente auf einmal geändert werden und das schneller gehen soll.

**-background** color
: Die Segmente füllen das Kreisdiagramm zu 100 % oder auch nicht. Der unbelegte Teil ist ein Segment, das 100 % des Kreisdiagramms einnimmt. Voreingestellt ist es durchsichtig mit einem schwarzen Rand. Die Farbe dieses Hintergrundsegments lässt sich mit Farbnamen setzen wie bei der Standardoption **-background**. Einzelheiten stehen auf der Tk-Handbuchseite **options**. Hat das Kreisdiagramm ein 3D-Aussehen, ist der Hintergrund einer Segmentkante dunkler als die Oberseite und nutzt denselben Farbton.

**-colors** list
: Liste von Farben für die Segmente. Die Segmentfarben werden der Reihe nach aus der Liste genommen und wieder von vorn, wenn es mehr Segmente als Farben gibt. Das Format ist dasselbe wie bei **-background**.

**-height** value
: Gesamthöhe des Kreisdiagramms, einschließlich des Platzes für die Beschriftungen des Labelers. Die Segmente werden in der Größe angepasst, wenn Beschriftungen hinzukommen oder wegfallen, also beim Erzeugen oder Löschen von Segmenten, sodass die Gesamthöhe gleich bleibt. Der Wert hat eine der Formen aus dem Abschnitt *KOORDINATEN* der Handbuchseite **canvas**.

**-labeler** object
: Ein Platzierungsobjekt für die Segmentbeschriftungen, sodass zum Beispiel die Segmentwerte daneben stehen können. Fehlt die Angabe, wird *pieBoxLabeler* verwendet, siehe die zugehörige Handbuchseite. Die andere Möglichkeit ist die Klasse *piePeripheralLabeler*. Jeder Labeler hat ein eigenes Verhalten, das seine Optionen setzen. Das Labeler-Objekt wird mit dem Kreisdiagramm-Objekt gelöscht. Nach dem Erzeugen des Kreisdiagramms lässt sich der Labeler nicht mehr wechseln.

**-selectable** boolean
: Boolescher Wert. Legt fest, ob Segmente auswählbar sind. Zulässig sind die booleschen Werte von Tcl. Auswählbare Segmente lassen sich mit der ersten Maustaste wählen, durch einen Klick auf das Segment oder seine Beschriftung. Die Auswahl lässt sich mit den üblichen Klicks *control* oder *shift* erweitern. Die Liste der gerade ausgewählten Segmente liefert jederzeit die Elementprozedur **selectedSlices** der Klasse pie.

**-title** text
: Titeltext über dem Kreisdiagramm.

**-titlefont** value
: Schrift des Titeltextes.

**-titleoffset** value
: Abstand zwischen der Unterkante des Titeltextes und der Oberkante der Segmente. Der Wert hat eine der Formen aus dem Abschnitt **GRÖßEN** unten.

**-thickness** value
: Die Dicke ist voreingestellt 0. Das Kreisdiagramm ist dann eine einfache 2D-Form und lässt sich deutlich schneller zeichnen. Ein positiver Wert gibt ihm ein 3D-Aussehen mit dazu passenden dunkleren Farben an den Segmentkanten. Die Werte haben eine der Formen aus dem Abschnitt *GRÖßEN* unten.

**-width** value
: Gesamtbreite des Kreisdiagramms, einschließlich des Platzes für die Beschriftungen des Labelers. Die Segmente werden in der Größe angepasst, wenn Beschriftungen hinzukommen oder wegfallen, also beim Erzeugen oder Löschen von Segmenten, sodass die Gesamtbreite gleich bleibt. Der Wert hat eine der Formen aus dem Abschnitt *KOORDINATEN* der Handbuchseite **canvas**.


# Prozeduren für Mitglieder

pie::newSlice *pieObject* ?labelText?
: Erzeugt ein Segment. Zurückgegeben wird ein eindeutiger Objektbezeichner, in diesem Dokument *sliceObject*. Die Segmentfarbe wird automatisch vergeben, die Beschriftung setzt der angegebene Labeler, Option **-labeler**. Das Segment selbst liegt im Uhrzeigersinn hinter den vorhandenen Segmenten. Der Objektbezeichner dient zum Setzen und Ändern der Größe.

    Fehlt der Beschriftungstext, wird er *"slice n"*, wobei *n* die Nummer des Segments in der Erzeugungsreihenfolge ist. Das erste Segment hat die Nummer 1.

pie::deleteSlice *pieObject* *sliceObject*
: Löscht ein Segment. Die folgenden Segmente im Uhrzeigersinn rücken nach, sodass die Lücke verschwindet.

pie::sizeSlice *pieObject* *sliceObject* *unitShare* ?displayedValue?
: Setzt oder ändert die Größe eines Segments. Das Segment wird neu berechnet, sodass es den passenden Anteil am ganzen Kreisdiagramm einnimmt. *unitShare* ist eine Gleitkommazahl als Anteil am ganzen Kreisdiagramm, zwischen 0 und 1. Die folgenden Segmente im Uhrzeigersinn rücken auf die neue Größe. Der Größenwert neben der Segmentbeschriftung wird der neue Anteil oder, wenn angegeben, *displayedValue*.

pie::labelSlice *pieObject* *sliceObject* *string*
: Aktualisiert eine Segmentbeschriftung. Der Aufruf ist jederzeit möglich.

pie::selectedSlices *pieObject*
: Gibt die Liste der gerade ausgewählten Segmentobjekte zurück.


# Tags

Das gesamte Kreisdiagramm, die Grafiken des Kreisdiagramms (alle Segmente) sowie jedes einzelne Segment sind mit den folgenden spezifischen Tags versehen:

- **pie(pieObject)**

- **pieSlices(pieObject)**

- **slice(sliceObject)**


Zum Beispiel lässt sich das ganze Kreisdiagramm mit dem Befehl **move** von **canvas** am pie-Tag verschieben, und Bindings an Segmenten lassen sich über die Segment-Tags setzen. Einzelheiten stehen auf der Handbuchseite **canvas** im Abschnitt *ITEM-IDS UND TAGS*.

# Größen

Alle Größen zu Kreisdiagrammen sind Gleitkommazahlen. Koordinaten und Größen sind Bildschirmeinheiten, Gleitkommazahlen, optional gefolgt von einem der Buchstaben aus dem Abschnitt *KOORDINATEN* der Handbuchseite **canvas**.

# Einschränkungen

Ist die Zahl der Segmente zu groß, bekommen einige Segmente dieselbe Farbe. Dann lassen sich eigene Farben setzen.

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *tkpiechart* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Copyright

```
Copyright (c) 1995-2004 Jean-Luc Fontaine <jfontain@free.fr>
```
