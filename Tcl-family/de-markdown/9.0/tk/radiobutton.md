---
CommandName: radiobutton
title: radiobutton
ManualSection: n
Version: 4.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - checkbutton(n)
 - labelframe(n)
 - listbox(n)
 - options(n)
 - scale(n)
 - ttk::radiobutton(n)
Keywords:
 - radiobutton
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

radiobutton - Erstellt und manipuliert 'Radiobutton'-Widgets für Einzelauswahl

# Übersicht

::: {.synopsis} :::
[radiobutton]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Standardoptionen

**-activebackground**, **-disabledforeground**, **-padx**, **-activeforeground**, **-font**, **-pady**, **-anchor**, **-foreground**, **-relief**, **-background**, **-highlightbackground**, **-takefocus**, **-bitmap**, **-highlightcolor**, **-text**, **-borderwidth**, **-highlightthickness**, **-textvariable**, **-compound**, **-image**, **-underline**, **-cursor**, **-justify**, **-wraplength**

Siehe die Handbuchseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-command** (**command**/**Command**)
: Legt einen Tcl-Befehl fest, der mit dem Button verknüpft wird. Dieser Befehl wird typischerweise aufgerufen, wenn Maustaste 1 über dem Button-Fenster losgelassen wird. Die globale Variable des Buttons (Option **-variable**) wird vor dem Aufruf des Befehls aktualisiert.

**-height** (**height**/**Height**)
: Legt eine gewünschte Höhe für den Button fest. Wenn ein Bild oder Bitmap im Button angezeigt wird, ist der Wert in Bildschirmeinheiten (d.h. alle von [Tk\_GetPixels][GetPixels] akzeptierten Formen); für Text ist es in Textzeilen. Wenn diese Option nicht angegeben ist, wird die gewünschte Höhe des Buttons aus der Größe des angezeigten Bildes, Bitmaps oder Textes berechnet.

**-indicatoron** (**indicatorOn**/**IndicatorOn**)
: Legt fest, ob der Indikator gezeichnet werden soll. Muss ein gültiger boolescher Wert sein. Wenn false, wird die Option **-relief** ignoriert und das Relief des Widgets ist stets eingesenkt, wenn das Widget ausgewählt ist, und sonst erhaben.

**-offrelief** (**offRelief**/**OffRelief**)
: Legt das Relief für den Radiobutton fest, wenn der Indikator nicht gezeichnet wird und der Radiobutton abgewählt ist. Der Standardwert ist „raised“. Durch Setzen dieser Option auf „flat“ und **-indicatoron** auf false sowie **-overrelief** auf „raised“ entsteht ein flacher Button, der bei Maus-Over erhaben wird und beim Aktivieren eingedrückt ist. Dies ist typisches Verhalten der Links-ausrichten-, Rechts-ausrichten- und Zentrieren-Radiobuttons in der Symbolleiste einer Textverarbeitung.

**-overrelief** (**overRelief**/**OverRelief**)
: Legt ein alternatives Relief für den Radiobutton fest, das verwendet wird, wenn der Mauszeiger über dem Widget ist. Diese Option kann verwendet werden, um Toolbar-Buttons zu erstellen, indem **-relief flat -overrelief raised** konfiguriert wird. Wenn der Wert dieser Option der leere String ist, wird kein alternatives Relief verwendet, wenn der Mauszeiger über dem Radiobutton ist. Der leere String ist der Standardwert.

**-selectcolor** (**selectColor**/**Background**)
: Legt eine Hintergrundfarbe fest, die verwendet wird, wenn der Button ausgewählt ist. Wenn **indicatorOn** true ist, wird die Farbe als Hintergrund für den Indikator verwendet, unabhängig vom Auswahlzustand. Wenn **-indicatoron** false ist, wird diese Farbe als Hintergrund für das gesamte Widget anstelle von **-background** oder **-activeBackground** verwendet, sobald das Widget ausgewählt ist. Wenn als leerer String angegeben, wird keine besondere Farbe für die Anzeige im ausgewählten Zustand verwendet.

