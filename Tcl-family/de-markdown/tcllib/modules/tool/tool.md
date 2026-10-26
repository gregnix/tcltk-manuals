---
CommandName: tool
title: tool
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: Standardized OO Framework for development
Keywords:
 - TOOL
 - TclOO
 - framework
Copyright:
 - Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
---

# Name

tool – TclOO-Bibliothek (TOOL)-Rahmen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [sha1]{.lit}
[package]{.cmd} [require]{.sub} [dicttool]{.lit}
[package]{.cmd} [require]{.sub} [oo::meta]{.lit}
[package]{.cmd} [require]{.sub} [oo::dialect]{.lit}
[object]{.ins} [cget]{.sub} [option]{.arg}
[object]{.ins} [configure]{.sub} [keyvaluelist]{.optarg}
[object]{.ins} [configure]{.sub} [field]{.arg} [value]{.arg} [field]{.optarg} [value]{.optarg} [...]{.optarg}
[object]{.ins} [configurelist]{.sub} [keyvaluelist]{.optarg}
[object]{.ins} [forward]{.sub} [stub]{.arg} [forward]{.arg}
[object]{.ins} [graft]{.sub} [stub]{.arg} [forward]{.arg}
[object]{.ins} [InitializePublic]{.sub}
[object]{.ins} [Eval\_Script]{.sub} [script]{.optarg}
[object]{.ins} [Option\_Default]{.sub} [field]{.arg}
:::

tool::define **class\_method** *arglist* *body*

tool::define **array** *name* *contents*

tool::define **array\_ensemble** *methodname* *varname* ?cases?

tool::define **dict\_ensemble** *methodname* *varname* ?cases?

tool::define **method** *methodname* *arglist* *body*

tool::define **option** *name* *dictopts*

tool::define **property** ?branch? *field* *value*

tool::define **variable** *name* *value*

# Beschreibung

Dieses Modul implementiert den Tcl Object Oriented Library-Rahmen, kurz *TOOL*. Es ist als universell einsetzbarer Rahmen konzipiert, der eigenständig genutzt werden kann und leicht erweiterbar ist.

TOOL definiert eine Metaklasse, die der Beschreibung TclOO mehrere zusätzliche Schlüsselwörter, Standardverhalten für die zugehörigen Objekte sowie eine Top-Down-Integration mit den vom Paket **oo::meta** bereitgestellten Funktionen bereitstellt.

Die Metaklasse „TOOL“ wurde mit dem Paket „**oo::dialect**“ erstellt und kann daher als Grundlage für weitere Metaklassen dienen. Als Metaklasse verfügt „TOOL“ über eine eigene „class“-Klasse, eine eigene „Objekt“-Klasse und definiert einen Namespace.

```
package require tool

# tool::class workds just like oo::class
tool::class create myclass {
}

# tool::define works just like oo::define
tool::define myclass method noop {} {}

# tool::define and tool::class understand additional keywords
tool::define myclass array_ensemble mysettings mysettings {}

# And tool interoperates with oo::define
oo::define myclass method do_something {} { return something }

# TOOL and TclOO objects are interchangeable
oo::class create myooclass {
  superclass myclass
}
```

In mehreren Handbuchseiten werden bestimmte Schlüsselwörter und Methoden ausführlicher behandelt.

- **tool::array\_ensemble**
- **tool::dict\_ensemble**
- **tool::method\_ensemble**
- **tool::object**
- **tool::option\_handling**


# Schlüsselwörter

TOOL fügt neue Schlüsselwörter für Klassendefinitionen hinzu (oder ändert bestehende). Die neuen Schlüsselwörter stehen jedoch nur in Aufrufen von *tool::class create* oder *tool::define* zur Verfügung.

tool::define **class\_method** *arglist* *body*
: Definiert eine Methode für das Klassenobjekt selbst. Anders als bei **self method** wird diese Methode an die Nachfahren der Klasse weitergegeben.

tool::define **array** *name* *contents*
: Deklariert eine Variable *name*, die für Objekte dieser Klasse sowie für alle Objekte von Nachfahren dieser Klasse als Array angelegt und mit *contents* gefüllt wird.

tool::define **array\_ensemble** *methodname* *varname* ?cases?
: Deklariert ein Methoden-Ensemble *methodname*, das den Zugriff auf die Variable *varname* steuert. *cases* ist eine Schlüssel-Wert-Liste aus Methodennamen und Rümpfen, die über die Standardvorlage gelegt werden. Siehe **tool::array\_ensemble**.

    Ein Methodenname ist reserviert: **initialize**. **initialize** deklariert die Anfangswerte, mit denen das Array gefüllt wird, als Schlüssel-Wert-Liste; daraus wird keine Methode des Ensembles.

tool::define **dict\_ensemble** *methodname* *varname* ?cases?
: Deklariert ein Methoden-Ensemble *methodname*, das den Zugriff auf die Variable *varname* steuert. *cases* ist eine Schlüssel-Wert-Liste aus Methodennamen und Rümpfen, die über die Standardvorlage gelegt werden. Siehe [tool::dict\_ensemble][tool_dict_ensemble].

    Ein Methodenname ist reserviert: **initialize**. **initialize** deklariert die Anfangswerte, mit denen das Array gefüllt wird, als Schlüssel-Wert-Liste; daraus wird keine Methode des Ensembles.

