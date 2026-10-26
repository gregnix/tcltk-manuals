---
CommandName: class
title: class
ManualSection: n
Version: 0.1
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - oo::define(n)
 - oo::object(n)
Keywords:
 - class
 - metaclass
 - object
Copyright:
 - Copyright (c) 2007 Donal K. Fellows
---

# Name

oo::class - Klasse aller Klassen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [TclOO]{.lit}

[oo::class]{.cmd} [method]{.arg} [arg]{.optdot}
:::

# Klassenhierarchie

::: {.classhierarchy} :::

```
oo::object
   → oo::class
```
:::

# Beschreibung

Klassen sind Objekte, die nach einem in dem Fabrikobjekt (der Klasse) gespeicherten Muster andere Objekte erzeugen können. Eine Instanz der Klasse wird erzeugt, indem eine der Fabrikmethoden der Klasse aufgerufen wird, typischerweise **create**, wenn ein expliziter Name vergeben wird, oder **new**, wenn automatisch ein beliebiger eindeutiger Name gewählt werden soll.

Die Klasse **oo::class** ist die Klasse aller Klassen; jede Klasse ist eine Instanz dieser Klasse, die folglich eine Instanz von sich selbst ist. Diese Klasse ist eine Unterklasse von [oo::object][object], sodass jede Klasse auch ein Objekt ist. Weitere Metaklassen (Klassen von Klassen) können bei Bedarf durch Subklassierung von **oo::class** definiert werden. Beachten Sie, dass das Objekt **oo::class** die Methode **new** auf sich selbst verbirgt; neue Klassen sollten daher immer mit der Methode **create** erzeugt werden.

## Konstruktor

Der Konstruktor der Klasse **oo::class** nimmt ein optionales Argument entgegen, das — falls vorhanden — zusammen mit dem Namen der neu erzeugten Klasse an [oo::define][define] übergeben wird, damit die Klasse bei der Erstellung bequem konfiguriert werden kann.

## Destruktor

Die Klasse **oo::class** definiert keinen expliziten Destruktor. Wird jedoch eine Klasse zerstört, werden auch alle ihre Unterklassen und Instanzen zerstört, ebenso alle Objekte, in die sie gemischt wurde.

## Exportierte Methoden

*cls* **create** *name* ?*arg ...*?
: Erzeugt eine neue Instanz der Klasse *cls* mit dem Namen *name* (wird im Namespace des Aufrufkontexts aufgelöst, wenn nicht voll qualifiziert), übergibt die Argumente *arg ...* an den Konstruktor und gibt (bei erfolgreichem Ergebnis) den voll qualifizierten Namen des erzeugten Objekts zurück (das Ergebnis des Konstruktors wird ignoriert). Schlägt der Konstruktor fehl (liefert kein OK-Ergebnis), wird das Objekt zerstört und die Fehlermeldung ist das Ergebnis dieses Methodenaufrufs.

*cls* **new** ?*arg ...*?
: Erzeugt eine neue Instanz der Klasse *cls* mit einem neuen eindeutigen Namen, übergibt die Argumente *arg ...* an den Konstruktor und gibt (bei erfolgreichem Ergebnis) den voll qualifizierten Namen des erzeugten Objekts zurück (das Ergebnis des Konstruktors wird ignoriert). Schlägt der Konstruktor fehl, wird das Objekt zerstört und die Fehlermeldung ist das Ergebnis dieses Methodenaufrufs.

    Beachten Sie, dass diese Methode vom Objekt **oo::class** selbst nicht exportiert wird; Klassen sollten daher nicht mit dieser Methode erzeugt werden.


## Nicht exportierte Methoden

Die Klasse **oo::class** unterstützt folgende nicht exportierte Methoden:

*cls* **createWithNamespace** *name nsName* ?*arg ...*?
: Erzeugt eine neue Instanz der Klasse *cls* mit dem Namen *name* (wird im Namespace des Aufrufkontexts aufgelöst, wenn nicht voll qualifiziert), übergibt die Argumente *arg ...* an den Konstruktor und gibt (bei erfolgreichem Ergebnis) den voll qualifizierten Namen des erzeugten Objekts zurück (das Ergebnis des Konstruktors wird ignoriert). Der Name des Instanz-Namespace des Objekts ist *nsName*; es ist ein Fehler, wenn dieser Namespace nicht erzeugt werden kann. Schlägt der Konstruktor fehl, wird das Objekt zerstört und die Fehlermeldung ist das Ergebnis dieses Methodenaufrufs.


# Beispiele

Dieses Beispiel definiert eine einfache Klassenhierarchie, erzeugt eine neue Instanz und ruft eine Methode des Objekts auf, bevor die Hierarchie zerstört wird und gezeigt wird, dass die Zerstörung transitiv ist.

```
oo::class create fruit {
    method eat {} {
        puts "yummy!"
    }
}
oo::class create banana {
    superclass fruit
    constructor {} {
        my variable peeled
        set peeled 0
    }
    method peel {} {
        my variable peeled
        set peeled 1
        puts "skin now off"
    }
    method edible? {} {
        my variable peeled
        return $peeled
    }
    method eat {} {
        if {![my edible?]} {
            my peel
        }
        next
    }
}
set b [banana new]
$b eat               → prints "skin now off" and "yummy!"
fruit destroy
$b eat               → error "unknown command"
```


[define]: define.md
[object]: object.md
