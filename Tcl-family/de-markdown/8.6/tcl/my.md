---
CommandName: my
ManualSection: n
Version: 0.1
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - next(n)
 - oo::object(n)
 - self(n)
Keywords:
 - method
 - method visibility
 - object
 - private method
 - public method
Copyright:
 - Copyright (c) 2007 Donal K. Fellows
---

# NAME

my - Ruft eine beliebige Methode des aktuellen Objekts auf

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 

[my]{.cmd} [methodName]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **my** ermöglicht es Methoden von Objekten, eine beliebige Methode des Objekts (oder seiner Klasse) aufzurufen. Insbesondere umfasst die Menge gültiger Werte für *methodName* alle Methoden, die ein Objekt und seine Superklassen unterstützen, einschließlich der nicht exportierten. Das Objekt, auf dem die Methode aufgerufen wird, ist stets dasjenige, das der aktuelle Kontext der Methode ist (d. h. das Objekt, das von **self object** zurückgegeben wird), aus der der Befehl **my** aufgerufen wird.

Jedes Objekt hat seinen eigenen Befehl **my**, der in seinem Instanz-Namespace enthalten ist.

# BEISPIELE

Dieses Beispiel zeigt die grundlegende Verwendung von **my**, um die Methode **variables** der Klasse **oo::object** aufzurufen, die standardmäßig nicht öffentlich sichtbar ist:

```
oo::class create c {
    method count {} {
        my variable counter
        puts [incr counter]
    }
}
c create o
o count              → prints "1"
o count              → prints "2"
o count              → prints "3"
```