tool::define **method** *methodname* *arglist* *body*
: Enthält *methodname* die Zeichenfolge ::, gilt die Methode als Teil eines Methoden-Ensembles. Siehe **tool::method\_ensembles**. Andernfalls verhält sich dieser Befehl genau wie der Standardbefehl **oo::define** **method**.

tool::define **option** *name* *dictopts*
: Deklariert eine Option. *dictopts* ist eine Schlüssel-Wert-Liste mit den Parametern der Option. Siehe **tool::option\_handling**.

    ```
    tool::class create myclass {
      option color {
        post-command: {puts [list %self%'s %field% is now %value%]}
        default: green
      }
    }
    myclass create foo
    foo configure color purple
    > foo's color is now purple
    ```

tool::define **property** ?branch? *field* *value*
: Definiert ein neues Blatt im Metadatenbaum der Klasse. Ohne *branch* erscheint das Blatt im Abschnitt *const* und ist entweder über die Methode **property** des Objekts oder über **oo::meta::info** *class* **get const** *field* erreichbar:

tool::define **variable** *name* *value*
: Deklariert eine Variable *name*, die für Objekte dieser Klasse sowie für alle Objekte von Nachfahren dieser Klasse mit dem Wert *value* initialisiert wird.


# Öffentliche Objektmethoden

Das TOOL-Objekt, die „Mutter aller Klassen“, definiert mehrere Methoden, um ein einheitliches Verhalten im gesamten Rahmen sicherzustellen.

*object* **cget** *option*
: Gibt den Wert der Option *option* dieses Objekts zurück. Wenn für diese Klasse der Wert **property options\_strict** auf „true“ gesetzt ist, führt der Aufruf einer Option, die nicht mit dem Schlüsselwort **option** deklariert wurde, zu einem Fehler. In allen anderen Fällen gibt das Objekt den Wert zurück, wenn er im Array *options* des Objekts vorhanden ist. Wenn er nicht vorhanden ist, versucht das Objekt, eine Eigenschaft mit demselben Namen abzurufen.

*object* **configure** ?keyvaluelist?
: siehe unten ...

*object* **configure** *field* *value* ?field? ?value? ?...?
: Dieser Befehl fügt dem Array *options* der Objekte neue Werte hinzu, gemäß den in den Beschreibungen der Optionen festgelegten Regeln. Einzelheiten finden Sie unter **tool::option\_handling**. **configure** entfernt führende Minuszeichen („-“) aus Feldnamen, wodurch eine quasi-abwärtskompatible Funktionsweise zu tk-Optionen gewährleistet wird.

*object* **configurelist** ?keyvaluelist?
: Dieser Befehl fügt dem Array *options* der Objekte neue Werte hinzu, gemäß den in den Beschreibungen der Optionen festgelegten Regeln. Dieser Befehl führt Validierungs- und alternative Speicherregeln durch. Er löst keine Trigger-Regeln aus. Weitere Informationen finden Sie unter **tool::option\_handling**.

*object* **forward** *stub* *forward*
: Eine Weiterleitung zu **oo:objdefine \[self\] forward**

*object* **graft** *stub* *forward*
: Weiterleitet die Methode *<stub>* an das durch *forward* angegebene Objekt oder den angegebenen Befehl

    ```
    tool::object create A
    tool::object create B
    A graft buddy B
    A configure color red
    B configure color blue
    A cget color
    > red
    A <buddy> cget color
    > blue
    ```


# Private Objektmethoden

*object* **InitializePublic**
: Überprüft die Metadaten der Klasse, um sicherzustellen, dass jedes Array, jede Option und jede Variable, die deklariert, aber nicht initialisiert wurde, mit dem Standardwert initialisiert wird. Diese Methode wird vom Konstruktor und von der „morph“-Methode aufgerufen. Ein mehrfacher Aufruf ist unbedenklich.

*object* **Eval\_Script** ?script?
: Führt einen Textblock innerhalb des Namespaces des Objekts aus. Zeilen, die mit einem # beginnen, werden als Kommentare ignoriert. Befehle, die mit :: beginnen, werden als Aufruf eines globalen Befehls interpretiert. Alle anderen Tcl-Befehle, denen das Präfix „my“ fehlt, erhalten dieses Präfix, damit das Skript interne Methoden ausführen kann. Diese Methode ist für Skripte der Konfiguration vorgesehen, in denen die Objektmethoden eine domänenspezifische Sprache interpretieren.

    ```
    tool::class myclass {
      constructor script {
        my Eval_Script $script
      }
      method node {nodename info} {
        my variable node
        dict set node $nodename $info
      }
      method get {args} {
        my variable node
        return [dict get $node $args]
      }
    }
    myclass create movies {
      # This block of code is executed by the object
      node {The Day the Earth Stood Still} {
        date: 1952
        characters: {GORT Klatoo}
      }
    }
    movies get {The Day the Earth Stood Still} date:
    > 1952
    ```

*object* **Option\_Default** *field*
: Berechnet den Standardwert für eine Option. Siehe **tool::option\_handling**.


# Autoren

Sean Woods

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *tcloo* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

TclOO

# Copyright

```
Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
```


[tool_dict_ensemble]: tool_dict_ensemble.md
