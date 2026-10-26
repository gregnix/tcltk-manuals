---
CommandName: clay
ManualSection: n
Version: 0.8.8
TclPart: tcllib
TclDescription: Clay Framework
Keywords:
 - TclOO
 - oo
Copyright:
 - Copyright (c) 2018 Sean Woods <yoda@etoyoc.com>
---

# NAME

clay – Ein minimalistischer Rahmen für umfangreiche objektorientierte Projekte

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [uuid]{.lit} 
[package]{.cmd} [require]{.sub} [oo::dialect]{.lit} 
:::

proc **clay::PROC** *name* *arglist* *body* ?*ninja* ?

proc **clay::\_ancestors** *resultvar* *class*

proc **clay::ancestors** ?*args*?

proc **clay::args_to_dict** ?*args*?

proc **clay::args_to_options** ?*args*?

proc **clay::dynamic_arguments** *Ensemble* *method* *arglist* ?*args*?

proc **clay::dynamic_wrongargs_message** *arglist*

proc **clay::is_dict** *d*

proc **clay::is_null** *value*

proc **clay::leaf** ?*args*?

proc **clay::K** *a* *b*

proc **clay::noop** ?*args*?

proc **clay::cleanup**

proc **clay::object_create** *objname* ?*class* ?

proc **clay::object_rename** *object* *neuer Name*

proc **clay::object_destroy** ?*args*?

proc **clay::path** ?*args*?

proc **clay::putb** ?*map*? *text*

proc **clay::script_path**

proc **clay::NSNormalize** *qualname*

proc **clay::uuid_generate** ?*args*?

proc **clay::uuid::generate_tcl_machinfo**

proc **clay::uuid::tostring** *uuid*

proc **clay::uuid::fromstring** *uuid*

proc **clay::uuid::equal** *links* *rechts*

proc **clay::uuid** *cmd* ?*args*?

proc **clay::tree::sanitize** *dict*

proc **clay::tree::\_sanitizeb** *path* *Variablenname* *Dict*

proc **clay::tree::storage** *rawpath*

proc **clay::tree::dictset** *varname* ?*args*?

proc **clay::tree::dictmerge** *varname* ?*args*?

proc **clay::tree::merge** ?*args*?

proc **dictargs::proc** *name* *argspec* *body*

proc **dictargs::method** *name* *argspec* *body*

proc **clay::dialect::Push** *class*

proc **clay::dialect::Peek**

proc **clay::dialect::Pop**

proc **clay::dialect::create** *name* ?*parent* ?

proc **clay::dialect::NSNormalize** *Namespace* *qualname*

proc **clay::dialect::DefineThunk** *target* ?*args*?

proc **clay::dialect::Canonical** *namespace* *NSpace* *class*

proc **clay::dialect::Define** *Namespace* *class* ?*Argumente*?

proc **clay::dialect::Aliases** *Namespace* ?*args*?

proc **clay::dialect::SuperClass** *Namespace* ?*args*?

proc **clay::dynamic_methods** *class*

proc **clay::dynamic_methods_class** *thisclass*

proc **clay::define::Array** *name* ?*Werte* ?

proc **clay::define::Delegate** *name* *info*

proc **clay::define::constructor** *arglist* *rawbody*

proc **clay::define::Class_Method** *name* *arglist* *body*

proc **clay::define::class_method** *name* *arglist* *body*

proc **clay::define::clay** ?*args*?

proc **clay::define::destructor** *rawbody*

proc **clay::define::Dict** *name* ?*Werte* ?

proc **clay::define::Option** *name* ?*args*?

proc **clay::define::Method** *name* *argstyle* *argspec* *body*

proc **clay::define::Option_Class** *name* ?*args*?

proc **clay::define::Variable** *name* ?*default* ?

proc **clay::ensemble_methodbody** *Ensemble* *einfo*

proc **clay::define::Ensemble** *rawmethod* ?*args*?

proc **clay::event::cancel** *self* ?*task* **\***?

proc **clay::event::generate** *self* *event* ?*args*?

