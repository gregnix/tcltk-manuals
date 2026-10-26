---
CommandName: dict
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

# NAME

dict - Verarbeitet Dictionaries

# ÜBERSICHT

::: {.synopsis} :::
[dict]{.cmd} [option]{.arg} [arg]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

Führt je nach *option* eine von mehreren Operationen auf Dictionary-Werten oder Variablen mit Dictionary-Werten aus (siehe Abschnitt **DICTIONARY-WERTE**). Zulässige *option*s (abkürzbar):

**dict append** *dictionaryVariable key* ?*string ...*?
: Hängt die angegebenen Zeichenketten an den Wert an, den *key* im Dictionary in *dictionaryVariable* abbildet, und schreibt das resultierende Dictionary zurück in die Variable. Fehlende Schlüssel gelten als leere Zeichenkette. Gibt das aktualisierte Dictionary zurück. Verweist *dictionaryVariable* auf ein nicht existierendes Array-Element mit Standardwert, wird der Standardwert vor dem Anhängen als Dictionary-Wert verwendet.

**dict create** ?*key value ...*?
: Gibt ein neues Dictionary mit allen als Argumente angegebenen Schlüssel/Wert-Paaren zurück (Schlüssel und Werte abwechselnd).

**dict exists** *dictionaryValue key* ?*key ...*?
: Gibt einen booleschen Wert zurück, ob der Schlüssel (oder Pfad durch verschachtelte Dictionaries) in *dictionaryValue* existiert — genau dann, wenn **dict get** auf diesem Pfad erfolgreich wäre.

**dict filter** *dictionaryValue filterType arg* ?*arg ...*?
: Nimmt ein Dictionary und gibt ein neues zurück, das nur die passenden Schlüssel/Wert-Paare enthält. Unterstützte *filterType* (abkürzbar):

**dict filter** *dictionaryValue* **key** ?*globPattern ...*?
: Die key-Regel behält Paare, deren Schlüssel einem der Muster entsprechen (Stil von **string match**).

**dict filter** *dictionaryValue* **script** {*keyVariable valueVariable*} *script*
: Die script-Regel weist Schlüssel und Wert den Variablen zu und wertet *script* aus (boolesches Ergebnis). Das erste Argument nach der Regel ist eine zweielementige Liste. **TCL_BREAK** beendet die weitere Prüfung; **TCL_CONTINUE** entspricht „falsch“. Paare werden in Einfügereihenfolge getestet.

**dict filter** *dictionaryValue* **value** ?*globPattern ...*?
: Die value-Regel behält Paare, deren Werte einem der Muster entsprechen (**string match**).

**dict for** {*keyVariable valueVariable*} *dictionaryValue body*
: Drei Argumente: zweielementige Liste von Variablennamen, Dictionary-Wert, Skript (wie **foreach**). Ergebnis: leere Zeichenkette. **TCL_BREAK** beendet die Iteration sofort erfolgreich; **TCL_CONTINUE** wie **TCL_OK**. Iterationsreihenfolge = Einfügereihenfolge der Schlüssel.

**dict get** *dictionaryValue* ?*key ...*?
: Liest den Wert zu *key* aus *dictionaryValue*. Mehrere *key*s: wie **dict get [dict get $dictVal $key] …** mit den restlichen Schlüsseln — Nachschlagen in verschachtelten Dictionaries. Beispiel, äquivalent:

    ```
    dict get $dict foo bar spong
    dict get [dict get [dict get $dict foo] bar] spong
    ```

    Ohne Schlüssel: Liste von Paaren wie **array get** (Schlüssel, Wert, …). Fehler, wenn ein Schlüssel fehlt.

**dict getdef** *dictionaryValue* ?*key ...*? *key default*
: …siehe **dict getwithdefault**…

**dict getwithdefault** *dictionaryValue* ?*key ...*? *key default*
: Wie **dict get** (mindestens ein *key*), aber bei fehlendem Schlüssel (oder fehlendem Schlüssel auf dem Pfad) wird *default* zurückgegeben statt eines Fehlers. Mindestens ein *key* ist erforderlich. **dict getdef** und **dict getwithdefault** sind Aliase.