**-selectimage** (**selectImage**/**SelectImage**)
: Legt ein Bild fest, das (anstelle der Option **-image**) angezeigt wird, wenn der Radiobutton ausgewählt ist. Diese Option wird ignoriert, sofern die Option **-image** nicht angegeben wurde.

**-state** (**state**/**State**)
: Legt einen von drei Zuständen für den Radiobutton fest: **normal**, **active** oder **disabled**. Im normalen Zustand wird der Radiobutton mit den Optionen **-foreground** und **-background** angezeigt. Der aktive Zustand wird typischerweise verwendet, wenn der Zeiger über dem Radiobutton ist. Im aktiven Zustand wird der Radiobutton mit den Optionen **-activeforeground** und **-activebackground** angezeigt. Der deaktivierte Zustand bedeutet, dass der Radiobutton unempfindlich sein sollte: Die Standard-Bindings weigern sich, das Widget zu aktivieren und ignorieren Mausklicks. In diesem Zustand bestimmen die Optionen **-disabledforeground** und **-background**, wie der Radiobutton angezeigt wird.

**-tristateimage** (**tristateImage**/**TristateImage**)
: Legt ein Bild fest, das (anstelle der Option **-image**) angezeigt wird, wenn der Radiobutton ausgewählt ist. Diese Option wird ignoriert, sofern die Option **-image** nicht angegeben wurde.

**-tristatevalue** (**tristateValue**/**Value**)
: Legt den Wert fest, der bewirkt, dass der Radiobutton die Mehrfachauswahl anzeigt, auch bekannt als Drei-Zustand-Modus. Standardwert ist „“.

**-value** (**value**/**Value**)
: Legt den Wert fest, der in der zugehörigen Variable des Buttons gespeichert wird, wenn dieser Button ausgewählt wird.

**-variable** ([variable]/**Variable**)
: Gibt den Namen einer globalen Variable an, die gesetzt wird, wenn dieser Button ausgewählt wird. Änderungen an dieser Variable bewirken auch, dass der Button sich selbst aus- bzw. abwählt. Standardwert ist **selectedButton**.

**-width** (**width**/**Width**)
: Legt eine gewünschte Breite für den Button fest. Wenn ein Bild oder Bitmap im Button angezeigt wird, ist der Wert in Bildschirmeinheiten (d.h. alle von [Tk\_GetPixels][GetPixels] akzeptierten Formen); für Text ist es in Zeichen. Wenn diese Option nicht angegeben ist, wird die gewünschte Breite des Buttons aus der Größe des angezeigten Bildes, Bitmaps oder Textes berechnet.


# Beschreibung

Der Befehl **radiobutton** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Radiobutton-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des Radiobuttons wie Farben, Schriftart, Text und anfängliches Relief zu konfigurieren. Der Befehl **radiobutton** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen *pathName* existieren, aber das Eltern-Element von *pathName* muss existieren.

Ein Radiobutton ist ein Widget, das einen Text-String, ein Bitmap oder ein Bild sowie eine Raute oder einen Kreis namens *Indikator* anzeigt. Wenn Text angezeigt wird, muss er in einer einzigen Schriftart sein, kann aber mehrere Zeilen auf dem Bildschirm einnehmen (wenn er Zeilenumbrüche enthält oder wenn ein Umbruch wegen der Option **-wraplength** erfolgt), und eines der Zeichen kann optional mit der Option **-underline** unterstrichen werden. Ein Radiobutton hat das gesamte Verhalten eines einfachen Buttons: Er kann sich je nach Option **-state** auf drei verschiedene Arten darstellen; er kann erhaben, eingesenkt oder flach dargestellt werden; er kann blinken; und er ruft einen Tcl-Befehl auf, wenn Maustaste 1 über dem Radiobutton geklickt wird.

Darüber hinaus können Radiobuttons *ausgewählt* werden. Wenn ein Radiobutton ausgewählt ist, wird der Indikator normalerweise mit ausgewähltem Erscheinungsbild gezeichnet, und eine mit dem Radiobutton verknüpfte Tcl-Variable wird auf einen bestimmten Wert gesetzt (normalerweise 1). Unter Unix wird der Indikator mit eingesenktem Relief und einer besonderen Farbe gezeichnet. Unter Windows wird der Indikator mit einem runden Markierungspunkt im Inneren gezeichnet. Wenn der Radiobutton nicht ausgewählt ist, wird der Indikator mit nicht ausgewähltem Erscheinungsbild gezeichnet, und die zugehörige Variable wird auf einen anderen Wert gesetzt (typischerweise 0). Der Indikator wird ohne runden Markierungspunkt im Inneren gezeichnet. Typischerweise teilen sich mehrere Radiobuttons eine einzelne Variable, und der Wert der Variable gibt an, welcher Radiobutton ausgewählt werden soll. Wenn ein Radiobutton ausgewählt wird, setzt er den Wert der Variable, um dies anzuzeigen; jeder Radiobutton überwacht auch den Wert der Variable und wählt sich automatisch ab bzw. an, wenn sich der Wert der Variable ändert. Wenn der Wert der Variable mit **-tristatevalue** übereinstimmt, wird der Radiobutton im Drei-Zustand-Modus gezeichnet. Dieser Modus wird verwendet, um gemischte oder mehrere Werte anzuzeigen. (Dies wird verwendet, wenn der Radiobutton den Zustand mehrerer Elemente repräsentiert.) Standardmäßig wird die Variable **selectedButton** verwendet; ihr Inhalt gibt den Namen des ausgewählten Buttons an oder den leeren String, wenn kein mit dieser Variable verknüpfter Button ausgewählt ist. Der Name der Variable für einen Radiobutton sowie die darin zu speichernde Variable können mit Optionen in der Befehlszeile oder in der Optionsdatenbank geändert werden. Konfigurationsoptionen können auch verwendet werden, um die Art der Indikatoranzeige zu ändern (oder ob er überhaupt angezeigt wird). Standardmäßig ist ein Radiobutton so konfiguriert, dass er sich bei Button-Klicks selbst auswählt.