proc **clay::event::nextid**

proc **clay::event::Notification_list** *self* *event* ?*stackvar* ?

proc **clay::event::notify** *Empfänger* *Absender* *event* *Ereignisinformationen*

proc **clay::event::process** *self* *handle* *script*

proc **clay::event::schedule** *self* *handle* *interval* *script*

proc **clay::event::subscribe** *self* *who* *event*

proc **clay::event::unsubscribe** *self* ?*args*?

proc **clay::singleton** *name* *script*

method **clay ancestors**

method **clay dump**

method **clay find** *path* ?**path...**?

method **clay get** *path* ?**path...**?

method **clay GET** *path* ?**path...**?

method **clay merge** *dict* ?**dict...**?

method **clay replace** *dictionary*

method **clay search** *path* ?**path...**?

method **clay set** *path* ?**path...**? *value*

method **clay ancestors**

method **clay cache** *path* *value*

method **clay cget** *field*

method **clay delegate** ?*stub*? ?*object*?

method **clay dump**

method **clay ensemble_map**

method **clay eval** *script*

method **clay evolve**

method **clay exists** *path* ?**path...**?

method **clay flush**

method **clay forward** *method* *object*

method **clay get** *path* ?**path...**?

method **clay leaf** *path* ?**path...**?

method **clay merge** *dict* ?**dict...**?

method **clay mixin** *class* ?**class...**?

method **clay mixinmap** ?*stub*? ?*classes*?

method **clay provenance** *path* ?**path...**?

method **clay replace** *dictionary*

method **clay search** *path* *valuevar* *isleafvar*

method **clay source** *filename*

method **clay set** *path* ?**path...**? *value*

method **InitializePublic**

# BESCHREIBUNG

Clay führt sowohl für **oo::class** als auch für **oo::object** ein Ensemble namens „clay“ ein. Dieses Ensemble verwaltet alle übergeordneten Interaktionen innerhalb des Rahmens. Clay speichert strukturierte Daten. Clan verwaltet die Weiterleitung der Methoden. Clay verfügt über Funktionen zur Verwaltung der komplexen Interaktionen, die durch Mixins entstehen.

Das zentrale Konzept besteht darin, dass sich im Inneren jedes Objekts und jeder Klasse (die ja eigentlich ebenfalls Objekte sind) ein Dict namens „clay“ befindet. Was in diesem Dict gespeichert ist, bleibt der Fantasie überlassen. Da dieses Dict jedoch über eine öffentliche Methode zugänglich gemacht wird, können wir strukturierte Daten zwischen Objekten, Klassen und Mixins austauschen.

## Strukturierte Daten

Clay nutzt einen standardisierten Satz von Methodeninteraktionen und Introspektion, den TclOO bereits bereitstellt, um Suchvorgänge in Echtzeit durchzuführen. Suchvorgänge in Echtzeit bedeuten, dass die Daten stets aktuell sind, und wir vermeiden viele der Konflikte, die entstehen würden, wenn sich Objekte während des Betriebs mit denen anderer Klassen vermischen würden.

Die **clay**-Methoden verfügen sowohl für Klassen als auch für Objekte über eine „get“- und eine „set“-Methode. Bei Objekten durchsucht die „get“-Methode das lokale „clay“-Dict. Wenn das angeforderte Blatt nicht gefunden wird oder wenn die Abfrage auf einen Zweig bezieht, beginnt das System damit, die „clay“-Methoden aller Klassen abzufragen, die das Objekt implementieren, sowie aller Vorfahren dieser Klassen und aller Klassen, die in dieses Objekt „gemischt“ wurden, einschließlich aller ihrer Vorfahren.

Als Zweige vorgesehene Einträge in einem Baum enden mit einem Verzeichnis-Shrug (/). Als Blätter vorgesehene Einträge bleiben unverändert. Dies dient dem Tool, das die Suchergebnisse erstellt, als Orientierungshilfe, um zu erkennen, welche Teile eines Dicts als Zweige und welche als Blätter vorgesehen sind. In einfachen Fällen kann die Kennzeichnung als Zweig ignoriert werden:

