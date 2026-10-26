---
CommandName: checkbutton
title: checkbutton
ManualSection: n
Version: 4.4
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - button(n)
 - options(n)
 - radiobutton(n)
 - ttk::checkbutton(n)
Keywords:
 - checkbutton
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

checkbutton - Erstellt und manipuliert 'Checkbutton'-Widgets für boolesche Auswahl

# Übersicht

::: {.synopsis} :::
[checkbutton]{.cmd} [pathName]{.arg} [options]{.optarg}
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
: Legt das Relief für den Checkbutton fest, wenn der Indikator nicht gezeichnet wird und der Checkbutton ausgeschaltet ist. Der Standardwert ist „raised“. Durch Setzen dieser Option auf „flat“ und **-indicatoron** auf false sowie **-overrelief** auf „raised“ entsteht ein flacher Button, der bei Maus-Over erhaben wird und beim Aktivieren eingedrückt ist. Dies ist typisches Verhalten der Fett-, Kursiv- und Unterstrichen-Checkbuttons in der Symbolleiste einer Textverarbeitung.

**-offvalue** (**offValue**/**Value**)
: Gibt den Wert an, der in der zugehörigen Variable des Buttons gespeichert wird, wenn dieser Button abgewählt wird. Standardwert ist „0“.

**-onvalue** (**onValue**/**Value**)
: Gibt den Wert an, der in der zugehörigen Variable des Buttons gespeichert wird, wenn dieser Button ausgewählt wird. Standardwert ist „1“.

**-overrelief** (**overRelief**/**OverRelief**)
: Legt ein alternatives Relief für den Checkbutton fest, das verwendet wird, wenn der Mauszeiger über dem Widget ist. Diese Option kann verwendet werden, um Toolbar-Buttons zu erstellen, indem **-relief flat -overrelief raised** konfiguriert wird. Wenn der Wert dieser Option der leere String ist, wird kein alternatives Relief verwendet, wenn der Mauszeiger über dem Checkbutton ist. Der leere String ist der Standardwert.

**-selectcolor** (**selectColor**/**Background**)
: Legt eine Hintergrundfarbe fest, die verwendet wird, wenn der Button ausgewählt ist. Wenn **indicatorOn** true ist, wird die Farbe als Hintergrund für den Indikator verwendet, unabhängig vom Auswahlzustand. Wenn **indicatorOn** false ist, wird diese Farbe als Hintergrund für das gesamte Widget anstelle von **background** oder **activeBackground** verwendet, sobald das Widget ausgewählt ist. Wenn als leerer String angegeben, wird keine besondere Farbe für die Anzeige im ausgewählten Zustand verwendet.

**-selectimage** (**selectImage**/**SelectImage**)
: Legt ein Bild fest, das (anstelle der Option **-image**) angezeigt wird, wenn der Checkbutton ausgewählt ist. Diese Option wird ignoriert, sofern die Option **-image** nicht angegeben wurde.

**-state** (**state**/**State**)
: Legt einen von drei Zuständen für den Checkbutton fest: **normal**, **active** oder **disabled**. Im normalen Zustand wird der Checkbutton mit den Optionen **-foreground** und **-background** angezeigt. Der aktive Zustand wird typischerweise verwendet, wenn der Zeiger über dem Checkbutton ist. Im aktiven Zustand wird der Checkbutton mit den Optionen **-activeforeground** und **-activebackground** angezeigt. Der deaktivierte Zustand bedeutet, dass der Checkbutton unempfindlich sein sollte: Die Standard-Bindings weigern sich, das Widget zu aktivieren und ignorieren Mausklicks. In diesem Zustand bestimmen die Optionen **-disabledforeground** und **-background**, wie der Checkbutton angezeigt wird.

**-tristateimage** (**tristateImage**/**TristateImage**)
: Legt ein Bild fest, das (anstelle der Option **-image**) angezeigt wird, wenn der Checkbutton im Drei-Zustand-Modus ist. Diese Option wird ignoriert, sofern die Option **-image** nicht angegeben wurde.

**-tristatevalue** (**tristateValue**/**Value**)
: Gibt den Wert an, der bewirkt, dass der Checkbutton die Mehrfachauswahl anzeigt, auch bekannt als Drei-Zustand-Modus. Standardwert ist „“.

