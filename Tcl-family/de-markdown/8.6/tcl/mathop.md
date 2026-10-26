---
CommandName: mathop
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Mathematical Operator Commands
Links:
 - expr(n)
 - mathfunc(n)
 - namespace(n)
Keywords:
 - command
 - expression
 - operator
Copyright:
 - Copyright (c) 2006-2007 Donal K. Fellows.
---

# NAME

mathop - Mathematische Operatoren als Tcl-Befehle

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} 
[::tcl::mathop::!]{.cmd} [number]{.arg} 
[::tcl::mathop::~]{.cmd} [number]{.arg} 
[::tcl::mathop::+]{.cmd} [number]{.optdot} 
[::tcl::mathop::-]{.cmd} [number]{.arg} [number]{.optdot} 
[::tcl::mathop::\*]{.cmd} [number]{.optdot} 
[::tcl::mathop::/]{.cmd} [number]{.arg} [number]{.optdot} 
[::tcl::mathop::%]{.cmd} [number]{.arg} [number]{.arg} 
[::tcl::mathop::\*\*]{.cmd} [number]{.optdot} 
[::tcl::mathop::&]{.cmd} [number]{.optdot} 
[::tcl::mathop::|]{.cmd} [number]{.optdot} 
[::tcl::mathop::^]{.cmd} [number]{.optdot} 
[::tcl::mathop::<<]{.cmd} [number]{.arg} [number]{.arg} 
[::tcl::mathop::>>]{.cmd} [number]{.arg} [number]{.arg} 
[::tcl::mathop::==]{.cmd} [arg]{.optdot} 
[::tcl::mathop::!=]{.cmd} [arg]{.arg} [arg]{.arg} 
[::tcl::mathop::<]{.cmd} [arg]{.optdot} 
[::tcl::mathop::<=]{.cmd} [arg]{.optdot} 
[::tcl::mathop::>=]{.cmd} [arg]{.optdot} 
[::tcl::mathop::>]{.cmd} [arg]{.optdot} 
[::tcl::mathop::eq]{.cmd} [arg]{.optdot} 
[::tcl::mathop::ne]{.cmd} [arg]{.arg} [arg]{.arg} 
[::tcl::mathop::in]{.cmd} [arg]{.arg} [list]{.arg} 
[::tcl::mathop::ni]{.cmd} [arg]{.arg} [list]{.arg} 
:::


# BESCHREIBUNG

Die Befehle im Namespace **::tcl::mathop** implementieren dieselbe Menge
von Operationen, die der Befehl **expr** unterstützt. Alle werden aus dem
Namespace exportiert, aber standardmäßig in keinen anderen Namespace
importiert. Beachten Sie, dass Umbenennen, Neuimplementieren oder Löschen
von Befehlen im Namespace *nicht* das Verhalten des Befehls **expr**
ändert, ebenso wenig wie das Definieren neuer Befehle im Namespace
**::tcl::mathop**.

Folgende Operator-Befehle werden unterstützt:

```
~ ! + - *
/ % ** & |
^ >> << == eq
!= ne < <= >
>= in ni
```

## MATHEMATISCHE OPERATOREN

Das Verhalten der mathematischen Operator-Befehle ist wie folgt:

**!** *boolean*
: Gibt die boolesche Negation von *boolean* zurück, wobei *boolean* ein
    beliebiger numerischer Wert oder eine andere Form eines booleschen
    Werts sein kann (*d. h.* es gibt Wahrheit zurück, wenn das Argument
    Falschheit oder Null ist, und Falschheit, wenn das Argument Wahrheit
    oder ungleich Null ist).

**+** ?*number* \...?
: Gibt die Summe beliebig vieler Argumente zurück. Jedes *number*-
    Argument kann ein beliebiger numerischer Wert sein. Sind keine
    Argumente angegeben, ist das Ergebnis Null (das neutrale Element der
    Addition).

**-** *number* ?*number* \...?
: Ist nur ein einzelnes *number*-Argument angegeben, gibt der Befehl
    die Negation dieses numerischen Werts zurück. Andernfalls gibt er die
    Zahl zurück, die entsteht, wenn alle folgenden numerischen Werte vom
    ersten subtrahiert werden. Alle *number*-Argumente müssen numerische
    Werte sein. Mindestens ein Argument muss angegeben sein.

**\*** ?*number* ...?
: Gibt das Produkt beliebig vieler Argumente zurück. Jedes *number* kann
    ein beliebiger numerischer Wert sein. Sind keine Argumente angegeben,
    ist das Ergebnis eins (das neutrale Element der Multiplikation).

