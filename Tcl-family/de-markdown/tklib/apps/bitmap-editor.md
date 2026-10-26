---
CommandName: bitmap-editor
title: bitmap-editor
ManualSection: n
Version: 1.0
TclPart: tklib
TclDescription: Bitmap handling
Keywords:
 - bitmap
 - editor
 - image
 - pixel
 - xbm
Copyright:
 - Copyright (c)
---

# Name

Bitmap-Editor – Editor für XBM-Bilder

# Übersicht

::: {.synopsis} :::
[bitmap-editor]{.cmd} [xbmfile]{.optarg}
:::

# Beschreibung

Die in diesem Dokument beschriebene Anwendung, **bitmap-editor**, ist ein einfacher Editor für XBM-basierte Bitmap-Bilder. Der von Keith Vetter entwickelte Originalcode ist unter <http://wiki.tcl-lang.org/6298> zu finden.

## Befehlszeile

**bitmap-editor** ?*xbmfile*?
: Wird der Editor ohne Argument aufgerufen, wird die Editor-Benutzeroberfläche geöffnet und eine Standard-Bitmap zur Bearbeitung angezeigt. Wird er mit einem Argument aufgerufen, wird erwartet, dass es sich um den Pfad zu einer Bitmap-Datei im XBM-Format handelt, und die darin enthaltene Bitmap wird angezeigt.

    path *xbmfile* (in/out)
    : Dieses Argument legt den Pfad zu einer Bitmap-Datei im XBM-Format fest, deren Inhalt von der Anwendung angezeigt und bearbeitet werden soll.



# Fehler, Ideen, Rückmeldungen

Dieses Dokument und die darin beschriebene Anwendung enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *bitmap* der [Tcllib-SF-Tracker](http://sourceforge.net/tracker/?group_id=12883). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen an der Anwendung oder an der Dokumentation.

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *bitmap-editor* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Kategorie

Bildverarbeitung

# Copyright

```
Copyright (c)
```
