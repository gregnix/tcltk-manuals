---
CommandName: math::complexnumbers
title: math::complexnumbers
ManualSection: n
Version: 1.0.3
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - complex numbers
 - math
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

math::complexnumbers – Einfaches Paket für komplexe Zahlen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [math::complexnumbers]{.lit} [1.0.3]{.optlit}
[::math::complexnumbers::+]{.cmd} [z1]{.arg} [z2]{.arg}
[::math::complexnumbers::-]{.cmd} [z1]{.arg} [z2]{.arg}
[::math::complexnumbers::\*]{.cmd} [z1]{.arg} [z2]{.arg}
[::math::complexnumbers::/]{.cmd} [z1]{.arg} [z2]{.arg}
[::math::complexnumbers::conj]{.cmd} [z1]{.arg}
[::math::complexnumbers::real]{.cmd} [z1]{.arg}
[::math::complexnumbers::imag]{.cmd} [z1]{.arg}
[::math::complexnumbers::mod]{.cmd} [z1]{.arg}
[::math::complexnumbers::arg]{.cmd} [z1]{.arg}
[::math::complexnumbers::complex]{.cmd} [real]{.arg} [imag]{.arg}
[::math::complexnumbers::tostring]{.cmd} [z1]{.arg}
[::math::complexnumbers::exp]{.cmd} [z1]{.arg}
[::math::complexnumbers::sin]{.cmd} [z1]{.arg}
[::math::complexnumbers::cos]{.cmd} [z1]{.arg}
[::math::complexnumbers::tan]{.cmd} [z1]{.arg}
[::math::complexnumbers::log]{.cmd} [z1]{.arg}
[::math::complexnumbers::sqrt]{.cmd} [z1]{.arg}
[::math::complexnumbers::pow]{.cmd} [z1]{.arg} [z2]{.arg}
:::

# Beschreibung

Das mathematische Modul *complexnumbers* bietet eine unkomplizierte Implementierung komplexer Zahlen in reinem Tcl. Dahinter steht die Philosophie, dass der Benutzer sich bewusst ist, auf abstrakte Weise mit komplexen Zahlen zu arbeiten, und dabei eine möglichst hohe Leistung anstrebt, wie sie innerhalb der Grenzen eines Interpreters erreichbar ist.

Daher gehen die in diesem Paket definierten Prozeduren davon aus, dass die Argumente gültige (Darstellungen von) „komplexen Zahlen“ sind, d. h. Listen aus zwei Zahlen, die den Real- und den Imaginärteil einer komplexen Zahl definieren (obwohl dies nur ein Detail ist: Verwenden Sie den Befehl *complex*, um eine gültige Zahl zu bilden.)

Die meisten Prozeduren implementieren die grundlegenden arithmetischen Operationen oder elementare Funktionen, während einige andere die Umwandlung zwischen verschiedenen Darstellungsformen vornehmen:

```
    set z [complex 0 1]
    puts "z = [tostring $z]"
    puts "z**2 = [* $z $z]
```

würde zu folgendem Ergebnis führen:

```
    z = i
    z**2 = -1
```

# Verfügbare Prozeduren

Das Paket implementiert alle oder die meisten grundlegenden Operationen und elementaren Funktionen.

*The arithmetic operations are:*

**::math::complexnumbers::+** *z1* *z2*
: Addiert die beiden Argumente und gibt die resultierende komplexe Zahl zurück

    complex *z1* (in)
    : Erstes Argument in der Summierung

    complex *z2* (in)
    : Zweites Argument in der Summierung


**::math::complexnumbers::-** *z1* *z2*
: Subtrahiert das zweite Argument vom ersten und gibt die resultierende komplexe Zahl zurück. Wenn nur ein Argument angegeben wird, wird das Negative von z1 zurückgegeben (d. h. -z1).

    complex *z1* (in)
    : Erstes Argument bei der Subtraktion

    complex *z2* (in)
    : Zweites Argument bei der Subtraktion (optional)


