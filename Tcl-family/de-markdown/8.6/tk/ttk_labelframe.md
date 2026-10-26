---
CommandName: ttk::labelframe
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - ttk::frame(n)
 - labelframe(n)
Keywords:
 - widget
 - frame
 - container
 - label
 - groupbox
Copyright:
 - Copyright (c) 2005 Joe English
---

# NAME

ttk::labelframe - Container-Widget mit optionalem Label

# ÜBERSICHT

::: {.synopsis} :::
[ttk::labelframe]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# BESCHREIBUNG

Ein **ttk::labelframe**-Widget ist ein Container, der andere Widgets gruppiert. Es hat ein optionales Label, das eine einfache Textzeichenkette oder ein anderes Widget sein kann. Standardoptionen (siehe **ttk_widget**): **-class**, **-cursor**, **-padding**, **-style**, **-takefocus**.

# WIDGET-SPEZIFISCHE OPTIONEN

**-height** (height/Height)
: Legt bei Angabe die gewünschte Widget-Höhe in Pixeln fest. (Siehe *ttk::frame(n)* für weitere Hinweise zu **-width** und **-height**).

**-labelanchor** (labelAnchor/LabelAnchor)
: Legt fest, wo das Label platziert wird. Zulässige Werte sind (im Uhrzeigersinn von der oberen linken Ecke): **nw**, **n**, **ne**, **en**, **e**, **es**, **se**, **s**,**sw**, **ws**, **w** und **wn**. Der Standardwert ist theme-abhängig.

**-labelwidget** (labelWidget/LabelWidget)
: Name eines Widgets, das als Label verwendet wird. Wenn gesetzt, überschreibt dies die Option **-text**. Das **-labelwidget** muss ein Kind des **labelframe**-Widgets oder eines seiner Vorfahren sein und zum selben Toplevel-Fenster wie das **labelframe** gehören.

**-text** (text/Text)
: Legt den Text des Labels fest.

**-underline** (underline/Underline)
: Wenn gesetzt, gibt dies den ganzzahligen Index (0-basiert) eines Zeichens an, das in der Textzeichenkette unterstrichen wird. Das unterstrichene Zeichen dient der Mnemonik-Aktivierung. Die Mnemonik-Aktivierung für ein **ttk::labelframe** setzt den Tastaturfokus auf das erste Kind des **ttk::labelframe**-Widgets.

**-width** (width/Width)
: Legt bei Angabe die gewünschte Widget-Breite in Pixeln fest.


# WIDGET-BEFEHL

Unterstützt die Standard-Widget-Befehle **configure**, **cget**, **identify**, **instate** und **state**; siehe *ttk::widget(n)*.

# STYLING-OPTIONEN

Der Klassenname für ein **ttk::labelframe** ist **TLabelframe**. Das Textlabel hat die Klasse **TLabelframe.Label**.

Dynamische Zustände: **disabled**, **readonly**.

**TLabelframe**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können, sind:

**-background** *color* .br **-bordercolor** *color* .br **-borderwidth** *amount* .br **-darkcolor** *color* .br **-labelmargins** *amount* .br **-labeloutside** *boolean* .br **-lightcolor** *color* .br **-relief** *relief*

**TLabelframe.Label**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können, sind:

**-background** *color* .br **-font** *font* .br **-foreground** *color*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite **ttk::style** für Informationen zur Konfiguration von ttk-Stilen.
