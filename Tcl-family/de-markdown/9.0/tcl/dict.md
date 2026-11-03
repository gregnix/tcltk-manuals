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

Führt abhängig von *option* eine von mehreren Operationen auf Dictionary-Werten oder auf Variablen aus, die Dictionary-Werte enthalten (eine Beschreibung finden Sie unten im Abschnitt [Dictionary-Werte]). Die zulässigen Werte für *option* (sie dürfen abgekürzt werden) sind:

[dict]{.cmd} [append]{.sub} [dictionaryVariable]{.arg} [key]{.arg} [string]{.optdot}
: Hängt die angegebene Zeichenkette (oder die angegebenen Zeichenketten) an den Wert an, auf den der angegebene Schlüssel im Dictionary-Wert der angegebenen Variable abgebildet wird, und schreibt den resultierenden Dictionary-Wert in diese Variable zurück. Nicht existierende Schlüssel werden so behandelt, als würden sie auf eine leere Zeichenkette abgebildet. Der aktualisierte Dictionary-Wert wird zurückgegeben. [Verweist *dictionaryVariable* auf ein nicht existierendes Element eines Arrays, für das ein Standardwert gesetzt ist, wird dieser Standardwert vor dem Anhängen als Wert des Dictionarys verwendet.]{version="TIP508"}

[dict]{.cmd} [create]{.sub} [key value]{.optdot}
: Gibt ein neues Dictionary zurück, das jede der als Argumente aufgeführten Schlüssel/Wert-Abbildungen enthält (Schlüssel und Werte wechseln sich ab, wobei auf jeden Schlüssel der zugehörige Wert folgt).

[dict]{.cmd} [exists]{.sub} [dictionaryValue]{.arg} [key]{.arg} [key]{.optdot}
: Gibt einen booleschen Wert zurück, der angibt, ob der angegebene Schlüssel (oder ein Pfad von Schlüsseln durch mehrere verschachtelte Dictionaries) im angegebenen Dictionary-Wert existiert. Der Wert ist genau dann wahr, wenn **dict get** auf diesem Pfad erfolgreich wäre.

[dict]{.cmd} [filter]{.sub} [dictionaryValue]{.arg} [filterType]{.arg} [arg]{.arg} [arg]{.optdot}
: Nimmt einen Dictionary-Wert entgegen und gibt ein neues Dictionary zurück, das nur die Schlüssel/Wert-Paare enthält, die dem angegebenen Filtertyp entsprechen (der Filtertyp darf abgekürzt werden). Unterstützte Filtertypen sind:

    [dict]{.cmd} [filter]{.sub} [dictionaryValue]{.arg} [key]{.lit} [globPattern]{.optdot}
    : Die key-Regel trifft nur auf die Schlüssel/Wert-Paare zu, deren Schlüssel einem der angegebenen Muster entsprechen (im Stil von [string match][string]).

    [dict]{.cmd} [filter]{.sub} [dictionaryValue]{.arg} [script]{.lit} [{keyVariable valueVariable}]{.arg} [script]{.arg}
    : Die script-Regel prüft auf Übereinstimmung, indem sie den Schlüssel der Variable *keyVariable* und den Wert der Variable *valueVariable* zuweist und dann das angegebene Skript auswertet, das einen booleschen Wert ergeben soll (das Schlüssel/Wert-Paar wird nur dann in das Ergebnis von **dict filter** aufgenommen, wenn ein wahrer Wert zurückgegeben wird). Beachten Sie, dass das erste Argument nach dem Wort, das die Regel auswählt, eine Liste mit zwei Elementen ist. Endet *script* mit dem Status [TCL\_BREAK][catch], werden keine weiteren Schlüssel/Wert-Paare für die Aufnahme in das resultierende Dictionary geprüft; der Status [TCL\_CONTINUE][catch] entspricht einem falschen Ergebnis. Die Schlüssel/Wert-Paare werden in der Reihenfolge geprüft, in der die Schlüssel in das Dictionary eingefügt wurden.

    [dict]{.cmd} [filter]{.sub} [dictionaryValue]{.arg} [value]{.lit} [globPattern]{.optdot}
    : Die value-Regel trifft nur auf die Schlüssel/Wert-Paare zu, deren Werte einem der angegebenen Muster entsprechen (im Stil von [string match][string]).


