---
CommandName: math::special
title: math::special
ManualSection: n
Version: 0.5.4
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - Bessel functions
 - error function
 - math
 - special functions
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

math::special – Spezielle mathematische Funktionen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5 9]{.optlit}
[package]{.cmd} [require]{.sub} [math::special]{.lit} [0.5.3]{.optlit}
[::math::special::eulerNumber]{.cmd} [index]{.arg}
[::math::special::bernoulliNumber]{.cmd} [index]{.arg}
[::math::special::Beta]{.cmd} [x]{.arg} [y]{.arg}
[::math::special::incBeta]{.cmd} [a]{.arg} [b]{.arg} [x]{.arg}
[::math::special::regIncBeta]{.cmd} [a]{.arg} [b]{.arg} [x]{.arg}
[::math::special::Gamma]{.cmd} [x]{.arg}
[::math::special::digamma]{.cmd} [x]{.arg}
[::math::special::erf]{.cmd} [x]{.arg}
[::math::special::erfc]{.cmd} [x]{.arg}
[::math::special::invnorm]{.cmd} [p]{.arg}
[::math::special::J0]{.cmd} [x]{.arg}
[::math::special::J1]{.cmd} [x]{.arg}
[::math::special::Jn]{.cmd} [n]{.arg} [x]{.arg}
[::math::special::J1/2]{.cmd} [x]{.arg}
[::math::special::J-1/2]{.cmd} [x]{.arg}
[::math::special::I\_n]{.cmd} [x]{.arg}
[::math::special::cn]{.cmd} [u]{.arg} [k]{.arg}
[::math::special::dn]{.cmd} [u]{.arg} [k]{.arg}
[::math::special::sn]{.cmd} [u]{.arg} [k]{.arg}
[::math::special::elliptic\_K]{.cmd} [k]{.arg}
[::math::special::elliptic\_E]{.cmd} [k]{.arg}
[::math::special::exponential\_Ei]{.cmd} [x]{.arg}
[::math::special::exponential\_En]{.cmd} [n]{.arg} [x]{.arg}
[::math::special::exponential\_li]{.cmd} [x]{.arg}
[::math::special::exponential\_Ci]{.cmd} [x]{.arg}
[::math::special::exponential\_Si]{.cmd} [x]{.arg}
[::math::special::exponential\_Chi]{.cmd} [x]{.arg}
[::math::special::exponential\_Shi]{.cmd} [x]{.arg}
[::math::special::fresnel\_C]{.cmd} [x]{.arg}
[::math::special::fresnel\_S]{.cmd} [x]{.arg}
[::math::special::sinc]{.cmd} [x]{.arg}
[::math::special::legendre]{.cmd} [n]{.arg}
[::math::special::chebyshev]{.cmd} [n]{.arg}
[::math::special::laguerre]{.cmd} [alpha]{.arg} [n]{.arg}
[::math::special::hermite]{.cmd} [n]{.arg}
:::

# Beschreibung

Dieses Paket implementiert mehrere sogenannte spezielle Funktionen, wie beispielsweise die Gammafunktion, die Besselfunktionen und dergleichen.

Jede Funktion wird durch eine Prozedur implementiert, die denselben Namen trägt (naja, zumindest annähernd):

- J0 für die Besselfunktion nullter Ordnung erster Art

- J1 für die Besselfunktion erster Ordnung erster Art

- Jn für die Besselfunktion n-ter Ordnung erster Art

- J1/2 für die Besselfunktion erster Art halber Ordnung

- J-1/2 für die Besselfunktion erster Art der Ordnung minus ein halb

- I\_n für die modifizierte Besselfunktion erster Art der Ordnung n

- Gamma für die Gammafunktion, erf und erfc für die Fehlerfunktion und die komplementäre Fehlerfunktion

- fresnel\_C und fresnel\_S für die Fresnel-Integrale

- elliptic\_K und elliptic\_E (vollständige elliptische Integrale)

- exponent\_Ei und andere Funktionen im Zusammenhang mit den sogenannten Exponentialintegralen

- legendre, hermite: einige der klassischen orthogonalen Polynome.


# Überblick

In der folgenden Tabelle sind einige Eigenschaften der Funktionen dieses Pakets zusammengefasst: der Definitionsbereich für das Argument, die Werte für die Parameter sowie die Fehlergrenzen.

