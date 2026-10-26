---
CommandName: ttk::progressbar
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
Copyright:
 - Copyright (c) 2005 Joe English
---

# NAME

ttk::progressbar - Fortschrittsanzeige

# ÜBERSICHT

::: {.synopsis} :::
[ttk::progressbar]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# BESCHREIBUNG

Ein **ttk::progressbar**-Widget zeigt den Status einer länger dauernden Operation. Es gibt zwei Modi: *determinate* zeigt den erledigten Anteil relativ zur Gesamtarbeit; *indeterminate* liefert eine Animation, damit der Benutzer sieht, dass etwas läuft.

Ist **-orient** **horizontal**, kann innerhalb der Fortschrittsleiste ein Text angezeigt werden — konfigurierbar mit **-anchor**, **-font**, **-foreground**, **-justify**, **-text** und **-wraplength**. Bei **vertical** werden diese Optionen ignoriert. Standardoptionen (siehe **ttk_widget**): **-anchor**, **-class**, **-cursor**, **-font**, **-foreground**, **-justify**, **-style**, **-takefocus**, **-text**, **-wraplength**.

# WIDGET-SPEZIFISCHE OPTIONEN

**-length** (length/Length)
: Länge der langen Achse der Fortschrittsleiste (Breite bei horizontal, Höhe bei vertikal). Wert in allen von **Tk_GetPixels** akzeptierten Formen.

**-maximum** (maximum/Maximum)
: Gleitkommazahl für maximalen **-value**. Standard 100.

**-mode** (mode/Mode)
: **determinate** oder **indeterminate**.

**-orient** (orient/Orient)
: **horizontal** oder **vertical** — Ausrichtung der Fortschrittsleiste.

**-phase** (phase/Phase)
: Nur-Lese-Option. Das Widget erhöht diesen Wert periodisch, wenn **-value** größer als 0 und im Modus *determinate* kleiner als **-maximum** ist. Das aktuelle Theme kann damit zusätzliche Animationen steuern..OP -value value Value Aktueller Wert. Im Modus *determinate*: erledigter Anteil. Im Modus *indeterminate*: modulo **-maximum**; ein „Zyklus“ ist abgeschlossen, wenn **-value** um **-maximum** steigt. Ist **-variable** gesetzt, hat **-value** keine Wirkung (Variable hat Vorrang).

**-variable** (variable/Variable)
: Name einer globalen Tcl-Variable, verknüpft mit **-value**. Bei bestehender Variable wird **-value** automatisch bei Änderung der Variable gesetzt.


# WIDGET-BEFEHL

*pathName* **cget** *option*
: Gibt den aktuellen Wert der angegebenen *option* zurück; siehe *ttk::widget(n)*.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Ändert oder fragt Widget-Optionen ab; siehe *ttk::widget(n)*.

*pathName* **identify** *x y*
: Gibt den Namen des Elements an der Position *x*, *y* zurück. Siehe *ttk::widget(n)*.

*pathName* **instate** *statespec* ?*script*?
: Prüft den Widget-Zustand; siehe *ttk::widget(n)*.

*pathName* **state** ?*stateSpec*?
: Ändert oder fragt den Widget-Zustand ab; siehe *ttk::widget(n)*.

*pathName* **start** ?*interval*?
: Startet Auto-Inkrement: periodischer Timer ruft **step** alle *interval* Millisekunden auf. Fehlt *interval*, Standard 50 ms (20 Schritte/s).

*pathName* **step** ?*amount*?
: Erhöht **-value** um *amount*. Fehlt *amount*, Standard 1.0.

*pathName* **stop**
: Stoppt Auto-Inkrement und bricht den von *pathName* **start** gestarteten Timer ab.


# STYLING-OPTIONEN

Der Klassenname für ein **ttk::progressbar** ist **TProgressbar**.

**TProgressbar**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können:

**-background** *color* .br **-bordercolor** *color* .br **-darkcolor** *color* .br **-lightcolor** *color* .br **-maxphase** Für das Aqua-Theme. **-period** Für das Aqua-Theme. **-troughcolor** *color*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite **ttk::style** für Informationen zur Konfiguration von ttk-Stilen.
