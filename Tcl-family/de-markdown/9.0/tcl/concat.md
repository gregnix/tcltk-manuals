---
CommandName: concat
ManualSection: n
Version: 8.3
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - append(n)
 - eval(n)
 - join(n)
 - list(n)
Keywords:
 - concatenate
 - join
 - list
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

concat - Verbindet Listen miteinander

# ÜBERSICHT

::: {.synopsis} :::
[concat]{.cmd} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Der Befehl verbindet die Argumente mit Leerzeichen, nachdem führende und nachfolgende Leerraumzeichen an jedem Argument entfernt wurden. Sind alle Argumente Listen, entspricht das dem Zusammenfügen zu einer Liste. Leere Argumente (nach dem Trimmen) werden ignoriert. Beliebig viele Argumente; ohne *arg*s: leere Zeichenkette.

# BEISPIELE

**concat** verkettet Listen und flacht sie dabei ab:

```
% concat a b {c d e} {f {g h}}
a b c d e f {g h}
```

Es verkettet auch Nicht-Listen:

```
% concat " a b {c   " d "  e} f"
a b {c d e} f
```

Die Verkettung entfernt keine Leerzeichen in der Mitte von Werten:

```
% concat "a   b   c" { d e f }
a   b   c d e f
```

(drei Leerzeichen zwischen **a**, **b** und **c**).

Für echte Listenverkettung **list** mit Expansion:

```
% list {*}"a   b   c" {*}{ d e f }
a b c d e f
```
