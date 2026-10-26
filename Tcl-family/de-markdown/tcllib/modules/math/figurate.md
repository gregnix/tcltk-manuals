---
CommandName: math::figurate
title: math::figurate
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - figurate numbers
 - mathematics
Copyright:
---

# Name

math::figurate – Berechnung figurierter Zahlen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [math::figurate]{.lit} [1.0]{.lit}
[::math::figurate::sum\_sequence]{.cmd} [n]{.arg}
[::math::figurate::sum\_squares]{.cmd} [n]{.arg}
[::math::figurate::sum\_cubes]{.cmd} [n]{.arg}
[::math::figurate::sum\_4th\_power]{.cmd} [n]{.arg}
[::math::figurate::sum\_5th\_power]{.cmd} [n]{.arg}
[::math::figurate::sum\_6th\_power]{.cmd} [n]{.arg}
[::math::figurate::sum\_7th\_power]{.cmd} [n]{.arg}
[::math::figurate::sum\_8th\_power]{.cmd} [n]{.arg}
[::math::figurate::sum\_9th\_power]{.cmd} [n]{.arg}
[::math::figurate::sum\_10th\_power]{.cmd} [n]{.arg}
[::math::figurate::sum\_sequence\_odd]{.cmd} [n]{.arg}
[::math::figurate::sum\_squares\_odd]{.cmd} [n]{.arg}
[::math::figurate::sum\_cubes\_odd]{.cmd} [n]{.arg}
[::math::figurate::sum\_4th\_power\_odd]{.cmd} [n]{.arg}
[::math::figurate::sum\_5th\_power\_odd]{.cmd} [n]{.arg}
[::math::figurate::sum\_6th\_power\_odd]{.cmd} [n]{.arg}
[::math::figurate::sum\_7th\_power\_odd]{.cmd} [n]{.arg}
[::math::figurate::sum\_8th\_power\_odd]{.cmd} [n]{.arg}
[::math::figurate::sum\_9th\_power\_odd]{.cmd} [n]{.arg}
[::math::figurate::sum\_10th\_power\_odd]{.cmd} [n]{.arg}
[::math::figurate::oblong]{.cmd} [n]{.arg}
[::math::figurate::pronic]{.cmd} [n]{.arg}
[::math::figurate::triangular]{.cmd} [n]{.arg}
[::math::figurate::square]{.cmd} [n]{.arg}
[::math::figurate::cubic]{.cmd} [n]{.arg}
[::math::figurate::biquadratic]{.cmd} [n]{.arg}
[::math::figurate::centeredTriangular]{.cmd} [n]{.arg}
[::math::figurate::centeredSquare]{.cmd} [n]{.arg}
[::math::figurate::centeredPentagonal]{.cmd} [n]{.arg}
[::math::figurate::centeredHexagonal]{.cmd} [n]{.arg}
[::math::figurate::centeredCube]{.cmd} [n]{.arg}
[::math::figurate::decagonal]{.cmd} [n]{.arg}
[::math::figurate::heptagonal]{.cmd} [n]{.arg}
[::math::figurate::hexagonal]{.cmd} [n]{.arg}
[::math::figurate::octagonal]{.cmd} [n]{.arg}
[::math::figurate::octahedral]{.cmd} [n]{.arg}
[::math::figurate::pentagonal]{.cmd} [n]{.arg}
[::math::figurate::squarePyramidral]{.cmd} [n]{.arg}
[::math::figurate::tetrahedral]{.cmd} [n]{.arg}
[::math::figurate::pentatope]{.cmd} [n]{.arg}
:::

# Beschreibung

Summen von Zahlen, die einem bestimmten Muster folgen, werden als figurierte Zahlen bezeichnet. Ein einfaches Beispiel ist die Summe der ganzen Zahlen 1, 2, … bis n. Sie können 1, 1+2=3, 1+2+3=6, … Objekte in einem Dreieck anordnen, daher der Name Dreieckszahlen:

```
       *
       *  *
       *  *  *
       *  *  *  *
       ...
```

