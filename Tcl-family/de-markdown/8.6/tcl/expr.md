---
CommandName: expr
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

# NAME

expr - Einen Ausdruck auswerten

# ÜBERSICHT

::: {.synopsis} :::
[expr]{.cmd} [arg]{.arg} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Fügt *arg*s zusammen (mit Leerzeichen dazwischen), wertet das Ergebnis als Tcl-Ausdruck aus und gibt den Wert zurück. In Tcl-Ausdrücken sind eine Teilmenge der in C erlaubten Operatoren zulässig. Für gemeinsame Operatoren gelten dieselbe Bedeutung und Priorität wie in C. Ausdrücke liefern fast immer numerische Ergebnisse (Ganzzahl oder Gleitkomma). Beispielsweise liefert

```
expr 8.2 + 6
```

den Wert 14.2. Tcl-Ausdrücke unterscheiden sich von C in der Operandenangabe und unterstützen nicht-numerische Operanden, Zeichenkettenvergleiche sowie zusätzliche Operatoren ohne C-Entsprechung.

## Operanden

Ein Tcl-Ausdruck besteht aus Operanden, Operatoren, Klammern und Kommas. Leerraum zwischen Operanden, Operatoren und Klammern (oder Kommas) ist erlaubt und wird ignoriert. Operanden werden nach Möglichkeit als Ganzzahlen interpretiert. Ganzzahlen können dezimal (Normalfall), binär (wenn die ersten zwei Zeichen **0b** sind), oktal (**0o**) oder hexadezimal (**0x**) angegeben werden. Zur Kompatibilität mit älteren Tcl-Versionen gilt ein oktaler Wert auch, wenn das erste Zeichen **0** ist, unabhängig davon, ob das zweite **o** ist. Hat ein Operand keines der Ganzzahlformate und ist Gleitkomma möglich, wird er als Gleitkommazahl behandelt. Gültige Formate nutzen Dezimalziffern, **.**, **e**/**E** für die wissenschaftliche Notation und **+**/**-**. Beispiele: 2.1, 3., 6e4, 7.91e+16. **Inf** und **NaN** in beliebiger Schreibweise gelten als Gleitkomma. Ist keine numerische Interpretation möglich (nicht-numerische oder nicht-boolesche Literale müssen in Klammern oder Anführungszeichen stehen), bleibt der Operand eine Zeichenkette (nur ein begrenzter Operatorsatz ist anwendbar).

Operanden können so angegeben werden:

1. Als numerischer Wert, Ganzzahl oder Gleitkomma.

2. Als boolescher Wert in jeder von **string is** **boolean** verstandenen Form.

3. Als Tcl-Variable mit **\$**-Notation; der Variablenwert ist der Operand.

4. Als Zeichenkette in doppelten Anführungszeichen. Der Parser führt Backslash-, Variablen- und Befehlssubstitution zwischen den Anführungszeichen aus und nutzt das Ergebnis als Operand.

5. Als Zeichenkette in geschweiften Klammern. Die Zeichen zwischen öffnender und schließender Klammer werden ohne Substitution als Operand verwendet.

6. Als Tcl-Befehl in eckigen Klammern. Der Befehl wird ausgeführt; sein Ergebnis ist der Operand.

7. Als mathematische Funktion mit Argumenten in einer der obigen Formen, z. B. **sin(\$x)**. Siehe **MATHEMATISCHE FUNKTIONEN** unten.


Wo obige Substitutionen vorkommen (z. B. in Anführungszeichen), führt sie der Ausdruck aus. Der Befehlsparser kann jedoch bereits eine Substitutionsrunde ausgeführt haben, bevor der Ausdruck verarbeitet wird. Wie unten beschrieben, empfiehlt es sich, Ausdrücke in geschweifte Klammern zu setzen.

Beispiele: **a** ist 3, **b** ist 6. Links steht der Befehl, rechts das Ergebnis:

```
expr {3.1 + $a}	6.1
expr {2 + "$a.$b"}	5.6
expr {4*[llength "6 2"]}	8
expr {{word one} < "word $a"}	0
```

## Operatoren

Die gültigen Operatoren (die meisten auch als Befehle im Namespace **tcl::mathop**; siehe **mathop**(n)) sind unten in abnehmender Priorität aufgeführt:

**-\0\0+\0\0~\0\0!**
: Unäres Minus, unäres Plus, bitweises NOT, logisches NOT. Keiner dieser Operatoren darf auf Zeichenketten angewendet werden; bitweises NOT nur auf Ganzzahlen.

**\*\***
: Potenzierung. Gültig für numerische Operanden. Maximaler Exponent bei Ganzzahl > 1 als erster Operand: 268435455.

