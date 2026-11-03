---
CommandName: array
title: array
ManualSection: n
Version: 9.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - list(n)
 - string(n)
 - variable(n)
 - trace(n)
 - foreach(n)
Keywords:
 - array
 - element names
 - search
Copyright:
 - Copyright (c) 1993-1994 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

array - Bearbeitet Array-Variablen

# Übersicht

::: {.synopsis} :::
[array]{.cmd} [option]{.arg} [arrayName]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Dieser Befehl führt eine von mehreren Operationen an der Variablen aus, die *arrayName* angibt. Sofern bei den einzelnen Befehlen unten nichts anderes angegeben ist, muss *arrayName* der Name einer vorhandenen Array-Variablen sein. Das Argument *option* bestimmt, welche Aktion der Befehl ausführt. Die zulässigen *options* (sie dürfen abgekürzt werden) sind:

[array]{.cmd} [anymore]{.sub} [arrayName]{.arg} [searchId]{.arg}
: Gibt 1 zurück, wenn bei einer Arraysuche noch Elemente zu verarbeiten sind, und 0, wenn bereits alle Elemente zurückgegeben wurden. *SearchId* gibt an, welche Suche in *arrayName* geprüft werden soll. Es muss der Rückgabewert eines früheren Aufrufs von **array startsearch** sein. Diese Option ist besonders nützlich, wenn ein Array ein Element mit leerem Namen hat, weil der Rückgabewert von **array nextelement** dann nicht anzeigt, ob die Suche abgeschlossen ist.

[array]{.cmd} [default]{.sub} [subcommand]{.arg} [arrayName]{.arg} [args...]{.arg}
: [Verwaltet den Standardwert des Arrays. Arrays haben anfangs keinen Standardwert, aber mit diesem Befehl können Sie einen festlegen. Der Standardwert wird beim Lesen eines Elements des Arrays *arrayName* zurückgegeben, wenn das Lesen sonst zu einem Fehler führen würde. Beachten Sie, dass sich dadurch das Verhalten der Befehle [append], [dict], [incr] und [lappend] gegenüber nicht vorhandenen Arrayelementen ändern kann.]{version="TIP508"}

    Das Argument *subcommand* steuert, welche Operation genau am Standardwert von *arrayName* ausgeführt wird. Die unterstützten *subcommand*-Argumente sind:

    [array]{.cmd} [default]{.sub} [exists]{.lit} [arrayName]{.arg}
    : [Gibt einen booleschen Wert zurück, der angibt, ob für das Array *arrayName* ein Standardwert festgelegt wurde. Gibt einen falschen Wert zurück, wenn *arrayName* nicht existiert. Löst einen Fehler aus, wenn *arrayName* eine vorhandene Variable ist, die kein Array ist.]{version="TIP508"}

    [array]{.cmd} [default]{.sub} [get]{.lit} [arrayName]{.arg}
    : [Gibt den aktuellen Standardwert des Arrays *arrayName* zurück. Löst einen Fehler aus, wenn *arrayName* eine vorhandene Variable ist, die kein Array ist, oder wenn *arrayName* ein Array ohne Standardwert ist.]{version="TIP508"}

    [array]{.cmd} [default]{.sub} [set]{.lit} [arrayName]{.arg} [value]{.arg}
    : [Setzt den Standardwert des Arrays *arrayName* auf *value*. Gibt die leere Zeichenkette zurück. Löst einen Fehler aus, wenn *arrayName* eine vorhandene Variable ist, die kein Array ist, oder wenn *arrayName* kein zulässiger Name für ein Array ist. Existiert *arrayName* noch nicht, wird es als leeres Array angelegt und erhält zugleich den Standardwert.]{version="TIP508"}

    [array]{.cmd} [default]{.sub} [unset]{.lit} [arrayName]{.arg}
    : [Entfernt den Standardwert des Arrays *arrayName* und gibt die leere Zeichenkette zurück. Hat *arrayName* keinen Standardwert, geschieht nichts. Löst einen Fehler aus, wenn *arrayName* eine vorhandene Variable ist, die kein Array ist.]{version="TIP508"}


