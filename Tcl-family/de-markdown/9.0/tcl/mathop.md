---
CommandName: mathop
title: mathop
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

# Name

mathop - Mathematische Operatoren als Tcl-Befehle

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5-]{.lit}

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
[::tcl::mathop::lt]{.cmd version="TIP461"} [arg]{.optdot}
[::tcl::mathop::le]{.cmd version="TIP461"} [arg]{.optdot}
[::tcl::mathop::gt]{.cmd version="TIP461"} [arg]{.optdot}
[::tcl::mathop::ge]{.cmd version="TIP461"} [arg]{.optdot}
[::tcl::mathop::in]{.cmd} [arg]{.arg} [list]{.arg}
[::tcl::mathop::ni]{.cmd} [arg]{.arg} [list]{.arg}
:::

# Beschreibung

Die Befehle im Namespace **::tcl::mathop** implementieren dieselbe Menge von Operationen, die der Befehl [expr] unterstützt. Alle werden aus dem Namespace exportiert, aber standardmäßig in keinen anderen Namespace importiert. Beachten Sie, dass Umbenennen, Neuimplementieren oder Löschen von Befehlen im Namespace *nicht* das Verhalten des Befehls [expr] ändert, ebenso wenig wie das Definieren neuer Befehle im Namespace **::tcl::mathop**.

Folgende Operator-Befehle werden unterstützt:

