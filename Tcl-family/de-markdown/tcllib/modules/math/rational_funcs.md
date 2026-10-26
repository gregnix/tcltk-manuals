---
CommandName: math::rationalfunctions
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Math
Keywords:
 - math
 - rational functions
Copyright:
 - Copyright (c) 2005 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# NAME

math::rationalfunctions – Gebrochenrationale Funktionen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [?8.5]{.lit} [9?]{.lit} 
[package]{.cmd} [require]{.sub} [math::rationalfunctions]{.lit} [1.0.2]{.optlit} 
[::math::rationalfunctions::rationalFunction]{.cmd} [num]{.arg} [den]{.arg} 
[::math::rationalfunctions::ratioCmd]{.cmd} [num]{.arg} [den]{.arg} 
[::math::rationalfunctions::evalRatio]{.cmd} [rational]{.arg} [x]{.arg} 
[::math::rationalfunctions::addRatio]{.cmd} [ratio1]{.arg} [ratio2]{.arg} 
[::math::rationalfunctions::subRatio]{.cmd} [ratio1]{.arg} [ratio2]{.arg} 
[::math::rationalfunctions::multRatio]{.cmd} [ratio1]{.arg} [ratio2]{.arg} 
[::math::rationalfunctions::divRatio]{.cmd} [ratio1]{.arg} [ratio2]{.arg} 
[::math::rationalfunctions::derivPolyn]{.cmd} [ratio]{.arg} 
[::math::rationalfunctions::coeffsNumerator]{.cmd} [ratio]{.arg} 
[::math::rationalfunctions::coeffsDenominator]{.cmd} [ratio]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket befasst sich mit gebrochenrationalen Funktionen einer Variablen:

**•**
: die grundlegenden arithmetischen Operationen werden auf gebrochenrationale Funktionen erweitert

**•**
: Berechnung der Ableitungen dieser Funktionen

**•**
: Auswertung über eine allgemeine Prozedur oder über spezielle Prozeduren)


# PROZEDUREN

Das Paket definiert die folgenden öffentlichen Prozeduren:

**::math::rationalfunctions::rationalFunction** *num* *den*
: Gibt eine (kodierte) Liste zurück, die die gebrochenrationale Funktion definiert. Eine gebrochenrationale Funktion


```
             1 + x^3
   f(x) = ------------
          1 + 2x + x^2
```

: kann wie folgt definiert werden:


```
   set f [::math::rationalfunctions::rationalFunction [list 1 0 0 1]  [list 1 2 1]]
```

list *num*
: Koeffizienten des Zählers der gebrochenrationalen Funktion (in aufsteigender Reihenfolge)

list *den*
: Koeffizienten des Nenners der gebrochenrationalen Funktion (in aufsteigender Reihenfolge)


**::math::rationalfunctions::ratioCmd** *num* *den*
: Erzeugt eine neue Prozedur, die die gebrochenrationale Funktion auswertet. Der Name der Funktion wird automatisch generiert. Dies ist nützlich, wenn Sie die Funktion mehrfach auswerten müssen, da die Prozedur aus einem einzigen \[expr\]-Befehl besteht.


list *num*
: Koeffizienten des Zählers der gebrochenrationalen Funktion (in aufsteigender Reihenfolge)

list *den*
: Koeffizienten des Nenners der gebrochenrationalen Funktion (in aufsteigender Reihenfolge)


**::math::rationalfunctions::evalRatio** *rational* *x*
: Wertet die gebrochenrationale Funktion an der Stelle x aus.


list *rational*
: Die Definition der gebrochenrationalen Funktion (wie sie vom Befehl rationalFunction zurückgegeben wird).

float *x*
: Die Koordinate, an der die Funktion ausgewertet werden soll


**::math::rationalfunctions::addRatio** *ratio1* *ratio2*
: Gibt eine neue gebrochenrationale Funktion zurück, die die Summe der beiden anderen Funktionen darstellt.


list *ratio1*
: Erster Operand (gebrochenrationale Funktion)

list *ratio2*
: Zweiter Operand (gebrochenrationale Funktion)


**::math::rationalfunctions::subRatio** *ratio1* *ratio2*
: Gibt eine neue gebrochenrationale Funktion zurück, die der Differenz der beiden anderen entspricht.


list *ratio1*
: Erster Operand (gebrochenrationale Funktion)

list *ratio2*
: Zweiter Operand (gebrochenrationale Funktion)


**::math::rationalfunctions::multRatio** *ratio1* *ratio2*
: Gibt eine neue gebrochenrationale Funktion zurück, die das Produkt der beiden anderen Funktionen ist. Wenn eines der Argumente ein Skalarwert ist, wird die andere gebrochenrationale Funktion lediglich skaliert.


list *ratio1*
: Erster Operand (gebrochenrationale Funktion oder Skalar)

list *ratio2*
: Zweiter Operand (gebrochenrationale Funktion oder Skalar)


**::math::rationalfunctions::divRatio** *ratio1* *ratio2*
: Teilt die erste gebrochenrationale Funktion durch die zweite gebrochenrationale Funktion und gibt das Ergebnis zurück. Der Rest wird verworfen.


list *ratio1*
: Erster Operand (gebrochenrationale Funktion)

list *ratio2*
: Zweiter Operand (gebrochenrationale Funktion)


**::math::rationalfunctions::derivPolyn** *ratio*
: Differenziert die gebrochenrationale Funktion und gibt das Ergebnis zurück.


list *ratio*
: Die zu differenzierende gebrochenrationale Funktion


**::math::rationalfunctions::coeffsNumerator** *ratio*
: Gibt die Koeffizienten des Zählers der gebrochenrationalen Funktion zurück.


list *ratio*
: Die zu untersuchende gebrochenrationale Funktion


**::math::rationalfunctions::coeffsDenominator** *ratio*
: Gibt die Koeffizienten des Nenners der gebrochenrationalen Funktion zurück.


list *ratio*
: Die zu untersuchende gebrochenrationale Funktion


# ANMERKUNGEN ZUR UMSETZUNG

Die Implementierung der gebrochenrationalen Funktionen basiert auf dem Paket math::polynomials. Weitere Hinweise finden Sie in der Dokumentation zu diesem Paket.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: rationalfunctions* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Mathematik

# COPYRIGHT

```
Copyright (c) 2005 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
