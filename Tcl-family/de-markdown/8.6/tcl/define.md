---
CommandName: define
ManualSection: n
Version: 0.3
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - next(n)
 - oo::class(n)
 - oo::object(n)
Keywords:
 - class
 - definition
 - method
 - object
 - slot
Copyright:
 - Copyright (c) 2007 Donal K. Fellows
---

# NAME

oo::define, oo::objdefine, oo::Slot - Klassen und Objekte definieren und konfigurieren

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 

[oo::define]{.cmd} [class]{.arg} [defScript]{.arg} 
[oo::define]{.cmd} [class]{.arg} [subcommand]{.arg} [arg]{.arg} [arg]{.optdot} 
[oo::objdefine]{.cmd} [object]{.arg} [defScript]{.arg} 
[oo::objdefine]{.cmd} [object]{.arg} [subcommand]{.arg} [arg]{.arg} [arg]{.optdot} 

[oo::Slot]{.cmd} [arg...]{.arg} 
:::

# KLASSENHIERARCHIE

```
oo::object
   → oo::Slot
```

# BESCHREIBUNG

Der Befehl **oo::define** steuert die Konfiguration von Klassen, und der Befehl **oo::objdefine** steuert die Konfiguration von Objekten (einschließlich Klassen als Instanzobjekte). Die Konfiguration wird auf die Entität angewendet, die im Argument *class* bzw. *object* benannt ist. Die Konfiguration einer Klasse aktualisiert auch die Konfiguration aller Unterklassen der Klasse und aller Objekte, die Instanzen dieser Klasse sind oder sie eingemischt haben (modifiziert durch jede instanzspezifische Konfiguration). Die Art der Konfiguration wird entweder durch das Argument *defScript* oder durch *subcommand* und die folgenden *arg*-Argumente gesteuert; ist Letzteres vorhanden, entspricht es genau dem Fall, dass alle Argumente ab *subcommand* zu einer Liste zusammengefasst und diese Liste als *defScript*-Argument verwendet wird.

## Konfigurieren von Klassen

Die folgenden Befehle werden im *defScript* für **oo::define** unterstützt; jeder kann auch in der *subcommand*-Form verwendet werden:

**constructor** *argList bodyScript*
: Erzeugt oder aktualisiert den Konstruktor einer Klasse. Die formalen Argumente des Konstruktors (definiert im gleichen Format wie beim Tcl-Befehl **proc**) sind *argList*, und der Rumpf des Konstruktors ist *bodyScript*. Wird der Rumpf des Konstruktors ausgewertet, ist der aktuelle Namespace des Konstruktors ein Namespace, der für das zu konstruierende Objekt eindeutig ist. Innerhalb des Konstruktors sollte der Befehl **next** verwendet werden, um die Konstruktoren der Superklassen aufzurufen. Ist *bodyScript* die leere Zeichenkette, wird der Konstruktor gelöscht.

**deletemethod** *name* ?*name ...*?
: Löscht jede der Methoden namens *name* aus einer Klasse. Die Methoden müssen zuvor in dieser Klasse existiert haben. Beeinflusst nicht die Superklassen der Klasse, noch Unterklassen oder Instanzen der Klasse (außer wenn sie eine Aufrufkette durch die geänderte Klasse haben) oder das Klassenobjekt selbst.

**destructor** *bodyScript*
: Erzeugt oder aktualisiert den Destruktor einer Klasse. Destruktoren nehmen keine Argumente entgegen, und der Rumpf des Destruktors ist *bodyScript*. Der Destruktor wird aufgerufen, wenn Objekte der Klasse gelöscht werden; beim Aufruf ist der eindeutige Namespace des Objekts der aktuelle Namespace. Destruktoren sollten den Befehl **next** verwenden, um die Destruktoren der Superklassen aufzurufen. Beachten Sie, dass Destruktoren nicht in allen Situationen aufgerufen werden (z. B. wenn der Interpreter zerstört wird). Ist *bodyScript* die leere Zeichenkette, wird der Destruktor gelöscht. Beachten Sie, dass Fehler während der Auswertung eines Destruktors *nicht* an den Code zurückgegeben werden, der die Zerstörung eines Objekts verursacht. Stattdessen werden sie an den aktuell definierten **bgerror**-Handler weitergegeben.