[dict]{.cmd} [for]{.sub} [{keyVariable valueVariable}]{.arg} [dictionaryValue]{.arg} [body]{.arg}
: Dieser Befehl nimmt drei Argumente entgegen: als erstes eine Liste mit zwei Variablennamen (für den Schlüssel bzw. den Wert jeder Abbildung im Dictionary), als zweites den Dictionary-Wert, über den iteriert wird, und als drittes ein Skript, das für jede Abbildung ausgewertet wird, wobei die Schlüssel- und die Wertvariable jeweils passend gesetzt sind (nach Art von [foreach]). Das Ergebnis des Befehls ist eine leere Zeichenkette. Liefert eine Auswertung des Rumpfs das Ergebnis [TCL\_BREAK][catch], wird über keine weiteren Paare des Dictionarys iteriert, und der Befehl **dict for** endet sofort erfolgreich. Liefert eine Auswertung des Rumpfs das Ergebnis [TCL\_CONTINUE][catch], wird es genau wie ein normales Ergebnis [TCL\_OK][catch] behandelt. Die Iterationsreihenfolge ist die Reihenfolge, in der die Schlüssel in das Dictionary eingefügt wurden.

[dict]{.cmd} [get]{.sub} [dictionaryValue]{.arg} [key]{.optdot}
: Liest zu einem Dictionary-Wert (erstes Argument) und einem Schlüssel (zweites Argument) den Wert für diesen Schlüssel aus. Werden mehrere Schlüssel angegeben, verhält sich der Befehl so, als würde das Ergebnis von **dict get $dictVal $key** als erstes Argument an **dict get** übergeben, mit den übrigen Argumenten als zweitem (und gegebenenfalls weiteren) Argument. Das erleichtert das Nachschlagen in verschachtelten Dictionaries. Zum Beispiel sind die folgenden beiden Befehle gleichwertig:

    ```
    dict get $dict foo bar spong
    dict get [dict get [dict get $dict foo] bar] spong
    ```

    Werden keine Schlüssel angegeben, gibt **dict get** eine Liste mit Paaren von Elementen zurück, ähnlich wie [array get][array]. Das heißt, das erste Element jedes Paars ist der Schlüssel und das zweite Element der Wert für diesen Schlüssel.

    Es ist ein Fehler, den Wert für einen Schlüssel abrufen zu wollen, der im Dictionary nicht vorhanden ist.

[dict]{.cmd} [getdef]{.sub} [dictionaryValue]{.arg} [key]{.optdot} [key]{.arg} [default]{.arg}
: siehe unten ...

[dict]{.cmd} [getwithdefault]{.sub} [dictionaryValue]{.arg} [key]{.optdot} [key]{.arg} [default]{.arg}
: [Verhält sich wie **dict get** (mit mindestens einem *key*-Argument) und gibt den Wert zurück, auf den der Schlüsselpfad im Dictionary *dictionaryValue* abgebildet wird. Der Unterschied: Fehlt der *key* (oder einer der *key*s auf dem Schlüsselpfad), wird kein Fehler erzeugt, sondern stattdessen das Argument *default* zurückgegeben.]{version="TIP342"}

    Beachten Sie, dass immer mindestens ein *key* angegeben werden muss und dass **dict getdef** und **dict getwithdefault** Aliase füreinander sind.

