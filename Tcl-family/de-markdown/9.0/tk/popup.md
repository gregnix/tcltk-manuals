---
CommandName: tk_popup
title: tk_popup
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - bind(n)
 - menu(n)
 - tk_optionMenu(n)
Keywords:
 - menu
 - popup
Copyright:
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

tk\_popup - Blendet ein Popup-Menü ein

# Übersicht

::: {.synopsis} :::
[tk\_popup]{.cmd} [menu]{.arg} [x]{.arg} [y]{.arg} [entry]{.optarg}
:::

# Beschreibung

Diese Prozedur blendet ein Menü an einer gegebenen Bildschirmposition ein und konfiguriert Tk so, dass das Menü und seine kaskadierten Kindmenüs mit Maus oder Tastatur durchlaufen werden können. *Menu* ist der Name eines Menü-Widgets; *x* und *y* sind die Root-Koordinaten, an denen das Menü angezeigt wird. Wird *entry* weggelassen oder ist es eine leere Zeichenkette, wird die obere linke Ecke des Menüs an den angegebenen Punkt positioniert. Andernfalls gibt *entry* den Index eines Eintrags in *menu* an, und das Menü wird so positioniert, dass dieser Eintrag über dem angegebenen Punkt liegt.

# Beispiel

So bindet man ein einfaches Popup-Menü an ein Widget.

```
# Menü erzeugen
set m [menu .popupMenu]
$m add command -label "Example 1" -command bell
$m add command -label "Example 2" -command bell

# Ziel-Widget erzeugen
pack [label .l -text "Click me!"]

# Menü beim Klick auf das Label einblenden
bind .l <Button-1> {tk_popup .popupMenu %X %Y}
```
