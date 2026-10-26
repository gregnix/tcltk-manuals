---
CommandName: code
ManualSection: n
Version: 3.0
TclPart: itcl
TclDescription: "[incr\\ Tcl]"
Keywords:
 - scope
 - callback
 - namespace
 - public
 - protected
 - private
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# NAME

itcl::code - den Namespace-Kontext eines Codefragments festhalten

# ÜBERSICHT

::: {.synopsis} :::
[itcl::code]{.cmd} [-namespace name]{.optarg} [command]{.arg} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Erzeugt einen geltungsbezogenen Wert für den angegebenen *command* und die zugehörigen Argumente *arg*. Ein geltungsbezogener Wert ist eine Liste mit drei Elementen: dem Schlüsselwort "\\ffC@scope", einem Namespace-Kontext und einer Wert-Zeichenkette. Der Befehl

```
namespace foo {
    code puts "Hello World!"
}
```

erzeugt zum Beispiel den geltungsbezogenen Wert:

```
@scope ::foo {puts {Hello World!}}
```

Der Befehl **code** hält den aktuellen Namespace-Kontext fest. Wenn die Option **-namespace** angegeben ist, wird der aktuelle Kontext ignoriert, und die Zeichenkette *name* wird als Namespace-Kontext verwendet.

Erweiterungen wie Tk führen gewöhnliche Codefragmente im globalen Namespace aus. Ein geltungsbezogener Wert hält ein Codefragment samt seinem Namespace-Kontext so fest, dass es sich später richtig ausführen lässt. Er wird zum Beispiel gebraucht, um Codefragmente einzupacken, wenn ein Tk-Widget innerhalb eines Namespace verwendet wird:

```
namespace foo {
    private proc report {mesg} {
        puts "click: $mesg"
    }

    button .b1 -text "Push Me" \
        -command [code report "Hello World!"]
    pack .b1
}
```

Das Codefragment der Schaltfläche \\ffC.b1 ist nur im Kontext des Namespace „foo“ sinnvoll. Außerdem ist die Prozedur „report“ private und nur innerhalb dieses Namespace zugänglich. Der Befehl **code** packt das Codefragment so ein, dass es richtig ausgeführt wird, wenn die Schaltfläche gedrückt wird.

Außerdem bewahrt der Befehl **code** die Argumente auf der Befehlszeile unversehrt. Dadurch ist er ein natürlicher Ersatz für den Befehl **list**, mit dem Tcl-Codefragmente oft formatiert werden. Mit anderen Worten, statt den Befehl **list** so zu verwenden:

```
after 1000 [list puts "Hello $name!"]
```

wird der Befehl **code** so verwendet:

```
after 1000 [code puts "Hello $name!"]
```

Das formatiert nicht nur den Befehl richtig, sondern hält auch seinen Namespace-Kontext fest.

Geltungsbezogene Befehle lassen sich wie gewöhnliche Codefragmente aufrufen, mit oder ohne den Befehl **eval**. Die folgenden Anweisungen funktionieren zum Beispiel richtig:

```
set cmd {@scope ::foo .b1}
$cmd configure -background red

set opts {-bg blue -fg white}
eval $cmd configure $opts
```

Geltungsbezogene Befehle umgehen die üblichen Schutzmechanismen; der Befehl

```
@scope ::foo {report {Hello World!}}
```

kann dazu dienen, aus jedem Namespace-Kontext auf das proc „foo::report“ zuzugreifen, obwohl es private ist.