**dict incr** *dictionaryVariable key* ?*increment*?
: Addiert *increment* (Ganzzahl, Standard 1) zum Wert von *key* in *dictionaryVariable* und schreibt zurück. Fehlende Schlüssel gelten als 0. Fehler, wenn der bestehende Wert keine Ganzzahl ist. Gibt das aktualisierte Dictionary zurück. Array-Standardwert wie bei **dict append**.

**dict info** *dictionaryValue*
: Informationen zum Dictionary (für Menschen); Format implementationsabhängig. Bei Hash-Tabellen oft **Tcl_HashStats**, analog **array statistics**.

**dict keys** *dictionaryValue* ?*globPattern*?
: Liste aller Schlüssel; mit Muster nur passende (**string match**). Reihenfolge = Einfügereihenfolge.

**dict lappend** *dictionaryVariable key* ?*value ...*?
: Hängt *value* an die Listen-Variable an, die *key* abbildet; fehlende Schlüssel = leere Liste. Fehler, wenn der Wert keine Liste ist. Gibt das aktualisierte Dictionary zurück. Array-Standardwert wie oben.

**dict map** {*keyVariable valueVariable*} *dictionaryValue body*
: Transformation je Mapping; neues Dictionary (wie **lmap**). Bei normalem **TCL_OK** landet das Skriptergebnis im Akkumulator unter dem aktuellen *keyVariable*-Inhalt. **break** beendet sofort; **continue** überspringt die aktuelle Iteration ohne Änderung am Akkumulator. Reihenfolge wie **dict for**.

**dict merge** ?*dictionaryValue ...*?
: Dictionary mit allen Inhalten der Argumente; bei gleichem Schlüssel gewinnt der Wert aus dem letzten Dictionary mit diesem Schlüssel.

**dict remove** *dictionaryValue* ?*key ...*?
: Kopie ohne die genannten Schlüssel; kein Schlüssel nötig; fehlende Schlüssel sind unkritisch.

**dict replace** *dictionaryValue* ?*key value ...*?
: Kopie mit geänderten oder neuen Paaren; ohne Paare erlaubt; Schlüssel ohne Wert ist Fehler.

**dict set** *dictionaryVariable key* ?*key ...*? *value*
: Setzt in *dictionaryVariable* die Abbildung von *key* (bzw. verschachtelter Pfad) auf *value*; erzeugt bei Bedarf verschachtelte Dictionaries. Gibt das aktualisierte Dictionary zurück. Array-Standardwert wie oben.

**dict size** *dictionaryValue*
: Anzahl der Schlüssel/Wert-Paare.

**dict unset** *dictionaryVariable key* ?*key ...*?
: Entfernt die Abbildung für *key* (Pfad durch verschachtelte Dictionaries); mindestens ein *key*; der letzte auf dem Pfad darf fehlen, alle anderen müssen existieren. Gibt das aktualisierte Dictionary zurück. Array-Standardwert wie oben.

**dict update** *dictionaryVariable key varName* ?*key varName ...*? *body*
: Führt *body* aus, wobei jeder *key* (aus *dictionaryVariable*) der Variable *varName* zugeordnet ist. Fehlender Schlüssel = unset *varName*. Nach *body* (auch bei Fehler oder Ausnahme) werden Änderungen an den *varName*s zurück ins Dictionary geschrieben — außer *dictionaryVariable* wird unreadable, dann werden Updates verworfen. Ergebnis von **dict update** ist (ohne Fehler) das Ergebnis von *body*. Array-Standardwert wie oben. Jede *varName* liegt im umschließenden Gültigkeitsbereich; empfohlen nur lokal (**proc**, Lambda für **apply**, Methode). Die Variablen existieren nach dem Befehl weiter (sofern nicht **unset**). Keine Traces: Änderungen am Dictionary nur beim Beenden von *body*.