```
::oo::class create ::foo { }
::foo clay set property/ color blue
::foo clay set property/ shape round

set A [::foo new]
$A clay get property/
{color blue shape round}

$A clay set property/ shape square
$A clay get property/
{color blue shape square}
```

Wenn Sie jedoch anfangen, Textblöcke zu speichern, wird es unübersichtlich, zu erraten, welches Feld ein Dictionary ist und welches nicht:

```
::foo clay set description {A generic thing of designated color and shape}

$A clay get description
{A generic thing of designated color and shape}

Without a convention for discerning branches for leaves what should have been a value can be accidentally parsed as a dictionary, and merged with all of the other values that were never intended to be merge. Here is an example of it all going wrong:
::oo::class create ::foo { }
# Add description as a leaf
::foo clay set description  {A generic thing of designated color and shape}
# Add description as a branch
::foo clay set description/  {A generic thing of designated color and shape}

::oo::class create ::bar {
  superclass foo
}
# Add description as a leaf
::bar clay set description  {A drinking establishment of designated color and shape and size}
# Add description as a branch
::bar clay set description/  {A drinking establishment of designated color and shape and size}

set B [::bar new]
# As a leaf we get the value verbatim from he nearest ancestor
$B clay get description
  {A drinking establishment of designated color and shape and size}
# As a branch we get a recursive merge
$B clay get description/
{A drinking establishment of designated color and size thing of}
```

## Clay-Dialekt

Clay basiert auf dem Modul oo::dialect aus Tcllib. Mit oo::dialect können Sie entweder Schlüsselwörter direkt zu Clay hinzufügen oder auf der Grundlage von Clay eine eigene Metaklasse und einen eigenen Satz von Schlüsselwörtern erstellen. Einzelheiten zu den Schlüsselwörtern und deren Funktionsweise finden Sie in den Funktionen des Namespace ::clay::define.

## Methoden-Weiterleitung

Methoden-Weiterleitung: Manchmal ist es sinnvoll, über ein externes Objekt zu verfügen, das so aufgerufen werden kann, als wäre es eine Methode des Objekts. Clay bietet eine Ensemble-Methode namens „delegate“ an, um diese Weiterleitung durchzuführen und um zu ermitteln, welche Methoden auf diese Weise delegiert sind. Alle delegierten Methoden sind durch HTML-ähnliche Tags (< >) gekennzeichnet.

```
::clay::define counter {
  Variable counter 0
  method incr {{howmuch 1}} {
    my variable counter
    incr counter $howmuch
  }
  method value {} {
    my variable counter
    return $counter
  }
  method reset {} {
    my variable counter
    set counter 0
  }
}
::clay::define example {
  variable buffer
  constructor {} {
    # Build a counter object
    set obj [namespace current]::counter
    ::counter create $obj
    # Delegate the counter
    my delegate <counter> $obj
  }
  method line {text} {
    my <counter> incr
    append buffer $text
  }
}

set A [example new]
$A line {Who’s line is it anyway?}
$A <counter> value
1
```

# BEFEHLE

proc **clay::PROC** *name* *arglist* *body* ?*ninja* ?
: Da viele Funktionen dieses Pakets möglicherweise als Befehle in zukünftige Tcl-Kerne aufgenommen oder von Paketen in binärer Form bereitgestellt werden, benötige ich eine deklarative Möglichkeit, um anzugeben: *Erstellen Sie diesen Befehl, falls noch keiner vorhanden ist*. Das Argument *ninja* ist ein Skript, das ausgeführt werden soll, wenn der Befehl über diesen Mechanismus erstellt wird.

proc **clay::\_ancestors** *resultvar* *class*
: ...siehe nächstes...

proc **clay::ancestors** ?*args*?
: ...siehe nächstes...

proc **clay::args_to_dict** ?*args*?
: ...siehe nächstes...

proc **clay::args_to_options** ?*args*?
: ...siehe nächstes...

