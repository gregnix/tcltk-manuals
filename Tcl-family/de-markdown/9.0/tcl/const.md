---
CommandName: const
ManualSection: n
Version: 9.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - proc(n)
 - namespace(n)
 - set(n)
 - unset(n)
Keywords:
 - namespace
 - procedure
 - variable
 - constant
Copyright:
 - Copyright (c) 2023 Donal K. Fellows
---

# NAME

const - Konstante erzeugen und initialisieren

# ÜBERSICHT

::: {.synopsis} :::
[const]{.cmd} [varName]{.arg} [value]{.arg} 
:::

# BESCHREIBUNG

Der Befehl wird üblicherweise im Körper einer Prozedur (oder Methode, oder in einem Lambda-Term) verwendet, um dort eine Konstante anzulegen, oder im Körper von **namespace eval**, um eine Konstante im Namespace zu erzeugen. Die Konstante ist eine nicht veränderbare Variable *varName*, initialisiert mit *value*. Bei Erfolg liefert **const** stets einen leeren String.

Existiert *varName* noch nicht, wird sie mit Wert *value* erzeugt und als Konstante markiert: andere Befehle (**set**, **append**, **incr**, **unset**) dürfen die Variable weder ändern noch entfernen; vor Traces wird geprüft, ob eine Variable Konstante ist. Existiert *varName* bereits, ist das ein Fehler — außer die Variable ist bereits als Konstante markiert (dann ist **const** eine No-Op).

*varName* darf kein qualifizierter Name sein und darf kein Array-Element bezeichnen. Existiert die Variable bereits als Array, ist das ein Fehler.

Konstanten werden normalerweise erst entfernt, wenn die umgebende Prozedur endet oder der Namespace gelöscht wird.

# BEISPIELE

Konstante in einer Prozedur:

```
proc foo {a b} {
    const BAR 12345
    return [expr {$a + $b + $BAR}]
}
```

Konstante in einem Namespace für einen regulären Ausdruck:

```
namespace eval someNS {
    const FOO_MATCHER {(?i)}\mfoo\M}

    proc findFoos str {
        variable FOO_MATCHER
        regexp -all $FOO_MATCHER $str
    }

    proc findFooIndices str {
        variable FOO_MATCHER
        regexp -all -indices $FOO_MATCHER $str
    }
}
```

Konstante in einer Schleife erzeugt keinen Fehler:

```
proc foo {n} {
    set result {}
    for {set i 0} {$i < $n} {incr i} {
        const X 123
	lappend result [expr {$X + $i**2}]
    }
}
```
