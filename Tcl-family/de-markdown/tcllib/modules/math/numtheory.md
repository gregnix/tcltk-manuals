---
CommandName: math::numtheory
ManualSection: n
Version: 1.1.4
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - number theory
 - prime
Copyright:
 - Copyright (c) 2010 Lars Hellström <Lars dot Hellstrom at residenset dot net>
---

# NAME

math::numtheory – Zahlentheorie

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [?8.5]{.lit} [9?]{.lit} 
[package]{.cmd} [require]{.sub} [math::numtheory]{.lit} [1.1.4]{.optlit} 
[math::numtheory::isprime]{.cmd} [N]{.arg} [option value]{.optdot} 
[math::numtheory::firstNprimes]{.cmd} [N]{.arg} 
[math::numtheory::primesLowerThan]{.cmd} [N]{.arg} 
[math::numtheory::primeFactors]{.cmd} [N]{.arg} 
[math::numtheory::primesLowerThan]{.cmd} [N]{.arg} 
[math::numtheory::primeFactors]{.cmd} [N]{.arg} 
[math::numtheory::uniquePrimeFactors]{.cmd} [N]{.arg} 
[math::numtheory::factors]{.cmd} [N]{.arg} 
[math::numtheory::totient]{.cmd} [N]{.arg} 
[math::numtheory::moebius]{.cmd} [N]{.arg} 
[math::numtheory::legendre]{.cmd} [a]{.arg} [p]{.arg} 
[math::numtheory::jacobi]{.cmd} [a]{.arg} [b]{.arg} 
[math::numtheory::gcd]{.cmd} [m]{.arg} [n]{.arg} 
[math::numtheory::lcm]{.cmd} [m]{.arg} [n]{.arg} 
[math::numtheory::numberPrimesGauss]{.cmd} [N]{.arg} 
[math::numtheory::numberPrimesLegendre]{.cmd} [N]{.arg} 
[math::numtheory::numberPrimesLegendreModified]{.cmd} [N]{.arg} 
[math::numtheory::differenceNumberPrimesLegendreModified]{.cmd} [lower]{.arg} [upper]{.arg} 
[math::numtheory::listPrimePairs]{.cmd} [lower]{.arg} [upper]{.arg} [step]{.arg} 
[math::numtheory::listPrimeProgressions]{.cmd} [lower]{.arg} [upper]{.arg} [step]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket dient der Zusammenstellung verschiedener zahlentheoretischer Operationen, wobei der Schwerpunkt leicht auf Primzahlen liegt.

**math::numtheory::isprime** *N* ?*option* *value* ...?
: Der Befehl **isprime** testet, ob die ganze Zahl *N* eine Primzahl ist, und gibt den booleschen Wert „true“ zurück, wenn *N* eine Primzahl ist, sowie den booleschen Wert „false“, wenn *N* keine Primzahl ist. Die verwendete formale Definition von „Primzahl“ entspricht der gängigen Definition, wonach die zu prüfende Zahl größer als 1 ist und nur triviale Teiler besitzt. Genauer gesagt ist der Rückgabewert einer der Werte **0** (wenn *N* definitiv keine Primzahl ist), **1** (wenn *N* definitiv eine Primzahl ist) und **on** (wenn *N* wahrscheinlich eine Primzahl ist); die beiden letztgenannten Werte sind jeweils boolesche „true“-Werte. Der Fall, dass eine ganze Zahl als „wahrscheinlich prim“ eingestuft werden kann, ergibt sich daraus, dass der in der Testimplementierung verwendete Miller-Rabin-Algorithmus grundsätzlich probabilistisch ist und bei ungünstigen Umständen möglicherweise nicht erkennt, dass eine Zahl tatsächlich zusammengesetzt ist. Mit Optionen lässt sich das Risiko solcher „falsch positiven Ergebnisse“ im Test wählen. Für „kleine“ *N* (was derzeit *N* < 118670087467 bedeutet) wird **1** zurückgegeben, da bekannt ist, dass hier keine falsch positiven Ergebnisse möglich sind. Die einzige derzeit definierte Option lautet:


**-randommr** *repetitions*
: die festlegt, wie oft der Miller-Rabin-Test mit zufällig ausgewählten Basen wiederholt werden soll. Jede Wiederholung verringert die Wahrscheinlichkeit eines falsch-positiven Ergebnisses um mindestens den Faktor 4. Der Standardwert für *repetitions* beträgt 4.


: Unbekannte Optionen werden stillschweigend ignoriert.


**math::numtheory::firstNprimes** *N*
: Gibt die ersten N Primzahlen zurück


integer *N* (in)
: Anzahl der Primzahlen, die zurückgegeben werden


**math::numtheory::primesLowerThan** *N*
: Gibt die Primzahlen zurück, die kleiner oder gleich N sind.