**/** *number* ?*number* \...?
: Ist nur ein einzelnes *number*-Argument angegeben, gibt der Befehl den
    Kehrwert dieses numerischen Werts zurück (*d. h.* den Wert, der durch
    Division von 1.0 durch diesen Wert entsteht). Andernfalls gibt er die
    Zahl zurück, die entsteht, wenn das erste numerische Argument durch
    alle folgenden numerischen Argumente dividiert wird. Alle
    *number*-Argumente müssen numerische Werte sein. Mindestens ein
    Argument muss angegeben sein.

    Beachten Sie, dass bei führenden Integer-Werten in der Argumentliste
    für diese anfänglichen Schritte Integer-Division verwendet wird (*d. h.*
    die Zwischenergebnisse sind so, als würden die Funktionen *floor* und
    *int* in dieser Reihenfolge angewendet). Sind alle Werte der Operation
    Integer, ist das Ergebnis ein Integer.

**%** *number number*
: Gibt den integralen Modulus (*d. h.* Rest) des ersten Arguments
    bezüglich des zweiten zurück. Jedes *number* muss einen integralen
    Wert haben. Außerdem hat das Ergebnis dasselbe Vorzeichen wie das
    zweite *number*, das nicht Null sein darf.

    Beachten Sie, dass Tcl diese Operation auch für negative Zahlen exakt
    definiert, sodass folgender Befehl einen wahren Wert zurückgibt (der
    Namespace wird zur Klarheit weggelassen):

```
== [* [/ x y] y] [- x [% x y]]
```

**\*\*** ?*number* ...?
: Gibt das Ergebnis zurück, bei dem jeder Wert potenziert wird mit dem
    Ergebnis nach rekursiver Verarbeitung der folgenden Argumente, sodass "**\*\* 2 3 4**" dasselbe ist wie "**\*\* 2 \[\*\* 3 4\]**".

Jedes *number* kann ein beliebiger numerischer Wert sein, wobei die
zweite Zahl nicht bruchteilig sein darf, wenn die erste negativ ist. Der
maximale Exponentenwert, den Tcl verarbeiten kann, wenn die erste Zahl
ein Integer \> 1 ist, beträgt 268435455. Sind keine Argumente angegeben,
ist das Ergebnis eins; ist nur ein Argument angegeben, ist das Ergebnis
dieses Argument. Das Ergebnis hat nur dann einen integralen Wert, wenn
alle Argumente integrale Werte sind.

## VERGLEICHSOPERATOREN

Das Verhalten der Vergleichsoperator-Befehle (die überwiegend numerische
Argumente bevorzugen) ist wie folgt:

**==** ?*arg* \...?
: Gibt zurück, ob jedes Argument den Argumenten auf beiden Seiten im
    Sinne des **expr**-Operators == gleich ist (*d. h.* numerischer
    Vergleich wenn möglich, sonst exakter Zeichenkettenvergleich). Sind
    weniger als zwei Argumente angegeben, gibt diese Operation stets einen
    wahren Wert zurück.

**eq** ?*arg* \...?
: Gibt zurück, ob jedes Argument den Argumenten auf beiden Seiten per
    exaktem Zeichenkettenvergleich gleich ist. Sind weniger als zwei
    Argumente angegeben, gibt diese Operation stets einen wahren Wert
    zurück.

**!=** *arg arg*
: Gibt zurück, ob die beiden Argumente einander im Sinne des
    **expr**-Operators != ungleich sind (*d. h.* numerischer Vergleich
    wenn möglich, sonst exakter Zeichenkettenvergleich).

**ne** *arg arg*
: Gibt zurück, ob die beiden Argumente einander per exaktem
    Zeichenkettenvergleich ungleich sind.

**\<** ?*arg* \...?
: Gibt zurück, ob die beliebig vielen Argumente geordnet sind, wobei
    jedes Argument nach dem ersten strikt größer als das vorhergehende
    sein muss. Vergleiche erfolgen vorzugsweise auf numerischen Werten,
    andernfalls per UNICODE-Zeichenkettenvergleich. Sind weniger als zwei
    Argumente vorhanden, gibt diese Operation stets einen wahren Wert
    zurück. Sollen numerische Argumente als Zeichenketten verglichen
    werden, sollte stattdessen der Befehl **string compare** verwendet
    werden.

**\<=** ?*arg* \...?
: Gibt zurück, ob die beliebig vielen Argumente geordnet sind, wobei
    jedes Argument nach dem ersten gleich oder größer als das
    vorhergehende sein muss. Vergleiche erfolgen vorzugsweise auf
    numerischen Werten, andernfalls per UNICODE-Zeichenkettenvergleich.
    Sind weniger als zwei Argumente vorhanden, gibt diese Operation stets
    einen wahren Wert zurück. Sollen numerische Argumente als Zeichenketten
    verglichen werden, sollte stattdessen der Befehl **string compare**
    verwendet werden.

**\>** ?*arg* \...?
: Gibt zurück, ob die beliebig vielen Argumente geordnet sind, wobei
    jedes Argument nach dem ersten strikt kleiner als das vorhergehende
    sein muss. Vergleiche erfolgen vorzugsweise auf numerischen Werten,
    andernfalls per UNICODE-Zeichenkettenvergleich. Sind weniger als zwei
    Argumente vorhanden, gibt diese Operation stets einen wahren Wert
    zurück. Sollen numerische Argumente als Zeichenketten verglichen
    werden, sollte stattdessen der Befehl **string compare** verwendet
    werden.

**\>=** ?*arg* \...?
: Gibt zurück, ob die beliebig vielen Argumente geordnet sind, wobei
    jedes Argument nach dem ersten gleich oder kleiner als das
    vorhergehende sein muss. Vergleiche erfolgen vorzugsweise auf
    numerischen Werten, andernfalls per UNICODE-Zeichenkettenvergleich.
    Sind weniger als zwei Argumente vorhanden, gibt diese Operation stets
    einen wahren Wert zurück. Sollen numerische Argumente als Zeichenketten
    verglichen werden, sollte stattdessen der Befehl **string compare**
    verwendet werden.

## BITWEISE OPERATOREN

Das Verhalten der bitweisen Operator-Befehle (die alle nur mit integralen
Argumenten arbeiten) ist wie folgt:

**\~** *number*
: Gibt die bitweise Negation von *number* zurück. *Number* kann ein
    Integer beliebiger Größe sein. Beachten Sie, dass das Ergebnis dieser
    Operation stets das entgegengesetzte Vorzeichen zum Eingabe-*number*
    hat.

**&** ?*number* \...?
: Gibt das bitweise UND aller beliebig vielen Argumente zurück. Jedes
    *number* muss einen integralen Wert haben. Sind keine Argumente
    angegeben, ist das Ergebnis minus eins.

**\|** ?*number* \...?
: Gibt das bitweise ODER aller beliebig vielen Argumente zurück. Jedes
    *number* muss einen integralen Wert haben. Sind keine Argumente
    angegeben, ist das Ergebnis Null.

**\^** ?*number* \...?
: Gibt das bitweise XOR aller beliebig vielen Argumente zurück. Jedes
    *number* muss einen integralen Wert haben. Sind keine Argumente
    angegeben, ist das Ergebnis Null.

**\<\<** *number number*
: Gibt das Ergebnis zurück, bei dem das erste Argument um die im zweiten
    Argument angegebene Anzahl Bits nach links verschoben wird. Jedes
    *number* muss einen integralen Wert haben.

**\>\>** *number number*
: Gibt das Ergebnis zurück, bei dem das erste Argument um die im zweiten
    Argument angegebene Anzahl Bits nach rechts verschoben wird. Jedes
    *number* muss einen integralen Wert haben.

## LISTENOPERATOREN

Das Verhalten der listenorientierten Operator-Befehle ist wie folgt:

**in** *arg list*
: Gibt zurück, ob der Wert *arg* in der Liste *list* enthalten ist
    (gemäß exaktem Zeichenkettenvergleich der Elemente).

**ni** *arg list*
: Gibt zurück, ob der Wert *arg* nicht in der Liste *list* enthalten ist
    (gemäß exaktem Zeichenkettenvergleich der Elemente).

# BEISPIELE

Der einfachste Weg, die Operatoren zu nutzen, ist oft **namespace path**,
um die Befehle verfügbar zu machen. Das hat den Vorteil, dass die im
aktuellen Namespace definierten Befehle nicht verändert werden.

```
namespace path {::tcl::mathop ::tcl::mathfunc}

# Summe einiger Zahlen berechnen
set sum [+ 1 2 3]

# Mittelwert einer Liste berechnen
set list {1 2 3 4 5 6}
set mean [/ [+ {*}$list] [double [llength $list]]]

# Listenmitgliedschaft prüfen
set gotIt [in 3 $list]

# Prüfen, ob ein Wert in einem definierten Bereich liegt
set inRange [<= 1 $x 5]

# Prüfen, ob eine Liste sortiert ist
set sorted [<= {*}$list]
```
