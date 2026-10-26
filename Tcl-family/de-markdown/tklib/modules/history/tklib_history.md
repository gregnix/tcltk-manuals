---
CommandName: history
ManualSection: n
Version: 0.3
TclPart: tklib
TclDescription: Provides a history for Entry widgets
Keywords:
 - entry
 - history
Copyright:
---

# NAME

history – Verlauf für Entry-Widgets

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [history]{.lit} [0.3]{.optlit} 
[::history::init]{.cmd} [pathName]{.arg} [length]{.optarg} 
[::history::remove]{.cmd} [pathName]{.arg} 
[::history::add]{.cmd} [pathName]{.arg} [text]{.arg} 
[::history::get]{.cmd} [pathName]{.arg} 
[::history::clear]{.cmd} [pathName]{.arg} 
[::history::configure]{.cmd} [pathName]{.arg} [option]{.arg} [value]{.optarg} 
:::

bell

# BESCHREIBUNG

Dieses Paket stellt einen Verlauf für Entry-Widgets bereit. Der Verlauf ist über die Pfeiltasten nach oben und unten erreichbar.

**::history::init** *pathName* ?length?
: Merkt sich den Verlauf des genannten Entry-Widgets. Die optionale Länge legt fest, wie viele Verlaufseinträge behalten werden. Das lässt sich später mit **::history::configure** ändern. Verlaufseinträge müssen mit **::history::add** hinzugefügt werden, bevor sie sichtbar sind.

**::history::remove** *pathName*
: Vergisst alle Verlaufseinträge des Entry *pathName* und entfernt die Verlaufsbindungen.

**::history::add** *pathName* *text*
: Fügt Verlaufseinträge zu einem Entry hinzu, für das zuvor **::history::init** aufgerufen wurde. Der Befehl sollte aus dem Handler des Entry mit dem Inhalt des Entry aufgerufen werden, oder mit dem, was in den Verlauf soll.

**::history::get** *pathName*
: Gibt eine Liste der Verlaufseinträge des Entry *pathName* zurück.

**::history::clear** *pathName*
: Löscht die Verlaufsliste des genannten Entry.

**::history::configure** *pathName* *option* ?value?
: Fragt Konfigurationsoptionen ab oder setzt sie. Erkannt werden *length* und *alert*. *length* bestimmt, wie viele Verlaufseinträge für das genannte Entry behalten werden. *alert* ist der Befehl, der läuft, wenn der Benutzer das Ende des Verlaufs erreicht. Die Vorgabe ist

**bell**
: . **configure** verlangt ein Argument *pathName*, die Einstellung von alert ist aber global, und der Pfad wird ignoriert.


```
entry .e
bind .e <Return> [list ProcessEntry %W]
::history::init .e
pack .e

proc ProcessEntry {w} {
    set text [$w get]
    if {$text == ""} { return }
    ::history::add $w $text
    puts $text
    $w delete 0 end
}
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *entry::history* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
