---
CommandName: math::interpolate
ManualSection: n
Version: 1.1.4
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - interpolation
 - math
 - spatial interpolation
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
 - Copyright (c) 2004 Kevn B. Kenny <kennykb@users.sourceforge.net>
---

# NAME

math::interpolate – Interpolationsroutinen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [?8.5]{.lit} [9?]{.lit} 
[package]{.cmd} [require]{.sub} [struct]{.lit} 
[package]{.cmd} [require]{.sub} [math::interpolate]{.lit} [1.1.4]{.optlit} 
[::math::interpolate::defineTable]{.cmd} [name]{.arg} [colnames]{.arg} [values]{.arg} 
[::math::interpolate::interp-1d-table]{.cmd} [name]{.arg} [xval]{.arg} 
[::math::interpolate::interp-table]{.cmd} [name]{.arg} [xval]{.arg} [yval]{.arg} 
[::math::interpolate::interp-linear]{.cmd} [xyvalues]{.arg} [xval]{.arg} 
[::math::interpolate::interp-lagrange]{.cmd} [xyvalues]{.arg} [xval]{.arg} 
[::math::interpolate::prepare-cubic-splines]{.cmd} [xcoord]{.arg} [ycoord]{.arg} 
[::math::interpolate::interp-cubic-splines]{.cmd} [coeffs]{.arg} [x]{.arg} 
[::math::interpolate::interp-spatial]{.cmd} [xyvalues]{.arg} [coord]{.arg} 
[::math::interpolate::interp-spatial-params]{.cmd} [max_search]{.arg} [power]{.arg} 
[::math::interpolate::neville]{.cmd} [xlist]{.arg} [ylist]{.arg} [x]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket implementiert mehrere Interpolationsalgorithmen:

**•**
: Interpolation in einer Tabelle (eine oder zwei unabhängige Variablen); dies ist beispielsweise nützlich, wenn die Daten statisch sind, wie bei Tabellen mit statistischen Funktionen.

**•**
: Lineare Interpolation anhand eines vorgegebenen Datensatzes (als (x, y)-Paare organisiert).

**•**
: Lagrange-Interpolation. Diese ist vor allem von theoretischem Interesse, da keine Garantie hinsichtlich der Fehlergrenzen besteht. Eine mögliche Anwendung: Wenn Sie eine Gerade oder eine Parabel durch vorgegebene Punkte benötigen (die Werte werden berechnet, die Koeffizienten jedoch nicht zurückgegeben). Eine Variante ist die Neville-Methode, die ein besseres Verhalten und bessere Fehlergrenzen aufweist.

**•**
: Räumliche Interpolation unter Verwendung einer einfachen abstandsgewichteten Methode. Diese Prozedur lässt eine beliebige Anzahl räumlicher Dimensionen und eine beliebige Anzahl abhängiger Variablen zu.

**•**
: Eindimensionale Interpolation unter Verwendung kubischer Splines. In diesem Dokument werden die Prozeduren beschrieben und deren Anwendung erläutert.


# INKOMPATIBILITÄT MIT VERSION 1.0.3

Die Interpretation der Tabellen im Befehl **::math::interpolate::interpolate-1d-table** wurde geändert, um die Kompatibilität mit der Interpretation für die 2D-Interpolation im Befehl **::math::interpolate::interpolate-table** zu gewährleisten. Infolgedessen ist diese Version nicht kompatibel mit den früheren Versionen des Befehls (1.0.x).

# PROZEDUREN

Das Interpolationspaket definiert die folgenden öffentlichen Prozeduren:

**::math::interpolate::defineTable** *name* *colnames* *values*
: Definiert eine Tabelle mit einer oder zwei unabhängigen Variablen (die Unterscheidung ergibt sich implizit aus den Daten). Die Prozedur gibt den Namen der Tabelle zurück – dieser Name wird immer dann verwendet, wenn Sie die Werte interpolieren möchten. *Hinweis:* Diese Prozedur ist eine praktische Hülle für die Prozedur struct::matrix. Daher können Sie an jeder beliebigen Stelle in Ihrem Programm auf die Daten zugreifen.


