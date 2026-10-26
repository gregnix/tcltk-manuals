---
CommandName: simulation::random
title: simulation::random
ManualSection: n
Version: 0.4
TclPart: tcllib
TclDescription: Tcl Simulation Tools
Keywords:
 - math
 - random numbers
 - simulation
 - statistical distribution
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

simulation::random – Pseudozufallszahlengeneratoren

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5 9]{.optlit}
[package]{.cmd} [require]{.sub} [simulation::random]{.lit} [0.4]{.lit}
[::simulation::random::prng\_Bernoulli]{.cmd} [p]{.arg}
[::simulation::random::prng\_Discrete]{.cmd} [n]{.arg}
[::simulation::random::prng\_Poisson]{.cmd} [lambda]{.arg}
[::simulation::random::prng\_Uniform]{.cmd} [min]{.arg} [max]{.arg}
[::simulation::random::prng\_Triangular]{.cmd} [min]{.arg} [max]{.arg}
[::simulation::random::prng\_SymmTriangular]{.cmd} [min]{.arg} [max]{.arg}
[::simulation::random::prng\_Exponential]{.cmd} [min]{.arg} [mean]{.arg}
[::simulation::random::prng\_Normal]{.cmd} [mean]{.arg} [stdev]{.arg}
[::simulation::random::prng\_Pareto]{.cmd} [min]{.arg} [steep]{.arg}
[::simulation::random::prng\_Gumbel]{.cmd} [min]{.arg} [f]{.arg}
[::simulation::random::prng\_chiSquared]{.cmd} [df]{.arg}
[::simulation::random::prng\_Disk]{.cmd} [rad]{.arg}
[::simulation::random::prng\_Sphere]{.cmd} [rad]{.arg}
[::simulation::random::prng\_Ball]{.cmd} [rad]{.arg}
[::simulation::random::prng\_Rectangle]{.cmd} [length]{.arg} [width]{.arg}
[::simulation::random::prng\_Block]{.cmd} [length]{.arg} [width]{.arg} [depth]{.arg}
:::

# Beschreibung

Dieses Paket enthält Befehle zur Erstellung von Pseudozufallszahlengeneratoren. Diese neuen Befehle bieten

- Zahlen, die normalverteilt, gleichmäßig verteilt oder nach einer Pareto- bzw. Gumbel-Verteilung verteilt sind usw.

- Koordinaten von Punkten, die gleichmäßig innerhalb einer Kugel oder eines Rechtecks verteilt sind.


Beispiel:

```
    set p [::simulation::random::prng_Normal -1.0 10.0]
```

Erzeugt einen neuen Befehl (dessen Name in der Variable „p“ gespeichert ist), der normalverteilte Zahlen mit einem Mittelwert von -1,0 und einer Standardabweichung von 10,0 generiert.

# Prozeduren

Das Paket definiert die folgenden öffentlichen Prozeduren für *diskrete* Verteilungen:

**::simulation::random::prng\_Bernoulli** *p*
: Erstellt einen Befehl (PRNG), der Zahlen mit einer Bernoulli-Verteilung erzeugt: Der Wert ist entweder 1 oder 0, mit der Wahrscheinlichkeit p, dass er 1 ist.

    float *p*
    : Wahrscheinlichkeit, dass das Ergebnis 1 ist


**::simulation::random::prng\_Discrete** *n*
: Erstellt einen Befehl (PRNG), der die Zahlen 0 bis n-1 mit gleicher Wahrscheinlichkeit generiert.

    int *n*
    : Anzahl der verschiedenen Werte (im Bereich von 0 bis n-1)


**::simulation::random::prng\_Poisson** *lambda*
: Erstellt einen Befehl (PRNG), der Zahlen gemäß der Poisson-Verteilung generiert.

    float *lambda*
    : Mittlere Anzahl pro Zeitintervall



Das Paket definiert die folgenden öffentlichen Prozeduren für *kontinuierliche* Verteilungen:

**::simulation::random::prng\_Uniform** *min* *max*
: Erstellt einen Befehl (PRNG), der gleichmäßig verteilte Zahlen zwischen „min“ und „max“ generiert.

    float *min*
    : Kleinste Zahl, die erzeugt wird

    float *max*
    : Größte Zahl, die erzeugt wird


