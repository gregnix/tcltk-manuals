---
CommandName: ttk::progressbar
title: ttk::progressbar
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
Copyright:
 - Copyright (c) 2005 Joe English
---

# Name

ttk::progressbar - Fortschrittsanzeige

# Übersicht

::: {.synopsis} :::
[ttk::progressbar]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Beschreibung

Ein **ttk::progressbar**-Widget zeigt den Status einer länger dauernden Operation. Es gibt zwei Modi: *determinate* zeigt den erledigten Anteil relativ zur Gesamtarbeit; *indeterminate* liefert eine Animation, damit der Benutzer sieht, dass etwas läuft.

# Standardoptionen

**-class**, **-cursor**, **-takefocus**, **-style**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-length** (**length**/**Length**)
: Länge der langen Achse der Fortschrittsleiste (Breite bei horizontal, Höhe bei vertikal).

**-maximum** (**maximum**/**Maximum**)
: Gleitkommazahl für maximalen **-value**. Standard 100.

**-mode** (**mode**/**Mode**)
: **determinate** oder **indeterminate**.

**-orient** (**orient**/**Orient**)
: **horizontal** oder **vertical** — Ausrichtung der Fortschrittsleiste.

**-phase** (**phase**/**Phase**)
: Nur-Lese-Option. Das Widget erhöht diesen Wert periodisch, wenn **-value** größer als 0 und im Modus *determinate* kleiner als **-maximum** ist. Das aktuelle Theme kann damit zusätzliche Animationen steuern.

**-value** (**value**/**Value**)
: Aktueller Wert. Im Modus *determinate*: erledigter Anteil. Im Modus *indeterminate*: modulo **-maximum**; ein „Zyklus“ ist abgeschlossen, wenn **-value** um **-maximum** steigt. Ist **-variable** gesetzt, hat **-value** keine Wirkung (Variable hat Vorrang).

**-variable** (**variable**/**Variable**)
: Name einer globalen Tcl-Variable, verknüpft mit **-value**. Bei bestehender Variable wird **-value** automatisch bei Änderung der Variable gesetzt.


# Widget-Befehl

*pathName* **cget** *option*
: Gibt den aktuellen Wert der angegebenen *option* zurück; siehe *ttk::widget(n)*.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Ändert oder fragt Widget-Optionen ab; siehe *ttk::widget(n)*.

*pathName* **identify** *x y*
: Gibt den Namen des Elements an der Position *x*, *y* zurück. Siehe *ttk::widget(n)*.

*pathName* **instate** *statespec* ?*script*?
: Prüft den Widget-Zustand; siehe *ttk::widget(n)*.

*pathName* **start** ?*interval*?
: Startet Auto-Inkrement: periodischer Timer ruft **step** alle *interval* Millisekunden auf. Fehlt *interval*, Standard 50 ms (20 Schritte/s).

*pathName* **state** ?*stateSpec*?
: Ändert oder fragt den Widget-Zustand ab; siehe *ttk::widget(n)*.

*pathName* **step** ?*amount*?
: Erhöht **-value** um *amount*. Fehlt *amount*, Standard 1.0.

*pathName* **stop**
: Stoppt Auto-Inkrement und bricht den von *pathName* **start** gestarteten Timer ab.


# Styling-Optionen

Der Klassenname für ein **ttk::progressbar** ist **TProgressbar**.

**TProgressbar**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können:

**-background** *color*

**-bordercolor** *color*

**-darkcolor** *color*

**-lightcolor** *color*

**-maxphase**
: Für das Aqua-Theme.


**-period**
: Für das Aqua-Theme.


**-troughcolor** *color*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