integer *N* (in)
: Größte zu berücksichtigende Zahl


**math::numtheory::primeFactors** *N*
: Gibt eine Liste der Primfaktoren der Zahl N zurück.


integer *N* (in)
: Zu faktorisierende Zahl


**math::numtheory::primesLowerThan** *N*
: Gibt die Primzahlen zurück, die kleiner oder gleich N sind.


integer *N* (in)
: Größte zu berücksichtigende Zahl


**math::numtheory::primeFactors** *N*
: Gibt eine Liste der Primfaktoren der Zahl N zurück.


integer *N* (in)
: Zu faktorisierende Zahl


**math::numtheory::uniquePrimeFactors** *N*
: Gibt eine Liste der *eindeutigen* Primfaktoren der Zahl N zurück.


integer *N* (in)
: Zu faktorisierende Zahl


**math::numtheory::factors** *N*
: Gibt eine Liste aller *eindeutigen* Teiler der Zahl N zurück, einschließlich 1 und N selbst.


integer *N* (in)
: Zu faktorisierende Zahl


**math::numtheory::totient** *N*
: Berechnet die Eulersche Phi-Funktion (Totientfunktion) für die Zahl N (Anzahl der zu N teilerfremden Zahlen).


integer *N* (in)
: Die betreffende Zahl


**math::numtheory::moebius** *N*
: Berechnet die Möbius-Funktion für die Zahl N


integer *N* (in)
: Die betreffende Zahl


**math::numtheory::legendre** *a* *p*
: Berechnet das Legendre-Symbol (a/p)


integer *a* (in)
: Die obere Zahl im Symbol

integer *p* (in)
: Die untere Zahl im Symbol (muss ungleich Null sein)


**math::numtheory::jacobi** *a* *b*
: Berechnet das Jacobi-Symbol (a/b)


integer *a* (in)
: Die obere Zahl im Symbol

integer *b* (in)
: Die untere Zahl im Symbol (muss ungerade sein)


**math::numtheory::gcd** *m* *n*
: Gibt den größten gemeinsamen Teiler von *m* und *n* zurück.


integer *m* (in)
: Erste Zahl

integer *n* (in)
: Zweite Zahl


**math::numtheory::lcm** *m* *n*
: Gibt das kleinste gemeinsame Vielfache von *m* und *n* zurück.


integer *m* (in)
: Erste Zahl

integer *n* (in)
: Zweite Zahl


**math::numtheory::numberPrimesGauss** *N*
: Schätzt die Anzahl der Primzahlen gemäß der Formel von Gauß.


integer *N* (in)
: Die betreffende Zahl; sollte größer als 0 sein


**math::numtheory::numberPrimesLegendre** *N*
: Schätzt die Anzahl der Primzahlen gemäß der Formel von Legendre.


integer *N* (in)
: Die betreffende Zahl; sollte größer als 0 sein


**math::numtheory::numberPrimesLegendreModified** *N*
: Schätzt die Anzahl der Primzahlen gemäß der modifizierten Formel von Legendre.


integer *N* (in)
: Die betreffende Zahl; sollte größer als 0 sein


**math::numtheory::differenceNumberPrimesLegendreModified** *lower* *upper*
: Schätzt die Anzahl der Primzahlen zwischen zwei Grenzen gemäß der modifizierten Formel von Legendre.


integer *lower* (in)
: Untergrenze für die Primzahlen; sollte größer als 0 sein

integer *upper* (in)
: Obergrenze für die Primzahlen; sollte größer als 0 sein


**math::numtheory::listPrimePairs** *lower* *upper* *step*
: Gibt eine Liste von Primzahlpaaren zurück, die jeweils um den angegebenen Schritt voneinander abweichen.


integer *lower* (in)
: Untergrenze für die Primzahlen; sollte größer als 0 sein

integer *upper* (in)
: Obergrenze für die Primzahlen; sollte größer als die Untergrenze sein

integer *step* (in)
: Schrittweite, um die sich die Primzahlen unterscheiden sollen; Standardwert ist 2


**math::numtheory::listPrimeProgressions** *lower* *upper* *step*
: Gibt eine Liste von Listen mit Primzahlen zurück, die sich jeweils um den angegebenen Schritt vom vorherigen Wert unterscheiden.


integer *lower* (in)
: Untergrenze für die Primzahlen; sollte größer als 0 sein

integer *upper* (in)
: Obergrenze für die Primzahlen; sollte größer als die Untergrenze sein

integer *step* (in)
: Schrittweite, um die sich die Primzahlen unterscheiden sollen; Standardwert ist 2


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: numtheory* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Mathematik

# COPYRIGHT

```
Copyright (c) 2010 Lars Hellström <Lars dot Hellstrom at residenset dot net>
```
