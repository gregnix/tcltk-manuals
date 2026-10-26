---
CommandName: math::bigfloat
ManualSection: n
Version: 2.0.6
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - computations
 - floating-point
 - interval
 - math
 - multiprecision
 - tcl
Copyright:
 - Copyright (c) 2004-2008, by Stephane Arnold <stephanearnold at yahoo dot fr>
---

# NAME

math::bigfloat – Gleitkommazahlen mit beliebiger Genauigkeit

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math::bigfloat]{.lit} [2.0.6]{.optlit} 
[fromstr]{.cmd} [number]{.arg} [trailingZeros]{.optarg} 
[tostr]{.cmd} [-nosci]{.optlit} [number]{.arg} 
[fromdouble]{.cmd} [double]{.arg} [decimals]{.optarg} 
[todouble]{.cmd} [number]{.arg} 
[isInt]{.cmd} [number]{.arg} 
[isFloat]{.cmd} [number]{.arg} 
[int2float]{.cmd} [integer]{.arg} [decimals]{.optarg} 
[add]{.cmd} [x]{.arg} [y]{.arg} 
[sub]{.cmd} [x]{.arg} [y]{.arg} 
[mul]{.cmd} [x]{.arg} [y]{.arg} 
[div]{.cmd} [x]{.arg} [y]{.arg} 
[mod]{.cmd} [x]{.arg} [y]{.arg} 
[abs]{.cmd} [x]{.arg} 
[opp]{.cmd} [x]{.arg} 
[pow]{.cmd} [x]{.arg} [n]{.arg} 
[iszero]{.cmd} [x]{.arg} 
[equal]{.cmd} [x]{.arg} [y]{.arg} 
[compare]{.cmd} [x]{.arg} [y]{.arg} 
[sqrt]{.cmd} [x]{.arg} 
[log]{.cmd} [x]{.arg} 
[exp]{.cmd} [x]{.arg} 
[cos]{.cmd} [x]{.arg} 
[sin]{.cmd} [x]{.arg} 
[tan]{.cmd} [x]{.arg} 
[cotan]{.cmd} [x]{.arg} 
[acos]{.cmd} [x]{.arg} 
[asin]{.cmd} [x]{.arg} 
[atan]{.cmd} [x]{.arg} 
[cosh]{.cmd} [x]{.arg} 
[sinh]{.cmd} [x]{.arg} 
[tanh]{.cmd} [x]{.arg} 
[pi]{.cmd} [n]{.arg} 
[rad2deg]{.cmd} [radians]{.arg} 
[deg2rad]{.cmd} [degrees]{.arg} 
[round]{.cmd} [x]{.arg} 
[ceil]{.cmd} [x]{.arg} 
[floor]{.cmd} [x]{.arg} 
:::

# BESCHREIBUNG

Das Paket „bigfloat“ erweitert die Sprache Tcl um Funktionen für Gleitkommaarithmetik mit beliebiger Genauigkeit. Es ist für die Verwendung mit Tcl 8.5 konzipiert; für Tcl 8.4 wird jedoch eine frühere Version dieses Pakets bereitgestellt. Weitere Erläuterungen finden Sie im Abschnitt **WIE SIEHT ES MIT TCL 8.4 AUS?**. Vereinbarungsgemäß bezeichnen wir die in dieser Bibliothek verarbeiteten Zahlen als:

**•**
: BigFloat für Gleitkommazahlen beliebiger Länge.

**•**
: Ganzzahlen beliebiger Länge mit Vorzeichen, genau wie einfache Ganzzahlen seit Tcl 8.5. Jeder BigFloat ist ein Intervall, nämlich \[*m-d, m+d*\], wobei *m* die Mantisse und *d* die Unsicherheit ist, die die Begrenzung der Genauigkeit dieser Zahl darstellt. Aus diesem Grund bezeichnen wir solche mathematischen Verfahren als *Intervallberechnungen*. Nehmen wir ein Beispiel aus der Physik: Wenn Sie eine Temperatur messen, sind nicht alle abgelesenen Ziffern *signifikant*. Manchmal können Sie einfach nicht allen Ziffern vertrauen – ganz zu schweigen davon, ob Double-Werte (Gleitkommazahlen) all diese Ziffern verarbeiten können. BigFloat löst dieses Problem – Sie können den erhaltenen Ziffern vertrauen – und bietet zudem die Möglichkeit, Zahlen mit beliebiger Genauigkeit zu speichern. BigFloats werden intern als Tcl-Listen dargestellt: Dieses Paket stellt eine Reihe von Prozeduren bereit, die auf diese interne Darstellung zugreifen, um:

