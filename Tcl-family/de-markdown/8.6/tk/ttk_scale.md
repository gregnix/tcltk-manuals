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

Ein **ttk::scale**-Widget dient typischerweise dazu, den numerischen Wert einer verknüpften Variablen zu steuern, der sich gleichmäßig über einen bestimmten Bereich ändert. Eine Scale zeigt einen *Schieberegler*, der entlang einer *Rinne* bewegt werden kann. Die relative Position des Schiebereglers auf der Rinne gibt den Wert der Variablen an.

# Standardoptionen

**-class**, **-cursor**, **-style**, **-takefocus**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-command** (**command**/**Command**)
: Legt das Präfix eines Tcl-Befehls fest, der aufgerufen wird, wenn sich der Wert der Scale über einen Widget-Befehl ändert. Der tatsächliche Befehl besteht aus dieser Option gefolgt von einem Leerzeichen und einer reellen Zahl, die den neuen Wert der Scale angibt.

**-from** (**from**/**From**)
: Ein reeller Wert, der dem linken bzw. oberen Ende der Scale entspricht.

**-length** (**length**/**Length**)
: Legt die gewünschte Länge der Scale entlang ihrer langen Seite in Bildschirmeinheiten fest (also in jeder Form, die [Tk\_GetPixels][GetPixels] akzeptiert). Bei vertikalen Scales ist dies die Höhe der Scale, bei horizontalen Scales ihre Breite.

**-orient** (**orient**/**Orient**)
: Legt fest, ob das Widget horizontal oder vertikal angeordnet werden soll. Der Wert muss **horizontal** oder **vertical** oder eine Abkürzung davon sein.

**-to** (**to**/**To**)
: Legt einen reellen Wert fest, der dem rechten bzw. unteren Ende der Scale entspricht. Dieser Wert kann kleiner oder größer als der Wert der Option **-from** sein.

**-value** (**value**/**Value**)
: Legt den aktuellen Gleitkommawert der Variable fest. Ist **-variable** auf eine existierende Variable gesetzt, hat die Angabe von **-value** keine Wirkung (der Wert der Variable hat Vorrang).

**-variable** (**variable**/**Variable**)
: Legt den Namen einer globalen Variablen fest, die mit der Scale verknüpft wird. Sobald sich der Wert der Variablen ändert, wird die Scale aktualisiert, sodass sie diesen Wert wiedergibt. Sobald die Scale interaktiv bedient wird, wird die Variable so geändert, dass sie den neuen Wert der Scale wiedergibt.


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

Folgende Styling-Optionen von **TScale** lassen sich mit [ttk::style][ttk_style] konfigurieren:

**-background** *color*

**-borderwidth** *amount*

**-darkcolor** *color*

**-groovewidth** *amount*

**-lightcolor** *color*

**-sliderwidth** *amount*

**-troughcolor** *color*

**-troughrelief** *relief*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Informationen dazu, wie sich ttk-Stile konfigurieren lassen, finden Sie auf der Handbuchseite [ttk::style][ttk_style].


[GetPixels]: ../tk-c/GetPixels.md
[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
