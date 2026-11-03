---
CommandName: expr
title: expr
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - array(n)
 - for(n)
 - if(n)
 - mathfunc(n)
 - mathop(n)
 - namespace(n)
 - proc(n)
 - string(n)
 - Tcl(n)
 - while(n)
Keywords:
 - arithmetic
 - boolean
 - compare
 - expression
 - fuzzy comparison
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-2000 Sun Microsystems, Inc.
 - Copyright (c) 2005 Kevin B. Kenny <kennykb@acm.org>. All rights reserved
---

# Name

expr - Einen Ausdruck auswerten

# Übersicht

::: {.synopsis} :::
[expr]{.cmd} [arg]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Verkettet die *arg*s (wobei zwischen ihnen trennende Leerzeichen eingefügt werden), wertet das Ergebnis als Tcl-Ausdruck aus und gibt den Wert zurück. Die in Tcl-Ausdrücken zulässigen Operatoren sind eine Teilmenge der in C-Ausdrücken zulässigen Operatoren. Für die Operatoren, die Tcl und C gemeinsam haben, verwendet Tcl dieselbe Bedeutung und Priorität wie bei den entsprechenden C-Operatoren. Ausdrücke liefern fast immer numerische Ergebnisse (Ganzzahl- oder Gleitkommawerte). Zum Beispiel ergibt der Ausdruck

```
expr 8.2 + 6
```

den Wert 14.2. Tcl-Ausdrücke unterscheiden sich von C-Ausdrücken in der Art, wie Operanden angegeben werden. Außerdem unterstützen Tcl-Ausdrücke nicht-numerische Operanden und Zeichenkettenvergleiche sowie einige zusätzliche Operatoren, die es in C nicht gibt.

## Operanden

Ein Tcl-Ausdruck besteht aus einer Kombination von Operanden, Operatoren, Klammern und Kommas. Zwischen Operanden, Operatoren und Klammern (oder Kommas) darf Leerraum stehen; die Anweisungen des Ausdrucks ignorieren ihn. Wo möglich, werden Operanden als Ganzzahlwerte interpretiert. Ganzzahlwerte können dezimal (der Normalfall), binär (wenn die ersten beiden Zeichen des Operanden **0b** sind), oktal (wenn die ersten beiden Zeichen des Operanden **0o** sind) oder hexadezimal (wenn die ersten beiden Zeichen des Operanden **0x** sind) angegeben werden. Zur Kompatibilität mit älteren Tcl-Versionen wird ein oktaler Ganzzahlwert auch schon dann angenommen, wenn das erste Zeichen des Operanden **0** ist, unabhängig davon, ob das zweite Zeichen ebenfalls **o** ist. Hat ein Operand keines der oben genannten Ganzzahlformate, wird er als Gleitkommazahl behandelt, sofern das möglich ist. Gleitkommazahlen können in mehreren gängigen Formaten angegeben werden, die die Dezimalziffern, den Dezimalpunkt **.**, die Zeichen **e** oder **E** für die wissenschaftliche Notation und die Vorzeichen **+** oder **-** verwenden. Zum Beispiel sind alle folgenden Werte gültige Gleitkommazahlen: 2.1, 3., 6e4, 7.91e+16. Ebenfalls als Gleitkommawerte erkannt werden die Zeichenketten **Inf** und **NaN**, wobei jedes Zeichen groß oder klein geschrieben sein darf. Ist keine numerische Interpretation möglich (beachten Sie, dass alle literalen Operanden, die weder numerisch noch boolesch sind, entweder mit geschweiften Klammern oder mit doppelten Anführungszeichen quotiert werden müssen), bleibt ein Operand eine Zeichenkette, und nur eine begrenzte Menge von Operatoren kann auf ihn angewendet werden.

Operanden können auf jede der folgenden Arten angegeben werden:

1. Als numerischer Wert, entweder als Ganzzahl oder als Gleitkommazahl.

2. Als boolescher Wert in jeder Form, die [string is][string] **boolean** versteht.

3. Als Tcl-Variable in der üblichen **$**-Notation. Der Wert der Variablen wird als Operand verwendet.

4. Als Zeichenkette in doppelten Anführungszeichen. Der Ausdrucksparser führt auf dem Inhalt zwischen den Anführungszeichen Backslash-, Variablen- und Befehlsersetzung aus und verwendet den resultierenden Wert als Operand.

