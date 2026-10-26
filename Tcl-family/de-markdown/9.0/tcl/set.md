---
CommandName: set
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - expr(n)
 - global(n)
 - namespace(n)
 - proc(n)
 - trace(n)
 - unset(n)
 - upvar(n)
 - variable(n)
Keywords:
 - read
 - write
 - variable
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

set - Liest und schreibt Variablen

# ÜBERSICHT

::: {.synopsis} :::
[set]{.cmd} [varName]{.arg} [value]{.optarg} 
:::

# BESCHREIBUNG

Gibt den Wert der Variable *varName* zurück. Wenn *value* angegeben ist, wird der Wert von *varName* auf *value* gesetzt, wobei eine neue Variable erstellt wird, falls noch keine existiert, und ihr Wert zurückgegeben wird. Wenn *varName* eine öffnende Klammer enthält und mit einer schließenden Klammer endet, bezieht es sich auf ein Array-Element: Die Zeichen vor der ersten öffnenden Klammer sind der Name des Arrays, und die Zeichen zwischen den Klammern sind der Index innerhalb des Arrays. Andernfalls bezieht sich *varName* auf eine skalare Variable.

Wenn *varName* Namespace-Qualifizierer enthält (im Array-Namen, falls es sich auf ein Array-Element bezieht), oder wenn *varName* unqualifiziert ist (keine Namen von umgebenden Namespaces enthält), aber keine Prozedur aktiv ist, bezieht sich *varName* auf eine Namespace-Variable, die gemäß den Regeln unter **NAME RESOLUTION** in der **namespace**-Manpage aufgelöst wird.

Wenn eine Prozedur aktiv ist und *varName* unqualifiziert ist, bezieht sich *varName* auf einen Parameter oder eine lokale Variable der Prozedur, es sei denn, *varName* wurde durch einen der Befehle **global**, **variable** oder **upvar** anders deklariert.

# BEISPIELE

Speichert eine Zufallszahl in der Variable *r*:

```
set r [expr {rand()}]
```

Speichert eine kurze Nachricht in einem Array-Element:

```
set anAry(msg) "Hello, World!"
```

Speichert eine kurze Nachricht in einem Array-Element, das durch eine Variable spezifiziert ist:

```
set elemName "msg"
set anAry($elemName) "Hello, World!"
```

Kopiert einen Wert in die Variable *out* aus einer Variable, deren Name in *vbl* gespeichert ist (beachten Sie, dass es in der Praxis oft einfacher ist, Arrays zu verwenden, statt doppelte Dereferenzierung):

```
set in0 "small random"
set in1 "large random"
set vbl in[expr {rand() >= 0.5}]
set out [set $vbl]
```

