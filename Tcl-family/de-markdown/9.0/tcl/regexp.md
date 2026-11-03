---
CommandName: regexp
title: regexp
ManualSection: n
Version: 8.3
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - re_syntax(n)
 - regsub(n)
 - string(n)
Keywords:
 - match
 - parsing
 - pattern
 - regular expression
 - splitting
 - string
Copyright:
 - Copyright (c) 1998 Sun Microsystems, Inc.
---

# Name

regexp - Prüft einen regulären Ausdruck gegen eine Zeichenkette

# Übersicht

::: {.synopsis} :::
[regexp]{.cmd} [switches]{.optarg} [exp]{.arg} [string]{.arg} [matchVar]{.optarg} [subMatchVar subMatchVar]{.optdot}
:::

# Beschreibung

Stellt fest, ob der reguläre Ausdruck *exp* auf einen Teil von *string* oder auf die ganze Zeichenkette passt. Der Befehl gibt 1 zurück, wenn dies der Fall ist, und 0, wenn nicht, sofern nicht **-inline** angegeben ist (siehe unten). (Der Abgleich mit regulären Ausdrücken ist auf der Referenzseite [re\_syntax][re_syntax] beschrieben.)

Werden nach *string* weitere Argumente angegeben, gelten sie als Namen von Variablen, in denen Informationen darüber zurückgegeben werden, welche Teile von *string* auf *exp* gepasst haben. *matchVar* wird auf den Bereich von *string* gesetzt, der auf den gesamten Ausdruck *exp* gepasst hat. Die erste *subMatchVar* enthält die Zeichen in *string*, die auf den am weitesten links stehenden geklammerten Unterausdruck in *exp* gepasst haben. Die nächste *subMatchVar* enthält die Zeichen, die auf den nächsten geklammerten Unterausdruck rechts davon in *exp* gepasst haben, und so weiter.

Beginnen die ersten Argumente von **regexp** mit **-**, werden sie als Schalter behandelt. Derzeit werden die folgenden Schalter unterstützt (sie dürfen abgekürzt werden):

[-about]{.lit}
: Statt zu versuchen, den regulären Ausdruck abzugleichen, gibt der Befehl eine Liste mit Informationen über den regulären Ausdruck zurück. Das erste Element der Liste ist die Anzahl der Unterausdrücke. Das zweite Element ist eine Liste von Eigenschaftsnamen, die verschiedene Merkmale des regulären Ausdrucks beschreiben. Dieser Schalter ist vor allem zur Fehlersuche gedacht.

[-expanded]{.lit}
: Ermöglicht die erweiterte Syntax für reguläre Ausdrücke, bei der Leerraum und Kommentare ignoriert werden. Dies entspricht der Angabe der eingebetteten Option **(?x)** (siehe die Handbuchseite [re\_syntax][re_syntax]).

[-indices]{.lit}
: Ändert, was in *matchVar* und den *subMatchVar*-Argumenten gespeichert wird. Statt der passenden Zeichen aus *string* enthält jede Variable eine Liste aus zwei dezimalen Zeichenketten. Sie geben die Indizes des ersten und des letzten Zeichens des passenden Zeichenbereichs in *string* an.

