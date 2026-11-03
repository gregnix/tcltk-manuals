---
CommandName: toplevel
title: toplevel
ManualSection: n
Version: 8.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - bind(n)
 - bindtags(n)
 - frame(n)
 - wm(n)
Keywords:
 - toplevel
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

toplevel - Erstellt und manipuliert Haupt- und Popup-Fenster vom Typ 'toplevel'

# Übersicht

::: {.synopsis} :::
[toplevel]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Standardoptionen

**-borderwidth**, **-highlightcolor**, **-pady**, **-cursor**, **-highlightthickness**, **-relief**, **-highlightbackground**, **-padx**, **-takefocus**

Siehe die Handbuchseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-background** (**background**/**Background**)
: Diese Option ist identisch mit der Standard-Option **-background**, außer dass ihr Wert auch als leere Zeichenkette angegeben werden kann. In diesem Fall zeigt das Widget keinen Hintergrund oder Rahmen an, und es werden keine Farben aus seiner Farbkarte für Hintergrund und Rahmen verbraucht.

**-class** (**class**/**Class**)
: Legt eine Klasse für das Fenster fest. Diese Klasse wird verwendet, wenn die Optionsdatenbank nach den übrigen Optionen des Fensters abgefragt wird, und sie wird später auch für andere Zwecke wie Bindungen verwendet. Manche Fenstermanager zeigen für Fenster in ihrem Dock den Klassennamen an, andere den Fenstertitel. Die Option **-class** kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-colormap** (**colormap**/**Colormap**)
: Legt eine Farbkarte für das Fenster fest. Der Wert kann entweder **new** sein; dann wird für das Fenster und seine Kinder eine neue Farbkarte erzeugt. Oder er ist der Name eines anderen Fensters (das sich auf demselben Bildschirm befinden und dasselbe Visual wie *pathName* haben muss); dann verwendet das neue Fenster die Farbkarte des angegebenen Fensters. Ist die Option **-colormap** nicht angegeben, verwendet das neue Fenster die Standard-Farbkarte seines Bildschirms. Diese Option kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-container** (**container**/**Container**)
: Der Wert muss ein boolescher Wert sein. Ist er wahr, wird dieses Fenster als Container verwendet, in den eine andere Anwendung eingebettet wird (zum Beispiel kann ein Tk-Toplevel-Fenster mit der Option **-use** eingebettet werden). Das Fenster unterstützt die passenden Fenstermanager-Protokolle, etwa für Geometrieanforderungen. Das Fenster sollte in dieser Anwendung keine eigenen Kinder haben. Diese Option kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-height** (**height**/**Height**)
: Legt die gewünschte Höhe für das Fenster in einer der von [Tk\_GetPixels][GetPixels] akzeptierten Formen fest. Wenn diese Option kleiner oder gleich null ist, fordert das Fenster überhaupt keine Größe an.

**-menu** ([menu]/**Menu**)
: Legt ein Menü-Widget fest, das als Menüleiste verwendet wird. Auf dem Macintosh wird die Menüleiste am oberen Rand des Hauptbildschirms angezeigt. Unter Microsoft Windows und allen UNIX-Plattformen erscheint das Menü quer über dem Toplevel-Fenster als Teil der Fensterdekoration, die der Fenstermanager verwaltet.

**-screen**
: Legt den Bildschirm fest, auf dem das neue Fenster platziert wird. Jeder gültige Bildschirmname kann verwendet werden, auch einer, der zu einem anderen Display gehört. Standardmäßig wird derselbe Bildschirm wie beim Elternfenster verwendet. Diese Option ist insofern besonders, als sie nicht über die Optionsdatenbank angegeben und nicht mit dem Widget-Befehl **configure** geändert werden kann.

**-use** (**use**/**Use**)
: Diese Option dient zum Einbetten. Ist der Wert keine leere Zeichenkette, muss er der Fensterbezeichner eines Container-Fensters sein, angegeben als hexadezimale Zeichenkette, wie sie der Befehl [winfo id][winfo] zurückgibt. Das Toplevel-Widget wird dann als Kind des angegebenen Containers erzeugt statt als Kind des Hauptfensters des Bildschirms. Befindet sich das Container-Fenster in einer Tk-Anwendung, muss es ein Frame- oder Toplevel-Widget sein, für das die Option **-container** angegeben wurde. Diese Option kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-visual** (**visual**/**Visual**)
: Legt Visual-Informationen für das neue Fenster in einer der Formen fest, die [Tk\_GetVisual][GetVisual] akzeptiert. Ist diese Option nicht angegeben, verwendet das neue Fenster das Standard-Visual seines Bildschirms. Die Option **-visual** kann nicht mit dem Widget-Befehl **configure** geändert werden.

**-width** (**width**/**Width**)
: Legt die gewünschte Breite für das Fenster in einer der von [Tk\_GetPixels][GetPixels] akzeptierten Formen fest. Wenn diese Option kleiner oder gleich null ist, fordert das Fenster überhaupt keine Größe an.


