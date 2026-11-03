---
CommandName: menubutton
title: menubutton
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - ttk::menubutton(n)
 - menu(n)
Keywords:
 - menubutton
 - widget
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

menubutton - Erstellt und manipuliert Menubutton-Widgets für Popup-Menüs

# Übersicht

::: {.synopsis} :::
[menubutton]{.cmd} [pathName]{.arg} [options]{.optarg}
:::

# Standardoptionen

**-activebackground**, **-disabledforeground**, **-padx**, **-activeforeground**, **-font**, **-pady**, **-anchor**, **-foreground**, **-relief**, **-background**, **-highlightbackground**, **-takefocus**, **-bitmap**, **-highlightcolor**, **-text**, **-borderwidth**, **-highlightthickness**, **-textvariable**, **-cursor**, **-image**, **-underline**, **-compound**, **-justify**, **-wraplength**

Siehe die Handbuchseite [options] für Einzelheiten zu den Standardoptionen.

# Widget-spezifische Optionen

**-direction** (**direction**/**Direction**)
: Legt fest, wo das Menü geöffnet werden soll. **above** versucht, das Menü oberhalb des Menubuttons zu öffnen. **below** versucht, das Menü unterhalb des Menubuttons zu öffnen. **left** versucht, das Menü links vom Menubutton zu öffnen. **right** versucht, das Menü rechts vom Menubutton zu öffnen. [flush] öffnet das Menü direkt über dem Menubutton. Bei **above** oder **below** wird die Richtung umgekehrt, wenn das Menü sonst außerhalb des Bildschirms erscheinen würde.

**-height** (**height**/**Height**)
: Legt eine gewünschte Höhe für den Menubutton fest. Zeigt der Menubutton ein Bild oder eine Bitmap an, wird der Wert in Bildschirmeinheiten angegeben (also in einer der Formen, die [Tk\_GetPixels][GetPixels] akzeptiert); bei Text wird er in Textzeilen angegeben. Ist diese Option nicht angegeben, wird die gewünschte Höhe des Menubuttons aus der Größe des darin angezeigten Bildes, der Bitmap oder des Textes berechnet.

**-indicatoron** (**indicatorOn**/**IndicatorOn**)
: Der Wert muss ein gültiger boolescher Wert sein. Ist er wahr, wird auf der rechten Seite des Menubuttons ein kleines Indikator-Rechteck angezeigt, und die Standard-Menübindungen behandeln den Menubutton als Options-Menubutton. Ist er falsch, wird kein Indikator angezeigt.

**-menu** ([menu]/**MenuName**)
: Legt den Pfadnamen des Menüs fest, das diesem Menubutton zugeordnet ist. Das Menü muss ein Kind des Menubuttons sein.

**-state** (**state**/**State**)
: Legt einen von drei Zuständen für den Menubutton fest: **normal**, **active** oder **disabled**. Im Zustand normal wird der Menubutton mit den Optionen **foreground** und **background** dargestellt. Der Zustand active wird typischerweise verwendet, wenn sich der Mauszeiger über dem Menubutton befindet. Im Zustand active wird der Menubutton mit den Optionen **-activeforeground** und **-activebackground** dargestellt. Der Zustand disabled bedeutet, dass der Menubutton nicht reagieren soll: Die Standardbindungen weigern sich, das Widget zu aktivieren, und ignorieren das Drücken von Maustasten. In diesem Zustand bestimmen die Optionen **-disabledforeground** und **-background**, wie der Button dargestellt wird.

