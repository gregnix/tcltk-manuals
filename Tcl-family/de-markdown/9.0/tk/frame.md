---
CommandName: frame
title: frame
ManualSection: n
Version: 8.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - labelframe(n)
 - toplevel(n)
 - ttk::frame(n)
Keywords:
 - frame
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

frame - Erstellt und manipuliert 'Frame'-Container-Widgets

# Übersicht

::: {.synopsis} :::
[frame]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Standardoptionen

**-borderwidth**, **-highlightcolor**, **-pady**, **-cursor**, **-highlightthickness**, **-relief**, **-highlightbackground**, **-padx**, **-takefocus**

Siehe die Handbuchseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-background** (**background**/**Background**)
: Diese Option ist identisch mit der Standard-Option **-background**, außer dass ihr Wert auch als leerer String angegeben werden kann. In diesem Fall zeigt das Widget keinen Hintergrund oder Rahmen an, und es werden keine Farben aus seiner Farbkarte für Hintergrund und Rahmen verbraucht. [Ein leerer Hintergrund deaktiviert das Zeichnen des Hintergrundbildes.]{version="9.0, TIP262"}

[**-backgroundimage** (**backgroundImage**/**BackgroundImage**)]{version="9.0, TIP262"}
: [Dies gibt ein Bild an, das im Hintergrund des Frames innerhalb des Rahmens angezeigt werden soll (d.h. das Bild wird durch den Hervorhebungsring und den Rahmen des Frames abgeschnitten, falls vorhanden); Unter-Widgets des Frames werden darüber gezeichnet. Das Bild muss mit dem Befehl [image create][image] erstellt worden sein. Wenn als leerer String angegeben, wird kein Bild angezeigt.]{version="9.0, TIP262"}

**-class** (**class**/**Class**)
: Legt eine Klasse für das Fenster fest. Diese Klasse wird verwendet, wenn die Optionsdatenbank für die anderen Optionen des Fensters abgefragt wird, und sie wird später auch für andere Zwecke wie Bindings verwendet. Die Option **-class** kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-colormap** (**colormap**/**Colormap**)
: Legt eine Farbkarte fest, die für das Fenster verwendet werden soll. Der Wert kann entweder **new** sein, in welchem Fall eine neue Farbkarte für das Fenster und seine Kinder erstellt wird, oder der Name eines anderen Fensters (das auf dem gleichen Bildschirm und mit der gleichen visuellen Darstellung wie *pathName* sein muss), in welchem Fall das neue Fenster die Farbkarte vom angegebenen Fenster verwendet. Wenn die Option **-colormap** nicht angegeben ist, verwendet das neue Fenster die gleiche Farbkarte wie sein Eltern-Element. Diese Option kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-container** (**container**/**Container**)
: Der Wert muss ein Boolean sein. Wenn wahr, bedeutet dies, dass dieses Fenster als Container verwendet wird, in dem eine andere Anwendung eingebettet wird (zum Beispiel kann ein Tk-Toplevel mit der Option **-use** eingebettet werden). Das Fenster unterstützt die entsprechenden Window-Manager-Protokolle für Dinge wie Geometrieanforderungen. Das Fenster sollte in dieser Anwendung keine eigenen Kinder haben. Diese Option kann nicht mit dem Widget-Befehl **configure** geändert werden. Beachten Sie, dass **-borderwidth**, **-padx** und **-pady** ignoriert werden, wenn als Container konfiguriert, da ein Container keinen Rahmen hat.

**-height** (**height**/**Height**)
: Legt die gewünschte Höhe für das Fenster in einer der von [Tk\_GetPixels][GetPixels] akzeptierten Formen fest. Wenn diese Option negativ oder null ist, fordert das Fenster überhaupt keine Größe an. Beachten Sie, dass dies die Gesamthöhe des Frames festlegt, **-borderwidth** oder ähnliches wird nicht hinzugefügt. Normalerweise sollte **-height** nicht verwendet werden, wenn ein propagierender Geometrie-Manager wie [grid] oder [pack] innerhalb des Frames verwendet wird, da der Geometrie-Manager die Höhe des Frames überschreibt.

**-tile** (**tile**/**Tile**)
: [Dies legt fest, wie das Hintergrundbild (siehe **-backgroundimage**) auf dem Frame gezeichnet wird. Wenn wahr (gemäß [Tcl\_GetBoolean][GetInt]), wird das Bild gekachelt, um den gesamten Frame zu füllen, wobei der Ursprung der ersten Kopie des Bildes die obere linke Ecke des Innenraums des Frames ist. Wenn falsch (Standard), wird das Bild innerhalb des Frames zentriert.]{version="9.0, TIP262"}

**-visual** (**visual**/**Visual**)
: Legt visuelle Informationen für das neue Fenster in einer der von [Tk\_GetVisual][GetVisual] akzeptierten Formen fest. Wenn diese Option nicht angegeben ist, verwendet das neue Fenster die gleiche visuelle Darstellung wie sein Eltern-Element. Die Option **-visual** kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-width** (**width**/**Width**)
: Legt die gewünschte Breite für das Fenster in einer der von [Tk\_GetPixels][GetPixels] akzeptierten Formen fest. Wenn diese Option negativ oder null ist, fordert das Fenster überhaupt keine Größe an. Beachten Sie, dass dies die Gesamtbreite des Frames festlegt, **-borderwidth** oder ähnliches wird nicht hinzugefügt. Normalerweise sollte **-width** nicht verwendet werden, wenn ein propagierender Geometrie-Manager wie [grid] oder [pack] innerhalb des Frames verwendet wird, da der Geometrie-Manager die Breite des Frames überschreibt.


# Beschreibung

Der Befehl **frame** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Frame-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des Frames wie Hintergrundfarbe und Relief zu konfigurieren. Der Befehl **frame** gibt den Pfadnamen des neuen Fensters zurück.

Ein Frame ist ein einfaches Widget. Sein Hauptzweck ist es, als Abstandshalter oder Container für komplexe Fensterlayouts zu dienen. Die einzigen Merkmale eines Frames sind sein Hintergrund und ein optionaler 3-D-Rahmen, um den Frame erhaben oder eingesenkt erscheinen zu lassen.

# Widget-Befehl

Der Befehl **frame** erstellt einen neuen Tcl-Befehl, dessen Name identisch mit dem Pfadnamen des Frame-Fensters ist. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName option ?arg ...?
```

*PathName* ist der Name des Befehls, der identisch mit dem Pfadnamen des Frame-Widgets ist. *Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Die folgenden Befehle sind für Frame-Widgets möglich:

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **frame** akzeptierten Werte haben.

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe [Tk\_ConfigureInfo][ConfigWidg] für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **frame** akzeptierten Werte haben.


# Bindings

Wenn ein neuer Frame erstellt wird, hat er keine Standard-Event-Bindings: Frames sind nicht für Interaktion gedacht.


[ConfigWidg]: ../tk-c/ConfigWidg.md
[GetInt]: ../tcl-c/GetInt.md
[GetPixels]: ../tk-c/GetPixels.md
[GetVisual]: ../tk-c/GetVisual.md
[grid]: grid.md
[image]: image.md
[options]: options.md
[pack]: pack.md
