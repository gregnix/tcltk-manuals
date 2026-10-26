---
CommandName: tk_dialog
ManualSection: n
Version: 4.1
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - tk_messageBox(n)
Keywords:
 - bitmap
 - dialog
 - modal
Copyright:
 - Copyright (c) 1992 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

tk_dialog - Erstellt einen modalen Dialog und wartet auf die Antwort

# ÜBERSICHT

::: {.synopsis} :::
[tk_dialog]{.cmd} [window]{.arg} [title]{.arg} [text]{.arg} [bitmap]{.arg} [default]{.arg} [string]{.arg} [string]{.arg} [...]{.arg} 
:::

# BESCHREIBUNG

Diese Prozedur gehört zur Tk-Skriptbibliothek. Sie ist weitgehend durch **tk_messageBox** *veraltet*. Ihre Argumente beschreiben ein Dialogfeld:

*window*
: Name des Toplevel-Fensters für den Dialog. Ein bereits vorhandenes Fenster mit diesem Namen wird zerstört.

*title*
: Text in der Titelleiste des Fenstermanagers für den Dialog.

*text*
: Meldung im oberen Bereich des Dialogfelds.

*bitmap*
: Wenn nicht leer, legt dies ein Bitmap fest (in einer für **Tk_GetBitmap** geeigneten Form), das im oberen Bereich des Dialogs links neben dem Text angezeigt wird. Bei einer leeren Zeichenkette wird kein Bitmap angezeigt.

*default*
: Ist dies eine ganze Zahl größer oder gleich null, gibt sie den Index des Standard-Buttons für den Dialog an (0 für den linken Button usw.). Ist der Wert negativ oder eine leere Zeichenkette, gibt es keinen Standard-Button.

*string*
: Für jedes dieser Argumente gibt es einen Button. Jede *string*-Angabe legt den auf dem Button anzuzeigenden Text fest, von links nach rechts.


Nach dem Erzeugen des Dialogfelds wartet **tk_dialog**, bis der Benutzer einen der Buttons wählt — per Mausklick oder durch Drücken von Return für den Standard-Button (falls vorhanden). Anschließend gibt der Befehl den Index des gewählten Buttons zurück: 0 für den linken, 1 für den nächsten usw. Wird das Dialogfenster zerstört, bevor der Benutzer einen Button wählt, wird -1 zurückgegeben.

Während des Wartens setzt **tk_dialog** einen lokalen Grab. Der Benutzer kann die Anwendung dann nur noch über das Dialogfeld bedienen.

# BEISPIEL

```
set reply [tk_dialog .foo "The Title" "Do you want to say yes?" \
        questhead 0 Yes No "I'm not sure"]
```
