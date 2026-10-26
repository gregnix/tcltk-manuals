---
CommandName: canvas::pdf
ManualSection: n
Version: 1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - canvas
 - graphics
 - imagemagick
 - pdf
 - portable document format
 - print screen
 - serialization
 - vector graphics
Copyright:
 - Copyright (c) 2014 Andreas Kupries, Arjen Markus
 - Copyright (c) 2014 Documentation, Andreas Kupries
---

# NAME

canvas::pdf – Von Canvas zu PDF

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.5]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::pdf]{.lit} [1]{.optlit} 
[package]{.cmd} [require]{.sub} [pdf4tcl]{.lit} 
[::canvas::pdf]{.cmd} [pathName]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält einen Befehl, mit dem sich der Inhalt eines Canvas in das Vektorformat PDF von Adobe konvertieren lässt.

# API

**::canvas::pdf** *pathName*
: Gibt den Inhalt des Canvas *pathName* aus. Das Ergebnis ist eine Zeichenkette im Adobe-PDF-Format.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# COPYRIGHT

```
Copyright (c) 2014 Andreas Kupries, Arjen Markus
Copyright (c) 2014 Documentation, Andreas Kupries
```