[array]{.cmd} [donesearch]{.sub} [arrayName]{.arg} [searchId]{.arg}
: Dieser Befehl beendet eine Arraysuche und verwirft den gesamten Zustand, der zu dieser Suche gehört. *SearchId* gibt an, welche Suche in *arrayName* verworfen werden soll. Es muss der Rückgabewert eines früheren Aufrufs von **array startsearch** sein. Gibt eine leere Zeichenkette zurück.

[array]{.cmd} [exists]{.sub} [arrayName]{.arg}
: Gibt 1 zurück, wenn *arrayName* eine Array-Variable ist, und 0, wenn es keine Variable dieses Namens gibt oder wenn es eine skalare Variable ist.

[array]{.cmd} [for]{.sub} [{keyVariable valueVariable}]{.arg} [arrayName]{.arg} [body]{.arg}
: Das erste Argument ist eine Liste aus zwei Variablennamen für den Schlüssel und den Wert jedes Eintrags im Array. Das zweite Argument ist der Name des Arrays, über das iteriert wird. Das dritte Argument ist der Rumpf, der für jedes zurückgegebene Paar aus Schlüssel und Wert ausgeführt wird. Die Reihenfolge der zurückgegebenen Schlüssel ist undefiniert. Wird während des Durchlaufs von *array for* ein Arrayelement gelöscht oder ein neues eingefügt, bricht der Befehl mit einem Fehler ab.

[array]{.cmd} [get]{.sub} [arrayName]{.arg} [pattern]{.optarg}
: Gibt eine Liste aus Paaren von Elementen zurück. Das erste Element jedes Paars ist der Name eines Elements in *arrayName*, das zweite Element jedes Paars ist der Wert dieses Arrayelements. Die Reihenfolge der Paare ist undefiniert. Ist *pattern* nicht angegeben, sind alle Elemente des Arrays im Ergebnis enthalten. Ist *pattern* angegeben, sind nur die Elemente enthalten, deren Namen auf *pattern* passen (nach den Regeln von [string match][string]). Ist *arrayName* nicht der Name einer Array-Variablen oder enthält das Array keine Elemente, wird eine leere Liste zurückgegeben. Ändern Traces auf dem Array die Liste der Elemente, werden die Elemente zurückgegeben, die sowohl vor als auch nach dem Aufruf von **array get** existieren.

[array]{.cmd} [names]{.sub} [arrayName]{.arg} [mode]{.optarg} [pattern]{.optarg}
: Gibt eine Liste mit den Namen aller Elemente des Arrays zurück, die auf *pattern* passen. *Mode* kann **-exact**, **-glob** oder **-regexp** sein. Ist *mode* angegeben, legt es fest, nach welchen Regeln *pattern* mit den Namen der Arrayelemente verglichen wird. Ist *mode* nicht angegeben, gilt **-glob**. Informationen zum Mustervergleich im Glob-Stil finden Sie in der Dokumentation zu [string match][string], Informationen zum Vergleich mit regulären Ausdrücken in der Dokumentation zu [regexp]. Wird *pattern* weggelassen, gibt der Befehl alle Elementnamen des Arrays zurück. Enthält das Array keine (passenden) Elemente oder ist *arrayName* nicht der Name einer Array-Variablen, wird eine leere Zeichenkette zurückgegeben.

[array]{.cmd} [nextelement]{.sub} [arrayName]{.arg} [searchId]{.arg}
: Gibt den Namen des nächsten Elements in *arrayName* zurück, oder eine leere Zeichenkette, wenn bei dieser Suche bereits alle Elemente von *arrayName* zurückgegeben wurden. Das Argument *searchId* bezeichnet die Suche und muss der Rückgabewert eines **array startsearch**-Befehls sein. Warnung: Werden dem Array Elemente hinzugefügt oder daraus gelöscht, werden alle Suchen automatisch beendet, als wäre **array donesearch** aufgerufen worden. Dadurch schlagen **array nextelement**-Operationen für diese Suchen fehl.

