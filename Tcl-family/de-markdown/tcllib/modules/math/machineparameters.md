---
CommandName: math::machineparameters
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: tclrep
Copyright:
 - Copyright (c) 2008 Michael Baudin <michael.baudin@sourceforge.net>
---

# NAME

math::machineparameters – Berechnung der Maschinenparameter mit doppelter Genauigkeit.

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [math::machineparameters]{.lit} [0.2]{.lit} 
[machineparameters]{.cmd} create [objectname]{.arg} [options]{.optdot} 
[objectname]{.ins} [configure]{.sub} [options]{.optdot} 
[objectname]{.ins} [cget]{.sub} [opt]{.arg} 
[objectname]{.ins} [destroy]{.sub} 
[objectname]{.ins} [compute]{.sub} 
[objectname]{.ins} [get]{.sub} [key]{.arg} 
[objectname]{.ins} [tostring]{.sub} 
[objectname]{.ins} [print]{.sub} 
:::

# BESCHREIBUNG

Das Paket *math::machineparameters* ist das Tcl-Äquivalent zur LAPACK-Funktion DLAMCH. In Gleitkommasystemen wird eine Gleitkommazahl wie folgt dargestellt:

```
x = +/- d1 d2 ... dt basis^e
```

wobei die Ziffern die folgende Bedingung erfüllen:

```
0 <= di <= basis - 1, i = 1, t
```

gemäß der Konvention:

**•**
: t ist die Größe der Mantisse

**•**
: basis ist die Basis (die „Radix“). Die Methode **compute** berechnet alle Maschinenparameter. Anschließend kann die Methode **get** verwendet werden, um die einzelnen Parameter abzurufen. Die Methode **print** gibt einen Bericht auf der Standardausgabe aus.


# BEISPIEL

Im folgenden Beispiel werden die Parameter eines Desktops unter Linux mit den folgenden Tcl-8.4.19-Eigenschaften berechnet:

```
% parray tcl_platform
tcl_platform(byteOrder) = littleEndian
tcl_platform(machine)   = i686
tcl_platform(os)        = Linux
tcl_platform(osVersion) = 2.6.24-19-generic
tcl_platform(platform)  = unix
tcl_platform(tip,268)   = 1
tcl_platform(tip,280)   = 1
tcl_platform(user)      = <username>
tcl_platform(wordSize)  = 4
```

Im folgenden Beispiel wird ein „machineparameters“-Objekt erstellt, dessen Eigenschaften berechnet und anschließend angezeigt.

```
     set pp [machineparameters create %AUTO%]
     $pp compute
     $pp print
     $pp destroy
```

Dies gibt Folgendes aus:

```
     Machine parameters
     Epsilon : 1.11022302463e-16
     Beta : 2
     Rounding : proper
     Mantissa : 53
     Maximum exponent : 1024
     Minimum exponent : -1021
     Overflow threshold : 8.98846567431e+307
     Underflow threshold : 2.22507385851e-308
```

Dies lässt sich gut mit den Ergebnissen von Lapack 3.1.1 vergleichen:

```
     Epsilon                      =   1.11022302462515654E-016
     Safe minimum                 =   2.22507385850720138E-308
     Base                         =    2.0000000000000000
     Precision                    =   2.22044604925031308E-016
     Number of digits in mantissa =    53.000000000000000
     Rounding mode                =   1.00000000000000000
     Minimum exponent             =   -1021.0000000000000
     Underflow threshold          =   2.22507385850720138E-308
     Largest exponent             =    1024.0000000000000
     Overflow threshold           =   1.79769313486231571E+308
     Reciprocal of safe minimum   =   4.49423283715578977E+307
```

Im folgenden Beispiel wird ein „machineparameters“-Objekt erstellt, die Eigenschaften berechnet und der Epsilon-Wert für die Maschine ermittelt.

```
     set pp [machineparameters create %AUTO%]
     $pp compute
     set eps [$pp get -epsilon]
     $pp destroy
```

# LITERATUR

**•**
: „Algorithms to Reveal Properties of Floating-Point Arithmetic“, Michael A. Malcolm, Stanford University, Communications of the ACM, Band 15, Ausgabe 11 (November 1972), Seiten: 949–951

**•**
: „More on Algorithms that Reveal Properties of Floating, Point Arithmetic Units“, W. Morven Gentleman, University of Waterloo, Scott B. Marovich, Purdue University, Communications of the ACM, Band 17,  Ausgabe 5  (Mai 1974), Seiten: 276–277


# API FÜR KLASSEN

**machineparameters** create *objectname* ?*options*...?
: Der Befehl erstellt ein neues „machineparameters“-Objekt und gibt als Ergebnis den vollqualifizierten Namen des Objektbefehls zurück.


**-verbose** *verbose*
: Setzen Sie diese Option auf 1, um die ausführliche Protokollierung zu aktivieren. Diese Option dient in erster Linie zu Debugging-Zwecken. Der Standardwert von *verbose* ist 0.


# OBJEKT-API

*objectname* **configure** ?*options*...?
: Der Befehl konfiguriert die Optionen des Objekts *objectname*. Die Optionen entsprechen denen der statischen Methode **create**.

*objectname* **cget** *opt*
: Gibt den Wert der Option mit dem Namen *opt* zurück. Die Optionen entsprechen denen der Methoden **create** und **configure**.

*objectname* **destroy**
: Zerstört das Objekt *objectname*.

*objectname* **compute**
: Berechnet die Maschinenparameter.

*objectname* **get** *key*
: Gibt den Wert zurück, der dem angegebenen Schlüssel entspricht. Nachfolgend finden Sie eine Liste der verfügbaren Schlüssel.


**•**
: -epsilon: Kleinster Wert, für den 1+epsilon>1 falsch ist

**•**
: -rounding: Der auf der Maschine verwendete Rundungsmodus. Die Rundung erfolgt, wenn zur Darstellung der Zahl mehr als t Ziffern erforderlich wären. Mit dem aktuellen System lassen sich zwei Modi ermitteln: „chop“ bedeutet, dass unabhängig vom Wert der Zahl nur t Ziffern beibehalten werden; „proper“ bedeutet, dass ein anderer Rundungsmodus verwendet wird, sei es „auf die nächste Zahl runden“, „aufrunden“ oder „abrunden“.

**•**
: -basis: Die Basis der Gleitkommadarstellung. Die Basis ist in der Regel 2, d. h. die binäre Darstellung (z. B. bei IEEE-754-Rechnern), doch einige Maschinen (wie beispielsweise HP-Taschenrechner) verwenden 10, 16 usw.

**•**
: -mantissa: Die Anzahl der Bits in der Mantisse

**•**
: -exponentmax:  der größte positive Exponent, bevor ein Überlauf auftritt

**•**
: -exponentmin: Der größte negative Exponent, bevor es zu einem (allmählichen) Unterlauf kommt

**•**
: -vmax: Größter positiver Wert, bevor ein Überlauf auftritt

**•**
: -vmin: Größter negativer Wert, bevor ein (allmählicher) Unterlauf auftritt


*objectname* **tostring**
: Gibt einen Bericht zu den Maschinenparametern zurück.

*objectname* **print**
: Gibt die Maschinenparameter auf der Standardausgabe aus.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# COPYRIGHT

```
Copyright (c) 2008 Michael Baudin <michael.baudin@sourceforge.net>
```
