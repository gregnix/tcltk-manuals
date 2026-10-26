---
CommandName: math::optimize
title: math::optimize
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - linear program
 - math
 - maximum
 - minimum
 - optimization
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
 - Copyright (c) 2004,2005 Kevn B. Kenny <kennykb@users.sourceforge.net>
---

# Name

math::optimize – Optimierungsroutinen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [math::optimize]{.lit} [1.0]{.optlit}
[::math::optimize::minimum]{.cmd} [begin]{.arg} [end]{.arg} [func]{.arg} [maxerr]{.arg}
[::math::optimize::maximum]{.cmd} [begin]{.arg} [end]{.arg} [func]{.arg} [maxerr]{.arg}
[::math::optimize::min\_bound\_1d]{.cmd} [func]{.arg} [begin]{.arg} [end]{.arg} [[-relerror]{.lit} [reltol]{.arg}]{.optarg} [[-abserror]{.lit} [abstol]{.arg}]{.optarg} [[-maxiter]{.lit} [maxiter]{.arg}]{.optarg} [[-trace]{.lit} [traceflag]{.arg}]{.optarg}
[::math::optimize::min\_unbound\_1d]{.cmd} [func]{.arg} [begin]{.arg} [end]{.arg} [[-relerror]{.lit} [reltol]{.arg}]{.optarg} [[-abserror]{.lit} [abstol]{.arg}]{.optarg} [[-maxiter]{.lit} [maxiter]{.arg}]{.optarg} [[-trace]{.lit} [traceflag]{.arg}]{.optarg}
[::math::optimize::solveLinearProgram]{.cmd} [objective]{.arg} [constraints]{.arg}
[::math::optimize::linearProgramMaximum]{.cmd} [objective]{.arg} [result]{.arg}
[::math::optimize::nelderMead]{.cmd} [objective]{.arg} [xVector]{.arg} [[-scale]{.lit} [xScaleVector]{.arg}]{.optarg} [[-ftol]{.lit} [epsilon]{.arg}]{.optarg} [[-maxiter]{.lit} [count]{.arg}]{.optarg} [?-trace]{.optarg} [flag?]{.arg}
:::

# Beschreibung

Dieses Paket implementiert mehrere Optimierungsalgorithmen:

- Eine Funktion über ein gegebenes Intervall minimieren oder maximieren

- Ein lineares Programm lösen (eine lineare Funktion unter linearen Nebenbedingungen maximieren)

- Eine Funktion mehrerer Variablen minimieren, ausgehend von einer Anfangsschätzung für die Lage des Minimums.


Das Paket ist vollständig in Tcl implementiert. Der Genauigkeit der Berechnungen wurde keine besondere Aufmerksamkeit geschenkt. Stattdessen wurden die Algorithmen auf unkomplizierte Weise angewendet.

Dieses Dokument beschreibt die Prozeduren und erläutert deren Verwendung.

# Prozeduren

Dieses Paket definiert die folgenden öffentlichen Prozeduren:

**::math::optimize::minimum** *begin* *end* *func* *maxerr*
: Minimiert die angegebene (stetige) Funktion, indem die Werte im angegebenen Intervall untersucht werden. Die Prozedur ermittelt die Werte an beiden Enden sowie in der Mitte des Intervalls und bildet anschließend ein neues Intervall mit der Hälfte der Länge, das das Minimum enthält. Es wird keine Garantie dafür gegeben, dass das *globale* Minimum gefunden wird.

    Die Prozedur gibt den „x“-Wert zurück, für den die Funktion ihr Minimum erreicht.

    *Diese Prozedur ist veraltet – verwenden Sie stattdessen min\_bound\_1d*

    *begin* – Anfang des Intervalls

    *end* – Ende des Intervalls

    *func* – Name der zu minimierenden Funktion (eine Prozedur, die ein Argument entgegennimmt).

    *maxerr* – Maximaler relativer Fehler (Standardwert: 1.0e-4)

**::math::optimize::maximum** *begin* *end* *func* *maxerr*
: Maximiert die angegebene (stetige) Funktion, indem die Werte im angegebenen Intervall untersucht werden. Die Prozedur ermittelt die Werte an beiden Enden sowie in der Mitte des Intervalls und bildet anschließend ein neues Intervall mit der Hälfte der Länge, das das Maximum enthält. Es wird keine Garantie dafür gegeben, dass das *globale* Maximum gefunden wird.

    Die Prozedur gibt den „x“-Wert zurück, für den die Funktion ihr Maximum erreicht.

    *Diese Prozedur ist veraltet – verwenden Sie stattdessen max\_bound\_1d*

    *begin* – Anfang des Intervalls

    *end* – Ende des Intervalls

    *func* – Name der zu maximierenden Funktion (eine Prozedur, die ein Argument entgegennimmt).

    *maxerr* – Maximaler relativer Fehler (Standardwert: 1.0e-4)

