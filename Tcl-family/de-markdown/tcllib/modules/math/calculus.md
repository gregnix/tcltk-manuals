---
CommandName: math::calculus
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Tcl Math Library
Links:
 - romberg
Keywords:
 - calculus
 - differential equations
 - integration
 - math
 - roots
Copyright:
 - Copyright (c) 2002,2003,2004 Arjen Markus
---

# NAME

math::calculus – Integralrechnung und gewöhnliche Differentialgleichungen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math::calculus]{.lit} [1.1]{.lit} 
[::math::calculus::integral]{.cmd} [begin]{.arg} [end]{.arg} [nosteps]{.arg} [func]{.arg} 
[::math::calculus::integralExpr]{.cmd} [begin]{.arg} [end]{.arg} [nosteps]{.arg} [expression]{.arg} 
[::math::calculus::integral2D]{.cmd} [xinterval]{.arg} [yinterval]{.arg} [func]{.arg} 
[::math::calculus::integral2D_accurate]{.cmd} [xinterval]{.arg} [yinterval]{.arg} [func]{.arg} 
[::math::calculus::integral3D]{.cmd} [xinterval]{.arg} [yinterval]{.arg} [zinterval]{.arg} [func]{.arg} 
[::math::calculus::integral3D_accurate]{.cmd} [xinterval]{.arg} [yinterval]{.arg} [zinterval]{.arg} [func]{.arg} 
[::math::calculus::qk15]{.cmd} [xstart]{.arg} [xend]{.arg} [func]{.arg} [nosteps]{.arg} 
[::math::calculus::qk15_detailed]{.cmd} [xstart]{.arg} [xend]{.arg} [func]{.arg} [nosteps]{.arg} 
[::math::calculus::eulerStep]{.cmd} [t]{.arg} [tstep]{.arg} [xvec]{.arg} [func]{.arg} 
[::math::calculus::heunStep]{.cmd} [t]{.arg} [tstep]{.arg} [xvec]{.arg} [func]{.arg} 
[::math::calculus::rungeKuttaStep]{.cmd} [t]{.arg} [tstep]{.arg} [xvec]{.arg} [func]{.arg} 
[::math::calculus::boundaryValueSecondOrder]{.cmd} [coeff_func]{.arg} [force_func]{.arg} [leftbnd]{.arg} [rightbnd]{.arg} [nostep]{.arg} 
[::math::calculus::solveTriDiagonal]{.cmd} [acoeff]{.arg} [bcoeff]{.arg} [ccoeff]{.arg} [dvalue]{.arg} 
[::math::calculus::newtonRaphson]{.cmd} [func]{.arg} [deriv]{.arg} [initval]{.arg} 
[::math::calculus::newtonRaphsonParameters]{.cmd} [maxiter]{.arg} [tolerance]{.arg} 
[::math::calculus::regula_falsi]{.cmd} [f]{.arg} [xb]{.arg} [xe]{.arg} [eps]{.arg} 
[::math::calculus::root_bisection]{.cmd} [f]{.arg} [xb]{.arg} [xe]{.arg} [eps]{.arg} 
[::math::calculus::root_secant]{.cmd} [f]{.arg} [xb]{.arg} [xe]{.arg} [eps]{.arg} 
[::math::calculus::root_brent]{.cmd} [f]{.arg} [xb]{.arg} [xe]{.arg} [eps]{.arg} 
[::math::calculus::root_chandrupatla]{.cmd} [f]{.arg} [xb]{.arg} [xe]{.arg} [eps]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket implementiert mehrere einfache mathematische Algorithmen:

**•**
: Die Integration einer Funktion über ein Intervall

**•**
: Die numerische Integration eines Systems gewöhnlicher Differentialgleichungen.

**•**
: Die Schätzung der Nullstelle(n) einer Gleichung in einer Variablen. Das Paket ist vollständig in Tcl implementiert. Der Genauigkeit der Berechnungen wurde keine besondere Aufmerksamkeit gewidmet. Stattdessen wurden bekannte Algorithmen auf unkomplizierte Weise verwendet. Dieses Dokument beschreibt die Prozeduren und erläutert deren Anwendung.


# PROZEDUREN

Dieses Paket definiert die folgenden öffentlichen Prozeduren:

**::math::calculus::integral** *begin* *end* *nosteps* *func*
: Bestimmt das Integral der angegebenen Funktion unter Verwendung der Simpson-Regel. Das Integrationsintervall lautet \[*begin*, *end*\]. Die übrigen Argumente lauten:


