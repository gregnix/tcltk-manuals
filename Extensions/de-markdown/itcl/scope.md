---
CommandName: scope
title: scope
ManualSection: n
Version: unknown
TclPart: itcl
TclDescription: "[incr Tcl]"
Keywords:
 - code
 - namespace
 - variable
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

itcl::scope - den Namespace-Kontext einer Variablen festhalten

# Übersicht

::: {.synopsis} :::
[itcl::scope]{.cmd} [name]{.arg}
:::

# Beschreibung

Erzeugt einen geltungsbezogenen Wert für den angegebenen *name*, der ein Variablenname sein muss. Wenn der *name* eine Instanzvariable ist, gibt der Befehl scope einen Namen zurück, der sich in jedem Kontext als Instanzvariable auflöst, die zu *object* gehört. Das genaue Format dieses Namens ist eine interne Einzelheit von Itcl. Ein solcher geltungsbezogener Wert macht es möglich, Instanzvariablen zusammen mit Widgets zu verwenden. Wenn ein Objekt eine private Variable **x** hat, lässt sich **x** zusammen mit der Option **-textvariable** eines Entry-Widgets verwenden. Vor itcl3.0 ließen sich auf diese Weise nur common-Variablen verwenden.

Wenn der *name* keine Instanzvariable ist, muss es eine common-Variable oder eine globale Variable sein. In diesem Fall gibt der Befehl scope den voll qualifizierten Namen der Variablen zurück, zum Beispiel **::foo::bar::x**.

Wenn der *name* nicht als Variable erkannt wird, gibt der Befehl scope einen Fehler zurück.

Gewöhnliche Variablennamen bezeichnen Variablen im globalen Namespace. Ein geltungsbezogener Wert hält einen Variablennamen samt seinem Namespace-Kontext so fest, dass später richtig darauf Bezug genommen werden kann. Er wird zum Beispiel gebraucht, um Variablennamen einzupacken, wenn ein Tk-Widget innerhalb eines Namespace verwendet wird:

```
namespace foo {
    private variable mode 1

    radiobutton .rb1 -text "Mode #1" \
        -variable [scope mode] -value 1
    pack .rb1

    radiobutton .rb2 -text "Mode #2" \
        -variable [scope mode] -value 2
    pack .rb2
}
```

Die Radiobuttons **.rb1** und **.rb2** wirken über die Variable „mode“ zusammen, die im Namespace „foo“ enthalten ist. Der Befehl **scope** stellt das sicher, indem er den voll qualifizierten Variablennamen **::foo::mode** zurückgibt.

Eigene geltungsbezogene Variablennamen sollten nie selbst gebastelt werden, auch wenn die Kodierung fehlerfrei nachgebaut scheint. Stattdessen sollte immer der Befehl scope den Variablennamen dynamisch erzeugen. Dieser Name lässt sich dann an ein Widget oder an jedes andere Stück Code im Programm übergeben.