string *name* (in)
: Name der zu erstellenden Tabelle

list *colnames* (in)
: Liste der Namen der Spalten

list *values* (in)
: Liste der Werte (die Anzahl der Elemente sollte ein Vielfaches der Anzahl der Spalten sein. Weitere Informationen zur Interpretation der Daten finden Sie im Abschnitt **BEISPIELE**. Die Werte müssen nach den unabhängigen Variablen sortiert sein.)


**::math::interpolate::interp-1d-table** *name* *xval*
: Interpoliert in der eindimensionalen Tabelle „name“ und gibt eine Liste von Werten zurück, jeweils einen für jede abhängige Spalte.


string *name* (in)
: Name einer vorhandenen Tabelle

float *xval* (in)
: Wert der unabhängigen *Zeilen*-Variablen


**::math::interpolate::interp-table** *name* *xval* *yval*
: Interpoliert in der zweidimensionalen Tabelle „name“ und gibt den interpolierten Wert zurück.


string *name* (in)
: Name einer vorhandenen Tabelle

float *xval* (in)
: Wert der unabhängigen *Zeilen*-Variablen

float *yval* (in)
: Wert der unabhängigen *Spalten*-Variablen


**::math::interpolate::interp-linear** *xyvalues* *xval*
: Interpoliert linear in der Liste der (x,y)-Paare und gibt den interpolierten Wert zurück.


list *xyvalues* (in)
: Liste von (x, y)-Wertepaaren, sortiert nach steigendem x. Sie dienen als Knickpunkte einer stückweise linearen Funktion.

float *xval* (in)
: Wert der unabhängigen Variablen, für den der Wert von y berechnet werden muss.


**::math::interpolate::interp-lagrange** *xyvalues* *xval*
: Konstruiert anhand der Liste der (x,y)-Paare das eindeutige Polynom niedrigsten Grades, das durch alle Punkte verläuft, und gibt den interpolierten Wert zurück.


list *xyvalues* (in)
: Liste der (x, y)-Wertepaare

float *xval* (in)
: Wert der unabhängigen Variablen, für den der Wert von y berechnet werden muss.


**::math::interpolate::prepare-cubic-splines** *xcoord* *ycoord*
: Gibt eine Liste von Koeffizienten zurück, mit denen die zweite Routine *interp-cubic-splines* die eigentliche Interpolation durchführt.


list *xcoord*
: Liste der x-Koordinaten, an denen der Wert der zu interpolierenden Funktion bekannt ist. Die Koordinaten müssen streng aufsteigend sein. Es sind mindestens drei Punkte erforderlich.

list *ycoord*
: Liste der y-Koordinaten (die Werte der Funktion bei den angegebenen x-Koordinaten).


**::math::interpolate::interp-cubic-splines** *coeffs* *x*
: Gibt den interpolierten Wert an der Koordinate x zurück. Die Koeffizienten werden durch die Prozedur *prepare-cubic-splines* berechnet.


list *coeffs*
: Liste der Koeffizienten, wie sie von prepare-cubic-splines zurückgegeben werden

float *x*
: x-Koordinate, an der die Funktion geschätzt werden soll. Sie muss zwischen der ersten und der letzten x-Koordinate liegen, für die Werte angegeben wurden.


**::math::interpolate::interp-spatial** *xyvalues* *coord*
: Verwendet eine einfache Interpolationsmethode mit Gewichten als Funktion des Kehrwerts des Abstands, um im 2D- und N-dimensionalen Raum zu interpolieren. Die Liste xyvalues ist eine Liste von Listen:


```
    {   {x1 y1 z1 {v11 v12 v13 v14}}
	{x2 y2 z2 {v21 v22 v23 v24}}
	...
    }
```

