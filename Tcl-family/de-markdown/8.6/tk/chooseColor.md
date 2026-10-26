---
CommandName: tk_chooseColor
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

# NAME

tk_chooseColor - Zeigt einen Dialog zur Farbauswahl an

# ÜBERSICHT

::: {.synopsis} :::
[tk_chooseColor]{.cmd} [option value]{.optdot} 
:::

# BESCHREIBUNG

Die Prozedur **tk_chooseColor** zeigt einen Dialog an, in dem der Benutzer eine Farbe auswählen kann. Folgende *option-value*-Paare sind als Befehlszeilenargumente möglich:

**-initialcolor** *color*
: Legt fest, welche Farbe beim Öffnen des Farbdialogs angezeigt wird. *color* muss in einer für die Funktion **Tk_GetColor** akzeptablen Form vorliegen.

**-parent** *window*
: Macht *window* zum logischen Elternfenster des Farbdialogs. Der Farbdialog wird über seinem Elternfenster angezeigt.

**-title** *titleString*
: Legt eine Zeichenkette fest, die als Titel des Dialogfelds angezeigt wird. Wird diese Option nicht angegeben, wird ein Standardtitel angezeigt. Wenn der Benutzer eine Farbe auswählt, gibt **tk_chooseColor** den Namen der Farbe in einer für **Tk_GetColor** akzeptablen Form zurück. Bricht der Benutzer den Vorgang ab, gibt der Befehl eine leere Zeichenkette zurück.


# BEISPIEL

```
button .b \-bg [tk_chooseColor \-initialcolor gray \-title "Choose color"]
```