**-variable** ([variable]/**Variable**)
: Gibt den Namen einer globalen Variable an, die gesetzt wird, um anzuzeigen, ob dieser Button ausgewählt ist oder nicht. Standardwert ist der Name des Buttons innerhalb seines Eltern-Elements (d.h. das letzte Element des Pfadnamens des Button-Fensters).

**-width** (**width**/**Width**)
: Legt eine gewünschte Breite für den Button fest. Wenn ein Bild oder Bitmap im Button angezeigt wird, ist der Wert in Bildschirmeinheiten (d.h. alle von [Tk\_GetPixels][GetPixels] akzeptierten Formen); für Text ist es in Zeichen. Wenn diese Option nicht angegeben ist, wird die gewünschte Breite des Buttons aus der Größe des angezeigten Bildes, Bitmaps oder Textes berechnet.


# Beschreibung

Der Befehl **checkbutton** erstellt ein neues Fenster (gegeben durch das *pathName*-Argument) und macht es zu einem Checkbutton-Widget. Zusätzliche Optionen, wie oben beschrieben, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Aspekte des Checkbuttons wie Farben, Schriftart, Text und anfängliches Relief zu konfigurieren. Der Befehl **checkbutton** gibt sein *pathName*-Argument zurück. Zum Zeitpunkt des Aufrufs dieses Befehls darf kein Fenster mit dem Namen *pathName* existieren, aber das Eltern-Element von *pathName* muss existieren.

Ein Checkbutton ist ein Widget, das einen Text-String, ein Bitmap oder ein Bild sowie ein Quadrat namens *Indikator* anzeigt. Wenn Text angezeigt wird, muss er in einer einzigen Schriftart sein, kann aber mehrere Zeilen auf dem Bildschirm einnehmen (wenn er Zeilenumbrüche enthält oder wenn ein Umbruch wegen der Option **-wraplength** erfolgt), und eines der Zeichen kann optional mit der Option **-underline** unterstrichen werden. Ein Checkbutton hat das gesamte Verhalten eines einfachen Buttons, einschließlich Folgendem: Er kann sich je nach Option **-state** auf drei verschiedene Arten darstellen; er kann erhaben, eingesenkt oder flach dargestellt werden; er kann blinken; und er ruft einen Tcl-Befehl auf, wenn Maustaste 1 über dem Checkbutton geklickt wird.

Darüber hinaus können Checkbuttons *ausgewählt* werden. Wenn ein Checkbutton ausgewählt ist, wird der Indikator normalerweise mit ausgewähltem Erscheinungsbild gezeichnet, und eine mit dem Checkbutton verknüpfte Tcl-Variable wird auf einen bestimmten Wert gesetzt (normalerweise 1). Der Indikator wird mit einem Häkchen darin gezeichnet. Wenn der Checkbutton nicht ausgewählt ist, wird der Indikator mit nicht ausgewähltem Erscheinungsbild gezeichnet, und die zugehörige Variable wird auf einen anderen Wert gesetzt (typischerweise 0). Der Indikator wird ohne Häkchen darin gezeichnet. Im Sonderfall, in dem die Variable (falls angegeben) einen Wert hat, der mit dem **-tristatevalue** übereinstimmt, wird der Indikator mit Drei-Zustand-Erscheinungsbild gezeichnet und befindet sich im Drei-Zustand-Modus, der gemischte oder mehrere Werte anzeigt. (Dies wird verwendet, wenn das Kontrollkästchen den Zustand mehrerer Elemente repräsentiert.) Der Indikator wird plattformabhängig gezeichnet. Unter Unix und Windows wird der Hintergrund im Inneren des Kästchens „ausgegraut“. Unter Mac wird der Indikator mit einem Strich darin gezeichnet. Standardmäßig ist der Name der mit einem Checkbutton verknüpften Variable derselbe wie der *name*, der zum Erstellen des Checkbuttons verwendet wurde. Der Variablenname sowie die darin gespeicherten „on“-, „off“- und „tristate“-Werte können mit Optionen in der Befehlszeile oder in der Optionsdatenbank geändert werden. Konfigurationsoptionen können auch verwendet werden, um die Art der Indikatoranzeige zu ändern (oder ob er überhaupt angezeigt wird). Standardmäßig ist ein Checkbutton so konfiguriert, dass er sich bei abwechselnden Button-Klicks selbst aus- und abwählt. Zusätzlich überwacht jeder Checkbutton seine zugehörige Variable und wählt sich automatisch ab bzw. an, wenn sich der Wert der Variable zu den „on“-, „off“- und „tristate“-Werten des Buttons ändert.

# Widget-Befehl

Der Befehl **checkbutton** erstellt einen neuen Tcl-Befehl, dessen Name *pathName* ist. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Widget aufzurufen. Er hat folgende allgemeine Form:

```
pathName option ?arg ...?
```