*nosteps*
: Anzahl der Schritte, in die das Intervall unterteilt wird.

*func*
: Zu integrierende Funktion. Sie sollte ein einziges Argument entgegennehmen.


**::math::calculus::integralExpr** *begin* *end* *nosteps* *expression*
: Ähnlich wie die vorherige Prozedur berechnet diese das Integral des angegebenen Ausdrucks *expression* unter Verwendung der Simpson-Regel. Das Integrationsintervall lautet \[*begin*, *end*\]. Die übrigen Argumente sind:


*nosteps*
: Anzahl der Schritte, in die das Intervall unterteilt wird.

*expression*
: Zu integrierender Ausdruck. Er sollte die Variable „x“ als einzige Variable verwenden (den „Integranden“).


**::math::calculus::integral2D** *xinterval* *yinterval* *func*
: ...siehe nächstes...

**::math::calculus::integral2D_accurate** *xinterval* *yinterval* *func*
: Die Befehle **integral2D** und **integral2D_accurate** berechnen das Integral einer Funktion zweier Variablen über das Rechteck, das durch die ersten beiden Argumente vorgegeben ist, bei denen es sich jeweils um eine Liste mit drei Elementen handelt: Anfang und Ende des Intervalls für die Variable sowie die Anzahl der Schritte. Der Befehl **integral2D** wertet die Funktion im Mittelpunkt jedes Rechtecks aus, während der Befehl **integral2D_accurate** eine Vier-Punkte-Quadraturformel verwendet. Dies führt zu einer exakten Integration von Polynomen dritten Grades oder niedriger. Die Funktion muss zwei Argumente entgegennehmen und den Wert der Funktion zurückgeben.

**::math::calculus::integral3D** *xinterval* *yinterval* *zinterval* *func*
: ...siehe nächstes...

**::math::calculus::integral3D_accurate** *xinterval* *yinterval* *zinterval* *func*
: Die Befehle **integral3D** und **integral3D_accurate** entsprechen den Befehlen **integral2D** und **integral3D_accurate** im dreidimensionalen Raum. Die Funktion *func* nimmt drei Argumente entgegen und wird über den durch drei Intervalle gegebenen Block im 3D-Raum integriert.

**::math::calculus::qk15** *xstart* *xend* *func* *nosteps*
: Bestimmt das Integral der angegebenen Funktion unter Verwendung der 15-Punkte-Quadraturregel nach Gauss-Kronrod. Der Rückgabewert ist die Schätzung des Integrals über das Intervall \[*xstart*, *xend*\]. Die übrigen Argumente sind:


*func*
: Zu integrierende Funktion. Sie sollte ein einziges Argument entgegennehmen.

**?nosteps?**
: Anzahl der Schritte, in die das Intervall unterteilt wird. Der Standardwert ist 1.


**::math::calculus::qk15_detailed** *xstart* *xend* *func* *nosteps*
: Bestimmt das Integral der angegebenen Funktion unter Verwendung der 15-Punkte-Quadraturregel nach Gauss-Kronrod. Das Integrationsintervall lautet \[*xstart*, *xend*\]. Die Prozedur gibt eine Liste mit vier Werten zurück:


**•**
: Die Schätzung des Integrals über das angegebene Intervall (I).

**•**
: Eine Schätzung des absoluten Fehlers in I.

**•**
: Die Schätzung des Integrals des Betrags der Funktion über das Intervall.

**•**
: Die Schätzung des Integrals des Betrags der Funktion abzüglich ihres Mittelwerts über das Intervall.


: Die übrigen Argumente lauten wie folgt:


*func*
: Zu integrierende Funktion. Sie sollte ein einziges Argument entgegennehmen.

**?nosteps?**
: Anzahl der Schritte, in die das Intervall unterteilt wird. Der Standardwert ist 1.


**::math::calculus::eulerStep** *t* *tstep* *xvec* *func*
: Führt einen einzelnen Schritt bei der numerischen Integration eines Differentialgleichungssystems aus. Als Methode wird das Euler-Verfahren verwendet.


*t*
: Wert der unabhängigen Variablen (in der Regel die Zeit) zu Beginn des Schritts.

*tstep*
: Schrittweite für die unabhängige Variable.

*xvec*
: Liste (Vektor) abhängiger Werte

*func*
: Funktion von t und den abhängigen Werten, die eine Liste der Ableitungen der abhängigen Werte zurückgibt. (Die Längen von xvec und des Rückgabewerts von „func“ müssen übereinstimmen.)


