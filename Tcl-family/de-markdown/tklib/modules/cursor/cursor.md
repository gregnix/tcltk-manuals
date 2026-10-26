---
CommandName: cursor
ManualSection: n
Version: 0.3.1
TclPart: tklib
TclDescription: Tk cursor routines
Links:
 - Tk_GetCursor(3)
 - cursors(n)
 - options(n)
Keywords:
 - cursor
Copyright:
 - Copyright (c) Jeffrey Hobbs <jeff@hobbs.org>
---

# NAME

cursor – Prozeduren für Tk-Cursor

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tk]{.lit} 
[package]{.cmd} [require]{.sub} [cursor]{.lit} [0.3.1]{.optlit} 
[::cursor::propagate]{.cmd} [widget]{.arg} [cursor]{.arg} 
[::cursor::restore]{.cmd} [widget]{.arg} [cursor]{.optarg} 
[::cursor::display]{.cmd} [parent]{.optarg} 
:::

# BESCHREIBUNG

Das Paket **cursor** stellt Befehle zur Verwaltung von Tk-Cursorn bereit.

# BEFEHLE

Folgende Befehle stehen zur Verfügung:

**::cursor::propagate** *widget* *cursor*
: Legt den Cursor für das angegebene *widget* und alle seine Nachkommen auf *cursor* fest.

**::cursor::restore** *widget* ?*cursor*?
: Stellt den ursprünglichen oder zuvor gesetzten Cursor für das angegebene *widget* und alle seine Nachkommen wieder her. Wird *cursor* angegeben, gilt er für jedes Widget, das keinen voreingestellten Cursor hatte (gesetzt durch einen früheren Aufruf von **::cursor::propagate**).

**::cursor::display** ?*parent*?
: Es wird ein Dialogfeld mit einer listbox angezeigt, die alle Cursor-Namen enthält. Wenn Sie einen Cursor-Namen auswählen, wird dieser in diesem Dialogfeld angezeigt. Dies dient lediglich dazu, alle auf der Plattform verfügbaren Cursor anzuzeigen.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *cursor* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# COPYRIGHT

```
Copyright (c) Jeffrey Hobbs <jeff@hobbs.org>
```