**-width** (**width**/**Width**)
: Legt eine gewünschte Breite für den Menubutton fest. Zeigt der Menubutton ein Bild oder eine Bitmap an, wird der Wert in Bildschirmeinheiten angegeben (also in einer der Formen, die [Tk\_GetPixels][GetPixels] akzeptiert); bei Text wird er in Zeichen angegeben. Ist diese Option nicht angegeben, wird die gewünschte Breite des Menubuttons aus der Größe des darin angezeigten Bildes, der Bitmap oder des Textes berechnet.


# Beschreibung

Der Befehl **menubutton** erstellt ein neues Fenster (durch das Argument *pathName* angegeben) und macht es zu einem Menubutton-Widget. Weitere Optionen, die oben beschrieben sind, können in der Befehlszeile oder in der Optionsdatenbank angegeben werden, um Eigenschaften des Menubuttons wie Farben, Schriftart, Text und anfängliches Relief zu konfigurieren. Der Befehl **menubutton** gibt sein Argument *pathName* zurück. Zum Zeitpunkt des Aufrufs darf kein Fenster mit dem Namen *pathName* existieren, das Elternfenster von *pathName* muss jedoch existieren.

Ein Menubutton ist ein Widget, das eine Zeichenkette, eine Bitmap oder ein Bild anzeigt und einem Menü-Widget zugeordnet ist. Wird Text angezeigt, muss er vollständig in einer einzigen Schriftart erscheinen. Er kann aber mehrere Zeilen auf dem Bildschirm einnehmen (wenn er Zeilenumbrüche enthält oder wenn wegen der Option **-wraplength** umbrochen wird), und eines der Zeichen kann mit der Option **-underline** unterstrichen werden. Im üblichen Gebrauch bewirkt das Drücken von Maustaste 1 über dem Menubutton, dass das zugeordnete Menü direkt unterhalb des Menubuttons geöffnet wird. Wird die Maus vor dem Loslassen der Maustaste über das Menü bewegt, ruft das Loslassen den darunterliegenden Menüeintrag auf. Wenn die Maustaste losgelassen wird, wird das Menü geschlossen.

Menubuttons werden verwendet, um ein [tk\_optionMenu][optionMenu] aufzubauen. Unter macOS ist das der bevorzugte Mechanismus, mit dem ein Benutzer ein Element aus einer Liste auswählt.

Menubuttons wurden außerdem typischerweise in Gruppen angeordnet, die Menüleisten heißen und ein Durchlaufen erlauben: Wird die Maustaste über einem Menubutton gedrückt (sodass er sein Menü öffnet) und die Maus ohne Loslassen der Maustaste über einen anderen Menubutton derselben Menüleiste bewegt, wird das Menü des ersten Menubuttons geschlossen und stattdessen das Menü des neuen Menubuttons geöffnet. *Diese Verwendung ist veraltet*; stattdessen sollten Sie ein [menu] direkt als Menüleiste festlegen. Wie das geht, beschreibt die Option **-menu** von [toplevel].

Zwischen Menubuttons und Menüs gibt es mehrere Wechselwirkungen; Informationen zu verschiedenen Menükonfigurationen, etwa Pulldown-Menüs und Optionsmenüs, finden Sie auf der Handbuchseite [menu].

# Widget-Befehl

Der Befehl **menubutton** erzeugt einen neuen Tcl-Befehl, dessen Name *pathName* ist. Mit diesem Befehl können verschiedene Operationen auf dem Widget ausgeführt werden. Er hat folgende allgemeine Form:

```
pathName option ?arg ...?
```

*Option* und die Argumente *arg* bestimmen das genaue Verhalten des Befehls. Für Menubutton-Widgets sind folgende Befehle möglich:

[pathName]{.ins} [cget]{.sub} [option]{.arg}
: Gibt den aktuellen Wert der Konfigurationsoption zurück, die durch *option* angegeben ist. *Option* kann jeden Wert haben, den der Befehl **menubutton** akzeptiert.

[pathName]{.ins} [configure]{.sub} [option]{.optarg} [value option value]{.optdot}
: Fragt die Konfigurationsoptionen des Widgets ab oder ändert sie. Ist keine *option* angegeben, wird eine Liste zurückgegeben, die alle verfügbaren Optionen für *pathName* beschreibt (das Format dieser Liste ist bei [Tk\_ConfigureInfo][ConfigWidg] beschrieben). Ist *option* ohne *value* angegeben, gibt der Befehl eine Liste zurück, die die eine genannte Option beschreibt (diese Liste ist identisch mit der entsprechenden Teilliste des Wertes, der ohne Angabe von *option* zurückgegeben wird). Sind ein oder mehrere *option-value*-Paare angegeben, setzt der Befehl die angegebenen Widget-Optionen auf die angegebenen Werte; in diesem Fall gibt der Befehl eine leere Zeichenkette zurück. *Option* kann jeden Wert haben, den der Befehl **menubutton** akzeptiert.


# Standard-Bindungen

Tk erzeugt automatisch Klassenbindungen für Menubuttons, die ihnen folgendes Standardverhalten geben:

1. Ein Menubutton wird aktiviert, sobald die Maus über ihn fährt, und deaktiviert, sobald die Maus ihn verlässt.

2. Das Drücken von Maustaste 1 über einem Menubutton öffnet den Menubutton: Sein Relief wechselt zu raised, und das zugeordnete Menü wird unterhalb des Menubuttons geöffnet. Wird die Maus bei weiterhin gedrückter Taste nach unten in das Menü gezogen und die Maustaste dann über einem Menüeintrag losgelassen, wird der Menubutton geschlossen und der Menüeintrag aufgerufen.

3. Wird Taste 1 über einem Menubutton gedrückt und über demselben Menubutton wieder losgelassen, bleibt der Menubutton geöffnet: Sie können die Maus weiterhin über das Menü bewegen und mit Taste 1 auf einen Eintrag klicken, um ihn aufzurufen. Sobald ein Menüeintrag aufgerufen wurde, schließt sich der Menubutton.

4. Wird Taste 1 über einem Menubutton gedrückt und die Maus dann über einen anderen Menubutton gezogen, schließt sich der ursprüngliche Menubutton, und der neue Menubutton öffnet sich.

5. Wird Taste 1 über einem Menubutton gedrückt und außerhalb jedes Menubuttons und Menüs losgelassen, schließt sich der Menubutton, ohne einen Menüeintrag aufzurufen.

6. Ist ein Menubutton geöffnet, übernimmt das zugeordnete Menü den Eingabefokus, damit Menü und Untermenüs mit der Tastatur durchlaufen werden können. Einzelheiten zu diesen Bindungen finden Sie auf der Handbuchseite [menu].

7. Ist für einen Menubutton die Option **-underline** angegeben, kann der Menubutton über die Tastatur geöffnet werden: Alt+*x*, wobei *x* das unterstrichene Zeichen ist (oder dessen Klein- bzw. Großbuchstabe), kann in jedem Fenster unterhalb des Toplevel-Fensters des Menubuttons eingegeben werden, um den Menubutton zu öffnen.

8. Die Taste F10 kann in jedem Fenster gedrückt werden, um den ersten nicht deaktivierten Menubutton unterhalb seines Toplevel-Fensters zu öffnen.

9. Hat ein Menubutton den Eingabefokus, öffnen die Leertaste und die Return-Taste den Menubutton.


Ist der Zustand des Menubuttons **disabled**, findet keine der obigen Aktionen statt: Der Menubutton reagiert überhaupt nicht.

Das Verhalten von Menubuttons lässt sich ändern, indem Sie für einzelne Widgets neue Bindungen festlegen oder die Klassenbindungen neu definieren.


[ConfigWidg]: ../tk-c/ConfigWidg.md
[flush]: ../tcl/flush.md
[GetPixels]: ../tk-c/GetPixels.md
[menu]: menu.md
[optionMenu]: optionMenu.md
[options]: options.md
[toplevel]: toplevel.md