**export** *name* ?*name ...*?
: Legt fest, dass jede der benannten Methoden *name* von der definierten Klasse exportiert wird (d. h. außerhalb einer Instanz über den Befehl des Instanzobjekts nutzbar). Beachten Sie, dass die Methoden selbst tatsächlich von einer Superklasse definiert sein können; Exporte von Unterklassen überschreiben die Sichtbarkeit der Superklasse und können wiederum von Instanzen überschrieben werden.

**filter** ?*-slotOperation*? ?*methodName ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) setzt oder aktualisiert die Liste von Methodennamen, die steuern, ob Methodenaufrufe an Instanzen der Klasse durchgeführt werden dürfen und welche Ergebnisse die Methoden liefern. Jedes *methodName* benennt eine einzelne Filtermethode (exportiert oder nicht exportiert); es ist kein Fehler, eine nicht existierende Methode zu benennen, da sie von Unterklassen definiert sein kann. Standardmäßig arbeitet dieser Slot durch Anhängen.

**forward** *name cmdName* ?*arg ...*?
: Erzeugt oder aktualisiert eine weitergeleitete Methode namens *name*. Die Methode wird an den Befehl *cmdName* weitergeleitet; zusätzliche Argumente *arg* usw. werden vor den vom Aufrufer der Methode angegebenen Argumenten eingefügt. *cmdName* wird stets nach den Regeln der Namespaces der aufrufenden Objekte aufgelöst, d. h. wenn *cmdName* nicht voll qualifiziert ist, wird der Befehl im Namespace jedes Objekts gesucht — über den Namespace-Pfad der Instanz oder im globalen Namespace. Die Methode wird exportiert, wenn *name* mit einem Kleinbuchstaben beginnt, andernfalls nicht exportiert.

**method** *name argList bodyScript*
: Erzeugt oder aktualisiert eine Methode, die als prozedurähnliches Skript implementiert ist. Der Name der Methode ist *name*, die formalen Argumente der Methode (definiert im gleichen Format wie beim Tcl-Befehl **proc**) sind *argList*, und der Rumpf der Methode ist *bodyScript*. Wird der Rumpf der Methode ausgewertet, ist der aktuelle Namespace der Methode ein Namespace, der für das aktuelle Objekt eindeutig ist. Die Methode wird exportiert, wenn *name* mit einem Kleinbuchstaben beginnt, andernfalls nicht exportiert; dieses Verhalten kann über **export** und **unexport** überschrieben werden.

**mixin** ?*-slotOperation*? ?*className ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) setzt oder aktualisiert die Liste zusätzlicher Klassen, die in alle Instanzen der definierten Klasse eingemischt werden sollen. Jedes Argument *className* benennt eine einzelne einzumischende Klasse. Standardmäßig arbeitet dieser Slot durch Ersetzung.

**renamemethod** *fromName toName*
: Benennt die in einer Klasse *fromName* genannte Methode in *toName* um. Die Methode muss zuvor in der Klasse existiert haben, und *toName* darf zuvor nicht auf eine Methode in dieser Klasse verweisen. Beeinflusst nicht die Superklassen der Klasse, noch Unterklassen oder Instanzen der Klasse (außer wenn sie eine Aufrufkette durch die geänderte Klasse haben) oder das Klassenobjekt selbst. Ändert nicht den Exportstatus der Methode; war sie zuvor exportiert, ist sie es danach auch.

**self** *subcommand arg ...*
: ...siehe nächstes...

**self** *script*
: Dieser Befehl entspricht dem Aufruf von **oo::objdefine** auf der gerade definierten Klasse (siehe **KONFIGURIEREN VON OBJEKTEN** unten für eine Beschreibung der unterstützten Werte von *subcommand*). Er folgt dem gleichen allgemeinen Muster der Argumentverarbeitung wie die Befehle **oo::define** und **oo::objdefine**, und „**oo::define** *cls* **self** *subcommand ...*“ wirkt identisch zu „**oo::objdefine** *cls subcommand ...*“.