5. Als Zeichenkette in geschweiften Klammern. Die Zeichen zwischen der öffnenden und der zugehörigen schließenden Klammer werden ohne jede Ersetzung als Operand verwendet.

6. Als Tcl-Befehl in eckigen Klammern. Der Befehl wird ausgeführt, und sein Ergebnis wird als Operand verwendet.

7. Als mathematische Funktion, deren Argumente eine der obigen Formen für Operanden haben, etwa **sin($x)**. Wie mathematische Funktionen behandelt werden, ist unten unter [Mathematische Funktionen] beschrieben.


Wo die obigen Ersetzungen vorkommen (z. B. innerhalb von Zeichenketten in Anführungszeichen), werden sie von den Anweisungen des Ausdrucks ausgeführt. Der Befehlsparser kann jedoch bereits eine Ersetzungsrunde ausgeführt haben, bevor der Ausdrucksprozessor aufgerufen wurde. Wie unten erläutert, ist es meist am besten, Ausdrücke in geschweifte Klammern zu setzen, damit der Befehlsparser keine Ersetzungen am Inhalt vornimmt.

Nehmen Sie für einige Beispiele einfacher Ausdrücke an, dass die Variable **a** den Wert 3 und die Variable **b** den Wert 6 hat. Dann liefert der Befehl auf der linken Seite jeder der folgenden Zeilen den Wert auf der rechten Seite der Zeile:

```
expr {3.1 + $a}	6.1
expr {2 + "$a.$b"}	5.6
expr {4*[llength "6 2"]}	8
expr {{word one} < "word $a"}	0
```

## Operatoren

Die gültigen Operatoren (die meisten davon sind auch als Befehle im Namespace **tcl::mathop** verfügbar; Einzelheiten finden Sie auf der Handbuchseite [mathop]\(n)) sind unten aufgeführt, gruppiert in absteigender Reihenfolge der Priorität:

**-  +  ~  !**
: Unäres Minus, unäres Plus, bitweises NOT, logisches NOT. Keiner dieser Operatoren darf auf Zeichenkettenoperanden angewendet werden, und bitweises NOT darf nur auf Ganzzahlen angewendet werden.

**\*\***
: Potenzierung. Gültig für alle numerischen Operanden. Ist die erste Zahl eine Ganzzahl > 1, ist der größte Exponent, den Tcl verarbeiten kann, 268435455.