: Das letzte Element jeder inneren Liste ist entweder eine einzelne Zahl oder selbst eine Liste. Im letzteren Fall gibt die Methode einen Wert zurück, der eine Liste mit derselben Anzahl von Elementen enthält. Die Methode wird durch den Suchradius und die Potenz des inversen Abstands beeinflusst.


list *xyvalues* (in)
: Liste von Listen, wobei jede Unterliste eine Liste von Koordinaten und abhängigen Werten darstellt.

list *coord* (in)
: Liste der Koordinaten, für die die Werte berechnet werden müssen


**::math::interpolate::interp-spatial-params** *max_search* *power*
: Legt die Parameter für die räumliche Interpolation fest


float *max_search* (in)
: Suchradius (Datenpunkte, die weiter entfernt liegen, werden ignoriert)

integer *power* (in)
: Exponent für den Abstand (entweder 1 oder 2; Standardwert ist 2)


**::math::interpolate::neville** *xlist* *ylist* *x*
: Führt eine Interpolation zwischen den tabellierten Werten einer Funktion durch, deren Abszissen *xlist* und deren Ordinaten *ylist* sind, um einen Schätzwert für den Wert der Funktion bei *x* zu ermitteln.  Das Ergebnis ist eine Liste mit zwei Elementen; das erste Element ist der geschätzte Wert der Funktion, das zweite ist eine Schätzung des absoluten Fehlers des Ergebnisses.  Es wird der Algorithmus von Neville für die Polynominterpolation verwendet.  Hinweis: Bei einer großen Tabelle mit Werten wird ein Interpolationspolynom hohen Grades verwendet, was wahrscheinlich zu numerischen Instabilitäten führt; es ist ratsam, nur wenige tabellierte Werte in der Nähe der gewünschten Abszisse zu verwenden.


# BEISPIELE

*Example of using one-dimensional tables:*

Angenommen, Sie haben mehrere tabellarisch aufgeführte Funktionen einer Variablen:

```
    x     y1     y2
  0.0    0.0    0.0
  1.0    1.0    1.0
  2.0    4.0    8.0
  3.0    9.0   27.0
  4.0   16.0   64.0
```

Um nun die Werte bei 0,5, 1,5, 2,5 und 3,5 zu berechnen, können Sie Folgendes verwenden:

```
   set table [::math::interpolate::defineTable table1  {x y1 y2} {   -      1      2
                   0.0    0.0    0.0
                   1.0    1.0    1.0
                   2.0    4.0    8.0
                   3.0    9.0   27.0
                   4.0   16.0   64.0}]
   foreach x {0.5 1.5 2.5 3.5} {
       puts "$x: [::math::interpolate::interp-1d-table $table $x]"
   }
```

Bei eindimensionalen Tabellen wird die erste Zeile nicht verwendet. Bei zweidimensionalen Tabellen enthält die erste Zeile die Werte für die zweite unabhängige Variable.

*Example of using the cubic splines:*

Angenommen, es liegen folgende Werte vor:

```
    x       y
  0.1     1.0
  0.3     2.1
  0.4     2.2
  0.8     4.11
  1.0     4.12
```

Um nun die Werte bei 0,1, 0,2, 0,3, … 1,0 zu schätzen, können Sie Folgendes verwenden:

```
   set coeffs [::math::interpolate::prepare-cubic-splines  {0.1 0.3 0.4 0.8  1.0}  {1.0 2.1 2.2 4.11 4.12}]
   foreach x {0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0} {
      puts "$x: [::math::interpolate::interp-cubic-splines $coeffs $x]"
   }
```

um die folgende Ausgabe zu erhalten:

```
0.1: 1.0
0.2: 1.68044117647
0.3: 2.1
0.4: 2.2
0.5: 3.11221507353
0.6: 4.25242647059
0.7: 5.41804227941
0.8: 4.11
0.9: 3.95675857843
1.0: 4.12
```

Wie Sie sehen, werden die Werte an den Abszissen exakt wiedergegeben.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: interpolate* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Mathematik

# COPYRIGHT

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
Copyright (c) 2004 Kevn B. Kenny <kennykb@users.sourceforge.net>
```