**superclass** ?*-slotOperation*? ?*className ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) ermöglicht die Änderung der Superklassen der definierten Klasse. Jedes Argument *className* benennt eine Klasse, die Superklasse der definierten Klasse sein soll. Beachten Sie, dass Objekte nicht von Klassen zu Nicht-Klassen oder umgekehrt geändert werden dürfen, dass eine leere Elternklasse **oo::object** entspricht und dass die Elternklassen von **oo::object** und **oo::class** nicht geändert werden dürfen. Standardmäßig arbeitet dieser Slot durch Ersetzung.

**unexport** *name* ?*name ...*?
: Legt fest, dass jede der benannten Methoden *name* von der definierten Klasse nicht exportiert wird (d. h. nicht außerhalb der Instanz über den Befehl des Instanzobjekts nutzbar, sondern nur über den in jedem Objektkontext sichtbaren Befehl **my**). Beachten Sie, dass die Methoden selbst tatsächlich von einer Superklasse definiert sein können; Unexporte von Unterklassen überschreiben die Sichtbarkeit der Superklasse und können von Instanz-Unexporten überschrieben werden.

**variable** ?*-slotOperation*? ?*name ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) sorgt dafür, dass jede der benannten Variablen in den von der definierten Klasse deklarierten Methoden, im Konstruktor und im Destruktor automatisch verfügbar gemacht wird. Jeder Variablenname darf keine Namespace-Trenner enthalten und darf nicht wie ein Array-Zugriff aussehen. Alle Variablen sind tatsächlich im Instanzobjekt vorhanden, auf dem die Methode ausgeführt wird. Beachten Sie, dass die von einer Super- oder Unterklasse deklarierten Variablenlisten vollständig disjunkt sind, ebenso wie von Instanzen deklarierte Variablenlisten; die Liste der Variablennamen gilt nur für von dieser Klasse deklarierte Methoden (sowie Konstruktoren und Destruktoren). Standardmäßig arbeitet dieser Slot durch Anhängen.


## Konfigurieren von Objekten

Die folgenden Befehle werden im *defScript* für **oo::objdefine** unterstützt; jeder kann auch in der *subcommand*-Form verwendet werden:

**class** *className*
: Ermöglicht die Änderung der Klasse eines Objekts nach der Erstellung. Beachten Sie, dass die Konstruktoren der Klasse dabei nicht aufgerufen werden; das Objekt kann daher in einem inkonsistenten Zustand sein, sofern keine zusätzliche Konfigurationsarbeit erfolgt.

**deletemethod** *name* ?*name ...*
: Löscht jede der Methoden namens *name* aus einem Objekt. Die Methoden müssen zuvor in diesem Objekt existiert haben (z. B. weil sie durch **oo::objdefine method** erzeugt wurden). Beeinflusst nicht die Klassen, deren Instanz das Objekt ist, und entfernt nicht die Sichtbarkeit der von diesen Klassen bereitgestellten Methoden in der Instanz dieser Klasse.

**export** *name* ?*name ...*?
: Legt fest, dass jede der benannten Methoden *name* von dem definierten Objekt exportiert wird (d. h. außerhalb des Objekts über den Befehl des Objekts nutzbar). Beachten Sie, dass die Methoden selbst tatsächlich von einer Klasse oder Superklasse definiert sein können; Objekt-Exporte überschreiben die Klassensichtbarkeit.

**filter** ?*-slotOperation*? ?*methodName ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) setzt oder aktualisiert die Liste von Methodennamen, die steuern, ob ein Methodenaufruf an das Objekt durchgeführt werden darf und welche Ergebnisse die Methode liefert. Jedes *methodName* benennt eine einzelne Filtermethode (exportiert oder nicht exportiert); es ist kein Fehler, eine nicht existierende Methode zu benennen. Beachten Sie, dass die tatsächliche Filterliste auch von den Filtern abhängt, die für Klassen gesetzt sind, deren Instanz das Objekt ist. Standardmäßig arbeitet dieser Slot durch Anhängen.

