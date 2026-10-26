---
CommandName: labelframe
ManualSection: n
Version: 8.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - frame(n)
 - label(n)
 - ttk::labelframe(n)
Keywords:
 - labelframe
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

labelframe - Erstellt und manipuliert 'labelframe'-beschriftete Container-Widgets

# ÜBERSICHT

::: {.synopsis} :::
[labelframe]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# WIDGET-SPEZIFISCHE OPTIONEN

**-background** (background/Background)
: Diese Option ist identisch mit der Standard-Option **-background**, außer dass ihr Wert auch als leerer String angegeben werden kann. In diesem Fall zeigt das Widget keinen Hintergrund oder Rahmen an, und es werden keine Farben aus seiner Farbkarte für Hintergrund und Rahmen verbraucht.

**-class** (class/Class)
: Legt eine Klasse für das Fenster fest. Diese Klasse wird verwendet, wenn die Optionsdatenbank für die anderen Optionen des Fensters abgefragt wird, und sie wird später auch für andere Zwecke wie Bindings verwendet. Die Option **-class** kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-colormap** (colormap/Colormap)
: Legt eine Farbkarte fest, die für das Fenster verwendet werden soll. Der Wert kann entweder **new** sein, in welchem Fall eine neue Farbkarte für das Fenster und seine Kinder erstellt wird, oder der Name eines anderen Fensters (das auf dem gleichen Bildschirm und mit der gleichen visuellen Darstellung wie *pathName* sein muss), in welchem Fall das neue Fenster die Farbkarte vom angegebenen Fenster verwendet. Wenn die Option **-colormap** nicht angegeben ist, verwendet das neue Fenster die gleiche Farbkarte wie sein Eltern-Element. Diese Option kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-height** (height/Height)
: Legt die gewünschte Höhe für das Fenster in einer der von **Tk_GetPixels** akzeptierten Formen fest. Wenn diese Option negativ oder null ist, fordert das Fenster überhaupt keine Größe an.

**-labelanchor** (labelAnchor/LabelAnchor)
: Legt fest, wo die Beschriftung platziert wird. Eine Beschriftung wird nur angezeigt, wenn die Option **-text** nicht der leere String ist. Gültige Werte für diese Option sind (im Uhrzeigersinn aufgeführt) **nw**, **n**, **ne**, **en**, **e**, **es**, **se**, **s**, **sw**, **ws**, **w** und **wn**. Der Standardwert ist **nw**.

**-labelwidget** (labelWidget/LabelWidget)
: Legt ein Widget fest, das als Beschriftung verwendet wird. Dies überschreibt jede **-text**-Option. Das Widget muss existieren, bevor es als **-labelwidget** verwendet wird, und wenn es kein Nachfahre dieses Fensters ist, wird es in der Stapelreihenfolge darüber angehoben.

**-visual** (visual/Visual)
: Legt visuelle Informationen für das neue Fenster in einer der von **Tk_GetVisual** akzeptierten Formen fest. Wenn diese Option nicht angegeben ist, verwendet das neue Fenster die gleiche visuelle Darstellung wie sein Eltern-Element. Die Option **-visual** kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-width** (width/Width)
: Legt die gewünschte Breite für das Fenster in einer der von **Tk_GetPixels** akzeptierten Formen fest. Wenn diese Option negativ oder null ist, fordert das Fenster überhaupt keine Größe an.


# BESCHREIBUNG

Der Befehl **labelframe** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem labelframe-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des labelframe wie Hintergrundfarbe und Relief zu konfigurieren. Der Befehl **labelframe** gibt den Pfadnamen des neuen Fensters zurück.

Ein labelframe ist ein einfaches Widget. Sein Hauptzweck ist es, als Abstandshalter oder Container für komplexe Fensterlayouts zu dienen. Es hat die Merkmale eines **frame** plus die Fähigkeit, eine Beschriftung anzuzeigen.

# WIDGET-BEFEHL

Der Befehl **labelframe** erstellt einen neuen Tcl-Befehl, dessen Name identisch mit dem Pfadnamen des labelframe-Fensters ist. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName option ?arg ...?
```

*PathName* ist der Name des Befehls, der identisch mit dem Pfadnamen des labelframe-Widgets ist. *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Die folgenden Befehle sind für Frame-Widgets möglich:

*pathName* **cget** *option*
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **labelframe** akzeptierten Werte haben.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe **Tk_ConfigureInfo** für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **labelframe** akzeptierten Werte haben.


# BINDINGS

Wenn ein neues labelframe erstellt wird, hat es keine Standard-Event-Bindings: labelframes sind nicht für Interaktion gedacht.

# BEISPIEL

Dies zeigt, wie ein Teil einer GUI für einen Hamburger-Anbieter aufgebaut wird. Die **labelframe**-Widgets werden verwendet, um die verfügbaren Auswahlmöglichkeiten nach den Arten der Dinge zu gruppieren, über die gewählt wird.

```
grid [labelframe .burger -text "Burger"] \
     [labelframe .bun    -text "Bun"] -sticky news
grid [labelframe .cheese -text "Cheese Option"] \
     [labelframe .pickle -text "Pickle Option"] -sticky news
foreach {type name val} {
    burger Beef    beef
    burger Lamb    lamb
    burger Vegetarian beans

    bun    Plain   white
    bun    Sesame  seeds
    bun    Wholemeal brown

    cheese None    none
    cheese Cheddar cheddar
    cheese Edam    edam
    cheese Brie    brie
    cheese Gruy\u00e8re gruyere
    cheese "Monterey Jack" jack

    pickle None    none
    pickle Gherkins gherkins
    pickle Onions  onion
    pickle Chili   chili
} {
    set w [radiobutton .$type.$val -text $name -anchor w \
            -variable $type -value $val]
    pack $w -side top -fill x
}
set burger beef
set bun    white
set cheese none
set pickle none
```
