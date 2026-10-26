---
CommandName: math
ManualSection: n
Version: 1.2.6
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - math
 - statistics
Copyright:
---

# NAME

math – Tcl-Mathematikbibliothek

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [math]{.lit} [1.2.6]{.optlit} 
[::math::cov]{.cmd} [value]{.arg} [value]{.arg} [value]{.optdot} 
[::math::integrate]{.cmd} [list]{.arg} [of]{.arg} [xy]{.arg} [value]{.arg} [pairs]{.arg} 
[::math::fibonacci]{.cmd} [n]{.arg} 
[::math::max]{.cmd} [value]{.arg} [value]{.optdot} 
[::math::mean]{.cmd} [value]{.arg} [value]{.optdot} 
[::math::min]{.cmd} [value]{.arg} [value]{.optdot} 
[::math::product]{.cmd} [value]{.arg} [value]{.optdot} 
[::math::random]{.cmd} [value1]{.optarg} [value2]{.optarg} 
[::math::sigma]{.cmd} [value]{.arg} [value]{.arg} [value]{.optdot} 
[::math::stats]{.cmd} [value]{.arg} [value]{.arg} [value]{.optdot} 
[::math::sum]{.cmd} [value]{.arg} [value]{.optdot} 
:::

# BESCHREIBUNG

Das Paket **math** stellt mathematische Hilfsfunktionen bereit.

Neben einer Reihe von Grundbefehlen, die über das Paket *math* verfügbar sind, gibt es noch speziellere Pakete:

**•**
: **math::bigfloat** – Gleitkommaarithmetik mit beliebiger Genauigkeit

**•**
: **math::bignum** – Ganzzahlarithmetik mit beliebiger Genauigkeit

**•**
: **math::calculus::romberg** – Robuste Integrationsmethoden für Funktionen einer Variablen unter Verwendung der Romberg-Integration

**•**
: **math::calculus** – Integration von Funktionen, Lösen gewöhnlicher Differentialgleichungen

**•**
: **math::combinatorics** – Prozeduren für verschiedene kombinatorische Funktionen (beispielsweise die Gammafunktion und „k aus n“)

**•**
: **math::complexnumbers** – Arithmetik mit komplexen Zahlen

**•**
: **math::constants** – Eine Sammlung bekannter mathematischer Konstanten wie Pi, E und der Goldene Schnitt

**•**
: **math::fourier** – Diskrete Fourier-Transformationen

**•**
: **math::fuzzy** – Unscharfe Vergleiche von Gleitkommazahlen

**•**
: **math::geometry** – Geometrische Berechnungen in 2D

**•**
: **math::interpolate** – Verschiedene Interpolationsmethoden

**•**
: **math::linearalgebra** – Paket zur linearen Algebra

**•**
: **math::optimize** – Optimierungsmethoden

**•**
: **math::polynomials** – Polynomarithmetik (einschließlich Familien klassischer Polynome)

**•**
: **math::rationalfunctions** – Arithmetik gebrochenrationaler Funktionen

**•**
: **math::roman** – Umgang mit römischen Ziffern (einschließlich Rechenoperationen)

**•**
: **math::special** – Approximationen spezieller Funktionen aus der mathematischen Physik

**•**
: **math::statistics** – Statistische Verfahren und Tests


# GRUNDLEGENDE BEFEHLE

**::math::cov** *value* *value* ?*value ...*?
: Gibt den Variationskoeffizienten von zwei oder mehr numerischen Werten in Prozent zurück.

**::math::integrate** *list of xy value pairs*
: Gibt die Fläche unter einer „Kurve“, die durch eine Menge von (x,y)-Paaren definiert ist, sowie die Fehlergrenze als Liste zurück.

**::math::fibonacci** *n*
: Gibt die *n*-te Fibonacci-Zahl zurück.

**::math::max** *value* ?*value ...*?
: Gibt das Maximum eines oder mehrerer numerischer Werte zurück.

**::math::mean** *value* ?*value ...*?
: Gibt den Mittelwert oder den „Durchschnitt“ eines oder mehrerer numerischer Werte zurück.

**::math::min** *value* ?*value ...*?
: Gibt das Minimum eines oder mehrerer numerischer Werte zurück.

**::math::product** *value* ?*value ...*?
: Gibt das Produkt aus einem oder mehreren numerischen Werten zurück.

**::math::random** ?*value1*? ?*value2*?
: Gibt eine Zufallszahl zurück.  Werden keine Argumente angegeben, ist die Zahl ein Gleitkommawert zwischen 0 und 1.  Wird ein Argument angegeben, ist die Zahl ein ganzzahliger Wert zwischen 0 und *value1*.  Werden zwei Argumente angegeben, ist die Zahl ein ganzzahliger Wert zwischen *value1* und *value2*.

**::math::sigma** *value* *value* ?*value ...*?
: Gibt die Stichprobenstandardabweichung von zwei oder mehr numerischen Werten zurück.

**::math::stats** *value* *value* ?*value ...*?
: Gibt den Mittelwert, die Standardabweichung und den Variationskoeffizienten (in Prozent) als Liste zurück.

**::math::sum** *value* ?*value ...*?
: Gibt die Summe eines oder mehrerer numerischer Werte zurück.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Mathematik
