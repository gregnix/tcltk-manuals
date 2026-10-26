---
CommandName: configurable
title: configurable
ManualSection: n
Version: 0.4
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - info(n)
 - oo::class(n)
 - oo::define(n)
Keywords:
 - class
 - object
 - properties
 - configuration
Copyright:
 - Copyright (c) 2019 Donal K. Fellows
---

# Name

oo::configurable, configure, property - Klasse für konfigurierbare Klassen und Objekte sowie Unterstützung konfigurierbarer Properties

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [TclOO]{.lit}

[oo::configurable]{.cmd} [create]{.sub} [class]{.arg} [definitionScript]{.optarg}

[oo::define]{.cmd} [class]{.arg} [{]{.lit}
[property]{.cmd} [propName]{.arg} [options...]{.optarg} [propName ?options...?...]{.optarg}
[}]{.cmd}

[oo::objdefine]{.cmd} [object]{.arg} [{]{.lit}
[property]{.cmd} [propName]{.arg} [options...]{.optarg} [propName ?options...?...]{.optarg}
[}]{.cmd}

[objectName]{.ins} [configure]{.sub}
[objectName]{.ins} [configure]{.sub} [-prop]{.arg}
[objectName]{.ins} [configure]{.sub} [-prop]{.arg} [value]{.arg} [-prop value...]{.optarg}
:::

# Klassenhierarchie

::: {.classhierarchy} :::

```
oo::object
   → oo::class
       → oo::configurable

oo::object
   → oo::class
       → oo::configurablesupport::configurable
```
:::

# Beschreibung

Konfigurierbare Objekte sind Objekte, die über eine **configure**-Methode konfiguriert werden können. Jede konfigurierbare Entität eines Objekts heißt Property des Objekts. Properties können auf Klassen oder Instanzen definiert werden; beim Konfigurieren eines Objekts können alle von seinen Klassen (direkt oder indirekt) oder von der Instanz selbst definierten Properties konfiguriert werden.

Die Metaklasse **oo::configurable** installiert grundlegende Unterstützung für konfigurierbare Objekte in einer Klasse. Dazu gehört ein **property**-Definitionsbefehl in Definitionsskripten für Klasse und Instanzen (z. B. aus dem Konstruktor der Klasse, innerhalb von [oo::define][define] und [oo::objdefine][define]) sowie eine **configure**-Methode in den Instanzen.

## Configure-Methode

Das Verhalten der **configure**-Methode orientiert sich am Befehl [fconfigure]/[chan configure][chan].

Ohne weitere Argumente gibt die **configure**-Methode ein alphabetisch sortiertes Dictionary aller lesbaren und les- und schreibbaren Properties mit ihren aktuellen Werten zurück.

Mit genau einem weiteren Argument muss dieses der Name einer auszulesenden Property sein (oder ein eindeutiges Präfix davon); der Wert wird zurückgegeben.

Andernfalls: Bei einer geraden Anzahl weiterer Argumente gibt jedes Argumentpaar einen Property-Namen (oder ein eindeutiges Präfix) und den zu setzenden Wert an. Die Properties werden in der angegebenen Reihenfolge gesetzt, einschließlich Duplikaten. Schlägt das Setzen einer Property fehl, schlägt die **configure**-Methode insgesamt fehl; vorherige Paare (falls vorhanden) bleiben angewendet, nachfolgende Paare (falls vorhanden) werden nicht angewendet. Bei Erfolg ist das Ergebnis der **configure**-Methode in diesem Modus eine leere Zeichenkette.

## Property-Definitionen

Wurde eine Klasse von der Metaklasse **oo::configurable** (oder einer ihrer Unterklassen) erzeugt, erhält sie eine zusätzliche Definition **property**. Die Definition **property** legt eine oder mehrere Properties fest, die von Instanzen der Klasse bereitgestellt werden.

Der Befehl **property** erwartet zuerst den Namen einer zu definierenden Property *ohne führenden Bindestrich*, gefolgt von Option-Wert-Paaren, die das Grundverhalten der Property ändern. Anschließend können beliebig viele weitere Property-Definitionen folgen. Unterstützte Optionen:

[-get]{.lit} [getterScript]{.arg}
: Definiert die Implementierung des Lesens der Property; *getterScript* wird zum Rumpf einer Methode (ohne Argumente) auf der Klasse, wenn die Property-Art das Lesen erlaubt. Die Methode heißt **<ReadProp-***propertyName***>** und ist standardmäßig ein einfaches Lesen der Instanzvariablen gleichen Namens wie die Property (z. B. **property** xyz ergibt eine Methode "<ReadProp-xyz>").

[-kind]{.lit} [propertyKind]{.arg}
: Legt die Art der Property fest. *propertyKind* muss genau eines von **readable**, **writable** oder **readwrite** (Standard) sein; die Property ist dann nur lesbar, nur schreibbar bzw. les- und schreibbar. Nur-lesbare Properties können nur gelesen, nur-schreibbare nur geschrieben werden; les-schreibbare Properties können beides.

    Beachten Sie, dass nur-schreibbare Properties schwer auffindbar sind: Die **configure**-Methode meldet sie nicht, außer in Fehlermeldungen beim Schreiben auf eine nicht existierende Property.

[-set]{.lit} [setterScript]{.arg}
: Definiert die Implementierung des Schreibens der Property; *setterScript* wird zum Rumpf einer Methode mit einem Argument *value* auf der Klasse, wenn die Property-Art das Schreiben erlaubt. Die Methode heißt **<WriteProp-***propertyName***>** und ist standardmäßig ein einfaches Schreiben der Instanzvariablen gleichen Namens wie die Property (z. B. **property** xyz ergibt eine Methode "<WriteProp-xyz>").


Instanzen einer von **oo::configurable** erzeugten Klasse unterstützen ebenfalls **property**-Definitionen; die Semantik ist wie oben, die Properties werden jedoch nur auf der Instanz definiert.

Die von **property** definierten Implementierungsmethoden sollten nicht privat sein, da sie sonst für die **configure**-Implementierung unzugänglich sind (absichtlich; der Property-Konfigurationsmechanismus ist vor allem für die Nutzung außerhalb einer Klasse gedacht, während eine Klasse Variablen direkt zugreifen kann). Die von den Standardimplementierungen der Properties genutzten Variablen *dürfen* privat sein, wenn so deklariert.

# Erweiterte Verwendung

Das System konfigurierbarer Klassen besteht aus mehreren Teilen. Die Metaklasse **oo::configurable** mischt eine Klasse ein und setzt bei der Objekterzeugung Definitions-Namespaces, die die übrige Mechanik bereitstellen. Die zentralen Implementierungsteile sind hier aufgeführt, damit anderer Code sie nutzen kann:

[oo::configuresupport::configurable]{.cmd}
: Klasse, die die **configure**-Methode bereitstellt (beschrieben unter [Configure-Methode]).

**oo::configuresupport::configurableclass**
: Namespace mit dem Definitionsdialekt, der die **property**-Deklaration für Klassen bereitstellt (über [oo::define][define] und Klassenkonstruktoren), wie unter [Property-Definitionen] beschrieben. Er [namespace export][namespace]iert den Befehl **property** für einfache Nutzung in benutzerdefinierten Definitionsdialekten.

**oo::configuresupport::configurableobject**
: Namespace mit dem Definitionsdialekt, der die **property**-Deklaration für Instanzobjekte bereitstellt (über [oo::objdefine][define] und die [self]-Deklaration in [oo::define][define]), wie unter [Property-Definitionen] beschrieben. Er [namespace export][namespace]iert den Befehl **property** für einfache Nutzung in benutzerdefinierten Definitionsdialekten.


Der zugrunde liegende Property-Erkennungsmechanismus nutzt vier Slots (siehe [oo::define][define] für die Bedeutung), die konfigurierbare Properties auflisten. Diese Slots legen selbst keine Semantik fest außer eindeutigen Namen, fehlender wichtiger Reihenfolge, Vererbbarkeit und Auffindbarkeit auf Klassen und Instanzen.

Diese Slots und ihre beabsichtigte Semantik:

[oo::configuresupport::readableproperties]{.cmd}
: Menge der Properties einer Klasse (ohne die der Oberklassen), die beim Konfigurieren einer Instanz der Klasse gelesen werden dürfen. Dieser Slot kann auch mit **info class properties** gelesen werden.

[oo::configuresupport::writableproperties]{.cmd}
: Menge der Properties einer Klasse (ohne die der Oberklassen), die beim Konfigurieren einer Instanz der Klasse geschrieben werden dürfen. Dieser Slot kann auch mit **info class properties** gelesen werden.

