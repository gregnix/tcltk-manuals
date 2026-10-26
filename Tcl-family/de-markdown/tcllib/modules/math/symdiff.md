---
CommandName: math::calculus::symdiff
title: math::calculus::symdiff
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Symbolic differentiation for Tcl
Links:
 - math::calculus
 - math::interpolate
Copyright:
 - Copyright (c) 2010 by Kevin B. Kenny <kennykb@acm.org>
---

# Name

math::calculus::symdiff – Symbolische Differentiation für Tcl

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [grammar::aycock]{.lit} [1.0]{.lit}
[package]{.cmd} [require]{.sub} [math::calculus::symdiff]{.lit} [1.0.2]{.lit}
[math::calculus::symdiff::symdiff]{.cmd} [expression]{.arg} [variable]{.arg}
[math::calculus::jacobian]{.cmd} [variableDict]{.arg}
:::

# Beschreibung

Das Paket **math::calculus::symdiff** bietet eine Funktion zur symbolischen Differenzierung von Tcl-Mathematik-Ausdrücken. Es ist nützlich, um Ableitungen für Pakete bereitzustellen, die entweder die Jacobi-Matrix einer Funktionsmenge benötigen oder die effizienter bzw. stabiler arbeiten, wenn die Jacobi-Matrix bereitgestellt wird.

# Prozeduren

Das Paket **math::calculus::symdiff** exportiert die beiden Prozeduren:

**math::calculus::symdiff::symdiff** *expression* *variable*
: Differenziert den angegebenen *expression* nach der angegebenen *variable*. (Eine Erläuterung der Teilmenge der Tcl-Mathematikausdrücke, die von **math::calculus::symdiff** akzeptiert werden, finden Sie im Abschnitt [Ausdrücke] weiter unten.) Das Ergebnis ist ein Tcl-Ausdruck, der die Ableitung berechnet. Meldet einen Fehler, wenn *expression* kein wohlgeformter Ausdruck ist oder nicht differenzierbar ist.

**math::calculus::jacobian** *variableDict*
: Berechnet die Jacobi-Matrix eines Gleichungssystems. Das System wird durch das Dictionary *variableDict* angegeben, dessen Schlüssel die Namen der Variablen im System sind und dessen Werte Tcl-Ausdrücke sind, die die Werte dieser Variablen angeben. (Eine Erläuterung der Teilmenge der Tcl-Mathematikausdrücke, die von **math::calculus::symdiff** akzeptiert werden, finden Sie im Abschnitt [Ausdrücke] weiter unten. Das Ergebnis ist eine Liste von Listen: Das i-te Element der j-ten Unterliste ist die partielle Ableitung der i-ten Variablen nach der j-ten Variablen. Meldet einen Fehler, wenn einer der Ausdrücke nicht differenzierbar ist oder wenn *variableDict* kein wohlgeformtes Dictionary ist.


# Ausdrücke

Das Paket **math::calculus::symdiff** akzeptiert nur eine kleine Teilmenge der Ausdrücke, die für Tcl-Befehle wie **expr** oder **if** zulässig sind. Konkret werden ausschließlich folgende Konstrukte akzeptiert:

- Gleitkomma-Konstanten wie beispielsweise **5** oder **3.14159e+00**.

- Verweise auf Tcl-Variablen mit $-Ersetzung. Die Namen der Variablen müssen aus alphanumerischen Zeichen und Unterstrichen bestehen: Die Schreibweise **${...}** wird nicht akzeptiert.

- Klammern.

- Die Operatoren **+**, **-**, **\***, **/** und **\*\***.

- Aufrufe der Funktionen [acos][bigfloat], [asin][bigfloat], [atan][bigfloat], **atan2**, [cos][bigfloat], [cosh][bigfloat], [exp][bigfloat], **hypot**, **log**, **log10**, [pow][bigfloat], [sin][bigfloat], [sinh][bigfloat]. [sqrt][bigfloat], [tan][bigfloat] und [tanh][bigfloat].


Befehlsersetzung, Backslash-Ersetzung und Argumenterweiterung werden nicht akzeptiert.

# Beispiele

```
math::calculus::symdiff::symdiff {($a*$x+$b)*($c*$x+$d)} x
==> (($c * (($a * $x) + $b)) + ($a * (($c * $x) + $d)))
math::calculus::symdiff::jacobian {x {$a * $x + $b * $y}
                         y {$c * $x + $d * $y}}
==> {{$a} {$b}} {{$c} {$d}}
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: calculus* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Copyright

```
Copyright (c) 2010 by Kevin B. Kenny <kennykb@acm.org>
Redistribution permitted under the terms of the Open Publication License <http://www.opencontent.org/openpub/>
```


[bigfloat]: bigfloat.md
