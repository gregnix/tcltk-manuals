---
CommandName: math::calculus::romberg
ManualSection: n
Version: 0.6
TclPart: tcllib
TclDescription: Tcl Math Library
Links:
 - math::calculus
 - math::interpolate
Copyright:
 - Copyright (c) 2004 Kevin B. Kenny <kennykb@acm.org>. All rights reserved. Redistribution permitted under the terms of the Open Publication License <http://www.opencontent.org/openpub/>
---

# NAME

math::calculus::romberg – Romberg-Integral

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math::calculus]{.lit} [0.6]{.lit} 
[::math::calculus::romberg]{.cmd} [f]{.arg} [a]{.arg} [b]{.arg} [-option value]{.optdot} 
[::math::calculus::romberg_infinity]{.cmd} [f]{.arg} [a]{.arg} [b]{.arg} [-option value]{.optdot} 
[::math::calculus::romberg_sqrtSingLower]{.cmd} [f]{.arg} [a]{.arg} [b]{.arg} [-option value]{.optdot} 
[::math::calculus::romberg_sqrtSingUpper]{.cmd} [f]{.arg} [a]{.arg} [b]{.arg} [-option value]{.optdot} 
[::math::calculus::romberg_powerLawLower]{.cmd} [gamma]{.arg} [f]{.arg} [a]{.arg} [b]{.arg} [-option value]{.optdot} 
[::math::calculus::romberg_powerLawUpper]{.cmd} [gamma]{.arg} [f]{.arg} [a]{.arg} [b]{.arg} [-option value]{.optdot} 
[::math::calculus::romberg_expLower]{.cmd} [f]{.arg} [a]{.arg} [b]{.arg} [-option value]{.optdot} 
[::math::calculus::romberg_expUpper]{.cmd} [f]{.arg} [a]{.arg} [b]{.arg} [-option value]{.optdot} 
:::

# BESCHREIBUNG

Die Prozeduren **romberg** im Paket **math::calculus** führen die numerische Integration einer Funktion einer Variablen durch. Sie sind so konzipiert, dass sie „produktionsreif“ sind, d. h., sie sind robust, präzise und hinsichtlich der Anzahl der Auswertungen angemessen effizient.

# PROZEDUREN

Für die Romberg-Integration stehen folgende Prozeduren zur Verfügung:

**::math::calculus::romberg** *f* *a* *b* ?*-option value*...?
: Integriert eine analytische Funktion über ein gegebenes Intervall.

**::math::calculus::romberg_infinity** *f* *a* *b* ?*-option value*...?
: Integriert eine analytische Funktion über ein halbunendliches Intervall.

**::math::calculus::romberg_sqrtSingLower** *f* *a* *b* ?*-option value*...?
: Integriert eine Funktion, von der erwartet wird, dass sie über ein Intervall hinweg analytisch ist, abgesehen vom Vorhandensein einer Singularität in Form einer inversen Quadratwurzel an der unteren Grenze.

**::math::calculus::romberg_sqrtSingUpper** *f* *a* *b* ?*-option value*...?
: Integriert eine Funktion, von der erwartet wird, dass sie über ein Intervall hinweg analytisch ist, abgesehen vom Vorhandensein einer Singularität in Form einer inversen Quadratwurzel an der oberen Grenze.

**::math::calculus::romberg_powerLawLower** *gamma* *f* *a* *b* ?*-option value*...?
: Integriert eine Funktion, von der erwartet wird, dass sie über ein Intervall hinweg analytisch ist, abgesehen vom Vorhandensein einer Potenzgesetz-Singularität an der unteren Grenze.

**::math::calculus::romberg_powerLawUpper** *gamma* *f* *a* *b* ?*-option value*...?
: Integriert eine Funktion, von der erwartet wird, dass sie über ein Intervall hinweg analytisch ist, abgesehen vom Vorhandensein einer Potenzgesetz-Singularität an der oberen Grenze.

**::math::calculus::romberg_expLower** *f* *a* *b* ?*-option value*...?
: Integriert eine exponentiell wachsende Funktion; die untere Grenze des Integrationsbereichs kann beliebig groß und negativ sein.

**::math::calculus::romberg_expUpper** *f* *a* *b* ?*-option value*...?
: Integriert eine exponentiell abklingende Funktion; die Obergrenze des Integrationsbereichs kann beliebig groß sein.


