---
CommandName: math::exact
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Tcl Math Library
Copyright:
 - Copyright (c) 2015 Kevin B. Kenny <kennykb@acm.org>
 - Redistribution permitted under the terms of the Open Publication License <http://www.opencontent.org/openpub/>
---

# NAME

math::exact – Exakte reelle Arithmetik

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [grammar::aycock]{.lit} [1.0]{.lit} 
[package]{.cmd} [require]{.sub} [math::exact]{.lit} [1.0.2]{.lit} 
[::math::exact::exactexpr]{.cmd} [expr]{.arg} 
[number]{.ins} [ref]{.sub} 
[number]{.ins} [unref]{.sub} 
[number]{.ins} [asPrint]{.sub} [precision]{.arg} 
[number]{.ins} [asFloat]{.sub} [precision]{.arg} 
:::

# BESCHREIBUNG

Der Befehl **exactexpr** im Paket **math::exact** ermöglicht exakte Berechnungen über den Bereich der berechenbaren reellen Zahlen. Dabei handelt es sich nicht um Berechnungen mit beliebiger Genauigkeit, sondern um exakte Berechnungen, bei denen Zahlen durch Algorithmen dargestellt werden, die aufeinanderfolgende Näherungswerte erzeugen. Am Ende einer Berechnung kann der Aufrufer eine bestimmte Genauigkeit für das Endergebnis anfordern, und Zwischenergebnisse werden mit der Genauigkeit berechnet, die zur Erfüllung dieser Anforderung erforderlich ist.

# PROZEDUREN

Die folgende Prozedur ist der primäre Einstieg in das Paket **math::exact**.

**::math::exact::exactexpr** *expr*
: Nimmt einen mathematischen Ausdruck in Tcl-Syntax entgegen und gibt ein Objekt zurück, das das Programm zur Berechnung aufeinanderfolgender Näherungswerte für den Wert des Ausdrucks darstellt. Das Ergebnis wird als exakte reelle Zahl bezeichnet.

*number* **ref**
: Erhöht die Referenzanzahl einer bestimmten exakten reellen Zahl.

*number* **unref**
: Verringert die Referenzanzahl einer bestimmten exakten reellen Zahl und löscht die Zahl, wenn die Referenzanzahl Null ist.

*number* **asPrint** *precision*
: Formatiert die angegebene *number* für die Ausgabe mit der festgelegten *precision*. (Wie *precision* interpretiert wird, erfahren Sie weiter unten.) Zahlen, von denen bekannt ist, dass sie rational sind, werden als Brüche formatiert.

*number* **asFloat** *precision*
: Formatiert die angegebene *number* für die Ausgabe mit der festgelegten *precision*. (Wie *precision* interpretiert wird, erfahren Sie weiter unten.) Alle Zahlen werden im Gleitkomma-E-Format formatiert.


# PARAMETER

*expr*
: Auszuwertender Ausdruck. Die Syntax für Ausdrücke entspricht der in Tcl, allerdings ist der Umfang der verfügbaren Operationen geringer. Weitere Einzelheiten finden Sie weiter unten im Abschnitt **AUSDRÜCKE**.

*number*
: Das Objekt, das bei einem früheren Aufruf von **math::exact::exactexpr** zurückgegeben wurde

*precision*
: Die gewünschte „Genauigkeit“ des Ergebnisses. Die Genauigkeit entspricht (ungefähr) dem Betrag des binären Exponenten zuzüglich der Anzahl der Bits der binären Mantisse. Um beispielsweise Ergebnisse in IEEE-754-Gleitkommazahlen doppelter Genauigkeit zurückzugeben, sind 56 Bits zuzüglich des Exponenten erforderlich. Zahlen zwischen 1/2 und 2 erfordern eine Genauigkeit von 57; Zahlen zwischen 1/4 und 1/2 oder zwischen 2 und 4 erfordern 58; Zahlen zwischen 1/8 und 1/4 oder zwischen 4 und 8 erfordern 59; und so weiter.


# AUSDRÜCKE

Der Befehl **math::exact::exactexpr** akzeptiert Ausdrücke, die auf einer Teilmenge der Tcl-Syntax basieren. Die folgenden Komponenten dürfen in einem Ausdruck verwendet werden.

**•**
: Dezimalganzzahlen.

**•**
: Variablenreferenzen mit dem Dollarzeichen (**\$**). Der Wert der Variablen muss das Ergebnis eines weiteren Aufrufs von **math::exact::exactexpr** sein. Die Referenzanzahl des Werts wird für jede Stelle, an der er im Ausdruck vorkommt, um eins erhöht.

**•**
: Der Potenzierungsoperator (**\*\***).

**•**
: Unäre Plus- (**+**) und Minus- (**-**) Operatoren.

