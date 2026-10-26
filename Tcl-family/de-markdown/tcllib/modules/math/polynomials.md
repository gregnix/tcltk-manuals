---
CommandName: math::polynomials
title: math::polynomials
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - math
 - polynomial functions
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

math::polynomials – Polynomfunktionen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.optlit}
[package]{.cmd} [require]{.sub} [math::polynomials]{.lit} [1.0.2]{.optlit}
[::math::polynomials::polynomial]{.cmd} [coeffs]{.arg}
[::math::polynomials::polynCmd]{.cmd} [coeffs]{.arg}
[::math::polynomials::evalPolyn]{.cmd} [polynomial]{.arg} [x]{.arg}
[::math::polynomials::addPolyn]{.cmd} [polyn1]{.arg} [polyn2]{.arg}
[::math::polynomials::subPolyn]{.cmd} [polyn1]{.arg} [polyn2]{.arg}
[::math::polynomials::multPolyn]{.cmd} [polyn1]{.arg} [polyn2]{.arg}
[::math::polynomials::divPolyn]{.cmd} [polyn1]{.arg} [polyn2]{.arg}
[::math::polynomials::remainderPolyn]{.cmd} [polyn1]{.arg} [polyn2]{.arg}
[::math::polynomials::derivPolyn]{.cmd} [polyn]{.arg}
[::math::polynomials::primitivePolyn]{.cmd} [polyn]{.arg}
[::math::polynomials::degreePolyn]{.cmd} [polyn]{.arg}
[::math::polynomials::coeffPolyn]{.cmd} [polyn]{.arg} [index]{.arg}
[::math::polynomials::allCoeffsPolyn]{.cmd} [polyn]{.arg}
:::

# Beschreibung

Dieses Paket befasst sich mit Polynomfunktionen einer Variablen:

- die grundlegenden arithmetischen Operationen werden auf Polynome erweitert

- Berechnung der Ableitungen und Stammfunktionen dieser Funktionen

- Auswertung über eine allgemeine Prozedur oder über spezielle Prozeduren)


# Prozeduren

Das Paket definiert die folgenden öffentlichen Prozeduren:

**::math::polynomials::polynomial** *coeffs*
: Gibt eine (kodierte) Liste zurück, die das Polynom definiert. Ein Polynom

    ```
       f(x) = a + b.x + c.x**2 + d.x**3
    ```

    kann wie folgt definiert werden:

    ```
       set f [::math::polynomials::polynomial [list $a $b $c $d]
    ```

    list *coeffs*
    : Koeffizienten des Polynoms (in aufsteigender Reihenfolge)


**::math::polynomials::polynCmd** *coeffs*
: Erzeugt eine neue Prozedur, die das Polynom auswertet. Der Name des Polynoms wird automatisch generiert. Dies ist nützlich, wenn Sie das Polynom mehrfach auswerten müssen, da die Prozedur aus einem einzigen \[expr\]-Befehl besteht.

    list *coeffs*
    : Koeffizienten des Polynoms (in aufsteigender Reihenfolge) oder die vom Befehl *polynomial* zurückgegebene Polynomdefinition.


**::math::polynomials::evalPolyn** *polynomial* *x*
: Wertet das Polynom an der Stelle x aus.

    list *polynomial*
    : Die Definition des Polynoms (wie sie vom Befehl polynomial zurückgegeben wird).

    float *x*
    : Die Koordinate, an der das Polynom ausgewertet werden soll


**::math::polynomials::addPolyn** *polyn1* *polyn2*
: Gibt ein neues Polynom zurück, das die Summe der beiden anderen ist.

    list *polyn1*
    : Der erste Polynomoperand

    list *polyn2*
    : Der zweite Polynomoperand


**::math::polynomials::subPolyn** *polyn1* *polyn2*
: Gibt ein neues Polynom zurück, das der Differenz der beiden anderen entspricht.

    list *polyn1*
    : Der erste Polynomoperand

    list *polyn2*
    : Der zweite Polynomoperand


**::math::polynomials::multPolyn** *polyn1* *polyn2*
: Gibt ein neues Polynom zurück, das das Produkt der beiden anderen Polynome ist. Wenn eines der Argumente ein Skalarwert ist, wird das andere Polynom lediglich skaliert.

    list *polyn1*
    : Der erste Polynomoperand oder ein Skalar

    list *polyn2*
    : Der zweite Polynomoperand oder ein Skalar


**::math::polynomials::divPolyn** *polyn1* *polyn2*
: Teilt das erste Polynom durch das zweite Polynom und gibt das Ergebnis zurück. Der Rest wird verworfen.

    list *polyn1*
    : Der erste Polynomoperand

    list *polyn2*
    : Der zweite Polynomoperand


**::math::polynomials::remainderPolyn** *polyn1* *polyn2*
: Teilt das erste Polynom durch das zweite Polynom und gibt den Rest zurück.

    list *polyn1*
    : Der erste Polynomoperand

    list *polyn2*
    : Der zweite Polynomoperand


**::math::polynomials::derivPolyn** *polyn*
: Differenziert das Polynom und gibt das Ergebnis zurück.

    list *polyn*
    : Das zu differenzierende Polynom


**::math::polynomials::primitivePolyn** *polyn*
: Integriert das Polynom und gibt das Ergebnis zurück. Die Integrationskonstante wird auf Null gesetzt.

    list *polyn*
    : Das zu integrierende Polynom


**::math::polynomials::degreePolyn** *polyn*
: Gibt den Grad des Polynoms zurück.

    list *polyn*
    : Das zu untersuchende Polynom


**::math::polynomials::coeffPolyn** *polyn* *index*
: Gibt den Koeffizienten des Terms vom Grad index des Polynoms zurück.

    list *polyn*
    : Das zu untersuchende Polynom

    int *index*
    : Der Grad des Terms


**::math::polynomials::allCoeffsPolyn** *polyn*
: Gibt die Koeffizienten des Polynoms (in aufsteigender Reihenfolge) zurück.

    list *polyn*
    : Das betreffende Polynom



# Anmerkungen zur Umsetzung

Die Implementierung zur Auswertung der Polynome an einem bestimmten Punkt nutzt die Horner-Regel, die numerische Stabilität und einen minimalen Aufwand an arithmetischen Operationen gewährleistet. Um zu erkennen, dass es sich bei einer Polynomdefinition tatsächlich um eine korrekte Definition handelt, besteht diese aus einer Liste mit zwei Elementen: dem Schlüsselwort „POLYNOMIAL“ und der Liste der Koeffizienten in absteigender Reihenfolge. Letzteres erleichtert die Umsetzung der Hornerschen Regel.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: polynomials* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
