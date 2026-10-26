---
CommandName: incr
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - expr(n)
 - set(n)
Keywords:
 - add
 - increment
 - variable
 - value
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

incr - Erhöht den Wert einer Variable

# ÜBERSICHT

::: {.synopsis} :::
[incr]{.cmd} [varName]{.arg} [increment]{.optarg} 
:::

# BESCHREIBUNG

Erhöht den in der Variable *varName* gespeicherten Wert. Der Variablenwert muss eine Ganzzahl sein. Ist *increment* angegeben, wird dessen Wert (ebenfalls eine Ganzzahl) zum Wert von *varName* addiert; andernfalls wird 1 addiert. Der neue Wert wird als Dezimalzeichenkette in *varName* gespeichert und auch als Ergebnis zurückgegeben.

Ab Tcl 8.5 darf *varName* unset sein; dann wird sie auf den Wert *increment* oder den Standard-Inkrementwert **1** gesetzt.

::: {.info -version="TIP508"}
Verweist *varName* auf ein nicht existierendes Element eines Arrays mit gesetztem Standardwert, wird die Summe aus Standardwert und *increment* (oder 1) im Array-Element gespeichert.
:::

# BEISPIELE

Addiert eins zum Inhalt der Variable *x*:

```
incr x
```

Addiert 42 zum Inhalt der Variable *x*:

```
incr x 42
```

Addiert den Inhalt der Variable *y* zum Inhalt der Variable *x*:

```
incr x $y
```

Addiert nichts zur Variable *x* (oft nützlich, um zu prüfen, ob ein Prozedurargument wirklich ganzzahlig ist, und andernfalls einen Fehler zu erzeugen):

```
incr x 0
```