proc **clay::dynamic_arguments** *Ensemble* *method* *arglist* ?*args*?
: ...siehe nächstes...

proc **clay::dynamic_wrongargs_message** *arglist*
: ...siehe nächstes...

proc **clay::is_dict** *d*
: ...siehe nächstes...

proc **clay::is_null** *value*
: ...siehe nächstes...

proc **clay::leaf** ?*args*?
: ...siehe nächstes...

proc **clay::K** *a* *b*
: ...siehe nächstes...

proc **clay::noop** ?*args*?
: Führt einen Noop aus. Dies ist beim Prototyping nützlich, um Code-Blöcke zu kommentieren, ohne sie tatsächlich auskommentieren zu müssen. Außerdem dient es als praktische Standardoption für die Weiterleitung der Methoden, wenn noch kein Delegat zugewiesen wurde.

proc **clay::cleanup**
: Verarbeitet den Prozess der Löschung der zu löschenden Objekte

proc **clay::object_create** *objname* ?*class* ?
: ...siehe nächstes...

proc **clay::object_rename** *object* *neuer Name*
: ...siehe nächstes...

proc **clay::object_destroy** ?*args*?
: Ein Objekt für die Löschung bei der nächsten Bereinigung markieren

proc **clay::path** ?*args*?
: ...siehe nächstes...

proc **clay::putb** ?*map*? *text*
: Fügt einer Variable eine Textzeile hinzu. Wenden Sie optional eine Zeichenfolgenzuordnung an.

proc **clay::script_path**
: ...siehe nächstes...

proc **clay::NSNormalize** *qualname*
: ...siehe nächstes...

proc **clay::uuid_generate** ?*args*?
: ...siehe nächstes...

proc **clay::uuid::generate_tcl_machinfo**
: ...siehe nächstes...

proc **clay::uuid::tostring** *uuid*
: ...siehe nächstes...

proc **clay::uuid::fromstring** *uuid*
: Konvertiert eine Zeichenfolgendarstellung einer UUID in ihr binary format.

proc **clay::uuid::equal** *links* *rechts*
: Vergleicht zwei UUIDs auf Gleichheit.

proc **clay::uuid** *cmd* ?*args*?
: UUID generieren -> Zeichenfolgenrepräsentation einer neuen UUID; UUID entspricht UUID1 und UUID2

proc **clay::tree::sanitize** *dict*
: Gibt ein Dictionary aus, aus dem alle von **clay::tree::merge** hinzugefügten Einträge entfernt wurden.

proc **clay::tree::\_sanitizeb** *path* *Variablenname* *Dict*
: Hilfsfunktion für ::clay::tree::sanitize: Formatiert die Zeichenfolgendarstellung eines Dictionary-Elements innerhalb eines für Menschen lesbaren Zeilenstroms und ermittelt, ob die Funktion sich selbst mit weiterer Einrückung aufrufen muss, um einen Unterzweig als Ausdruck darzustellen

proc **clay::tree::storage** *rawpath*
: Gibt den Pfad als Speicherpfad für clay::tree zurück, wobei alle Verzweigungsbegrenzer entfernt werden. Dieser Befehl teilt Argumente zudem auf, wenn sie ein „/“ enthalten. Beispiele:


```
 > clay::tree::storage {foo bar baz bang}
 foo bar baz bang
 > clay::tree::storage {foo bar baz bang/}
 foo bar baz bang
 > clay::tree::storage {foo bar baz bang:}
 foo bar baz bang:
 > clay::tree::storage {foo/bar/baz bang:}
 foo bar baz bang:
 > clay::tree::storage {foo/bar/baz/bang}
 foo bar baz bang
```

proc **clay::tree::dictset** *varname* ?*args*?
: Legt ein Element mit einem rekursiven Dictionary fest, wobei alle Verzweigungen auf dem Weg zum Endelement markiert werden. Wenn der Wert im verschachtelten Dictionary nicht existiert, wird er als Blatt hinzugefügt. Wenn der Wert bereits als Zweig existiert, wird der übergebene Wert mit dem vorhandenen Wert zusammengeführt, sofern es sich um ein gültiges Dictionary handelt. Wenn der übergebene Wert kein gültiges Dictionary ist, überschreibt er den gespeicherten Wert und wird fortan als Blatt behandelt. Beispiele:


```
 > set r {}
 > ::clay::tree::dictset r option color default Green
 . {} option {. {} color {. {} default Green}}
 > ::clay::tree::dictset r option {Something not dictlike}
 . {} option {Something not dictlike}
 # Note that if the value is not a dict, and you try to force it to be
 # an error with be thrown on the merge
 > ::clay::tree::dictset r option color default Blue
 missing value to go with key
```

proc **clay::tree::dictmerge** *varname* ?*args*?
: Eine rekursive Form der Zusammenführung von Wörterbüchern, die dazu dient, Variablen direkt an Ort und Stelle zu ändern. Beispiele:


```
 > set mydict {sub/ {sub/ {description {a block of text}}}}
 > ::clay::tree::dictmerge mydict {sub/ {sub/ {field {another block of text}}}}]
 > clay::tree::print $mydict
 sub/ {
   sub/ {
     description {a block of text}
     field {another block of text}
   }
 }
```

proc **clay::tree::merge** ?*args*?
: Eine rekursive Methode zum Zusammenführen von Wörterbüchern – Eine Routine zum rekursiven Durchsuchen von Wörterbüchern und deren Zusammenführung, adaptiert von http://stevehavelka.com/tcl-dict-operation-nested-merge/. Beispiele:


```
 > set mydict {sub/ {sub/ {description {a block of text}}}}
 > set odict [clay::tree::merge $mydict {sub/ {sub/ {field {another block of text}}}}]
 > clay::tree::print $odict
 sub/ {
   sub/ {
     description {a block of text}
     field {another block of text}
   }
 }
```

proc **dictargs::proc** *name* *argspec* *body*
: „Benannte Prozeduren“ als neuer Befehl

proc **dictargs::method** *name* *argspec* *body*
: ...siehe nächstes...

proc **clay::dialect::Push** *class*
: ...siehe nächstes...

proc **clay::dialect::Peek**
: ...siehe nächstes...

proc **clay::dialect::Pop**
: ...siehe nächstes...

proc **clay::dialect::create** *name* ?*parent* ?
: Diese Prozedur generiert einen Namespace, eine „Mutter aller Klassen“ sowie einen grundlegenden Satz von Richtlinien für diesen Dialekt.

proc **clay::dialect::NSNormalize** *Namespace* *qualname*
: Hilfsbefehle; nicht für den direkten Aufruf vorgesehen.

proc **clay::dialect::DefineThunk** *target* ?*args*?
: ...siehe nächstes...

proc **clay::dialect::Canonical** *namespace* *NSpace* *class*
: ...siehe nächstes...

proc **clay::dialect::Define** *Namespace* *class* ?*Argumente*?
: Implementierung des Befehls „define“ in den Sprachen

proc **clay::dialect::Aliases** *Namespace* ?*args*?
: ...siehe nächstes...

proc **clay::dialect::SuperClass** *Namespace* ?*args*?
: ...siehe nächstes...

proc **clay::dynamic_methods** *class*
: ...siehe nächstes...

proc **clay::dynamic_methods_class** *thisclass*
: ...siehe nächstes...

proc **clay::define::Array** *name* ?*Werte* ?
: Neue OO-Schlüsselwörter für Ton

proc **clay::define::Delegate** *name* *info*
: Eine Anmerkung, die angibt, dass Objekte dieser Klasse mit delegierten Methoden interagieren. Die Anmerkung ist als Dictionary konzipiert, und der einzige reservierte Schlüssel ist *description*, eine für Menschen lesbare Beschreibung.

proc **clay::define::constructor** *arglist* *rawbody*
: ...siehe nächstes...

proc **clay::define::Class_Method** *name* *arglist* *body*
: Legt eine Methode für das Klassenobjekt selbst fest, anstatt für Objekte dieser Klasse

