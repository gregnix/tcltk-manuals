---
CommandName: mathfunc
title: mathfunc
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Mathematical Functions
Links:
 - expr(n)
 - mathop(n)
 - namespace(n)
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-2000 Sun Microsystems, Inc.
 - Copyright (c) 2005 Kevin B. Kenny <kennykb@acm.org>. All rights reserved
---

# Name

mathfunc - Mathematische Funktionen für Tcl-Ausdrücke

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit}
[::tcl::mathfunc::abs]{.cmd} [arg]{.arg}
[::tcl::mathfunc::acos]{.cmd} [arg]{.arg}
[::tcl::mathfunc::asin]{.cmd} [arg]{.arg}
[::tcl::mathfunc::atan]{.cmd} [arg]{.arg}
[::tcl::mathfunc::atan2]{.cmd} [y]{.arg} [x]{.arg}
[::tcl::mathfunc::bool]{.cmd} [arg]{.arg}
[::tcl::mathfunc::ceil]{.cmd} [arg]{.arg}
[::tcl::mathfunc::cos]{.cmd} [arg]{.arg}
[::tcl::mathfunc::cosh]{.cmd} [arg]{.arg}
[::tcl::mathfunc::double]{.cmd} [arg]{.arg}
[::tcl::mathfunc::entier]{.cmd} [arg]{.arg}
[::tcl::mathfunc::exp]{.cmd} [arg]{.arg}
[::tcl::mathfunc::floor]{.cmd} [arg]{.arg}
[::tcl::mathfunc::fmod]{.cmd} [x]{.arg} [y]{.arg}
[::tcl::mathfunc::hypot]{.cmd} [x]{.arg} [y]{.arg}
[::tcl::mathfunc::int]{.cmd} [arg]{.arg}
[::tcl::mathfunc::isqrt]{.cmd} [arg]{.arg}
[::tcl::mathfunc::log]{.cmd} [arg]{.arg}
[::tcl::mathfunc::log10]{.cmd} [arg]{.arg}
[::tcl::mathfunc::max]{.cmd} [arg]{.arg} [arg]{.optdot}
[::tcl::mathfunc::min]{.cmd} [arg]{.arg} [arg]{.optdot}
[::tcl::mathfunc::pow]{.cmd} [x]{.arg} [y]{.arg}
[::tcl::mathfunc::rand]{.cmd}
[::tcl::mathfunc::round]{.cmd} [arg]{.arg}
[::tcl::mathfunc::sin]{.cmd} [arg]{.arg}
[::tcl::mathfunc::sinh]{.cmd} [arg]{.arg}
[::tcl::mathfunc::sqrt]{.cmd} [arg]{.arg}
[::tcl::mathfunc::srand]{.cmd} [arg]{.arg}
[::tcl::mathfunc::tan]{.cmd} [arg]{.arg}
[::tcl::mathfunc::tanh]{.cmd} [arg]{.arg}
[::tcl::mathfunc::wide]{.cmd} [arg]{.arg}
:::

# Beschreibung

Der Befehl [expr] behandelt mathematische Funktionen der Form **sin($x)** oder **atan2($y,$x)**, indem er sie in Aufrufe der Form **\[tcl::mathfunc::sin \[expr {$x}\]\]** oder **\[tcl::mathfunc::atan2 \[expr {$y}\] \[expr {$x}\]\]** umwandelt. Im Namespace **::tcl::mathfunc** stehen standardmäßig zahlreiche mathematische Funktionen zur Verfügung; diese sind auch außerhalb von [expr] nutzbar, indem die genannten Befehle direkt aufgerufen werden.

Tcl unterstützt in Ausdrücken die folgenden mathematischen Funktionen, die — sofern nicht anders angegeben — ausschließlich mit Gleitkommazahlen arbeiten:

::: {.info DISPLAY="yes"}
**abs**	**acos**	**asin**	**atan**\
**atan2**	**bool**	**ceil**	**cos**\
**cosh**	**double**	**entier**	**exp**\
**floor**	**fmod**	**hypot**	**int**\
**isqrt**	**log**	**log10**	**max**\
**min**	**pow**	**rand**	**round**\
**sin**	**sinh**	**sqrt**	**srand**\
**tan**	**tanh**	**wide**
:::

