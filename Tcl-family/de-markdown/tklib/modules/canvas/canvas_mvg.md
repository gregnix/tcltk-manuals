---
CommandName: canvas::mvg
ManualSection: n
Version: 1.0.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - graphics
 - imagemagick
 - magick vector graphics
 - mvg
 - print screen
 - serialization
 - vector graphics
Copyright:
 - Copyright (c) 2010 Wolf-Dieter Busch (http://wiki.tcl-lang.org/15505)
 - Copyright (c) 2010 Documentation, Andreas Kupries
---

# NAME

canvas::mvg – Von Canvas in das MVG-Vektorformat von ImageMagick

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::mvg]{.lit} [1]{.optlit} 
[::canvas::mvg]{.cmd} [pathName]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält einen Befehl, mit dem der Inhalt eines Canvas in das MVG-Vektorformat von ImageMagick konvertiert werden kann.

# API

**::canvas::mvg** *pathName*
: Gibt den Inhalt des Canvas *pathName* aus. Das Ergebnis ist eine Zeichenkette im MVG-Vektorformat von ImageMagick.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# COPYRIGHT

```
Copyright (c) 2010 Wolf-Dieter Busch (http://wiki.tcl-lang.org/15505)
Copyright (c) 2010 Documentation, Andreas Kupries
```
