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

Ein **ttk::scale**-Widget steuert typischerweise den numerischen Wert einer verknüpften Variable über einen Bereich. Es zeigt einen *Schieberegler* auf einer *Rinne*; die relative Position gibt den Wert an.

# Standardoptionen

**-class**, **-cursor**, **-style**, **-takefocus**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-command** (**command**/**Command**)
: Legt das Präfix eines Tcl-Befehls fest, der aufgerufen wird, wenn sich der Wert der Scale über einen Widget-Befehl ändert. Der tatsächliche Befehl besteht aus dieser Option gefolgt von einem Leerzeichen und einer reellen Zahl, die den neuen Wert der Scale angibt.

**-from** (**from**/**From**)
: Reeller Wert für das linke bzw. obere Ende der Skala.

**-length** (**length**/**Length**)
: Gewünschte Längenmaß der langen Dimension in Bildschirmeinheiten ([Tk\_GetPixels][GetPixels]). Bei vertikaler Ausrichtung die Höhe, bei horizontaler die Breite.

**-orient** (**orient**/**Orient**)
: **horizontal** oder **vertical** (oder Abkürzung) — Layout-Ausrichtung.

**-to** (**to**/**To**)
: Reeller Wert für das rechte bzw. untere Ende; kann kleiner oder größer als **-from** sein.

**-value** (**value**/**Value**)
: Aktueller Gleitkommawert. Ist **-variable** gesetzt, hat **-value** keine Wirkung (Variable hat Vorrang).

**-variable** (**variable**/**Variable**)
: Name einer globalen Variable; bei Änderung aktualisiert sich die Skala; bei interaktiver Bedienung wird die Variable angepasst.


# Widget-Befehl

Zusätzlich zu **cget**, **configure**, **identify element**, **instate**, **state** und **style** (siehe [ttk::widget][ttk_widget]):

[pathName]{.ins} [get]{.sub} [x y]{.optarg}
: Aktuellen **-value** oder den Wert zu den Pixelkoordinaten *x*, *y* (relativ zum Widget-Ursprung).

[pathName]{.ins} [set]{.sub} [value]{.arg}
: **-value** auf *value* setzen, begrenzt auf **-from**/**-to**. Setzen der verknüpften Variable führt nicht zu dieser Begrenzung.


# Interne Befehle

[pathName]{.ins} [coords]{.sub} [value]{.optarg}
: Koordinaten zu *value* oder zum aktuellen **-value**, falls *value* fehlt.


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