**dict values** *dictionaryValue* ?*globPattern*?
: Liste aller Werte; mit Muster nur passende Werte (**string match**). Reihenfolge der Werte = Einfügereihenfolge der zugehörigen Schlüssel.

**dict with** *dictionaryVariable* ?*key ...*? *body*
: Führt *body* aus; jeder Schlüssel in *dictionaryVariable* wird einer gleichnamigen Variable zugeordnet (ähnlich **dict update**). Mit *key*s: Pfad durch verschachtelte Dictionaries; innerstes Dictionary wird geöffnet. Wie bei **dict update**: unreadable Variable oder zerstörte Pfadkette verwirft Updates. Ergebnis ist (ohne Fehler) das Ergebnis von *body*. Array-Standardwert wie oben. Nur lokal empfohlen; Variablen bleiben bestehen. Keine Traces. Ist der Inhalt von *dictionaryVariable* beim Beenden von *body* kein Dictionary (z. B. wenn der Name mit einem Schlüssel kollidiert), tritt ein Fehler auf — nicht empfohlen, wenn Schlüssel mit *dictionaryVariable* kollidieren können. Mappt der Schlüssel auf ein Dictionary, wird das innere in das äußere eingefügt; siehe **BEISPIELE**.

# DICTIONARY-WERTE

Dictionaries sind Werte mit effizienter, reihenfolgetreuer Abbildung beliebiger Schlüssel auf beliebige Werte; jeder Schlüssel mappt auf genau einen Wert. Textuell entsprechen sie einer Liste mit gerader Elementanzahl (je Mapping zwei Elemente). Erzeugt ein Befehl aus einem Dictionary ein neues (Rückgabe oder Zurückschreiben in die Ausgangsvariable), bleibt die Schlüsselreihenfolge erhalten — gelöschte Schlüssel entfallen, neue kommen ans Ende. Bei doppelten Schlüsseln in der Zeichenkettendarstellung zählt nur der letzte Wert; „apple banana“ und „apple carrot apple banana“ sind äquivalente Dictionaries (unterschiedliche Darstellung).

Operationen, die ein neues Dictionary aus einem alten ableiten (**dict set**, **dict unset**, …), erhalten die Schlüsselreihenfolge; neue Schlüssel werden angehängt, entfernte gestrichen.

# BEISPIELE

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
# Daten eines Mitarbeiters
dict set employeeInfo 12345-A forenames "Joe"
dict set employeeInfo 12345-A surname   "Schmoe"
dict set employeeInfo 12345-A street "147 Short Street"
dict set employeeInfo 12345-A city   "Springfield"
dict set employeeInfo 12345-A phone  "555-1234"
# Zweiter Mitarbeiter
dict set employeeInfo 98372-J forenames "Anne"
dict set employeeInfo 98372-J surname   "Other"
dict set employeeInfo 98372-J street "32995 Oakdale Way"
dict set employeeInfo 98372-J city   "Springfield"
dict set employeeInfo 98372-J phone  "555-8765"
# Daten vermutlich aus einer Datenbank...

# Ausgabe
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
foreach id [dict keys $employeeInfo] {
    puts "Hello, [dict get $employeeInfo $id forenames]!"
}
```

Lokalisierbare Variante von **string toupper**:

```
# Basis-Locale C
set capital [dict create C [dict create]]
foreach c [split {abcdefghijklmnopqrstuvwxyz} ""] {
    dict set capital C $c [string toupper $c]
}

# Englische Locales teilen C
dict set capital en [dict get $capital C]
dict set capital en_US [dict get $capital C]
dict set capital en_GB [dict get $capital C]

# ... weitere Sprachen ...

set upperCaseMap [dict get $capital $env(LANG)]
set upperCase [string map $upperCaseMap $string]
```

Detail von **dict with**:

```
proc sumDictionary {varName} {
    upvar 1 $varName vbl
    foreach key [dict keys $vbl] {
        dict set vbl $key total 0
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
