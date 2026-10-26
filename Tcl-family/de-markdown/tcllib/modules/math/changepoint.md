---
CommandName: math::changepoint
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - control
 - statistics
Copyright:
 - Copyright (c) 2020 by Arjen Markus
---

# NAME

math::changepoint – Methoden zur Erkennung von Änderungspunkten

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [math::statistics]{.lit} 
[package]{.cmd} [require]{.sub} [math::changepoint]{.lit} [0.2]{.optlit} 
[::math::changepoint::cusum-detect]{.cmd} [data]{.arg} [args]{.optarg} 
[::math::changepoint::cusum-online]{.cmd} [args]{.optarg} 
[\$cusumObj]{.cmd} examine [value]{.arg} 
[\$cusumObj]{.cmd} reset 
[::math::changepoint::binary-segmentation]{.cmd} [data]{.arg} [args]{.optarg} 
:::

# BESCHREIBUNG

Das Paket **math::changepoint** implementiert eine Reihe bekannter Methoden, um festzustellen, ob eine Datenreihe eine Verschiebung des Mittelwerts aufweist oder nicht. Hinweis: Diese Methoden zeigen lediglich an, ob eine Verschiebung des Mittelwerts wahrscheinlich ist. Aufgrund des stochastischen Charakters der zu analysierenden Daten sind falsch-positive Ergebnisse möglich. Die CUSUM-Methode ist sowohl in einer „Offline“- als auch in einer „Online“-Version implementiert, sodass sie entweder für eine vollständige Datenreihe oder zur Erkennung von Veränderungen in Daten verwendet werden kann, die nach und nach eintreffen. Die Implementierung basiert größtenteils auf folgenden Websites:

**•**
: *https://www.itl.nist.gov/div898/handbook/pmc/section3/pmc323.htm*

**•**
: *https://en.wikipedia.org/wiki/CUSUM* Im Wesentlichen wird die Abweichung der Daten von einem vorgegebenen Zielwert kumuliert, und wenn die Gesamtabweichung zu groß wird, wird ein Änderungspunkt gemeldet. Eine zweite Methode, die binäre Segmentierung, wird ausschließlich als „Offline“-Verfahren implementiert, da sie die Datenreihe als Ganzes untersuchen muss. In der hier enthaltenen Variante wurden folgende Ansätze verwendet:

**•**
: Die Segmente, in die die Datenreihe unterteilt werden kann, sollten nicht zu kurz sein, da es sonst zu Segmenten kommen könnte, die nur aus einem einzigen Datenpunkt bestehen. Daher wird eine Mindestlänge festgelegt.

**•**
: Damit sich die Segmentierung lohnt, sollte ein Mindestgewinn bei der Reduzierung der Kostenfunktion (der Summe der quadrierten Abweichungen vom Mittelwert für jedes Segment) erzielt werden. Dies steht möglicherweise nicht im Einklang mit den Beschreibungen der Methode in verschiedenen Veröffentlichungen, ist jedoch leicht verständlich und intuitiv. Eine Veröffentlichung, die weitere Informationen zur Methode im Allgemeinen liefert, ist „Selective review of offline change point detection methods“ von Truong et al. *https://arxiv.org/abs/1801.00718*.


# PROZEDUREN

Das Paket definiert die folgenden öffentlichen Prozeduren:

**::math::changepoint::cusum-detect** *data* ?args?
: Untersucht eine vorgegebene Datenreihe und gibt die Position der ersten Änderung (falls vorhanden) zurück.


double *data*
: Zu untersuchende Datenreihe

list *args*
: Optionale Liste von Schlüssel-Wert-Paaren:


**-target** *value*
: Der Zielwert (bzw. Mittelwert) für die Zeitreihe

**-tolerance** *value*
: Die zulässige Standardabweichung

**-kfactor** *value*
: Der Faktor, mit dem die Standardabweichung multipliziert werden soll (Standardwert ist 0,5, typischerweise zwischen 0,5 und 1,0)

**-hfactor** *value*
: Der Faktor, der die Grenzen festlegt, innerhalb derer die „cusum“-Statistik akzeptiert wird (typischerweise 3,0–5,0, Standardwert 4,0)


**::math::changepoint::cusum-online** ?args?
: Klasse zur Überprüfung der übergebenen Daten hinsichtlich der erwarteten Eigenschaften. Es müssen mindestens die Schlüsselwörter *-target* und *-tolerance* angegeben werden.


list *args*
: Liste der Schlüssel-Wert-Paare:


**-target** *value*
: Der Zielwert (bzw. Mittelwert) für die Zeitreihe

**-tolerance** *value*
: Die zulässige Standardabweichung

**-kfactor** *value*
: Der Faktor, mit dem die Standardabweichung multipliziert werden soll (Standardwert ist 0,5, typischerweise zwischen 0,5 und 1,0)

**-hfactor** *value*
: Der Faktor, der die Grenzen festlegt, innerhalb derer die „cusum“-Statistik akzeptiert wird (typischerweise 3,0–5,0, Standardwert 4,0)


**\$cusumObj** examine *value*
: Übergibt einen Wert an das *cusum-online*-Objekt und prüft ihn. Bleibt die kumulative Summe mit diesem neuen Wert innerhalb der Grenzen, wird Null (0) zurückgegeben, andernfalls Eins (1).


double *value*
: Der neue Wert


**\$cusumObj** reset
: Setzt die kumulative Summe zurück, sodass die Prüfung von vorne beginnen kann.

**::math::changepoint::binary-segmentation** *data* ?args?
: Wendet die binäre Segmentierungsmethode rekursiv an, um Änderungspunkte zu ermitteln. Gibt eine Liste mit den Indizes potenzieller Änderungspunkte zurück.


list *data*
: Zu untersuchende Daten

list *args*
: Optionale Schlüssel-Wert-Paare:


**-minlength** *number*
: Mindestanzahl an Punkten in jedem Segment (Standard: 5)

**-threshold** *value*
: Faktor, der auf die Standardabweichung angewendet wird und als Schwellenwert dient, um die Änderung der Kostenfunktion als Verbesserung zu werten (Standardwert: 1,0)


# KATEGORIE

Mathematik

# COPYRIGHT

```
Copyright (c) 2020 by Arjen Markus
```
