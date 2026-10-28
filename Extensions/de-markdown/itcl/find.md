---
CommandName: find
title: find
ManualSection: n
Version: 3.0
TclPart: itcl
TclDescription: "[incr Tcl]"
Keywords:
 - class
 - object
 - search
 - import
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

itcl::find - Klassen und Objekte suchen

# Übersicht

::: {.synopsis} :::
[itcl::find]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Der Befehl **find** sucht Klassen und Objekte, die im aktuellen Interpreter verfügbar sind. Klassen und Objekte werden zuerst im aktiven Namespace gemeldet, dann in allen anderen Namespaces des Interpreters.

Das Argument *option* legt fest, welche Aktion der Befehl ausführt. Die zulässigen *options* (die abgekürzt werden dürfen) sind:

**find classes** ?*pattern*?
: Gibt eine Liste der Klassen von \[incr Tcl\] zurück. Klassen im aktuellen Namespace stehen zuerst, danach die Klassen in allen anderen Namespaces des Interpreters. Wenn das optionale *pattern* angegeben ist, werden die gemeldeten Namen nach den Regeln des Befehls „**string match**“ verglichen, und nur passende Namen werden gemeldet.

    Wenn eine Klasse im aktuellen Namespace-Kontext liegt, meldet dieser Befehl ihren einfachen Namen, ohne Qualifizierer. Wenn das *pattern* jedoch Qualifizierer **::** enthält oder die Klasse in einem anderen Kontext liegt, meldet dieser Befehl ihren voll qualifizierten Namen. Mit dem folgenden Befehl erhält man deshalb eine Liste, in der alle Namen voll qualifiziert sind:

    ```
    itcl::find classes ::*
    ```

**find objects** ?*pattern*? ?**-class** *className*? ?**-isa** *className*?
: Gibt eine Liste der Objekte von \[incr Tcl\] zurück. Objekte im aktuellen Namespace stehen zuerst, danach die Objekte in allen anderen Namespaces des Interpreters. Wenn das optionale *pattern* angegeben ist, werden die gemeldeten Namen nach den Regeln des Befehls „**string match**“ verglichen, und nur passende Namen werden gemeldet. Wenn der optionale Parameter „**-class**“ angegeben ist, beschränkt sich diese Liste auf Objekte, deren spezifischste Klasse *className* ist. Wenn der optionale Parameter „**-isa**“ angegeben ist, beschränkt sich die Liste weiter auf Objekte, die das gegebene *className* irgendwo in ihrer Abstammung haben.

    Wenn ein Objekt im aktuellen Namespace-Kontext liegt, meldet dieser Befehl seinen einfachen Namen, ohne Qualifizierer. Wenn das *pattern* jedoch Qualifizierer **::** enthält oder das Objekt in einem anderen Kontext liegt, meldet dieser Befehl seinen voll qualifizierten Namen. Mit dem folgenden Befehl erhält man deshalb eine Liste, in der alle Namen voll qualifiziert sind:

    ```
    itcl::find objects ::*
    ```