[dict]{.cmd} [incr]{.sub} [dictionaryVariable]{.arg} [key]{.arg} [increment]{.optarg}
: Addiert den angegebenen Inkrementwert (eine Ganzzahl, die standardmäßig 1 ist, wenn sie nicht angegeben wird) zu dem Wert, auf den der angegebene Schlüssel im Dictionary-Wert der angegebenen Variable abgebildet wird, und schreibt den resultierenden Dictionary-Wert in diese Variable zurück. Nicht existierende Schlüssel werden so behandelt, als würden sie auf 0 abgebildet. Es ist ein Fehler, den Wert eines vorhandenen Schlüssels zu erhöhen, wenn dieser Wert keine Ganzzahl ist. Der aktualisierte Dictionary-Wert wird zurückgegeben. [Verweist *dictionaryVariable* auf ein nicht existierendes Element eines Arrays, für das ein Standardwert gesetzt ist, wird dieser Standardwert vor dem Erhöhen als Wert des Dictionarys verwendet.]{version="TIP508"}

[dict]{.cmd} [info]{.sub} [dictionaryValue]{.arg}
: Gibt Informationen über das angegebene Dictionary zurück (zur Anzeige für Menschen gedacht). Das Format dieser Daten hängt jedoch von der Implementierung des Dictionarys ab. Für Dictionaries, die mit Hash-Tabellen implementiert sind, wird erwartet, dass die von [Tcl\_HashStats][Hash] erzeugte Zeichenkette zurückgegeben wird, ähnlich wie bei [array statistics][array].

[dict]{.cmd} [keys]{.sub} [dictionaryValue]{.arg} [globPattern]{.optarg}
: Gibt eine Liste aller Schlüssel im angegebenen Dictionary-Wert zurück. Wird ein Muster angegeben, werden nur die Schlüssel zurückgegeben, die ihm entsprechen (nach den Regeln von [string match][string]). Die zurückgegebenen Schlüssel stehen in der Reihenfolge, in der sie in das Dictionary eingefügt wurden.

[dict]{.cmd} [lappend]{.sub} [dictionaryVariable]{.arg} [key]{.arg} [value]{.optdot}
: Hängt die angegebenen Elemente an den Listenwert an, auf den der angegebene Schlüssel im Dictionary-Wert der angegebenen Variable abgebildet wird, und schreibt den resultierenden Dictionary-Wert in diese Variable zurück. Nicht existierende Schlüssel werden so behandelt, als würden sie auf eine leere Liste abgebildet. Es ist zulässig, keine Elemente zum Anhängen anzugeben. Es ist ein Fehler, wenn sich der Wert, auf den der Schlüssel abgebildet wird, nicht als Liste darstellen lässt. Der aktualisierte Dictionary-Wert wird zurückgegeben. [Verweist *dictionaryVariable* auf ein nicht existierendes Element eines Arrays, für das ein Standardwert gesetzt ist, wird dieser Standardwert vor dem Anhängen an die Liste als Wert des Dictionarys verwendet.]{version="TIP508"}

[dict]{.cmd} [map]{.sub} [{keyVariable valueVariable}]{.arg} [dictionaryValue]{.arg} [body]{.arg}
: Dieser Befehl wendet eine Transformation auf jedes Element eines Dictionarys an und gibt ein neues Dictionary zurück. Er nimmt drei Argumente entgegen: als erstes eine Liste mit zwei Variablennamen (für den Schlüssel bzw. den Wert jeder Abbildung im Dictionary), als zweites den Dictionary-Wert, über den iteriert wird, und als drittes ein Skript, das für jede Abbildung ausgewertet wird, wobei die Schlüssel- und die Wertvariable jeweils passend gesetzt sind (nach Art von [lmap]). In einer Iteration, in der das ausgewertete Skript normal endet ([TCL\_OK][catch], im Gegensatz etwa zu einem [error]), wird das Ergebnis des Skripts in ein Sammel-Dictionary aufgenommen, und zwar unter dem Schlüssel, der zu diesem Zeitpunkt der aktuelle Inhalt der Variable *keyVariable* ist. Das Ergebnis des Befehls **dict map** ist das Sammel-Dictionary, nachdem über alle Schlüssel iteriert wurde.

    Erzeugt die Auswertung des Rumpfs in einem Schritt ein [break], wird über keine weiteren Paare des Dictionarys iteriert, und der Befehl **dict map** endet sofort erfolgreich. Erzeugt die Auswertung des Rumpfs in einem Schritt das Ergebnis [continue], wird die aktuelle Iteration abgebrochen, und das Sammel-Dictionary bleibt unverändert. Die Iterationsreihenfolge ist die natürliche Reihenfolge des Dictionarys (in der Regel die Reihenfolge, in der die Schlüssel zum Dictionary hinzugefügt wurden; es ist dieselbe Reihenfolge wie bei **dict for**).

