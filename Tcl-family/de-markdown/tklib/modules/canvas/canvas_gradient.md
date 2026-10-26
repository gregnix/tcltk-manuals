---
CommandName: canvas::gradient
ManualSection: n
Version: 0.2
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - background
 - canvas
 - color gradient
 - gradients
 - image
 - widget background
Copyright:
 - Copyright (c) 2013 Jarek Lewandowski, MaxJarek
 - Copyright (c) Origin http://wiki.tcl-lang.org/6100
 - Copyright (c) Origin http://wiki.tcl-lang.org/37242
 - Copyright (c) Origin http://wiki.tcl-lang.org/9079
---

# NAME

canvas::gradient – Canvas mit Farbverlaufshintergrund

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::gradient]{.lit} [0.2]{.optlit} 
[::canvas::gradient]{.cmd} [pathName]{.arg} [options?]{.optdot} 
:::

# BESCHREIBUNG

Dieses Paket enthält einen Befehl zum Festlegen von Hintergrundverläufen auf Canvas.

*NOTE!* Dieses Paket reserviert das Canvas-Tag **canvas::gradient** für sich.

# API

**::canvas::gradient** *pathName* ?options?...
: Erstellt einen Hintergrundverlauf auf dem Canvas *pathName*. Ein bereits vorhandener Verlauf wird durch die neue Definition ersetzt. Die verfügbaren Optionen werden weiter unten im Abschnitt **Optionen** beschrieben.


## Optionen

**-direction** *direction*
: Der Wert für diese Option legt die *direction* des Farbverlaufs fest. Wird kein Wert angegeben, verwendet das System standardmäßig „**x**“, einen horizontalen Farbverlauf. Das Paket unterstützt fünf Richtungen:


**x**
: für einen horizontalen Farbverlauf (Standard). Die Farbe ändert sich entlang der x-Achse, wobei die Startfarbe links liegt.

**y**
: für einen vertikalen Farbverlauf. Die Farbe ändert sich entlang der y-Achse, wobei die Ausgangsfarbe oben liegt.

**d1**
: für einen diagonalen Farbverlauf von links oben nach rechts unten. Die Farbe ändert sich entlang der Diagonale, wobei die Startfarbe links oben liegt.

**d2**
: für einen diagonalen Farbverlauf von links unten nach rechts oben. Die Farbe ändert sich entlang der Diagonale, wobei die Startfarbe links unten liegt.

**r**
: Für einen radialen Farbverlauf um den Mittelpunkt des Ansichtsbereichs: Die Farbe ändert sich von der Mitte nach außen, wobei die Startfarbe in der Mitte liegt.


**-color1** *color*
: Der Wert für diese Option legt die Startfarbe des Farbverlaufs fest. Wird kein Wert angegeben, wird standardmäßig „**red**“ verwendet.

**-color2** *color*
: Der Wert für diese Option legt die Endfarbe des Farbverlaufs fest. Wird kein Wert angegeben, wird standardmäßig „**green**“ verwendet.

**-type** *type*
: Der Wert für diese Option legt fest, wie der Farbverlauf berechnet wird. Das Paket unterstützt derzeit nur eine Methode, die natürlich als Standard eingestellt ist:


**linear**
: für eine lineare Interpolation zwischen der Start- und der Endfarbe (Standard).


# BEISPIEL

```
	package require canvas::gradient
	canvas .c
	canvas::gradient .c -direction x -color1 yellow -color2 blue
	pack .c -fill both -expand 1
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# COPYRIGHT

```
Copyright (c) 2013 Jarek Lewandowski, MaxJarek
Copyright (c) Origin http://wiki.tcl-lang.org/6100
Copyright (c) Origin http://wiki.tcl-lang.org/37242
Copyright (c) Origin http://wiki.tcl-lang.org/9079
```
