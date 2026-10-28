---
CommandName: is
title: is
ManualSection: n
Version: 3.3
TclPart: itcl
TclDescription: "[incr Tcl]"
Keywords:
 - class
 - object
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

itcl::is - Argument prüfen, ob es eine Klasse oder ein Objekt ist

# Übersicht

::: {.synopsis} :::
[itcl::is]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Der Befehl **is** prüft, ob das gegebene Argument eine Klasse oder ein Objekt ist, je nach der gegebenen Option. Wenn das Argument eine Klasse oder ein Objekt ist, wird 1 zurückgegeben. Sonst wird 0 zurückgegeben. Der Befehl **is** erkennt auch die Befehle, die im itcl-Befehl **code** verpackt sind.

Das Argument *option* legt fest, welche Aktion der Befehl ausführt. Die zulässigen *options* (die abgekürzt werden dürfen) sind:

**is class** *command*
: Gibt 1 zurück, wenn command eine Klasse ist, und gibt sonst 0 zurück.

    Der voll qualifizierte Name der Klasse muss als Argument *command* angegeben werden. Wenn eine Klasse in einem Namespace liegt, muss also auch der Namespace angegeben werden. Wenn eine Klasse **C** in einem Namespace **N** liegt, sollte der Befehl so aufgerufen werden:

    ```
    is N::C
        or
    is ::N::C
    ```

**is** object ?**-class** *className*? *command*
: Gibt 1 zurück, wenn *command* ein Objekt ist, und gibt sonst 0 zurück.

    Wenn der optionale Parameter „**-class**“ angegeben ist, wird das *command* im Kontext der gegebenen Klasse geprüft. *className* muss existieren. Sonst wird ein Fehler gemeldet. Wenn unsicher ist, ob *className* eine Klasse ist, muss die Existenz vorher geprüft werden, oder der Aufruf wird in eine catch-Anweisung gepackt.

    Wenn also **c** ein Objekt der Klasse **C** im Namespace N ist, sind dies die Möglichkeiten (alle geben 1 zurück):

    ```
    set obj [N::C c]
    itcl::is object N::c
    itcl::is object c
    itcl::is object $obj
    itcl::is object [itcl::code c]
    ```
