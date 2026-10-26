---
CommandName: math::decimal
title: math::decimal
ManualSection: n
Version: 1.0.5
TclPart: tcllib
TclDescription: Tcl Decimal Arithmetic Library
Keywords:
 - decimal
 - math
 - tcl
Copyright:
 - Copyright (c) 2011 Mark Alston <mark at beernut dot com>
---

# Name

math::decimal – Allgemeine Dezimalarithmetik

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5 9]{.optlit}
[package]{.cmd} [require]{.sub} [math::decimal]{.lit} [1.0.3]{.lit}
[::math::decimal::fromstr]{.cmd} [string]{.arg}
[::math::decimal::tostr]{.cmd} [decimal]{.arg}
[::math::decimal::setVariable]{.cmd} [variable]{.arg} [setting]{.arg}
[::math::decimal::add]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::+]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::subtract]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::-]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::multiply]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::\*]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::divide]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::/]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::divideint]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::remainder]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::abs]{.cmd} [decimal]{.arg}
[::math::decimal::compare]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::max]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::maxmag]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::min]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::minmag]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::plus]{.cmd} [a]{.arg}
[::math::decimal::minus]{.cmd} [a]{.arg}
[::math::decimal::copynegate]{.cmd} [a]{.arg}
[::math::decimal::copysign]{.cmd} [a]{.arg} [b]{.arg}
[::math::decimal::is-signed]{.cmd} [decimal]{.arg}
[::math::decimal::is-zero]{.cmd} [decimal]{.arg}
[::math::decimal::is-NaN]{.cmd} [decimal]{.arg}
[::math::decimal::is-infinite]{.cmd} [decimal]{.arg}
[::math::decimal::is-finite]{.cmd} [decimal]{.arg}
[::math::decimal::fma]{.cmd} [a]{.arg} [b]{.arg} [c]{.arg}
[::math::decimal::round\_half\_even]{.cmd} [decimal]{.arg} [digits]{.arg}
[::math::decimal::round\_half\_up]{.cmd} [decimal]{.arg} [digits]{.arg}
[::math::decimal::round\_half\_down]{.cmd} [decimal]{.arg} [digits]{.arg}
[::math::decimal::round\_down]{.cmd} [decimal]{.arg} [digits]{.arg}
[::math::decimal::round\_up]{.cmd} [decimal]{.arg} [digits]{.arg}
[::math::decimal::round\_floor]{.cmd} [decimal]{.arg} [digits]{.arg}
[::math::decimal::round\_ceiling]{.cmd} [decimal]{.arg} [digits]{.arg}
[::math::decimal::round\_05up]{.cmd} [decimal]{.arg} [digits]{.arg}
:::

# Beschreibung

Das „decimal“-Paket bietet Unterstützung für die Dezimalarithmetik sowohl für Gleitkommazahlen mit begrenzter Genauigkeit als auch für Gleitkommazahlen mit beliebiger Genauigkeit. Darüber hinaus wird die Ganzzahl-Arithmetik unterstützt.

Weitere Informationen sowie die Spezifikationen, von denen dieses Paket abhängt, finden Sie auf der allgemeinen Seite zur Dezimalarithmetik unter http://speleotrove.com/decimal. Dieses Paket bietet folgende Funktionen:

- Ein neuer Datentyp „decimal“, der als Liste dargestellt wird, die Vorzeichen, Mantisse und Exponent enthält.

- Arithmetische Operationen mit diesen Dezimalzahlen, wie beispielsweise Addition, Subtraktion, Multiplikation usw.


Die Zahlen werden mithilfe der Operation ::math::decimal::fromstr in das Dezimalformat konvertiert.

Die Zahlen werden mithilfe der Operation ::math::decimal::tostr wieder in eine Zeichenkette zurückkonvertiert.

# Beispiele

In diesem Abschnitt werden einige einfache Beispiele vorgestellt. Da der Zweck dieser Bibliothek darin besteht, dezimale Rechenoperationen durchzuführen, sind Beispiele möglicherweise der einfachste Weg, um den Umgang mit ihr zu erlernen und den Unterschied zwischen der Verwendung dieses Pakets und der weiteren Nutzung von expr zu erkennen. Informationen zu den einzelnen Prozeduren finden Sie im Abschnitt „API“ dieser Man-Seite.