**forward** *name cmdName* ?*arg ...*?
: Erzeugt oder aktualisiert eine weitergeleitete Objekt-Methode namens *name*. Die Methode wird an den Befehl *cmdName* weitergeleitet; zusätzliche Argumente *arg* usw. werden vor den vom Aufrufer der Methode angegebenen Argumenten eingefügt. Weitergeleitete Methoden sollten mit dem Unterbefehl **method** gelöscht werden. Die Methode wird exportiert, wenn *name* mit einem Kleinbuchstaben beginnt, andernfalls nicht exportiert.

**method** *name argList bodyScript*
: Erzeugt, aktualisiert oder löscht eine Objekt-Methode. Der Name der Methode ist *name*, die formalen Argumente der Methode (definiert im gleichen Format wie beim Tcl-Befehl **proc**) sind *argList*, und der Rumpf der Methode ist *bodyScript*. Wird der Rumpf der Methode ausgewertet, ist der aktuelle Namespace der Methode ein Namespace, der für das Objekt eindeutig ist. Die Methode wird exportiert, wenn *name* mit einem Kleinbuchstaben beginnt, andernfalls nicht exportiert.

**mixin** ?*-slotOperation*? ?*className ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) setzt oder aktualisiert eine pro Objekt geltende Liste zusätzlicher Klassen, die in das Objekt eingemischt werden sollen. Jedes Argument *className* benennt eine einzelne einzumischende Klasse. Standardmäßig arbeitet dieser Slot durch Ersetzung.

**renamemethod** *fromName toName*
: Benennt die in einem Objekt *fromName* genannte Methode in *toName* um. Die Methode muss zuvor im Objekt existiert haben, und *toName* darf zuvor nicht auf eine Methode in diesem Objekt verweisen. Beeinflusst nicht die Klassen, deren Instanz das Objekt ist, und kann in einem Instanzobjekt nicht die von diesen Klassen bereitgestellten Methoden umbenennen (eine per **oo::objdefine forward** weitergeleitete Methode kann jedoch eine gleichwertige Fähigkeit bieten). Ändert nicht den Exportstatus der Methode; war sie zuvor exportiert, ist sie es danach auch.

**unexport** *name* ?*name ...*?
: Legt fest, dass jede der benannten Methoden *name* von dem definierten Objekt nicht exportiert wird (d. h. nicht außerhalb des Objekts über den Befehl des Objekts nutzbar, sondern nur über den im Objektkontext sichtbaren Befehl **my**). Beachten Sie, dass die Methoden selbst tatsächlich von einer Klasse definiert sein können; Instanz-Unexporte überschreiben die Klassensichtbarkeit.

**variable** ?*-slotOperation*? ?*name ...*?
: Dieser Slot (siehe **SLOT-DEFINITIONEN** unten) sorgt dafür, dass jede der benannten Variablen in den von dem definierten Objekt deklarierten Methoden automatisch verfügbar gemacht wird. Jeder Variablenname darf keine Namespace-Trenner enthalten und darf nicht wie ein Array-Zugriff aussehen. Alle Variablen sind tatsächlich im Objekt vorhanden, auf dem die Methode ausgeführt wird. Beachten Sie, dass die von den Klassen und Mixins, deren Instanz das Objekt ist, deklarierten Variablenlisten vollständig disjunkt sind; die Liste der Variablennamen gilt nur für von diesem Objekt deklarierte Methoden. Standardmäßig arbeitet dieser Slot durch Anhängen.


# Slot-Definitionen

::: {.info -version=""}
Einige der konfigurierbaren Definitionen einer Klasse oder eines Objekts sind *Slot-Definitionen*. Das bedeutet, die Konfiguration wird durch ein Slot-Objekt implementiert — eine Instanz der Klasse **oo::Slot** —, das eine Liste von Werten (Klassennamen, Variablennamen usw.) verwaltet, die den Inhalt des Slots bilden.

Die Klasse **oo::Slot** definiert drei Operationen (als Methoden), die am Slot ausgeführt werden können:
:::

*slot* **-append** ?*member ...*?
: Hängt die angegebenen *member*-Elemente an die Slot-Definition an.

*slot* **-clear**
: Setzt die Slot-Definition auf die leere Liste.

*slot* **-set** ?*member ...*?
: Ersetzt die Slot-Definition durch die angegebenen *member*-Elemente.


