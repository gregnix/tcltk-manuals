---
CommandName: dict
title: dict
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - append(n)
 - array(n)
 - foreach(n)
 - incr(n)
 - list(n)
 - lappend(n)
 - lmap(n)
 - set(n)
Keywords:
 - dictionary
 - create
 - update
 - lookup
 - iterate
 - filter
 - map
Copyright:
 - Copyright (c) 2003 Donal K. Fellows
---

# Name

dict - Verarbeitet Dictionaries

# Übersicht

::: {.synopsis} :::
[dict]{.cmd} [option]{.arg} [arg]{.arg} [arg]{.optdot}
:::

# Beschreibung

Führt je nach *option* eine von mehreren Operationen auf Dictionary-Werten oder Variablen mit Dictionary-Werten aus (siehe Abschnitt [Dictionary-Werte]). Zulässige *option*s (abkürzbar):

[dict]{.cmd} [append]{.sub} [dictionaryVariable]{.arg} [key]{.arg} [string]{.optdot}
: Hängt die angegebenen Zeichenketten an den Wert an, den *key* im Dictionary in *dictionaryVariable* abbildet, und schreibt das resultierende Dictionary zurück in die Variable. Fehlende Schlüssel gelten als leere Zeichenkette. Gibt das aktualisierte Dictionary zurück. [Verweist *dictionaryVariable* auf ein nicht existierendes Array-Element mit Standardwert, wird der Standardwert vor dem Anhängen als Dictionary-Wert verwendet.]{version="TIP508"}

[dict]{.cmd} [create]{.sub} [key value]{.optdot}
: Gibt ein neues Dictionary mit allen als Argumente angegebenen Schlüssel/Wert-Paaren zurück (Schlüssel und Werte abwechselnd).

[dict]{.cmd} [exists]{.sub} [dictionaryValue]{.arg} [key]{.arg} [key]{.optdot}
: Gibt einen booleschen Wert zurück, ob der Schlüssel (oder Pfad durch verschachtelte Dictionaries) in *dictionaryValue* existiert — genau dann, wenn **dict get** auf diesem Pfad erfolgreich wäre.

[dict]{.cmd} [filter]{.sub} [dictionaryValue]{.arg} [filterType]{.arg} [arg]{.arg} [arg]{.optdot}
: Nimmt ein Dictionary und gibt ein neues zurück, das nur die passenden Schlüssel/Wert-Paare enthält. Unterstützte *filterType* (abkürzbar):

    [dict]{.cmd} [filter]{.sub} [dictionaryValue]{.arg} [key]{.lit} [globPattern]{.optdot}
    : Die key-Regel behält Paare, deren Schlüssel einem der Muster entsprechen (Stil von [string match][string]).

    [dict]{.cmd} [filter]{.sub} [dictionaryValue]{.arg} [script]{.lit} [{keyVariable valueVariable}]{.arg} [script]{.arg}
    : Die script-Regel weist Schlüssel und Wert den Variablen zu und wertet *script* aus (boolesches Ergebnis). Das erste Argument nach der Regel ist eine zweielementige Liste. [TCL\_BREAK][catch] beendet die weitere Prüfung; [TCL\_CONTINUE][catch] entspricht „falsch“. Paare werden in Einfügereihenfolge getestet.

    [dict]{.cmd} [filter]{.sub} [dictionaryValue]{.arg} [value]{.lit} [globPattern]{.optdot}
    : Die value-Regel behält Paare, deren Werte einem der Muster entsprechen ([string match][string]).


[dict]{.cmd} [for]{.sub} [{keyVariable valueVariable}]{.arg} [dictionaryValue]{.arg} [body]{.arg}
: Drei Argumente: zweielementige Liste von Variablennamen, Dictionary-Wert, Skript (wie [foreach]). Ergebnis: leere Zeichenkette. [TCL\_BREAK][catch] beendet die Iteration sofort erfolgreich; [TCL\_CONTINUE][catch] wie [TCL\_OK][catch]. Iterationsreihenfolge = Einfügereihenfolge der Schlüssel.

