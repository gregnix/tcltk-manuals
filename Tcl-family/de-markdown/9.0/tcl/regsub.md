---
CommandName: regsub
title: regsub
ManualSection: n
Version: 8.3
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - regexp(n)
 - re_syntax(n)
 - subst(n)
 - string(n)
Keywords:
 - match
 - pattern
 - quoting
 - regular expression
 - substitution
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
 - Copyright (c) 2000 Scriptics Corporation.
---

# Name

regsub - Ersetzungen auf Basis regulärer Ausdrücke

# Übersicht

::: {.synopsis} :::
[regsub]{.cmd} [switches]{.optarg} [exp]{.arg} [string]{.arg} [subSpec]{.arg} [varName]{.optarg}
:::

# Beschreibung

Dieser Befehl vergleicht den regulären Ausdruck *exp* mit *string* und kopiert *string* entweder in die Variable, deren Name in *varName* angegeben ist, oder gibt *string* zurück, wenn *varName* fehlt. (Der Vergleich mit regulären Ausdrücken ist auf der Referenzseite [re\_syntax][re_syntax] beschrieben.) Gibt es einen Treffer, wird beim Kopieren von *string* nach *varName* (bzw. in das Ergebnis dieses Befehls, wenn *varName* fehlt) der Teil von *string*, auf den *exp* gepasst hat, durch *subSpec* ersetzt. Enthält *subSpec* ein „&“ oder „\\0“, wird dieses bei der Ersetzung durch den Teil von *string* ersetzt, auf den *exp* gepasst hat. Enthält *subSpec* ein „\\*n*“, wobei *n* eine Ziffer zwischen 1 und 9 ist, wird es bei der Ersetzung durch den Teil von *string* ersetzt, auf den der *n*-te geklammerte Unterausdruck von *exp* gepasst hat. In *subSpec* können zusätzliche Backslashes verwendet werden, um die Sonderbedeutung von „&“, „\\0“, „\\*n*“ und Backslashes aufzuheben. Backslashes in *subSpec* vertragen sich oft schlecht mit der Backslash-Verarbeitung des Tcl-Parsers. Daher ist es im Allgemeinen am sichersten, *subSpec* in geschweifte Klammern zu setzen, wenn es Backslashes enthält.

Beginnen die ersten Argumente von **regsub** mit **-**, werden sie als Schalter behandelt. Derzeit werden folgende Schalter unterstützt:

[-all]{.lit}
: Alle Bereiche in *string*, auf die *exp* passt, werden gefunden, und für jeden dieser Bereiche wird eine Ersetzung durchgeführt. Ohne diesen Schalter wird nur der erste passende Bereich gefunden und ersetzt. Ist **-all** angegeben, werden die Sequenzen „&“ und „\\*n*“ bei jeder Ersetzung mit den Angaben des jeweiligen Treffers behandelt.

[-command]{.lit}
: [Ändert die Behandlung von *subSpec* so, dass es nicht als Vorlage für eine Ersetzungszeichenkette behandelt wird und die Teilzeichenketten „&“ und „\\*n*“ keine Sonderbedeutung mehr haben. Stattdessen muss *subSpec* ein Befehlspräfix sein, also eine nicht leere Liste. Die Teilzeichenkette von *string*, auf die *exp* passt, und danach jede Teilzeichenkette, auf die ein erfassender Unterausdruck innerhalb von *exp* passt, werden als weitere Elemente an diese Liste angehängt. (Die angehängten Elemente entsprechen weitgehend dem, was [regexp] **-inline** zurückgeben würde.) Die vervollständigte Liste wird dann als Tcl-Befehl ausgewertet, und das Ergebnis dieses Befehls ist die Ersetzungszeichenkette. Jeder Fehler und jede Ausnahme aus der Auswertung des Befehls wird zu einem Fehler bzw. einer Ausnahme des Befehls **regsub**.]{version="TIP463"}

    Ist **-all** nicht ebenfalls angegeben, wird der Callback-Befehl höchstens einmal aufgerufen (genau dann, wenn der reguläre Ausdruck passt). Ist **-all** angegeben, wird der Callback-Befehl der Reihe nach für jede Trefferstelle aufgerufen. Die genauen Indizes der Trefferstellen werden dem Skript nicht zur Verfügung gestellt.

    Anschauliche Fälle finden Sie unten unter [Beispiele].

[-expanded]{.lit}
: Ermöglicht die erweiterte Syntax für reguläre Ausdrücke, bei der Leerraum und Kommentare ignoriert werden. Das entspricht der Angabe der eingebetteten Option **(?x)** (siehe die Handbuchseite [re\_syntax][re_syntax]).