[array]{.cmd} [set]{.sub} [arrayName]{.arg} [list]{.arg}
: Setzt die Werte eines oder mehrerer Elemente in *arrayName*. *list* muss eine Form haben wie die Rückgabe von **array get**, also aus einer geraden Anzahl von Elementen bestehen. Jedes Element von *list* an ungerader Position wird als Elementname in *arrayName* behandelt, und das darauf folgende Element von *list* wird als neuer Wert dieses Arrayelements verwendet. Existiert die Variable *arrayName* noch nicht und ist *list* leer, wird *arrayName* mit einem leeren Array als Wert angelegt.

[array]{.cmd} [size]{.sub} [arrayName]{.arg}
: Gibt eine Zeichenkette mit der Anzahl der Elemente im Array als Dezimalzahl zurück. Ist *arrayName* nicht der Name eines Arrays, wird 0 zurückgegeben.

[array]{.cmd} [startsearch]{.sub} [arrayName]{.arg}
: Dieser Befehl beginnt eine Suche Element für Element durch das Array *arrayName*, sodass Aufrufe des Befehls **array nextelement** die Namen der einzelnen Elemente des Arrays zurückgeben. Ist die Suche abgeschlossen, sollte der Befehl **array donesearch** aufgerufen werden. Der Rückgabewert ist ein Suchbezeichner, der in den Befehlen **array nextelement** und **array donesearch** verwendet werden muss. Damit können mehrere Suchen im selben Array gleichzeitig laufen. Derzeit ist es effizienter und einfacher, für das Durchlaufen aller Arrays außer sehr großen entweder **array get** oder **array names** zusammen mit [foreach] zu verwenden. Wie das geht, zeigen die Beispiele unten.

[array]{.cmd} [statistics]{.sub} [arrayName]{.arg}
: Gibt Statistiken über die Verteilung der Daten in der Hashtabelle zurück, die das Array darstellt. Diese Angaben umfassen die Anzahl der Einträge in der Tabelle, die Anzahl der Buckets und die Auslastung der Buckets.

[array]{.cmd} [unset]{.sub} [arrayName]{.arg} [pattern]{.optarg}
: Entfernt alle Elemente des Arrays, die auf *pattern* passen (nach den Regeln von [string match][string]). Ist *arrayName* nicht der Name einer Array-Variablen oder enthält das Array keine passenden Elemente, wird kein Fehler ausgelöst. Wird *pattern* weggelassen und ist *arrayName* eine Array-Variable, entfernt der Befehl das gesamte Array. Der Befehl gibt immer eine leere Zeichenkette zurück.


# Beispiele

```
array set colorcount {
    red   1
    green 5
    blue  4
    white 9
}

foreach {color count} [array get colorcount] {
    puts "Color: $color Count: $count"
}
  → Color: blue Count: 4
    Color: white Count: 9
    Color: green Count: 5
    Color: red Count: 1

foreach color [array names colorcount] {
    puts "Color: $color Count: $colorcount($color)"
}
  → Color: blue Count: 4
    Color: white Count: 9
    Color: green Count: 5
    Color: red Count: 1

foreach color [lsort [array names colorcount]] {
    puts "Color: $color Count: $colorcount($color)"
}
  → Color: blue Count: 4
    Color: green Count: 5
    Color: red Count: 1
    Color: white Count: 9

array statistics colorcount
  → 4 entries in table, 4 buckets
    number of buckets with 0 entries: 1
    number of buckets with 1 entries: 2
    number of buckets with 2 entries: 1
    number of buckets with 3 entries: 0
    number of buckets with 4 entries: 0
    number of buckets with 5 entries: 0
    number of buckets with 6 entries: 0
    number of buckets with 7 entries: 0
    number of buckets with 8 entries: 0
    number of buckets with 9 entries: 0
    number of buckets with 10 or more entries: 0
    average search distance for entry: 1.2
```


[append]: append.md
[dict]: dict.md
[foreach]: foreach.md
[incr]: incr.md
[lappend]: lappend.md
[regexp]: regexp.md
[string]: string.md
