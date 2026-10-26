---
CommandName: simulation::annealing
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Tcl Simulation Tools
Keywords:
 - math
 - optimization
 - simulated annealing
Copyright:
 - Copyright (c) 2008 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# NAME

simulation::annealing – Simuliertes Annealing

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [?8.5]{.lit} [9?]{.lit} 
[package]{.cmd} [require]{.sub} [simulation::annealing]{.lit} [0.3]{.lit} 
[::simulation::annealing::getOption]{.cmd} [keyword]{.arg} 
[::simulation::annealing::hasOption]{.cmd} [keyword]{.arg} 
[::simulation::annealing::setOption]{.cmd} [keyword]{.arg} [value]{.arg} 
[::simulation::annealing::findMinimum]{.cmd} [args]{.arg} 
[::simulation::annealing::findCombinatorialMinimum]{.cmd} [args]{.arg} 
:::

# BESCHREIBUNG

Die Technik des *Simulated Annealing* bietet Methoden zur Schätzung des globalen Optimums einer Funktion. Sie wird auf der Wiki-Seite *http://wiki.tcl.tk/...* ausführlich beschrieben. Die Idee ist einfach:

**•**
: Punkte innerhalb eines vorgegebenen Suchraums zufällig auswählen

**•**
: Die Auswertung der zu optimierenden Funktion für jeden dieser Punkte durchführen und den Punkt auswählen, der den niedrigsten (oder höchsten) Wert aufweist, oder – in manchen Fällen – einen Punkt akzeptieren, der einen weniger optimalen Wert aufweist. Die Wahrscheinlichkeit, dass ein solcher nicht-optimaler Punkt akzeptiert wird, nimmt mit der Zeit ab.

**•**
: Die Akzeptanz von weniger optimalen Punkten bedeutet, dass die Methode nicht zwangsläufig in einem lokalen Optimum stecken bleibt und theoretisch in der Lage ist, das globale Optimum innerhalb des Suchraums zu finden. Die Methode ähnelt dem Abkühlen von Material, daher der Name. Das Paket *simulation::annealing* bietet den Befehl *findMinimum*:


```
    puts [::simulation::annealing::findMinimum  -trials 300  -parameters {x -5.0 5.0 y -5.0 5.0}  -function {$x*$x+$y*$y+sin(10.0*$x)+4.0*cos(20.0*$y)}]
```

gibt den geschätzten Minimalwert der Funktion f(x,y) = *x\*\*2+y\*\*2+sin(10\*x)+4\*cos(20\*y)* sowie die Werte von x und y aus, bei denen das Minimum erreicht wurde:

```
result -4.9112922923 x -0.181647676593 y 0.155743646974
```

# PROZEDUREN

Das Paket definiert die folgenden Hilfsprozeduren:

**::simulation::annealing::getOption** *keyword*
: Ruft den Wert einer Option ab, die als Teil des Befehls *findMinimum* angegeben wurde.


string *keyword*
: Angegebenes Schlüsselwort (ohne vorangestelltes Minuszeichen)


**::simulation::annealing::hasOption** *keyword*
: Gibt 1 zurück, wenn die Option vorhanden ist, andernfalls 0.


string *keyword*
: Angegebenes Schlüsselwort (ohne vorangestelltes Minuszeichen)


**::simulation::annealing::setOption** *keyword* *value*
: Setzt den Wert der angegebenen Option.


string *keyword*
: Angegebenes Schlüsselwort (ohne vorangestelltes Minuszeichen)

string *value*
: (Neuer) Wert der Option


Die wichtigsten Prozeduren sind *findMinimum* und *findCombinatorialMinimum*:

**::simulation::annealing::findMinimum** *args*
: Ermittelt das Minimum einer Funktion mithilfe von Simulated Annealing. Die Funktion und die Parameter des Verfahrens werden über eine Liste von Schlüsselwort-Wert-Paaren vorgegeben.


int *n*
: Liste von Schlüsselwort-Wert-Paaren, die während der Ausführung alle über den Befehl *getOption* abrufbar sind.


**::simulation::annealing::findCombinatorialMinimum** *args*
: Ermittelt das Minimum einer Funktion diskreter Variablen mithilfe von Simulated Annealing. Die Funktion und die Parameter des Verfahrens werden über eine Liste von Schlüsselwort-Wert-Paaren vorgegeben.


int *n*
: Liste von Schlüsselwort-Wert-Paaren, die während der Ausführung alle über den Befehl *getOption* abrufbar sind.


Der Befehl *findMinimum* enthält die folgenden vordefinierten Optionen:

**•**
: *-parameters list*: Tripel, die Parameter und Bereiche festlegen

**•**
: *-function expr*: Ausdruck, der die Funktion definiert

**•**
: *-code body*: Prozedurrumpf, der die Funktion definiert (hat Vorrang vor *-function*). Der Code soll die Variable „result“ setzen