[dict]{.cmd} [merge]{.sub} [dictionaryValue]{.optdot}
: Gibt ein Dictionary zurück, das den Inhalt aller *dictionaryValue*-Argumente enthält. Enthalten zwei (oder mehr) Dictionaries eine Abbildung für denselben Schlüssel, bildet das resultierende Dictionary diesen Schlüssel auf den Wert aus dem letzten Dictionary in der Befehlszeile ab, das eine Abbildung für diesen Schlüssel enthält.

[dict]{.cmd} [remove]{.sub} [dictionaryValue]{.arg} [key]{.optdot}
: Gibt ein neues Dictionary zurück, das eine Kopie des als erstes Argument übergebenen alten Dictionarys ist, jedoch ohne Abbildungen für die aufgeführten Schlüssel. Es ist zulässig, keine zu entfernenden Schlüssel anzugeben. Ebenso ist es zulässig, dass einer der zu entfernenden Schlüssel im Eingabe-Dictionary gar nicht vorhanden ist.

[dict]{.cmd} [replace]{.sub} [dictionaryValue]{.arg} [key value]{.optdot}
: Gibt ein neues Dictionary zurück, das eine Kopie des als erstes Argument übergebenen alten Dictionarys ist, jedoch mit einigen geänderten Werten oder einigen zusätzlichen Schlüssel/Wert-Paaren. Es ist zulässig, diesen Befehl ohne Schlüssel/Wert-Paare aufzurufen, aber unzulässig, ihn mit einem Schlüssel ohne Wert aufzurufen.

[dict]{.cmd} [set]{.sub} [dictionaryVariable]{.arg} [key]{.arg} [key]{.optdot} [value]{.arg}
: Diese Operation nimmt den Namen einer Variable entgegen, die einen Dictionary-Wert enthält, und legt in dieser Variable einen aktualisierten Dictionary-Wert ab, der eine Abbildung vom angegebenen Schlüssel auf den angegebenen Wert enthält. Sind mehrere Schlüssel angegeben, erzeugt oder aktualisiert diese Operation eine Kette verschachtelter Dictionaries. Der aktualisierte Dictionary-Wert wird zurückgegeben. [Verweist *dictionaryVariable* auf ein nicht existierendes Element eines Arrays, für das ein Standardwert gesetzt ist, wird dieser Standardwert vor dem Einfügen oder Aktualisieren des Werts als Wert des Dictionarys verwendet.]{version="TIP508"}

[dict]{.cmd} [size]{.sub} [dictionaryValue]{.arg}
: Gibt die Anzahl der Schlüssel/Wert-Abbildungen im angegebenen Dictionary-Wert zurück.

