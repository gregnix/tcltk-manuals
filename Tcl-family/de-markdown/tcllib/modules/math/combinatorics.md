---
CommandName: math::combinatorics
ManualSection: n
Version: 2.1
TclPart: tcllib
TclDescription: Tcl Math Library
Copyright:
---

# NAME

math::combinatorics – Kombinatorische Funktionen in der Tcl-Mathematikbibliothek

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math]{.lit} [1.2.6]{.optlit} 
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [math::combinatorics]{.lit} [2.1]{.optlit} 
[::math::ln_Gamma]{.cmd} [z]{.arg} 
[::math::factorial]{.cmd} [x]{.arg} 
[::math::choose]{.cmd} [n]{.arg} [k]{.arg} 
[::math::Beta]{.cmd} [z]{.arg} [w]{.arg} 
[::math::combinatorics::permutations]{.cmd} [n]{.arg} 
[::math::combinatorics::variations]{.cmd} [n]{.arg} [k]{.arg} 
[::math::combinatorics::combinations]{.cmd} [n]{.arg} [k]{.arg} 
[::math::combinatorics::derangements]{.cmd} [n]{.arg} 
[::math::combinatorics::catalan]{.cmd} [n]{.arg} 
[::math::combinatorics::firstStirling]{.cmd} [n]{.arg} [m]{.arg} 
[::math::combinatorics::secondStirling]{.cmd} [n]{.arg} [m]{.arg} 
[::math::combinatorics::partitionP]{.cmd} [n]{.arg} 
[::math::combinatorics::list-permutations]{.cmd} [n]{.arg} 
[::math::combinatorics::list-variations]{.cmd} [n]{.arg} [k]{.arg} 
[::math::combinatorics::list-combinations]{.cmd} [n]{.arg} [k]{.arg} 
[::math::combinatorics::list-derangements]{.cmd} [n]{.arg} 
[::math::combinatorics::list-powerset]{.cmd} [n]{.arg} 
[::math::combinatorics::permutationObj]{.cmd} new/create NAME [n]{.arg} 
[\$perm]{.cmd} next 
[\$perm]{.cmd} reset 
[\$perm]{.cmd} setElements [elements]{.arg} 
[\$perm]{.cmd} setElements 
[::math::combinatorics::combinationObj]{.cmd} new/create NAME [n]{.arg} [k]{.arg} 
[\$combin]{.cmd} next 
[\$combin]{.cmd} reset 
[\$combin]{.cmd} setElements [elements]{.arg} 
[\$combin]{.cmd} setElements 
:::

# BESCHREIBUNG

