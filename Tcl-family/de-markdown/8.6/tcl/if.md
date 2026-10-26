---
CommandName: if
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - expr(n)
 - for(n)
 - foreach(n)
Keywords:
 - boolean
 - conditional
 - else
 - false
 - if
 - true
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

if - Führt Scripte bedingt aus

# ÜBERSICHT

::: {.synopsis} :::
[if]{.cmd} [expr1]{.arg} [then]{.optlit} [body1]{.arg} [elseif]{.lit} [expr2]{.arg} [then]{.optlit} [body2]{.arg} [elseif]{.lit} ... [else]{.optlit} [bodyN]{.optarg} 
:::

# BESCHREIBUNG

Der Befehl *if* wertet *expr1* als Ausdruck aus (auf dieselbe Weise wie **expr** sein Argument auswertet). Der Wert des Ausdrucks muss ein Boolean sein (ein numerischer Wert, wobei 0 falsch und alles andere wahr ist, oder ein String-Wert wie **true** oder **yes** für wahr und **false** oder **no** für falsch); wenn er wahr ist, wird *body1* ausgeführt, indem es an den Tcl-Interpreter übergeben wird. Andernfalls wird *expr2* als Ausdruck ausgewertet, und wenn dieser wahr ist, wird **body2** ausgeführt, und so weiter. Wenn keiner der Ausdrücke zu wahr ausgewertet wird, wird *bodyN* ausgeführt. Die Argumente **then** und **else** sind optionale „Füllwörter“, um den Befehl leichter lesbar zu machen. Es kann eine beliebige Anzahl von **elseif**-Klauseln geben, einschließlich null. *BodyN* kann auch weggelassen werden, solange **else** ebenfalls weggelassen wird. Der Rückgabewert des Befehls ist das Ergebnis des Body-Scripts, das ausgeführt wurde, oder ein leerer String, wenn keiner der Ausdrücke nicht null war und es kein *bodyN* gab.

# BEISPIELE

Eine einfache Bedingung:

```
if {$vbl == 1} { puts "vbl is one" }
```

Mit einer **else**-Klausel:

```
if {$vbl == 1} {
    puts "vbl is one"
} else {
    puts "vbl is not one"
}
```

Mit einer **elseif**-Klausel:

```
if {$vbl == 1} {
    puts "vbl is one"
} elseif {$vbl == 2} {
    puts "vbl is two"
} else {
    puts "vbl is not one or two"
}
```

Beachten Sie: Ausdrücke können mehrzeilig sein, aber in diesem Fall kann es sinnvoll sein, das optionale Schlüsselwort **then** für mehr Klarheit zu verwenden:

```
if {
    $vbl == 1
    || $vbl == 2
    || $vbl == 3
} then {
    puts "vbl is one, two or three"
}
```

