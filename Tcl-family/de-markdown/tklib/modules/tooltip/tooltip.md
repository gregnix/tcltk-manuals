---
CommandName: tooltip
title: tooltip
ManualSection: n
Version: 2.0.4
TclPart: tklib
TclDescription: Tooltip management
Keywords:
 - balloon
 - help
 - hover
 - tooltip
Copyright:
 - Copyright (c) 1996-2008, Jeffrey Hobbs
 - Copyright (c) 2024 Emmanuel Frecon
---

# Name

tooltip – Verwaltung von Tooltips

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[package]{.cmd} [require]{.sub} [tooltip]{.lit} [2.0.4]{.optlit}
[::tooltip::tooltip]{.cmd} [command]{.arg} [options]{.optarg}
[::tooltip::tooltip]{.cmd} [pathName]{.arg} [option value...]{.optarg} [--]{.optlit} [message]{.arg}
:::

# Beschreibung

Dieses Paket bietet Tooltips, d. h. kurze Textmeldungen, die angezeigt werden können, wenn der Mauszeiger über ein Widget, einen Menüpunkt, ein Canvas-Element, einen Listbox-Eintrag, einen Eintrag oder eine Spaltenüberschrift von ttk::treeview, eine Registerkarte von ttk::notebook oder ein Text-Widget-Tag bewegt wird.

# Befehle

**::tooltip::tooltip** *command* ?*options*?
: Verwaltet das Paket tooltip über die folgenden Unterbefehle.

    **clear** ?*pattern*?
    : Verhindert, dass die festgelegten Widgets Tooltips anzeigen. *pattern* ist ein Glob-Muster und passt standardmäßig auf alle Widgets.

    **configure** ?*option* ?*value option value* ...??
    : Fragt die Konfigurationsoptionen des Tooltips ab oder ändert sie. Unterstützt werden **-backgroud**, **-foreground** und **-font**. Ohne *option* gibt der Befehl ein Dictionary der Optionswerte zurück. Mit einer *option* ohne Wert gibt er den Wert dieser Option zurück. Sonst setzt er die angegebenen *option*s auf die zugehörigen *value*s.

    **delay** ?*millisecs*?
    : Fragt die Hover-Verzögerung ab oder setzt sie. Das ist die Zeit, die der Zeiger über dem Widget bleiben muss, bevor der Tooltip erscheint. Die Verzögerung wird in Millisekunden angegeben und muss mindestens 50 ms betragen. Ohne Argument wird die aktuelle Verzögerung zurückgegeben.

    **fade** ?*boolean*?
    : Schaltet das Ausblenden des Tooltips ein oder aus. Unter Win32 und Aqua ist das Ausblenden vorgegeben. Bei Leave-Ereignissen blendet der Tooltip aus, anstatt zu verschwinden.

    **disable**
    : siehe unten ...

    **off**
    : Alle Tooltips deaktivieren

    **enable**
    : siehe unten ...

    **on**
    : Aktiviert Tooltips für definierte Widgets.