[dict]{.cmd} [unset]{.sub} [dictionaryVariable]{.arg} [key]{.arg} [key]{.optdot}
: Diese Operation (das Gegenstück zu **dict set**) nimmt den Namen einer Variable entgegen, die einen Dictionary-Wert enthält, und legt in dieser Variable einen aktualisierten Dictionary-Wert ab, der keine Abbildung für den angegebenen Schlüssel enthält. Sind mehrere Schlüssel angegeben, beschreiben sie einen Pfad durch verschachtelte Dictionaries zu der Abbildung, die entfernt werden soll. Mindestens ein Schlüssel muss angegeben werden, der letzte Schlüssel auf dem Schlüsselpfad muss jedoch nicht existieren. Alle anderen Bestandteile des Pfads müssen existieren. Der aktualisierte Dictionary-Wert wird zurückgegeben. [Verweist *dictionaryVariable* auf ein nicht existierendes Element eines Arrays, für das ein Standardwert gesetzt ist, wird dieser Standardwert vor dem Entfernen des Werts als Wert des Dictionarys verwendet.]{version="TIP508"}

[dict]{.cmd} [update]{.sub} [dictionaryVariable]{.arg} [key]{.arg} [varName]{.arg} [key varName]{.optdot} [body]{.arg}
: Führt das Tcl-Skript in *body* aus, wobei der Wert jedes *key* (wie er beim Lesen des Dictionary-Werts in *dictionaryVariable* gefunden wird) der Variable *varName* zugeordnet ist. Es darf mehrere *key*/*varName*-Paare geben. Hat ein *key* keine Abbildung, entspricht das einer nicht gesetzten Variable *varName*. Wenn *body* endet, werden alle Änderungen an den *varName*s in das Dictionary in *dictionaryVariable* zurückübertragen (es sei denn, *dictionaryVariable* selbst ist nicht mehr lesbar; dann werden alle Aktualisierungen stillschweigend verworfen). Das gilt auch, wenn *body* mit einem Fehler oder auf eine andere außergewöhnliche Weise endet. Das Ergebnis von **dict update** ist (sofern kein Fehler auftritt) das Ergebnis der Auswertung von *body*. [Verweist *dictionaryVariable* auf ein nicht existierendes Element eines Arrays, für das ein Standardwert gesetzt ist, wird dieser Standardwert vor dem Aktualisieren als Wert des Dictionarys verwendet.]{version="TIP508"}

    Jede *varName* wird im Gültigkeitsbereich zugeordnet, der **dict update** umschließt. Es wird empfohlen, diesen Befehl nur in einem lokalen Gültigkeitsbereich zu verwenden ([proc]-Prozedur, Lambda-Ausdruck für [apply] oder Methode). Deshalb bestehen die von **dict update** gesetzten Variablen auch nach dem Ende des Befehls weiter (sofern sie nicht ausdrücklich mit [unset] entfernt werden).

    Beachten Sie, dass die Zuordnung von Werten zu Variablen keine Traces verwendet. Der Inhalt von *dictionaryVariable* ändert sich erst, wenn *body* endet.

[dict]{.cmd} [values]{.sub} [dictionaryValue]{.arg} [globPattern]{.optarg}
: Gibt eine Liste aller Werte im angegebenen Dictionary-Wert zurück. Wird ein Muster angegeben, werden nur die Werte zurückgegeben, die ihm entsprechen (nach den Regeln von [string match][string]). Die zurückgegebenen Werte stehen in der Reihenfolge, in der die zugehörigen Schlüssel in das Dictionary eingefügt wurden.

[dict]{.cmd} [with]{.sub} [dictionaryVariable]{.arg} [key]{.optdot} [body]{.arg}
: Führt das Tcl-Skript in *body* aus, wobei der Wert jedes Schlüssels in *dictionaryVariable* (ähnlich wie bei **dict update**) einer gleichnamigen Variable zugeordnet ist. Sind ein oder mehrere *key*s angegeben, bezeichnen sie eine Kette verschachtelter Dictionaries; geöffnet wird dann für die Ausführung von *body* das innerste Dictionary. Wie bei **dict update** führt eine nicht mehr lesbare *dictionaryVariable* dazu, dass die Aktualisierungen des Dictionarys verworfen werden. Das geschieht auch, wenn der Inhalt von *dictionaryVariable* so geändert wird, dass die Kette der Dictionaries nicht mehr existiert. Das Ergebnis von **dict with** ist (sofern kein Fehler auftritt) das Ergebnis der Auswertung von *body*. [Verweist *dictionaryVariable* auf ein nicht existierendes Element eines Arrays, für das ein Standardwert gesetzt ist, wird dieser Standardwert vor dem Aktualisieren als Wert des Dictionarys verwendet.]{version="TIP508"}

    Die Variablen werden im Gültigkeitsbereich zugeordnet, der **dict with** umschließt. Es wird empfohlen, diesen Befehl nur in einem lokalen Gültigkeitsbereich zu verwenden ([proc]-Prozedur, Lambda-Ausdruck für [apply] oder Methode). Deshalb bestehen die von **dict with** gesetzten Variablen auch nach dem Ende des Befehls weiter (sofern sie nicht ausdrücklich mit [unset] entfernt werden).

    Beachten Sie, dass die Zuordnung von Werten zu Variablen keine Traces verwendet. Der Inhalt von *dictionaryVariable* ändert sich erst, wenn *body* endet.

    Enthält *dictionaryVariable* zu dem Zeitpunkt, an dem *body* endet, einen Wert, der kein Dictionary ist, tritt an dieser Stelle ein Fehler auf. Das kann leicht passieren, wenn der Variablenname mit einem der Schlüssel im Dictionary übereinstimmt. Dieser Befehl wird daher nicht empfohlen, wenn zu erwarten ist, dass Schlüssel im Dictionary mit dem Namen von *dictionaryVariable* selbst kollidieren. Wird der enthaltene Schlüssel tatsächlich auf ein Dictionary abgebildet, wird im Endeffekt dieses innere Dictionary mit dem äußeren zusammengeführt; ein Beispiel dazu finden Sie unten unter [Beispiele].


# Dictionary-Werte

Dictionaries sind Werte, die eine effiziente, reihenfolgeerhaltende Abbildung von beliebigen Schlüsseln auf beliebige Werte enthalten. Jeder Schlüssel im Dictionary wird auf genau einen Wert abgebildet. Ihr Textformat ist genau das einer beliebigen Liste mit einer geraden Anzahl von Elementen, wobei jede Abbildung im Dictionary durch zwei Elemente der Liste dargestellt wird. Nimmt ein Befehl ein Dictionary entgegen und erzeugt daraus ein neues Dictionary (das er entweder zurückgibt oder in die Variable zurückschreibt, aus der das Ausgangs-Dictionary gelesen wurde), hat das neue Dictionary dieselbe Schlüsselreihenfolge; ausgenommen sind gelöschte Schlüssel, und neue Schlüssel werden am Ende angefügt. Wird eine Zeichenkette als Dictionary interpretiert und enthielte sie sonst doppelte Schlüssel, wird für einen bestimmten Schlüssel nur der letzte Wert verwendet; die anderen werden ignoriert. Daher sind „apple banana“ und „apple carrot apple banana“ gleichwertige Dictionaries (mit unterschiedlichen Zeichenkettendarstellungen).

Operationen, die ein neues Dictionary aus einem alten ableiten (z. B. Aktualisierungen wie **dict set** und **dict unset**), erhalten die Reihenfolge der Schlüssel im Dictionary. Ausgenommen davon sind neu hinzugefügte Schlüssel, die an die Folge angehängt werden, sowie entfernte Schlüssel, die aus der Reihenfolge herausgenommen werden.

# Beispiele

Grundlegende Verwendung von Dictionaries:

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

Verschachtelte Dictionaries erzeugen und verwenden:

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

Eine lokalisierbare Variante von [string toupper][string]:

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

Die Arbeitsweise von **dict with** im Detail:

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

Wenn **dict with** mit einem Schlüssel verwendet wird, der mit dem Namen der Dictionary-Variable kollidiert:

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
