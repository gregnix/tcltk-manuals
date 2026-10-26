---
CommandName: simulation::montecarlo
title: simulation::montecarlo
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Tcl Simulation Tools
Keywords:
 - math
 - montecarlo simulation
 - stochastic modelling
Copyright:
 - Copyright (c) 2008 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

simulation::montecarlo – Monte-Carlo-Simulationen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5 9]{.optlit}
[package]{.cmd} [require]{.sub} [simulation::montecarlo]{.lit} [0.2]{.lit}
[package]{.cmd} [require]{.sub} [simulation::random]{.lit}
[package]{.cmd} [require]{.sub} [math::statistics]{.lit}
[::simulation::montecarlo::getOption]{.cmd} [keyword]{.arg}
[::simulation::montecarlo::hasOption]{.cmd} [keyword]{.arg}
[::simulation::montecarlo::setOption]{.cmd} [keyword]{.arg} [value]{.arg}
[::simulation::montecarlo::setTrialResult]{.cmd} [values]{.arg}
[::simulation::montecarlo::setExpResult]{.cmd} [values]{.arg}
[::simulation::montecarlo::getTrialResults]{.cmd}
[::simulation::montecarlo::getExpResult]{.cmd}
[::simulation::montecarlo::transposeData]{.cmd} [values]{.arg}
[::simulation::montecarlo::integral2D]{.cmd} [...]{.arg}
[::simulation::montecarlo::singleExperiment]{.cmd} [args]{.arg}
:::

# Beschreibung

Das Prinzip der *Monte-Carlo-Simulationen* ist im Grunde genommen einfach:

- Zufallswerte für einen oder mehrere Parameter erzeugen.

- Das Modell eines interessierenden Systems auswerten und die interessanten Ergebnisse für jede Realisierung dieser Parameter festhalten.

- Nach einer geeigneten Anzahl solcher Versuche eine Gesamteigenschaft des Modells ableiten.


Denkbar ist ein Modell eines Rechnernetzes, ein Ökosystem oder überhaupt alles, was sich quantitativ beschreiben lässt und ein stochastisches Element enthält.

Das Paket *simulation::montecarlo* bietet einen grundlegenden Rahmen für ein solches Modellierungsverfahren:

```
#
# MC experiments:
# Determine the mean and median of a set of points and compare them
#
::simulation::montecarlo::singleExperiment -init {
    package require math::statistics

    set prng [::simulation::random::prng_Normal 0.0 1.0]
} -loop {
    set numbers {}
    for { set i 0 } { $i < [getOption samples] } { incr i } {
        lappend numbers [$prng]
    }
    set mean   [::math::statistics::mean $numbers]
    set median [::math::statistics::median $numbers] ;# ? Exists?
    setTrialResult [list $mean $median]
} -final {
    set result [getTrialResults]
    set means   {}
    set medians {}
    foreach r $result {
        foreach {m M} $r break
        lappend means   $m
        lappend medians $M
    }
    puts [getOption reportfile] "Correlation: [::math::statistics::corr $means $medians]"

} -trials 100 -samples 10 -verbose 1 -columns {Mean Median}
```

In diesem Beispiel soll untersucht werden, inwieweit der Medianwert und der Mittelwert einer zufälligen Zahlenmenge miteinander korrelieren. Manchmal ist der Medianwert ein robusteres Merkmal als der Mittelwert – insbesondere bei einer statistischen Verteilung mit „dicken“ Schwänzen.

# Prozeduren

Das Paket definiert die folgenden Hilfsprozeduren:

**::simulation::montecarlo::getOption** *keyword*
: Ruft den Wert einer Option ab, die als Teil des Befehls *singleExperiment* angegeben wurde.

    string *keyword*
    : Angegebenes Schlüsselwort (ohne vorangestelltes Minuszeichen)