[-line]{.lit}
: Aktiviert einen zeilenumbruchsensitiven Abgleich. Standardmäßig ist der Zeilenumbruch ein völlig gewöhnliches Zeichen ohne besondere Bedeutung. Mit diesem Schalter passen Klammerausdrücke der Form „\[^“ und „.“ niemals auf einen Zeilenumbruch. „^“ passt zusätzlich zu seiner normalen Funktion auf eine leere Zeichenkette nach jedem Zeilenumbruch, und „$“ passt zusätzlich zu seiner normalen Funktion auf eine leere Zeichenkette vor jedem Zeilenumbruch. Dieser Schalter entspricht der Angabe von **-linestop** und **-lineanchor** zusammen oder der eingebetteten Option **(?n)** (siehe die Handbuchseite [re\_syntax][re_syntax]).

[-linestop]{.lit}
: Ändert das Verhalten von Klammerausdrücken der Form „\[^“ und von „.“ so, dass sie an Zeilenumbrüchen anhalten. Dies entspricht der Angabe der eingebetteten Option **(?p)** (siehe die Handbuchseite [re\_syntax][re_syntax]).

[-lineanchor]{.lit}
: Ändert das Verhalten von „^“ und „$“ (den „Ankern“) so, dass sie auf den Anfang beziehungsweise das Ende einer Zeile passen. Dies entspricht der Angabe der eingebetteten Option **(?w)** (siehe die Handbuchseite [re\_syntax][re_syntax]).

[-nocase]{.lit}
: Bewirkt, dass Großbuchstaben in *string* beim Abgleich wie Kleinbuchstaben behandelt werden.

[-all]{.lit}
: Bewirkt, dass der reguläre Ausdruck so oft wie möglich in der Zeichenkette abgeglichen wird. Der Befehl gibt die Gesamtzahl der gefundenen Treffer zurück. Werden dabei Match-Variablen angegeben, enthalten sie nur Informationen über den letzten Treffer.

[-inline]{.lit}
: Bewirkt, dass der Befehl die Daten, die sonst in den Match-Variablen abgelegt würden, als Liste zurückgibt. Bei Verwendung von **-inline** dürfen keine Match-Variablen angegeben werden. Zusammen mit **-all** wird die Liste bei jedem Durchlauf verkettet, sodass stets eine flache Liste zurückgegeben wird. Bei jedem Treffer hängt der Befehl die Daten des Gesamttreffers sowie ein Element für jeden Unterausdruck des regulären Ausdrucks an. Beispiele:

    ```
    regexp -inline -- {\w(\w)} " inlined "
          → in n
    regexp -all -inline -- {\w(\w)} " inlined "
          → in n li i ne e
    ```

[-start]{.lit} [index]{.arg}
: Legt einen Zeichenindex in der Zeichenkette fest, ab dem der Abgleich des regulären Ausdrucks beginnt. Der Wert *index* wird genauso interpretiert wie das Argument *index* von [string index][string]. Bei Verwendung dieses Schalters passt „^“ nicht auf den Zeilenanfang, und \\A passt weiterhin auf den Anfang der Zeichenkette bei *index*. Wenn **-indices** angegeben ist, werden die Indizes ab dem absoluten Anfang der Eingabezeichenkette gezählt. *index* wird auf die Grenzen der Eingabezeichenkette beschränkt.

[--]{.lit}
: Markiert das Ende der Schalter. Das darauf folgende Argument wird als *exp* behandelt, auch wenn es mit einem **-** beginnt.


Gibt es mehr *subMatchVar*-Argumente als geklammerte Unterausdrücke in *exp* oder passt ein bestimmter Unterausdruck in *exp* nicht auf die Zeichenkette (etwa weil er in einem Teil des Ausdrucks lag, der nicht abgeglichen wurde), wird die entsprechende *subMatchVar* auf „**-1 -1**“ gesetzt, wenn **-indices** angegeben wurde, andernfalls auf eine leere Zeichenkette.

# Beispiele

Das erste Vorkommen eines Worts finden, das mit **foo** beginnt, aber nicht tatsächlich **foobar** ist, und die darauf folgenden Buchstaben bis zum Wortende in einer Variablen ablegen:

```
regexp {\mfoo(?!bar\M)(\w*)} $string -> restOfWord
```

Beachten Sie, dass die gesamte passende Teilzeichenkette in der Variablen „**->**“ abgelegt wurde. Dieser Name wurde gewählt, weil er gut aussieht, da uns der Inhalt dieser Variablen eigentlich nicht interessiert.

Den Index des Worts **badger** (in beliebiger Schreibung) in einer Zeichenkette finden und in der Variablen **location** speichern:

```
regexp -indices {(?i)\mbadger\M} $string location
```

Dies lässt sich auch als Abgleich mit einem *einfachen* regulären Ausdruck schreiben (statt der voreingestellten Syntax der *erweiterten* regulären Ausdrücke), indem dem Ausdruck ein passendes Flag vorangestellt wird:

```
regexp -indices {(?ib)\<badger\>} $string location
```

Dies zählt die Oktalziffern in einer Zeichenkette:

```
regexp -all {[0-7]} $string
```

Dies listet alle Wörter (also alle Folgen von Zeichen, die kein Leerraum sind) in einer Zeichenkette auf. Es ist als leistungsfähigere Variante des Befehls [split] nützlich:

```
regexp -all -inline {\S+} $string
```


[re_syntax]: re_syntax.md
[split]: split.md
[string]: string.md
