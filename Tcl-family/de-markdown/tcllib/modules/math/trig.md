---
CommandName: math::trig
title: math::trig
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - math
 - trigonometry
Copyright:
 - Copyright (c) 2018 Arjen Markus
---

# Name

math::trig – Trigonometrische und hyperbolische Funktionen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [math::trig]{.lit} [1.1]{.lit}
[::math::trig::radian\_reduced]{.cmd} [angle]{.arg}
[::math::trig::degree\_reduced]{.cmd} [angle]{.arg}
[::math::trig::cosec]{.cmd} [angle]{.arg}
[::math::trig::sec]{.cmd} [angle]{.arg}
[::math::trig::cotan]{.cmd} [angle]{.arg}
[::math::trig::acosec]{.cmd} [value]{.arg}
[::math::trig::asec]{.cmd} [value]{.arg}
[::math::trig::acotan]{.cmd} [value]{.arg}
[::math::trig::cosech]{.cmd} [value]{.arg}
[::math::trig::sech]{.cmd} [value]{.arg}
[::math::trig::cotanh]{.cmd} [value]{.arg}
[::math::trig::asinh]{.cmd} [value]{.arg}
[::math::trig::acosh]{.cmd} [value]{.arg}
[::math::trig::atanh]{.cmd} [value]{.arg}
[::math::trig::acosech]{.cmd} [value]{.arg}
[::math::trig::asech]{.cmd} [value]{.arg}
[::math::trig::acotanh]{.cmd} [value]{.arg}
[::math::trig::sind]{.cmd} [angle]{.arg}
[::math::trig::cosd]{.cmd} [angle]{.arg}
[::math::trig::tand]{.cmd} [angle]{.arg}
[::math::trig::cosecd]{.cmd} [angle]{.arg}
[::math::trig::secd]{.cmd} [angle]{.arg}
[::math::trig::cotand]{.cmd} [angle]{.arg}
:::

# Beschreibung

Das Paket *math::trig* definiert eine Reihe von trigonometrischen und hyperbolischen Funktionen sowie deren Umkehrfunktionen. Darüber hinaus definiert es Varianten der trigonometrischen Funktionen, deren Argumente in Grad statt im Bogenmaß angegeben werden.

Zur Vereinfachung der Verwendung können diese Funktionen in den Namespace *tcl::mathfunc* importiert werden, sodass sie direkt im Befehl *expr* verwendet werden können.

# Funktionen

Die Funktionen *radian\_reduced* und *degree\_reduced* geben einen reduzierten Winkel zurück, und zwar im Bogenmaß bzw. in Grad, in den Intervallen \[0, 2pi) und \[0, 360):

**::math::trig::radian\_reduced** *angle*
: Gibt den entsprechenden Winkel im Intervall \[0, 2pi) zurück.

    float *angle*
    : Winkel (im Bogenmaß)


**::math::trig::degree\_reduced** *angle*
: Gibt den entsprechenden Winkel im Intervall \[0, 360) zurück.

    float *angle*
    : Winkel (in Grad)



Zusätzlich zu den im Befehl *expr* definierten trigonometrischen Funktionen sind die folgenden definiert:

**::math::trig::cosec** *angle*
: Berechnet den Kosekans des Winkels (1/cos(angle))

    float *angle*
    : Winkel (im Bogenmaß)


**::math::trig::sec** *angle*
: Berechnet den Sekans des Winkels (1/sin(angle))

    float *angle*
    : Winkel (im Bogenmaß)


**::math::trig::cotan** *angle*
: Berechnet den Kotangens des Winkels (1/tan(angle))

    float *angle*
    : Winkel (im Bogenmaß)



Auch für diese Funktionen sind die Umkehrfunktionen definiert:

**::math::trig::acosec** *value*
: Berechnet den Arkuskosekans des Wertes

    float *value*
    : Wert des Arguments


**::math::trig::asec** *value*
: Berechnet den Arkussekans des Wertes

    float *value*
    : Wert des Arguments


**::math::trig::acotan** *value*
: Berechnet den Arkuskotangens des Wertes

    float *value*
    : Wert des Arguments



Es sind die folgenden hyperbolischen und inversen hyperbolischen Funktionen definiert:

**::math::trig::cosech** *value*
: Berechnet den hyperbolischen Kosekans des Wertes (1/sinh(value))

    float *value*
    : Wert des Arguments


**::math::trig::sech** *value*
: Berechnet den hyperbolischen Sekans des Wertes (1/cosh(value))

    float *value*
    : Wert des Arguments


**::math::trig::cotanh** *value*
: Berechnet den hyperbolischen Kotangens des Wertes (1/tanh(value))

    float *value*
    : Wert des Arguments


**::math::trig::asinh** *value*
: Berechnet den inversen hyperbolischen Sinus des Wertes

    float *value*
    : Wert des Arguments


**::math::trig::acosh** *value*
: Berechnet den inversen hyperbolischen Kosinus des Wertes

    float *value*
    : Wert des Arguments


**::math::trig::atanh** *value*
: Berechnet den inversen hyperbolischen Tangens des Wertes

    float *value*
    : Wert des Arguments


**::math::trig::acosech** *value*
: Berechnet den inversen hyperbolischen Kosekans des Wertes

    float *value*
    : Wert des Arguments


**::math::trig::asech** *value*
: Berechnet den inversen hyperbolischen Sekans des Wertes

    float *value*
    : Wert des Arguments


**::math::trig::acotanh** *value*
: Berechnet den inversen hyperbolischen Kotangens des Wertes

    float *value*
    : Wert des Arguments



Es sind die folgenden Versionen der gängigen trigonometrischen Funktionen und ihrer Umkehrfunktionen definiert:

**::math::trig::sind** *angle*
: Berechnet den Sinus des Winkels (in Grad)

    float *angle*
    : Winkel (in Grad)


**::math::trig::cosd** *angle*
: Berechnet den Kosinus des Winkels (in Grad)

    float *angle*
    : Winkel (im Bogenmaß)


**::math::trig::tand** *angle*
: Berechnet den Kotangens des Winkels (in Grad)

    float *angle*
    : Winkel (in Grad)


**::math::trig::cosecd** *angle*
: Berechnet den Kosekans des Winkels (in Grad)

    float *angle*
    : Winkel (in Grad)


**::math::trig::secd** *angle*
: Berechnet den Sekans des Winkels (in Grad)

    float *angle*
    : Winkel (in Grad)


**::math::trig::cotand** *angle*
: Berechnet den Kotangens des Winkels (in Grad)

    float *angle*
    : Winkel (in Grad)



# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: trig* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2018 Arjen Markus
```