**•**
: Die Operatoren für die Multiplikation (**\***) und die Division (**/**).

**•**
: Klammern zur Gruppierung.

**•**
: Funktionen. Die verfügbaren Funktionen finden Sie weiter unten im Abschnitt **FUNKTIONEN**.


# FUNKTIONEN

Die folgenden Funktionen stehen zur Verwendung in exakten reellen Ausdrücken zur Verfügung.

**acos(**_x_**)**
: Der Arkuskosinus von *x*. Das Ergebnis wird im Bogenmaß angegeben. Der Betrag von *x* muss kleiner als 1 sein.

**acosh(**_x_**)**
: Der inverse hyperbolische Kosinus von *x*. *x* muss größer als 1 sein.

**asin(**_x_**)**
: Der Arkussinus von *x*. Das Ergebnis wird im Bogenmaß angegeben. Der Betrag von *x* muss kleiner als 1 sein.

**asinh(**_x_**)**
: Der inverse hyperbolische Sinus von *x*.

**atan(**_x_**)**
: Der Arkustangens von *x*. Das Ergebnis wird im Bogenmaß angegeben.

**atanh(**_x_**)**
: Der inverse hyperbolische Tangens von *x*. Der Betrag von *x* muss kleiner als 1 sein.

**cos(**_x_**)**
: Der Kosinus von *x*. *x* wird im Bogenmaß angegeben.

**cosh(**_x_**)**
: Der hyperbolische Kosinus von *x*.

**e()**
: Die Basis der natürlichen Logarithmen = **2.71828...**

**exp(**_x_**)**
: Die Exponentialfunktion von *x*.

**log(**_x_**)**
: Der natürliche Logarithmus von *x*. *x* muss positiv sein.

**pi()**
: Der Wert von Pi = **3.15159...**

**sin(**_x_**)**
: Der Sinus von *x*. *x* wird im Bogenmaß angegeben.

**sinh(**_x_**)**
: Der hyperbolische Sinus von *x*.

**sqrt(**_x_**)**
: Die Quadratwurzel von *x*. *x* muss positiv sein.

**tan(**_x_**)**
: Der Tangens von *x*. *x* wird im Bogenmaß angegeben.

**tanh(**_x_**)**
: Der hyperbolische Tangens von *x*.


# ZUSAMMENFASSUNG

Der Befehl **math::exact::exactexpr** stellt ein System bereit, das exakte Arithmetik über berechenbare reelle Zahlen durchführt, wobei die Zahlen als Algorithmen zur sukzessiven Annäherung dargestellt werden. Nachstehend finden Sie ein Beispiel, das die aus der Schule bekannte Lösungsformel für quadratische Gleichungen umsetzt.

```
namespace import math::exact::exactexpr
proc exactquad {a b c} {
    set d [[exactexpr {sqrt($b*$b - 4*$a*$c)}] ref]
    set r0 [[exactexpr {(-$b - $d) / (2 * $a)}] ref]
    set r1 [[exactexpr {(-$b + $d) / (2 * $a)}] ref]
    $d unref
    return [list $r0 $r1]
}

set a [[exactexpr 1] ref]
set b [[exactexpr 200] ref]
set c [[exactexpr {(-3/2) * 10**-12}] ref]
lassign [exactquad $a $b $c] r0 r1
$a unref; $b unref; $c unref
puts [list [$r0 asFloat 70] [$r1 asFloat 110]]
$r0 unref; $r1 unref
```

Das Programm gibt das Ergebnis aus:

```
-2.000000000000000075e2 7.499999999999999719e-15
```

Hinweis: Wenn die IEEE-754-Gleitkommadarstellung verwendet worden wäre, hätte ein katastrophaler Rundungsfehler zu einer kleineren Wurzel geführt, die um den Faktor zwei zu hoch ist:

```
-200.0 1.4210854715202004e-14
```

Die Aufrufe von **exactexpr** sollten weitgehend selbsterklärend sein. Die weiteren erwähnenswerten Befehle sind **ref** und **unref**. Der Aufrufer muss den Überblick über Verweise auf exakte Ausdrücke behalten – er muss **ref** jedes Mal aufrufen, wenn ein exakter Ausdruck in einer Variablen gespeichert wird, und **unref** jedes Mal, wenn die Variable den Gültigkeitsbereich verlässt oder überschrieben wird. Die Methode **asFloat** gibt Dezimalziffern aus, solange die angeforderte Genauigkeit dies zulässt. Sie wird beendet, wenn die angeforderte Genauigkeit zu einer Ungenauigkeit von mehr als einer Einheit in der niedrigstwertigen Ziffer führt.

# KATEGORIE

Mathematik

# COPYRIGHT

```
Copyright (c) 2015 Kevin B. Kenny <kennykb@acm.org>
Redistribution permitted under the terms of the Open Publication License <http://www.opencontent.org/openpub/>
```
