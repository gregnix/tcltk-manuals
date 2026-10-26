---
CommandName: ttk::combobox
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - ttk::entry(n)
Keywords:
 - choice
 - entry
 - list box
 - text box
 - widget
Copyright:
 - Copyright (c) 2004 Joe English
---

# NAME

ttk::combobox - Textfeld mit ausklappbarer Auswahlliste

# ÜBERSICHT

::: {.synopsis} :::
[ttk::combobox]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# BESCHREIBUNG

Ein **ttk::combobox** kombiniert ein Textfeld mit einer ausklappbaren Liste von Werten; der Benutzer kann den Wert des Textfelds aus den Einträgen der Liste wählen. Standardoptionen (siehe **ttk_widget**): **-class**, **-cursor**, **-takefocus**, **-style**.

# WIDGET-SPEZIFISCHE OPTIONEN

**-exportselection** (exportSelection/ExportSelection)
: Boolescher Wert. Ist er gesetzt, ist die Widget-Auswahl mit der X-Auswahl verknüpft.

**-justify** (justify/Justify)
: Legt fest, wie der Text im Widget ausgerichtet ist. Muss einer von **left**, **center** oder **right** sein.

**-height** (height/Height)
: Legt die Höhe der ausklappbaren Listbox in Zeilen fest.

**-postcommand** (postCommand/PostCommand)
: Tcl-Skript, das unmittelbar vor dem Anzeigen der Listbox ausgewertet wird. Das Skript **-postcommand** kann die anzuzeigenden **-values** festlegen.

**-state** (state/State)
: Einer von **normal**, **readonly** oder **disabled**. Im Zustand **readonly** kann der Wert nicht direkt bearbeitet werden; der Benutzer kann nur einen der **-values** aus der Dropdown-Liste wählen. Im Zustand **normal** ist das Textfeld direkt editierbar. Im Zustand **disabled** ist keine Interaktion möglich.

**-textvariable** (textVariable/TextVariable)
: Name einer globalen Variable, deren Wert mit dem Widget-Wert verknüpft ist. Ändert sich die Variable, wird der Widget-Wert aktualisiert und umgekehrt.

**-values** (values/Values)
: Liste der in der Dropdown-Listbox anzuzeigenden Werte.

**-width** (width/Width)
: Ganzzahl für die gewünschte Breite des Eingabefensters in Zeichen durchschnittlicher Größe der Widget-Schriftart.


# WIDGET-BEFEHL

Für Combobox-Widgets sind folgende Unterbefehle möglich:

*pathName* **current** ?*newIndex*?
: Wird *newIndex* angegeben, setzt der Befehl den Combobox-Wert auf das Element an Position *newIndex* in der Liste **-values** (neben Ganzzahlen wird der Index **end** unterstützt und bezeichnet das letzte Element der Liste). Andernfalls gibt er den Index des aktuellen Werts in der Liste **-values** zurück oder **-1**, wenn der aktuelle Wert nicht in der Liste vorkommt.

*pathName* **get**
: Gibt den aktuellen Wert der Combobox zurück.

*pathName* **set** *value*
: Setzt den Wert der Combobox auf *value*.


Die Combobox unterstützt außerdem folgende Unterbefehle des **ttk::entry**-Widgets (Details siehe *ttk::entry(n)*):

```
bbox            delete          icursor
index           insert          selection
xview
```

Die Combobox unterstützt außerdem folgende generische Unterbefehle des **ttk::widget**-Widgets (Details siehe *ttk::widget(n)*):

```
cget            configure       identify
instate         state
```

# VIRTUELLE EREIGNISSE

Die Combobox erzeugt ein virtuelles Ereignis **<\<ComboboxSelected>>**, wenn der Benutzer ein Element aus der Werteliste wählt. Schließt die Auswahlaktion die Listbox, wird dieses Ereignis nach dem Schließen der Listbox ausgeliefert.

# STYLING-OPTIONEN

Der Klassenname für ein **ttk::combobox** ist **TCombobox**. **ttk::combobox** verwendet intern die Widgets **entry** und **listbox**. Der Listbox-Rahmen hat den Klassennamen **ComboboxPopdownFrame**.

Dynamische Zustände: **disabled**, **focus**, **pressed**, **readonly**.

**TCombobox**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können, sind:

**-arrowcolor** *color* .br **-arrowsize** *amount* .br **-background** *color* .br **-bordercolor** *color* .br **-darkcolor** *color* .br **-focusfill** *color* .br **-foreground** *color* .br **-fieldbackground** *color* Kann nur bei nicht-nativen und nicht-grafischen Themes geändert werden. **-insertcolor** *color* .br **-insertwidth** *amount* .br **-lightcolor** *color* .br **-padding** *padding* .br **-postoffset** *padding* .br **-selectbackground** *color* Hintergrund der Textauswahl. **-selectforeground** *color* Vordergrund der Textauswahl.

Die ausklappbare Listbox von **ttk::combobox** lässt sich weder mit **ttk::style** noch über den Widget-Befehl **configure** konfigurieren. Die Listbox kann über die Optionsdatenbank konfiguriert werden.

option add *TCombobox*Listbox.background *color* .br option add *TCombobox*Listbox.font *font* .br option add *TCombobox*Listbox.foreground *color* .br option add *TCombobox*Listbox.selectBackground *color* .br option add *TCombobox*Listbox.selectForeground *color*

Zum Konfigurieren einer bestimmten Listbox (kann sich künftig ändern):

```
set popdown [ttk::combobox::PopdownWindow .mycombobox]
$popdown.f.l configure \-font font
```

**ComboboxPopdownFrame**-Styling-Optionen, die mit **ttk::style** konfiguriert werden können, sind:

**-borderwidth** *amount* .br **-relief** *relief*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite **ttk::style** für Informationen zur Konfiguration von ttk-Stilen.