# Beschreibung

Der Befehl **toplevel** erzeugt ein neues Toplevel-Widget (durch das Argument *pathName* angegeben). Weitere Optionen, die oben beschrieben sind, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Eigenschaften des Toplevel-Fensters wie Hintergrundfarbe und Relief zu konfigurieren. Der Befehl **toplevel** gibt den Pfadnamen des neuen Fensters zurück.

Ein Toplevel-Fenster ähnelt einem [frame], wird aber als Fenster der obersten Ebene erzeugt: Sein X-Elternfenster ist das Hauptfenster eines Bildschirms und nicht das logische Elternfenster, das sich aus seinem Tk-Pfadnamen ergibt. Ein Toplevel-Fenster dient vor allem als Container für Dialogfenster und andere Gruppen von Widgets. Die einzigen sichtbaren Merkmale eines Toplevel-Fensters sind seine Hintergrundfarbe und ein optionaler 3D-Rahmen, der das Toplevel-Fenster erhaben oder vertieft erscheinen lässt.

# Widget-Befehl

Der Befehl **toplevel** erzeugt einen neuen Tcl-Befehl, dessen Name gleich dem Pfadnamen des Toplevel-Fensters ist. Mit diesem Befehl können verschiedene Operationen auf dem Widget ausgeführt werden. Er hat folgende allgemeine Form:

```
pathName option ?arg arg ...?
```

*PathName* ist der Name des Befehls; er ist gleich dem Pfadnamen des Toplevel-Widgets. *Option* und die Argumente *arg* bestimmen das genaue Verhalten des Befehls. Für Toplevel-Widgets sind folgende Befehle möglich:

*pathName* **cget** *option*
: Gibt den aktuellen Wert der Konfigurationsoption zurück, die durch *option* angegeben ist. *Option* kann jeden Wert haben, den der Befehl **toplevel** akzeptiert.

*pathName* **configure** ?*option*? ?*value option value ...*?
: Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Ist keine *option* angegeben, wird eine Liste zurückgegeben, die alle verfügbaren Optionen für *pathName* beschreibt (das Format dieser Liste ist bei [Tk\_ConfigureInfo][ConfigWidg] beschrieben). Ist *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die eine genannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der ohne Angabe von *option* zurückgegeben wird). Sind ein oder mehrere *option-value*-Paare angegeben, setzt der Befehl die angegebenen Widget-Optionen auf die angegebenen Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Befehl **toplevel** akzeptiert.


# Bindungen

Ein neu erzeugtes Toplevel-Fenster hat keine Standardbindungen für Ereignisse: Toplevel-Fenster sind nicht für Interaktion gedacht.

Beachten Sie, dass Bindungen auf Toplevel-Fenstern Ereignisse von Unter-Widgets erhalten können.


[ConfigWidg]: ../tk-c/ConfigWidg.md
[frame]: frame.md
[GetPixels]: ../tk-c/GetPixels.md
[GetVisual]: ../tk-c/GetVisual.md
[menu]: menu.md
[options]: options.md
[winfo]: winfo.md