**::tooltip::tooltip** *pathName* ?*option value*...? ?**--**? *message*
: Sorgt dafür, dass das Widget *pathName* einen Tooltip mit *message* anzeigt.

    Ist das Widget ein **menu**, **canvas**, **listbox**, **ttk::treeview**, **ttk::notebook** oder **text**, binden zusätzliche Optionen den Tooltip an bestimmte Menü-, Canvas- oder Listbox-Einträge, ttk::treeview-Einträge oder Spaltenüberschriften, ttk::notebook-Registerkarten oder Text-Tags.

    **-heading** *columnId*
    : Setzt einen Tooltip für eine Spaltenüberschrift eines ttk::treeview. Die Spalte muss noch nicht vorhanden sein. Dieselben Bezeichner sollten nicht zugleich für Spalten und Einträge eines Widgets verwendet werden, sonst vermischen sich die Tooltips. Das Widget muss ein ttk::treeview sein.

    **-image** *image*
    : Das angegebene Bild (photo) erscheint links neben der primären Tooltip-*message*.

    **-index** *index*
    : Mit dieser Option können Sie einen Tooltip für einen Menüpunkt festlegen. Der Index kann entweder der Eintragsindex oder die Eintragsbezeichnung sein. Das Widget muss ein Menü-Widget sein, die Einträge müssen jedoch zum Zeitpunkt der Festlegung des Tooltips nicht vorhanden sein.

    **-info** *info*
    : Der angegebene Text *info* erscheint als zusätzliche Angabe unter der primären Tooltip-*message*.

    **-items** *items*
    : Diese Option dient dazu, einen Tooltip für Elemente im Canvas, in der listbox oder ttk::treview festzulegen. Beim Canvas-Widget muss das Element bereits im Canvas vorhanden sein und wird über eine **find withtag**-Abfrage ermittelt. Bei Listbox- und ttk::treview-Widgets können die Elemente zu einem späteren Zeitpunkt erstellt werden; der Programmierer ist jedoch dafür verantwortlich, die Verknüpfung zwischen dem Index des Listbox- oder ttk::treview-Elements und dem entsprechenden Tooltip zu verwalten. Wenn die Elemente der Listbox oder von ttk::treview neu angeordnet werden, müssen die Tooltips angepasst werden.

        Handelt es sich bei dem Widget nicht um ein Canvas-, Listbox- oder ttk::treview-Widget, wird ein Fehler ausgelöst.

    **-tab** *tabId*
    : Setzt einen Tooltip für eine Registerkarte eines ttk::notebook. Die Registerkarte muss beim Aufruf schon vorhanden sein, sonst wird ein Fehler zurückgegeben. Das Widget muss ein ttk::notebook sein.

    **-tag** *name*
    : Setzt einen Tooltip für ein Tag eines Text-Widgets. Das Tag muss beim Aufruf schon vorhanden sein, sonst wird ein Fehler zurückgegeben. Das Widget muss ein Text-Widget sein.

    **--**
    : Die Option **--** markiert das Ende der Optionen. Das darauf folgende Argument wird als *message* behandelt, selbst wenn es mit **-** beginnt.



# Beispiel

```
# Demonstrate widget tooltip
package require tooltip
pack [label .l -text "label"]
tooltip::tooltip .l "This is a label widget"
```

```
# Demonstrate menu tooltip
package require tooltip
. configure -menu [menu .menu]
.menu add cascade -label Test -menu [menu .menu.test -tearoff 0]
.menu.test add command -label Tooltip
tooltip::tooltip .menu.test -index 0 "This is a menu tooltip"
```

```
# Demonstrate canvas item tooltip
package require tooltip
pack [canvas .c]
set item [.c create rectangle 10 10 80 80 -fill red]
tooltip::tooltip .c -item $item "Canvas item tooltip"
```

```
# Demonstrate listbox item tooltip
package require tooltip
pack [listbox .lb]
.lb insert 0 "item one"
tooltip::tooltip .lb -item 0 "Listbox item tooltip"
```

```
# Demonstrate ttk::notebook tab tooltip
package require tooltip
pack [ttk::notebook .nb]
.nb add [frame .nb.f1 -height 50] -text "First tab"
.nb add [frame .nb.f2 -height 50] -text "Second tab"
tooltip::tooltip .nb -tab 0 "Tooltip for the 1st notebook tab"
tooltip::tooltip .nb -tab 1 "Tooltip for the 2nd notebook tab"
```

```
# Demonstrate text tag tooltip
package require tooltip
pack [text .txt]
.txt tag configure TIP-1 -underline 1
tooltip::tooltip .txt -tag TIP-1 "tooltip one text"
.txt insert end "An example of a " {} "tooltip" TIP-1 " tag.\n" {}
```

# Migration von Version 1

Die Versionen 1.3 bis 1.7 riefen vor der Anzeige eines Tooltips die Funktion **msgcat::mc** auf und verwendeten dabei den Tooltip-Namespace. **msgcat::mc** benötigt die Umgebung des Aufrufers. Aus diesem Grund wurde in Version 1.8 der Namespace des Aufrufers erfasst und bei dem Aufruf verwendet. In Version 2.0 wurde jegliche Unterstützung für **msgcat::mc** entfernt. Die Optionen **-namespace**, **-msgargs** und **-infoargs** wurden entfernt. Ab TCL 8.7 unterstützt **msgcat::mc** OO-Klassen und OO-Methoden. Allerdings ist die OO-Aufruferumgebung nicht vorhanden, wenn **msgcat::mc** bei der Anzeige von Tooltips aufgerufen wurde, was zu Fehlern in der Laufzeit führte. Es wurde als schlechtes Design bewertet, **msgcat::mc** zu spät aufzurufen. Der Aufrufer sollte die Tooltips bei einer eventuellen Änderung der Meldung neu installieren.

# Fehler, Ideen, Rückmeldungen

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *tooltip* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# Copyright

```
Copyright (c) 1996-2008, Jeffrey Hobbs
Copyright (c) 2024 Emmanuel Frecon
```