**\***\\**0**\\**0/**\\**0**\\**0%**
: Multiplikation, Division, Rest. Keiner darf auf Zeichenketten angewendet werden; Rest nur auf Ganzzahlen. Der Rest hat dasselbe Vorzeichen wie der Divisor und einen absoluten Betrag kleiner als der Divisor.
    Bei Ganzzahlen kann man Division und Rest als Aufteilung der Zahlengeraden in gleich große, aneinandergrenzende Intervalle der Divisorgröße auffassen; der Quotient gibt das Intervall des Dividenden an, der Rest die Position darin. Folglich ist „-57 **/** 10“ immer -6 und „-57 **%** 10“ immer 3.

**+\0\0-**
: Addition und Subtraktion. Gültig für numerische Operanden.

**<<\0\0>>**
: Links- und Rechtsshift. Nur für Ganzzahlen. Rechtsshift überträgt das Vorzeichenbit.

**<\0\0>\0\0<=\0\0>=**
: Boolesch kleiner, größer, kleiner gleich, größer gleich. Ergebnis 1 bei wahrer Bedingung, sonst 0. Anwendbar auf Zeichenketten und Zahlen; bei Zeichenketten Zeichenkettenvergleich.

**==\0\0!=**
: Boolesches gleich und ungleich. Ergebnis 0/1. Gültig für alle Operandentypen.

**eq\0\0ne**
: Boolesches Zeichenketten-gleich und -ungleich. Ergebnis 0/1. Operanden nur als Zeichenketten.

**in\0\0ni**
: Listenelement und Negation. Ergebnis 0/1; erstes Argument Zeichenkette, zweites Tcl-Liste. **in** prüft Zugehörigkeit; **ni** kehrt das Ergebnis um.

**&**
: Bitweises AND. Nur Ganzzahlen.

**^**
: Bitweises exklusives OR. Nur Ganzzahlen.

**|**
: Bitweises OR. Nur Ganzzahlen.

**&&**
: Logisches AND. Ergebnis 1, wenn beide Operanden ungleich null, sonst 0. Nur für boolesche und numerische Operanden. Faule Auswertung des zweiten Operanden nur bei Bedarf.

**||**
: Logisches OR. Ergebnis 0, wenn beide Operanden null, sonst 1. Nur für boolesche und numerische Operanden. Faule Auswertung des zweiten Operanden nur bei Bedarf.

*x* **?** *y* **:** *z*
: Wenn-dann-sonst wie in C. Ist *x* ungleich null, Ergebnis von *y*, sonst von *z*. *x* muss boolesch oder numerisch sein. Faule Auswertung: nur *y* oder *z*.


Einzelheiten zu den Operatoren siehe die C-Dokumentation. Potenzierung fördert Typen wie Multiplikation/Division; das Ergebnis entspricht **pow** (nach Typumwandlung). Alle binären Operatoren außer Potenzierung gruppierten links-rechts auf gleicher Priorität; Potenzierung rechts-links. Beispiel:

```
expr {4*2 < 7}
```

liefert 0, während

```
expr {2**3**2}
```

512 liefert.

**&&**, **||** und **?:** werten faul aus wie in C. In

```
expr {$v?[a]:[b]}
```

wird nur „**[a]**“ oder „**[b]**“ ausgewertet, je nach **\$v** — aber nur, wenn der gesamte Ausdruck in Klammern steht; sonst wertet der Tcl-Parser beide aus, bevor **expr** läuft.

## Mathematische Funktionen

Trifft der Parser auf eine Funktion wie **sin(\$x)**, ersetzt er sie durch einen Tcl-Befehl im Namespace **tcl::mathfunc**. Die Verarbeitung von

```
expr {sin($x+$y)}
```

entspricht der von

```
expr {[tcl::mathfunc::sin [expr {$x+$y}]]}
```

was wiederum der von

```
tcl::mathfunc::sin [expr {$x+$y}]
```

entspricht.

Der Ausführer sucht **tcl::mathfunc::sin** nach den üblichen Namespace-Regeln. **::tcl::mathfunc::sin** oder **[namespace current]::tcl::mathfunc::sin** erfüllen die Anforderung; weitere sind je nach **namespace path** möglich.

Manche Funktionen haben mehrere durch Kommas getrennte Argumente wie in C:

```
expr {hypot($x,$y)}
```

wird zu

```
tcl::mathfunc::hypot $x $y
```

Standard-Mathefunktionen siehe **mathfunc**(n).

## Typen, Überlauf und Genauigkeit

