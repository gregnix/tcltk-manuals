---
CommandName: ttk::scrollbar
title: ttk::scrollbar
ManualSection: n
Version: 8.5
TclPart: Tk
TclDescription: Tk Themed Widget
Links:
 - ttk::widget(n)
 - scrollbar(n)
Keywords:
 - scrollbar
 - widget
Copyright:
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2004 Joe English
---

# Name

ttk::scrollbar - Steuert den Viewport eines scrollbaren Widgets

# Übersicht

::: {.synopsis} :::
[ttk::scrollbar]{.cmd} [pathName]{.arg} [options...]{.optarg}
:::

# Beschreibung

**ttk::scrollbar**-Widgets sind typischerweise mit einem zugehörigen Fenster verknüpft, das ein Dokument anzeigt, etwa eine bearbeitete Datei oder eine Zeichnung. Eine Scrollbar zeigt einen *Thumb* im mittleren Bereich an, dessen Position und Größe Auskunft über den im zugehörigen Fenster sichtbaren Dokumentanteil geben. Der Benutzer kann den Thumb ziehen, um den sichtbaren Bereich zu steuern. Je nach Theme können zwei oder mehr Pfeilbuttons vorhanden sein; diese dienen zum Scrollen des sichtbaren Bereichs in diskreten Einheiten. Standardoptionen (siehe **ttk\_widget**): **-class**, **-cursor**, **-style**, **-takefocus**.

# Standardoptionen

**-class**, **-cursor**, **-style**, **-takefocus**

Siehe die Handbuchseite [ttk\_widget][ttk_widget] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-command** (**command**/**Command**)
: Ein Tcl-Skript-Präfix, das ausgewertet wird, um die Ansicht im mit der Scrollbar verknüpften Widget zu ändern. Zusätzliche Argumente werden an den Wert dieser Option angehängt, wie in [Scroll-Befehle] unten beschrieben, wann immer der Benutzer durch Manipulation der Scrollbar eine Ansichtsänderung anfordert.

    Diese Option besteht typischerweise aus einer Liste mit zwei Elementen: dem Namen eines scrollbaren Widgets, gefolgt von entweder **xview** (für horizontale Scrollbars) oder **yview** (für vertikale Scrollbars).

**-orient** (**orient**/**Orient**)
: Einer von **horizontal** oder **vertical**. Legt die Ausrichtung der Scrollbar fest.


# Widget-Befehl

Zusätzlich zu den Standardbefehlen **cget**, **configure**, **identify element**, **instate**, **state** und **style** (siehe [ttk::widget][ttk_widget]) unterstützen Scrollbar-Widgets folgende zusätzliche Befehle:

[pathName]{.ins} [get]{.sub}
: Gibt die Scrollbar-Einstellungen in Form einer Liste zurück, deren Elemente die Argumente des zuletzt ausgeführten Widget-Befehls **set** sind.

[pathName]{.ins} [set]{.sub} [first]{.arg} [last]{.arg}
: Dieser Befehl wird normalerweise vom mit der Scrollbar verknüpften Widget aus einem **-xscrollcommand**- oder **-yscrollcommand**-Callback aufgerufen. Legt den anzuzeigenden sichtbaren Bereich fest. *first* und *last* sind reelle Bruchteile zwischen 0 und 1.


# Interne Befehle

Die folgenden Widget-Befehle werden intern von den Bindungen der Widget-Klasse **TScrollbar** verwendet.

[pathName]{.ins} [delta]{.sub} [deltaX]{.arg} [deltaY]{.arg}
: Gibt eine reelle Zahl zurück, die die fraktionale Änderung der Scrollbar-Einstellung angibt, die einer gegebenen Änderung der Thumb-Position entspricht. Ist die Scrollbar horizontal, gibt das Ergebnis an, um wie viel sich die Scrollbar-Einstellung ändern muss, um den Thumb *deltaX* Pixel nach rechts zu bewegen (*deltaY* wird in diesem Fall ignoriert). Ist die Scrollbar vertikal, gibt das Ergebnis an, um wie viel sich die Einstellung ändern muss, um den Thumb *deltaY* Pixel nach unten zu bewegen. Die Argumente und das Ergebnis können null oder negativ sein.