::: {.info DISPLAY="yes"}
**~**	**!**	**+**	**-**	**\***\
**/**	**%**	**\*\***	**&**	**|**\
**^**	**>>**	**<<**	**==**	**eq**\
**!=**	**ne**	**<**	**<=**	**>**\
**>=**	**in**	**ni**	**lt**	**le**\
**gt**	**ge**
:::

## Mathematische Operatoren

Das Verhalten der mathematischen Operator-Befehle ist wie folgt:

[!]{.cmd} [boolean]{.arg}
: Gibt die boolesche Negation von *boolean* zurück, wobei *boolean* ein beliebiger numerischer Wert oder eine andere Form eines booleschen Werts sein kann (*d. h.* es gibt Wahrheit zurück, wenn das Argument Falschheit oder Null ist, und Falschheit, wenn das Argument Wahrheit oder ungleich Null ist).

[+]{.cmd} [number]{.optdot}
: Gibt die Summe beliebig vieler Argumente zurück. Jedes *number*-Argument kann ein beliebiger numerischer Wert sein. Sind keine Argumente angegeben, ist das Ergebnis Null (das neutrale Element der Addition).

[-]{.cmd} [number]{.arg} [number]{.optdot}
: Ist nur ein einzelnes *number*-Argument angegeben, gibt der Befehl die Negation dieses numerischen Werts zurück. Andernfalls gibt er die Zahl zurück, die entsteht, wenn alle folgenden numerischen Werte vom ersten subtrahiert werden. Alle *number*-Argumente müssen numerische Werte sein. Mindestens ein Argument muss angegeben sein.

[\*]{.cmd} [number]{.optdot}
: Gibt das Produkt beliebig vieler Argumente zurück. Jedes *number* kann ein beliebiger numerischer Wert sein. Sind keine Argumente angegeben, ist das Ergebnis eins (das neutrale Element der Multiplikation).

[/]{.cmd} [number]{.arg} [number]{.optdot}
: Ist nur ein einzelnes *number*-Argument angegeben, gibt der Befehl den Kehrwert dieses numerischen Werts zurück (*d. h.* den Wert, der durch Division von 1.0 durch diesen Wert entsteht). Andernfalls gibt er die Zahl zurück, die entsteht, wenn das erste numerische Argument durch alle folgenden numerischen Argumente dividiert wird. Alle *number*-Argumente müssen numerische Werte sein. Mindestens ein Argument muss angegeben sein.

    Beachten Sie, dass bei führenden Integer-Werten in der Argumentliste für diese anfänglichen Schritte Integer-Division verwendet wird (*d. h.* die Zwischenergebnisse sind so, als würden die Funktionen *floor* und *int* in dieser Reihenfolge angewendet). Sind alle Werte der Operation Integer, ist das Ergebnis ein Integer.

[%]{.cmd} [number]{.arg} [number]{.arg}
: Gibt den integralen Modulus (*d. h.* Rest) des ersten Arguments bezüglich des zweiten zurück. Jedes *number* muss einen integralen Wert haben. Außerdem hat das Ergebnis dasselbe Vorzeichen wie das zweite *number*, das nicht Null sein darf.

    Beachten Sie, dass Tcl diese Operation auch für negative Zahlen exakt definiert, sodass folgender Befehl einen wahren Wert zurückgibt (der Namespace wird zur Klarheit weggelassen):

    ```
    == [* [/ x y] y] [- x [% x y]]
    ```

[\*\*]{.cmd} [number]{.optdot}
: Gibt das Ergebnis zurück, bei dem jeder Wert potenziert wird mit dem Ergebnis nach rekursiver Verarbeitung der folgenden Argumente, sodass "**\*\* 2 3 4**" dasselbe ist wie "**\*\* 2 \[\*\* 3 4\]**". Jedes *number* kann ein beliebiger numerischer Wert sein, wobei die zweite Zahl nicht bruchteilig sein darf, wenn die erste negativ ist. Der maximale Exponentenwert, den Tcl verarbeiten kann, wenn die erste Zahl ein Integer > 1 ist, beträgt 268435455. Sind keine Argumente angegeben, ist das Ergebnis eins; ist nur ein Argument angegeben, ist das Ergebnis dieses Argument. Das Ergebnis hat nur dann einen integralen Wert, wenn alle Argumente integrale Werte sind.


## Vergleichsoperatoren

Das Verhalten der Vergleichsoperator-Befehle (die überwiegend numerische Argumente bevorzugen) ist wie folgt:

[==]{.cmd} [arg]{.optdot}
: Gibt zurück, ob jedes Argument den Argumenten auf beiden Seiten im Sinne des [expr]-Operators == gleich ist (*d. h.* numerischer Vergleich wenn möglich, sonst exakter Zeichenkettenvergleich). Sind weniger als zwei Argumente angegeben, gibt diese Operation stets einen wahren Wert zurück.

[eq]{.cmd} [arg]{.optdot}
: Gibt zurück, ob jedes Argument den Argumenten auf beiden Seiten per exaktem Zeichenkettenvergleich gleich ist. Sind weniger als zwei Argumente angegeben, gibt diese Operation stets einen wahren Wert zurück.

[!=]{.cmd} [arg]{.arg} [arg]{.arg}
: Gibt zurück, ob die beiden Argumente einander im Sinne des [expr]-Operators != ungleich sind (*d. h.* numerischer Vergleich wenn möglich, sonst exakter Zeichenkettenvergleich).

[ne]{.cmd} [arg]{.arg} [arg]{.arg}
: Gibt zurück, ob die beiden Argumente einander per exaktem Zeichenkettenvergleich ungleich sind.

[<]{.lit} [arg]{.optdot}
: Gibt zurück, ob die beliebig vielen Argumente geordnet sind, wobei jedes Argument nach dem ersten strikt größer als das vorhergehende sein muss. Vergleiche erfolgen vorzugsweise auf numerischen Werten, andernfalls per UNICODE-Zeichenkettenvergleich. Sind weniger als zwei Argumente vorhanden, gibt diese Operation stets einen wahren Wert zurück. Sollen numerische Argumente als Zeichenketten verglichen werden, sollte stattdessen der Operator **lt** oder der Befehl [string compare][string] verwendet werden.

[<=]{.lit} [arg]{.optdot}
: Gibt zurück, ob die beliebig vielen Argumente geordnet sind, wobei jedes Argument nach dem ersten gleich oder größer als das vorhergehende sein muss. Vergleiche erfolgen vorzugsweise auf numerischen Werten, andernfalls per UNICODE-Zeichenkettenvergleich. Sind weniger als zwei Argumente vorhanden, gibt diese Operation stets einen wahren Wert zurück. Sollen numerische Argumente als Zeichenketten verglichen werden, sollte stattdessen der Operator **le** oder der Befehl [string compare][string] verwendet werden.

[>]{.lit} [arg]{.optdot}
: Gibt zurück, ob die beliebig vielen Argumente geordnet sind, wobei jedes Argument nach dem ersten strikt kleiner als das vorhergehende sein muss. Vergleiche erfolgen vorzugsweise auf numerischen Werten, andernfalls per UNICODE-Zeichenkettenvergleich. Sind weniger als zwei Argumente vorhanden, gibt diese Operation stets einen wahren Wert zurück. Sollen numerische Argumente als Zeichenketten verglichen werden, sollte stattdessen der Operator **gt** oder der Befehl [string compare][string] verwendet werden.

[>=]{.lit} [arg]{.optdot}
: Gibt zurück, ob die beliebig vielen Argumente geordnet sind, wobei jedes Argument nach dem ersten gleich oder kleiner als das vorhergehende sein muss. Vergleiche erfolgen vorzugsweise auf numerischen Werten, andernfalls per UNICODE-Zeichenkettenvergleich. Sind weniger als zwei Argumente vorhanden, gibt diese Operation stets einen wahren Wert zurück. Sollen numerische Argumente als Zeichenketten verglichen werden, sollte stattdessen der Operator **ge** oder der Befehl [string compare][string] verwendet werden.

[lt]{.cmd} [arg]{.optdot}
: [Gibt zurück, ob die beliebig vielen Argumente geordnet sind, wobei jedes Argument nach dem ersten strikt größer als das vorhergehende sein muss. Vergleiche erfolgen per UNICODE-Zeichenkettenvergleich. Sind weniger als zwei Argumente vorhanden, gibt diese Operation stets einen wahren Wert zurück.]{version="TIP461"}

[le]{.cmd} [arg]{.optdot}
: [Gibt zurück, ob die beliebig vielen Argumente geordnet sind, wobei jedes Argument nach dem ersten gleich oder strikt größer als das vorhergehende sein muss. Vergleiche erfolgen per UNICODE-Zeichenkettenvergleich. Sind weniger als zwei Argumente vorhanden, gibt diese Operation stets einen wahren Wert zurück.]{version="TIP461"}

[gt]{.cmd} [arg]{.optdot}
: [Gibt zurück, ob die beliebig vielen Argumente geordnet sind, wobei jedes Argument nach dem ersten strikt kleiner als das vorhergehende sein muss. Vergleiche erfolgen per UNICODE-Zeichenkettenvergleich. Sind weniger als zwei Argumente vorhanden, gibt diese Operation stets einen wahren Wert zurück.]{version="TIP461"}

[ge]{.cmd} [arg]{.optdot}
: [Gibt zurück, ob die beliebig vielen Argumente geordnet sind, wobei jedes Argument nach dem ersten gleich oder strikt kleiner als das vorhergehende sein muss. Vergleiche erfolgen per UNICODE-Zeichenkettenvergleich. Sind weniger als zwei Argumente vorhanden, gibt diese Operation stets einen wahren Wert zurück.]{version="TIP461"}


## Bitweise Operatoren

Das Verhalten der bitweisen Operator-Befehle (die alle nur mit integralen Argumenten arbeiten) ist wie folgt:

[~]{.cmd} [number]{.arg}
: Gibt die bitweise Negation von *number* zurück. *Number* kann ein Integer beliebiger Größe sein. Beachten Sie, dass das Ergebnis dieser Operation stets das entgegengesetzte Vorzeichen zum Eingabe-*number* hat.

[&]{.cmd} [number]{.optdot}
: Gibt das bitweise UND aller beliebig vielen Argumente zurück. Jedes *number* muss einen integralen Wert haben. Sind keine Argumente angegeben, ist das Ergebnis minus eins.

[|]{.lit} [number]{.optdot}
: Gibt das bitweise ODER aller beliebig vielen Argumente zurück. Jedes *number* muss einen integralen Wert haben. Sind keine Argumente angegeben, ist das Ergebnis Null.

[^]{.cmd} [number]{.optdot}
: Gibt das bitweise XOR aller beliebig vielen Argumente zurück. Jedes *number* muss einen integralen Wert haben. Sind keine Argumente angegeben, ist das Ergebnis Null.

[<<]{.lit} [number]{.arg} [number]{.arg}
: Gibt das Ergebnis zurück, bei dem das erste Argument um die im zweiten Argument angegebene Anzahl Bits nach links verschoben wird. Jedes *number* muss einen integralen Wert haben.

[>>]{.lit} [number]{.arg} [number]{.arg}
: Gibt das Ergebnis zurück, bei dem das erste Argument um die im zweiten Argument angegebene Anzahl Bits nach rechts verschoben wird. Jedes *number* muss einen integralen Wert haben.


## Listenoperatoren

Das Verhalten der listenorientierten Operator-Befehle ist wie folgt:

[in]{.cmd} [arg]{.arg} [list]{.arg}
: Gibt zurück, ob der Wert *arg* in der Liste *list* enthalten ist (gemäß exaktem Zeichenkettenvergleich der Elemente).

[ni]{.cmd} [arg]{.arg} [list]{.arg}
: Gibt zurück, ob der Wert *arg* nicht in der Liste *list* enthalten ist (gemäß exaktem Zeichenkettenvergleich der Elemente).


# Beispiele

Der einfachste Weg, die Operatoren zu nutzen, ist oft [namespace path][namespace], um die Befehle verfügbar zu machen. Das hat den Vorteil, dass die im aktuellen Namespace definierten Befehle nicht verändert werden.

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

# Prüfen, ob eine Liste numerisch sortiert ist
set sorted [<= {*}$list]

# Prüfen, ob eine Liste lexikalisch sortiert ist
set alphaList {a b c d e f}
set sorted [le {*}$alphaList]
```


[expr]: expr.md
[namespace]: namespace.md
[string]: string.md
