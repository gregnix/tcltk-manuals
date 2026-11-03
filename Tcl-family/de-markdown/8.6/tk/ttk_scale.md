---
CommandName: ttk::scale
title: ttk::scale
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - scale(n)
Keywords:
 - scale
 - slider
 - trough
 - widget
Copyright:
 - Copyright (c) 2008 Donal Fellows
---

# Name

ttk::scale - Schieberegler-Widget erzeugen und steuern

# Übersicht

::: {.synopsis} :::
[ttk::scale]{.cmd} [pathName]{.arg} [options...]{.optarg}
:::

# Beschreibung

Ein **ttk::scale**-Widget steuert typischerweise den numerischen Wert einer verknüpften Variable der sich gleichmäßig über einen Bereich ändert. Es zeigt einen *Schieberegler*, der entlang einer *Rinne* bewegt werden kann; die relative Position des Schiebereglers auf der Rinne gibt den Wert der Variable an.

# Standardoptionen

**-class**, **-cursor**, **-style**, **-takefocus**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-command** (**command**/**Command**)
: Legt das Präfix eines Tcl-Befehls fest, der aufgerufen wird, wenn sich der Wert der Scale über einen Widget-Befehl ändert. Der tatsächliche Befehl besteht aus dieser Option gefolgt von einem Leerzeichen und einer reellen Zahl, die den neuen Wert der Scale angibt.

**-from** (**from**/**From**)
: Reeller Wert für das linke bzw. obere Ende der Skala.

**-length** (**length**/**Length**)
: Legt die gewünschte Länge der Scale in Bildschirmeinheiten fest (also in jeder von [Tk\_GetPixels][GetPixels] akzeptierten Form). Bei vertikaler Ausrichtung die Höhe, bei horizontaler die Breite.

**-orient** (**orient**/**Orient**)
: **horizontal** oder **vertical** (oder Abkürzung) — Layout-Ausrichtung.

**-to** (**to**/**To**)
: Reeller Wert für das rechte bzw. untere Ende; kann kleiner oder größer als **-from** sein.

**-value** (**value**/**Value**)
: Legt den aktuellen Gleitkommawert der Variable fest. Ist **-variable** auf eine existierende Variable gesetzt, hat die Angabe von **-value** keine Wirkung (der Wert der Variable hat Vorrang).

**-variable** (**variable**/**Variable**)
: Legt den Namen einer globalen Variable fest, die mit der Scale verknüpft wird. Ändert sich der Wert der Variable, wird die Scale aktualisiert; wird die Scale interaktiv bedient, wird die Variable auf den neuen Wert der Scale gesetzt.


# Widget-Befehl

*pathName* **cget** *option*
: Gibt den aktuellen Wert der angegebenen *option* zurück; siehe *ttk::widget(n)*.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Ändert oder fragt Widget-Optionen ab; siehe *ttk::widget(n)*.

*pathName* **get** ?*x y*?
: Gibt den aktuellen Wert der Option **-value** zurück oder, falls *x* und *y* angegeben sind, den Wert zu diesen Koordinaten. *X* und *y* sind Pixelkoordinaten relativ zum Ursprung des Scale-Widgets.

*pathName* **identify** *x y*
: Gibt den Namen des Elements an der Position *x*, *y* zurück. Siehe *ttk::widget(n)*.

*pathName* **instate** *statespec* ?*script*?
: Prüft den Widget-Zustand; siehe *ttk::widget(n)*.

*pathName* **set** *value*
: Setzt den Wert des Widgets (also die Option **-value**) auf *value*. Der Wert wird auf den durch **-from** und **-to** gegebenen Bereich begrenzt. Beachten Sie, dass das Setzen der verknüpften Variable (der in **-variable** genannten Variable) nicht zu dieser Begrenzung führt.

*pathName* **state** ?*stateSpec*?
: Ändert oder fragt den Widget-Zustand ab; siehe *ttk::widget(n)*.


# Interne Befehle

*pathName* **coords** ?*value*?
: Gibt die Koordinaten zu *value* zurück oder, falls *value* weggelassen wird, die Koordinaten zum aktuellen Wert der Option **-value**.


# Styling-Optionen

Der Klassenname für ein **ttk::scale** ist **TScale**.

Dynamische Zustände: **active**.

**TScale**-Styling-Optionen mit [ttk::style][ttk_style]:

**-background** *color*

**-borderwidth** *amount*

**-darkcolor** *color*

**-groovewidth** *amount*

**-lightcolor** *color*

**-sliderwidth** *amount*

**-troughcolor** *color*

**-troughrelief** *relief*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe [ttk::style][ttk_style] zur Konfiguration von ttk-Stilen.


[GetPixels]: ../tk-c/GetPixels.md
[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