```
Family       | Function    | Domain x    | Parameter   | Error bound
-------------+-------------+-------------+-------------+--------------
Bessel       | J0, J1,     | all of R    | n = integer |   < 1.0e-8
             | Jn          |             |             |  (|x|<20, n<20)
Bessel       | J1/2, J-1/2,|  x > 0      | n = integer |   exact
Bessel       | I_n         | all of R    | n = integer |   < 1.0e-6
             |             |             |             |
Elliptic     | cn          | 0 <= x <= 1 |     --      |   < 1.0e-10
functions    | dn          | 0 <= x <= 1 |     --      |   < 1.0e-10
             | sn          | 0 <= x <= 1 |     --      |   < 1.0e-10
Elliptic     | K           | 0 <= x < 1  |     --      |   < 1.0e-6
integrals    | E           | 0 <= x < 1  |     --      |   < 1.0e-6
             |             |             |             |
Error        | erf         |             |     --      |
functions    | erfc        |             |             |
             |             |             |             |
Inverse      | invnorm     | 0 < x < 1   |     --      |   < 1.2e-9
normal       |             |             |             |
distribution |             |             |             |
             |             |             |             |
Exponential  | Ei          |  x != 0     |     --      |   < 1.0e-10 (relative)
integrals    | En          |  x >  0     |     --      |   as Ei
             | li          |  x > 0      |     --      |   as Ei
             | Chi         |  x > 0      |     --      |   < 1.0e-8
             | Shi         |  x > 0      |     --      |   < 1.0e-8
             | Ci          |  x > 0      |     --      |   < 2.0e-4
             | Si          |  x > 0      |     --      |   < 2.0e-4
             |             |             |             |
Fresnel      | C           |  all of R   |     --      |   < 2.0e-3
integrals    | S           |  all of R   |     --      |   < 2.0e-3
             |             |             |             |
general      | Beta        | (see Gamma) |     --      |   < 1.0e-9
             | Gamma       |  x != 0,-1, |     --      |   < 1.0e-9
             |             |  -2, ...    |             |
             | incBeta     |             |  a, b > 0   |   < 1.0e-9
             | regIncBeta  |             |  a, b > 0   |   < 1.0e-9
             | digamma     |  x != 0,-1  |             |   < 1.0e-9
             |             |  -2, ...    |             |
             |             |             |             |
             | sinc        |  all of R   |     --      |   exact
             |             |             |             |
orthogonal   | Legendre    |  all of R   | n = 0,1,... |   exact
polynomials  | Chebyshev   |  all of R   | n = 0,1,... |   exact
             | Laguerre    |  all of R   | n = 0,1,... |   exact
             |             |             | alpha el. R |
             | Hermite     |  all of R   | n = 0,1,... |   exact
```

*Hinweis:* Einige der Fehlergrenzen sind geschätzt, da mit der implementierten Approximationsmethode keine „formalen“ Grenzen verfügbar waren; andere gelten für die Hilfsfunktionen, die zur Schätzung der Hauptfunktionen verwendet werden.

Die folgenden bekannten Funktionen fehlen derzeit im Paket:

- Besselfunktionen zweiter Art (Y\_n, K\_n)

- Besselfunktionen beliebiger Ordnung (und somit auch die Airy-Funktionen)

- Tschebyscheff-Polynome zweiter Art (U\_n)

- Die unvollständige Gammafunktion


# Prozeduren

Das Paket definiert die folgenden öffentlichen Prozeduren:

**::math::special::eulerNumber** *index*
: Gibt die Euler-Zahl mit dem Index *index* zurück (Hinweis: Es handelt sich hierbei um ganzzahlige Werte). Da die Größe dieser Zahlen sehr schnell zunimmt, steht nur eine begrenzte Anzahl zur Verfügung.

    int *index*
    : Index der zurückzugebenden Zahl (muss zwischen 0 und 54 liegen)


**::math::special::bernoulliNumber** *index*
: Gibt die Bernoulli-Zahl mit dem Index *index* zurück. Da die Größe dieser Zahlen sehr schnell zunimmt, steht nur eine begrenzte Anzahl zur Verfügung.

    int *index*
    : Index der zurückzugebenden Zahl (muss zwischen 0 und 52 liegen)


