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
 - integer value
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

Fügt *arg*s durch Leerzeichen getrennt zu einem Ausdruck zusammen, wertet diesen aus und gibt seinen Wert zurück. In einem Ausdruck sind eine Teilmenge der in C-Ausdrücken erlaubten Operatoren zulässig. Für Operatoren, die sowohl in Tcl als auch in C vorkommen, gelten dieselbe Bedeutung und dieselbe Priorität wie bei den entsprechenden C-Operatoren. Der Wert eines Ausdrucks ist oft ein numerisches Ergebnis, entweder eine Ganzzahl oder ein Gleitkommawert, kann aber auch ein nicht-numerischer Wert sein. Beispielsweise liefert der Ausdruck

```
expr 8.2 + 6
```

den Wert 14.2. Ausdrücke unterscheiden sich von C-Ausdrücken in der Art, wie Operanden angegeben werden. Ausdrücke unterstützen außerdem nicht-numerische Operanden, Zeichenkettenvergleiche und einige zusätzliche Operatoren, die in C nicht vorkommen.

Ist das Ergebnis eines Ausdrucks eine Ganzzahl, liegt es in Dezimalform vor; ist es eine Gleitkommazahl, in der Form, die der **%g**-Konvertierungsspezifizierer von [format] erzeugt.