[dict]{.cmd} [get]{.sub} [dictionaryValue]{.arg} [key]{.optdot}
: Liest den Wert zu *key* aus *dictionaryValue*. Mehrere *key*s: wie **dict get \[dict get $dictVal $key\] …** mit den restlichen Schlüsseln — Nachschlagen in verschachtelten Dictionaries. Beispiel, äquivalent:

    ```
    dict get $dict foo bar spong
    dict get [dict get [dict get $dict foo] bar] spong
    ```

    Ohne Schlüssel: Liste von Paaren wie [array get][array] (Schlüssel, Wert, …).

    Fehler, wenn ein Schlüssel fehlt.

[dict]{.cmd} [getdef]{.sub} [dictionaryValue]{.arg} [key]{.optdot} [key]{.arg} [default]{.arg}
: siehe unten ...

[dict]{.cmd} [getwithdefault]{.sub} [dictionaryValue]{.arg} [key]{.optdot} [key]{.arg} [default]{.arg}
: [Wie **dict get** (mindestens ein *key*), aber bei fehlendem Schlüssel (oder fehlendem Schlüssel auf dem Pfad) wird *default* zurückgegeben statt eines Fehlers.]{version="TIP342"}

    Mindestens ein *key* ist erforderlich. **dict getdef** und **dict getwithdefault** sind Aliase.

[dict]{.cmd} [incr]{.sub} [dictionaryVariable]{.arg} [key]{.arg} [increment]{.optarg}
: Addiert *increment* (Ganzzahl, Standard 1) zum Wert von *key* in *dictionaryVariable* und schreibt zurück. Fehlende Schlüssel gelten als 0. Fehler, wenn der bestehende Wert keine Ganzzahl ist. Gibt das aktualisierte Dictionary zurück. [Array-Standardwert wie bei **dict append**.]{version="TIP508"}

[dict]{.cmd} [info]{.sub} [dictionaryValue]{.arg}
: Informationen zum Dictionary (für Menschen); Format implementationsabhängig. Bei Hash-Tabellen oft [Tcl\_HashStats][Hash], analog [array statistics][array].

[dict]{.cmd} [keys]{.sub} [dictionaryValue]{.arg} [globPattern]{.optarg}
: Liste aller Schlüssel; mit Muster nur passende ([string match][string]). Reihenfolge = Einfügereihenfolge.

[dict]{.cmd} [lappend]{.sub} [dictionaryVariable]{.arg} [key]{.arg} [value]{.optdot}
: Hängt *value* an die Listen-Variable an, die *key* abbildet; fehlende Schlüssel = leere Liste. Fehler, wenn der Wert keine Liste ist. Gibt das aktualisierte Dictionary zurück. [Array-Standardwert wie oben.]{version="TIP508"}

[dict]{.cmd} [map]{.sub} [{keyVariable valueVariable}]{.arg} [dictionaryValue]{.arg} [body]{.arg}
: Transformation je Mapping; neues Dictionary (wie [lmap]). Bei normalem [TCL\_OK][catch] (im Gegensatz zu [error] usw.) landet das Skriptergebnis im Akkumulator unter dem aktuellen *keyVariable*-Inhalt.

    [break] beendet sofort; [continue] überspringt die aktuelle Iteration ohne Änderung am Akkumulator. Reihenfolge wie **dict for**.

[dict]{.cmd} [merge]{.sub} [dictionaryValue]{.optdot}
: Dictionary mit allen Inhalten der Argumente; bei gleichem Schlüssel gewinnt der Wert aus dem letzten Dictionary mit diesem Schlüssel.

[dict]{.cmd} [remove]{.sub} [dictionaryValue]{.arg} [key]{.optdot}
: Kopie ohne die genannten Schlüssel; kein Schlüssel nötig; fehlende Schlüssel sind unkritisch.

[dict]{.cmd} [replace]{.sub} [dictionaryValue]{.arg} [key value]{.optdot}
: Kopie mit geänderten oder neuen Paaren; ohne Paare erlaubt; Schlüssel ohne Wert ist Fehler.

[dict]{.cmd} [set]{.sub} [dictionaryVariable]{.arg} [key]{.arg} [key]{.optdot} [value]{.arg}
: Setzt in *dictionaryVariable* die Abbildung von *key* (bzw. verschachtelter Pfad) auf *value*; erzeugt bei Bedarf verschachtelte Dictionaries. Gibt das aktualisierte Dictionary zurück. [Array-Standardwert wie oben.]{version="TIP508"}