# PARAMETER

*f*
: Zu integrierende Funktion. Diese muss als einzelner Tcl-Befehl ausgedrückt werden, an den ein einziges Argument angehängt wird, nämlich die Abszisse, bei der die Auswertung der Funktion erfolgen soll. Das erste Wort des Befehls wird vor jeder Auswertung mit **namespace which** im Geltungsbereich des Aufrufers verarbeitet. Aufgrund dieser Verarbeitung kann der Befehl lokal im aufrufenden Namespace definiert sein und muss nicht global sein.

*a*
: Untergrenze des Integrationsbereichs.

*b*
: Obergrenze des Integrationsbereichs. Für die Prozeduren **romberg_sqrtSingLower**, **romberg_sqrtSingUpper**, **romberg_powerLawLower**, **romberg_powerLawUpper**, **romberg_expLower** und **romberg_expUpper** muss die Untergrenze echt kleiner sein als die Obergrenze.  Bei den übrigen Prozeduren können die Grenzen in beliebiger Reihenfolge angegeben werden.

*gamma*
: Potenz, die für eine Singularität nach einem Potenzgesetz verwendet wird; Einzelheiten finden Sie im Abschnitt **UNEIGENTLICHE INTEGRALE**.


# OPTIONEN

**-abserror** *epsilon*
: Legt fest, dass der Integrationsvorgang höchstens so lange fortgesetzt wird, bis der geschätzte absolute Fehler des Integrals kleiner als *epsilon* ist. Der Fehler kann erheblich über- oder unterschätzt werden, wenn die Funktion (oder eine ihrer Ableitungen) Singularitäten enthält; Einzelheiten finden Sie im Abschnitt **UNEIGENTLICHE INTEGRALE**. Der Standardwert beträgt 1.0e-08.

**-relerror** *epsilon*
: Legt fest, dass der Integrationsvorgang höchstens so lange fortgesetzt wird, bis der geschätzte relative Fehler des Integrals kleiner als *epsilon* ist. Der Fehler kann erheblich über- oder unterschätzt werden, wenn die Funktion (oder eine ihrer Ableitungen) Singularitäten enthält; Einzelheiten finden Sie im Abschnitt **UNEIGENTLICHE INTEGRALE**.  Der Standardwert beträgt 1.0e-06.

**-maxiter** *m*
: Legt fest, dass die Integration nach höchstens *n* Verdreifachungen der Anzahl der durchgeführten Auswertungen beendet wird. Mit anderen Worten: Bei einem Wert von *n* für **-maxiter** führt der Integrationsmechanismus höchstens 3\*\**n* Auswertungen der Funktion durch.  Der Standardwert beträgt 14, was einer Obergrenze von etwa 4,8 Millionen Auswertungen entspricht. (Gutartige Funktionen erfordern selten mehr als einige hundert Auswertungen.)

**-degree** *d*
: Legt fest, dass bei der Romberg-Integration ein extrapolierendes Polynom vom Grad *d* verwendet werden soll; Einzelheiten finden Sie im Abschnitt **BESCHREIBUNG**. Der Standardwert ist 4. Der Wert darf höchstens *m*-1 betragen.


# BESCHREIBUNG

Die Prozedur **romberg** führt eine Romberg-Integration unter Verwendung der modifizierten Mittelpunktsregel durch. Die Romberg-Integration ist ein iterativer Prozess. Im ersten Schritt wird die Funktion am Mittelpunkt des Integrationsbereichs ausgewertet, und der Wert wird mit der Breite des Intervalls multipliziert; das ergibt die gröbstmögliche Schätzung. Im zweiten Schritt wird das Intervall in drei Teile unterteilt, und die Funktion wird am Mittelpunkt jedes Teils ausgewertet; die Summe der Werte wird mit drei multipliziert.  Im dritten Schritt werden neun Teile verwendet, im vierten siebenundzwanzig und so weiter, wobei sich die Anzahl der Unterteilungen bei jedem Schritt verdreifacht.

Sobald das Intervall mindestens *d* Mal unterteilt wurde, wird ein Polynom an die in den letzten *d*+1 Unterteilungen geschätzten Integrale angepasst.  Die Integrale werden als Funktion des Quadrats der Breite der Teilintervalle betrachtet (jedes gute Lehrbuch der numerischen Mathematik behandelt diesen Prozess unter dem Begriff „Romberg-Integration“). Das Polynom wird auf eine Schrittweite von Null extrapoliert, wodurch ein Wert für das Integral sowie eine Schätzung des Fehlers berechnet werden.