proc **clay::define::class_method** *name* *arglist* *body*
: Und ein Alias für das neue Schlüsselwort „Class_Method“

proc **clay::define::clay** ?*args*?
: ...siehe nächstes...

proc **clay::define::destructor** *rawbody*
: ...siehe nächstes...

proc **clay::define::Dict** *name* ?*Werte* ?
: ...siehe nächstes...

proc **clay::define::Option** *name* ?*args*?
: Legt eine Option für die Klasse fest

proc **clay::define::Method** *name* *argstyle* *argspec* *body*
: ...siehe nächstes...

proc **clay::define::Option_Class** *name* ?*args*?
: Definiert eine Klasse von Optionen. Alle Feld-/Wert-Paare werden von einer Option geerbt, die *name* als Klassenfeld festlegt.

proc **clay::define::Variable** *name* ?*default* ?
: Dieses Schlüsselwort lässt sich auch wie folgt ausdrücken:


```
property variable NAME {default DEFAULT}
```

Variablen, die in der Eigenschaft „variable“ registriert sind, werden ebenfalls initialisiert (sofern sie fehlen), wenn das Objekt über die Methode *morph* die Klasse wechselt.

proc **clay::ensemble_methodbody** *Ensemble* *einfo*
: Erstellt den Hauptteil der öffentlichen Dispatch-Methode eines Ensembles. „ensemble“ ist der Name des Ensembles. „einfo“ ist ein Dictionary mit Methoden für das Ensemble, und jeder Wert ist ein Skript, das beim Dispatch ausgeführt werden soll. Beispiele:


```
 ::clay::ensemble_methodbody foo {
   bar {tailcall my Foo_bar {*}$args}
   baz {tailcall my Foo_baz {*}$args}
   clock {return [clock seconds]}
   default {puts "You gave me $method"}
 }
```

proc **clay::define::Ensemble** *rawmethod* ?*args*?
: ...siehe nächstes...

proc **clay::event::cancel** *self* ?*task* **\***?
: Ein geplantes Ereignis absagen

proc **clay::event::generate** *self* *event* ?*args*?
: Ereignis generieren: Fügt einen Abonnementmechanismus für Objekte hinzu, um festzustellen, wer dieses Ereignis erhalten hat, und um Spam oder unendliche Rekursion zu verhindern

proc **clay::event::nextid**
: ...siehe nächstes...

proc **clay::event::Notification_list** *self* *event* ?*stackvar* ?
: Wird rekursiv aufgerufen, um eine Liste der Personen zu erstellen, die Benachrichtigungen erhalten

proc **clay::event::notify** *Empfänger* *Absender* *event* *Ereignisinformationen*
: Endgültige Zustellung an den vorgesehenen Empfänger als Objekt

proc **clay::event::process** *self* *handle* *script*
: Ein Ereignisskript im globalen Namespace auswerten

proc **clay::event::schedule** *self* *handle* *interval* *script*
: Ein Ereignis für einen späteren Zeitpunkt planen

proc **clay::event::subscribe** *self* *who* *event*
: Ein Objekt auf ein Ereignis-Muster abonnieren

proc **clay::event::unsubscribe** *self* ?*args*?
: Ein Objekt aus einem Ereignis-Muster abmelden

proc **clay::singleton** *name* *script*
: Ein Objekt, das als eigene Klasse gedacht ist.


# KLASSEN

## Klasse clay::class

**Methods**

method **clay ancestors**
: Gibt diese Klasse und alle Vorfahren in Suchreihenfolge zurück.

method **clay dump**
: Gibt einen vollständigen Auszug der Clay-Daten dieses Objekts zurück, jedoch ausschließlich die Clay-Daten dieses Objekts.

