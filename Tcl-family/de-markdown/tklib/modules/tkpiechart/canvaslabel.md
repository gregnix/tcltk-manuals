---
CommandName: canvasLabel
title: canvasLabel
ManualSection: n
Version: 6.6
TclPart: tklib
TclDescription: canvasLabel class
Links:
 - pie
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

canvasLabel – tkpiechart-Klasse für Canvas-Beschriftungen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [stooop]{.lit} [4.1]{.lit}
[package]{.cmd} [require]{.sub} [switched]{.lit} [2.2]{.lit}
[package]{.cmd} [require]{.sub} [tkpiechart]{.lit} [6.6]{.lit}
[stooop::new]{.cmd} [canvasLabel]{.lit} [canvas]{.arg} [options]{.optarg}
[switched::configure]{.cmd} [canvasLabelObject]{.arg} [options]{.optarg}
[switched::cget]{.cmd} [canvasLabelObject]{.arg} [option]{.arg}
[stooop::delete]{.cmd} [canvasLabelObject]{.arg}
:::

# Beschreibung

Die Klasse canvasLabel gibt dem Text-Element des Canvas einige Fähigkeiten des Tk-Label-Widgets, etwa einen Hintergrund und einen Rand.

Ein canvasLabel besteht aus einem Bullet-Rechteck links vom Text. Das Relief folgt dem Auswahlzustand, bei Auswahl das übliche Relief sunken.

Die Beschriftung hat ein eigenes Tag. Damit lassen sich über die Canvas-Funktionen die Koordinaten des Objekts holen oder es verschieben.

**stooop::new** **canvasLabel** *canvas* ?options?
: Erstellt ein „canvasLabel“-Objekt in der angegebenen Tk-Canvas. Die Objekt-ID des „canvasLabel“-Objekts wird zurückgegeben (in diesem Dokument als *canvasLabelObject* bezeichnet).

**switched::configure** *canvasLabelObject* ?options?
: Konfiguriert ein „canvasLabel“-Objekt oder gibt alle Optionen mit ihren aktuellen Werten zurück, wenn keine Optionen als Parameter übergeben werden.

**switched::cget** *canvasLabelObject* *option*
: Gibt einen Wert für das angegebene „canvasLabel“-Objekt zurück.

**stooop::delete** *canvasLabelObject*
: Löscht das angegebene „canvasLabel“-Objekt.


# Optionen

**-anchor** value
: Ankerposition von Rechteck und Text, relativ zum Positionierungspunkt. Das Verhalten entspricht der Option **-anchor** des *text*-Elements von **canvas**, nur dass das Rechteck mitzählt. Voreingestellt ist *center*.

**-background** color
: Hintergrundfarbe des Bullet-Rechtecks, wie die Option **-fill** des *rectangle*-Elements von **canvas**. Voreingestellt ist durchsichtig, die leere Zeichenkette.

**-bordercolor** color
: Randfarbe des Rechtecks, wie die Option **-outline** des *rectangle*-Elements von **canvas**. Voreingestellt ist schwarz.

**-borderwidth** value
: Randbreite des Rechtecks, wie die Option **-width** des *rectangle*-Elements von **canvas**. Voreingestellt ist die Breite 1 Pixel, das ist die kleinste Breite.

**-bulletwidth** value
: Breite des Rechtecks links vom Text. Voreingestellt ist *10*.

**-font** value
: Schrift des Textes, wie die Option **-font** des *text*-Elements von **canvas**. Voreingestellt ist die systemabhängige Schrift.

**-foreground** color
: Farbe des Textes, wie die Option **-fill** des *text*-Elements von **canvas**. Voreingestellt ist schwarz.

**-justify** value
: Ausrichtung des Textes, wie die Option **-justify** des *text*-Elements von **canvas**. Voreingestellt ist *left*.

**-minimumwidth** value
: Die Gesamtbreite der Beschriftung unterschreitet den angegebenen Wert nicht, kann aber größer sein, wenn der Text es verlangt.

**-padding** value
: Abstand zwischen dem Text und der nächsten Rechteckkante. Die Einheiten sind dieselben wie im Abschnitt *KOORDINATEN* der Handbuchseite **canvas**.

**-scale** list
: Liste von 2 Gleitkommazahlen, der Skalierungsfaktor auf der x- und der y-Achse. Die Skalierung gilt sofort. Voreingestellt ist 1.

**-select** boolean
: Setzt den Zustand der Beschriftung.

**-selectrelief** value
: Entweder *flat*, *raised* oder *sunken*. Der gewünschte 3D-Effekt des Textbereichs, wenn die Beschriftung ausgewählt ist.

**-stipple** bitmap
: Punktmuster, das das Rechteck füllt, wie die Option **-stipple** des *rectangle*-Elements von **canvas**. Voreingestellt gibt es keine Bitmap.

**-text** text
: Die Zeichenkette im Textbereich, wie die Option **-text** des *text*-Elements von **canvas**. Voreingestellt ist die leere Zeichenkette.

**-textbackground** color
: Farbe des Hintergrunds des Textbereichs.

**-width** value
: Maximale Zeilenlänge des Textes, wie die Option **-width** des *text*-Elements von **canvas**. Voreingestellt ist *0*.


# Tags

Der Labeler hat das folgende besondere Tag. Einzelheiten stehen auf der Handbuchseite **canvas** im Abschnitt *ITEM-IDS UND TAGS*:

- canvasLabel(canvasLabelObject)


# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *tkpiechart* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Copyright

```
Copyright (c) 1995-2004 Jean-Luc Fontaine <jfontain@free.fr>
```
