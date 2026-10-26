---
CommandName: local
ManualSection: n
Version: unknown
TclPart: itcl
TclDescription: "[incr\\ Tcl]"
Keywords:
 - class
 - object
 - procedure
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# NAME

itcl::local - ein Objekt erzeugen, das lokal zu einer Prozedur ist

# ÜBERSICHT

::: {.synopsis} :::
[itcl::local]{.cmd} [className]{.arg} [objName]{.arg} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl **local** erzeugt ein Objekt von **\[incr**\\ **Tcl\]**, das lokal zum aktuellen Aufruf-Frame ist. Wenn der Aufruf-Frame verschwindet, wird das Objekt automatisch gelöscht. Dieser Befehl eignet sich, um Objekte zu erzeugen, die lokal zu einer Prozedur sind.

Als Nebenwirkung erzeugt dieser Befehl eine Variable namens „**itcl-local-**_xxx_“, wobei *xxx* der Name des erzeugten Objekts ist. Diese Variable erkennt, wenn der Aufruf-Frame zerstört wird, und löscht das zugeordnete Objekt automatisch.

# BEISPIEL

Im folgenden Beispiel wird ein einfaches Objekt „counter“ innerhalb der Prozedur „test“ verwendet. Der Zähler wird als lokales Objekt erzeugt und deshalb bei jedem Verlassen der Prozedur automatisch gelöscht. Die Anweisungen **puts** in Konstruktor und Destruktor zeigen, wie das Objekt beim Aufruf der Prozedur entsteht und wieder verschwindet.

```
itcl::class counter {
    private variable count 0
    constructor {} {
        puts "created: $this"
    }
    destructor {
        puts "deleted: $this"
    }

    method bump {{by 1}} {
        incr count $by
    }
    method get {} {
        return $count
    }
}

proc test {val} {
    local counter x
    for {set i 0} {$i < $val} {incr i} {
        x bump
    }
    return [x get]
}

set result [test 5]
puts "test: $result"

set result [test 10]
puts "test: $result"

puts "objects: [itcl::find objects *]"
```
