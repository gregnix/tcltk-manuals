---
CommandName: bindtags
title: bindtags
ManualSection: n
Version: 4.0
TclPart: Tk
TclDescription: Tk Built-In Commands
Links:
 - bind(n)
Keywords:
 - binding
 - event
 - tag
Copyright:
 - Copyright (c) 1990 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

bindtags - Legt anwendbare Bindungen und ihre Auswertungsreihenfolge fest

# Übersicht

::: {.synopsis} :::
[bindtags]{.cmd} [window]{.arg} [tagList]{.optarg}
:::

# Beschreibung

Wird eine Bindung mit dem Befehl [bind] erzeugt, wird sie entweder einem bestimmten Fenster wie **.a.b.c**, einem Klassennamen wie **Button**, dem Schlüsselwort **all** oder einer anderen Zeichenkette zugeordnet. All diese Formen heißen *Bindungs-Tags*. Jedes Fenster enthält eine Liste von Bindungs-Tags, die bestimmen, wie Ereignisse für das Fenster verarbeitet werden. Tritt ein Ereignis in einem Fenster ein, wird es nacheinander auf jedes Tag des Fensters angewendet: Für jedes Tag wird die spezifischste Bindung ausgeführt, die zum Tag und Ereignis passt. Details zum Abgleich siehe Befehl [bind].

Standardmäßig hat jedes Fenster vier Bindungs-Tags in dieser Reihenfolge: Fenstername, Klassenname des Fensters, Name des nächsten **toplevel**-Vorfahren und **all**. **toplevel**-Fenster haben standardmäßig nur drei Tags, da der Toplevel-Name mit dem Fensternamen übereinstimmt. Mit **bindtags** können die Bindungs-Tags eines Fensters gelesen und geändert werden.

Wird **bindtags** nur mit einem Argument aufgerufen, gibt der Befehl die aktuelle Bindungs-Tag-Liste von *window* als Liste zurück. Ist das Argument *tagList* angegeben, muss es eine gültige Liste sein; die Tags von *window* werden auf die Listenelemente gesetzt. Die Elemente von *tagList* dürfen beliebige Zeichenketten sein; beginnt ein Tag mit einem Punkt, wird er als Fenstername behandelt — existiert zum Zeitpunkt der Ereignisverarbeitung kein Fenster mit diesem Namen, wird das Tag für dieses Ereignis ignoriert. Die Reihenfolge der Elemente in *tagList* legt fest, in welcher Reihenfolge Bindungsskripte bei Ereignissen ausgeführt werden. Beispiel:

```
bindtags .b {all . Button .b}
```

kehrt die Auswertungsreihenfolge für einen Button **.b** um: zuerst **all**-Bindungen, dann Bindungen des Toplevels von **.b** („.“), dann Klassen-Bindungen, zuletzt Bindungen für **.b**. Ist *tagList* eine leere Liste, werden die Bindungs-Tags von *window* auf den oben beschriebenen Standard zurückgesetzt.

Mit **bindtags** lassen sich beliebige zusätzliche Bindungs-Tags einführen oder Standard-Tags entfernen. Beispiel:

```
bindtags .b {.b TrickyButton . all}
```

ersetzt den **Button**-Tag von **.b** durch **TrickyButton**. Die Standard-Widget-Bindungen für Buttons (Tag **Button**) gelten dann nicht mehr für **.b**; Bindungen für **TrickyButton** (z. B. neues Button-Verhalten) schon.

# Beispiele

Bei verschachtelten [frame]-Widgets sollen Ereignisse eines [button]-Widgets auch an alle Widgets bis zum aktuellen [toplevel] weitergegeben werden (im Gegensatz zum Tk-Standard, der Zwischenfenster auslässt) — praktisch für Beschleuniger, die nur für einen Teil des Fensters aktiv sind. Hilfsprozedur:

```
proc setupBindtagsForTreeDelivery {widget} {
    set tags [list $widget [winfo class $widget]]
    set w $widget
    set t [winfo toplevel $w]
    while {$w ne $t} {
        set w [winfo parent $w]
        lappend tags $w
    }
    lappend tags all
    bindtags $widget $tags
}
```


[bind]: bind.md
[button]: button.md
[frame]: frame.md
[toplevel]: toplevel.md