**•**
: mathematische Operationen mit BigFloats und (optional) mit Ganzzahlen durchzuführen,

**•**
: BigFloats von ihrer internen Darstellung in Zeichenketten umzuwandeln und umgekehrt.


# EINLEITUNG

**fromstr** *number* ?*trailingZeros*?
: Wandelt *number* in einen BigFloat um. Die Genauigkeit entspricht mindestens der Anzahl der in *number* angegebenen Ziffern. Wenn *number* ausschließlich Ziffern enthält und gegebenenfalls ein Minuszeichen vorhanden ist, wird es als Ganzzahl betrachtet. In diesem Fall erfolgt keinerlei Umwandlung. *trailingZeros* – die Anzahl der Nullen, die am Ende der Gleitkommazahl angehängt werden sollen, um eine höhere Genauigkeit zu erzielen. Bei einer Ganzzahl ist dies nicht möglich.


```
# x and y are BigFloats : the first string contained a dot, and the second an e sign
set x [fromstr -1.000000]
set y [fromstr 2000e30]
# let's see how we get integers
set t 20000000000000
# the old way (package 1.2) is still supported for backwards compatibility :
set m [fromstr 10000000000]
# but we do not need fromstr for integers anymore
set n -39
# t, m and n are integers
```

Die letzte Ziffer von *number* gilt für die Prozedur als auf +/-1 genau. Beispielsweise entspricht 1.00 dem Intervall \[0.99, 1.01\] und 0.43 dem Intervall \[0.42, 0.44\]. Die Konstante Pi kann durch die Zahl "3.1415" angenähert werden. Diese Zeichenkette würde von **fromstr** als das Intervall \[3.1414 , 3.1416\] aufgefasst. Wenn Sie also 1.0 als Double-Wert meinen, müssen Sie möglicherweise 1.000000 schreiben, um eine ausreichende Genauigkeit zu erzielen. Weitere Informationen zu diesem Thema finden Sie im Abschnitt **GENAUIGKEIT**.

Beispiel:

```
set x [fromstr 1.0000000000]
# the next line does the same, but smarter
set y [fromstr 1. 10]
```

**tostr** ?**-nosci**? *number*
: Gibt einen BigFloat als Zeichenkette zurück, in der alle Ziffern exakt sind. *Alle exakten Ziffern* bedeutet, dass eine Rundung erfolgen kann, beispielsweise auf Null, wenn das Unsicherheitsintervall die tatsächlichen Ziffern nicht eindeutig angibt. *number* kann eine Ganzzahl sein, wodurch der Befehl genau das Eingabeargument zurückgibt. Mit der Option **-nosci** wird die Zahl nie in wissenschaftlicher Notation zurückgegeben, d. h. nicht als '3.4523e+5', sondern als '345230.'.


```
puts [tostr [fromstr 0.99999]] ;# 1.0000
puts [tostr [fromstr 1.00001]] ;# 1.0000
puts [tostr [fromstr 0.002]] ;# 0.e-2
```

: Siehe hierzu den Abschnitt **GENAUIGKEIT**. Siehe auch **iszero** zur Erkennung von Nullen, was bei der Durchführung einer Division hilfreich ist.


**fromdouble** *double* ?*decimals*?
: Konvertiert einen Double-Wert (einen einfachen Gleitkommawert) in einen BigFloat mit genau *decimals* Stellen. Ohne das Argument *decimals* verhält sich der Befehl wie **fromstr**. Wichtig ist hier eigentlich nur die Möglichkeit, BigFloats mit einer festen Anzahl von *decimals* Stellen zu erzeugen.


```
tostr [fromstr 1.111 4]
# returns : 1.111000 (3 zeros)
tostr [fromdouble 1.111 4]
# returns : 1.111
```

**todouble** *number*
: Gibt zu einem BigFloat einen Double-Wert zurück, der in *expr* verwendet werden kann.

**isInt** *number*
: Gibt 1 zurück, wenn *number* eine ganze Zahl ist, andernfalls 0.

**isFloat** *number*
: Gibt 1 zurück, wenn *number* ein BigFloat ist, andernfalls 0.

**int2float** *integer* ?*decimals*?
: Wandelt eine Ganzzahl in einen BigFloat mit *decimals* nachgestellten Nullen um. Die Standardanzahl und die minimale Anzahl von *decimals* beträgt 1. Wenn die Rückwandlung in eine Zeichenkette erfolgt, geht eine Dezimalstelle verloren:


```
set n 10
set x [int2float $n]; # like fromstr 10.0
puts [tostr $x]; # prints "10."
set x [int2float $n 3]; # like fromstr 10.000
puts [tostr $x]; # prints "10.00"
```

# ARITHMETIK

**add** *x* *y*
: ...siehe nächstes...

**sub** *x* *y*
: ...siehe nächstes...

**mul** *x* *y*
: Gibt die Summe, die Differenz und das Produkt von *x* mit *y* zurück. *x* – kann entweder ein BigFloat oder eine Ganzzahl sein; *y* – kann entweder ein BigFloat oder eine Ganzzahl sein. Sind beide Werte Ganzzahlen, verhalten sich diese Befehle wie **expr**.

**div** *x* *y*
: ...siehe nächstes...

**mod** *x* *y*
: Gibt den Quotienten und den Rest der Division von *x* durch *y* zurück. Jedes Argument (*x* und *y*) kann entweder ein BigFloat oder eine Ganzzahl sein; eine Ganzzahl darf jedoch nicht durch einen BigFloat dividiert werden. Die Division durch Null führt zu einem Fehler.

**abs** *x*
: Gibt den Betrag (Absolutwert) von *x* zurück

**opp** *x*
: Gibt die Gegenzahl von *x* zurück (-*x*)

**pow** *x* *n*
: Gibt *x* hoch *n* zurück. Dies funktioniert nur, wenn *n* eine ganze Zahl ist. *x* kann ein BigFloat oder eine ganze Zahl sein.


# VERGLEICHE

**iszero** *x*
: Gibt 1 zurück, wenn *x* Folgendes ist:


**•**
: ein BigFloat, der nahe genug an Null liegt, um den Fehler „Division durch Null“ auszulösen.

**•**
: die ganze Zahl 0.


: Hier sehen Sie, wie Zahlen, die nahe bei Null liegen, in Zeichenketten umgewandelt werden:


```
tostr [fromstr 0.001] ; # -> 0.e-2
tostr [fromstr 0.000000] ; # -> 0.e-5
tostr [fromstr -0.000001] ; # -> 0.e-5
tostr [fromstr 0.0] ; # -> 0.
tostr [fromstr 0.002] ; # -> 0.e-2

set a [fromstr 0.002] ; # uncertainty interval : 0.001, 0.003
tostr  $a ; # 0.e-2
iszero $a ; # false

set a [fromstr 0.001] ; # uncertainty interval : 0.000, 0.002
tostr  $a ; # 0.e-2
iszero $a ; # true
```

**equal** *x* *y*
: Gibt 1 zurück, wenn *x* und *y* gleich sind, andernfalls 0.

**compare** *x* *y*
: Gibt 0 zurück, wenn beide BigFloat-Argumente gleich sind, 1, wenn *x* größer als *y* ist, und -1, wenn *x* kleiner als *y* ist. Ein Vergleich zwischen einer Ganzzahl und einem BigFloat ist nicht möglich: Die Operanden müssen entweder beide BigFloats oder beide Ganzzahlen sein.


# ANALYSE

**sqrt** *x*
: ...siehe nächstes...

**log** *x*
: ...siehe nächstes...

**exp** *x*
: ...siehe nächstes...

**cos** *x*
: ...siehe nächstes...

**sin** *x*
: ...siehe nächstes...

**tan** *x*
: ...siehe nächstes...

**cotan** *x*
: ...siehe nächstes...

**acos** *x*
: ...siehe nächstes...

**asin** *x*
: ...siehe nächstes...

**atan** *x*
: ...siehe nächstes...

**cosh** *x*
: ...siehe nächstes...

**sinh** *x*
: ...siehe nächstes...

**tanh** *x*
: Die oben genannten Funktionen geben jeweils Folgendes zurück: Quadratwurzel, Logarithmus, Exponentialfunktion, Kosinus, Sinus, Tangens, Kotangens, Arkuskosinus, Arkussinus, Arkustangens, hyperbolischer Kosinus, hyperbolischer Sinus, hyperbolischer Tangens eines BigFloat *x*.

**pi** *n*
: Gibt einen BigFloat zurück, der die Konstante Pi mit *n* Stellen nach dem Komma darstellt. *n* ist eine positive ganze Zahl.

**rad2deg** *radians*
: ...siehe nächstes...