Das Paket **math::figurate** umfasst eine Sammlung von Prozeduren zur Auswertung einer Vielzahl figurierter Zahlen. Zwar sind alle Formeln unkompliziert, doch die Details sind mitunter verwirrend. *Hinweis:* Die Prozeduren interpretieren Argumente kleiner als Null als „keine zu zählenden Objekte“ und geben daher den Wert 0 zurück.

# Prozeduren

Die Prozeduren lassen sich in einige Kategorien einteilen: Summen von ganzen Zahlen, die auf eine bestimmte Potenz erhoben werden, Summen von ungeraden ganzen Zahlen sowie allgemeine figurierte Zahlen, beispielsweise die Fünfeckzahlen.

**::math::figurate::sum\_sequence** *n*
: Gibt die Summe der ganzen Zahlen 1, 2, …, n zurück.

    int *n*
    : Die größte ganze Zahl in der Summe


**::math::figurate::sum\_squares** *n*
: Gibt die Summe der Quadrate 1\*\*2, 2\*\*2, …, n\*\*2 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_cubes** *n*
: Gibt die Summe der Kubikzahlen 1\*\*3, 2\*\*3, …, n\*\*3 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_4th\_power** *n*
: Gibt die Summe der vierten Potenzen 1\*\*4, 2\*\*4, …, n\*\*4 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_5th\_power** *n*
: Gibt die Summe der 5. Potenzen 1\*\*5, 2\*\*5, …, n\*\*5 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_6th\_power** *n*
: Gibt die Summe der 6. Potenzen 1\*\*6, 2\*\*6, …, n\*\*6 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_7th\_power** *n*
: Gibt die Summe der 7. Potenzen 1\*\*7, 2\*\*7, …, n\*\*7 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_8th\_power** *n*
: Gibt die Summe der 8. Potenzen 1\*\*8, 2\*\*8, …, n\*\*8 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_9th\_power** *n*
: Gibt die Summe der 9. Potenzen 1\*\*9, 2\*\*9, …, n\*\*9 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_10th\_power** *n*
: Gibt die Summe der 10. Potenzen 1\*\*10, 2\*\*10, …, n\*\*10 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_sequence\_odd** *n*
: Gibt die Summe der ungeraden ganzen Zahlen 1, 3, …, 2n-1 zurück.

    int *n*
    : Die größte ganze Zahl in der Summe


**::math::figurate::sum\_squares\_odd** *n*
: Gibt die Summe der ungeraden Quadrate 1\*\*2, 3\*\*2, …, (2n-1)\*\*2 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_cubes\_odd** *n*
: Gibt die Summe der ungeraden Kubikzahlen 1\*\*3, 3\*\*3, …, (2n-1)\*\*3 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_4th\_power\_odd** *n*
: Gibt die Summe der ungeraden 4. Potenzen 1\*\*4, 2\*\*4, …, (2n-1)\*\*4 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_5th\_power\_odd** *n*
: Gibt die Summe der ungeraden 5. Potenzen 1\*\*5, 2\*\*5, …, (2n-1)\*\*5 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_6th\_power\_odd** *n*
: Gibt die Summe der ungeraden 6. Potenzen 1\*\*6, 2\*\*6, …, (2n-1)\*\*6 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_7th\_power\_odd** *n*
: Gibt die Summe der ungeraden 7. Potenzen 1\*\*7, 2\*\*7, …, (2n-1)\*\*7 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_8th\_power\_odd** *n*
: Gibt die Summe der ungeraden 8. Potenzen 1\*\*8, 2\*\*8, …, (2n-1)\*\*8 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_9th\_power\_odd** *n*
: Gibt die Summe der ungeraden 9. Potenzen 1\*\*9, 2\*\*9, …, (2n-1)\*\*9 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::sum\_10th\_power\_odd** *n*
: Gibt die Summe der ungeraden 10. Potenzen 1\*\*10, 2\*\*10, …, (2n-1)\*\*10 zurück.

    int *n*
    : Die größte ganzzahlige Basis in der Summe


**::math::figurate::oblong** *n*
: Gibt die n-te Rechteckzahl (das Doppelte der n-ten Dreieckszahl) zurück

    int *n*
    : Erforderlicher Index


