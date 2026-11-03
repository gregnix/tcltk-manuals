---
CommandName: after
title: after
ManualSection: n
Version: 7.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - concat(n)
 - interp(n)
 - update(n)
 - vwait(n)
Keywords:
 - cancel
 - delay
 - idle callback
 - sleep
 - time
Copyright:
 - Copyright (c) 1990-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

after - Führt einen Befehl nach einer Zeitverzögerung aus

# Übersicht

::: {.synopsis} :::
[after]{.cmd} [ms]{.arg}
[after]{.cmd} [ms]{.arg} [script script script]{.optdot}
[after]{.cmd} [cancel]{.sub} [id]{.arg}
[after]{.cmd} [cancel]{.sub} [script]{.arg} [script]{.arg} [script]{.arg} [...]{.arg}
[after]{.cmd} [idle]{.sub} [script script script]{.optdot}
[after]{.cmd} [info]{.sub} [id]{.optarg}
:::

# Beschreibung

Dieser Befehl dient dazu, die Ausführung des Programms zu verzögern oder einen Befehl irgendwann in der Zukunft im Hintergrund auszuführen. Er hat mehrere Formen, abhängig vom ersten Argument des Befehls:

[after]{.cmd} [ms]{.arg}
: *ms* muss eine Ganzzahl sein, die eine Zeit in Millisekunden angibt. Eine negative Zahl wird wie 0 behandelt. Der Befehl schläft *ms* Millisekunden lang und kehrt dann zurück. Während der Befehl schläft, reagiert die Anwendung nicht auf Ereignisse.

[after]{.cmd} [ms]{.arg} [script script script]{.optdot}
: In dieser Form kehrt der Befehl sofort zurück, sorgt aber dafür, dass ein Tcl-Befehl *ms* Millisekunden später als Ereignisbehandler ausgeführt wird. Der Befehl wird genau einmal zum angegebenen Zeitpunkt ausgeführt. Der verzögerte Befehl entsteht, indem alle *script*-Argumente auf dieselbe Weise verkettet werden wie beim Befehl [concat]. Der Befehl wird auf globaler Ebene ausgeführt (außerhalb des Kontexts jeder Tcl-Prozedur). Tritt beim Ausführen des verzögerten Befehls ein Fehler auf, wird der Hintergrundfehler von dem Befehl gemeldet, der mit [interp bgerror][interp] registriert ist. Der Befehl **after** gibt einen Bezeichner zurück, mit dem sich der verzögerte Befehl über **after cancel** abbrechen lässt. Ein *ms*-Wert von 0 (oder ein negativer Wert) reiht das Ereignis sofort ein, und zwar mit Vorrang vor anderen Ereignistypen (sofern diese nicht mit einer Ereignisprozedur installiert wurden, die auf die nächste Runde von Ereignissen wartet).

[after]{.cmd} [cancel]{.sub} [id]{.arg}
: Bricht die Ausführung eines verzögerten Befehls ab, der zuvor eingeplant wurde. *id* gibt an, welcher Befehl abgebrochen werden soll; es muss der Rückgabewert eines früheren **after**-Befehls sein. Wurde der durch *id* bezeichnete Befehl bereits ausgeführt, hat der Befehl **after cancel** keine Wirkung.

[after]{.cmd} [cancel]{.sub} [script]{.arg} [script]{.arg} [...]{.arg}
: Auch dieser Befehl bricht die Ausführung eines verzögerten Befehls ab. Die *script*-Argumente werden mit Leerzeichen als Trennzeichen verkettet (genau wie beim Befehl [concat]). Gibt es einen ausstehenden Befehl, der zu dieser Zeichenkette passt, wird er abgebrochen und nie ausgeführt. Ist derzeit kein solcher Befehl ausstehend, hat der Befehl **after cancel** keine Wirkung.

[after]{.cmd} [idle]{.sub} [script]{.arg} [script script]{.optdot}
: Verkettet die *script*-Argumente mit Leerzeichen als Trennzeichen (genau wie beim Befehl [concat]) und sorgt dafür, dass das entstandene Skript später als Idle-Rückruffunktion ausgewertet wird. Das Skript wird genau einmal ausgeführt, und zwar beim nächsten Mal, wenn die Ereignisschleife betreten wird und keine Ereignisse zu verarbeiten sind. Der Befehl gibt einen Bezeichner zurück, mit dem sich der verzögerte Befehl über **after cancel** abbrechen lässt. Tritt beim Ausführen des Skripts ein Fehler auf, wird der Hintergrundfehler von dem Befehl gemeldet, der mit [interp bgerror][interp] registriert ist.

[after]{.cmd} [info]{.sub} [id]{.optarg}
: Dieser Befehl gibt Informationen über vorhandene Ereignisbehandler zurück. Wird kein Argument *id* angegeben, gibt der Befehl eine Liste der Bezeichner aller vorhandenen Ereignisbehandler zurück, die der Befehl **after** für diesen Interpreter erzeugt hat. Wird *id* angegeben, bezeichnet es einen vorhandenen Behandler. *id* muss der Rückgabewert eines früheren Aufrufs von **after** sein, und der Behandler darf noch nicht ausgelöst oder abgebrochen worden sein. In diesem Fall gibt der Befehl eine Liste mit zwei Elementen zurück. Das erste Element der Liste ist das Skript, das zu *id* gehört. Das zweite Element ist entweder **idle** oder **timer** und gibt an, um welche Art von Ereignisbehandler es sich handelt.


Die Formen **after** *ms* und **after idle** des Befehls setzen voraus, dass die Anwendung ereignisgesteuert ist: Die verzögerten Befehle werden nur ausgeführt, wenn die Anwendung die Ereignisschleife betritt. In Anwendungen, die normalerweise nicht ereignisgesteuert sind, etwa [tclsh], lässt sich die Ereignisschleife mit den Befehlen [vwait] und [update] betreten.

# Beispiele

Dies definiert einen Befehl, der Tcl *N* Sekunden lang überhaupt nichts tun lässt:

```
proc sleep {N} {
    after [expr {int($N * 1000)}]
}
```

Dies sorgt dafür, dass der Befehl *wake\_up* in acht Stunden ausgeführt wird (vorausgesetzt, die Ereignisschleife ist zu diesem Zeitpunkt aktiv):

```
after [expr {1000 * 60 * 60 * 8}] wake_up
```

Mit dem folgenden Befehl lassen sich lang laufende Berechnungen schrittweise durchführen (hier dargestellt durch *::my\_calc::one\_step*; es wird angenommen, dass dieser Befehl einen booleschen Wert zurückgibt, der angibt, ob ein weiterer Schritt ausgeführt werden soll). Die Berechnung selbst muss dafür allerdings so aufgebaut sein, dass sie schrittweise arbeiten kann. Diese Technik achtet besonders darauf, dass die Ereignisschleife durch das erneute Einplanen der Verarbeitungsschritte nicht ausgehungert wird (der nächste Schritt wird erst dann über ein bereits ausgelöstes Timer-Ereignis eingeplant, wenn die Ereigniswarteschlange abgearbeitet ist). Sie ist nützlich, wenn Sie sicherstellen wollen, dass eine Tk-Oberfläche während einer langsamen Aufgabe bedienbar bleibt.

```
proc doOneStep {} {
    if {[::my_calc::one_step]} {
        after idle [list after 0 doOneStep]
    }
}
doOneStep
```


[concat]: concat.md
[interp]: interp.md
[tclsh]: tclsh.md
[update]: update.md
[vwait]: vwait.md
