---
CommandName: abstract
title: abstract
ManualSection: n
Version: 0.3
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - oo::define(n)
 - oo::object(n)
Keywords:
 - abstract class
 - class
 - metaclass
 - object
Copyright:
 - Copyright (c) 2018 Donal K. Fellows
---

# Name

oo::abstract - Eine Klasse, die keine direkten Instanzen von sich selbst erlaubt

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcl::oo]{.lit}

[oo::abstract]{.cmd} [method]{.arg} [arg]{.optdot}
:::

# Klassenhierarchie

::: {.classhierarchy} :::

```
oo::object
   → oo::class
       → oo::abstract
```
:::

# Beschreibung

Abstrakte Klassen sind Klassen, die Definitionen enthalten können, aber nicht direkt instanziiert werden können. Sie sind nur dazu gedacht, vererbt und indirekt instanziiert zu werden. Die charakteristischen Methoden von [oo::class][class] (**create** und **new**) werden von einer Instanz von **oo::abstract** nicht exportiert.

Beachten Sie, dass **oo::abstract** selbst keine Instanz von **oo::abstract** ist.

## Konstruktor

Die Klasse **oo::abstract** definiert keinen expliziten Konstruktor; das bedeutet, dass sie effektiv identisch mit dem Konstruktor der Klasse [oo::class][class] ist.

## Destruktor

Die Klasse **oo::abstract** definiert keinen expliziten Destruktor; das Zerstören einer Instanz ist genauso wie das Zerstören einer gewöhnlichen Klasse (und zerstört alle ihre Unterklassen).

## Exportierte Methoden

Die Klasse **oo::abstract** definiert keine neuen exportierten Methoden.

## Nicht-exportierte Methoden

Die Klasse **oo::abstract** erklärt explizit, dass **create**, **createWithNamespace** und **new** nicht exportiert sind.

# Beispiele

Dieses Beispiel definiert eine einfache Klassenhierarchie, erzeugt eine neue Instanz und ruft eine Methode des Objekts auf, bevor die Hierarchie zerstört wird und gezeigt wird, dass die Zerstörung transitiv ist.

```
oo::abstract create fruit {
    method eat {} {
        puts "yummy!"
    }
}
oo::class create banana {
    superclass fruit
    method peel {} {
        puts "skin now off"
    }
}
set b [banana new]
$b peel              → prints 'skin now off'
$b eat               → prints 'yummy!'
set f [fruit new]    → error 'unknown method "new"...'
```


[class]: class.md