```
    package require math::decimal

    # Various operations on two numbers.
    # We first convert them to decimal format.
    set a [::math::decimal::fromstr 8.2]
    set b [::math::decimal::fromstr .2]

    # Then we perform our operations. Here we add
    set c [::math::decimal::+ $a $b]

    # Finally we convert back to string format for presentation to the user.
    puts [::math::decimal::tostr $c] ; # => will output 8.4

    # Other examples
    #
    # Subtraction
    set c [::math::decimal::- $a $b]
    puts [::math::decimal::tostr $c] ; # => will output 8.0

    # Why bother using this instead of simply expr?
    puts [expr {8.2 + .2}] ; # => will output 8.399999999999999
    puts [expr {8.2 - .2}] ; # => will output 7.999999999999999
    # See http://speleotrove.com/decimal to learn more about why this happens.
```

# API

**::math::decimal::fromstr** *string*
: Wandelt *string* in eine Dezimalzahl um.

**::math::decimal::tostr** *decimal*
: Wandelt *decimal* in eine Zeichenkette um, die die Zahl im Dezimalsystem darstellt.

**::math::decimal::setVariable** *variable* *setting*
: Setzt *variable* auf *setting*. Gültige Variablen sind:

    - *rounding* – Beim Umskalieren zu verwendende Rundungsmethode. Zulässige Methoden sind round\_half\_even, round\_half\_up, round\_half\_down, round\_down, round\_up, round\_floor, round\_ceiling.

    - *precision* – Maximale Anzahl der in der Mantisse zulässigen Ziffern.

    - *extended* – 1 für den erweiterten Modus, 0 für den vereinfachten Modus.

    - *maxExponent* – Maximaler Wert für den Exponenten. Der Standardwert beträgt 999.

    - *minExponent* – Minimaler Wert für den Exponenten. Standardwert: -998.


**::math::decimal::add** *a* *b*
: siehe unten ...

**::math::decimal::+** *a* *b*
: Gibt die Summe der beiden Dezimalzahlen *a* und *b* zurück.

**::math::decimal::subtract** *a* *b*
: siehe unten ...

**::math::decimal::-** *a* *b*
: Gibt die Differenz der beiden Dezimalzahlen *a* und *b* zurück.

**::math::decimal::multiply** *a* *b*
: siehe unten ...

**::math::decimal::\*** *a* *b*
: Gibt das Produkt der beiden Dezimalzahlen *a* und *b* zurück.

**::math::decimal::divide** *a* *b*
: siehe unten ...