[-line]{.lit}
: Aktiviert den zeilenumbruchsensitiven Vergleich. Standardmäßig ist der Zeilenumbruch ein völlig gewöhnliches Zeichen ohne besondere Bedeutung. Mit diesem Schalter passen Klammerausdrücke mit „\[^“ und „.“ nie auf einen Zeilenumbruch, „^“ passt zusätzlich zu seiner normalen Funktion auf eine leere Zeichenkette nach jedem Zeilenumbruch, und „$“ passt zusätzlich zu seiner normalen Funktion auf eine leere Zeichenkette vor jedem Zeilenumbruch. Dieser Schalter entspricht der gemeinsamen Angabe von **-linestop** und **-lineanchor** oder der eingebetteten Option **(?n)** (siehe die Handbuchseite [re\_syntax][re_syntax]).

[-linestop]{.lit}
: Ändert das Verhalten von Klammerausdrücken mit „\[^“ und von „.“ so, dass sie an Zeilenumbrüchen enden. Das entspricht der Angabe der eingebetteten Option **(?p)** (siehe die Handbuchseite [re\_syntax][re_syntax]).

[-lineanchor]{.lit}
: Ändert das Verhalten von „^“ und „$“ (den „Ankern“) so, dass sie auf den Anfang bzw. das Ende einer Zeile passen. Das entspricht der Angabe der eingebetteten Option **(?w)** (siehe die Handbuchseite [re\_syntax][re_syntax]).

[-nocase]{.lit}
: Großbuchstaben in *string* werden vor dem Vergleich mit *exp* in Kleinbuchstaben umgewandelt; die in *subSpec* angegebenen Ersetzungen verwenden jedoch die ursprüngliche, nicht umgewandelte Form von *string*.

[-start]{.lit} [index]{.arg}
: Legt einen Zeichenindex in der Zeichenkette fest, ab dem der Vergleich mit dem regulären Ausdruck beginnt. Der Wert *index* wird genauso interpretiert wie das Argument *index* von [string index][string]. Bei Verwendung dieses Schalters passt „^“ nicht auf den Zeilenanfang, und \\A passt weiterhin auf den Anfang der Zeichenkette bei *index*. *index* wird auf die Grenzen der Eingabezeichenkette beschränkt.

[--]{.lit}
: Markiert das Ende der Schalter. Das darauf folgende Argument wird als *exp* behandelt, auch wenn es mit **-** beginnt.


Ist *varName* angegeben, gibt der Befehl die Anzahl der gefundenen und ersetzten Trefferbereiche zurück, andernfalls wird die Zeichenkette nach der Ersetzung zurückgegeben. Einzelheiten zur Interpretation regulärer Ausdrücke finden Sie auf der Handbuchseite [regexp].

# Beispiele

Jedes Vorkommen von **foo**, das ein eigenständiges Wort ist, (in der Zeichenkette in der Variablen *string*) durch **bar** ersetzen:

```
regsub -all {\mfoo\M} $string bar string
```

oder (mit der Syntax für „grundlegende reguläre Ausdrücke“):

```
regsub -all {(?b)\<foo\>} $string bar string
```

Das erste Vorkommen des Wortes **interesting** in doppelte Anführungszeichen setzen, unabhängig von seiner Groß- und Kleinschreibung.

```
regsub -nocase {\yinteresting\y} $string {"&"} string
```

Alle Nicht-ASCII-Zeichen und alle für Tcl bedeutsamen Zeichen mit **regsub** und [subst] zusammen in \\u-Escape-Sequenzen umwandeln:

```
# This RE is just a character class for almost everything "bad"
set RE {[][{};#\\\$ \r\t\u0080-\uffff]}

# We will substitute with a fragment of Tcl script in brackets
set substitution {[format \\\\u%04x [scan "\\&" %c]]}

# Now we apply the substitution to get a subst-string that
# will perform the computational parts of the conversion. Note
# that newline is handled specially through string map since
# backslash-newline is a special sequence.
set quoted [subst [string map {\n {\\u000a}} \
        [regsub -all $RE $string $substitution]]]
```

[Die obige Operation lässt sich auch mit **regsub -command** durchführen, was oft schneller ist. (Ein vollständig vorab berechnetes [string map][string] wäre noch schneller, aber der Aufwand für die Berechnung der Zuordnung kann bei einer so komplexen Transformation wie dieser recht groß sein.)]{version="TIP463"}

```
# This RE is just a character class for everything "bad"
set RE {[][{};#\\\$\s\u0080-\uffff]}

# This encodes what the RE described above matches
proc encodeChar {ch} {
    # newline is handled specially since backslash-newline is a
    # special sequence.
    if {$ch eq "\n"} {
        return "\\u000a"
    }
    # No point in writing this as a one-liner
    scan $ch %c charNumber
    format "\\u%04x" $charNumber
}

set quoted [regsub -all -command $RE $string encodeChar]
```

Eine URL-kodierte Zeichenkette mit **regsub -command**, einem Lambda-Ausdruck und dem Befehl [apply] dekodieren.

```
# Match one of the sequences in a URL-encoded string that needs
# fixing, converting + to space and %XX to the right character
# (e.g., %7e becomes ~)
set RE {(\+)|%([0-9A-Fa-f]{2})}

# Note that -command uses a command prefix, not a command name
set decoded [regsub -all -command $RE $string {apply {{- p h} {
    # + is a special case; handle directly
    if {$p eq "+"} {
        return " "
    }
    # convert hex to a char
    scan $h %x charNumber
    format %c $charNumber
}}}]
```

Die Option **-command** kann auch nützlich sein, um den Wirkungsbereich von Befehlen wie [string totitle][string] einzuschränken:

```
set message "the quIck broWn fOX JUmped oVer the laZy dogS..."
puts [regsub -all -command {\w+} $message {string totitle}]
# → The Quick Brown Fox Jumped Over The Lazy Dogs..
```


[apply]: apply.md
[re_syntax]: re_syntax.md
[regexp]: regexp.md
[string]: string.md
[subst]: subst.md
