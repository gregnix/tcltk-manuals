---
CommandName: oometa
ManualSection: n
Version: 0.7.2
TclPart: tcllib
TclDescription: Data registry for TclOO frameworks
Keywords:
 - TOOL
 - TclOO
Copyright:
 - Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
---

# NAME

oometa – oo::meta Ein Datenregister für Klassen

# ÜBERSICHT

::: {.synopsis} :::
[oo::meta::info]{.cmd} 
[oo::meta::info]{.cmd} [branchget]{.sub} [key]{.optarg} [...]{.optdot} 
[oo::meta::info]{.cmd} [branchset]{.sub} [key]{.optdot} [key]{.arg} [value]{.arg} 
[oo::meta::info]{.cmd} [dump]{.sub} [class]{.arg} 
[oo::meta::info]{.cmd} [class]{.arg} [is]{.lit} [type]{.arg} [args]{.optarg} 
[oo::meta::info]{.cmd} [class]{.arg} [merge]{.lit} [dict]{.optarg} [dict]{.optarg} [...]{.optdot} 
[oo::meta::info]{.cmd} [class]{.arg} [rebuild]{.lit} 
[oo::meta::metadata]{.cmd} [class]{.arg} 
[oo::define]{.cmd} [meta]{.sub} 
[oo::class]{.cmd} [method]{.sub} [meta]{.lit} 
[oo::object]{.cmd} [method]{.sub} [meta]{.lit} 
[oo::object]{.cmd} [method]{.sub} [meta]{.lit} [cget]{.lit} [field]{.optarg} [...]{.optdot} [field]{.arg} 
:::

# BESCHREIBUNG

Das Paket „**oo::meta**“ stellt einen Datenregistrierungsdienst für TclOO-Klassen bereit.

# VERWENDUNG

```
oo::class create animal {
  meta set biodata animal: 1
}
oo::class create mammal {
  superclass animal
  meta set biodata mammal: 1
}
oo::class create cat {
  superclass mammal
  meta set biodata diet: carnivore
}

cat create felix
puts [felix meta dump biodata]
> animal: 1 mammal: 1 diet: carnivore

felix meta set biodata likes: {birds mice}
puts [felix meta get biodata]
> animal: 1 mammal: 1 diet: carnivore likes: {bird mice}

# Modify a class
mammal meta set biodata metabolism: warm-blooded
puts [felix meta get biodata]
> animal: 1 mammal: 1 metabolism: warm-blooded diet: carnivore likes: {birds mice}

# Overwrite class info
felix meta set biodata mammal: yes
puts [felix meta get biodata]
> animal: 1 mammal: yes metabolism: warm-blooded diet: carnivore likes: {birds mice}
```

# KONZEPT

Das Konzept hinter **oo::meta** besteht darin, dass jede Klasse einen Ausschnitt *lokaler* Daten beisteuert. Wenn **oo::meta::metadata** aufgerufen wird, durchläuft das System die von **oo::meta::ancestors** erzeugte lineare Abstammungsstruktur und fasst alle diese lokalen Daten für alle Vorfahren einer Klasse rekursiv zu einem einzigen Dict zusammen. Instanzen von oo::object können zudem Daten einer Klasse mit einem lokalen Dict kombinieren, das in der *meta*-Variablen gespeichert ist.

# BEFEHLE

**oo::meta::info**
: **oo::meta::info** ist darauf ausgelegt, die Metadaten einer Klasse auf ähnliche Weise zu bearbeiten, wenn die einzelnen Elemente zu einem einzigen Dict zusammengefügt worden sind. Das System unterstützt alle Standard-Befehle für Dicts und bietet darüber hinaus folgende zusätzliche Funktionen:

**oo::meta::info branchget** ?*key*? ?...?
: Gibt eine Dict-Darstellung des Elements an der Position *args* zurück, wobei jedoch alle abschließenden „:“ aus den Feldnamen entfernt werden.


```
::oo::meta::info $myclass set option color {default: green widget: colorselect}
puts [::oo::meta::info $myclass get option color]
> {default: green widget: color}
puts [::oo::meta::info $myclass branchget option color]
> {default green widget color}
```

**oo::meta::info branchset** ?*key...*? *key* *value*
: Führt *dict* mit allen anderen Informationen zusammen, die am Knoten ?*key...*? enthalten sind, und fügt allen Feldnamen ein abschließendes : hinzu.


```
::oo::meta::info $myclass branchset option color {default green widget colorselect}
puts [::oo::meta::info $myclass get option color]
> {default: green widget: color}
```

**oo::meta::info dump** *class*
: Gibt den vollständigen Snapshot der Metadaten einer Klasse zurück, wie er von **oo::meta::metadata** erstellt wurde

**oo::meta::info** *class* **is** *type* ?*args*?
: Gibt den booleschen Wert „true“ oder „false“ zurück, wenn das Element „?*args*?“ mit **string is** *type* *value* übereinstimmen würde.


```
::oo::meta::info $myclass set constant mammal 1
puts [::oo::meta::info $myclass is true constant mammal]
> 1
```

**oo::meta::info** *class* **merge** ?*dict*? ?*dict*? ?*...*?
: Führt alle Argumente zu einem einzigen Dict zusammen, das anschließend als neue lokale Darstellung für diese Klasse gespeichert wird.

**oo::meta::info** *class* **rebuild**
: Zwingt das Metasystem dazu, alle zwischengespeicherten Darstellungen der Metadaten einer Klasse vor dem nächsten Zugriff auf **oo::meta::metadata** zu löschen

**oo::meta::metadata** *class*
: Gibt ein Gesamtbild der Metadaten für *class* zurück, wobei deren *lokale* Daten mit den *lokalen* Daten ihrer Vorfahren kombiniert werden.

**oo::define meta**
: Das Paket fügt den Befehl „**oo::define::meta**“ ein, der es einer Klasse ermöglicht, während der Definition auf „**oo::meta::info**“ zuzugreifen, ohne den Namen nachschlagen zu müssen.


```
oo::define myclass {
  meta set foo bar: baz
}
```

**oo::class method meta**
: Das Paket fügt eine neue Methode „**meta**“ in „**oo::class**“ ein, die den Zugriff einer Instanz der Klasse auf „**oo::meta::info**“ ermöglicht.

**oo::object method meta**
: Das Paket fügt eine neue Methode **meta** in **oo::object** ein. **oo::object** kombiniert die Daten für seine Klasse (wie von **oo::meta::metadata** bereitgestellt) mit einer lokalen Variablen *meta*, um ein lokales Abbild der Metadaten zu erstellen. Diese Methode stellt die folgenden zusätzlichen Befehle bereit:

**oo::object method meta cget** ?*field*? ?*...*? *field*
: Versucht, ein einzelnes Blatt zu finden und dessen Wert zurückzugeben. Bei der Suche nach einer einzelnen Option ist dies schneller als **my meta getnull** ?*field*? ?*...*? *field*\], da hier direkt eine Suche durchgeführt wird, anstatt zunächst das rekursive Merge-Produkt zwischen den Klassenmetadaten, der lokalen *meta*-Variablen zu erzeugen und erst danach die Suche durchzuführen.


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