**::math::calculus::heunStep** *t* *tstep* *xvec* *func*
: Führt einen einzelnen Schritt bei der numerischen Integration eines Differentialgleichungssystems aus. Als Methode wird das Heun-Verfahren verwendet.


*t*
: Wert der unabhängigen Variablen (in der Regel die Zeit) zu Beginn des Schritts.

*tstep*
: Schrittweite für die unabhängige Variable.

*xvec*
: Liste (Vektor) abhängiger Werte

*func*
: Funktion von t und den abhängigen Werten, die eine Liste der Ableitungen der abhängigen Werte zurückgibt. (Die Längen von xvec und des Rückgabewerts von „func“ müssen übereinstimmen.)


**::math::calculus::rungeKuttaStep** *t* *tstep* *xvec* *func*
: Führt einen einzelnen Schritt bei der numerischen Integration eines Differentialgleichungssystems aus. Als Methode wird die Runge-Kutta-Methode 4. Ordnung verwendet.


*t*
: Wert der unabhängigen Variablen (in der Regel die Zeit) zu Beginn des Schritts.

*tstep*
: Schrittweite für die unabhängige Variable.

*xvec*
: Liste (Vektor) abhängiger Werte

*func*
: Funktion von t und den abhängigen Werten, die eine Liste der Ableitungen der abhängigen Werte zurückgibt. (Die Längen von xvec und des Rückgabewerts von „func“ müssen übereinstimmen.)


**::math::calculus::boundaryValueSecondOrder** *coeff_func* *force_func* *leftbnd* *rightbnd* *nostep*
: Löst eine lineare Differentialgleichung zweiter Ordnung mit Randwerten an beiden Seiten. Die Gleichung muss folgende Form haben (die „konservative“ Form):


```
         d      dy     d
         -- A(x)--  +  -- B(x)y + C(x)y  =  D(x)
         dx     dx     dx
```

: Normalerweise würde eine solche Gleichung wie folgt geschrieben werden:


```
             d2y        dy
         a(x)---  + b(x)-- + c(x) y  =  D(x)
             dx2        dx
```

: Die erste Form lässt sich leichter diskretisieren (durch Integration über ein endliches Volumen) als die zweite Form. Der Zusammenhang zwischen den beiden Formen ist recht einfach:


```
         A(x)  =  a(x)
         B(x)  =  b(x) - a'(x)
         C(x)  =  c(x) - B'(x)  =  c(x) - b'(x) + a''(x)
```

: Wegen der Differentiation ist es jedoch wesentlich einfacher, den Benutzer zu bitten, die Funktionen A, B und C direkt anzugeben.


*coeff_func*
: Prozedur, die die drei Koeffizienten (A, B, C) der Gleichung zurückgibt und als einziges Argument die x-Koordinate entgegennimmt.

*force_func*
: Prozedur, die die rechte Seite (D) als Funktion der x-Koordinate zurückgibt.

*leftbnd*
: Eine Liste mit zwei Werten: die x-Koordinate der linken Grenze und der Wert an dieser Grenze.

*rightbnd*
: Eine Liste mit zwei Werten: die x-Koordinate der rechten Grenze und der Wert an dieser Grenze.

*nostep*
: Anzahl der Schritte, in die das Intervall unterteilt werden soll. Die Prozedur gibt eine Liste der x-Koordinaten und der Näherungswerte der Lösung zurück.


**::math::calculus::solveTriDiagonal** *acoeff* *bcoeff* *ccoeff* *dvalue*
: Löst ein System linearer Gleichungen Ax = b, wobei A eine tridiagonale Matrix ist. Gibt die Lösung als Liste zurück.


*acoeff*
: Liste der Werte auf der unteren Diagonalen

*bcoeff*
: Liste der Werte auf der Hauptdiagonalen

*ccoeff*
: Liste der Werte auf der oberen Diagonalen

*dvalue*
: Liste der Werte auf der rechten Seite


**::math::calculus::newtonRaphson** *func* *deriv* *initval*
: Bestimmt die Nullstelle einer Gleichung der Form


```
    func(x) = 0
```

: unter Verwendung der Newton-Raphson-Methode. Die Prozedur benötigt die folgenden Argumente:


*func*
: Prozedur, die den Wert der Funktion an der Stelle x zurückgibt

*deriv*
: Prozedur, die die Ableitung der Funktion an der Stelle x zurückgibt

*initval*
: Anfangswert für x


**::math::calculus::newtonRaphsonParameters** *maxiter* *tolerance*
: Legt die numerischen Parameter für die Newton-Raphson-Methode fest:


*maxiter*
: Maximale Anzahl der Iterationsschritte (Standardwert: 20)

