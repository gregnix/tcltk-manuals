---
CommandName: tk_chooseColor
title: tk_chooseColor
ManualSection: n
Version: 4.2
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - color
 - color selection
 - dialog
Copyright:
 - Copyright (c) 1996 Sun Microsystems, Inc.
---

# Name

tk\_chooseColor - Zeigt einen Dialog zur Farbauswahl an

# Übersicht

::: {.synopsis} :::
[tk\_chooseColor]{.cmd} [option value]{.optdot}
:::

# Beschreibung

Die Prozedur **tk\_chooseColor** zeigt einen Dialog an, in dem der Benutzer eine Farbe auswählen kann. Folgende *option-value*-Paare sind als Befehlszeilenargumente möglich:

[-initialcolor]{.lit} [color]{.arg}
: Legt fest, welche Farbe beim Öffnen des Farbdialogs angezeigt wird. *color* muss in einer für die Funktion [Tk\_GetColor][GetColor] akzeptablen Form vorliegen.

[-parent]{.lit} [window]{.arg}
: Macht *window* zum logischen Elternfenster des Farbdialogs. Der Farbdialog wird über seinem Elternfenster angezeigt.

[-title]{.lit} [titleString]{.arg}
: Legt eine Zeichenkette fest, die als Titel des Dialogfelds angezeigt wird. Wird diese Option nicht angegeben, wird ein Standardtitel angezeigt.

Wenn der Benutzer eine Farbe auswählt, gibt **tk\_chooseColor** den Namen der Farbe in einer für [Tk\_GetColor][GetColor] akzeptablen Form zurück. Bricht der Benutzer den Vorgang ab, gibt der Befehl eine leere Zeichenkette zurück.


# Beispiel

```
button .b -bg [tk_chooseColor -initialcolor gray -title "Choose color"]
```


[GetColor]: ../tk-c/GetColor.md