**::math::optimize::min\_bound\_1d** *func* *begin* *end* ?**-relerror** *reltol*? ?**-abserror** *abstol*? ?**-maxiter** *maxiter*? ?**-trace** *traceflag*?
: Minimiert eine Funktion einer Variablen im angegebenen Intervall. Die Prozedur verwendet die Brent-Methode der parabolischen Interpolation, die durch Unterteilungen nach dem Goldenen Schnitt abgesichert ist, wenn die Interpolation nicht konvergiert.  Es wird keine Garantie dafür gegeben, dass ein *globales* Minimum gefunden wird. Die auszuwertende Funktion *func* muss ein einzelner Tcl-Befehl sein; sie wird mit einer als letztes Argument angehängten Abszisse ausgewertet.

    *x1* und *x2* sind die beiden Grenzen des Intervalls, in dem das Minimum gefunden werden soll.  Sie müssen nicht in aufsteigender Reihenfolge stehen.

    *reltol* ist, wenn es angegeben ist, die gewünschte Obergrenze für den relativen Fehler des Ergebnisses; der Standardwert ist 1.0e-7.  Der angegebene Wert sollte niemals kleiner sein als die Quadratwurzel der Gleitkommagenauigkeit des Rechners, da sonst die Konvergenz nicht gewährleistet ist.  *abstol* ist, sofern angegeben, die gewünschte Obergrenze für den absoluten Fehler des Ergebnisses; der Standardwert beträgt 1.0e-10.  Bei kleinen Werten von *abstol* ist Vorsicht geboten, um Überlauf- bzw. Unterlaufbedingungen zu vermeiden; wenn erwartet wird, dass das Minimum bei einer kleinen, aber von Null verschiedenen Abszisse liegt, sollten Sie entweder eine Verschiebung der Funktion oder eine Änderung ihrer Längenskala in Betracht ziehen.

    *maxiter* kann verwendet werden, um die Anzahl der durchzuführenden Funktionsauswertungen zu begrenzen; der Standardwert ist 100.  Wenn der Befehl die Funktion mehr als *maxiter* Mal auswertet, gibt er einen Fehler an den Aufrufer zurück.

    *traceFlag* ist ein boolescher Wert. Ist er wahr, gibt der Befehl bei jeder Auswertung der Funktion eine Meldung an die Standardausgabe aus, die die Abszisse und die Ordinate sowie einen Hinweis auf die gewählte Interpolationsart enthält. Der Standardwert ist 0 (keine Protokollierung).

**::math::optimize::min\_unbound\_1d** *func* *begin* *end* ?**-relerror** *reltol*? ?**-abserror** *abstol*? ?**-maxiter** *maxiter*? ?**-trace** *traceflag*?
: Minimiert eine Funktion einer Variablen über die gesamte reelle Zahlenachse. Die Prozedur nutzt eine parabolische Extrapolation in Kombination mit einer Dilatation nach dem Goldenen Schnitt, um einen Bereich zu suchen, in dem ein Minimum vorliegt, gefolgt von Brents Methode der parabolischen Interpolation, die durch Unterteilungen nach dem Goldenen Schnitt abgesichert wird, wenn die Interpolation nicht konvergiert.  Es wird keine Garantie dafür gegeben, dass ein *globales* Minimum gefunden wird. Die auszuwertende Funktion *func* muss ein einzelner Tcl-Befehl sein; sie wird mit einer als letztes Argument angehängten Abszisse ausgewertet.

    *x1* und *x2* sind zwei anfängliche Vermutungen, wo das Minimum liegen könnte.  *x1* ist der Startpunkt für die Minimierung, und die Differenz zwischen *x2* und *x1* dient als Hinweis auf die charakteristische Längenskala des Problems.

    *reltol* ist, wenn es angegeben ist, die gewünschte Obergrenze für den relativen Fehler des Ergebnisses; der Standardwert ist 1.0e-7.  Der angegebene Wert sollte niemals kleiner sein als die Quadratwurzel der Gleitkommagenauigkeit des Rechners, da sonst die Konvergenz nicht gewährleistet ist. *abstol* ist, sofern angegeben, die gewünschte Obergrenze für den absoluten Fehler des Ergebnisses; der Standardwert beträgt 1.0e-10.  Bei kleinen Werten für *abstol* ist Vorsicht geboten, um Überlauf- bzw. Unterlaufbedingungen zu vermeiden; wenn erwartet wird, dass das Minimum bei einer kleinen, aber von Null verschiedenen Abszisse liegt, sollten Sie entweder eine Verschiebung der Funktion oder eine Änderung ihrer Längenskala in Betracht ziehen.

    *maxiter* kann verwendet werden, um die Anzahl der durchzuführenden Funktionsauswertungen zu begrenzen; der Standardwert ist 100.  Wenn der Befehl die Funktion mehr als *maxiter* Mal auswertet, gibt er einen Fehler an den Aufrufer zurück.

    *traceFlag* ist ein boolescher Wert. Wenn er auf „true“ gesetzt ist, gibt der Befehl bei jeder Auswertung einer Funktion eine Meldung an die Standardausgabe aus, die die Abszisse und die Ordinate sowie einen Hinweis auf die gewählte Interpolationsart enthält. Der Standardwert ist 0 (keine Protokollierung).