**::math::decimal::/** *a* *b*
: Gibt den Quotienten der Division der beiden Dezimalzahlen *a* und *b* zurück.

**::math::decimal::divideint** *a* *b*
: Gibt den ganzzahligen Teil des Quotienten der Division der Dezimalzahlen *a* und *b* zurück.

**::math::decimal::remainder** *a* *b*
: Gibt den Rest der Division der beiden Dezimalzahlen *a* und *b* zurück.

**::math::decimal::abs** *decimal*
: Gibt den Betrag (Absolutwert) der Dezimalzahl zurück.

**::math::decimal::compare** *a* *b*
: Vergleicht die beiden Dezimalzahlen a und b und gibt *0* zurück, wenn *a == b* gilt, *1*, wenn *a > b* gilt, und *-1*, wenn *a < b* gilt.

**::math::decimal::max** *a* *b*
: Vergleicht die beiden Dezimalzahlen a und b und gibt *a* zurück, wenn *a >= b* gilt, und *b*, wenn *a < b* gilt.

**::math::decimal::maxmag** *a* *b*
: Vergleicht die beiden Dezimalzahlen a und b ohne Berücksichtigung ihrer Vorzeichen und gibt *a* zurück, wenn *abs(a) >= abs(b)* gilt, und *b*, wenn *abs(a) < abs(b)* gilt.

**::math::decimal::min** *a* *b*
: Vergleicht die beiden Dezimalzahlen a und b und gibt *a* zurück, wenn *a <= b* gilt, und *b*, wenn *a > b* gilt.

**::math::decimal::minmag** *a* *b*
: Vergleicht die beiden Dezimalzahlen a und b ohne Berücksichtigung ihrer Vorzeichen und gibt *a* zurück, wenn *abs(a) <= abs(b)* gilt, und *b*, wenn *abs(a) > abs(b)* gilt.

**::math::decimal::plus** *a*
: Gibt das Ergebnis von *::math::decimal::+ 0 $a* zurück.

**::math::decimal::minus** *a*
: Gibt das Ergebnis von *::math::decimal::- 0 $a* zurück.

**::math::decimal::copynegate** *a*
: Gibt *a* mit umgekehrtem Vorzeichen zurück.

**::math::decimal::copysign** *a* *b*
: Gibt *a* zurück, wobei das Vorzeichen auf das Vorzeichen von *b* gesetzt wird.

**::math::decimal::is-signed** *decimal*
: Gibt das Vorzeichen der Dezimalzahl zurück. Die Prozedur gibt 0 zurück, wenn die Zahl positiv ist, und 1, wenn sie negativ ist.

**::math::decimal::is-zero** *decimal*
: Gibt true zurück, wenn der *decimal*-Wert Null ist, andernfalls false.

**::math::decimal::is-NaN** *decimal*
: Gibt true zurück, wenn der *decimal*-Wert NaN (keine Zahl) ist, andernfalls false.

**::math::decimal::is-infinite** *decimal*
: Gibt true zurück, wenn der *decimal*-Wert unendlich ist, andernfalls false.

**::math::decimal::is-finite** *decimal*
: Gibt true zurück, wenn der *decimal*-Wert endlich ist, andernfalls false.

**::math::decimal::fma** *a* *b* *c*
: Gibt das Ergebnis zurück, das sich ergibt, wenn zunächst *a* mit *b* multipliziert und anschließend *c* addiert wird. Das Umskalieren erfolgt erst nach Abschluss aller Rechenoperationen. Daher kann das Ergebnis von dem abweichen, das sich bei getrennter Ausführung der einzelnen Rechenoperationen ergibt.

**::math::decimal::round\_half\_even** *decimal* *digits*
: Rundet *decimal* auf *digits* Dezimalstellen nach den folgenden Regeln: Auf den nächstgelegenen Wert runden. Bei gleichem Abstand so runden, dass die letzte Ziffer gerade ist.

**::math::decimal::round\_half\_up** *decimal* *digits*
: Rundet *decimal* auf *digits* Dezimalstellen nach den folgenden Regeln: Auf den nächstgelegenen Wert runden. Bei gleichem Abstand aufrunden.

**::math::decimal::round\_half\_down** *decimal* *digits*
: Rundet *decimal* auf *digits* Dezimalstellen nach den folgenden Regeln: Auf den nächstgelegenen Wert runden. Bei gleichem Abstand abrunden.

**::math::decimal::round\_down** *decimal* *digits*
: Rundet *decimal* auf *digits* Dezimalstellen nach den folgenden Regeln: In Richtung 0 runden.  (Abschneiden)

**::math::decimal::round\_up** *decimal* *digits*
: Rundet *decimal* auf *digits* Dezimalstellen nach den folgenden Regeln: Von 0 weg runden

**::math::decimal::round\_floor** *decimal* *digits*
: Rundet *decimal* auf *digits* Dezimalstellen nach den folgenden Regeln: In Richtung -Infinity runden.

**::math::decimal::round\_ceiling** *decimal* *digits*
: Rundet *decimal* auf *digits* Dezimalstellen nach den folgenden Regeln: In Richtung Infinity runden

**::math::decimal::round\_05up** *decimal* *digits*
: Rundet *decimal* auf *digits* Dezimalstellen nach den folgenden Regeln: Bei 0 oder 5 von 0 weg runden. Wie round-up, mit dem Unterschied, dass nur dann aufgerundet wird, wenn die aufzurundende Ziffer 0 oder 5 ist, und dass das Ergebnis nach einem Überlauf dasselbe ist wie bei round-down.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *decimal* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2011 Mark Alston <mark at beernut dot com>
```
