---
CommandName: switch
title: switch
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - for(n)
 - if(n)
 - regexp(n)
Keywords:
 - switch
 - match
 - regular expression
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# Name

switch - Wertet eines von mehreren Skripten aus, abhängig von einem Wert

# Übersicht

::: {.synopsis} :::
[switch]{.cmd} [options]{.optarg} [value]{.arg} [pattern]{.arg} [body]{.arg} [pattern body]{.optdot}
[switch]{.cmd} [options]{.optarg} [value]{.arg} [{pattern body ?pattern body ...?}]{.arg}
:::

# Beschreibung

**switch** vergleicht sein Argument *value* nacheinander mit jedem *pattern*. Sobald ein *pattern* zu *value* passt, wird das folgende *body* rekursiv ausgewertet; dessen Ergebnis liefert **switch**. Ist das letzte *pattern* **default**, passt es auf alles. Passt kein *pattern* und gibt es kein **default**, gibt **switch** eine leere Zeichenkette zurück.

Beginnen die ersten Argumente mit **-**, gelten sie als Optionen — außer es gibt genau zwei Argumente (dann ist das erste *value*, das zweite die *pattern*/*body*-Liste). Unterstützte Optionen:

[-exact]{.lit}
: Exakter Vergleich von *value* mit dem Muster (Standard).

[-glob]{.lit}
: Glob-Vergleich (wie [string match][string]).

[-regexp]{.lit}
: Reguläre Ausdrücke (siehe [re\_syntax][re_syntax]).

[-nocase]{.lit}
: Vergleich ohne Berücksichtigung der Groß-/Kleinschreibung.

[-matchvar]{.lit} [varName]{.arg}
: Nur mit **-regexp**: Variable erhält die Trefferliste der Engine (gesamtes Match, dann Capturing Groups). Bei **default**: leere Liste. Kombinierbar mit **-indexvar**.

[-indexvar]{.lit} [varName]{.arg}
: Nur mit **-regexp**: Indizes der Treffer (zwei Elemente Start/Ende pro Teilstring, analog zur Option **-indices** von [regexp]). Bei **default**: leere Liste. Kombinierbar mit **-matchvar**.

[--]{.lit}
: Ende der Optionen; das folgende Argument ist *value*, auch wenn es mit **-** beginnt. Nicht nötig, wenn Muster und Körper in einem Listenargument stehen.


Zwei Syntaxen für *pattern* und *body*: getrennte Argumente (Substitutionen in Mustern/Körpern möglich) oder eine Liste aller Paare (mehrzeilige **switch**-Befehle; Muster in geschweiften Klammern ohne Substitution — Verhalten kann abweichen).

Ist *body* als **-** angegeben, gilt der *body* des nächsten Musters auch hier (Kette von **-** möglich). So teilen sich mehrere Muster einen *body*.

Kommentare in **switch** nur **innerhalb** des Ausführungskörpers eines Musters, nicht zwischen den Mustern.

# Beispiele

Abgleich mit Variablen (Ergebnis *2*):

```
set foo "abc"
switch abc a - b {expr {1}} $foo {expr {2}} default {expr {3}}
```

Glob und Durchfall (**-** als *body*); Ergebnis *1*:

```
switch -glob aaab {
    a*b     -
    b       {expr {1}}
    a*      {expr {2}}
    default {expr {3}}
}
```

**default** (muss zuletzt stehen); Ergebnis *3*:

```
switch xyz {
    a -
    b {
        # Kommentar hier erlaubt
        expr {1}
    }
    c {
        expr {2}
    }
    default {
        expr {3}
    }
}
```

**-matchvar** bei regulären Ausdrücken:

```
switch -regexp -matchvar foo -- $bar {
    a(b*)c {
        puts "Found [string length [lindex $foo 1]] 'b's"
    }
    d(e*)f(g*)h {
        puts "Found [string length [lindex $foo 1]] 'e's and\
                [string length [lindex $foo 2]] 'g's"
    }
}
```


[re_syntax]: re_syntax.md
[regexp]: regexp.md
[string]: string.md