Zusätzlich zu diesen vordefinierten Funktionen können Anwendungen weitere Funktionen definieren, indem sie mit [proc] (oder auf andere Weise, z. B. [interp alias][interp] oder [Tcl\_CreateObjCommand][CrtObjCmd]) neue Befehle im Namespace **tcl::mathfunc** anlegen. Zusätzlich steht Erweiterungen in C eine veraltete Schnittstelle [Tcl\_CreateMathFunc][CrtMathFnc]() zur Verfügung. Letztere Schnittstelle wird für neue Implementierungen nicht empfohlen.

## Detaillierte Definitionen

**abs** *arg*
: Gibt den Absolutwert von *arg* zurück. *Arg* kann Ganzzahl oder Gleitkommazahl sein; das Ergebnis wird in derselben Form zurückgegeben.

**acos** *arg*
: Gibt den Arkuskosinus von *arg* im Bereich \[*0*,*pi*\] Radiant zurück. *Arg* sollte im Bereich \[*-1*,*1*\] liegen.

**asin** *arg*
: Gibt den Arkussinus von *arg* im Bereich \[*-pi/2*,*pi/2*\] Radiant zurück. *Arg* sollte im Bereich \[*-1*,*1*\] liegen.

**atan** *arg*
: Gibt den Arkustangens von *arg* im Bereich \[*-pi/2*,*pi/2*\] Radiant zurück.

**atan2** *y x*
: Gibt den Arkustangens von *y*/*x* im Bereich \[*-pi*,*pi*\] Radiant zurück. *x* und *y* dürfen nicht beide 0 sein. Ist *x* größer als *0*, ist dies äquivalent zu "**atan** \[[expr] {*y***/***x*}\]".

**bool** *arg*
: Akzeptiert jeden numerischen Wert oder jede Zeichenkette, die **string is boolean** akzeptiert, und gibt den entsprechenden booleschen Wert **0** oder **1** zurück. Von Null verschiedene Zahlen sind wahr. Andere Zahlen sind falsch. Nicht-numerische Zeichenketten liefern boolesche Werte gemäß **string is true** und **string is false**.

**ceil** *arg*
: Gibt den kleinsten integralen Gleitkommawert (d. h. mit Null Nachkommastellen) zurück, der nicht kleiner als *arg* ist. Das Argument kann ein beliebiger numerischer Wert sein.

**cos** *arg*
: Gibt den Kosinus von *arg* zurück, gemessen in Radiant.

**cosh** *arg*
: Gibt den hyperbolischen Kosinus von *arg* zurück. Würde das Ergebnis einen Überlauf verursachen, wird ein Fehler zurückgegeben.

**double** *arg*
: Das Argument kann ein beliebiger numerischer Wert sein. Ist *arg* ein Gleitkommawert, gibt der Befehl *arg* zurück, andernfalls wandelt er *arg* in Gleitkomma um und gibt den konvertierten Wert zurück. Kann **Inf** oder **-Inf** zurückgeben, wenn das Argument den Gleitkommabereich überschreitet.

**entier** *arg*
: Das Argument kann ein beliebiger numerischer Wert sein. Der Ganzzahl-Anteil von *arg* wird ermittelt und zurückgegeben. Der von dieser Funktion zurückgegebene Ganzzahl-Bereich ist unbegrenzt, im Gegensatz zu **int** und **wide**, die ihren Bereich auf bestimmte Speicherbreiten kürzen.

**exp** *arg*
: Gibt die Exponentialfunktion von *arg* zurück, definiert als *e*\*\**arg*. Würde das Ergebnis einen Überlauf verursachen, wird ein Fehler zurückgegeben.

**floor** *arg*
: Gibt den größten integralen Gleitkommawert (d. h. mit Null Nachkommastellen) zurück, der nicht größer als *arg* ist. Das Argument kann ein beliebiger numerischer Wert sein.

**fmod** *x y*
: Gibt den Gleitkomma-Rest der Division von *x* durch *y* zurück. Ist *y* gleich 0, wird ein Fehler zurückgegeben.

**hypot** *x y*
: Berechnet die Länge der Hypotenuse eines rechtwinkligen Dreiecks, ungefähr "**sqrt** \[[expr] {*x***\****x***+***y***\****y*}\]", außer dass sie numerisch stabiler ist, wenn die beiden Argumente deutlich unterschiedliche Größenordnungen haben.