[oo::configuresupport::objreadableproperties]{.cmd}
: Menge der Properties einer Objektinstanz (ohne die ihrer Klassen), die beim Konfigurieren des Objekts gelesen werden dürfen. Dieser Slot kann auch mit **info object properties** gelesen werden.

[oo::configuresupport::objwritableproperties]{.cmd}
: Menge der Properties einer Objektinstanz (ohne die ihrer Klassen), die beim Konfigurieren des Objekts geschrieben werden dürfen. Dieser Slot kann auch mit **info object properties** gelesen werden.


Obwohl es sich um Slots handelt, liegen sie *nicht* in den Standard-Namespaces [oo::define][define] oder [oo::objdefine][define]; in Definitionsskripten müssen sie voll qualifiziert referenziert werden. Sie sind Bausteine des konfigurierbaren Property-Systems und nicht für direkte Nutzung durch normalen Anwendercode gedacht.

## Implementierungshinweis

Die **configure**-Methode nutzt **info object properties** mit der Option **-all**, um zu ermitteln, welche Properties sie bearbeiten darf.

# Beispiele

Hier wird eine einfache konfigurierbare Klasse erzeugt und ihre Konfiguration gezeigt:

```
oo::configurable create Point {
    property x y
    constructor args {
        my configure -x 0 -y 0 {*}$args
    }
    variable x y
    method print {} {
        puts "x=$x, y=$y"
    }
}

set pt [Point new -x 27]
$pt print;   # x=27, y=0
$pt configure -y 42
$pt print;   # x=27, y=42
puts "distance from origin: [expr {
    hypot([$pt configure -x], [$pt configure -y])
}]";         # distance from origin: 49.92995093127971
puts [$pt configure]
             # -x 27 -y 42
```

Eine solche konfigurierbare Klasse kann durch Subklassierung erweitert werden; die Unterklasse muss ebenfalls mit **oo::configurable** erzeugt werden, wenn sie die **property**-Definition nutzt:

```
oo::configurable create Point3D {
    superclass Point
    property z
    constructor args {
        next -z 0 {*}$args
    }
}

set pt2 [Point3D new -x 2 -y 3 -z 4]
puts [$pt2 configure]
             # -x 2 -y 3 -z 4
```

Hat man eine konfigurierbare Klasse, können auch Instanz-Properties hinzugefügt werden. (Die hinterlegten Variablen aller Properties starten unset.) Unten wird ein eindeutiges Präfix eines Property-Namens beim Setzen verwendet; das ist für alle Properties möglich, vollständige Namen werden jedoch empfohlen, weil Unterklassen ein eindeutiges Präfix nicht mehr eindeutig machen.

```
oo::objdefine $pt {
    property color
}
$pt configure -c bisque
puts [$pt configure]
             # -color bisque -x 27 -y 42
```

Abgeleitete Properties sind möglich, indem sie nur lesbar gemacht und mit einem berechnenden Skript versehen werden.

```
oo::configurable create PointMk2 {
    property x y
    property distance -kind readable -get {
        return [expr {hypot($x, $y)}]
    }
    variable x y
    constructor args {
        my configure -x 0 -y 0 {*}$args
    }
}

set pt3 [PointMk2 new -x 3 -y 4]
puts [$pt3 configure -distance]
             # 5.0
$pt3 configure -distance 10
             # ERROR: bad property "-distance": must be -x or -y
```

Setter dienen zur Validierung des Typs einer Property:

```
oo::configurable create PointMk3 {
    property x -set {
        if {![string is double -strict $value]} {
            error "-x property must be a number"
        }
        set x $value
    }
    property y -set {
        if {![string is double -strict $value]} {
            error "-y property must be a number"
        }
        set y $value
    }
    variable x y
    constructor args {
        my configure -x 0 -y 0 {*}$args
    }
}

set pt4 [PointMk3 new]
puts [$pt4 configure]
             # -x 0 -y 0
$pt4 configure -x 3 -y 4
puts [$pt4 configure]
             # -x 3 -y 4
$pt4 configure -x "obviously not a number"
             # ERROR: -x property must be a number
```


[chan]: chan.md
[define]: define.md
[fconfigure]: fconfigure.md
[namespace]: namespace.md
[self]: self.md
