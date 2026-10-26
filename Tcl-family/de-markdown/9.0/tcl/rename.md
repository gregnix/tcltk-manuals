---
CommandName: rename
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - namespace(n)
 - proc(n)
Keywords:
 - command
 - delete
 - namespace
 - rename
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
---

# NAME

rename - Benennt einen Befehl um oder löscht ihn

# ÜBERSICHT

::: {.synopsis} :::
[rename]{.cmd} [oldName]{.arg} [newName]{.arg} 
:::

# BESCHREIBUNG

Benennt den Befehl *oldName* in *newName* um. Ist *newName* eine leere Zeichenkette, wird *oldName* gelöscht. *oldName* und *newName* dürfen Namespace-Qualifizierer enthalten. Wird ein Befehl in einen anderen Namespace umbenannt, laufen künftige Aufrufe in diesem Namespace. **rename** gibt eine leere Zeichenkette zurück.

# BEISPIELE

**rename** kann Standardbefehle mit eigener Überwachung umschließen — z. B. zählen, wie oft **source** aufgerufen wird:

```
rename ::source ::theRealSource
set sourceCount 0
proc ::source args {
    global sourceCount
    puts "called source for the [incr sourceCount]'th time"
    uplevel 1 ::theRealSource $args
}
```