method **clay find** *path* ?**path...**?
: Ruft einen Datenblock aus dem Clay-System ab. Wenn das letzte Element von *path* ein Zweig ist, gibt es eine rekursive Zusammenführung aller Daten dieses Objekts und seiner Klassen mit den Daten in diesem Zweig zurück. Wenn das letzte Element ein Blatt ist, wird dieses Objekt nach einem passenden Blatt durchsucht oder es werden alle zugehörigen Klassen nach einem passenden Blatt durchsucht und der erste gefundene Wert gegeben. Wird kein Wert gefunden, gibt es eine leere Zeichenkette zurück. Wird ein Zweig zurückgegeben, wird der oberste Eintrag weggelassen.

method **clay get** *path* ?**path...**?
: Ruft einen Datenblock aus dem „Clay“-System der Klasse ab. Wird kein Wert gefunden, gibt es eine leere Zeichenkette zurück. Wird ein Zweig zurückgegeben, wird der oberste Eintrag weggelassen.

method **clay GET** *path* ?**path...**?
: Ruft einen Datenblock aus dem „Clay“-System der Klasse ab. Wird kein Wert gefunden, gibt es eine leere Zeichenkette zurück.

method **clay merge** *dict* ?**dict...**?
: Fügt die angegebenen Dictionarys rekursiv in den lokalen Clay-Speicher des Objekts ein.

method **clay replace** *dictionary*
: Ersetzt den Inhalt des internen Clay-Speichers durch das angegebene Dictionary.

method **clay search** *path* ?**path...**?
: Gibt den ersten übereinstimmenden Wert für den Pfad entweder in den Clay-Daten dieser Klasse oder in denen eines ihrer übergeordneten Elemente zurück

method **clay set** *path* ?**path...**? *value*
: Fügt den Inhalt von **value** mit dem Speicherplatz des Objekts unter **path** zusammen.


## Klasse clay::object

clay::object Diese Klasse wird von allen Klassen geerbt, die Optionen besitzen.

**Methods**

method **clay ancestors**
: Gibt die Klasse, zu der dieses Objekt gehört, alle in dieses Objekt gemischten Klassen sowie alle Vorfahren dieser Klassen in Suchreihenfolge zurück.

method **clay cache** *path* *value*
: Speichert „VALUE“ so, dass eine Abfrage nach „Pfad“ in „SEARCH“ diesen Wert stets gibt, bis der Cache geleert wird.

method **clay cget** *field*
: Entnimmt einen Wert entweder aus der „clay“-Struktur des Objekts oder aus einer seiner Teilklassen, der mit dem Feldnamen übereinstimmt. Die Reihenfolge der Suche lautet wie folgt: 1. Als Wert in der lokalen Dict-Variablen „config“ 2. Als Wert in der lokalen Dict-Variablen „clay“ 3. Als Blattknoten in einem beliebigen Vorfahren, der die Wurzel des „clay“-Baums bildet 4. Als Blattknoten in einem beliebigen Vorfahren mit dem Feldnamen **const** *field* 5. Als Blattknoten in einem beliebigen Vorfahren mit dem Feldnamen **option** *field* **default**

method **clay delegate** ?*stub*? ?*object*?
: Introspektion oder Weiterleitung von Methoden. Ohne Argumente gibt die Methode eine Schlüssel-Wert-Liste aus Stubs und Objekten zurück. Mit nur dem Argument *stub* gibt die Methode das Objekt (falls vorhanden) zurück, das mit dem Stub verknüpft ist. Mit einem *stub* und einem *object* leitet dieser Befehl alle Aufrufe der Methode *stub* an das *object* weiter.

method **clay dump**
: Gibt einen vollständigen Auszug der Clay-Daten dieses Objekts sowie die Daten aller rekursiv eingebundenen Klassen zurück.

method **clay ensemble_map**
: Gibt ein Dictionary zurück, das die für dieses Objekt zusammenzustellenden Methodenensembles beschreibt

method **clay eval** *script*
: Ein Skript im Namespace dieses Objekts wurde ausgewertet

method **clay evolve**
: Löst die private Methode **InitializePublic** aus

