---
CommandName: math::constants
title: math::constants
ManualSection: n
Version: 1.0.4
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - constants
 - degrees
 - e
 - math
 - pi
 - radians
Copyright:
 - Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
---

# Name

math::constants – Mathematische und numerische Konstanten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.3]{.optlit}
[package]{.cmd} [require]{.sub} [math::constants]{.lit} [1.0.4]{.optlit}
[::math::constants::constants]{.cmd} [args]{.arg}
[::math::constants::print-constants]{.cmd} [args]{.arg}
:::

# Beschreibung

Dieses Paket definiert einige gängige mathematische und numerische Konstanten. Durch die Verwendung des Pakets erhalten Sie einheitliche Werte für Zahlen wie Pi und ln(10).

Es definiert zwei Befehle:

- einen zum Importieren der Konstanten

- einen, der anzeigt, welche Konstanten definiert sind und welche Werte sie tatsächlich haben.


Der Grund für dieses Paket liegt darin, dass Sie bei (mathematischen) Berechnungen häufig eine gute Näherung benötigen, beispielsweise für das Verhältnis von Grad zu Radiant. Sie können dies natürlich wie folgt definieren:

```
    variable radtodeg [expr {180.0/(4.0*atan(1.0))}]
```

und die Variable radtodeg verwenden, wann immer Sie die Umrechnung benötigen.

Dies hat zwei Nachteile:

- Sie müssen sich die richtige Formel oder den richtigen Wert merken, und das birgt die Gefahr von Fehlern.

- Insbesondere bei der Verwendung mathematischer Funktionen wie *atan* gehen Sie davon aus, dass diese korrekt implementiert wurden. Dies ist jedoch selten oder gar nicht der Fall, und je nach Plattform können geringfügige Unterschiede auftreten.


So können Sie dies mit dem Paket *math::constants* umsetzen:

```
    package require math::constants
    ::math::constants::constants radtodeg degtorad
```

wodurch im aufrufenden Namespace zwei Variablen erstellt werden: radtodeg und (deren Kehrwert) degtorad.

Zu den definierten Konstanten (deren Werte größtenteils aus mathematischen Tabellen stammen, deren Genauigkeit die üblicherweise verarbeitbare Genauigkeit übersteigt) gehören:

- Grundkonstanten wie Pi, e, Gamma (Eulersche Konstante)

- abgeleitete Werte wie ln(10) und sqrt(2)

- rein numerische Werte wie 1/3, die der Einfachheit halber und aufgrund der Tatsache aufgenommen wurden, dass bestimmte, scheinbar triviale Berechnungen wie:

    ```
        set value [expr {3.0*$onethird}]
    ```

- liefern *genau* den Wert, den Sie erwarten (sofern IEEE-Arithmetik verfügbar ist).


Die vollständige Liste der benannten Konstanten finden Sie im Abschnitt [Konstanten].

# Prozeduren

Das Paket definiert die folgenden öffentlichen Prozeduren:

**::math::constants::constants** *args*
: Importiert die Konstanten, deren Namen als Argumente angegeben sind

**::math::constants::print-constants** *args*
: Gibt die Konstanten, deren Namen als Argumente angegeben wurden, auf dem Bildschirm aus (Name, Wert und Beschreibung) oder, falls keine Argumente angegeben wurden, alle definierten Konstanten. Hierbei handelt es sich in erster Linie um eine Hilfsprozedur.


# Konstanten

[pi][bigfloat]
: Verhältnis von Kreisumfang zu Durchmesser

**e**
: Basis des natürlichen Logarithmus

**ln10**
: Natürlicher Logarithmus von 10

**phi**
: Der Goldene Schnitt

**gamma**
: Eulersche Konstante

**sqrt2**
: Quadratwurzel aus 2

**thirdrt2**
: Kubikwurzel aus 2 (2 hoch 1/3)

**sqrt3**
: Quadratwurzel aus 3

**radtodeg**
: Umrechnung von Radiant in Grad

**degtorad**
: Umrechnung von Grad in Radiant

**onethird**
: Ein Drittel (0,3333....)

**twothirds**
: Zwei Drittel (0,6666....)

**onesixth**
: Ein Sechstel (0,1666....)

**huge**
: (Ungefähr) die größte Zahl

**tiny**
: (Ungefähr) die kleinste Zahl ungleich Null

**eps**
: Die kleinste Zahl, für die gilt: 1+eps != 1


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: constants* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2004 Arjen Markus <arjenmarkus@users.sourceforge.net>
```


[bigfloat]: bigfloat.md
