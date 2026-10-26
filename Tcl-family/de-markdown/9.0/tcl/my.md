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

my, myclass - Ruft eine beliebige Methode des aktuellen Objekts oder seiner Klasse auf

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcl::oo]{.lit} 

[my]{.cmd} [methodName]{.arg} [arg]{.optdot} 
[myclass]{.cmd} [methodName]{.arg} [arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **my** ermöglicht es Methoden von Objekten, Methoden des Objekts (oder seiner Klasse) aufzurufen,

::: {.info -version="TIP478"}
und der Befehl **myclass** ermöglicht es Methoden von Objekten, Methoden der aktuellen Klasse des Objekts *als Objekt* aufzurufen.
:::

Insbesondere umfasst die Menge gültiger Werte für *methodName* alle Methoden, die ein Objekt und seine Superklassen unterstützen, einschließlich der nicht exportierten

::: {.info -version="TIP500"}
sowie privater Methoden des Objekts oder der Klasse, wenn sie innerhalb einer anderen von diesem Objekt oder dieser Klasse definierten Methode verwendet werden.
:::

Das Objekt, auf dem die Methode über **my** aufgerufen wird, ist dasjenige, dem der Namespace gehört, in dem der Befehl **my** ursprünglich enthalten ist (**Hinweis:** die Verknüpfung bleibt bestehen, wenn der Befehl umbenannt wird); standardmäßig ist das das gerade aufgerufene Objekt.

::: {.info -version="TIP478"}
Entsprechend ist das Objekt, auf dem die Methode über **myclass** aufgerufen wird, das Objekt, das die aktuelle Klasse des Objekts ist, dem der Namespace gehört, in dem der Befehl **myclass** ursprünglich enthalten ist. Wie bei **my** bleibt die Verknüpfung bestehen, auch wenn der Befehl in einen anderen Namespace umbenannt wird, und verweist standardmäßig auf die erzeugende Klasse des aktuellen Objekts.
:::

Jedes Objekt hat seine eigenen Befehle **my** und **myclass**, die in seinem Instanz-Namespace enthalten sind.

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

Dieses Beispiel zeigt, wie **my** verwendet werden kann, um von außerhalb des Objekts (über einen **trace**) Callbacks zu privaten Methoden zu machen, wobei **namespace code** den richtigen Kontext herstellt. (Siehe den Befehl **callback** für die empfohlene Vorgehensweise.)

```
oo::class create HasCallback {
    method makeCallback {} {
        return [namespace code {
            my Callback
        }]
    }

    method Callback {args} {
        puts "callback: $args"
    }
}

set o [HasCallback new]
trace add variable xyz write [$o makeCallback]
set xyz "called"     → prints "callback: xyz {} write"
```

::: {.info -version="TIP478"}
Dieses Beispiel zeigt den Zugriff auf eine private Methode einer Klasse von einer Instanz dieser Klasse aus. (Siehe die Deklaration **classmethod** in **oo::define** für eine höhere Schnittstelle dafür.)
:::

```
oo::class create CountedSteps {
    self {
        variable count
        method Count {} {
            return [incr count]
        }
    }
    method advanceTwice {} {
        puts "in [self] step A: [myclass Count]"
        puts "in [self] step B: [myclass Count]"
    }
}

CountedSteps create x
CountedSteps create y
x advanceTwice       → prints "in ::x step A: 1"
                     → prints "in ::x step B: 2"
y advanceTwice       → prints "in ::y step A: 3"
                     → prints "in ::y step B: 4"
x advanceTwice       → prints "in ::x step A: 5"
                     → prints "in ::x step B: 6"
y advanceTwice       → prints "in ::y step A: 7"
                     → prints "in ::y step B: 8"
```