**::math::complexnumbers::\*** *z1* *z2*
: Multipliziert die beiden Argumente und gibt die resultierende komplexe Zahl zurück

    complex *z1* (in)
    : Erstes Argument bei der Multiplikation

    complex *z2* (in)
    : Zweites Argument bei der Multiplikation


**::math::complexnumbers::/** *z1* *z2*
: Teilt das erste Argument durch das zweite und gibt die resultierende komplexe Zahl zurück

    complex *z1* (in)
    : Erstes Argument (Zähler) bei der Division

    complex *z2* (in)
    : Zweites Argument (Nenner) bei der Division


**::math::complexnumbers::conj** *z1*
: Gibt die konjugiert komplexe Zahl der angegebenen komplexen Zahl zurück

    complex *z1* (in)
    : Die betreffende komplexe Zahl



*Conversion/inquiry procedures:*

**::math::complexnumbers::real** *z1*
: Gibt den Realteil der angegebenen komplexen Zahl zurück

    complex *z1* (in)
    : Die betreffende komplexe Zahl


**::math::complexnumbers::imag** *z1*
: Gibt den Imaginärteil der angegebenen komplexen Zahl zurück

    complex *z1* (in)
    : Die betreffende komplexe Zahl


**::math::complexnumbers::mod** *z1*
: Gibt den Betrag (Modulus) der angegebenen komplexen Zahl zurück

    complex *z1* (in)
    : Die betreffende komplexe Zahl


**::math::complexnumbers::arg** *z1*
: Gibt das Argument („Winkel“ im Bogenmaß) der angegebenen komplexen Zahl zurück

    complex *z1* (in)
    : Die betreffende komplexe Zahl


**::math::complexnumbers::complex** *real* *imag*
: Bildet die komplexe Zahl „real + imag\*i“ und gibt sie zurück

    float *real* (in)
    : Der Realteil der neuen komplexen Zahl

    float *imag* (in)
    : Der Imaginärteil der neuen komplexen Zahl


**::math::complexnumbers::tostring** *z1*
: Wandelt die komplexe Zahl in die Form „real + imag\*i“ um und gibt die Zeichenkette zurück

    float *complex* (in)
    : Die umzuwandelnde komplexe Zahl



*Elementary functions:*

**::math::complexnumbers::exp** *z1*
: Berechnet die Exponentialfunktion für das angegebene komplexe Argument und gibt das Ergebnis zurück

    complex *z1* (in)
    : Das komplexe Argument der Funktion


**::math::complexnumbers::sin** *z1*
: Berechnet die Sinusfunktion für das angegebene komplexe Argument und gibt das Ergebnis zurück

    complex *z1* (in)
    : Das komplexe Argument der Funktion


**::math::complexnumbers::cos** *z1*
: Berechnet die Kosinusfunktion für das angegebene komplexe Argument und gibt das Ergebnis zurück

    complex *z1* (in)
    : Das komplexe Argument der Funktion


**::math::complexnumbers::tan** *z1*
: Berechnet die Tangensfunktion für das angegebene komplexe Argument und gibt das Ergebnis zurück

    complex *z1* (in)
    : Das komplexe Argument der Funktion


**::math::complexnumbers::log** *z1*
: Berechnet den (Hauptwert des) Logarithmus für das angegebene komplexe Argument und gibt das Ergebnis zurück

    complex *z1* (in)
    : Das komplexe Argument der Funktion


**::math::complexnumbers::sqrt** *z1*
: Berechnet den (Hauptwert der) Quadratwurzel für das angegebene komplexe Argument und gibt das Ergebnis zurück

    complex *z1* (in)
    : Das komplexe Argument der Funktion


**::math::complexnumbers::pow** *z1* *z2*
: Berechnet „z1 hoch z2“ und gibt das Ergebnis zurück

    complex *z1* (in)
    : Die komplexe Zahl, die potenziert werden soll

    complex *z2* (in)
    : Der zu verwendende komplexe Exponent



# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: complexnumbers* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