**::simulation::montecarlo::hasOption** *keyword*
: Gibt 1 zurück, wenn die Option vorhanden ist, andernfalls 0.

    string *keyword*
    : Angegebenes Schlüsselwort (ohne vorangestelltes Minuszeichen)


**::simulation::montecarlo::setOption** *keyword* *value*
: Setzt den Wert der angegebenen Option.

    string *keyword*
    : Angegebenes Schlüsselwort (ohne vorangestelltes Minuszeichen)

    string *value*
    : (Neuer) Wert der Option


**::simulation::montecarlo::setTrialResult** *values*
: Speichert die Ergebnisse des Versuchs zur späteren Auswertung

    list *values*
    : Liste der zu speichernden Werte


**::simulation::montecarlo::setExpResult** *values*
: Setzt die Ergebnisse des gesamten Experiments (üblicherweise in der Abschlussphase).

    list *values*
    : Liste der zu speichernden Werte


**::simulation::montecarlo::getTrialResults**
: Ruft die Ergebnisse aller einzelnen Versuche zur Auswertung ab (üblicherweise in der Abschlussphase oder nach Abschluss des Befehls).

**::simulation::montecarlo::getExpResult**
: Ruft die Ergebnisse des gesamten Experiments ab (üblicherweise in der Abschlussphase oder auch nach Ausführung des Befehls *singleExperiment*).

**::simulation::montecarlo::transposeData** *values*
: Vertauscht Spalten und Zeilen einer Liste von Listen und gibt das Ergebnis zurück.

    list *values*
    : Liste von Listen von Werten



Es gibt zwei Hauptprozeduren: *integral2D* und *singleExperiment*.

**::simulation::montecarlo::integral2D** *...*
: Integriert eine Funktion über einen zweidimensionalen Bereich mit einem Monte-Carlo-Verfahren.

    Argumente: PM

**::simulation::montecarlo::singleExperiment** *args*
: Führt den Code über eine Anzahl von Versuchen aus und speichert die Ergebnisse. Die Iteration wird durch Parameter gesteuert, die über eine Liste von Schlüsselwort-Wert-Paaren vorgegeben werden.

    int *n*
    : Liste von Schlüsselwort-Wert-Paaren, die während der Ausführung alle über den Befehl *getOption* abrufbar sind.



Der Befehl *singleExperiment* legt die folgenden Optionen vordefiniert fest:

- *-init code*: Code, der zu Beginn ausgeführt wird

- *-loop body*: Prozedurrumpf, der die wiederholt auszuführende Berechnung definiert. Der Code soll *setTrialResult* verwenden, um die Ergebnisse jedes Versuchs zu speichern (in der Regel eine Liste von Zahlen; die Interpretation bleibt der Implementierung überlassen). Hinweis: erforderliches Schlüsselwort.

- *-final code*: Code, der am Ende ausgeführt wird

- *-trials n*: Anzahl der Versuche im Experiment (erforderlich)

- *-reportfile file*: geöffnete Datei, an die die Ausgabe gehen soll (Voreinstellung: stdout)

- *-verbose*: schreibt die Zwischenergebnisse (1) oder nicht (0) (Voreinstellung: 0)

- *-analysis proc*: entweder „none“ (keine automatische Analyse), standard (grundlegende Statistiken der Versuchsergebnisse und eine Korrelationsmatrix) oder der Name einer Prozedur, die die Analyse übernimmt.

- *-columns list*: Liste der Spaltennamen, nützlich für eine ausführliche Ausgabe und die Analyse.


Alle weiteren Optionen lassen sich über die Prozedur getOption im Prozedurrumpf verwenden.

# Tipps

Die Prozedur *singleExperiment* erstellt eine temporäre Prozedur, die die eigentliche Arbeit übernimmt. Sie führt eine Schleife über die angegebene Anzahl von Versuchen durch.

Da eine temporäre Prozedur erstellt wird, bleiben die zu Beginn definierten lokalen Variablen innerhalb der Schleife bestehen.

# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2008 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