Das Paket **math** enthält Implementierungen verschiedener Funktionen, die bei kombinatorischen Problemen nützlich sind. Das Paket **math::combinatorics** erweitert diese Sammlung um Funktionen, die auf Merkmalen von Tcl 8.6 beruhen. Hinweis: Die Bedeutung der Funktion „partitionP“ sowie der Catalan- und Stirling-Zahlen wird auf der [MathWorld-Website](http://mathworld.wolfram.com) erläutert.

# BEFEHLE

**::math::ln_Gamma** *z*
: Gibt den natürlichen Logarithmus der Gammafunktion für das Argument *z* zurück. Die Gammafunktion ist definiert als das uneigentliche Integral von Null bis zum positiven Unendlichen von


```
  t**(x-1)*exp(-t) dt
```

Die in der Tcl-Mathematikbibliothek verwendete Approximation stammt von Lanczos, *ISIAM J. Numerical Analysis, Serie B*, Band 1, S. 86. Für „**x** > 1“ wird angegeben, dass der absolute Fehler des Ergebnisses kleiner als 5,5\*10\*\*-10 ist – das heißt, der resultierende Wert von Gamma, wenn

```
  exp( ln_Gamma( x) )
```

: berechnet wird, ist voraussichtlich auf mehr als neun signifikante Stellen genau.


**::math::factorial** *x*
: Gibt die Fakultät des Arguments *x* zurück. Für ganzzahlige Werte von *x* im Bereich 0 <= *x* <= 12 wird ein exaktes ganzzahliges Ergebnis zurückgegeben. Für ganzzahlige Werte von *x* im Bereich 13 <= *x* <= 21 wird auf Rechnern mit IEEE-Gleitkommastandard ein exaktes Gleitkommaergebnis zurückgegeben. Für ganze Zahlen *x* mit 22 <= *x* <= 170 ist das Ergebnis auf 1 ULP genau. Für reelle Zahlen *x* mit *x* >= 0 wird das Ergebnis durch Berechnung von *Gamma(x+1)* unter Verwendung der Funktion **::math::ln_Gamma** approximiert; das Ergebnis wird voraussichtlich auf mehr als neun signifikante Stellen genau sein. Es ist ein Fehler, *x* <= -1 oder *x* > 170 anzugeben oder einen Wert für *x*, der nicht numerisch ist.

**::math::choose** *n k*
: Gibt den Binomialkoeffizienten *C(n, k)* zurück


```
   C(n,k) = n! / k! (n-k)!
```

: Wenn beide Parameter ganze Zahlen sind und das Ergebnis in 32 Bit passt, wird das Ergebnis auf eine ganze Zahl gerundet. Ganzzahlige Ergebnisse sind bis mindestens *n* = 34 exakt. Gleitkommaergebnisse sind auf mehr als neun signifikante Stellen genau.


**::math::Beta** *z w*
: Gibt die Beta-Funktion der Parameter *z* und *w* zurück.


```
   Beta(z,w) = Beta(w,z) = Gamma(z) * Gamma(w) / Gamma(z+w)
```

: Die Ergebnisse werden als Gleitkommazahl mit einer Genauigkeit von mehr als neun signifikanten Stellen zurückgegeben, sofern *w* und *z* beide mindestens 1 betragen.


**::math::combinatorics::permutations** *n*
: Gibt die Anzahl der Permutationen von n Elementen zurück. Der Rückgabewert ist stets eine ganze Zahl; er unterliegt nicht der Beschränkung auf den Bereich von 32- oder 64-Bit-Ganzzahlen, da in Tcl 8.5 und späteren Versionen Ganzzahlen mit beliebiger Genauigkeit verwendet werden.


int *n*
: Die Anzahl der Elemente, die permutiert werden sollen.


**::math::combinatorics::variations** *n* *k*
: Gibt die Anzahl der Variationen von k Elementen zurück, die aus insgesamt n Elementen ausgewählt werden. Dabei wird die Reihenfolge der Elemente berücksichtigt.


int *n*
: Die Anzahl der Elemente, aus denen eine Auswahl getroffen werden soll.

int *k*
: Die Anzahl der Elemente, die in jeder Variation ausgewählt werden sollen.


**::math::combinatorics::combinations** *n* *k*
: Gibt die Anzahl der Kombinationen von k Elementen zurück, die aus insgesamt n Elementen ausgewählt werden. Die Reihenfolge der Elemente spielt keine Rolle.


int *n*
: Die Anzahl der Elemente, aus denen eine Auswahl getroffen werden soll.

int *k*
: Die Anzahl der Elemente, die in jeder Kombination ausgewählt werden sollen.


**::math::combinatorics::derangements** *n*
: Gibt die Anzahl der Derangements von n Elementen zurück. Ein Derangement ist eine Permutation, bei der jedes Element gegenüber seiner ursprünglichen Position verschoben ist.


int *n*
: Die Anzahl der Elemente, die neu angeordnet werden sollen.


**::math::combinatorics::catalan** *n*
: Gibt die n-te Catalan-Zahl zurück. Die Zahl n muss 1 oder größer sein. Diese Zahlen kommen in verschiedenen kombinatorischen Problemen vor.


int *n*
: Der Index der Catalan-Zahl


**::math::combinatorics::firstStirling** *n* *m*
: Berechnet eine Stirling-Zahl erster Art (mit Vorzeichen, m Zyklen in einer Permutation von n Elementen)


int *n*
: Anzahl der Elemente

int *m*
: Anzahl der Zyklen


**::math::combinatorics::secondStirling** *n* *m*
: Berechnet eine Stirling-Zahl zweiter Art (m nichtleere Teilmengen aus n Elementen)


int *n*
: Anzahl der Elemente

int *m*
: Anzahl der Teilmengen


**::math::combinatorics::partitionP** *n*
: Berechnet die Anzahl der Möglichkeiten, auf die eine ganze Zahl n als Summe positiver ganzer Zahlen dargestellt werden kann.


int *n*
: Die betreffende Zahl


**::math::combinatorics::list-permutations** *n*
: Gibt die Liste der Permutationen der Zahlen 0, …, n-1 zurück.


int *n*
: Die Anzahl der Elemente, die permutiert werden sollen.


**::math::combinatorics::list-variations** *n* *k*
: Gibt die Liste der Variationen von k Zahlen zurück, die aus den Zahlen 0, …, n-1 ausgewählt wurden. Dabei wird die Reihenfolge der Elemente berücksichtigt.


int *n*
: Die Anzahl der Elemente, aus denen eine Auswahl getroffen werden soll.

int *k*
: Die Anzahl der Elemente, die in jeder Variation ausgewählt werden sollen.


**::math::combinatorics::list-combinations** *n* *k*
: Gibt die Liste der Kombinationen aus k Zahlen zurück, die aus den Zahlen 0, …, n-1 ausgewählt wurden. Die Reihenfolge der Elemente wird dabei nicht berücksichtigt.


int *n*
: Die Anzahl der Elemente, aus denen eine Auswahl getroffen werden soll.

int *k*
: Die Anzahl der Elemente, die in jeder Kombination ausgewählt werden sollen.


**::math::combinatorics::list-derangements** *n*
: Gibt die Liste der Derangements der Zahlen 0, …, n-1 zurück.


int *n*
: Die Anzahl der Elemente, die neu angeordnet werden sollen.


**::math::combinatorics::list-powerset** *n*
: Gibt die Liste aller Teilmengen der Zahlen 0, …, n-1 zurück.


int *n*
: Die Anzahl der Elemente, die neu angeordnet werden sollen.


**::math::combinatorics::permutationObj** new/create NAME *n*
: Erzeugt ein TclOO-Objekt, das Permutationen nacheinander zurückgibt. Wenn die letzte Permutation erreicht ist, wird eine leere Liste zurückgegeben.


int *n*
: Die Anzahl der Elemente, die neu angeordnet werden sollen.


**\$perm** next
: Gibt die nächste Permutation von n Objekten zurück.

**\$perm** reset
: Setzt das Objekt zurück, sodass der Befehl *next* wieder die vollständige Liste liefert.

**\$perm** setElements *elements*
: Registriert eine Liste von Elementen, die mit dem Befehl *nextElements* permutiert werden sollen.


list *elements*
: Die Liste mit n Elementen, die permutiert werden sollen.


**\$perm** setElements
: Gibt die nächste Permutation der registrierten Elemente zurück.

**::math::combinatorics::combinationObj** new/create NAME *n* *k*
: Erzeugt ein TclOO-Objekt, das Kombinationen nacheinander zurückgibt. Wenn die letzte Kombination erreicht ist, wird eine leere Liste zurückgegeben.


int *n*
: Die Anzahl der Elemente, die neu angeordnet werden sollen.


**\$combin** next
: Gibt die nächste Kombination aus n Objekten zurück.

**\$combin** reset
: Setzt das Objekt zurück, sodass der Befehl *next* wieder die vollständige Liste liefert.

**\$combin** setElements *elements*
: Registriert eine Liste von Elementen, die mit dem Befehl *nextElements* permutiert werden sollen.


list *elements*
: Die Liste mit n Elementen, die permutiert werden sollen.


**\$combin** setElements
: Gibt die nächste Kombination der registrierten Elemente zurück.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Mathematik