*tolerance*
: Relative Genauigkeit (Standardwert: 0.001)


**::math::calculus::regula_falsi** *f* *xb* *xe* *eps*
: Gibt eine Schätzung der Nullstelle bzw. einer der Nullstellen der Funktion zurück, die im Intervall \[xb,xe\] liegt. Der Fehler dieser Schätzung liegt in der Größenordnung von eps\*abs(xe-xb), wobei der tatsächliche Fehler geringfügig größer sein kann. Die verwendete Methode ist die sogenannte *regula falsi* (*false position*). Es handelt sich um eine unkomplizierte Implementierung. Die Methode ist robust, setzt jedoch voraus, dass das Intervall eine Nullstelle oder zumindest eine ungerade Anzahl von Nullstellen einschließt, sodass der Wert der Funktion am Anfang ein anderes Vorzeichen hat als der Wert am Ende. Im Gegensatz zum Newton-Raphson-Verfahren ist die Berechnung der Ableitung der Funktion nicht erforderlich.


command *f*
: Name des Befehls, der die Funktion auswertet, deren Nullstelle zurückgegeben werden soll

float *xb*
: Beginn des Intervalls, in dem die Nullstelle liegen soll

float *xe*
: Ende des Intervalls

float *eps*
: Zulässiger relativer Fehler (Standardwert: 1.0e-4)


**::math::calculus::root_bisection** *f* *xb* *xe* *eps*
: Gibt eine Schätzung der Nullstelle bzw. einer der Nullstellen der Funktion zurück, die im Intervall \[xb,xe\] liegt. Der Fehler dieser Schätzung liegt in der Größenordnung von eps\*abs(xe-xb); der tatsächliche Fehler kann geringfügig größer sein. Als Methode wird die sogenannte *Bisektion* verwendet. Zu den Eigenschaften siehe die *regula falsi*-Prozedur.


command *f*
: Name des Befehls, der die Funktion auswertet, deren Nullstelle zurückgegeben werden soll

float *xb*
: Beginn des Intervalls, in dem die Nullstelle liegen soll

float *xe*
: Ende des Intervalls

float *eps*
: Zulässiger relativer Fehler (Standardwert: 1.0e-7)


**::math::calculus::root_secant** *f* *xb* *xe* *eps*
: Gibt eine Schätzung der Nullstelle bzw. einer der Nullstellen der Funktion im Intervall \[xb,xe\] zurück. Der Fehler dieser Schätzung liegt in der Größenordnung von eps\*abs(xe-xb); der tatsächliche Fehler kann geringfügig größer sein. Als Methode wird die sogenannte *Sekantenmethode* verwendet. Zu den Eigenschaften: siehe die *regula falsi*-Prozedur. Hinweis: Diese Methode liefert nicht garantiert eine Nullstelle, ist aber schnell.


command *f*
: Name des Befehls, der die Funktion auswertet, deren Nullstelle zurückgegeben werden soll

float *xb*
: Beginn des Intervalls, in dem die Nullstelle liegen soll

float *xe*
: Ende des Intervalls

float *eps*
: Zulässiger relativer Fehler (Standardwert: 1.0e-7)


**::math::calculus::root_brent** *f* *xb* *xe* *eps*
: Gibt eine Schätzung der Nullstelle bzw. einer der Nullstellen der Funktion im Intervall \[xb,xe\] zurück. Der Fehler dieser Schätzung liegt in der Größenordnung von eps\*abs(xe-xb); der tatsächliche Fehler kann geringfügig größer sein. Als Methode wird die sogenannte *Brent*-Methode verwendet. Zu den Eigenschaften: siehe die *regula falsi*-Prozedur.


command *f*
: Name des Befehls, der die Funktion auswertet, deren Nullstelle zurückgegeben werden soll

float *xb*
: Beginn des Intervalls, in dem die Nullstelle liegen soll

float *xe*
: Ende des Intervalls

float *eps*
: Zulässiger relativer Fehler (Standardwert: 1.0e-7)


**::math::calculus::root_chandrupatla** *f* *xb* *xe* *eps*
: Gibt eine Schätzung der Nullstelle bzw. einer der Nullstellen der Funktion im Intervall \[xb,xe\] zurück. Der Fehler dieser Schätzung liegt in der Größenordnung von eps\*abs(xe-xb); der tatsächliche Fehler kann geringfügig größer sein. Die verwendete Methode ist die sogenannte *Chandrupatla*-Methode. Sie ist eine Variante der Brent-Methode und gilt als schneller. Eine Erörterung finden Sie unter *https://www.embeddedrelated.com/showarticle/855.php*.


