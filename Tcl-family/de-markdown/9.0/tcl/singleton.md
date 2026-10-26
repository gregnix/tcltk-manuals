---
CommandName: singleton
title: singleton
ManualSection: n
Version: 0.3
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - oo::class(n)
Keywords:
 - class
 - metaclass
 - object
 - single instance
Copyright:
 - Copyright (c) 2018 Donal K. Fellows
---

# Name

oo::singleton - Klasse, die höchstens eine Instanz von sich selbst zulässt

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcl::oo]{.lit}

[oo::singleton]{.cmd} [method]{.arg} [arg]{.optdot}
:::

# Klassenhierarchie

::: {.classhierarchy} :::

```
oo::object
   → oo::class
       → oo::singleton
```
:::

# Beschreibung

Singleton-Klassen sind Klassen, die höchstens eine Instanz von sich selbst zulassen. Sie exportieren die Methoden **create** und **createWithNamespace** vollständig nicht und überschreiben **new** so, dass nur dann eine neue Instanz erzeugt wird, wenn noch keine existiert. Von einer Singleton-Klasse zu erben wird nicht empfohlen; Singleton-Eigenschaft wird *nicht* vererbt. Es wird nicht empfohlen, dass der Konstruktor einer Singleton-Klasse Argumente annimmt.

Instanzen haben ihre Methode **destroy** durch eine Methode ersetzt, die stets einen Fehler zurückgibt, um die Zerstörung des Objekts zu erschweren; Zerstörung bleibt bei striktem Bedarf möglich (z. B. durch Zerstörung der Klasse oder [rename] zum Löschen). Sie definieren außerdem eine (nicht exportierte) Methode **<cloned>**, die ebenfalls stets Fehler zurückgibt, damit Versuche, die Singleton-Instanz mit [oo::copy][copy] zu nutzen, scheitern.

## Konstruktor

Die Klasse **oo::singleton** definiert keinen expliziten Konstruktor; sie verhält sich damit wie der Konstruktor der Klasse [oo::class][class].

## Destruktor

Die Klasse **oo::singleton** definiert keinen expliziten Destruktor; das Zerstören einer Instanz entspricht dem Zerstören einer gewöhnlichen Klasse (und zerstört das Singleton-Objekt).

## Exportierte Methoden

[cls]{.ins} [new]{.sub} [arg]{.optdot}
: Gibt die aktuelle Instanz der Singleton-Klasse zurück, falls eine existiert, und erzeugt nur dann eine neue Instanz, wenn noch keine existiert. Die zusätzlichen Argumente *arg ...* werden nur verwendet, wenn tatsächlich eine neue Instanz erzeugt wird; die Erzeugung erfolgt über **new** der Klasse [oo::class][class].

    Dies überschreibt das Verhalten einer Superklassen-Methode mit derselben Aufrufsignatur.


## Nicht exportierte Methoden

Die Klasse **oo::singleton** erklärt ausdrücklich, dass **create** und **createWithNamespace** nicht exportiert sind; Aufrufer dürfen nicht annehmen, dass sie Name oder Namespace-Name der Singleton-Instanz steuern können.

# Beispiele

Dieses Beispiel zeigt, dass es nur eine Instanz gibt, obwohl **new** dreimal aufgerufen wird.

```
oo::singleton create Highlander {
    method say {} {
        puts "there can be only one"
    }
}

set h1 [Highlander new]
set h2 [Highlander new]
if {$h1 eq $h2} {
    puts "equal objects"    → prints "equal objects"
}
set h3 [Highlander new]
if {$h1 eq $h3} {
    puts "equal objects"    → prints "equal objects"
}
```

Beachten Sie, dass der Name der Singleton-Instanz nicht garantiert ist.


[class]: class.md
[copy]: copy.md
[rename]: rename.md