**::math::special::Beta** *x* *y*
: Berechnet die Betafunktion für die Argumente „x“ und „y“

    float *x*
    : Erstes Argument für die Betafunktion

    float *y*
    : Zweites Argument für die Betafunktion


**::math::special::incBeta** *a* *b* *x*
: Berechnet die unvollständige Betafunktion für das Argument „x“ mit den Parametern „a“ und „b“

    float *a*
    : Erster Parameter für die unvollständige Betafunktion, a > 0

    float *b*
    : Zweiter Parameter für die unvollständige Betafunktion, b > 0

    float *x*
    : Argument für die unvollständige Betafunktion


**::math::special::regIncBeta** *a* *b* *x*
: Berechnet die regularisierte unvollständige Betafunktion für das Argument „x“ mit den Parametern „a“ und „b“

    float *a*
    : Erster Parameter für die unvollständige Betafunktion, a > 0

    float *b*
    : Zweiter Parameter für die unvollständige Betafunktion, b > 0

    float *x*
    : Argument für die regularisierte unvollständige Betafunktion


**::math::special::Gamma** *x*
: Berechnet die Gammafunktion für das Argument „x“

    float *x*
    : Argument der Gammafunktion


**::math::special::digamma** *x*
: Berechnet die Digammafunktion (psi) für das Argument „x“

    float *x*
    : Argument der Digammafunktion


**::math::special::erf** *x*
: Berechnet die Fehlerfunktion für das Argument „x“

    float *x*
    : Argument für die Fehlerfunktion


**::math::special::erfc** *x*
: Berechnet die komplementäre Fehlerfunktion für das Argument „x“

    float *x*
    : Argument für die komplementäre Fehlerfunktion


**::math::special::invnorm** *p*
: Berechnet die Inverse der Normalverteilungsfunktion für das Argument „p“

    float *p*
    : Argument für die inverse Normalverteilungsfunktion (p muss größer als 0 und kleiner als 1 sein)


**::math::special::J0** *x*
: Berechnet die Besselfunktion nullter Ordnung erster Art für das Argument „x“

    float *x*
    : Argument der Besselfunktion


**::math::special::J1** *x*
: Berechnet die Besselfunktion erster Ordnung der ersten Art für das Argument „x“

    float *x*
    : Argument der Besselfunktion


**::math::special::Jn** *n* *x*
: Berechnet die Besselfunktion erster Art n-ter Ordnung für das Argument „x“

    integer *n*
    : Ordnung der Besselfunktion

    float *x*
    : Argument der Besselfunktion


**::math::special::J1/2** *x*
: Berechnet die Besselfunktion erster Art halber Ordnung für das Argument „x“

    float *x*
    : Argument der Besselfunktion


**::math::special::J-1/2** *x*
: Berechnet die Besselfunktion erster Art der Ordnung minus ein halb für das Argument „x“

    float *x*
    : Argument der Besselfunktion


**::math::special::I\_n** *x*
: Berechnet die modifizierte Besselfunktion erster Art der Ordnung n für das Argument „x“

    int *x*
    : Positive ganzzahlige Ordnung der Funktion

    float *x*
    : Argument der Funktion


**::math::special::cn** *u* *k*
: Berechnet die elliptische Funktion *cn* für das Argument „u“ und den Parameter „k“.

    float *u*
    : Argument der Funktion

    float *k*
    : Parameter


**::math::special::dn** *u* *k*
: Berechnet die elliptische Funktion *dn* für das Argument „u“ und den Parameter „k“.

    float *u*
    : Argument der Funktion

    float *k*
    : Parameter


**::math::special::sn** *u* *k*
: Berechnet die elliptische Funktion *sn* für das Argument „u“ und den Parameter „k“.

    float *u*
    : Argument der Funktion

    float *k*
    : Parameter


**::math::special::elliptic\_K** *k*
: Berechnet das vollständige elliptische Integral erster Art für das Argument „k“

    float *k*
    : Argument der Funktion


**::math::special::elliptic\_E** *k*
: Berechnet das vollständige elliptische Integral zweiter Art für das Argument „k“

    float *k*
    : Argument der Funktion


**::math::special::exponential\_Ei** *x*
: Berechnet das Exponentialintegral zweiter Art für das Argument „x“

    float *x*
    : Argument für die Funktion (x != 0)