Eine Folge davon ist, dass jede Verwendung der Standardoperation eines Slots, bei der das erste *member*-Argument mit einem Bindestrich beginnt, ein Fehler ist. In diesen Fällen sollte eine der obigen Operationen explizit verwendet werden.

Eine Instanz von **oo::Slot** muss nur erzeugt werden, wenn ein eigener Slot definiert wird, der sich wie ein Standard-Slot verhält.

## Slot-Implementierung

::: {.info -version=""}
Intern definieren Slot-Objekte auch eine Methode **--default-operation**, die an die Standardoperation des Slots weitergeleitet wird (für den Klassen-„**variable**“-Slot also an „**my -append**“), sowie diese Methoden, die die Implementierungsschnittstelle bereitstellen:
:::

*slot* **Get**
: Gibt eine Liste zurück, die den aktuellen Inhalt des Slots ist. Diese Methode muss stets aus einem Stack-Frame aufgerufen werden, der durch einen Aufruf von **oo::define** oder **oo::objdefine** erzeugt wurde.

*slot* **Resolve** *element*
: Wandelt ein Element der Slot-Sammlung in seine aufgelöste Form um; für einen einfachen Wert könnte sie den Wert einfach zurückgeben, bei einem Slot mit Verweisen auf Befehle oder Klassen sollten diese in voll qualifizierte Formen umgewandelt werden (damit sie mit **string equals** verglichen werden können): das könnte durch Weiterleitung an **namespace which** oder Ähnliches geschehen.

*slot* **Set** *elementList*
: Setzt den Inhalt des Slots auf die Liste *elementList* und gibt die leere Zeichenkette zurück. Diese Methode muss stets aus einem Stack-Frame aufgerufen werden, der durch einen Aufruf von **oo::define** oder **oo::objdefine** erzeugt wurde.


Die Implementierung dieser Methoden hängt vom Slot ab (und ist dafür verantwortlich, auf den richtigen Teil der Klassen- oder Objektdefinition zuzugreifen). Slots haben auch einen Unknown-Methoden-Handler, der all diese Teile zusammenführt, und verbergen ihre Methode **destroy**, damit sie nicht versehentlich aufgerufen wird. Es wird *empfohlen*, Benutzeränderungen am Slot-Mechanismus selbst auf die Definition neuer Operationen zu beschränken, deren Namen mit einem Bindestrich beginnen.

Beachten Sie, dass Slot-Instanzen nicht erwartungsgemäß den Speicher für den von ihnen verwalteten Slot enthalten; der befindet sich in oder ist an die verwaltete Klasse bzw. das verwaltete Objekt angehängt. Diese Instanzen sollten eigene Implementierungen der Methoden **Get** und **Set** bereitstellen (optional **Resolve**; standardmäßig eine durchreichende No-Op-Implementierung).

# BEISPIELE

Dieses Beispiel zeigt die Verwendung beider Formen der Befehle **oo::define** und **oo::objdefine** (sie funktionieren gleich) und veranschaulicht vier ihrer Unterbefehle.

```
oo::class create c
c create o
oo::define c method foo {} {
    puts "world"
}
oo::objdefine o {
    method bar {} {
        my Foo "hello "
        my foo
    }
    forward Foo ::puts -nonewline
    unexport foo
}
o bar                → prints "hello world"
o foo                → error "unknown method foo"
o Foo Bar            → error "unknown method Foo"
oo::objdefine o renamemethod bar lollipop
o lollipop           → prints "hello world"
```

Dieses Beispiel zeigt, wie zusätzliche Klassen in ein Objekt eingemischt werden können. Es zeigt auch, dass **mixin** ein Slot ist, der Anhängen unterstützt:

```
oo::object create inst
inst m1              → error "unknown method m1"
inst m2              → error "unknown method m2"

oo::class create A {
    method m1 {} {
        puts "red brick"
    }
}
oo::objdefine inst {
    mixin A
}
inst m1              → prints "red brick"
inst m2              → error "unknown method m2"

oo::class create B {
    method m2 {} {
        puts "blue brick"
    }
}
oo::objdefine inst {
    mixin -append B
}
inst m1              → prints "red brick"
inst m2              → prints "blue brick"
```
