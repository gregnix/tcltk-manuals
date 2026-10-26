---
CommandName: object
ManualSection: n
Version: 0.1
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - my(n)
 - oo::class(n)
Keywords:
 - base class
 - class
 - object
 - root class
Copyright:
 - Copyright (c) 2007-2008 Donal K. Fellows
---

# NAME

oo::object - Wurzelklasse der Klassenhierarchie

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcl::oo]{.lit} 

[oo::object]{.cmd} [method]{.arg} [arg]{.optdot} 
:::

# KLASSENHIERARCHIE

```
oo::object
```

# BESCHREIBUNG

Die Klasse **oo::object** ist die Wurzelklasse der Objekthierarchie; jedes Objekt ist eine Instanz dieser Klasse. Da Klassen selbst Objekte sind, sind sie ebenfalls Instanzen dieser Klasse. Objekte werden stets über ihren Namen angesprochen und können mit **rename** umbenannt werden, ohne ihre Identität zu verlieren.

Instanzen von Objekten können mit den Methoden **create** oder **new** des Objekts **oo::object** selbst oder durch Aufruf dieser Methoden auf Unterklassenobjekten erzeugt werden; siehe **oo::class** für Details. Die Konfiguration einzelner Objekte (z. B. instanzspezifische Methoden, gemischte Klassen usw.) kann mit **oo::objdefine** gesteuert werden.

Jedes Objekt hat einen eindeutigen Namespace, den Instanz-Namespace. Dieser Namespace enthält alle Instanzvariablen des Objekts und ist der aktuelle Namespace, wenn eine Methode des Objekts (einschließlich einer Methode der Klasse des Objekts) aufgerufen wird. Wird das Objekt zerstört, wird sein Instanz-Namespace gelöscht. Der Instanz-Namespace enthält den **my**-Befehl des Objekts, mit dem nicht exportierte Methoden aufgerufen oder eine Referenz auf das Objekt für Aufrufe erzeugt werden kann, die Umbenennungen überdauert.

## Konstruktor

Die Klasse **oo::object** definiert keinen expliziten Konstruktor.

## Destruktor

Die Klasse **oo::object** definiert keinen expliziten Destruktor.

## Exportierte Methoden

Die Klasse **oo::object** unterstützt folgende exportierte Methoden:

*obj* **destroy**
: Diese Methode zerstört das Objekt *obj*, auf dem sie aufgerufen wird, und ruft dabei Destruktoren der Klasse des Objekts auf. Sie entspricht **rename**, um den Objektbefehl zu löschen. Das Ergebnis dieser Methode ist stets die leere Zeichenkette.


## Nicht exportierte Methoden

Die Klasse **oo::object** unterstützt folgende nicht exportierte Methoden:

*obj* **eval** ?*arg ...*?
: Diese Methode verkettet die Argumente *arg* wie mit **concat** und wertet das resultierende Skript im Namespace aus, der eindeutig mit *obj* verknüpft ist; der Rückgabewert der Auswertung wird zurückgegeben.
    Beachten Sie, dass objektinterne Befehle wie **my** und **self** in diesem Kontext aufgerufen werden können.

*obj* **unknown ?**_methodName_? ?*arg ...*?
: Diese Methode wird aufgerufen, wenn der Versuch, die Methode *methodName* auf dem Objekt *obj* aufzurufen, fehlschlägt. Die vom Benutzer übergebenen Argumente stehen als *arg* zur Verfügung. Fehlt *methodName*, wurde das Objekt ohne Methodennamen (oder andere Argumente) aufgerufen. Die Standardimplementierung (in **oo::object**) erzeugt einen passenden Fehler mit Angabe der unterstützten Methoden, je nachdem ob das Objekt über seinen öffentlichen Namen oder über **my** aufgerufen wurde.

*obj* **variable** ?*varName ...*?
: Diese Methode verknüpft jede Variable *varName* aus dem eindeutigen Namespace des Objekts *obj* in den Kontext des Aufrufers. Wird sie innerhalb einer Prozedur aufgerufen, wird die Namespace-Variable mit der lokalen Variable der Prozedur verknüpft. Jedes *varName* darf keine Namespace-Trenner enthalten. Das Ergebnis ist die leere Zeichenkette.

*obj* **varname** *varName*
: Diese Methode gibt den global qualifizierten Namen der Variable *varName* im eindeutigen Namespace des Objekts *obj* zurück.

*obj* **<cloned>** *sourceObjectName*
: Diese Methode wird vom Befehl **oo::object** verwendet, um den Zustand eines Objekts auf ein anderes zu kopieren. Sie kopiert die Prozeduren und Variablen des Namespace von *sourceObjectName* in das aktuelle Objekt. Andere Befehlstypen oder Spuren auf Variablen werden nicht kopiert; das kann durch Überschreiben dieser Methode in einer Unterklasse ergänzt werden.


# BEISPIELE

Dieses Beispiel zeigt die grundlegende Verwendung eines Objekts.

```
set obj [oo::object new]
$obj foo             → Fehler "unknown method foo"
oo::objdefine $obj method foo {} {
    my variable count
    puts "bar[incr count]"
}
$obj foo             → gibt "bar1" aus
$obj foo             → gibt "bar2" aus
$obj variable count  → Fehler "unknown method variable"
$obj destroy
$obj foo             → Fehler "unknown command obj"
```
