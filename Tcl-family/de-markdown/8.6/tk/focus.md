---
CommandName: focus
title: focus
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Keywords:
 - events
 - focus
 - keyboard
 - top-level
 - window manager
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

focus - Verwaltung des Eingabefokus

# Übersicht

::: {.synopsis} :::
[focus]{.cmd}
[focus]{.cmd} [window]{.arg}
[focus]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Der Befehl **focus** verwaltet den Tk-Eingabefokus. Zu jedem Zeitpunkt ist auf jedem Display genau ein Fenster als *Fokusfenster* festgelegt; alle Tastendruck- und Tastenloslass-Ereignisse für dieses Display werden an dieses Fenster gesendet. Normalerweise leitet der Fenstermanager den Fokus zwischen den Toplevel-Fenstern eines Displays um. Einige Fenstermanager setzen den Eingabefokus beispielsweise automatisch auf ein Toplevel-Fenster, sobald die Maus hineinbewegt wird; andere geben den Fokus erst um, wenn der Benutzer auf ein Fenster klickt. Üblicherweise setzt der Fenstermanager den Fokus nur auf Toplevel-Fenster; die Anwendung leitet den Fokus unter den Kindern des Toplevels selbst um.

Tk merkt sich für jedes Toplevel ein Fokusfenster (den zuletzt fokussierten Nachkommen dieses Toplevels). Gibt der Fenstermanager einem Toplevel den Fokus, leitet Tk ihn automatisch auf das gemerkte Fenster um. Innerhalb eines Toplevels verwendet Tk standardmäßig ein *explizites* Fokusmodell: Das Bewegen der Maus innerhalb eines Toplevels ändert den Fokus normalerweise nicht; er wechselt nur, wenn ein Widget den Fokus ausdrücklich anfordert (z. B. durch einen Mausklick auf einen Button) oder wenn der Benutzer eine Taste wie Tab drückt, die den Fokus verschiebt.

Die Tcl-Prozedur [tk\_focusFollowsMouse][focusNext] kann aufgerufen werden, um ein *implizites* Fokusmodell einzurichten: Tk wird so konfiguriert, dass ein Fenster den Fokus erhält, sobald die Maus hineinbewegt wird. Die Tcl-Prozeduren [tk\_focusNext][focusNext] und [tk\_focusPrev][focusNext] implementieren eine Fokusreihenfolge unter den Fenstern eines Toplevels; sie werden unter anderem in den Standard-Bindings für Tab und Shift-Tab verwendet.

Der Befehl **focus** kann eine der folgenden Formen annehmen:

**focus**
: Gibt den Pfadnamen des Fokusfensters auf dem Display zurück, das das Hauptfenster der Anwendung enthält, oder eine leere Zeichenkette, wenn kein Fenster dieser Anwendung auf diesem Display den Fokus hat. Hinweis: Es ist besser, das Display ausdrücklich mit **-displayof** anzugeben (siehe unten), damit der Code in Anwendungen mit mehreren Displays funktioniert.

**focus** *window*
: Hat die Anwendung derzeit den Eingabefokus auf dem Display von *window*, setzt dieser Befehl den Eingabefokus für das Display von *window* auf *window* und gibt eine leere Zeichenkette zurück. Hat die Anwendung den Eingabefokus auf dem Display von *window* derzeit nicht, wird *window* als Fokusfenster für sein Toplevel gemerkt; beim nächsten Erhalt des Fokus durch das Toplevel leitet Tk ihn auf *window* um. Ist *window* eine leere Zeichenkette, bewirkt der Befehl nichts.

**focus -displayof** *window*
: Gibt den Namen des Fokusfensters auf dem Display zurück, das *window* enthält. Liegt das Fokusfenster für das Display von *window* nicht in dieser Anwendung, ist der Rückgabewert eine leere Zeichenkette.

**focus -force** *window*
: Setzt den Fokus des Displays von *window* auf *window*, auch wenn die Anwendung derzeit nicht den Eingabefokus für dieses Display hat. Dieser Befehl sollte sparsam oder gar nicht verwendet werden. In normaler Nutzung sollte eine Anwendung den Fokus nicht selbst beanspruchen, sondern darauf warten, dass der Fenstermanager ihn vergibt. Ist *window* eine leere Zeichenkette, bewirkt der Befehl nichts.

**focus -lastfor** *window*
: Gibt den Namen des zuletzt den Eingabefokus gehabten Fensters unter allen Fenstern im selben Toplevel wie *window* zurück. Hat noch kein Fenster in diesem Toplevel den Eingabefokus gehabt oder wurde das zuletzt fokussierte Fenster gelöscht, wird der Name des Toplevels zurückgegeben. Der Rückgabewert ist das Fenster, das den Eingabefokus erhält, sobald der Fenstermanager dem Toplevel das nächste Mal den Fokus gibt.


# Besonderheiten

Erhält ein internes Fenster den Eingabefokus, setzt Tk den X-Fokus nicht tatsächlich auf dieses Fenster; aus Sicht von X bleibt der Fokus auf dem Toplevel-Fenster, das das fokussierte Fenster enthält. Tk erzeugt jedoch FocusIn- und FocusOut-Ereignisse, als ob der X-Fokus auf dem internen Fenster läge. Dieser Ansatz umgeht eine Reihe von Problemen, die entstünden, wenn der X-Fokus wirklich verschoben würde; dass der X-Fokus auf dem Toplevel liegt, ist unsichtbar, sofern der X-Server nicht direkt per C-Code abgefragt wird.

# Beispiele

Um ein Fenster nur dann in den Fokus-Traversierungsring einzubeziehen, wenn eine Variable gesetzt ist, fügen Sie die folgenden Bindings den Widgets *vor* und *nach* diesem Fenster im Ring hinzu:

```
button .before -text "Before"
button .middle -text "Middle"
button .after  -text "After"
checkbutton .flag -variable traverseToMiddle -takefocus 0
pack .flag -side left
pack .before .middle .after
bind .before <Tab> {
   if {!$traverseToMiddle} {
      focus .after
      break
   }
}
bind .after <Shift-Tab> {
   if {!$traverseToMiddle} {
      focus .before
      break
   }
}
focus .before
```


[focusNext]: focusNext.md