method **clay exists** *path* ?**path...**?
: Gibt den Wert 1 zurück, wenn *path* in den Clay-Daten des Objekts vorhanden ist. Werte größer als eins zeigen an, dass das Element in einer der Klassen vorhanden ist, aus denen das Objekt besteht. Der Wert Null bedeutet, dass der Pfad nicht gefunden werden konnte.

method **clay flush**
: Löscht alle von der Clay-Implementierung erstellten Caches

method **clay forward** *method* *object*
: Eine praktische Hülle für


```
oo::objdefine [self] forward {*}$args
```

method **clay get** *path* ?**path...**?
: Ruft einen Datenblock aus dem Clay-System ab. Wenn das letzte Element von *path* ein Zweig (endet mit einem Schrägstrich /) ist, gibt es eine rekursive Zusammenführung aller Daten dieses Objekts und seiner Klassen mit den Daten in diesem Zweig zurück. Wenn das letzte Element ein Blatt ist, wird dieses Objekt oder es werden alle zugehörigen Klassen nach einem passenden Blatt durchsucht, und der erste gefundene Wert wird zurückgegeben. Wird kein Wert gefunden, gibt der Befehl eine leere Zeichenkette zurück.

method **clay leaf** *path* ?**path...**?
: Ein modifizierter „get“-Befehl, der so angepasst ist, dass er ausschließlich Blattelemente abruft

method **clay merge** *dict* ?**dict...**?
: Fügt die angegebenen Dictionarys rekursiv in den lokalen Clay-Speicher des Objekts ein.

method **clay mixin** *class* ?**class...**?
: Führt \[oo::objdefine \[self\] mixin\] für dieses Objekt aus, wobei folgende zusätzliche Regeln gelten: Vor dem Aufruf wird für jede Klasse, die zuvor eingemischt wurde, aber nicht im neuen Ergebnis enthalten ist, das unter mixin/unmap-script registrierte Skript ausgeführt (sofern vorhanden). Für alle neuen Klassen, die vor diesem Aufruf noch nicht vorhanden waren, wird nach dem Aufruf des nativen TclOO-Mixins das unter mixin/map-script registrierte Skript ausgeführt (sofern vorhanden). Für alle Klassen, die nun vorhanden und eingemischt sind, wird das unter mixin/react-script registrierte Skript ausgeführt (sofern vorhanden).

method **clay mixinmap** ?*stub*? ?*classes*?
: Wird kein Argument angegeben, gibt die Map der Stubs und Klassen zurück, die in das aktuelle Objekt eingemischt wurden. Wird nur ein Stub angegeben, gibt die Map der Klassen zurück, die in diesen Stub eingemischt wurden. Werden ein Stub und eine Klassenliste angegeben, werden die derzeit in diesem Stub enthaltenen Klassen durch die angegebenen Klassen ersetzt und das Verfahren „clay mixin“ auf die neue Matrix der eingemischten Klassen angewendet.

method **clay provenance** *path* ?**path...**?
: Gibt entweder **self** zurück, falls dieser Pfad im aktuellen Objekt vorhanden ist, oder die erste Klasse (sofern vorhanden) entlang des Clay-Suchpfads, die dieses Element enthält.

method **clay replace** *dictionary*
: Ersetzt den Inhalt des internen Clay-Speichers durch das angegebene Dictionary.

method **clay search** *path* *valuevar* *isleafvar*
: Gibt true zurück und setzt *valuevar* auf den Wert sowie *isleafvar* auf true oder false, je nachdem, ob *path* im Cache gefunden wurde.

method **clay source** *filename*
: Wertet die angegebene Datei im Namespace des Objekts aus

method **clay set** *path* ?**path...**? *value*
: Fügt den Inhalt von **value** mit dem „Clay“-Speicher des Objekts unter **path** zusammen.

method **InitializePublic**
: Variablen instanziieren. Wird bei der Objekterstellung und während des „Clay“-Mixins aufgerufen.


# AUTOREN

Sean Woods *mailto:\<yoda@etoyoc.com>*

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *oo* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge

# COPYRIGHT

```
Copyright (c) 2018 Sean Woods <yoda@etoyoc.com>
```
