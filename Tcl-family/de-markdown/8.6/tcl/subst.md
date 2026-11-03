---
CommandName: subst
title: subst
ManualSection: n
Version: 7.4
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - Tcl(n)
 - eval(n)
 - break(n)
 - continue(n)
Keywords:
 - backslash substitution
 - command substitution
 - quoting
 - substitution
 - variable substitution
Copyright:
 - Copyright (c) 1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2001 Donal K. Fellows
---

# Name

subst - Führt Backslash-, Befehls- und Variablenersetzungen durch

# Übersicht

::: {.synopsis} :::
[subst]{.cmd} [-nobackslashes]{.optlit} [-nocommands]{.optlit} [-novariables]{.optlit} [string]{.arg}
:::

# Beschreibung

Dieser Befehl führt Variablen-, Befehls- und Backslash-Ersetzungen an seinem Argument *string* durch und gibt das vollständig substituierte Ergebnis zurück. Die Ersetzungen erfolgen genau wie bei Tcl-Befehlen. Dadurch wird das Argument *string* tatsächlich zweimal substituiert: einmal durch den Tcl-Parser wie üblich für Tcl-Befehle und erneut durch den Befehl *subst*.

Ist eine der Optionen **-nobackslashes**, **-nocommands** oder **-novariables** angegeben, werden die entsprechenden Ersetzungen nicht durchgeführt. Ist zum Beispiel **-nocommands** gesetzt, findet keine Befehlsersetzung statt: öffnende und schließende eckige Klammern gelten als normale Zeichen ohne besondere Bedeutung.

Beachten Sie, dass die Ersetzung einer Art Ersetzungen anderer Art einschließen kann. Ist zum Beispiel **-novariables** gesetzt, wird die Befehlsersetzung dennoch uneingeschränkt durchgeführt. Jede für die Befehlsersetzung nötige Variablenersetzung findet also weiter statt. Ebenso findet jede für eine Variablenersetzung nötige Befehlsersetzung statt, auch wenn **-nocommands** gesetzt ist. Siehe [Beispiele] unten.

Tritt während der Ersetzung ein Fehler auf, gibt **subst** diesen Fehler zurück. Tritt während einer Befehls- oder Variablenersetzung eine break-Ausnahme auf, ist das Ergebnis der gesamten Ersetzung die Zeichenkette (bereits substituiert) bis zum Beginn der Ersetzung, die die Ausnahme auslöste. Tritt während der Auswertung einer Befehls- oder Variablenersetzung eine continue-Ausnahme auf, wird für diese gesamte Befehls- oder Variablenersetzung eine leere Zeichenkette substituiert (sofern sie wohlgeformtes Tcl ist). Tritt eine return-Ausnahme auf oder wird während einer Befehls- oder Variablenersetzung ein anderer Rückgabecode zurückgegeben, wird der zurückgegebene Wert für diese Ersetzung eingesetzt. Siehe [Beispiele] unten. So „fängt“ **subst** alle außergewöhnlichen Rückgabecodes. Der Befehl **subst** selbst gibt entweder einen Fehler zurück oder schließt erfolgreich ab.

# Beispiele

Bei seinen Ersetzungen behandelt *subst* doppelte Anführungszeichen und geschweifte Klammern nicht besonders (außer innerhalb von Befehlsersetzungen). Das Skript

```
set a 44
subst {xyz {$a}}
```

liefert "**xyz {44}**", nicht "**xyz {$a}**", und das Skript

```
set a "p\} q \{r"
subst {xyz {$a}}
```

liefert "**xyz {p} q {r}**", nicht "**xyz {p\\} q \\{r}**".

Bei Befehlsersetzung wird jede zur Auswertung des Skripts nötige Variablenersetzung einbezogen.

```
set a 44
subst -novariables {$a [format $a]}
```

liefert "**$a 44**", nicht "**$a $a**". Bei Variablenersetzung wird entsprechend jede zum Lesen des Variablenwerts nötige Befehlsersetzung einbezogen.

```
proc b {} {return c}
array set a {c c [b] tricky}
subst -nocommands {[b] $a([b])}
```

liefert "**\[b\] c**", nicht "**\[b\] tricky**".

Die Ausnahmen continue und break erlauben Befehlsersetzungen, die Ersetzung des restlichen Befehlsteils bzw. des restlichen *string* zu verhindern und Skriptautoren mehr Möglichkeiten bei der Textverarbeitung mit *subst*. Das Skript

```
subst {abc,[break],def}
```

liefert "**abc,**", nicht "**abc,,def**", und das Skript

```
subst {abc,[continue;expr {1+2}],def}
```

liefert "**abc,,def**", nicht "**abc,3,def**".

Andere außergewöhnliche Rückgabecodes substituieren den zurückgegebenen Wert:

```
subst {abc,[return foo;expr {1+2}],def}
```

liefert "**abc,foo,def**", nicht "**abc,3,def**", und

```
subst {abc,[return -code 10 foo;expr {1+2}],def}
```

liefert ebenfalls "**abc,foo,def**", nicht "**abc,3,def**".
