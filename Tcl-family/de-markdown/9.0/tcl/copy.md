---
CommandName: copy
ManualSection: n
Version: 0.1
TclPart: TclOO
TclDescription: TclOO Commands
Links:
 - oo::class(n)
 - oo::define(n)
 - oo::object(n)
Keywords:
 - clone
 - copy
 - duplication
 - object
Copyright:
 - Copyright (c) 2007 Donal K. Fellows
---

# NAME

oo::copy - Erzeugt Kopien von Objekten und Klassen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tcl::oo]{.lit} 

[oo::copy]{.cmd} [sourceObject]{.arg} [targetObject]{.optarg} [targetNamespace]{.optarg} 
:::

# BESCHREIBUNG

Der Befehl **oo::copy** erzeugt eine Kopie eines Objekts oder einer Klasse. Er nimmt den Namen des zu kopierenden Objekts oder der Klasse *sourceObject* und optional den Namen des zu erzeugenden Objekts oder der Klasse *targetObject*, der relativ zum aktuellen Namespace aufgelöst wird, wenn er kein absolut qualifizierter Name ist, und *targetNamespace*, den Namen des Namespace, der den internen Zustand des Objekts (**my**-Befehl usw.) hält; er *darf nicht* auf einen existierenden Namespace verweisen. Ist *targetObject* oder *targetNamespace* weggelassen oder als leere Zeichenkette angegeben, wird ein neuer Name gewählt. Namen werden, sofern nicht angegeben, mit demselben Algorithmus wie die Methode **new** von **oo::class** gewählt. Das kopierte Objekt hat dieselbe Klasse wie das Quellobjekt und alle seine objektspezifischen Methoden werden kopiert. Ist es eine Klasse, werden auch alle Klassenmethoden der Klasse kopiert, aber keine ihrer Instanzen.

::: {.info -version=""}
Nachdem *targetObject* erzeugt und alle Konfigurationsdefinitionen (z. B. Methoden, Filter, Mixins) kopiert wurden, wird die Methode **<cloned>** von *targetObject* aufgerufen, um das erzeugte Objekt anzupassen, z. B. durch Installation zugehöriger Variablen-Spuren. Das einzige Argument ist *sourceObject*. Die Standardimplementierung dieser Methode (in **oo::object**) kopiert nur die Prozeduren und Variablen im Namespace von *sourceObject* in den Namespace von *targetObject*. Liefert dieser Methodenaufruf kein erfolgreiches Ergebnis (d. h. einen Fehler oder eine andere Ausnahme), wird *targetObject* gelöscht und ein Fehler zurückgegeben.
:::

Das Ergebnis von **oo::copy** ist der voll qualifizierte Name des neuen Objekts oder der Klasse.

# BEISPIELE

Dieses Beispiel erzeugt ein Objekt, kopiert es, ändert das Quellobjekt und zeigt, dass das kopierte Objekt tatsächlich eine Kopie ist.

```
oo::object create src
oo::objdefine src method msg {} {puts foo}
oo::copy src dst
oo::objdefine src method msg {} {puts bar}
src msg              → gibt "bar" aus
dst msg              → gibt "foo" aus
```