**::simulation::random::prng\_Triangular** *min* *max*
: Erstellt einen Befehl (PRNG), der Zahlen mit Dreiecksverteilung zwischen „min“ und „max“ generiert. Wenn das Argument „min“ kleiner ist als das Argument „max“, so haben kleinere Werte eine höhere Wahrscheinlichkeit und umgekehrt. Im ersten Fall hat die Wahrscheinlichkeitsdichtefunktion die Form *f(x) = 2(1-x)* und im anderen Fall die Form *f(x) = 2x*.

    float *min*
    : Kleinste Zahl, die erzeugt wird

    float *max*
    : Größte Zahl, die erzeugt wird


**::simulation::random::prng\_SymmTriangular** *min* *max*
: Erstellt einen Befehl (PRNG), der Zahlen erzeugt, die gemäß einem symmetrischen Dreieck um den Mittelwert von „min“ und „max“ verteilt sind.

    float *min*
    : Kleinste Zahl, die erzeugt wird

    float *max*
    : Größte Zahl, die erzeugt wird


**::simulation::random::prng\_Exponential** *min* *mean*
: Erstellt einen Befehl (PRNG), der exponentialverteilte Zahlen mit einem vorgegebenen Mindestwert und einem vorgegebenen Mittelwert erzeugt.

    float *min*
    : Kleinste Zahl, die erzeugt wird

    float *mean*
    : Mittelwert der Zahlen


**::simulation::random::prng\_Normal** *mean* *stdev*
: Erstellt einen Befehl (PRNG), der normalverteilte Zahlen mit einem vorgegebenen Mittelwert und einer vorgegebenen Standardabweichung erzeugt.

    float *mean*
    : Mittelwert der Zahlen

    float *stdev*
    : Standardabweichung


**::simulation::random::prng\_Pareto** *min* *steep*
: Erstellt einen Befehl (PRNG), der Zahlen gemäß der Pareto-Verteilung mit einem vorgegebenen Mindestwert und einer vorgegebenen Verteilungssteilheit erzeugt.

    float *min*
    : Kleinste Zahl, die erzeugt wird

    float *steep*
    : Steilheit der Verteilung


**::simulation::random::prng\_Gumbel** *min* *f*
: Erstellt einen Befehl (PRNG), der Zahlen gemäß der Gumbel-Verteilung mit einem vorgegebenen Mindestwert und einem vorgegebenen Skalierungsfaktor erzeugt. Die Wahrscheinlichkeitsdichtefunktion lautet:

    ```
         P(v) = exp( -exp(f*(v-min)))
    ```

    float *min*
    : Kleinste Zahl, die erzeugt wird

    float *f*
    : Skalierungsfaktor für die Werte


**::simulation::random::prng\_chiSquared** *df*
: Erstellt einen Befehl (PRNG), der Zahlen gemäß der Chi-Quadrat-Verteilung mit df Freiheitsgraden erzeugt. Der Mittelwert ist 0 und die Standardabweichung ist 1.

    float *df*
    : Freiheitsgrade



Das Paket definiert die folgenden öffentlichen Prozeduren für Zufalls-Punktmengen:

**::simulation::random::prng\_Disk** *rad*
: Erstellt einen Befehl (PRNG), der (x,y)-Koordinaten für Punkte erzeugt, die gleichmäßig über eine Scheibe mit gegebenem Radius verteilt sind.

    float *rad*
    : Radius der Scheibe


**::simulation::random::prng\_Sphere** *rad*
: Erstellt einen Befehl (PRNG), der (x,y,z)-Koordinaten für Punkte erzeugt, die gleichmäßig über die Oberfläche einer Kugel mit gegebenem Radius verteilt sind.

    float *rad*
    : Radius der Kugel


**::simulation::random::prng\_Ball** *rad*
: Erstellt einen Befehl (PRNG), der (x,y,z)-Koordinaten für Punkte erzeugt, die gleichmäßig innerhalb eines Balls mit gegebenem Radius verteilt sind.

    float *rad*
    : Radius des Balls


**::simulation::random::prng\_Rectangle** *length* *width*
: Erstellt einen Befehl (PRNG), der (x,y)-Koordinaten für Punkte erzeugt, die gleichmäßig über ein Rechteck verteilt sind.

    float *length*
    : Länge des Rechtecks (x-Richtung)

    float *width*
    : Breite des Rechtecks (y-Richtung)


**::simulation::random::prng\_Block** *length* *width* *depth*
: Erstellt einen Befehl (PRNG), der (x,y,z)-Koordinaten für Punkte erzeugt, die gleichmäßig über einen Block verteilt sind

    float *length*
    : Länge des Blocks (x-Richtung)

    float *width*
    : Breite des Blocks (y-Richtung)

    float *depth*
    : Tiefe des Blocks (z-Richtung)



# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
