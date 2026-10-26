---
CommandName: math::fuzzy
title: math::fuzzy
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - floating-point
 - math
 - rounding
Copyright:
---

# Name

math::fuzzy – Unscharfer Vergleich von Gleitkommazahlen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.3]{.optlit}
[package]{.cmd} [require]{.sub} [math::fuzzy]{.lit} [0.2]{.optlit}
[::math::fuzzy::teq]{.cmd} [value1]{.arg} [value2]{.arg}
[::math::fuzzy::tne]{.cmd} [value1]{.arg} [value2]{.arg}
[::math::fuzzy::tge]{.cmd} [value1]{.arg} [value2]{.arg}
[::math::fuzzy::tle]{.cmd} [value1]{.arg} [value2]{.arg}
[::math::fuzzy::tlt]{.cmd} [value1]{.arg} [value2]{.arg}
[::math::fuzzy::tgt]{.cmd} [value1]{.arg} [value2]{.arg}
[::math::fuzzy::tfloor]{.cmd} [value]{.arg}
[::math::fuzzy::tceil]{.cmd} [value]{.arg}
[::math::fuzzy::tround]{.cmd} [value]{.arg}
[::math::fuzzy::troundn]{.cmd} [value]{.arg} [ndigits]{.arg}
:::

# Beschreibung

Das Paket „Fuzzy“ dient dazu, häufige Probleme mit Gleitkommazahlen auf systematische Weise zu lösen:

- Der Vergleich zweier Zahlen, die eigentlich identisch sein „sollten“, wie beispielsweise 1.0 und 2.1/(1.2+0.9), führt nicht zwangsläufig zu dem intuitiv erwarteten Ergebnis.

- Das Runden einer Zahl, die genau zwischen zwei ganzen Zahlen liegt, kann zu seltsamen Fehlern führen, wie beispielsweise int(100.0\*2.8) != 28, sondern 27.


Das Fuzzy-Paket soll dabei helfen, diese Art von Problemen zu lösen, indem es „unscharfe“ Vergleichsprozeduren für Gleitkommazahlen definiert. Dies geschieht durch die Berücksichtigung einer kleinen Toleranz, die automatisch bestimmt wird – die Toleranz beträgt das Dreifache des „Epsilon“-Werts, d. h. das Dreifache der kleinsten Zahl *eps*, bei der 1.0 und 1.0+$eps unterschieden werden können. In Tcl, das Gleitkommazahlen mit doppelter Genauigkeit verwendet, beträgt dieser Wert typischerweise 1.1e-16.

# Prozeduren

Im Wesentlichen bietet das Paket die folgenden Prozeduren:

**::math::fuzzy::teq** *value1* *value2*
: Vergleicht zwei Gleitkommazahlen und gibt 1 zurück, wenn deren Werte innerhalb eines kleinen Bereichs liegen. Andernfalls wird 0 zurückgegeben.

**::math::fuzzy::tne** *value1* *value2*
: Gibt die Negation zurück, d. h., wenn die Differenz größer als die Toleranz ist, wird 1 zurückgegeben.

**::math::fuzzy::tge** *value1* *value2*
: Vergleicht zwei Gleitkommazahlen und gibt 1 zurück, wenn deren Werte entweder in einen kleinen Bereich fallen oder wenn die erste Zahl größer ist als die zweite. Andernfalls wird 0 zurückgegeben.

**::math::fuzzy::tle** *value1* *value2*
: Gibt den Wert 1 zurück, wenn die beiden Zahlen gemäß \[teq\] gleich sind oder wenn die erste kleiner als die zweite ist.

**::math::fuzzy::tlt** *value1* *value2*
: Gibt das Gegenteil von \[tge\] zurück.

**::math::fuzzy::tgt** *value1* *value2*
: Gibt das Gegenteil von \[tle\] zurück.

**::math::fuzzy::tfloor** *value*
: Gibt die ganze Zahl zurück, die innerhalb einer genau definierten Toleranz kleiner oder gleich der angegebenen Gleitkommazahl ist.

**::math::fuzzy::tceil** *value*
: Gibt die ganze Zahl zurück, die innerhalb einer genau definierten Toleranz größer oder gleich der angegebenen Gleitkommazahl ist.

**::math::fuzzy::tround** *value*
: Rundet die Gleitkommazahl.

**::math::fuzzy::troundn** *value* *ndigits*
: Rundet die Gleitkommazahl auf die festgelegte Anzahl von Dezimalstellen (Pro memorie).


Verwendung:

```
if { [teq $x $y] } { puts "x == y" }
if { [tne $x $y] } { puts "x != y" }
if { [tge $x $y] } { puts "x >= y" }
if { [tgt $x $y] } { puts "x > y" }
if { [tlt $x $y] } { puts "x < y" }
if { [tle $x $y] } { puts "x <= y" }

set fx      [tfloor $x]
set fc      [tceil  $x]
set rounded [tround $x]
set roundn  [troundn $x $nodigits]
```

# Testfälle

Die Probleme, die bei Gleitkommazahlen auftreten können, werden anhand der Tests in der Datei „fuzzy.test“ veranschaulicht:

- In mehreren Tests werden die üblichen Vergleichsoperatoren verwendet, und diese liefern ausnahmslos keine nachvollziehbaren Ergebnisse.

- Ein Testfall verwendet \[expr\] ohne geschweifte Klammern ({ und }). Auch dieser schlägt fehl.


Daraus lässt sich schließen, dass jeder Ausdruck in geschweifte Klammern gesetzt werden sollte, da es andernfalls zu sehr unangenehmen Situationen kommen kann, wenn Genauigkeit erforderlich ist. Darüber hinaus werden Genauigkeit und Verständlichkeit der Ergebnisse durch die Verwendung dieser „toleranten“ oder unscharfen Vergleiche verbessert.

Hinweis: Es gibt neben dem reinen Tcl-Paket auch eine C-basierte Version.

# Literatur

Ursprüngliche Implementierung in Fortran durch Dr. H.D. Knoble (Penn State University).

P. E. Hagerty, „More on Fuzzy Floor and Ceiling“, APL QUOTE QUAD 8(4):20–24, Juni 1978. Hinweis: Es hat fünf Jahre gedauert, bis TFLOOR=FL5 nach einem Begutachtungsverfahren veröffentlicht wurde.

L. M. Breed, „Definitions for Fuzzy Floor and Ceiling“, APL QUOTE QUAD 8(3):16–23, März 1978.

D. Knuth, Art of Computer Programming, Band 1, Aufgabe 1.2.4–5.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: fuzzy* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Mathematik