Alle internen Ganzzahl-Berechnungen nutzen bei Bedarf die LibTomMath-Bibliothek für mehrstellige Ganzzahlen, sodass Ganzzahlrechnungen exakt sind. In Tcl vor 8.5 wurden Ganzzahlen mit *long int* oder *Tcl_WideInt* gerechnet; Überlauf führte zu stiller Kürzung. Code, der darauf angewiesen war, muss an den betreffenden Stellen explizit **int()** oder **wide()** verwenden.

Gleitkomma intern mit C-Typ *double*. Exponentenüberlauf beim Umwandeln einer Zeichenkette liefert **Inf** bzw. **-Inf**. Über- und Unterlauf werden hardwareabhängig erkannt, in der Regel zuverlässig.

Umwandlung zwischen Ganzzahl, Gleitkomma und Zeichenkette erfolgt automatisch. Bei Arithmetik werden Ganzzahlen verwendet, bis Gleitkomma eingeführt wird. Beispiel:

```
expr {5 / 4}
```

liefert 1, während

```
expr {5 / 4.0}
expr {5 / ( [string length "abcd"] + 0.0 )}
```

beide 1.25 liefern. Gleitkomma-Ergebnisse enthalten immer „**.**“ oder „**e**“, damit sie nicht wie Ganzzahlen aussehen. Beispiel:

```
expr {20.0/5.0}
```

liefert **4.0**, nicht **4**.

## Zeichenkettenoperationen

Zeichenketten können Vergleichsoperatoren nutzen; der Auswerter vergleicht nach Möglichkeit als Ganzzahl oder Gleitkomma, wenn alle Operanden numerisch interpretierbar sind — außer bei **eq** und **ne**. Ist ein Operand eine Zeichenkette und der andere numerisch, wird für den numerischen Operanden eine kanonische Zeichenkettenform erzeugt. Ganzzahlen: Dezimalstring. Gleitkomma: Ausgabe von **%g** in **format**. Beispiele:

```
expr {"0x03" > "2"}
expr {"0y" > "0x12"}
```

liefern beide 1. Der erste Vergleich ist ganzzahlig, der zweite Zeichenkettenvergleich. Da Tcl Werte möglichst als Zahlen behandelt, sollte man bei beliebigen Operanden und gewünschtem Zeichenkettenvergleich **eq**, **ne** oder **string** statt **==** verwenden.

# LEISTUNGSHINWEISE

Setzen Sie Ausdrücke in geschweifte Klammern für beste Geschwindigkeit und geringsten Speicherbedarf; so kann der Tcl-Bytecode-Compiler optimalen Code erzeugen.

Wie oben werden Ausdrücke zweimal substituiert: einmal vom Tcl-Parser, einmal von **expr**. Beispiel:

```
set a 3
set b {$a + 2}
expr $b*4
```

liefert 11, kein Vielfaches von 4: Der Parser ersetzt zuerst „**\$a + 2**“ für **b**, dann wertet **expr** „**\$a + 2*4**“ aus.

Die meisten Ausdrücke brauchen keine zweite Substitutionsrunde — sie stehen in Klammern oder liefern Zahlen/Zeichenketten ohne weitere Substitution. Weil einige ungeklammerte Ausdrücke zwei Runden brauchen, muss der Compiler zusätzlichen Code erzeugen; am teuersten sind ungeklammerte Ausdrücke mit Befehlssubstitution (neuer Code bei jeder Auswertung).

Muss ein nicht-konstanter Teil in einen sonst konstanten Ausdruck, ist ein rekursives **expr** für den variablen Teil am effizientesten: Der äußere Teil kann kompiliert werden, der variable Teil wird separat ausgewertet. Im Beispiel ist das Ergebnis 20; der äußere Ausdruck profitiert von gecachtem Bytecode.

```
set a 3
set b {$a + 2}
expr {[expr $b] * 4}
```

Ist der Ausdruck ungeklammert, um Funktion oder Operator zu substituieren, erwägen Sie die Befehle in **mathfunc**(n) oder **mathop**(n) direkt.

# BEISPIELE

Prozedur für eine „interessante“ mathematische Funktion:

```
proc tcl::mathfunc::calc {x y} {
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
puts "a und b sind [expr {$a eq $b ? {equal} : {different}}]"
```

Variable setzen, ob eine Umgebungsvariable existiert und einen booleschen Wahrheitswert hat:

```
set isTrue [expr {
    [info exists ::env(SOME_ENV_VAR)] &&
    [string is true -strict $::env(SOME_ENV_VAR)]
}]
```

Zufällige Ganzzahl im Bereich 0..99 einschließlich:

```
set randNum [expr { int(100 * rand()) }]
```

# Copyright

```
Copyright © 1993 The Regents of the University of California.
Copyright © 1994-2000 Sun Microsystems Incorporated.
Copyright © 2005 Kevin B. Kenny <kennykb@acm.org>. All rights reserved.
```