*Option* und die *arg*s bestimmen das genaue Verhalten des Befehls. Die folgenden Befehle sind für Checkbutton-Widgets möglich:

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der durch *option* gegebenen Konfigurationsoption zurück. *Option* kann jeden der vom Befehl **checkbutton** akzeptierten Werte haben.

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Abfrage oder Änderung der Konfigurationsoptionen des Widgets. Wenn keine *option* angegeben ist, gibt eine Liste zurück, die alle verfügbaren Optionen für *pathName* beschreibt (siehe [Tk\_ConfigureInfo][ConfigWidg] für Informationen über das Format dieser Liste). Wenn *option* ohne *value* angegeben ist, gibt der Befehl eine Liste zurück, die die eine benannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Unterliste des zurückgegebenen Wertes, wenn keine *option* angegeben ist). Wenn ein oder mehrere *option-value*-Paare angegeben sind, ändert der Befehl die gegebene(n) Widget-Option(en) auf die gegebenen Werte; in diesem Fall gibt der Befehl einen leeren String zurück. *Option* kann jeden der vom Befehl **checkbutton** akzeptierten Werte haben.

[pathName]{.ins} [deselect]{.sub}
: Wählt den Checkbutton ab und setzt die zugehörige Variable auf ihren „off“-Wert.

[pathName]{.ins} [flash]{.sub}
: Lässt den Checkbutton blinken. Dies wird erreicht, indem der Checkbutton mehrmals neu angezeigt wird und dabei zwischen aktiven und normalen Farben gewechselt wird. Am Ende des Blinkens bleibt der Checkbutton im gleichen normal/aktiven Zustand wie beim Aufruf des Befehls. Dieser Befehl wird ignoriert, wenn der Zustand des Checkbuttons **disabled** ist.

[pathName]{.ins} [invoke]{.sub}
: Bewirkt genau das, was passiert wäre, wenn der Benutzer den Checkbutton mit der Maus aufgerufen hätte: Schaltet den Auswahlzustand des Buttons um und ruft den mit dem Checkbutton verknüpften Tcl-Befehl auf, falls einer vorhanden ist. Der Rückgabewert ist der Rückgabewert des Tcl-Befehls oder ein leerer String, wenn kein Befehl mit dem Checkbutton verknüpft ist. Dieser Befehl wird ignoriert, wenn der Zustand des Checkbuttons **disabled** ist.

[pathName]{.ins} [select]{.sub}
: Wählt den Checkbutton aus und setzt die zugehörige Variable auf ihren „on“-Wert.

[pathName]{.ins} [toggle]{.sub}
: Schaltet den Auswahlzustand des Buttons um, zeigt ihn neu an und ändert die zugehörige Variable entsprechend dem neuen Zustand.


# Standard-Bindings

Tk erstellt automatisch Klassen-Bindings für Checkbuttons, die ihnen folgendes Standardverhalten geben:

1. Auf Unix-Systemen wird ein Checkbutton aktiviert, wenn die Maus über ihn fährt, und deaktiviert, wenn die Maus den Checkbutton verlässt. Auf Mac- und Windows-Systemen wird der Button aktiviert, wenn Maustaste 1 über einem Checkbutton gedrückt wird und der Mauszeiger sich innerhalb des Buttons befindet, und deaktiviert, wenn der Mauszeiger den Button verlässt.

2. Wenn Maustaste 1 über einem Checkbutton gedrückt wird, wird er aufgerufen (sein Auswahlzustand schaltet um und der mit dem Button verknüpfte Befehl wird aufgerufen, falls einer vorhanden ist).

3. Wenn ein Checkbutton den Eingabefokus hat, bewirkt die Leertaste, dass der Checkbutton aufgerufen wird. Unter Windows gibt es zusätzliche Tasten-Bindings; Plus (**+**) und Gleich (**=**) wählen den Button aus, und Minus (**-**) wählt ihn ab.


Wenn der Zustand des Checkbuttons **disabled** ist, tritt keine der obigen Aktionen auf: Der Checkbutton reagiert überhaupt nicht.

Das Verhalten von Checkbuttons kann geändert werden, indem neue Bindings für einzelne Widgets definiert werden oder indem die Klassen-Bindings neu definiert werden.

# Beispiele

Dieses Beispiel zeigt eine Gruppe unabhängiger Checkbuttons.

```
labelframe .lbl -text "Steps:"
checkbutton .c1 -text Lights  -variable lights
checkbutton .c2 -text Cameras -variable cameras
checkbutton .c3 -text Action! -variable action
pack .c1 .c2 .c3 -in .lbl
pack .lbl
```


[ConfigWidg]: ../tk-c/ConfigWidg.md
[GetPixels]: ../tk-c/GetPixels.md
[options]: options.md
[variable]: ../tcl/variable.md
