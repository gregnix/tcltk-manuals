---
CommandName: widget_calendar
title: widget_calendar
ManualSection: n
Version: 1.0.2
TclPart: tklib
TclDescription: Various megawidgets
Keywords:
 - calendar
 - date
 - megawidget
 - snit
 - widget
Copyright:
---

# Name

widget\_calendar – Kalender-Megawidget

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [widget]{.lit} [3.0]{.optlit}
[package]{.cmd} [require]{.sub} [widget::calendar]{.lit} [1.0.2]{.optlit}
[widget::calendar]{.cmd} [pathname]{.arg} [options]{.optarg}
:::

# Beschreibung

Dieses Paket enthält ein Kalender-Megawidget (snidget).

- **widget::calendar** *pathname* ?options?


# Widget-Optionen

**-command**
: Ein Skript, das ausgewertet wird, wenn ein Datum ausgewählt wurde.

**-dateformat**
: Das Format des zurückgegebenen Datums. Standard: %m/%d/%Y.

**-firstday**
: Setzt den ersten Wochentag, entweder sunday oder monday. Die Vorgabe ist monday.

**-font**
: Wählt die im Widget verwendete Schriftart. Die Vorgabe ist Helvetica 9.

**-highlightcolor**
: Wählt die Hintergrundfarbe des ausgewählten Tages. Vorgabe: #FFCC00

**-language**
: Legt die Sprache des Kalenderinhalts fest. Die Sprache wird durch Abkürzungen angegeben, zum Beispiel en – englisch, de – deutsch. Die Vorgabe ist en.

    Unterstützte Sprachen: de en es fr gr he it ja sv pl pt zh fi tr nl ru crk crx-nak crx-lhe

**-shadecolor**
: Wählt die Farbe der Teile mit schattiertem Hintergrund. Vorgabe: #888888

**-showpast**
: Legt fest, ob die Vergangenheit angezeigt wird. Ein boolescher Wert, Vorgabe 1.

**-textvariable**
: Legt den Namen einer Variablen fest, deren Wert mit dem Inhalt des Entry-Widgets verknüpft ist. Ändert sich der Wert der Variablen, wird der Inhalt des Widgets aktualisiert, und umgekehrt.


# Widget-Befehl

*pathname* **get** ?*what*?

Gibt einen Teil des ausgewählten Datums oder all zurück. Das Argument *what* wählt den Teil. Zulässige Werte für *what* sind day, month, year und all. all ist die Vorgabe und gibt das vollständige Datum in dem mit -dateformat angegebenen Format zurück.

# Standard-Bindings

Beim Erstellen des Kalender-Widgets werden die folgenden Bindings eingerichtet. Beim Drücken einer Taste wird der Befehl aufgerufen und die Textvariable aktualisiert. aktualisiert.

- Home – Zum aktuellen Datum wechseln

- Up – Zur Woche vor dem aktuellen Datum wechseln

- Down – Zur Woche nach dem aktuellen Datum wechseln

- Left – Zum Tag vor dem aktuellen Datum wechseln

- Right – Zum Tag nach dem aktuellen Datum wechseln

- Control-Left – Zum Monat vor dem aktuellen Datum wechseln

- Control-Right – Zum Monat nach dem aktuellen Datum wechseln

- Control-Up – Zum Jahr vor dem aktuellen Datum wechseln

- Control-Down – Zum Jahr nach dem aktuellen Datum wechseln


# Beispiel

```
    package require widget::calendar ; # or widget::all
    set t [widget::calendar .t]
    pack $t -fill x -expand 1
```

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *widget::calendar* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Kategorie

Widget
