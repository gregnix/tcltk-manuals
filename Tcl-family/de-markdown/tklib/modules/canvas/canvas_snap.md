---
CommandName: canvas::snap
title: canvas::snap
ManualSection: n
Version: 1.0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - image
 - photo
 - print screen
 - snapshot
Copyright:
 - Copyright (c) 2004 George Petasis (http://wiki.tcl-lang.org/1404)
 - Copyright (c) 2010 Documentation, Andreas Kupries
---

# Name

canvas::snap – Momentaufnahme der Canvas als Tk-Foto-Image

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [canvas::snap]{.lit} [1.0.1]{.optlit}
[package]{.cmd} [require]{.sub} [img::window]{.lit}
[::canvas::snap]{.cmd} [pathName]{.arg}
:::

# Beschreibung

Dieses Paket enthält einen Befehl zum Erstellen von Momentaufnahmen beliebiger Canvas.

# API

**::canvas::snap** *pathName*
: Erstellt eine Momentaufnahme des Canvas *pathName*. Das Ergebnis ist der Name eines neuen Tk-Foto-Images, das die Momentaufnahme enthält.

    *Hinweis*: Dieser Befehl hat einen Nebeneffekt. Um zu vermeiden, dass weiße Rechtecke an den Stellen entstehen, an denen andere Fenster den Canvas überlappen könnten, zwingt dieser Befehl das Toplevel-Fenster, in dem sich der Canvas befindet, an die oberste Position der Stacking-Reihenfolge.


# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Copyright

```
Copyright (c) 2004 George Petasis (http://wiki.tcl-lang.org/1404)
Copyright (c) 2010 Documentation, Andreas Kupries
```
