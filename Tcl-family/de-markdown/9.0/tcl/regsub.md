---
CommandName: regsub
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

# NAME

regsub - Ersetzungen auf Basis regulärer Ausdrücke

# ÜBERSICHT

::: {.synopsis} :::
[regsub]{.cmd} [switches]{.optarg} [exp]{.arg} [string]{.arg} [subSpec]{.arg} [varName]{.optarg} 
:::

# BESCHREIBUNG

Matcht den regulären Ausdruck *exp* gegen *string* und kopiert *string* entweder in die Variable *varName* oder gibt *string* zurück, wenn *varName* fehlt. (Reguläre Ausdrücke: Referenzseite **re_syntax**.) Bei einem Treffer wird beim Kopieren von *string* nach *varName* (bzw. als Rückgabewert ohne *varName*) der zu *exp* passende Teil von *string* durch *subSpec* ersetzt. Enthält *subSpec* „&“ oder „\0“, wird es in der Ersetzung durch den zu *exp* passenden Teil von *string* ersetzt. Enthält *subSpec* „\*n*“, wobei *n* eine Ziffer von 1 bis 9 ist, wird es durch den Teil von *string* ersetzt, der zum *n*. geklammerten Unterausdruck von *exp* passte. Zusätzliche Backslashes in *subSpec* verhindern die Sonderbedeutung von „&“, „\0“, „\*n*“ und Backslashes. Backslashes in *subSpec* kollidieren oft mit der Tcl-Parser-Verarbeitung; *subSpec* daher am besten in geschweifte Klammern setzen, wenn Backslashes vorkommen.

Beginnen die ersten Argumente von **regsub** mit **-**, gelten sie als Schalter. Unterstützt werden:

**-all**
: Alle in *string* zu *exp* passenden Bereiche werden gefunden und ersetzt. Ohne diesen Schalter nur der erste Treffer. Mit **-all** werden „&“- und „\*n*“-Sequenzen pro Ersetzung mit den Daten des jeweiligen Treffers aufgelöst.

**-command**
: *subSpec* ist kein Ersetzungs-Template mehr; „&“ und „\*n*“ haben keine Sonderbedeutung. *subSpec* muss ein Befehlspräfix sein (nicht-leere Liste). Der zu *exp* passende Teil von *string* und dann je der Treffer jedes erfassenden Unter-RE innerhalb von *exp* werden als weitere Listenelemente angehängt (ähnlich **regexp** **-inline**). Die fertige Liste wird als Tcl-Befehl ausgewertet; dessen Ergebnis ist die Ersetzungszeichenkette. Fehler oder Ausnahmen aus der Befehlsauswertung werden zu Fehlern/Ausnahmen von **regsub**.

::: {.info -version="TIP463"}
Ohne **-all** wird der Callback höchstens einmal aufgerufen (genau wenn der Ausdruck matcht). Mit **-all** für jede Trefferposition der Reihe nach. Die exakten Indexpositionen der Treffer stehen dem Skript nicht zur Verfügung.
:::    Siehe **BEISPIELE** unten.

**-expanded**
: Erweiterte RE-Syntax: Leerraum und Kommentare werden ignoriert. Entspricht **(?x)** (siehe **re_syntax**).

**-line**
: Zeilenumbruch-sensitives Matching. Standard: Zeilenumbruch ist ein normales Zeichen. Mit diesem Flag: „[^“-Klammerausdrücke und „.“ treffen keinen Zeilenumbruch; „^“ zusätzlich leere Zeichenkette nach jedem Zeilenumbruch; „$“ zusätzlich davor. Entspricht **-linestop** und **-lineanchor** zusammen oder **(?n)** (siehe **re_syntax**).

**-linestop**
: „[^“ und „.“ stoppen an Zeilenumbrüchen. Wie **(?p)** (siehe **re_syntax**).

**-lineanchor**
: „^“ und „$“ (Anker) treffen Zeilenanfang bzw. -ende. Wie **(?w)** (siehe **re_syntax**).

**-nocase**
: Großbuchstaben in *string* werden vor dem Match gegen *exp* in Kleinbuchstaben umgewandelt; Ersetzungen aus *subSpec* beziehen sich aber auf die unveränderte Form von *string*.

**-start** *index*
: Zeichenindex-Offset in *string*, ab dem gematcht wird (wie **string index**). Mit diesem Schalter trifft „^“ nicht den Zeilenanfang; \A trifft weiter den Stringanfang bei *index*. *index* wird auf die Stringgrenzen beschränkt.

**-|-**
: Ende der Schalter; das folgende Argument gilt als *exp*, auch wenn es mit **-** beginnt.


Ist *varName* angegeben, gibt der Befehl die Anzahl der gefundenen und ersetzten Trefferbereiche zurück, sonst die Zeichenkette nach der Ersetzung. Details zur Interpretation regulärer Ausdrücke: Manpage **regexp**.

# BEISPIELE

Jedes eigenständige Wort **foo** in der Variable *string* durch **bar** ersetzen:

```
regsub -all {\mfoo\M} $string bar string
```

oder (Syntax *basic regular expression*):

```
regsub -all {(?b)\<foo\>} $string bar string
```

Das erste Vorkommen des Worts **interesting** (beliebige Schreibweise) in Anführungszeichen setzen:

```
regsub -nocase {\yinteresting\y} $string {"&"} string
```

Alle Nicht-ASCII- und Tcl-relevanten Zeichen per **regsub** und **subst** in \u-Escapes umwandeln:

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

::: {.info -version="TIP463"}
Dasselbe lässt sich mit **regsub -command** erledigen, oft schneller. (Eine vollständig vorberechnete **string map** wäre noch schneller; der Aufwand für die Map bei so komplexer Transformation kann aber groß sein.)
:::

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

::: {.info -version="TIP463"}
URL-kodierte Zeichenkette dekodieren mit **regsub -command**, Lambda und **apply**:
:::
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

::: {.info -version="TIP463"}
Die Option **-command** eignet sich auch, um den Wirkungsbereich von Befehlen wie **string totitle** einzuschränken:
:::
```
set message "the quIck broWn fOX JUmped oVer the laZy dogS..."
puts [regsub -all -command {\w+} $message {string totitle}]
# → The Quick Brown Fox Jumped Over The Lazy Dogs..
```
