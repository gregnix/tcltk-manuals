---
CommandName: tool
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: Standardized OO Framework for development
Keywords:
 - TOOL adds new (or modifies) keywords used in the definitions of classes. However
 - the new keywords are only available via calls to tool::class create or tool::define
 - tool::define class_method arglist body Defines a method for the class object itself. This method will be passed on to descendents of the class
 - unlike self method
 - tool::define array name contents Declares a variable name which will be initialized as an array
 - populated with contents for objects of this class
 - as well as any objects for classes which are descendents of this class
 - "tool::define array_ensemble methodname varname ?cases? Declares a method ensemble methodname which will control access to variable varname. Cases are a key/value list of method names and bodies which will be overlaid on top of the standard template. See tool::array_ensemble. One method name is reserved: initialize. initialize Declares the initial values to be populated in the array"
 - as a key/value list
 - and will not be expressed as a method for the ensemble
 - "tool::define dict_ensemble methodname varname ?cases? Declares a method ensemble methodname which will control access to variable varname. Cases are a key/value list of method names and bodies which will be overlaid on top of the standard template. See tool::dict_ensemble. One method name is reserved: initialize. initialize Declares the initial values to be populated in the array"
 - "tool::define method methodname arglist body If methodname contains ::"
 - the method is considered to be part of a method ensemble. See tool::method_ensembles. Otherwise this command behaves exactly like the standard oo::define method command
 - "tool::define option name dictopts Declares an option. dictopts is a key/value list defining parameters for the option. See tool::option_handling. tool::class create myclass { option color { post-command: {puts [list %self%'s %field% is now %value%]} default: green } } myclass create foo foo configure color purple > foo's color is now purple"
 - tool::define property ?branch? field value Defines a new leaf in the class metadata tree. With no branch
 - the leaf will appear in the const section
 - accessible by either the object's property method
 - "or via oo::meta::info class get const field:"
 - tool::define variable name value Declares a variable name which will be initialized with the value value for objects of this class
 - as well as any objects for classes which are descendents of this class. TOOL
 - TclOO
 - framework
Copyright:
 - Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
---

# NAME

tool – TclOO-Bibliothek (TOOL)-Rahmen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [sha1]{.lit} 
[package]{.cmd} [require]{.sub} [dicttool]{.lit} 
[package]{.cmd} [require]{.sub} [oo::meta]{.lit} 
[package]{.cmd} [require]{.sub} [oo::dialect]{.lit} 
[object]{.ins} [cget]{.sub} [option]{.arg} 
[object]{.ins} [configure]{.sub} [keyvaluelist]{.optarg} 
[object]{.ins} [configure]{.sub} [field]{.arg} [value]{.arg} [field]{.optarg} [value]{.optarg} [...]{.optdot} 
[object]{.ins} [configurelist]{.sub} [keyvaluelist]{.optarg} 
[object]{.ins} [forward]{.sub} [stub]{.arg} [forward]{.arg} 
[object]{.ins} [graft]{.sub} [stub]{.arg} [forward]{.arg} 
[object]{.ins} [InitializePublic]{.sub} 
[object]{.ins} [Eval_Script]{.sub} [script]{.optarg} 
[object]{.ins} [Option_Default]{.sub} [field]{.arg} 
:::

tool::define **class_method** *arglist* *body*

tool::define **array** *name* *contents*

tool::define **array_ensemble** *methodname* *varname* ?cases?

tool::define **dict_ensemble** *methodname* *varname* ?cases?

tool::define **method** *methodname* *arglist* *body*

tool::define **option** *name* *dictopts*

tool::define **property** ?branch? *field* *value*

tool::define **variable** *name* *value*

# BESCHREIBUNG

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

**tool::array_ensemble**
: ...siehe nächstes...

**tool::dict_ensemble**
: ...siehe nächstes...

**tool::method_ensemble**
: ...siehe nächstes...

**tool::object**
: ...siehe nächstes...

**tool::option_handling**
: 


# ÖFFENTLICHE OBJEKTMETHODEN

Das TOOL-Objekt, die „Mutter aller Klassen“, definiert mehrere Methoden, um ein einheitliches Verhalten im gesamten Rahmen sicherzustellen.

*object* **cget** *option*
: Gibt den Wert der Option *option* dieses Objekts zurück. Wenn für diese Klasse der Wert **property options_strict** auf „true“ gesetzt ist, führt der Aufruf einer Option, die nicht mit dem Schlüsselwort **option** deklariert wurde, zu einem Fehler. In allen anderen Fällen gibt das Objekt den Wert zurück, wenn er im Array *options* des Objekts vorhanden ist. Wenn er nicht vorhanden ist, versucht das Objekt, eine Eigenschaft mit demselben Namen abzurufen.

*object* **configure** ?keyvaluelist?
: ...siehe nächstes...

*object* **configure** *field* *value* ?field? ?value? ?...?
: Dieser Befehl fügt dem Array *options* der Objekte neue Werte hinzu, gemäß den in den Beschreibungen der Optionen festgelegten Regeln. Einzelheiten finden Sie unter **tool::option_handling**. **configure** entfernt führende Minuszeichen („-“) aus Feldnamen, wodurch eine quasi-abwärtskompatible Funktionsweise zu tk-Optionen gewährleistet wird.

*object* **configurelist** ?keyvaluelist?
: Dieser Befehl fügt dem Array *options* der Objekte neue Werte hinzu, gemäß den in den Beschreibungen der Optionen festgelegten Regeln. Dieser Befehl führt Validierungs- und alternative Speicherregeln durch. Er löst keine Trigger-Regeln aus. Weitere Informationen finden Sie unter **tool::option_handling**.

*object* **forward** *stub* *forward*
: Eine Weiterleitung zu **oo:objdefine \[self\] forward**

*object* **graft** *stub* *forward*
: Weiterleitet die Methode *\<stub>* an das durch *forward* angegebene Objekt oder den angegebenen Befehl


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

# PRIVATE OBJEKTMETHODEN

*object* **InitializePublic**
: Überprüft die Metadaten der Klasse, um sicherzustellen, dass jedes Array, jede Option und jede Variable, die deklariert, aber nicht initialisiert wurde, mit dem Standardwert initialisiert wird. Diese Methode wird vom Konstruktor und von der „morph“-Methode aufgerufen. Ein mehrfacher Aufruf ist unbedenklich.

*object* **Eval_Script** ?Skript?
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

*object* **Option_Default** *field*
: Berechnet den Standardwert für eine Option. Siehe **tool::option_handling**.


# AUTOREN

Sean Woods

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *tcloo* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

TclOO

# COPYRIGHT

```
Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
```