**::math::optimize::solveLinearProgram** *objective* *constraints*
: Löst ein *lineares Programm* in Standardform mit einer einfachen Implementierung des Simplex-Algorithmus. (In der folgenden Erläuterung hat das lineare Programm N Nebenbedingungen und M Variablen.)

    Die Prozedur gibt eine Liste mit M Werten zurück, bei denen die Zielfunktion ihr Maximum erreicht, oder ein einzelnes Schlüsselwort, wenn das lineare Programm unzulässig oder unbeschränkt ist (entweder „unfeasible“ oder „unbounded“).

    *objective* – Die M Koeffizienten der Zielfunktion

    *constraints* – Matrix aus Koeffizienten und Maximalwerten, die die linearen Nebenbedingungen darstellen. Erwartet wird eine Liste aus N Listen mit jeweils M+1 Zahlen: den M Koeffizienten und dem Maximalwert.

**::math::optimize::linearProgramMaximum** *objective* *result*
: Hilfsfunktion, die den Maximalwert für die von der Prozedur solveLinearProgram gefundene Lösung zurückgibt.

    *objective* – Die M Koeffizienten der Zielfunktion

    *result* – Das von solveLinearProgram zurückgegebene Ergebnis

**::math::optimize::nelderMead** *objective* *xVector* ?**-scale** *xScaleVector*? ?**-ftol** *epsilon*? ?**-maxiter** *count*? ??-trace? *flag*?
: Minimiert auf uneingeschränkte Weise eine Funktion mehrerer Variablen über den gesamten Raum. Die auszuwertende Funktion, *objective*, muss ein einzelner Tcl-Befehl sein. An diesen werden so viele Elemente angehängt, wie in der Anfangsschätzung für die Lage des Minimums enthalten sind, die als Tcl-Liste *xVector* übergeben wird.

    *xScaleVector* ist eine anfängliche Schätzung des Problemmaßstabs; die ersten Auswertungen der Funktion erfolgen durch Variation der Koordinaten in *xVector* um die in *xScaleVector* angegebenen Beträge.  Wenn *xScaleVector* nicht angegeben wird, werden die Koordinaten um den Faktor 1.0001 (sofern die Koordinate ungleich Null ist) oder um den konstanten Wert 0.0001 (sofern die Koordinate Null ist) variiert.

    *epsilon* ist der gewünschte relative Fehler des am Minimum ausgewerteten Funktionswerts. Der Standardwert ist 1.0e-7, was in der Regel eine Genauigkeit von drei signifikanten Stellen bei den x-Werten ergibt.

    pp *count* ist eine Begrenzung der Anzahl der Durchläufe durch die Hauptschleife des Optimierers.  Die Anzahl der Funktionsauswertungen kann ein Vielfaches dieser Zahl betragen.  Wenn der Optimierer innerhalb von *maxiter* Iterationen kein Minimum mit einer Genauigkeit von *ftol* findet, gibt er seine aktuell beste Schätzung sowie einen Fehlerstatus zurück. Standardmäßig sind 500 Iterationen zulässig.

    *flag* ist ein Flag, das, falls es wahr ist, bewirkt, dass bei jeder Auswertung der Zielfunktion eine Zeile an die Standardausgabe geschrieben wird, die die an die Funktion übergebenen Argumente und den zurückgegebenen Wert enthält. Der Standardwert ist „false“.

    Die Prozedur **nelderMead** gibt eine Liste abwechselnder Schlüsselwörter und Werte zurück, die für die Verwendung mit **array set** geeignet sind. Die Schlüsselwörter haben folgende Bedeutung:

    *x* ist die ungefähre Position des Minimums.

    *y* ist der Wert der Funktion am Punkt *x*.

    *yvec* ist ein Vektor der besten N+1 erzielten Funktionswerte, wobei N die Dimension von *x* ist.

    *vertices* ist eine Liste von Vektoren, die die Funktionsargumente angeben, die den Werten in *yvec* entsprechen.

    *nIter* ist die Anzahl der Iterationen, die erforderlich sind, um Konvergenz zu erreichen oder zu scheitern.

    *status* ist „ok“, wenn der Vorgang erfolgreich war, oder „too-many-iterations“, wenn die maximale Iterationsanzahl überschritten wurde.

    **nelderMead** minimiert die angegebene Funktion unter Verwendung der Downhill-Simplex-Methode von Nelder und Mead. Diese Methode ist recht langsam – es sind wesentlich schnellere Methoden zur Minimierung bekannt –, hat jedoch den Vorteil, dass sie bei Problemen, bei denen das Minimum in einem Tal komplexer Topologie liegt, äußerst robust ist.

    **nelderMead** kann gelegentlich an einem Punkt „hängenbleiben“, an dem es keine weiteren Fortschritte mehr erzielen kann; es wird empfohlen, dass der Aufrufer die Funktion mindestens ein zweites Mal ausführt und dabei das vom vorherigen Aufruf gefundene Ergebnis als Anfangsschätzung übergibt. Der zweite Durchlauf ist in der Regel sehr schnell.

    **nelderMead** kann in einigen Fällen für die Optimierung unter Nebenbedingungen verwendet werden. Fügen Sie dazu der Zielfunktion einen großen Wert hinzu, wenn sich die Parameter außerhalb des zulässigen Bereichs befinden.  Um in diesem Modus effektiv zu arbeiten, erfordert **nelderMead**, dass der Anfangswert zulässig ist, und in der Regel, dass der zulässige Bereich konvex ist.