command *f*
: Name des Befehls, der die Funktion auswertet, deren Nullstelle zurückgegeben werden soll

float *xb*
: Beginn des Intervalls, in dem die Nullstelle liegen soll

float *xe*
: Ende des Intervalls

float *eps*
: Zulässiger relativer Fehler (Standardwert: 1.0e-7)


*Notes:*

Einige der oben genannten Prozeduren nehmen die *Namen* von Prozeduren als Argumente entgegen. Um Probleme mit der *Sichtbarkeit* dieser Prozeduren zu vermeiden, wird der vollqualifizierte Name dieser Prozeduren innerhalb der calculus-Routinen ermittelt. Für den Benutzer hat dies nur eine Konsequenz: Die benannte Prozedur muss in der aufrufenden Prozedur sichtbar sein. Zum Beispiel:

```
    namespace eval ::mySpace {
       namespace export calcfunc
       proc calcfunc { x } { return $x }
    }
    #
    # Use a fully-qualified name
    #
    namespace eval ::myCalc {
       proc detIntegral { begin end } {
          return [integral $begin $end 100 ::mySpace::calcfunc]
       }
    }
    #
    # Import the name
    #
    namespace eval ::myCalc {
       namespace import ::mySpace::calcfunc
       proc detIntegral { begin end } {
          return [integral $begin $end 100 calcfunc]
       }
    }
```

Erweiterungen für das Randwertproblem zweiter Ordnung:

**•**
: Andere Arten von Randbedingungen (Nullgradient, Nullfluss)

**•**
: Eine weitere Schematisierung des Terms erster Ordnung (derzeit werden zentrale Differenzen verwendet, doch könnten auch stromaufwärts gerichtete Differenzen sinnvoll sein).

**•**
: Die verschiedenen Methoden zur Nullstellenbestimmung unterscheiden sich hinsichtlich ihrer Robustheit, Benutzerfreundlichkeit und Konvergenzgeschwindigkeit. Das Newton-Raphson-Verfahren ist zwar recht schnell (quadratische Konvergenz), liefert jedoch nicht garantiert ein Ergebnis. Die Methoden, die die Nullstelle in einem Intervall einschließen, erfordern zwei Startpunkte, liefern jedoch – mit Ausnahme des Sekantenverfahrens – garantiert eine gute Schätzung.


# BEISPIELE

Lassen Sie uns einige einfache Beispiele betrachten:

Integrieren Sie x über das Intervall \[0,100\] (20 Schritte):

```
proc linear_func { x } { return $x }
puts "Integral: [::math::calculus::integral 0 100 20 linear_func]"
```

Bei einfachen Funktionen könnte die Alternative wie folgt lauten:

```
puts "Integral: [::math::calculus::integralExpr 0 100 20 {$x}]"
```

Vergessen Sie die geschweiften Klammern nicht!

Die Differentialgleichung für einen gedämpften Oszillator:

```
x'' + rx' + wx = 0
```

lässt sich in ein System von Gleichungen erster Ordnung zerlegen:

```
x' = y
y' = -ry - wx
```

Dann lässt sich dieses System mit folgendem Code lösen:

```
proc dampened_oscillator { t xvec } {
   set x  [lindex $xvec 0]
   set x1 [lindex $xvec 1]
   return [list $x1 [expr {-$x1-$x}]]
}

set xvec   { 1.0 0.0 }
set t      0.0
set tstep  0.1
for { set i 0 } { $i < 20 } { incr i } {
   set result [::math::calculus::eulerStep $t $tstep $xvec dampened_oscillator]
   puts "Result ($t): $result"
   set t      [expr {$t+$tstep}]
   set xvec   $result
}
```

Nehmen wir an, wir haben das Randwertproblem:

```
    Dy'' + ky = 0
    x = 0: y = 1
    x = L: y = 0
```

Dieses Randwertproblem könnte auf die Diffusion einer zerfallenden Substanz zurückzuführen sein.

Das lässt sich mit dem folgenden Fragment lösen:

```
   proc coeffs { x } { return [list $::Diff 0.0 $::decay] }
   proc force  { x } { return 0.0 }

   set Diff   1.0e-2
   set decay  0.0001
   set length 100.0

   set y [::math::calculus::boundaryValueSecondOrder \
      coeffs force {0.0 1.0} [list $length 0.0] 100]
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: calculus* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Mathematik

# COPYRIGHT

```
Copyright (c) 2002,2003,2004 Arjen Markus
```