**int** *arg*
: Das Argument kann ein beliebiger numerischer Wert sein. Der Ganzzahl-Anteil von *arg* wird ermittelt; anschließend werden die niederwertigen Bits dieses Ganzzahl-Werts bis zur Maschinenwortgröße als Ganzzahl-Wert zurückgegeben. Zur Referenz: Die Anzahl der Bytes im Maschinenwort ist im Element **wordSize** des Arrays [tcl\_platform][tclvars] gespeichert.

**isqrt** *arg*
: Berechnet den Ganzzahl-Anteil der Quadratwurzel von *arg*. *Arg* muss ein positiver Wert sein, Ganzzahl oder Gleitkommazahl. Im Gegensatz zu **sqrt**, das auf die Genauigkeit einer Gleitkommazahl beschränkt ist, liefert *isqrt* ein Ergebnis beliebiger Genauigkeit.

**log** *arg*
: Gibt den natürlichen Logarithmus von *arg* zurück. *Arg* muss ein positiver Wert sein.

**log10** *arg*
: Gibt den Logarithmus zur Basis 10 von *arg* zurück. *Arg* muss ein positiver Wert sein.

**max** *arg* *...*
: Akzeptiert ein oder mehrere numerische Argumente. Gibt das Argument mit dem größten Wert zurück.

**min** *arg* *...*
: Akzeptiert ein oder mehrere numerische Argumente. Gibt das Argument mit dem kleinsten Wert zurück.

**pow** *x y*
: Berechnet *x* hoch *y*. Ist *x* negativ, muss *y* ein Ganzzahl-Wert sein.

**rand**
: Gibt einen pseudozufälligen Gleitkommawert im Bereich (*0*,*1*) zurück. Der Generator ist ein einfacher linearer Kongruenzgenerator ohne kryptographische Sicherheit. Jedes Ergebnis von **rand** bestimmt vollständig alle zukünftigen Ergebnisse nachfolgender Aufrufe von **rand**; **rand** sollte daher nicht zur Erzeugung geheimer Folgen, etwa Einmalpasswörter, verwendet werden. Der Startwert wird aus der internen Systemuhr initialisiert oder kann mit der Funktion **srand** gesetzt werden.

**round** *arg*
: Ist *arg* ein Ganzzahlwert, gibt der Befehl *arg* zurück, andernfalls wird *arg* durch Runden in eine Ganzzahl umgewandelt und der umgewandelte Wert zurückgegeben.

**sin** *arg*
: Gibt den Sinus von *arg* zurück, gemessen in Radiant.

**sinh** *arg*
: Gibt den hyperbolischen Sinus von *arg* zurück. Würde das Ergebnis einen Überlauf verursachen, wird ein Fehler zurückgegeben.

**sqrt** *arg*
: Das Argument kann ein beliebiger nicht-negativer numerischer Wert sein. Gibt einen Gleitkommawert zurück, der die Quadratwurzel von *arg* ist. Kann **Inf** zurückgeben, wenn das Argument den Quadrat des maximalen Gleitkommawerts überschreitet.

**srand** *arg*
: Das *arg*, das eine Ganzzahl sein muss, setzt den Startwert des Zufallszahlengenerators von **rand** zurück. Gibt die erste Zufallszahl (siehe **rand**) aus diesem Startwert zurück. Jeder Interpreter hat seinen eigenen Startwert.

**tan** *arg*
: Gibt den Tangens von *arg* zurück, gemessen in Radiant.

**tanh** *arg*
: Gibt den hyperbolischen Tangens von *arg* zurück.

**wide** *arg*
: Das Argument kann ein beliebiger numerischer Wert sein. Der ganzzahlige Teil von *arg* wird bestimmt, dann werden die niederwertigen 64 Bits dieses Ganzzahlwerts als Ganzzahl zurückgegeben.


# Copyright

```
Copyright © 1993 The Regents of the University of California.
Copyright © 1994-2000 Sun Microsystems Incorporated.
Copyright © 2005, 2006 Kevin B. Kenny <kennykb@acm.org>.
```


[CrtMathFnc]: ../tcl-c/CrtMathFnc.md
[CrtObjCmd]: ../tcl-c/CrtObjCmd.md
[expr]: expr.md
[interp]: interp.md
[proc]: proc.md
[tclvars]: tclvars.md