**::math::special::exponential\_En** *n* *x*
: Berechnet das Exponentialintegral erster Art für das Argument „x“ und die Ordnung n

    int *n*
    : Ordnung des Integrals (n >= 0)

    float *x*
    : Argument der Funktion (x >= 0)


**::math::special::exponential\_li** *x*
: Berechnet das logarithmische Integral für das Argument „x“

    float *x*
    : Argument der Funktion (x > 0)


**::math::special::exponential\_Ci** *x*
: Berechnet das Kosinusintegral für das Argument „x“

    float *x*
    : Argument der Funktion (x > 0)


**::math::special::exponential\_Si** *x*
: Berechnet das Sinusintegral für das Argument „x“

    float *x*
    : Argument der Funktion (x > 0)


**::math::special::exponential\_Chi** *x*
: Berechnet das Integral des hyperbolischen Kosinus für das Argument „x“

    float *x*
    : Argument der Funktion (x > 0)


**::math::special::exponential\_Shi** *x*
: Berechnet das Integral des hyperbolischen Sinus für das Argument „x“

    float *x*
    : Argument der Funktion (x > 0)


**::math::special::fresnel\_C** *x*
: Berechnet das Fresnel-Kosinus-Integral für das reelle Argument x

    float *x*
    : Argument der Funktion


**::math::special::fresnel\_S** *x*
: Berechnet das Fresnel-Sinus-Integral für das reelle Argument x

    float *x*
    : Argument der Funktion


**::math::special::sinc** *x*
: Berechnet die Sinc-Funktion für das reelle Argument x

    float *x*
    : Argument der Funktion


**::math::special::legendre** *n*
: Gibt das Legendre-Polynom vom Grad n zurück (siehe [Die orthogonalen Polynome])

    int *n*
    : Grad des Polynoms


**::math::special::chebyshev** *n*
: Gibt das Tschebyscheff-Polynom vom Grad n (erster Art) zurück

    int *n*
    : Grad des Polynoms


**::math::special::laguerre** *alpha* *n*
: Gibt das Laguerre-Polynom vom Grad n mit dem Parameter alpha zurück

    float *alpha*
    : Parameter des Laguerre-Polynoms

    int *n*
    : Grad des Polynoms


**::math::special::hermite** *n*
: Gibt das Hermite-Polynom vom Grad n zurück

    int *n*
    : Grad des Polynoms



# Die orthogonalen Polynome

Für die Behandlung der klassischen Familien orthogonaler Polynome stützt sich das Paket auf das Paket *math::polynomials*. Um das Polynom an einer bestimmten Koordinate auszuwerten, verwenden Sie den Befehl *evalPolyn*:

```
   set leg2 [::math::special::legendre 2]
   puts "Value at x=$x: [::math::polynomials::evalPolyn $leg2 $x]"
```

Der Rückgabewert von *legendre* und den anderen Befehlen ist eigentlich die Definition des jeweiligen Polynoms, wie sie in jenem Paket verwendet wird.

# Anmerkungen zur Umsetzung

Es sei angemerkt, dass die tatsächliche Implementierung von J0 und J1 auf einfachen Gaußschen Quadraturformeln beruht. Die (absolute) Genauigkeit der Ergebnisse liegt in der Größenordnung von 1.0e-4 oder besser. Der Hauptgrund für diese Art der Implementierung war, dass sie sich schnell umsetzen ließ (die Formeln sind einfach) und auch die Berechnungen schnell erfolgen.

Die Implementierung von J1/2 ist davon nicht betroffen: Diese Funktion lässt sich exakt als Zusammensetzung elementarer Funktionen ausdrücken.

Die Funktionen J0 und J1 sind diejenigen, denen Sie in der Praxis am häufigsten begegnen werden.

Die Berechnung von I\_n basiert auf dem Miller-Algorithmus zur Berechnung der Minimalfunktion aus Rekursionsbeziehungen.

Die Berechnung der Gamma- und Betafunktionen stützt sich auf das Paket combinatorics, die der Fehlerfunktionen auf das Paket statistics.

Zur Berechnung der vollständigen elliptischen Integrale wird der AGM-Algorithmus verwendet.

Zahlreiche Informationen zu diesen Funktionen finden Sie in:

Abramowitz und Stegun: *Handbook of Mathematical Functions* (Dover, ISBN 486-61272-4)

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: special* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