**\*  /  %**
: Multiplikation, Division, Rest. Keiner dieser Operatoren darf auf Zeichenkettenoperanden angewendet werden, und der Rest darf nur auf Ganzzahlen angewendet werden. Der Rest hat immer dasselbe Vorzeichen wie der Divisor und einen Betrag, der kleiner ist als der Betrag des Divisors.

    Bei Ganzzahlen lassen sich die Divisions- und Restoperatoren so auffassen, dass sie die Zahlengerade in eine Folge gleich großer, aneinandergrenzender, sich nicht überlappender Abschnitte aufteilen, von denen jeder so groß ist wie der Divisor. Das Ergebnis der Division gibt an, in welchem Abschnitt der Dividend liegt, und das Ergebnis des Rests gibt an, an welcher Stelle innerhalb dieses Abschnitts er liegt. Daraus folgt, dass das Ergebnis von „-57 **/** 10“ immer -6 und das Ergebnis von „-57 **%** 10“ immer 3 ist.

**+  -**
: Addition und Subtraktion. Gültig für alle numerischen Operanden.

**<<  >>**
: Links- und Rechtsverschiebung. Nur für Ganzzahloperanden gültig. Eine Rechtsverschiebung überträgt immer das Vorzeichenbit.

**<  >  <=  >=**
: Boolesches Kleiner, Größer, Kleiner-gleich und Größer-gleich. Jeder Operator liefert 1, wenn die Bedingung wahr ist, andernfalls 0. Diese Operatoren können sowohl auf Zeichenketten als auch auf numerische Operanden angewendet werden; bei Zeichenketten wird ein Zeichenkettenvergleich verwendet.

**==  !=**
: Boolesches Gleich und Ungleich. Jeder Operator liefert als Ergebnis null oder eins. Gültig für alle Operandentypen.

**eq  ne**
: Boolesches Zeichenketten-Gleich und Zeichenketten-Ungleich. Jeder Operator liefert als Ergebnis null oder eins. Die Operanden werden ausschließlich als Zeichenketten interpretiert.

**in  ni**
: Enthaltensein in einer Liste und dessen Verneinung. Jeder Operator liefert als Ergebnis null oder eins und behandelt sein erstes Argument als Zeichenkette und sein zweites Argument als Tcl-Liste. Der Operator **in** gibt an, ob das erste Argument ein Element der Liste im zweiten Argument ist; der Operator **ni** kehrt das Ergebnis um.

**&**
: Bitweises AND. Nur für Ganzzahloperanden gültig.

**^**
: Bitweises exklusives OR. Nur für Ganzzahloperanden gültig.

**|**
: Bitweises OR. Nur für Ganzzahloperanden gültig.

**&&**
: Logisches AND. Liefert 1, wenn beide Operanden ungleich null sind, andernfalls 0. Nur für boolesche und numerische Operanden (Ganzzahlen oder Gleitkommazahlen) gültig. Dieser Operator wertet faul aus: Er wertet seinen zweiten Operanden nur aus, wenn das zur Bestimmung des Ergebnisses nötig ist.

**||**
: Logisches OR. Liefert 0, wenn beide Operanden null sind, andernfalls 1. Nur für boolesche und numerische Operanden (Ganzzahlen oder Gleitkommazahlen) gültig. Dieser Operator wertet faul aus: Er wertet seinen zweiten Operanden nur aus, wenn das zur Bestimmung des Ergebnisses nötig ist.

*x* **?** *y* **:** *z*
: Wenn-dann-sonst wie in C. Ergibt die Auswertung von *x* einen Wert ungleich null, ist das Ergebnis der Wert von *y*. Andernfalls ist das Ergebnis der Wert von *z*. Der Operand *x* muss einen booleschen oder numerischen Wert haben. Dieser Operator wertet faul aus: Er wertet nur entweder *y* oder *z* aus.


Weitere Einzelheiten zu den Ergebnissen der einzelnen Operatoren finden Sie in der C-Dokumentation. Der Potenzierungsoperator wandelt Typen wie die Multiplikations- und Divisionsoperatoren um und liefert dasselbe Ergebnis wie die Funktion **pow** (nach etwaigen Typumwandlungen). Alle binären Operatoren außer der Potenzierung gruppieren innerhalb derselben Prioritätsstufe von links nach rechts; die Potenzierung gruppiert von rechts nach links. Zum Beispiel gibt der Befehl

```
expr {4*2 < 7}
```

0 zurück, während

```
expr {2**3**2}
```

512 zurückgibt.

Die Operatoren **&&**, **||** und **?:** werten wie in C „faul“ aus. Das bedeutet, dass Operanden nicht ausgewertet werden, wenn sie zur Bestimmung des Ergebnisses nicht benötigt werden. Zum Beispiel wird im Befehl

```
expr {$v?[a]:[b]}
```

nur entweder „**\[a\]**“ oder „**\[b\]**“ tatsächlich ausgewertet, abhängig vom Wert von **$v**. Beachten Sie jedoch, dass dies nur gilt, wenn der gesamte Ausdruck in geschweifte Klammern eingeschlossen ist; andernfalls wertet der Tcl-Parser sowohl „**\[a\]**“ als auch „**\[b\]**“ aus, bevor er den Befehl **expr** aufruft.

## Mathematische Funktionen

Trifft der Ausdrucksparser auf eine mathematische Funktion wie **sin($x)**, ersetzt er sie durch den Aufruf eines gewöhnlichen Tcl-Befehls im Namespace **tcl::mathfunc**. Die Verarbeitung eines Ausdrucks wie:

```
expr {sin($x+$y)}
```

ist in jeder Hinsicht dieselbe wie die Verarbeitung von:

```
expr {[tcl::mathfunc::sin [expr {$x+$y}]]}
```

was wiederum dasselbe ist wie die Verarbeitung von:

```
tcl::mathfunc::sin [expr {$x+$y}]
```

Der Ausführer sucht **tcl::mathfunc::sin** nach den üblichen Regeln für die Auflösung von Funktionen in Namespaces. Sowohl [::tcl::mathfunc::sin][mathfunc] als auch **\[namespace current\]::tcl::mathfunc::sin** erfüllen die Anforderung, und je nach der aktuellen Einstellung von [namespace path][namespace] können es auch andere tun.

Einige mathematische Funktionen haben mehrere Argumente, die wie in C durch Kommas getrennt werden. So wird

```
expr {hypot($x,$y)}
```

letztlich zu

```
tcl::mathfunc::hypot $x $y
```

Die standardmäßig verfügbaren mathematischen Funktionen sind auf der Handbuchseite [mathfunc]\(n) beschrieben.

## Typen, Überlauf und Genauigkeit

Alle internen Berechnungen mit Ganzzahlen werden bei Bedarf mit der Bibliothek LibTomMath für Ganzzahlen beliebiger Genauigkeit ausgeführt, sodass alle Ganzzahlberechnungen exakt erfolgen. Beachten Sie, dass in Tcl-Versionen vor 8.5 Ganzzahlberechnungen mit einem der C-Typen *long int* oder *Tcl\_WideInt* ausgeführt wurden. Bei Berechnungen, deren Werte den Bereich dieser Typen überschritten, führte das zu einer impliziten Kürzung auf diesen Bereich. Code, der sich auf diese impliziten Kürzungen verlassen hat, muss an den Stellen, an denen eine solche Kürzung stattfinden soll, ausdrücklich Aufrufe der Funktionen **int()** oder **wide()** in die Ausdrücke einfügen.

Alle internen Berechnungen mit Gleitkommazahlen werden mit dem C-Typ *double* ausgeführt. Beim Umwandeln einer Zeichenkette in eine Gleitkommazahl wird ein Exponentenüberlauf erkannt und ergibt je nach Fall den *double*-Wert **Inf** oder **-Inf**. Gleitkomma-Überlauf und -Unterlauf werden in dem Maß erkannt, in dem die Hardware es unterstützt; das ist im Allgemeinen recht zuverlässig.

Die Umwandlung zwischen den internen Darstellungen für Ganzzahl-, Gleitkomma- und Zeichenkettenoperanden erfolgt bei Bedarf automatisch. Bei arithmetischen Berechnungen werden Ganzzahlen verwendet, bis eine Gleitkommazahl hinzukommt; danach wird mit Gleitkommazahlen gerechnet. Zum Beispiel gibt

```
expr {5 / 4}
```

1 zurück, während

```
expr {5 / 4.0}
expr {5 / ( [string length "abcd"] + 0.0 )}
```

beide 1.25 zurückgeben. Gleitkommawerte werden immer mit einem „**.**“ oder einem „**e**“ zurückgegeben, damit sie nicht wie Ganzzahlwerte aussehen. Zum Beispiel gibt

```
expr {20.0/5.0}
```

**4.0** zurück, nicht **4**.

## Zeichenkettenoperationen

Zeichenkettenwerte können als Operanden der Vergleichsoperatoren verwendet werden. Der Ausdrucksauswerter versucht jedoch, Vergleiche als Ganzzahl- oder Gleitkommavergleiche auszuführen, wenn er kann, d. h. wenn alle Argumente des Operators eine numerische Interpretation zulassen; ausgenommen sind die Operatoren **eq** und **ne**. Ist einer der Operanden eines Vergleichs eine Zeichenkette und hat der andere einen numerischen Wert, wird eine kanonische Zeichenkettendarstellung des numerischen Operanden erzeugt, die mit dem Zeichenkettenoperanden verglichen wird. Die kanonische Zeichenkettendarstellung für Ganzzahlwerte ist eine Dezimalzahl als Zeichenkette. Die kanonische Zeichenkettendarstellung für Gleitkommawerte ist diejenige, die der Formatbezeichner **%g** des Tcl-Befehls [format] erzeugt. Zum Beispiel geben die Befehle

```
expr {"0x03" > "2"}
expr {"0y" > "0x12"}
```

beide 1 zurück. Der erste Vergleich erfolgt als Ganzzahlvergleich, der zweite als Zeichenkettenvergleich. Weil Tcl dazu neigt, Werte wann immer möglich als Zahlen zu behandeln, ist es im Allgemeinen keine gute Idee, Operatoren wie **==** zu verwenden, wenn Sie eigentlich einen Zeichenkettenvergleich wollen und die Werte der Operanden beliebig sein können. In diesen Fällen ist es besser, stattdessen die Operatoren **eq** oder **ne** oder den Befehl [string] zu verwenden.

# Leistungshinweise

Setzen Sie Ausdrücke in geschweifte Klammern, um die beste Geschwindigkeit und den geringsten Speicherbedarf zu erreichen. So kann der Tcl-Bytecode-Compiler den besten Code erzeugen.

Wie oben erwähnt, werden Ausdrücke zweimal ersetzt: einmal vom Tcl-Parser und einmal vom Befehl **expr**. Zum Beispiel geben die Befehle

```
set a 3
set b {$a + 2}
expr $b*4
```

11 zurück und kein Vielfaches von 4. Das liegt daran, dass der Tcl-Parser zuerst „**$a + 2**“ für die Variable **b** einsetzt und der Befehl **expr** dann den Ausdruck „**$a + 2\*4**“ auswertet.

Die meisten Ausdrücke benötigen keine zweite Ersetzungsrunde. Entweder sind sie in geschweifte Klammern eingeschlossen, oder ihre Variablen- und Befehlsersetzungen ergeben Zahlen oder Zeichenketten, die selbst keine Ersetzungen erfordern. Weil jedoch einige Ausdrücke ohne geschweifte Klammern zwei Ersetzungsrunden benötigen, muss der Bytecode-Compiler zusätzliche Anweisungen erzeugen, um diesen Fall zu behandeln. Der aufwendigste Code ist für Ausdrücke ohne geschweifte Klammern nötig, die Befehlsersetzungen enthalten. Solche Ausdrücke müssen umgesetzt werden, indem bei jeder Ausführung des Ausdrucks neuer Code erzeugt wird.

Muss eine nicht konstante Ausdruckszeichenkette in den größeren Zusammenhang eines ansonsten konstanten Ausdrucks eingefügt werden, ist es am effizientesten, den veränderlichen Teil in ein rekursives **expr** zu setzen. So kann zumindest der äußere Teil kompiliert werden, auch wenn der veränderliche Teil dann selbst als eigener Ausdruck ausgewertet werden muss. In diesem Beispiel ist das Ergebnis also 20, und der äußere Ausdruck profitiert von einer vollständig zwischengespeicherten Bytecode-Kompilierung.

```
set a 3
set b {$a + 2}
expr {[expr $b] * 4}
```

Wird ein Ausdruck ohne geschweifte Klammern geschrieben, damit eine Funktion oder ein Operator ersetzt werden kann, sollten Sie in Erwägung ziehen, stattdessen direkt die Befehle zu verwenden, die auf den Handbuchseiten [mathfunc]\(n) oder [mathop]\(n) beschrieben sind.

# Beispiele

Definiert eine Prozedur, die eine „interessante“ mathematische Funktion berechnet:

```
proc tcl::mathfunc::calc {x y} {
    expr { ($x**2 - $y**2) / exp($x**2 + $y**2) }
}
```

Rechnet Polarkoordinaten in kartesische Koordinaten um:

```
# Umrechnung von ($radius,$angle)
set x [expr { $radius * cos($angle) }]
set y [expr { $radius * sin($angle) }]
```

Rechnet kartesische Koordinaten in Polarkoordinaten um:

```
# Umrechnung von ($x,$y)
set radius [expr { hypot($y, $x) }]
set angle  [expr { atan2($y, $x) }]
```

Gibt eine Meldung aus, die beschreibt, in welcher Beziehung zwei Zeichenkettenwerte zueinander stehen:

```
puts "a and b are [expr {$a eq $b ? {equal} : {different}}]"
```

Setzt eine Variable darauf, ob eine Umgebungsvariable überhaupt definiert ist und zugleich einen wahren booleschen Wert hat:

```
set isTrue [expr {
    [info exists ::env(SOME_ENV_VAR)] &&
    [string is true -strict $::env(SOME_ENV_VAR)]
}]
```

Erzeugt eine zufällige Ganzzahl im Bereich 0..99 einschließlich:

```
set randNum [expr { int(100 * rand()) }]
```

# Copyright

```
Copyright © 1993 The Regents of the University of California.
Copyright © 1994-2000 Sun Microsystems Incorporated.
Copyright © 2005 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
```


[format]: format.md
[mathfunc]: mathfunc.md
[mathop]: mathop.md
[namespace]: namespace.md
[string]: string.md