**•**
: *-init code*: Code, der zu Beginn ausgeführt wird *-final code*: Code, der am Ende ausgeführt wird *-trials n*: Anzahl der Versuche, bevor die Temperatur gesenkt wird *-reduce factor*: senkt die Temperatur um diesen Faktor (zwischen 0 und 1) *-initial-temp t*: Anfangstemperatur *-scale s*: Skala der Funktion (Größenordnung der Werte) *-estimate-scale y/n*: schätzt die Skala (nur wenn *-scale* fehlt) *-verbose y/n*: gibt ausführliche Fortschrittsinformationen in die Berichtsdatei aus (1) oder nicht (0) *-reportfile file*: geöffnete Datei für die Ausgabe (Voreinstellung stdout) Alle weiteren Optionen lassen sich über die Prozedur getOption im Prozedurrumpf verwenden. Der Befehl *findCombinatorialMinimum* gibt die folgenden Optionen vor:

**•**
: *-number-params n*: Anzahl der binären Parameter (der Lösungsraum besteht aus Listen aus Einsen und Nullen). Dies ist eine erforderliche Option.

**•**
: *-initial-values*: Eine Liste aus Einsen und Nullen, die den Anfang der Suche bildet. Die übrigen vordefinierten Optionen entsprechen denen von *findMinimum*.


# TIPPS

Die Prozedur *findMinimum* funktioniert, indem sie eine temporäre Prozedur erstellt, die die eigentliche Arbeit übernimmt. Sie durchläuft eine Schleife, bis sich der Punkt, der das geschätzte Optimum darstellt, innerhalb der vorgegebenen Anzahl von Versuchen nicht mehr ändert. Da die Temperatur immer weiter sinkt, verringert sich auch die Wahrscheinlichkeit, einen Punkt mit einem höheren Wert zu akzeptieren, sodass die Prozedur in der Praxis beendet wird.

Es ist möglich, über einen nicht rechteckigen Bereich zu optimieren, doch ist dabei gewisse Vorsicht geboten:

**•**
: Wenn der Punkt außerhalb des Untersuchungsbereichs liegt, können Sie einen sehr hohen Wert festlegen.

**•**
: Dies bedeutet, dass eine automatische Bestimmung eines Skalierungsfaktors nicht in Frage kommt – die hohen Werte der Funktionen, die den Punkt in den Bereich hineinzwingen, würden die Schätzung verfälschen. Hier sind Beispiele für die Suche nach einem Optimum innerhalb eines Kreises:


```
    puts [::simulation::annealing::findMinimum  -trials 3000  -reduce 0.98  -parameters {x -5.0 5.0 y -5.0 5.0}  -code {
            if { hypot($x-5.0,$y-5.0) < 4.0 } {
                set result [expr {$x*$x+$y*$y+sin(10.0*$x)+4.0*cos(20.0*$y)}]
            } else {
                set result 1.0e100
            }
        }]
```

Die Methode ist theoretisch in der Lage, das globale Optimum zu ermitteln; häufig sind jedoch eine große Anzahl von Versuchen und eine langsame Absenkung der Temperatur erforderlich, um zuverlässige und reproduzierbare Schätzwerte zu erhalten.

Sie können die Option *-final* verwenden, um eine deterministische Optimierungsmethode anzuwenden, sobald Sie sicher sind, dass Sie sich in der Nähe des gewünschten Optimums befinden.

Die Prozedur *findCombinatorialMinimum* eignet sich für Fälle, in denen die Parameter die Werte 0 oder 1 annehmen (und es kann viele davon geben). Hier ein Beispiel:

**•**
: Wir haben eine Funktion, die ein absolutes Minimum erreicht, wenn die ersten zehn Zahlen 1 und die übrigen 0 sind:


```
proc cost {params} {
    set cost 0
    foreach p [lrange $params 0 9] {
        if { $p == 0 } {
            incr cost
        }
    }
    foreach p [lrange $params 10 end] {
        if { $p == 1 } {
            incr cost
        }
    }
    return $cost
}
```

**•**
: Wir möchten die Lösung finden, die dieses Minimum für verschiedene Längen des Lösungsvektors *params* liefert:


```
foreach n {100 1000 10000} {
    break
    puts "Problem size: $n"
    puts [::simulation::annealing::findCombinatorialMinimum  -trials 300  -verbose 0  -number-params $n  -code {set result [cost $params]}]
}
```

**•**
: Mit zunehmender Vektorgröße steigt die Rechenzeit, doch die Prozedur endet, sobald eine Art Gleichgewicht erreicht ist. Für eine brauchbare Lösung können verschiedene Werte des Parameters trials ausprobiert werden. Außerdem sollte die zu minimierende Funktion von allen oder den meisten Parametern abhängen; ein Gegenbeispiel steht im Quellcode und sollte ausgeführt werden.


# KATEGORIE

Mathematik

# COPYRIGHT

```
Copyright (c) 2008 Arjen Markus <arjenmarkus@users.sourceforge.net>
```
