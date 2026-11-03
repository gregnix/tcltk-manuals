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

Der Befehl **switch** vergleicht sein Argument *value* der Reihe nach mit jedem der Argumente *pattern*. Sobald er ein *pattern* findet, das zu *value* passt, wertet er das folgende Argument *body* aus, indem er es rekursiv an den Tcl-Interpreter übergibt, und gibt das Ergebnis dieser Auswertung zurück. Ist das letzte Argument *pattern* **default**, passt es auf alles. Passt kein Argument *pattern* zu *value* und ist kein Vorgabezweig angegeben, gibt der Befehl **switch** eine leere Zeichenkette zurück.

Beginnen die ersten Argumente von **switch** mit **-**, werden sie als Optionen behandelt. Das gilt nicht, wenn **switch** genau zwei Argumente erhält; dann muss das erste *value* und das zweite die *pattern*/*body*-Liste sein. Derzeit werden die folgenden Optionen unterstützt (sie dürfen abgekürzt werden):

[-exact]{.lit}
: Verwendet beim Vergleich von *value* mit einem Muster einen exakten Vergleich. Das ist die Voreinstellung.

[-glob]{.lit}
: Verwendet beim Vergleich von *value* mit den Mustern einen Glob-Vergleich, d. h. denselben, den der Befehl [string match][string] implementiert.

[-regexp]{.lit}
: Verwendet beim Vergleich von *value* mit den Mustern reguläre Ausdrücke, wie auf der Handbuchseite [re\_syntax][re_syntax] beschrieben.

[-nocase]{.lit}
: Bewirkt, dass bei den Vergleichen Groß- und Kleinschreibung nicht unterschieden wird.

[-matchvar]{.lit} [varName]{.arg}
: Diese Option ist nur zulässig, wenn auch **-regexp** angegeben ist. Sie legt den Namen einer Variablen fest, in die die Liste der Treffer geschrieben wird, die die Engine für reguläre Ausdrücke gefunden hat. Das erste Element dieser Liste ist die gesamte passende Teilzeichenkette der Eingabezeichenkette (d. h. des Arguments *value* von **switch**). Das zweite Element ist die Teilzeichenkette, die zur ersten einfangenden Klammer des passenden regulären Ausdrucks passt, und so weiter. Wird der Zweig **default** gewählt, wird die leere Liste in die Variable geschrieben. Diese Option kann zusammen mit der Option **-indexvar** angegeben werden.

[-indexvar]{.lit} [varName]{.arg}
: Diese Option ist nur zulässig, wenn auch **-regexp** angegeben ist. Sie legt den Namen einer Variablen fest, in die die Liste der Indizes geschrieben wird, die auf die von der Engine für reguläre Ausdrücke gefundenen passenden Teilzeichenketten verweisen. Das erste Element dieser Liste ist eine Liste mit zwei Elementen: dem Index des Anfangs und dem Index des ersten Zeichens nach dem Ende der gesamten passenden Teilzeichenkette der Eingabezeichenkette (d. h. des Arguments *value* von **switch**), ähnlich wie bei der Option **-indices** von [regexp]. Entsprechend verweist das zweite Element der Liste auf die erste einfangende Klammer des passenden regulären Ausdrucks, und so weiter. Wird der Zweig **default** gewählt, wird die leere Liste in die Variable geschrieben. Diese Option kann zusammen mit der Option **-matchvar** angegeben werden.

[--]{.lit}
: Markiert das Ende der Optionen. Das darauf folgende Argument wird als *value* behandelt, auch wenn es mit **-** beginnt. Das ist nicht nötig, wenn die Muster und Rümpfe zusammen in einem einzigen Argument gruppiert sind.


Für die Argumente *pattern* und *body* gibt es zwei Syntaxen. Die erste verwendet für jedes Muster und jeden Befehl ein eigenes Argument; diese Form ist praktisch, wenn auf einige der Muster oder Befehle Ersetzungen angewendet werden sollen. Die zweite Form fasst alle Muster und Befehle in einem einzigen Argument zusammen. Dieses Argument muss eine gültige Listenstruktur haben, deren Elemente die Muster und Befehle sind. Mit der zweiten Form lassen sich mehrzeilige switch-Befehle leicht schreiben: Die geschweiften Klammern um die ganze Liste machen einen Backslash am Ende jeder Zeile überflüssig. Da die Argumente *pattern* in der zweiten Form in geschweiften Klammern stehen, wird auf sie keine Befehls- oder Variablenersetzung angewendet. Dadurch verhält sich die zweite Form in manchen Fällen anders als die erste.

Ist ein *body* als „**-**“ angegeben, wird der *body* des nächsten Musters auch als Rumpf für dieses Muster verwendet. Hat auch das nächste Muster den Rumpf „**-**“, wird der Rumpf danach verwendet, und so weiter. So können sich mehrere Muster einen einzigen *body* teilen.

Achten Sie darauf, wie Sie Kommentare in **switch**-Befehle setzen. Kommentare sollten nur **innerhalb** des ausgeführten Rumpfs eines der Muster stehen und nicht zwischen die Muster gemischt werden.

# Beispiele

Der Befehl **switch** kann nicht nur mit Literalen, sondern auch mit Variablen vergleichen, wie hier gezeigt (das Ergebnis ist *2*):

```
set foo "abc"
switch abc a - b {expr {1}} $foo {expr {2}} default {expr {3}}
```

Ein Glob-Vergleich mit dem durchfallenden Rumpf ist eine Alternative zu regulären Ausdrücken mit Alternativen, wie hier zu sehen (das Ergebnis ist *1*):

```
switch -glob aaab {
    a*b     -
    b       {expr {1}}
    a*      {expr {2}}
    default {expr {3}}
}
```

Wenn nichts passt, wird die Klausel **default** gewählt (sie muss zuletzt stehen). Dieses Beispiel hat das Ergebnis *3*:

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

Beim Vergleich mit regulären Ausdrücken lässt sich mit der Option **-matchvar** leicht ermitteln, was genau gepasst hat:

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
