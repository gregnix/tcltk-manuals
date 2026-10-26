---
CommandName: swaplist
title: swaplist
ManualSection: n
Version: 0.1
TclPart: tklib
TclDescription: A dialog which allows a user to move options between two lists
Keywords:
 - dialog
 - disjointlistbox
 - listbox
Copyright:
---

# Name

swaplist – Ein Dialog, mit dem sich Einträge zwischen zwei Listen verschieben lassen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [swaplist]{.lit} [0.1]{.optlit}
[::swaplist::swaplist]{.cmd} [pathName]{.arg} [variable]{.arg} [completeList]{.arg} [selectedList]{.arg} [options]{.optarg}
:::

# Beschreibung

Dieses Paket stellt einen Dialog aus zwei Listboxen bereit, mit Schaltflächen, die Einträge zwischen ihnen verschieben und die rechte Liste umordnen.

**::swaplist::swaplist** *pathName* *variable* *completeList* *selectedList* ?options?
: Erzeugt einen Dialog mit einem Paar Listboxen. Einträge werden ausgewählt, indem die Schaltflächen sie in die rechte Liste verschieben. Beim Schließen des Dialogs wird der Inhalt der rechten Liste in die *variable* geschrieben. Der Befehl gibt einen booleschen Wert zurück, der angibt, ob der Benutzer OK gedrückt hat. Ist -geometry nicht angegeben, wird der Dialog im übergeordneten Toplevel zentriert. Ist das übergeordnete Fenster ., wird der Dialog auf dem Bildschirm zentriert.

    Optionen:

    **-embed**
    : Ist dieses Flag angegeben, erzeugt die Prozedur ein Swaplist-Widget namens *pathName* und setzt *variable* als listvariable der rechten Listbox. Dieses Flag bewirkt außerdem, dass -title und -geometry ignoriert werden.

    **-reorder**
    : Boolescher Wert. Legt fest, ob Schaltflächen erscheinen, mit denen sich die Reihenfolge der rechten Listbox ändern lässt. Voreingestellt ist true.

    **-title**
    : Setzt den Titel des Dialogfensters. Voreingestellt ist „Configuration“.

    **-llabel**
    : Setzt die Überschrift über der linken Liste. Voreingestellt ist „Available:“.

    **-rlabel**
    : Setzt die Überschrift über der rechten Liste. Voreingestellt ist „Selected:“.

    **-lbuttontext**
    : Setzt den Text der Schaltfläche „nach links“. Voreingestellt ist „<<“.

    **-rbuttontext**
    : Setzt den Text der Schaltfläche „nach rechts“. Voreingestellt ist „>>“.

    **-ubuttontext**
    : Setzt den Text der Schaltfläche „nach oben“. Voreingestellt ist „Move Up“.

    **-dbuttontext**
    : Setzt den Text der Schaltfläche „nach unten“. Voreingestellt ist „Move Down“.

    **-geometry**
    : Setzt die Geometrie des Dialogfensters.



# Beispiel

```
package require swaplist
namespace import swaplist::*

if {[swaplist .slist opts "1 2 3 4 5 6 7 8 9" "1 3 5"]} {
    puts "user chose numbers: $opts"
}
```

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *swaplist* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Kategorie

Widget