**::math::figurate::pronic** *n*
: Gibt die n-te pronische Zahl zurück (Synonym für Rechteckzahl)

    int *n*
    : Erforderlicher Index


**::math::figurate::triangular** *n*
: Gibt die n-te Dreieckszahl zurück

    int *n*
    : Erforderlicher Index


**::math::figurate::square** *n*
: Gibt die n-te Quadratzahl zurück

    int *n*
    : Erforderlicher Index


**::math::figurate::cubic** *n*
: Gibt die n-te Kubikzahl zurück

    int *n*
    : Erforderlicher Index


**::math::figurate::biquadratic** *n*
: Gibt die n-te biquadratische Zahl (d. h. n\*\*4) zurück.

    int *n*
    : Erforderlicher Index


**::math::figurate::centeredTriangular** *n*
: Gibt die n-te zentrierte Dreieckszahl zurück (die Elemente sind in konzentrischen Dreiecken angeordnet)

    int *n*
    : Erforderlicher Index


**::math::figurate::centeredSquare** *n*
: Gibt die n-te zentrierte Quadratzahl zurück (die Elemente sind in konzentrischen Quadraten angeordnet)

    int *n*
    : Erforderlicher Index


**::math::figurate::centeredPentagonal** *n*
: Gibt die n-te zentrierte Fünfeckzahl zurück (Elemente sind in konzentrischen Fünfecken angeordnet)

    int *n*
    : Erforderlicher Index


**::math::figurate::centeredHexagonal** *n*
: Gibt die n-te zentrierte Sechseckzahl zurück (Elemente sind in konzentrischen Sechsecken angeordnet)

    int *n*
    : Erforderlicher Index


**::math::figurate::centeredCube** *n*
: Gibt die n-te zentrierte Würfelzahl zurück (Elemente sind in konzentrischen Würfeln angeordnet)

    int *n*
    : Erforderlicher Index


**::math::figurate::decagonal** *n*
: Gibt die n-te Zehneckzahl zurück (Elemente, die in Zehnecken mit einem gemeinsamen Eckpunkt angeordnet sind)

    int *n*
    : Erforderlicher Index


**::math::figurate::heptagonal** *n*
: Gibt die n-te Siebeneckzahl zurück (Elemente, die in Siebenecken mit einem gemeinsamen Eckpunkt angeordnet sind)

    int *n*
    : Erforderlicher Index


**::math::figurate::hexagonal** *n*
: Gibt die n-te Sechseckzahl zurück (Elemente, die in Sechsecken mit einem gemeinsamen Eckpunkt angeordnet sind)

    int *n*
    : Erforderlicher Index


**::math::figurate::octagonal** *n*
: Gibt die n-te Achteckzahl zurück (Elemente, die in Achtecken mit einem gemeinsamen Eckpunkt angeordnet sind)

    int *n*
    : Erforderlicher Index


**::math::figurate::octahedral** *n*
: Gibt die n-te Oktaederzahl zurück (Elemente, die in Oktaedern mit einem gemeinsamen Mittelpunkt angeordnet sind)

    int *n*
    : Erforderlicher Index


**::math::figurate::pentagonal** *n*
: Gibt die n-te Fünfeckzahl zurück (Elemente, die in Fünfecken mit einem gemeinsamen Eckpunkt angeordnet sind)

    int *n*
    : Erforderlicher Index


**::math::figurate::squarePyramidral** *n*
: Gibt die n-te quadratische Pyramidalzahl zurück (Elemente sind in einer quadratischen Pyramide angeordnet)

    int *n*
    : Erforderlicher Index


**::math::figurate::tetrahedral** *n*
: Gibt die n-te Tetraederzahl zurück (Elemente, die in einer dreieckigen Pyramide angeordnet sind)

    int *n*
    : Erforderlicher Index


**::math::figurate::pentatope** *n*
: Gibt die n-te Pentatop-Zahl zurück (Elemente, die im vierdimensionalen Analogon einer dreieckigen Pyramide angeordnet sind)

    int *n*
    : Erforderlicher Index



# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: figurate* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Mathematik