[dict]{.cmd} [size]{.sub} [dictionaryValue]{.arg}
: Anzahl der Schlüssel/Wert-Paare.

[dict]{.cmd} [unset]{.sub} [dictionaryVariable]{.arg} [key]{.arg} [key]{.optdot}
: Entfernt die Abbildung für *key* (Pfad durch verschachtelte Dictionaries); mindestens ein *key*; der letzte auf dem Pfad darf fehlen, alle anderen müssen existieren. Gibt das aktualisierte Dictionary zurück. [Array-Standardwert wie oben.]{version="TIP508"}

[dict]{.cmd} [update]{.sub} [dictionaryVariable]{.arg} [key]{.arg} [varName]{.arg} [key varName]{.optdot} [body]{.arg}
: Führt *body* aus, wobei jeder *key* (aus *dictionaryVariable*) der Variable *varName* zugeordnet ist. Fehlender Schlüssel = unset *varName*. Nach *body* (auch bei Fehler oder Ausnahme) werden Änderungen an den *varName*s zurück ins Dictionary geschrieben — außer *dictionaryVariable* wird unlesbar, dann werden Updates verworfen. Ergebnis von **dict update** ist (ohne Fehler) das Ergebnis von *body*. [Array-Standardwert wie oben.]{version="TIP508"}

    Jede *varName* liegt im umschließenden Gültigkeitsbereich; empfohlen nur lokal ([proc], Lambda für [apply], Methode). Die Variablen existieren nach dem Befehl weiter (sofern nicht [unset]).

    Keine Traces: Änderungen am Dictionary nur beim Beenden von *body*.

[dict]{.cmd} [values]{.sub} [dictionaryValue]{.arg} [globPattern]{.optarg}
: Liste aller Werte; mit Muster nur passende Werte ([string match][string]). Reihenfolge der Werte = Einfügereihenfolge der zugehörigen Schlüssel.

[dict]{.cmd} [with]{.sub} [dictionaryVariable]{.arg} [key]{.optdot} [body]{.arg}
: Führt *body* aus; jeder Schlüssel in *dictionaryVariable* wird einer gleichnamigen Variable zugeordnet (ähnlich **dict update**). Mit *key*s: Pfad durch verschachtelte Dictionaries; innerstes Dictionary wird geöffnet. Wie bei **dict update**: unlesbare Variable oder zerstörte Pfadkette verwirft Updates. Ergebnis ist (ohne Fehler) das Ergebnis von *body*. [Array-Standardwert wie oben.]{version="TIP508"}

    Die Variablen liegen im umschließenden Gültigkeitsbereich von **dict with**; empfohlen nur lokal ([proc], Lambda für [apply], Methode). Die Variablen bleiben nach dem Befehl bestehen (sofern nicht [unset]).

    Keine Traces: Änderungen am Dictionary nur beim Beenden von *body*.

    Ist der Inhalt von *dictionaryVariable* beim Beenden von *body* kein Dictionary (z. B. wenn der Name mit einem Schlüssel kollidiert), tritt ein Fehler auf — nicht empfohlen, wenn Schlüssel mit *dictionaryVariable* kollidieren können. Mappt der Schlüssel auf ein Dictionary, wird das innere in das äußere eingefügt; siehe [Beispiele].


# Dictionary-Werte

Dictionaries sind Werte mit effizienter, reihenfolgetreuer Abbildung beliebiger Schlüssel auf beliebige Werte; jeder Schlüssel mappt auf genau einen Wert. Textuell entsprechen sie einer Liste mit gerader Elementanzahl (je Mapping zwei Elemente). Erzeugt ein Befehl aus einem Dictionary ein neues (Rückgabe oder Zurückschreiben in die Ausgangsvariable), bleibt die Schlüsselreihenfolge erhalten — gelöschte Schlüssel entfallen, neue kommen ans Ende. Bei doppelten Schlüsseln in der Zeichenkettendarstellung zählt nur der letzte Wert; „apple banana“ und „apple carrot apple banana“ sind äquivalente Dictionaries (unterschiedliche Darstellung).