[pathName]{.ins} [fraction]{.sub} [x]{.arg} [y]{.arg}
: Gibt eine reelle Zahl zwischen 0 und 1 zurück, die angibt, wo der durch *x* und *y* gegebene Punkt im Trough-Bereich der Scrollbar liegt, wobei 0.0 dem oberen oder linken Rand des Troughs und 1.0 dem unteren oder rechten Rand entspricht. *X* und *y* sind Pixelkoordinaten relativ zum Scrollbar-Widget. Liegen *x* und *y* außerhalb des Troughs, wird der nächstgelegene Punkt im Trough verwendet.


# Scroll-Befehle

Wenn der Benutzer mit der Scrollbar interagiert, etwa durch Ziehen des Thumbs, benachrichtigt die Scrollbar das zugehörige Widget, dass es seine Ansicht ändern muss. Die Scrollbar erfolgt dies durch Auswertung eines Tcl-Befehls, der aus der **-command**-Option der Scrollbar erzeugt wird. Der Befehl kann eine der folgenden Formen annehmen. In jedem Fall ist *prefix* der Inhalt der **-command**-Option, der üblicherweise die Form **.t yview** hat

*prefix* **moveto** *fraction*
: *Fraction* ist eine reelle Zahl zwischen 0 und 1. Das Widget soll seine Ansicht so anpassen, dass der durch *fraction* angegebene Punkt am Anfang des Widgets erscheint. Ist *fraction* 0, bezeichnet dies den Anfang des Dokuments. 1.0 bezeichnet das Ende, 0.333 einen Punkt ein Drittel durch das Dokument usw.

*prefix* **scroll** *number* **pages**
: Das Widget soll seine Ansicht um *number* Seiten anpassen. Die Bedeutung einer Seite legt das Widget fest; typischerweise ist sie etwas kleiner als der sichtbare Fensterinhalt, sodass alte und neue Ansicht leicht überlappen. *Number* ist entweder 1 (nächste Seite sichtbar) oder -1 (vorherige Seite sichtbar).

*prefix* **scroll** *number* **units**
: Das Widget soll seine Ansicht um *number* Einheiten anpassen. Die Einheiten sind widget-spezifisch definiert, etwa Zeichen oder Zeilen in einem Text-Widget. *Number* ist entweder 1 (eine Einheit scrollt oben oder links aus dem Fenster) oder -1 (eine Einheit scrollt unten oder rechts aus dem Fenster).


# Widget-Zustände

Die Scrollbar setzt automatisch das Zustandsbit **disabled**, wenn der gesamte Bereich sichtbar ist (Bereich 0.0 bis 1.0), und löscht es andernfalls. Sie setzt außerdem die Zustandsflags **active** und **pressed** einzelner Elemente basierend auf Position und Zustand des Mauszeigers.

# Beispiel

```
set f [frame .f]
ttk::scrollbar $f.hsb -orient horizontal -command [list $f.t xview]
ttk::scrollbar $f.vsb -orient vertical -command [list $f.t yview]
text $f.t -xscrollcommand [list $f.hsb set] -yscrollcommand [list $f.vsb set]
grid $f.t -row 0 -column 0 -sticky nsew
grid $f.vsb -row 0 -column 1 -sticky nsew
grid $f.hsb -row 1 -column 0 -sticky nsew
grid columnconfigure $f 0 -weight 1
grid rowconfigure $f 0 -weight 1
pack $f
```

# Styling-Optionen

Der Klassenname für eine **ttk::scrollbar** ist **TScrollbar**.

Dynamische Zustände: **active**, **disabled**.

**TScrollbar**-Styling-Optionen (genauer **Vertical.TScrollbar** und **Horizontal.TScrollbar**), die mit [ttk::style][ttk_style] konfiguriert werden können, sind:

**-arrowcolor** *color*

**-arrowsize** *amount*

**-background** *color*

**-bordercolor** *color*

**-darkcolor** *color* (Farbe des dunklen Teils des 3D-Reliefs)

**-foreground** *color*

**-gripsize** *size* (Anzahl Bildschirmeinheiten)

**-lightcolor** *color* (Farbe des hellen Teils des 3D-Reliefs)

**-troughcolor** *color*

Einige Optionen sind nur für bestimmte Themes verfügbar.

Siehe die Handbuch-Seite [ttk::style][ttk_style] für Informationen zur Konfiguration von ttk-Stilen.


[ttk_style]: ttk_style.md
[ttk_widget]: ttk_widget.md
