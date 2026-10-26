---
CommandName: ttk::panedwindow
title: ttk::panedwindow
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - ttk::notebook(n)
 - panedwindow(n)
Copyright:
 - Copyright (c) 2005 Joe English
---

# Name

ttk::panedwindow - Container-Fenster mit mehreren Bereichen

# Übersicht

::: {.synopsis} :::
[ttk::panedwindow]{.cmd} [pathname]{.arg} [options]{.optarg}
[pathname]{.ins} [add]{.sub} [window]{.arg} [options...]{.optarg}
[pathname]{.ins} [insert]{.sub} [index]{.arg} [window]{.arg} [options...]{.optarg}
:::

# Beschreibung

Ein **ttk::panedwindow**-Widget zeigt eine Anzahl von Unterfenstern an, entweder vertikal oder horizontal gestapelt. Der Benutzer kann die relativen Größen der Unterfenster anpassen, indem er den Sash zwischen den Bereichen zieht.

# Standardoptionen

**-class**, **-cursor**, **-takefocus**, **-style**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-orient** (**orient**/**Orient**)
: Legt die Ausrichtung des Fensters fest. Bei **vertical** werden Unterbereiche von oben nach unten gestapelt; bei **horizontal** von links nach rechts.

**-width** (**width**/**Width**)
: Wenn vorhanden und größer als null, legt die gewünschte Breite des Widgets in Pixeln fest. Andernfalls wird die angeforderte Breite durch die Breite der verwalteten Fenster bestimmt.

**-height** (**height**/**Height**)
: Wenn vorhanden und größer als null, legt die gewünschte Höhe des Widgets in Pixeln fest. Andernfalls wird die angeforderte Höhe durch die Höhe der verwalteten Fenster bestimmt.


# Bereichsoptionen

Die folgenden Optionen können für jeden Bereich angegeben werden:

**-weight** (**weight**/**Weight**)
: Eine ganze Zahl, die die relative Dehnbarkeit des Bereichs angibt. Wenn das Paned-Window in der Größe geändert wird, wird der zusätzliche Platz jedem Bereich proportional zu seinem **-weight** hinzugefügt oder entzogen.


# Widget-Befehl

Unterstützt die Standardbefehle **configure**, **cget**, **state** und **instate**; siehe *ttk::widget(n)* für Details. Zusätzliche Befehle:

*pathname* **add** *subwindow options...*
: Fügt dem Fenster einen neuen Bereich hinzu. Siehe [Bereichsoptionen] für die Liste der verfügbaren Optionen.

*pathname* **forget** *pane*
: Entfernt den angegebenen Unterbereich aus dem Widget. *pane* ist entweder ein ganzzahliger Index oder der Name eines verwalteten Unterfensters.

*pathname* **identify** *component x y*
: Gibt den Namen des Elements unter dem Punkt *x* und *y* zurück oder den leeren String, wenn an dieser Position kein Element vorhanden ist. Wenn *component* weggelassen wird, ist der Standardwert **sash**. Folgende Unterbefehle werden unterstützt:

    *pathname* **identify element** *x y*
    : Gibt den Namen des Elements an der angegebenen Position zurück.

    *pathname* **identify sash** *x y*
    : Gibt den Index des Sash an der angegebenen Position zurück.


*pathname* **insert** *pos subwindow options...*
: Fügt einen Bereich an der angegebenen Position ein. *pos* ist entweder der String **end**, ein ganzzahliger Index oder der Name eines verwalteten Unterfensters. Wenn *subwindow* bereits vom Paned-Window verwaltet wird, wird es an die angegebene Position verschoben. Siehe [Bereichsoptionen] für die Liste der verfügbaren Optionen.

*pathname* **pane** *pane -option* ?*value* ?*-option value...*
: Fragt die Optionen des angegebenen *pane* ab oder ändert sie, wobei *pane* entweder ein ganzzahliger Index oder der Name eines verwalteten Unterfensters ist. Wenn keine *-option* angegeben ist, gibt ein Dictionary der Bereichs-Optionswerte zurück. Ist eine *-option* angegeben, gibt der Wert dieser *option* zurück. Andernfalls werden die *-option*en auf die entsprechenden *value*s gesetzt.

*pathname* **panes**
: Gibt die Liste aller vom Widget verwalteten Fenster in der Indexreihenfolge ihrer zugehörigen Bereiche zurück.

*pathname* **sashpos** *index* ?*newpos*?
: Wenn *newpos* angegeben ist, setzt die Position des Sash mit der Nummer *index*. Kann die Positionen benachbarter Sashes anpassen, damit die Positionen monoton steigend bleiben. Sash-Positionen sind außerdem auf den Bereich zwischen 0 und der Gesamtgröße des Widgets beschränkt. Gibt die neue Position des Sash mit der Nummer *index* zurück.


Das Panedwindow-Widget unterstützt außerdem die folgenden generischen [ttk::widget][ttk_widget]-Unterbefehle (siehe *ttk::widget(n)* für Details):

::: {.info DISPLAY="yes"}
**cget**	**configure**\
**instate**	**state**
:::

# Virtuelle Ereignisse

Das Panedwindow-Widget erzeugt bei LeaveNotify/NotifyInferior-Ereignissen ein virtuelles Ereignis **<<EnteredChild>>**.

# Styling-Optionen

Der Klassenname für ein **ttk::panedwindow** ist **TPanedwindow**. Der Sash hat den Klassennamen **Sash**.

**TPanedwindow**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können, sind:

**-background** *color*

**Sash**-Styling-Optionen, die mit [ttk::style][ttk_style] konfiguriert werden können, sind:

**-background** *color*

**-bordercolor** *color*

**-gripcount** *count*

**-handlepad** *amount*

**-handlesize** *amount*

**-lightcolor** *color*

**-sashpad** *amount*

**-sashrelief** *relief*

**-sashthickness** *amount*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