Dieser Prozess verläuft nur dann einwandfrei, wenn die Funktion im Integrationsbereich analytisch ist; an beiden Enden des Bereichs dürfen hebbare Singularitäten auftreten, sofern der Grenzwert der Funktion (und aller ihrer Ableitungen) bei Annäherung an die Endpunkte existiert. Somit kann **romberg** verwendet werden, um eine Funktion wie f(x)=sin(x)/x über ein Intervall zu integrieren, das bei Null beginnt oder endet.

Beachten Sie, dass **romberg** entweder nicht konvergiert oder falsche Fehlerschätzungen zurückgibt, wenn die Funktion oder eine ihrer Ableitungen irgendwo im Integrationsbereich eine Singularität hat (mit Ausnahme des oben genannten Falls).  Daher ist bei der Integration einer Funktion wie 1/(1-x\*\*2) Vorsicht geboten, um die Stellen zu vermeiden, an denen die Ableitung singulär ist.

# UNEIGENTLICHE INTEGRALE

Die Romberg-Integration eignet sich auch zur Integration von Funktionen über halbunendliche Intervalle oder von Funktionen, die Singularitäten aufweisen. Der Trick besteht darin, einen Variablenwechsel vorzunehmen, um die Singularität zu beseitigen, und die Singularität an das eine oder andere Ende des Integrationsbereichs zu verlagern. Das Paket **math::calculus** stellt eine Reihe von **romberg**-Prozeduren zur Verfügung, um die häufigsten Fälle zu behandeln.

**romberg_infinity**
: Integriert eine Funktion über ein halbunendliches Intervall; entweder *a* oder *b* kann unendlich sein. *a* und *b* müssen das gleiche Vorzeichen haben; wenn Sie über die Achse integrieren müssen, beispielsweise von einem negativen Wert bis zur positiven Unendlichkeit, verwenden Sie **romberg**, um vom negativen Wert bis zu einem kleinen positiven Wert zu integrieren, und anschließend **romberg_infinity**, um vom positiven Wert bis zur positiven Unendlichkeit zu integrieren.  Die Prozedur **romberg_infinity** arbeitet mit dem Variablenwechsel u=1/x, sodass das Integral von a bis b über f(x) als das Integral von 1/a bis 1/b über f(1/u)/u\*\*2 ausgewertet wird.

**romberg_powerLawLower** und **romberg_powerLawUpper**
: Integriert eine Funktion, die entweder an der unteren oder an der oberen Grenze des Integrationsbereichs eine integrierbare Singularität in Form eines Potenzgesetzes aufweist (oder dort eine Ableitung mit einer Singularität in Form eines Potenzgesetzes besitzt). Diese Prozeduren erfordern einen ersten Parameter, *gamma*, der das Potenzgesetz angibt.  Es wird angenommen, dass die Funktion oder ihre erste Ableitung wie (x-*a*)\*\*(-*gamma*) oder (*b*-x)\*\*(-*gamma*) divergiert.  *gamma* muss größer als Null und kleiner als 1 sein. Diese Prozeduren sind nicht nur bei der Integration von Funktionen nützlich, die an einem Ende des Integrationsbereichs gegen unendlich streben, sondern auch bei Funktionen, deren Ableitungen am Ende des Bereichs nicht existieren.  Beispielsweise führt die Integration von f(x)=pow(x,0.25) mit dem Ursprung als einem Ende des Integrationsbereichs dazu, dass die Prozedur **romberg** den Fehler im Integral erheblich unterschätzt. Das Problem lässt sich beheben, indem man berücksichtigt, dass die erste Ableitung von f(x), f'(x)=x\*\*(-3/4)/4, am Ursprung gegen unendlich geht.  Die Integration mit **romberg_powerLawLower** mit *gamma* gleich 0.75 führt zu einer wesentlich geordneteren Konvergenz. Diese Prozeduren arbeiten mit dem Variablenwechsel u=(x-a)\*\*(1-gamma) (**romberg_powerLawLower**) bzw. u=(b-x)\*\*(1-gamma) (**romberg_powerLawUpper**). Zur Zusammenfassung der Bedeutung von gamma:


**•**
: Wenn f(x) ~ x\*\*(-a) (0 < a < 1) gilt, verwenden Sie gamma = a

**•**
: Wenn f'(x) ~ x\*\*(-b) (0 < b < 1) gilt, verwenden Sie gamma = b


**romberg_sqrtSingLower** und **romberg_sqrtSingUpper**
: Diese Prozeduren verhalten sich im häufigen Fall *gamma*=0.5 identisch zu **romberg_powerLawLower** und **romberg_powerLawUpper**; das heißt, sie integrieren eine Funktion mit einer Singularität in Form einer inversen Quadratwurzel an einem Ende des Intervalls.  Ihre Implementierung ist einfacher, da sie Quadratwurzeln anstelle beliebiger Potenzen verwenden.

**romberg_expLower** und **romberg_expUpper**
: Diese Prozeduren dienen der Integration einer Funktion, die über ein halbunendliches Intervall exponentiell ansteigt oder abfällt. **romberg_expLower** behandelt exponentiell ansteigende Funktionen und ermöglicht es, die untere Integrationsgrenze als beliebig große negative Zahl festzulegen.  **romberg_expUpper** behandelt exponentiell abklingende Funktionen und erlaubt, dass die obere Integrationsgrenze eine beliebig große positive Zahl ist. Die Funktionen nehmen den Variablenwechsel u=exp(-x) bzw. u=exp(x) vor.


# SONSTIGE VARIABLENÄNDERUNGEN

Wenn Sie ein anderes uneigentliches Integral als die hier aufgeführten benötigen, lässt sich ein Variablenwechsel mit nur wenigen Zeilen Tcl-Code umsetzen. Da der dafür erforderliche Tcl-Code etwas kompliziert ist, stellen wir Ihnen hier ein ausgearbeitetes Beispiel zur Verfügung.

Angenommen, die Funktion, die wir integrieren möchten, ist f(x)=exp(x)/sqrt(1-x\*x) (keine sehr natürliche Funktion, aber ein gutes Beispiel), und wir möchten sie über das Intervall (-1,1) integrieren.  Der Nenner wird an beiden Enden des Intervalls null. Wir möchten die Variable von x auf u umstellen, sodass dx/sqrt(1-x\*\*2) zu du wird.  Mit x=sin(u) ergibt sich dx=cos(u)\*du und sqrt(1-x\*\*2)=cos(u).  Das Integral von f(x) von a bis b ist das Integral von f(sin(u))\*cos(u) von asin(a) bis asin(b).

Wir können eine Funktion **g** definieren, die eine beliebige Funktion **f** sowie den Parameter u entgegennimmt und diesen neuen Integranden berechnet.

```
proc g { f u } {
    set x [expr { sin($u) }]
    set cmd $f; lappend cmd $x; set y [eval $cmd]
    return [expr { $y / cos($u) }]
}
```

Nun entspricht die Integration von **f** von *a* bis *b* der Integration von **g** von *asin(a)* bis *asin(b)*. Es ist etwas knifflig, **f** konsistent im Geltungsbereich des Aufrufers auszuwerten; die folgende Prozedur ermöglicht dies.

```
proc romberg_sine { f a b args } {
    set f [lreplace $f 0 0 [uplevel 1 [list namespace which [lindex $f 0]]]]
    set f [list g $f]
    return [eval [linsert $args 0 romberg $f [expr { asin($a) }] [expr { asin($b) }]]]
}
```

Diese **romberg_sine**-Prozedur bewältigt jede Funktion, bei der sqrt(1-x\*x) im Nenner steht. Unsere Beispielfunktion lautet f(x)=exp(x)/sqrt(1-x\*x):

```
proc f { x } {
    expr { exp($x) / sqrt( 1. - $x*$x ) }
}
```

Die Integration erfolgt durch die Anwendung von **romberg_sine**, genau wie bei jeder anderen **romberg**-Prozedur:

```
foreach { value error } [romberg_sine f -1.0 1.0] break
puts [format "integral is %.6g +/- %.6g" $value $error]

integral is 3.97746 +/- 2.3557e-010
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: calculus* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Mathematik

# COPYRIGHT

```
Copyright (c) 2004 Kevin B. Kenny <kennykb@acm.org>. All rights reserved. Redistribution permitted under the terms of the Open Publication License <http://www.opencontent.org/openpub/>
```