# Widget-Befehl

Der Befehl **radiobutton** erstellt einen neuen Tcl-Befehl, dessen Name *pathName* ist. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName option ?arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Die folgenden Befehle sind für Radiobutton-Widgets möglich:

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **radiobutton** akzeptierten Werte haben.

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe [Tk\_ConfigureInfo][ConfigWidg] für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **radiobutton** akzeptierten Werte haben.

[pathName]{.ins} [deselect]{.sub}
: Wählt den Radiobutton ab und setzt die zugehörige Variable auf einen leeren String. Wenn dieser Radiobutton derzeit nicht ausgewählt war, hat der Befehl keine Wirkung.

[pathName]{.ins} [flash]{.sub}
: Lässt den Radiobutton blinken. Dies wird erreicht, indem der Radiobutton mehrmals neu angezeigt wird und dabei zwischen aktiven und normalen Farben gewechselt wird. Am Ende des Blinkens bleibt der Radiobutton im gleichen normal/aktiven Zustand wie beim Aufruf des Befehls. Dieser Befehl wird ignoriert, wenn der Zustand des Radiobuttons **disabled** ist.

[pathName]{.ins} [invoke]{.sub}
: Bewirkt genau das, was passiert wäre, wenn der Benutzer den Radiobutton mit der Maus aufgerufen hätte: wählt den Button aus und ruft den mit dem Radiobutton verknüpften Tcl-Befehl auf, falls einer vorhanden ist. Der Rückgabewert ist der Rückgabewert des Tcl-Befehls oder ein leerer String, wenn kein Befehl mit dem Radiobutton verknüpft ist. Dieser Befehl wird ignoriert, wenn der Zustand des Radiobuttons **disabled** ist.

[pathName]{.ins} [select]{.sub}
: Wählt den Radiobutton aus und setzt die zugehörige Variable auf den Wert, der diesem Widget entspricht.


# Standard-Bindings

Tk erstellt automatisch Klassen-Bindings für Radiobuttons, die ihnen folgendes Standardverhalten geben:

1. Auf Unix-Systemen wird ein Radiobutton aktiviert, wenn die Maus über ihn fährt, und deaktiviert, wenn die Maus den Radiobutton verlässt. Auf Mac- und Windows-Systemen wird der Button aktiviert, wenn Maustaste 1 über einem Radiobutton gedrückt wird und der Mauszeiger sich innerhalb des Buttons befindet, und deaktiviert, wenn der Mauszeiger den Button verlässt.

2. Wenn Maustaste 1 über einem Radiobutton gedrückt wird, wird er aufgerufen (er wird ausgewählt und der mit dem Button verknüpfte Befehl wird aufgerufen, falls einer vorhanden ist).

3. Wenn ein Radiobutton den Eingabefokus hat, bewirkt die Leertaste, dass der Radiobutton aufgerufen wird.


Wenn der Zustand des Radiobuttons **disabled** ist, tritt keine der obigen Aktionen auf: Der Radiobutton reagiert überhaupt nicht.

Das Verhalten von Radiobuttons kann geändert werden, indem neue Bindings für einzelne Widgets definiert werden oder indem die Klassen-Bindings neu definiert werden.


[ConfigWidg]: ../tk-c/ConfigWidg.md
[GetPixels]: ../tk-c/GetPixels.md
[options]: options.md
[variable]: ../tcl/variable.md