**deg2rad** *degrees*
: *radians* – Winkel im Bogenmaß (BigFloat) *degrees* – Winkel in Grad (BigFloat) Rechnet einen Winkel vom Bogenmaß in Grad um und *umgekehrt*.


# RUNDUNG

**round** *x*
: ...siehe nächstes...

**ceil** *x*
: ...siehe nächstes...

**floor** *x*
: Die oben genannten Funktionen runden den BigFloat *x* wie die gleichnamige mathematische Funktion in *expr* und geben das Ergebnis als Ganzzahl zurück.


# GENAUIGKEIT

Wie wirken sich Umwandlungen auf die Genauigkeit aus?

**•**
: Wenn ein BigFloat aus einer Zeichenkette konvertiert wird, wird in der internen Darstellung die Unsicherheit auf der Ebene der letzten Ziffer als 1 gespeichert.

**•**
: Bei der Berechnung wird die Unsicherheit jedes Ergebnisses intern so realitätsnah wie möglich ermittelt, wodurch Speicherplatz eingespart wird.

**•**
: Wenn die Rückkonvertierung in eine Zeichenkette erfolgt, unterliegen die ausgegebenen Ziffern keiner Unsicherheit. Es erfolgt jedoch eine gewisse Rundung, da das Unterlassen einer solchen zu schwerwiegenden Problemen führen würde. Unsicherheiten bleiben in der internen Darstellung der Zahl erhalten; es wird empfohlen, **tostr** ausschließlich zur Ausgabe von Daten (auf dem Bildschirm oder in einer Datei) zu verwenden und **fromstr** NIEMALS mit dem Ergebnis von **tostr** aufzurufen. Es ist besser, Operanden stets in ihrer internen Darstellung zu belassen. Aufgrund der internen Funktionsweise dieser Bibliothek kann das Unsicherheitsintervall etwas breiter sein als erwartet, was jedoch keine falschen Ziffern verursachen sollte. Nun stellen Sie sich vielleicht folgende Frage: Welche Genauigkeit erhalte ich nach dem Aufruf von add, sub, mul oder div? Zunächst erzeugen Sie eine Zahl aus ihrer Zeichenkettendarstellung, wobei nebenbei ihre Unsicherheit festgelegt wird:


```
set a [fromstr 1.230]
# $a belongs to [1.229, 1.231]
set a [fromstr 1.000]
# $a belongs to [0.999, 1.001]
# $a has a relative uncertainty of 0.1% : 0.001(the uncertainty)/1.000(the medium value)
```

Die Unsicherheit der Summe oder der Differenz zweier Zahlen entspricht der Summe ihrer jeweiligen Unsicherheiten.

```
set a [fromstr 1.230]
set b [fromstr 2.340]
set sum [add $a $b]]
# the result is : [3.568, 3.572] (the last digit is known with an uncertainty of 2)
tostr $sum ; # 3.57
```

Wenn wir jedoch beispielsweise eine ganze Zahl zu einem BigFloat addieren oder von diesem subtrahieren, bleibt die relative Unsicherheit des Ergebnisses unverändert. Daher ist es ratsam, ganze Zahlen nicht in BigFloats umzuwandeln:

```
set a [fromstr 0.999999999]
# now something dangerous
set b [fromstr 2.000]
# the result has only 3 digits
tostr [add $a $b]

# how to keep precision at its maximum
puts [tostr [add $a 2]]
```

Bei der Multiplikation und Division entspricht die relative Unsicherheit des Produkts bzw. des Quotienten der Summe der relativen Unsicherheiten der Operanden. Vorsicht bei der Division durch Null: Prüfen Sie jeden Divisor mit **iszero**.

```
set num [fromstr 4.00]
set denom [fromstr 0.01]

puts [iszero $denom];# true
set quotient [div $num $denom];# error : divide by zero

# opposites of our operands
puts [compare $num [opp $num]]; # 1
puts [compare $denom [opp $denom]]; # 0 !!!
# No suprise ! 0 and its opposite are the same...
```

Auswirkungen der Genauigkeit einer Zahl, die als gleich Null angesehen wird, auf die cos-Funktion:

```
puts [tostr [cos [fromstr 0. 10]]]; # -> 1.000000000
puts [tostr [cos [fromstr 0. 5]]]; # -> 1.0000
puts [tostr [cos [fromstr 0e-10]]]; # -> 1.000000000
puts [tostr [cos [fromstr 1e-10]]]; # -> 1.000000000
```

