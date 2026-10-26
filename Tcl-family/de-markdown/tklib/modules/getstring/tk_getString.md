---
CommandName: getstring
title: getstring
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: A dialog which prompts for a string input
Keywords:
 - dialog
 - entry
 - string
Copyright:
---

# Name

getstring – Ein Dialogfeld für Zeichenfolgen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [getstring]{.lit} [0.1]{.optlit}
[::getstring::tk\_getString]{.cmd} [pathName]{.arg} [variable]{.arg} [text]{.arg} [options]{.optarg}
:::

# Beschreibung

Dieses Paket stellt ein Dialogfeld bereit, das aus einem Entry sowie den Schaltflächen OK und Abbrechen besteht.

**::getstring::tk\_getString** *pathName* *variable* *text* ?options?
: Erstellt ein Dialogfeld, das den Benutzer mit *text* zur Eingabe einer Zeichenkette auffordert. Der Inhalt des Entry wird beim Schließen des Dialogs in die *variable* geschrieben. Der Befehl gibt einen booleschen Wert zurück, der angibt, ob der Benutzer OK gedrückt hat. Wenn -geometry nicht angegeben ist, wird der Dialog im übergeordneten Toplevel zentriert, außer das übergeordnete Fenster ist . ; dann wird der Dialog auf dem Bildschirm zentriert. Optionen: -title -allowempty, ein boolesches Argument, das angibt, ob der Dialog eine leere Eingabe akzeptiert. -entryoptions gibt seine Argumente an das Entry-Widget weiter. Das ist nützlich für zusätzliche Prüfungen über die Validierungs-Hooks des Entry-Widgets. -geometry legt die Geometrie des Fensters fest.


# Beispiel

```
package require getstring
namespace import getstring::*

if {[tk_getString .gs text "Feed me a string please:"]} {
    puts "user entered: $text"
}
```

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *getstring* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