Operationen, die ein neues Dictionary aus einem alten ableiten (**dict set**, **dict unset**, …), erhalten die Schlüsselreihenfolge; neue Schlüssel werden angehängt, entfernte gestrichen.

# Beispiele

Grundlegende Dictionary-Nutzung:

```
# Dictionary: Endungen -> Beschreibungen
set filetypes [dict create .txt "Text File" .tcl "Tcl File"]

# Ergänzen/Aktualisieren
dict set filetypes .tcl "Tcl Script"
dict set filetypes .tm  "Tcl Module"
dict set filetypes .gif "GIF Image"
dict set filetypes .png "PNG Image"

# Einfaches Lesen
set ext ".tcl"
set desc [dict get $filetypes $ext]
puts "$ext is for a $desc"

# Mit Existenztest
foreach filename [glob *] {
    set ext [file extension $filename]
    if {[dict exists $filetypes $ext]} {
        puts "$filename is a [dict get $filetypes $ext]"
    }
}
```

Verschachtelte Dictionaries:

```
# Data for one employee
dict set employeeInfo 12345-A forenames "Joe"
dict set employeeInfo 12345-A surname   "Schmoe"
dict set employeeInfo 12345-A street "147 Short Street"
dict set employeeInfo 12345-A city   "Springfield"
dict set employeeInfo 12345-A phone  "555-1234"
# Data for another employee
dict set employeeInfo 98372-J forenames "Anne"
dict set employeeInfo 98372-J surname   "Other"
dict set employeeInfo 98372-J street "32995 Oakdale Way"
dict set employeeInfo 98372-J city   "Springfield"
dict set employeeInfo 98372-J phone  "555-8765"
# The above data probably ought to come from a database...

# Print out some employee info
set i 0
puts "There are [dict size $employeeInfo] employees"
dict for {id info} $employeeInfo {
    puts "Employee #[incr i]: $id"
    dict with info {
        puts "   Name: $forenames $surname"
        puts "   Address: $street, $city"
        puts "   Telephone: $phone"
    }
}
# Another way to iterate and pick out names...
foreach id [dict keys $employeeInfo] {
    puts "Hello, [dict get $employeeInfo $id forenames]!"
}
```

Lokalisierbare Variante von [string toupper][string]:

```
# Set up the basic C locale
set capital [dict create C [dict create]]
foreach c [split {abcdefghijklmnopqrstuvwxyz} ""] {
    dict set capital C $c [string toupper $c]
}

# English locales can luckily share the "C" locale
dict set capital en [dict get $capital C]
dict set capital en_US [dict get $capital C]
dict set capital en_GB [dict get $capital C]

# ... and so on for other supported languages ...

# Now get the mapping for the current locale and use it.
set upperCaseMap [dict get $capital $env(LANG)]
set upperCase [string map $upperCaseMap $string]
```

Detail von **dict with**:

```
proc sumDictionary {varName} {
    upvar 1 $varName vbl
    foreach key [dict keys $vbl] {
        # Manufacture an entry in the subdictionary
        dict set vbl $key total 0
        # Add the values and remove the old
        dict with vbl $key {
            set total [expr {$x + $y + $z}]
            unset x y z
        }
    }
    puts "last total was $total, for key $key"
}

set myDict {
    a {x 1 y 2 z 3}
    b {x 6 y 5 z 4}
}

sumDictionary myDict
#    prints: last total was 15, for key b

puts "dictionary is now \"$myDict\""
#    prints: dictionary is now "a {total 6} b {total 15}"
```

**dict with** bei kollidierendem Schlüssel und Variablennamen:

```
set foo {foo {a b} bar 2 baz 3}
dict with foo {}
puts $foo
#    prints: a b foo {a b} bar 2 baz 3
```


[apply]: apply.md
[array]: array.md
[break]: break.md
[catch]: catch.md
[continue]: continue.md
[error]: error.md
[foreach]: foreach.md
[Hash]: ../tcl-c/Hash.md
[lmap]: lmap.md
[proc]: proc.md
[string]: string.md
[unset]: unset.md