BigFloats mit unterschiedlichen internen Darstellungen können in dieselbe Zeichenkette konvertiert werden.

Bei den meisten Analysefunktionen (Kosinus, Quadratwurzel, Logarithmus usw.) ist es schwierig, die Genauigkeit des Ergebnisses zu bestimmen. Es scheint jedoch, dass der Genauigkeitsverlust des Ergebnisses in vielen Fällen nur eine oder zwei Ziffern beträgt. Es gibt einige Ausnahmen: zum Beispiel,

```
tostr [exp [fromstr 100.0 10]]
# returns : 2.688117142e+43 which has only 10 digits of precision, although the entry
# has 14 digits of precision.
```

# WIE SIEHT ES MIT TCL 8.4 AUS?

Wenn Ihre Systemumgebung Tcl 8.5 nicht bereitstellt, aber 8.4 unterstützt, kann das Paket dennoch geladen werden; es wird dann auf *math::bigfloat* 1.2 zurückgeschaltet. Tatsächlich wird eine wichtige, in Tcl 8.5 eingeführte Funktion benötigt – die Fähigkeit, mit großen Zahlen (Bignums) umzugehen, was wir mit **expr** bewerkstelligen können. Vor Version 8.5 wurde diese Funktion von mehreren Paketen bereitgestellt, darunter das reine Tcl-Paket *math::bignum*, das von *tcllib* bereitgestellt wird. In diesem Fall müssen Sie lediglich wissen, dass die Argumente der hier erläuterten Befehle in ihrer internen Darstellung vorliegen müssen. Selbst bei Ganzzahlen müssen Sie also **fromstr** und **tostr** aufrufen, um sie zwischen Zeichenkette und interner Darstellung umzuwandeln.

```
#
# with Tcl 8.5
# ============
set a [pi 20]
# round returns an integer and 'everything is a string' applies to integers
# whatever big they are
puts [round [mul $a 10000000000]]
#
# the same with Tcl 8.4
# =====================
set a [pi 20]
# bignums (arbitrary length integers) need a conversion hook
set b [fromstr 10000000000]
# round returns a bignum:
# before printing it, we need to convert it with 'tostr'
puts [tostr [round [mul $a $b]]]
```

# NAMESPACES UND ANDERE PAKETE

Wir haben das Thema Namespaces bisher noch nicht behandelt, da wir davon ausgegangen sind, dass Sie öffentliche Befehle wie folgt in den globalen Namespace importiert haben:

```
namespace import ::math::bigfloat::*
```

Wenn es Ihnen besonders wichtig ist, Namenskonflikte zu vermeiden, bin ich der Ansicht, dass dies auf folgende Weise gelöst werden sollte:

```
package require math::bigfloat
# beware: namespace ensembles are not available in Tcl 8.4
namespace eval ::math::bigfloat {namespace ensemble create -command ::bigfloat}
# from now, the bigfloat command takes as subcommands all original math::bigfloat::* commands
set a [bigfloat sub [bigfloat fromstr 2.000] [bigfloat fromstr 0.530]]
puts [bigfloat tostr $a]
```

# BEISPIELE

Raten Sie mal, was passiert, wenn Sie sich mit Astronomie beschäftigen. Hier ein Beispiel:

```
# convert acurrate angles with a millisecond-rated accuracy
proc degree-angle {degrees minutes seconds milliseconds} {
    set result 0
    set div 1
    foreach factor {1 1000 60 60} var [list $milliseconds $seconds $minutes $degrees] {
        # we convert each entry var into milliseconds
        set div [expr {$div*$factor}]
        incr result [expr {$var*$div}]
    }
    return [div [int2float $result] $div]
}
# load the package
package require math::bigfloat
namespace import ::math::bigfloat::*
# work with angles : a standard formula for navigation (taking bearings)
set angle1 [deg2rad [degree-angle 20 30 40   0]]
set angle2 [deg2rad [degree-angle 21  0 50 500]]
set opposite3 [deg2rad [degree-angle 51  0 50 500]]
set sinProduct [mul [sin $angle1] [sin $angle2]]
set cosProduct [mul [cos $angle1] [cos $angle2]]
set angle3 [asin [add [mul $sinProduct [cos $opposite3]] $cosProduct]]
puts "angle3 : [tostr [rad2deg $angle3]]"
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: bignum :: float* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Mathematik

# COPYRIGHT

```
Copyright (c) 2004-2008, by Stephane Arnold <stephanearnold at yahoo dot fr>
```
