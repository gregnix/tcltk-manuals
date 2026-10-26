---
CommandName: ttk_image
title: ttk_image
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::intro(n)
 - ttk::style(n)
 - ttk_vsapi(n)
 - image(n)
 - photo(n)
Keywords:
 - style
 - theme
 - appearance
 - pixmap theme
 - image
Copyright:
 - Copyright (c) 2004 Joe English
---

# Name

ttk\_image - Definiert ein Element auf Basis eines Bildes

# Übersicht

::: {.synopsis} :::
[ttk::style]{.cmd} [element]{.sub} [create]{.lit} [name]{.arg} [image]{.lit} [imageSpec]{.arg} [options]{.optarg}
:::

# Beschreibung

Die *image*-Elementfabrik erzeugt ein neues Element im aktuellen Theme, dessen Erscheinungsbild durch Tk-Bilder bestimmt wird. *imageSpec* ist eine Liste mit einem oder mehreren Elementen. Das erste Element ist der Standard-Bildname. Der Rest der Liste ist eine Folge von *statespec / value*-Paaren, die andere Bilder angeben, wenn das Element in einem bestimmten Zustand oder einer Kombination von Zuständen ist.

# Optionen

Gültige *options* sind:

**-border** *padding*
: *padding* ist eine Liste mit bis zu vier Ganzzahlen für die Ränder links, oben, rechts und unten. Sind weniger als vier Elemente angegeben, gilt standardmäßig *bottom* = *top*, *right* = *left* und *top* = *left*. Eine Liste mit drei Zahlen legt den linken, vertikalen und rechten Rand fest; zwei Zahlen den horizontalen und vertikalen Rand; eine einzelne Zahl denselben Rand ringsum. Siehe [Bild-Streckung] unten.

**-height** *height*
: Legt eine Mindesthöhe für das Element fest. Ist der Wert kleiner als null, wird die Höhe des Basisbildes als Standard verwendet.

**-padding** *padding*
: Legt den Innenabstand des Elements fest. Der Innenabstand ist eine Liste mit bis zu vier Längenangaben *left top right bottom*. Sind weniger als vier Elemente angegeben, gilt standardmäßig *bottom* = *top*, *right* = *left* und *top* = *left*. Eine Liste mit drei Zahlen legt den linken, vertikalen und rechten Innenabstand fest; zwei Zahlen den horizontalen und vertikalen Innenabstand; eine einzelne Zahl denselben Innenabstand ringsum. Standard ist **-border**, falls nicht angegeben.

**-sticky** *spec*
: Legt fest, wie das Bild im endgültigen Bereich platziert wird. *spec* enthält null oder mehr Zeichen „n“, „s“, „w“ oder „e“.

**-width** *width*
: Legt eine Mindestbreite für das Element fest. Ist der Wert kleiner als null, wird die Breite des Basisbildes als Standard verwendet.


# Bild-Streckung

Ist der dem Element zugewiesene Bereich größer als das Bild, wird das Bild gemäß der Option **-sticky** im Bereich platziert. Muss das Bild horizontal gestreckt werden (d. h. **-sticky ew**) oder vertikal (**-sticky ns**), werden Teilbereiche des Bildes entsprechend der Option **-border** wiederholt, um den Bereich zu füllen. **-border** teilt das Bild in neun Regionen: vier feste Ecken, obere und linke Kanten (horizontal kachelbar), linke und rechte Kanten (vertikal kachelbar) und den zentralen Bereich (in beide Richtungen kachelbar).

Ein Bildelement, das keinen Platz beanspruchen soll (z. B. als Hintergrundbild), sollte **-width 0** und **-height 0** verwenden.

# Beispiel

```
set img1 [image create photo -file button.png]
set img2 [image create photo -file button-pressed.png]
set img3 [image create photo -file button-active.png]
ttk::style element create Button.button image \
    [list $img1  pressed $img2  active $img3] \
    -border {2 4} -sticky we
```
