---
CommandName: cd
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - filename(n)
 - glob(n)
 - pwd(n)
Keywords:
 - working directory
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

cd - Wechselt das Arbeitsverzeichnis

# ÜBERSICHT

::: {.synopsis} :::
[cd]{.cmd} [dirName]{.optarg} 
:::

# BESCHREIBUNG

Wechselt das aktuelle Arbeitsverzeichnis zu *dirName* oder, wenn *dirName* nicht angegeben ist, zum Home-Verzeichnis (wie in der Umgebungsvariable HOME festgelegt). Gibt eine leere Zeichenkette zurück.

Das aktuelle Arbeitsverzeichnis ist eine ressourcenbezogene Größe pro Prozess; der Befehl **cd** ändert das Arbeitsverzeichnis für alle Interpreter und alle Threads.

# BEISPIELE

Wechselt ins Home-Verzeichnis des Benutzers **fred**:

```
cd [file home fred]
```

Wechselt in das Verzeichnis **lib**, das ein Geschwisterverzeichnis des aktuellen ist:

```
cd ../lib
```
