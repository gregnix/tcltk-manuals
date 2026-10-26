---
CommandName: lambda
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Utility commands for anonymous procedures
Links:
 - apply(n)
 - proc(n)
Keywords:
 - anonymous procedure
 - callback
 - command prefix
 - currying
 - lambda
 - partial application
 - proc
Copyright:
 - Copyright (c) 2011 Andreas Kupries, BSD licensed
---

# NAME

lambda – Hilfskommandos für anonyme Prozeduren

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [lambda]{.lit} [1.1]{.optlit} 
[::lambda]{.cmd} [arguments]{.arg} [body]{.arg} [arg]{.optdot} 
[::lambda@]{.cmd} [namespace]{.arg} [arguments]{.arg} [body]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

Dieses Paket bietet zwei Komfortbefehle, die die Erstellung anonymer Befehle, d. h. Lambda-Ausdrücke, **proc**-like. Anstatt beispielsweise zu schreiben

```
     set f {::apply {{x} {
        ....
     }}}
```

mit seiner tiefen Verschachtelung von Klammern oder

```
     set f [list ::apply {{x y} {
        ....
     }} $value_for_x]
```

Um mit einem **list**-Befehl einige der Argumente einer partiellen Anwendung einzufügen, schreibe einfach

```
     set f [lambda {x} {
        ....
     }]
```

or

```
     set f [lambda {x y} {
        ....
     } $value_for_x]
```

Lambdas sind besonders nützlich für Befehle, die die Option **-command** akzeptieren.

# API

**::lambda** *arguments* *body* ?*arg ...*?
: Gibt einen anonymen Befehl zurück, der auf der Liste *arguments*, dem Skript *body* und etwaigen (optionalen) vordefinierten Argumentwerten *arg ...* basiert. Bei der Ausführung wird der *body* in einem neuen Bereich der Prozedur direkt unterhalb des globalen Bereichs ausgeführt, wobei die Argumente auf die Werte gesetzt werden, die sowohl bei der Erstellung (alle *arg ...*-Argumente) als auch zum Zeitpunkt der Ausführung übergeben wurden.

**::lambda@** *namespace* *arguments* *body* ?*arg ...*?
: Gibt einen anonymen Befehl im Namespace *namespace* zurück, der auf der Liste *arguments*, dem Skript *body* und etwaigen (optionalen) vordefinierten Argumentwerten *arg ...* basiert. Bei der Ausführung wird der *body* in einem neuen Prozedurbereich im Namespace *namespace* ausgeführt, wobei die Argumente auf die Werte gesetzt werden, die sowohl bei der Erstellung (alle *arg ...*-Argumente) als auch zum Zeitpunkt der Ausführung übergeben wurden.


# BEISPIELE

## Partielle Funktionsanwendung

Lambdas können für die partielle Funktionsanwendung (PFA) verwendet werden, obwohl dies aufgrund der **expr**-Kontexte in Tcl meist nicht erforderlich ist. Dennoch hier ein klassisches PFA-Beispiel:

```
proc make_adder addend { lambda {x y} { expr { $x + $y } } $addend }
set add5 [make_adder 5]
puts "[{*}$add5 92] [{*}$add5 17]"
=>
97 22
```

Mit dem Befehl **make_adder** wurde ein anonymer Befehl, d. h. ein Lambda, erstellt, der anschließend der Variable **add5** zugewiesen wurde. Um eine Variable als Befehl aufzurufen, muss ihr der Expansionsoperator **{\*}** („Splat“) vorangestellt werden. Beachten Sie, dass diese Aufrufe nur *ein* Argument benötigen; das erste Argument wurde bei der Erstellung des Lambda festgelegt.

## Verwendung von „regusb“ mit „lambda“

Dieses Beispiel zeigt, wie Sie ein Lambda mit der Option **-command** des integrierten Befehls [regsub](https://www.tcl-lang.org/man/tcl/TclCmd/regsub.html)] verwenden.

```
# Simple URL-decoding: + → space; %XX → char
set encoded_url "www.tcl-lang.org%2FSet%20or%20%24%20usage%3F"
set url [regsub -all -command {(\+)|%([0-9A-Fa-f]{2})}  $encoded_url [lambda {_ plus hex} {
                if {$plus eq "+"} { return " " }
                scan $hex %x charCode
                format %c $charCode
            }]]
puts $url
=>
www.tcl-lang.org/Set or $ usage?
```

Beachten Sie, dass bei Verwendung der Option **-command** des integrierten Befehls [regsub](https://www.tcl-lang.org/man/tcl/TclCmd/regsub.html)] der Befehl selbst *hinter* der zu suchenden Zeichenfolge steht (an der Position des Arguments *subSpec*).

## Verwendung von „lsort“ mit Lambda

Dieses Beispiel zeigt, wie Sie mithilfe von Lambda-Ausdrücken Objekte sortieren, indem Sie die Option **-command** des integrierten Befehls [lsort](https://www.tcl-lang.org/man/tcl/TclCmd/lsort.html)] verwenden.

Zunächst eine minimale Definition einer Klasse **Id**, deren Objekte sortiert werden sollen.

```
oo::class create Id {
    variable Id
    variable Name
    constructor {id name} { set Id $id ; set Name $name }
    method id {} { return $Id }
    method name {} { return $Name }
    method to_string {} { return "$Id'$Name'" }
}
```

Anschließend wird eine Liste von **Id**s erstellt und dann mithilfe von Lambda-Ausdrücken auf zwei verschiedene Arten sortiert, um die gewünschten Sortierreihenfolgen zu erhalten.

```
set ids [list [Id new 3 Jane] [Id new 1 Bill] [Id new 4 Sam] [Id new 5 Nell]]
#
puts -nonewline "Original order:     "
foreach id $ids { puts -nonewline "[$id to_string] " }
#
puts -nonewline "\nName,Id order:      "
foreach id [lsort -command [lambda {a b} {
		if {[set i [string compare [$a name] [$b name]]]} { return $i }
		if {[$a id] < [$b id]} { return -1 }
		if {[$a id] > [$b id]} { return 1 }
		return 0}
            ] $ids] {
    puts -nonewline "[$id to_string] "
}
#
puts -nonewline "\nId desc,Name order: "
foreach id [lsort -command [lambda {a b} {
		if {[$a id] < [$b id]} { return 1 }
		if {[$a id] > [$b id]} { return -1 }
		return [string compare [$a name] [$b name]]}
            ] $ids] {
    puts -nonewline "[$id to_string] "
}
puts ""
=>
Original order:     3'Jane' 1'Bill' 4'Sam' 5'Nell'
Name,Id order:      1'Bill' 3'Jane' 5'Nell' 4'Sam'
Id desc,Name order: 5'Nell' 4'Sam' 3'Jane' 1'Bill'
```

Beachten Sie, dass bei Verwendung der Option **-command** des integrierten Befehls [lsort](https://www.tcl-lang.org/man/tcl/TclCmd/lsort.html)] der Befehl selbst *vor* der zu sortierenden Liste steht.

# AUTOREN

Andreas Kupries

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *lambda* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Hilfsprogramme

# COPYRIGHT

```
Copyright (c) 2011 Andreas Kupries, BSD licensed
```