# Hinweise

Einige der oben genannten Prozeduren nehmen die *Namen* von Prozeduren als Argumente entgegen. Um Probleme mit der *Sichtbarkeit* dieser Prozeduren zu vermeiden, wird der vollqualifizierte Name dieser Prozeduren innerhalb der Optimierungsroutinen ermittelt. Für den Benutzer hat dies nur eine Konsequenz: Die benannte Prozedur muss in der aufrufenden Prozedur sichtbar sein. Zum Beispiel:

```
    namespace eval ::mySpace {
       namespace export calcfunc
       proc calcfunc { x } { return $x }
    }
    #
    # Use a fully-qualified name
    #
    namespace eval ::myCalc {
       puts [min_bound_1d ::myCalc::calcfunc $begin $end]
    }
    #
    # Import the name
    #
    namespace eval ::myCalc {
       namespace import ::mySpace::calcfunc
       puts [min_bound_1d calcfunc $begin $end]
    }
```

Die einfachen Prozeduren *minimum* und *maximum* sind veraltet: Die Alternativen sind wesentlich flexibler, robuster und erfordern weniger Funktionsauswertungen.

# Beispiele

Lassen Sie uns einige einfache Beispiele betrachten:

Bestimmen Sie das Maximum von f(x) = x^3 exp(-3x) auf dem Intervall (0,10):

```
proc efunc { x } { expr {$x*$x*$x * exp(-3.0*$x)} }
puts "Maximum at: [::math::optimize::max_bound_1d efunc 0.0 10.0]"
```

Der maximal zulässige Fehler bestimmt die Anzahl der durchgeführten Schritte (bei jedem Schritt der Iteration wird das Intervall um den Faktor 1/2 verringert). Somit wird ein maximaler Fehler von 0.0001 in etwa 14 Schritten erreicht.

Ein Beispiel für ein *lineares Programm*:

Optimieren Sie den Ausdruck 3x+2y, wobei:

```
   x >= 0 and y >= 0 (implicit constraints, part of the
                     definition of linear programs)

   x + y   <= 1      (constraints specific to the problem)
   2x + 5y <= 10
```

Dieses Problem lässt sich wie folgt lösen:

```
   set solution [::math::optimize::solveLinearProgram  { 3.0   2.0 }  { { 1.0   1.0   1.0 }
        { 2.0   5.0  10.0 } } ]
```

Hinweis: Eine Nebenbedingung wie:

```
   x + y >= 1
```

lässt sich so in die Standardform bringen:

```
   -x  -y <= -1
```

Die Theorie der linearen Programmierung ist Gegenstand zahlreicher Lehrbücher, und der hier implementierte Simplex-Algorithmus ist die bekannteste Methode zur Lösung dieser Art von Problemen, jedoch nicht die einzige.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: optimize* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
Copyright (c) 2004,2005 Kevn B. Kenny <kennykb@users.sourceforge.net>
```