[An jeder Stelle im Ausdruck außer innerhalb von doppelten Anführungszeichen oder geschweiften Klammern markiert **#** den Beginn eines Kommentars, der bis zum Zeilenende oder bis zum Ende des Ausdrucks reicht, je nachdem, was zuerst eintritt.]{version="TIP582"}

## Operanden

Ein Ausdruck besteht aus einer Kombination von Operanden, Operatoren, Klammern und Kommas, ggf. mit Leerraum zwischen diesen Elementen, der ignoriert wird. Jeder Operand wird nach Möglichkeit als numerischer Wert interpretiert.

Jeder Operand hat eine der folgenden Formen:

**Numerischer Wert**
: Ganzzahl oder Gleitkommazahl. Die ersten zwei Zeichen einer Ganzzahl können auch **0d** für dezimal, **0b** für binär, **0o** für oktal oder **0x** für hexadezimal sein.

    Eine Gleitkommazahl kann in mehreren gängigen Dezimalformaten angegeben werden und darf den Dezimalpunkt **.**, **e** oder **E** für die wissenschaftliche Notation sowie die Vorzeichen **+** und **-** verwenden. Folgende Werte sind gültige Gleitkommazahlen: 2.1, 3., 6e4, 7.91e+16. Die Zeichenketten **Inf** und **NaN** in beliebiger Groß-/Kleinschreibung werden ebenfalls als Gleitkommawerte erkannt. Ein Operand ohne numerische Interpretation muss in geschweifte Klammern oder doppelte Anführungszeichen gesetzt werden.

    Ziffern in einem numerischen Wert dürfen durch ein oder mehrere Unterstriche „**\_**“ getrennt sein. Ein Trennzeichen darf nur zwischen Ziffern stehen, nicht am Anfang eines numerischen Werts, nicht zwischen der führenden 0 und dem Radix-Präfix und nicht am Ende. Beispiele:

    ```
    expr 100_000_000		100000000
    expr 0xffff_ffff		4294967295
    format 0x%x 0b1111_1110_1101_1011		0xfedb
    expr 3_141_592_653_589e-1_2		3.141592653589
    ```

**Boolescher Wert**
: In jeder von [string is][string] **boolean** verstandenen Form.

**Variable**
: Mit der üblichen **$**-Notation. Der Wert der Variable ist der Wert des Operanden.

**Zeichenkette in doppelten Anführungszeichen**
: Backslash-, Variablen- und Befehlssubstitution erfolgen gemäß den Regeln für [Tcl].

**Zeichenkette in geschweiften Klammern**
: Der Operand wird als Wert in geschweiften Klammern gemäß der Klammerregel in [Tcl] behandelt.

**Tcl-Befehl in eckigen Klammern**
: Befehlssubstitution erfolgt gemäß der Substitutionsregel für Befehle in [Tcl].

**Funktionsaufruf**
: Mathematische Funktion wie **sin($x)**, deren Argumente eine der obigen Operandenformen haben können. Siehe [Mathematische Funktionen] unten.


Da **expr** Werte parst und Substitutionen vornimmt, die [Tcl] bereits geparst und substituiert hat, empfiehlt es sich in der Regel, Ausdrücke in geschweifte Klammern zu setzen, damit [Tcl] die erste Substitutionsrunde vermeidet.

Unten einige einfache Ausdrücke, wenn **a** den Wert 3 und **b** den Wert 6 hat. Der Befehl links erzeugt den Wert rechts.

```
expr {3.1 + $a}	6.1
expr {2 + "$a.$b"}	5.6
expr {4*[llength {6 2}]}	8
expr {{word one} < "word $a"}	0
```

## Operatoren

Bei Operatoren mit numerischem und Zeichenkettenmodus wird der numerische Modus gewählt, wenn alle Operanden numerisch interpretierbar sind. Die Ganzzahl-Interpretation hat Vorrang vor der Gleitkomma-Interpretation. Für Zeichenkettenoperationen auf beliebigen Werten empfiehlt es sich in der Regel, **eq**, **ne** oder den Befehl [string] statt vielseitigerer Operatoren wie **==** zu verwenden.

Sofern nicht anders angegeben, akzeptieren Operatoren auch nicht-numerische Operanden. Der Wert einer booleschen Operation ist 1 bei wahr, sonst 0. Siehe auch [string is][string] **boolean**. Die gültigen Operatoren, von denen die meisten auch als Befehle im Namespace **tcl::mathop** verfügbar sind (siehe [mathop]\(n)), sind unten in abnehmender Priorität aufgeführt:

**-  +  ~  !**
: Unäres Minus, unäres Plus, bitweises NOT, logisches NOT. Diese Operatoren dürfen nur auf numerische Operanden angewendet werden; bitweises NOT nur auf Ganzzahlen.

**\*\***
: Potenzierung. Gültig für numerische Operanden. Der maximale Exponent, den Tcl verarbeiten kann, wenn die erste Zahl eine Ganzzahl > 1 ist, beträgt 268435455.

**\*  /  %**
: Multiplikation und Division (numerische Operanden) sowie Rest (Ganzzahlen). Der Rest hat einen absoluten Betrag kleiner als der des Divisors und dasselbe Vorzeichen wie der Divisor.

    Bei Ganzzahlen kann man Division und Rest als Aufteilung der Zahlengeraden in aneinandergrenzende Intervalle der Größe des Divisors auffassen; der Quotient gibt an, in welchem Intervall der Dividend liegt, der Rest, wo innerhalb dieses Intervalls. Folglich ist das Ergebnis von „-57 **/** 10“ immer -6 und das von „-57 **%** 10“ immer 3.

**+  -**
: Addition und Subtraktion. Gültig für numerische Operanden.

**<<  >>**
: Links- und Rechtsshift. Gültig für Ganzzahlen. Ein Rechtsshift überträgt stets das Vorzeichenbit.

**<  >  <=  >=**
: Boolesche, numerisch bevorzugte Vergleiche: kleiner, größer, kleiner gleich, größer gleich. Ist ein Argument nicht numerisch, erfolgt der Vergleich als UNICODE-Zeichenkettenvergleich wie bei den unten genannten Zeichenkettenoperatoren gleicher Priorität.

**lt  gt  le  ge**
: [Boolesche Zeichenkettenvergleiche: kleiner, größer, kleiner gleich, größer gleich. Vergleichen Werte stets als UNICODE-Zeichenketten (siehe auch [string compare][string]), im Gegensatz zu den obigen numerisch bevorzugten Vergleichen gleicher Priorität.]{version="TIP461"}

**==  !=**
: Boolesches gleich und ungleich.

**eq  ne**
: Boolesches Zeichenketten-gleich und Zeichenketten-ungleich.

**in  ni**
: Listenelement und negiertes Listenelement. Das erste Argument wird als Zeichenkette, das zweite als Liste interpretiert. **in** prüft die Zugehörigkeit zur Liste, **ni** ist die Negation.

**&**
: Bitweises AND. Gültig für Ganzzahl-Operanden.

**^**
: Bitweises exklusives OR. Gültig für Ganzzahl-Operanden.

**|**
: Bitweises OR. Gültig für Ganzzahl-Operanden.

**&&**
: Logisches AND. Sind beide Operanden wahr, ist das Ergebnis 1, sonst 0. Dieser Operator wertet faul aus; er wertet den zweiten Operanden nur aus, wenn das für das Ergebnis nötig ist.

**||**
: Logisches OR. Sind beide Operanden falsch, ist das Ergebnis 0, sonst 1. Dieser Operator wertet faul aus; er wertet den zweiten Operanden nur aus, wenn das für das Ergebnis nötig ist.

*x* **?** *y* **:** *z*
: Wenn-dann-sonst wie in C. Ist *x* wahr, ist das Ergebnis der Wert von *y*, sonst der von *z*. Dieser Operator wertet faul aus; er wertet nur *y* oder *z* aus.


Der Potenzierungsoperator fördert Typen wie Multiplikation und Division; das Ergebnis entspricht **pow**. Potenzierung gruppiert innerhalb einer Prioritätsstufe von rechts nach links, andere binäre Operatoren von links nach rechts. Beispielsweise ist der Wert von

```
expr {4*2 < 7}
```

0, der von

```
expr {2**3**2}
```

512.

Wie in C werten **&&**, **||** und **?:** „faul“ aus: Operanden werden nicht ausgewertet, wenn das für das Ergebnis nicht nötig ist. In

```
expr {$v?[a]:[b]}
```

wird nur **\[a\]** oder **\[b\]** ausgewertet, je nach Wert von **$v**. Das gilt nicht für den normalen Tcl-Parser; daher empfiehlt es sich, die Argumente von **expr** in geschweifte Klammern zu setzen. Ohne Klammern, wie in **expr** $v ? \[a\] : \[b\], werden **\[a\]** und **\[b\]** ausgewertet, bevor **expr** aufgerufen wird.

Einzelheiten zu den Ergebnissen der Operatoren siehe die C-Dokumentation.

## Mathematische Funktionen

Eine mathematische Funktion wie **sin($x)** wird durch einen Aufruf eines gewöhnlichen Tcl-Befehls im Namespace **::tcl::mathfunc** ersetzt. Die Auswertung von

```
expr {sin($x+$y)}
```

entspricht in jeder Hinsicht der Auswertung von

```
expr {[::tcl::mathfunc::sin [expr {$x+$y}]]}
```

was wiederum gleichbedeutend ist mit der Auswertung von

```
::tcl::mathfunc::sin [expr {$x+$y}]
```

[::tcl::mathfunc::sin][mathfunc] wird wie in **NAMESPACE-AUFLÖSUNG** in [namespace]\(n) beschrieben aufgelöst. Bei Standardwert von [namespace path][namespace] sind **\[namespace current\]::tcl::mathfunc::sin** oder [::tcl::mathfunc::sin][mathfunc] typische Auflösungen.

Wie in C kann eine mathematische Funktion mehrere durch Kommas getrennte Argumente haben. So wird

```
expr {hypot($x,$y)}
```

zu

```
::tcl::mathfunc::hypot $x $y
```

Verfügbare Standard-Mathefunktionen siehe [mathfunc]\(n).

## Typen, Überlauf und Genauigkeit

Interne Gleitkomma-Berechnungen nutzen den C-Typ *double*. Beim Umwandeln einer Zeichenkette in Gleitkomma wird Exponentenüberlauf erkannt und liefert den *double*-Wert **Inf** bzw. **-Inf**. Gleitkomma-Über- und Unterlauf werden soweit von der Hardware unterstützt erkannt, was in der Regel zuverlässig ist.

Die Umwandlung zwischen internen Darstellungen für Ganzzahl, Gleitkomma und Zeichenkette erfolgt bei Bedarf automatisch. Bei arithmetischen Berechnungen werden Ganzzahlen verwendet, bis eine Gleitkommazahl ins Spiel kommt; danach Gleitkomma. Beispielsweise liefert

```
expr {5 / 4}
```

1, während

```
expr {5 / 4.0}
expr {5 / ( [string length "abcd"] + 0.0 )}
```

beide 1.25 ergeben. Ein Gleitkomma-Ergebnis erkennt man am „**.**“ oder „**e**“.

Beispielsweise liefert

```
expr {20.0/5.0}
```

**4.0**, nicht **4**.

# Leistungshinweise

Enthält ein Ausdruck Syntax, die Tcl sonst substituieren würde, erlauben geschweifte Klammern oder sonstige Anführung als statischer Wert dem Tcl-Compiler, Bytecode für den Ausdruck zu erzeugen — bessere Geschwindigkeit, geringerer Speicherbedarf. Das vermeidet auch Probleme, wenn Tcl die Substitution vor dem Aufruf von **expr** ausführt.

Im folgenden Beispiel ist der Ausdruckswert 11, weil der Tcl-Parser zuerst **$b** und **expr** dann **$a** beim Auswerten von „$a + 2\*4“ substituiert. Klammern um den Ausdruck führten zu einem Syntaxfehler, da **$b** keinen numerischen Wert liefert.

```
set a 3
set b {$a + 2}
expr $b*4
```

Wird ein Ausdruck zur Laufzeit erzeugt (wie oben), muss der Bytecode-Compiler bei jeder Auswertung neuen Code erzeugen — der aufwändigste Fall. Dann sind die in [mathfunc]\(n) oder [mathop]\(n) beschriebenen Befehle oft die bessere Wahl als **expr**.

Die meisten Ausdrücke entstehen nicht zur Laufzeit, sondern sind Literale oder enthalten Substitutionen ohne weitere Substitutionen. Damit der Bytecode-Compiler zur Kompilierzeit mit einem Zeichenkettenliteral arbeiten kann, darf der Ausdruck keine Substitutionen enthalten oder muss in Klammern stehen, damit **expr** statt Tcl substituiert.

Muss ein nicht-konstanter Ausdruck in einen sonst konstanten Ausdruck, ist ein rekursives **expr** für den variablen Teil am effizientesten: Der äußere Teil kann kompiliert werden, der variable Teil wird separat ausgewertet. Im Beispiel ist das Ergebnis 20; der äußere Ausdruck profitiert von vollständig gecachtem Bytecode.

```
set a 3
set b {$a + 2}
expr {[expr $b] * 4}
```

Setzen Sie Ausdrücke nach Möglichkeit in geschweifte Klammern; wo das nicht geht, sollte das **expr**-Argument möglichst einfach woanders definiert sein. Oft sind Befehle aus **tcl::mathop** effizienter und sicherer als komplexe Ausdrucksgenerierung.

# Beispiele

Numerischer Vergleich mit Ergebnis 1:

```
expr {"0x03" > "2"}
```

Zeichenkettenvergleich mit Ergebnis 1:

```
expr {"0y" > "0x12"}
```

[Erzwungener Zeichenkettenvergleich mit Ergebnis 0:]{version="TIP461"}

```
expr {"0x03" gt "2"}
```

Prozedur für eine „interessante“ mathematische Funktion:

```
proc ::tcl::mathfunc::calc {x y} {
    expr { ($x**2 - $y**2) / exp($x**2 + $y**2) }
}
```

Polarkoordinaten in kartesische umrechnen:

```
# Umrechnung von ($radius,$angle)
set x [expr { $radius * cos($angle) }]
set y [expr { $radius * sin($angle) }]
```

Kartesische in Polarkoordinaten umrechnen:

```
# Umrechnung von ($x,$y)
set radius [expr { hypot($y, $x) }]
set angle  [expr { atan2($y, $x) }]
```

Meldung über die Beziehung zweier Zeichenkettenwerte:

```
puts "a and b are [expr {$a eq $b ? {equal} : {different}}]"
```

Variable setzen, ob eine Umgebungsvariable existiert und den Wert „wahr“ hat:

```
set isTrue [expr {
    # Existiert die Umgebungsvariable, und...
    [info exists ::env(SOME_ENV_VAR)] &&
    # ...enthält sie einen gültigen Wahrheitswert?
    [string is true -strict $::env(SOME_ENV_VAR)]
}]
```

Zufällige Ganzzahl im Bereich 0..99 einschließlich:

```
set randNum [expr { int(100 * rand()) }]
```


[format]: format.md
[mathfunc]: mathfunc.md
[mathop]: mathop.md
[namespace]: namespace.md
[string]: string.md
[Tcl]: Tcl.md
