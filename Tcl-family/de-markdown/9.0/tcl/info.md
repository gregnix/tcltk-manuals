---
CommandName: info
title: info
ManualSection: n
Version: 8.4
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - global(n)
 - oo::class(n)
 - oo::define(n)
 - oo::object(n)
 - proc(n)
 - self(n)
 - tcl_library(n)
 - tcl_patchLevel(n)
 - tcl_version(n)
Keywords:
 - command
 - information
 - interpreter
 - introspection
 - level
 - namespace
 - object
 - procedure
 - variable
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1997 Sun Microsystems, Inc.
 - Copyright (c) 1993-1997 Bell Labs Innovations for Lucent Technologies
 - Copyright (c) 1998-2000 Ajuba Solutions
 - Copyright (c) 2007-2012 Donal K. Fellows
---

# Name

info - Informationen über den Zustand des Tcl-Interpreters

# Übersicht

::: {.synopsis} :::
[info]{.cmd} [option]{.arg} [arg arg]{.optdot}
:::

# Beschreibung

Verfügbare Befehle:

[info]{.cmd} [args]{.sub} [procname]{.arg}
: Gibt die Namen der Parameter der Prozedur *procname* zurück.

[info]{.cmd} [body]{.sub} [procname]{.arg}
: Gibt den Rumpf der Prozedur *procname* zurück.

[info]{.cmd} [class]{.sub} [subcommand]{.arg} [class]{.arg} [arg ...]{.optarg}
: Gibt Informationen über die Klasse *class* zurück. Siehe [Klassen-Introspection] unten.

[info]{.cmd} [cmdcount]{.sub}
: Gibt die Gesamtzahl der in diesem Interpreter ausgewerteten Befehle zurück.

[info]{.cmd} [cmdtype]{.sub} [commandName]{.arg}
: [Gibt den Typ des Befehls *commandName* zurück. Eingebaute Typen sind:]{version="TIP426"}

    [**alias**]{version="TIP426"}
    : [*commandName* wurde mit [interp alias][interp] erzeugt. In einem Safe-Interpreter ist ein Alias nur sichtbar, wenn sowohl der Alias als auch das Ziel sichtbar sind.]{version="TIP426"}

    [**coroutine**]{version="TIP426"}
    : [*commandName* wurde mit **coroutine** erzeugt.]{version="TIP426"}

    [**ensemble**]{version="TIP426"}
    : [*commandName* wurde mit [namespace ensemble][namespace] erzeugt.]{version="TIP426"}

    [**import**]{version="TIP426"}
    : [*commandName* wurde mit [namespace import][namespace] erzeugt.]{version="TIP426"}

    [**native**]{version="TIP426"}
    : [*commandName* wurde direkt über die Schnittstelle [Tcl\_CreateObjCommand][CrtObjCmd] erzeugt, ohne weitere Registrierung des Befehlstyps.]{version="TIP426"}

    [**object**]{version="TIP426"}
    : [*commandName* ist der öffentliche Befehl, der eine Instanz von [oo::object][object] oder einer seiner Unterklassen repräsentiert.]{version="TIP426"}

    [**privateObject**]{version="TIP426"}
    : [*commandName* ist der private Befehl (standardmäßig [my]), der eine Instanz von [oo::object][object] oder einer seiner Unterklassen repräsentiert.]{version="TIP426"}

    [**proc**]{version="TIP426"}
    : [*commandName* wurde mit **proc** erzeugt.]{version="TIP426"}

    [**interp**]{version="TIP426"}
    : [*commandName* wurde mit [interp create][interp] erzeugt.]{version="TIP426"}

    [**zlibStream**]{version="TIP426"}
    : [*commandName* wurde mit [zlib stream][zlib] erzeugt.]{version="TIP426"}


[info]{.cmd} [commands]{.sub} [pattern]{.optarg}
: Gibt die Namen aller im aktuellen Namespace sichtbaren Befehle zurück. Ist *pattern* angegeben, nur die Namen, die gemäß [string match][string] passen. Nur die letzte Komponente von *pattern* ist ein Muster; andere Komponenten bezeichnen einen Namespace. Siehe **NAMENSAUFLÖSUNG** in der Dokumentation zu [namespace]\(n).

[info]{.cmd} [complete]{.sub} [command]{.arg}
: Gibt **1** zurück, wenn *command* ein vollständiger Befehl ist, sonst **0**. Typischerweise in zeilenorientierten Eingabeumgebungen, damit Benutzer Befehle über mehrere Zeilen eingeben können.

[info]{.cmd} [constant]{.sub} [varName]{.arg}
: [Gibt **1** zurück, wenn *varName* eine Konstantenvariable ist (siehe [const]), sonst **0**.]{version="TIP677"}

[info]{.cmd} [consts]{.sub} [pattern]{.optarg}
: [Gibt die Liste der Konstantenvariablen (siehe [const]) im aktuellen Gültigkeitsbereich zurück, oder — ist *pattern* angegeben — die Liste der Konstantenvariablen, die *pattern* entsprechen, analog zu **info vars**.]{version="TIP677"}

[info]{.cmd} [coroutine]{.sub}
: Gibt den Namen der aktuellen **coroutine** zurück oder die leere Zeichenkette, wenn keine aktuelle Coroutine existiert oder die aktuelle Coroutine gelöscht wurde.

[info]{.cmd} [default]{.sub} [procname]{.arg} [parameter]{.arg} [varname]{.arg}
: Hat der Parameter *parameter* der Prozedur *procname* einen Standardwert, wird dieser in *varname* gespeichert und **1** zurückgegeben. Andernfalls **0**.

[info]{.cmd} [errorstack]{.sub} [interp]{.optarg}
: Gibt eine Beschreibung des aktiven Befehls auf jeder Ebene für den letzten Fehler im aktuellen Interpreter zurück, oder im Interpreter *interp*, falls angegeben.

    Die Beschreibung ist ein Dictionary aus Token und Parametern. Token sind derzeit **CALL**, **UP** oder **INNER**; weitere Werte können künftig eingeführt werden. **CALL** kennzeichnet einen Befehlsaufruf; der Parameter ist das entsprechende **info level** **0**. **UP** kennzeichnet einen durch [uplevel] oder Ähnliches erzeugten Wechsel der Variablenframes und bezieht sich auf das vorherige **CALL**-Element; der Parameter ist der Ebenenversatz. **INNER** bezeichnet den „inneren Kontext“ — den innersten atomaren Befehl oder Bytecode-Befehl, der den Fehler auslöste, samt Argumenten, sofern verfügbar. Während **CALL** und **UP** den Aufrufpfad abbilden, liefert **INNER** Details der fehlerhaften Operation im innersten Prozeduraufruf, bis auf Subausdruck-Ebene.

    Diese Information steht auch im Eintrag **-errorstack** des Options-Dictionarys von [catch] mit drei Argumenten; **info errorstack** ist eine bequeme Möglichkeit, sie für nicht abgefangene Fehler auf oberster Ebene in einem interaktiven **interpreter** abzurufen.

[info]{.cmd} [exists]{.sub} [varName]{.arg}
: Gibt **1** zurück, wenn eine Variable *varName* sichtbar und definiert ist, sonst **0**.

[info]{.cmd} [frame]{.sub} [depth]{.optarg}
: Gibt die Tiefe des Aufrufs von **info frame** selbst zurück. Andernfalls ein Dictionary, das den aktiven Befehl auf der *depth*-ten Ebene beschreibt; gezählt werden alle für **info level** sichtbaren Befehle plus Befehle ohne neue Ebene, z. B. [eval], [source] oder *uplevel*. Die Frame-Tiefe ist stets größer als die aktuelle Ebene.

    Ist *depth* größer als **0**, bezeichnet sie den Frame in dieser Tiefe. Andernfalls die Anzahl Frames oberhalb des aktuellen Frames.

    Wie bei **info level** und Fehler-Traces sieht **info frame** bei verschachtelten Befehlen wie „foo \[bar \[x\]\]“ nur „x“, wenn es innerhalb von „x“ aufgerufen wird.

    Das Dictionary kann folgende Schlüssel enthalten:

    **type**
    : Immer vorhanden. Mögliche Werte: [source], **proc**, **eval** und **precompiled**.

        [source]
        : Ein per [source] geladenes Skript.

        **proc**
        : Der Rumpf einer Prozedur, der nicht auf eine Zeile in einem bestimmten Skript zurückverfolgt werden konnte.

        [eval]
        : Der Rumpf eines an [eval] oder [uplevel] übergebenen Skripts.

        **precompiled**
        : Ein vorkompiliertes Skript (ladbar mit dem Paket **tbcload**); weitere Informationen sind nicht verfügbar.


    **line**
    : Die Zeilennummer des Befehls innerhalb seines Skripts. Nicht verfügbar für **precompiled**. Bei Typ [source] relativ zum Dateianfang, bei den letzten beiden Typen relativ zum Skriptanfang.

    [file]
    : Bei Typ [source] der normalisierte Pfad der Datei, die den Befehl enthält.

    **cmd**
    : Der Befehl vor durchgeführten Substitutionen.

    **proc**
    : Bei Typ **proc** der Name der Prozedur, die den Befehl enthält.

    **lambda**
    : Für einen Befehl in einem per [apply] als Rumpf einer unbenannten Routine ausgewerteten Skript die Definition dieser Routine.

    **level**
    : Für einen Frame, der einer Ebene entspricht (noch festzulegen).


    Wenn ein Befehl bis zu seiner wörtlichen Definition in einem Skript zurückverfolgt werden kann — z. B. in statisch definierten Prozeduren verschachtelte Prozeduren oder wörtliche **eval**-Skripte in Dateien oder statischen Prozeduren — ist sein Typ [source] und die Position die absolute Zeilennummer im Skript. Andernfalls ist der Typ **proc** und die Position die Zeilennummer im Prozedurrumpf.

    Prozedurdefinitionen und [eval] in einer dynamisch [eval]uierten Umgebung zählen Zeilennummern relativ zum Skriptanfang, auch wenn sie relativ zum äußeren dynamischen Skript zählen könnten. Diese Art von Nummer ist meist aussagekräftiger.

    Anders formuliert: dateibasierte Positionen werden so tief wie möglich verfolgt; wo das nicht möglich ist, werden Zeilen relativ zum kleinstmöglichen [eval]- oder Prozedurrumpf gezählt — dieser Gültigkeitsbereich ist meist leichter zu finden als ein dynamischer äußerer.

    Die syntaktische Form **{\*}** wird wie [eval] behandelt: Bei wörtlichem Listenargument verfolgt das System die Zeilennummer innerhalb der Listenelemente; andernfalls werden alle Zeilennummern relativ zum Anfang jedes Worts gezählt (kleinster Gültigkeitsbereich).

[info]{.cmd} [functions]{.sub} [pattern]{.optarg}
: Ohne *pattern* eine Liste aller derzeit definierten mathematischen Funktionen. Mit *pattern* nur Namen, die *pattern* gemäß [string match][string] entsprechen.

[info]{.cmd} [globals]{.sub} [pattern]{.optarg}
: Ohne *pattern* alle Namen derzeit definierter globaler Variablen (Variablen im globalen Namespace). Mit *pattern* nur passende Namen; Abgleich wie bei [string match][string].

[info]{.cmd} [hostname]{.sub}
: Gibt den Namen des aktuellen Rechners zurück.

    Dieser Name ist nicht garantiert der vollqualifizierte Domainname. Haben Rechner mehrere Namen (häufig bei TCP/IP (DNS) und NetBIOS), wird der für TCP/IP-Netzwerke geeignete Name zurückgegeben.

[info]{.cmd} [level]{.sub} [level]{.optarg}
: Ohne *number* die Ebene, von der diese Routine aufgerufen wurde. Andernfalls den vollständigen aktiven Befehl auf der angegebenen Ebene. Ist *number* größer als **0**, die gewünschte Ebene; andernfalls *number* Ebenen oberhalb der aktuellen. Ein vollständiger Befehl sind die Wörter des Befehls nach allen Substitutionen, also eine Liste. Siehe [uplevel] zu Ebenen.

[info]{.cmd} [library]{.sub}
: Gibt den Wert von [tcl\_library][tclvars] zurück — das Verzeichnis, in dem die mit Tcl verteilten Skripte liegen.

[info]{.cmd} [loaded]{.sub} [interp]{.optarg} [prefix]{.optarg}
: Gibt den Namen jeder Datei zurück, die in *interp* mit [load] und Präfix *prefix* geladen wurde. Ohne *prefix* eine Liste, deren Elemente je Dateiname und verwendetes Präfix sind. Bei statisch geladenen Paketen ist der Dateiname die leere Zeichenkette. Für *interp* bezeichnet die leere Zeichenkette den aktuellen Interpreter.

[info]{.cmd} [locals]{.sub} [pattern]{.optarg}
: Mit *pattern* die Namen lokaler Variablen, die *pattern* gemäß [string match][string] entsprechen. Andernfalls alle lokalen Variablen. Mit [global], [upvar] oder [variable] definierte Variablen sind nicht lokal.

[info]{.cmd} [nameofexecutable]{.sub}
: Gibt den absoluten Pfadnamen des Programms für den aktuellen Interpreter zurück. Kann keine Datei identifiziert werden, die leere Zeichenkette.

[info]{.cmd} [object]{.sub} [subcommand]{.arg} [object]{.arg} [arg ...]{.optarg}
: Gibt Informationen über das Objekt *object* zurück. *subcommand* siehe [Objekt-Introspection] unten.

[info]{.cmd} [patchlevel]{.sub}
: Gibt den Wert der globalen Variable [tcl\_patchLevel][tclvars] zurück — die exakte Version der Tcl-Bibliothek bei der Initialisierung.

[info]{.cmd} [procs]{.sub} [pattern]{.optarg}
: Gibt die Namen aller sichtbaren Prozeduren zurück. Mit *pattern* nur passende Namen gemäß [string match][string]. Nur die letzte Komponente von *pattern* ist ein Muster; andere Komponenten wählen einen Namespace. Siehe **NAMENSAUFLÖSUNG** in [namespace]\(n).

[info]{.cmd} [script]{.sub} [filename]{.optarg}
: Gibt den Pfadnamen des innersten gerade ausgewerteten Skripts zurück oder die leere Zeichenkette, wenn keiner bestimmt werden kann. Mit *filename* wird der Rückgabewert künftiger **info script**-Aufrufe für die Dauer des innersten aktiven Skripts gesetzt — nützlich in virtuellen Dateisystemen.

[info]{.cmd} [sharedlibextension]{.sub}
: Gibt die Erweiterung für Shared-Library-Dateinamen auf dieser Plattform zurück, z. B. **.so** unter Solaris. Leere Zeichenkette, wenn Shared Libraries nicht unterstützt werden.

[info]{.cmd} [tclversion]{.sub}
: Gibt den Wert der globalen Variable [tcl\_version][tclvars] zurück (Haupt- und Nebenversion der Tcl-Bibliothek).

[info]{.cmd} [vars]{.sub} [pattern]{.optarg}
: Ohne *pattern* alle sichtbaren Variablennamen. Mit *pattern* nur passende gemäß [string match][string]. Nur die letzte Komponente von *pattern* ist ein Muster; andere Komponenten bezeichnen einen Namespace. Siehe **NAMENSAUFLÖSUNG** in [namespace]\(n). Bei qualifiziertem *pattern* sind die Ergebnisse vollqualifiziert.

    Deklarierte, aber noch nicht bewertete Variablen sind in den Ergebnissen enthalten.


## Klassen-Introspection

Folgende *subcommand*-Werte unterstützt **info class**:

[info]{.cmd} [class]{.sub} [call]{.lit} [class]{.arg} [method]{.arg}
: Gibt eine Beschreibung der Methodenimplementierungen zurück, die eine stereotype Instanz der Implementierung von *method* in *class* liefern (stereotype Instanzen: vom Klasse erzeugte Objekte ohne objektspezifische Definitionen). Das Ergebnis ist eine Liste von Viererlisten; jedes Element besteht aus einem Wort für den Implementierungstyp (**method** für eine normale Methode, **filter** für einen angewendeten Filter, [**private** für eine private Methode,]{version="TIP500"} [unknown] für unbekannte Methodenbehandlung), dem aufgerufenen Methodennamen (bei **method** stets *method*, bei [unknown] „[unknown]“), dem vollqualifizierten Klassennamen der Definition und einem Wort zum Implementierungstyp (siehe **info class methodtype**).

    Es wird nicht geprüft, ob die Implementierungen [next] zur Weitergabe entlang der Aufrufkette nutzen; [die von diesem Befehl gelieferten Aufrufketten enthalten private Methoden nicht.]{version="TIP500"}

[info]{.cmd} [class]{.sub} [constructor]{.lit} [class]{.arg}
: Beschreibung der Konstruktordefinition von *class* als Zweierliste: erstes Element die Argumentliste (geeignet für **proc** oder Methodendefinition), zweites der Konstruktorrumpf. Ohne Konstruktor die leere Liste.

[info]{.cmd} [class]{.sub} [definition]{.lit} [class]{.arg} [method]{.arg}
: Beschreibung der Definition der Methode *method* von *class* als Zweierliste (Argumentliste und Methodenrumpf).

[info]{.cmd} [class]{.sub} [definitionnamespace]{.lit} [class]{.arg} [kind]{.optarg}
: [Gibt den Definitions-Namespace für Definitionen des Typs *kind* der Klasse *class* zurück; er betrifft nur Instanzen von *class*, nicht *class* selbst. *kind* kann **-class** (Namespace für [oo::define][define]) oder **-instance** (für [oo::objdefine][define]) sein; Standard ist **-class** (nur bei Unterklassen von [oo::class][class] wirklich nützlich).]{version="TIP524"}

    Liefert *class* keinen Definitions-Namespace des Typs, die leere Zeichenkette. Dann ermitteln [oo::define][define] und [oo::objdefine][define] den Namespace über die Vererbungshierarchie.

[info]{.cmd} [class]{.sub} [destructor]{.lit} [class]{.arg}
: Rumpf des Destruktors von *class*. Ohne Destruktor die leere Zeichenkette.

[info]{.cmd} [class]{.sub} [filters]{.lit} [class]{.arg}
: Liste der auf der Klasse gesetzten Filtermethoden.

[info]{.cmd} [class]{.sub} [forward]{.lit} [class]{.arg} [method]{.arg}
: Argumentliste der Methodenweiterleitung *method* auf der Klasse *class*.

[info]{.cmd} [class]{.sub} [instances]{.lit} [class]{.arg} [pattern]{.optarg}
: Liste der Instanzen von *class*. Mit optionalem *pattern* nur passende Instanzen gemäß [string match][string].

[info]{.cmd} [class]{.sub} [methods]{.lit} [class]{.arg} [options...]{.optarg}
: Liste aller öffentlichen (exportierten) Methoden von *class*. Folgende *option*s steuern die Auswahl:

    [-all]{.lit}
    : Mit **-all** [und ohne **-scope**]{version="TIP500"} Methoden der Klasse sowie ihrer Superklassen und Mixins.

    [-private]{.lit}
    : Mit **-private** [und ohne **-scope**]{version="TIP500"} auch nicht exportierte Methoden (und bei **-all** von Superklassen und Mixins). [Hinweis: unglückliche Namenskollision mit echten privaten Methoden; der Optionsname bleibt aus Kompatibilitätsgründen.]{version="TIP500"}

    [-scope]{.lit} [scope]{.arg}
    : [Alle Methoden von *class* mit Sichtbarkeit *scope*. Bei dieser Option werden **-all** und **-private** ignoriert. Gültige *scope*-Werte:]{version="TIP500"}

        [**public**]{version="TIP500"}
        : [Nur Methoden mit *public*-Sichtbarkeit (von überall und jeder Instanz dieser Klasse aufrufbar).]{version="TIP500"}

        [**unexported**]{version="TIP500"}
        : [Nur Methoden mit *unexported*-Sichtbarkeit (nur über [my] aufrufbar).]{version="TIP500"}

        [**private**]{version="TIP500"}
        : [Nur Methoden mit *private*-Sichtbarkeit (nur innerhalb der Methoden dieser Klasse aufrufbar).]{version="TIP500"}



[info]{.cmd} [class]{.sub} [methodtype]{.lit} [class]{.arg} [method]{.arg}
: Beschreibung des Implementierungstyps der Methode *method* von *class*. Bei Ergebnis **method** weitere Infos mit **info class definition**, bei **forward** mit **info class forward**.

[info]{.cmd} [class]{.sub} [mixins]{.lit} [class]{.arg}
: Liste aller in *class* gemischten Klassen.

[info]{.cmd} [class]{.sub} [properties]{.lit} [class]{.arg} [options...]{.optarg}
: [Sortierte Liste der Eigenschaften von *class*. *options* steuern die Auswahl:]{version="TIP558"}

    [-all]{.lit}
    : [Mit dieser Option auch Eigenschaften von Superklassen und Mixins.]{version="TIP558"}

    [-readable]{.lit}
    : [Diese Option (Standard) liefert lesbare Eigenschaften. Es werden nur lesbare oder schreibbare Eigenschaften zurückgegeben, nicht beides.]{version="TIP558"}

    [-writable]{.lit}
    : [Liefert schreibbare Eigenschaften. Es werden nur lesbare oder schreibbare Eigenschaften zurückgegeben, nicht beides.]{version="TIP558"}


[info]{.cmd} [class]{.sub} [subclasses]{.lit} [class]{.arg} [pattern]{.optarg}
: Liste direkter Unterklassen von *class*. Mit *pattern* nur passende Klassen gemäß [string match][string].

[info]{.cmd} [class]{.sub} [superclasses]{.lit} [class]{.arg}
: Liste direkter Superklassen von *class* in Vererbungsreihenfolge.

[info]{.cmd} [class]{.sub} [variables]{.lit} [class]{.arg} [-private]{.optlit}
: Liste aller für *class* deklarierten Variablen (automatisch in Methoden, Konstruktor und Destruktor vorhanden). [Mit **-private** die deklarierten privaten Variablen.]{version="TIP500"}


## Objekt-Introspection

Folgende *subcommand*-Werte unterstützt **info object**:

[info]{.cmd} [object]{.sub} [call]{.lit} [object]{.arg} [method]{.arg}
: Gibt eine Beschreibung der Methodenimplementierungen zurück, mit denen *object* die Methode *method* implementiert. Das ist eine Liste von Listen mit je vier Elementen: ein Wort für die allgemeine Art der Methodenimplementierung (**method** für eine gewöhnliche Methode, **filter** für einen angewendeten Filter, [**private** für eine private Methode,]{version="TIP500"} und [unknown] für eine Methode, die bei der Behandlung unbekannter Methoden aufgerufen wird), ein Wort mit dem Namen der aufgerufenen Methode (bei der Art **method** immer gleich *method*, bei der Art [unknown] „[unknown]“), ein Wort, das angibt, was die Methode definiert hat (der vollqualifizierte Name der Klasse oder die Zeichenkette **object**, wenn die Methodenimplementierung an einer Instanz liegt), und ein Wort, das die Art der Methodenimplementierung beschreibt (siehe **info object methodtype**).

    Es wird nicht geprüft, ob die Implementierungen [next] zur Weitergabe entlang der Aufrufkette nutzen; [die von diesem Befehl gelieferten Aufrufketten enthalten private Methoden nicht.]{version="TIP500"}

[info]{.cmd} [object]{.sub} [class]{.lit} [object]{.arg} [className]{.optarg}
: Ohne *className* die Klasse von *object*. Mit *className* ein boolescher Wert, ob *object* von dieser Klasse ist.

[info]{.cmd} [object]{.sub} [creationid]{.lit} [object]{.arg}
: [Eindeutige Erstellungskennung von *object*. Sie ist pro Objekt (innerhalb eines Tcl-Interpreters) eindeutig und kann weder bei der Erstellung gesetzt noch später geändert werden.]{version="TIP500"}

    *Implementierungshinweis:* Die Erstellungskennung erzeugt eindeutige Bezeichner für das Objekt, insbesondere für private Variablen.

[info]{.cmd} [object]{.sub} [definition]{.lit} [object]{.arg} [method]{.arg}
: Beschreibung der Definition der Methode *method* von *object* als Zweierliste (Argumentliste und Methodenrumpf).

[info]{.cmd} [object]{.sub} [filters]{.lit} [object]{.arg}
: Liste der auf dem Objekt gesetzten Filtermethoden.

[info]{.cmd} [object]{.sub} [forward]{.lit} [object]{.arg} [method]{.arg}
: Argumentliste der Methodenweiterleitung *method* auf *object*.

[info]{.cmd} [object]{.sub} [isa]{.lit} [category]{.arg} [object]{.arg} [arg]{.optarg}
: Prüft, ob ein Objekt zu einer Kategorie gehört; boolescher Wert. Unterstützte Kategorien:

    [info]{.cmd} [object]{.sub} [isa]{.lit} [class]{.lit} [object]{.arg}
    : Ob *object* eine Klasse ist (Instanz von [oo::class][class] oder Unterklasse).

    [info]{.cmd} [object]{.sub} [isa]{.lit} [metaclass]{.lit} [object]{.arg}
    : Ob *object* eine Klasse ist, die Klassen erzeugen kann ([oo::class][class] oder Unterklasse).

    [info]{.cmd} [object]{.sub} [isa]{.lit} [mixin]{.lit} [object]{.arg} [class]{.arg}
    : Ob *class* direkt in *object* gemischt ist.

    [info]{.cmd} [object]{.sub} [isa]{.lit} [object]{.lit} [object]{.arg}
    : Ob *object* wirklich ein Objekt ist.

    [info]{.cmd} [object]{.sub} [isa]{.lit} [typeof]{.lit} [object]{.arg} [class]{.arg}
    : Ob *class* der Typ von *object* ist (*object* Instanz von *class* oder Unterklasse, direkt oder indirekt).


[info]{.cmd} [object]{.sub} [methods]{.lit} [object]{.arg} [option...]{.optarg}
: Liste aller öffentlichen Methoden von *object*. *option*s wie bei **info class methods**:

    [-all]{.lit}
    : Mit **-all** [und ohne **-scope**]{version="TIP500"} auch Methoden von Klasse, Mixins und deren Superklassen.

    [-private]{.lit}
    : Mit **-private** [und ohne **-scope**]{version="TIP500"} auch nicht exportierte Methoden (und bei **-all** von Klassen). [Namenskollision mit echten privaten Methoden; Optionsname aus Kompatibilität.]{version="TIP500"}

    [-scope]{.lit} [scope]{.arg}
    : [Methoden von *object* mit Sichtbarkeit *scope*; **-all** und **-private** werden ignoriert. Gültige Werte:]{version="TIP500"}

        [**public**]{version="TIP500"}
        : [Nur *public* (von überall aufrufbar).]{version="TIP500"}

        [**unexported**]{version="TIP500"}
        : [Nur *unexported* (nur über [my]).]{version="TIP500"}

        [**private**]{version="TIP500"}
        : [Nur *private* (nur innerhalb der Instanzmethoden dieses Objekts).]{version="TIP500"}



[info]{.cmd} [object]{.sub} [methodtype]{.lit} [object]{.arg} [method]{.arg}
: Implementierungstyp der Methode *method* von *object*. Bei **method** → **info object definition**, bei **forward** → **info object forward**.

[info]{.cmd} [object]{.sub} [mixins]{.lit} [object]{.arg}
: Liste aller in *object* gemischten Klassen.

[info]{.cmd} [object]{.sub} [namespace]{.lit} [object]{.arg}
: Name des internen Namespace von *object*.

[info]{.cmd} [object]{.sub} [properties]{.lit} [object]{.arg} [options...]{.optarg}
: [Sortierte Liste der Eigenschaften von *object*. *options* wie bei **info class properties**:]{version="TIP558"}

    [-all]{.lit}
    : [Auch Eigenschaften von Klasse, Superklassen und Mixins.]{version="TIP558"}

    [-readable]{.lit}
    : [Standard: lesbare Eigenschaften. Nur lesbare oder schreibbare, nicht beides.]{version="TIP558"}

    [-writable]{.lit}
    : [Schreibbare Eigenschaften. Nur lesbare oder schreibbare, nicht beides.]{version="TIP558"}


[info]{.cmd} [object]{.sub} [variables]{.lit} [object]{.arg} [-private]{.optlit}
: Liste aller für *object* deklarierten Variablen (automatisch in den Methoden des Objekts). [Mit **-private** die privaten Variablen.]{version="TIP500"}

[info]{.cmd} [object]{.sub} [vars]{.lit} [object]{.arg} [pattern]{.optarg}
: Liste aller Variablen im privaten Namespace von *object*. Mit *pattern* ein Filter ([string match][string]-Glob). Anders als **info object variables**: jene kann noch nicht gesetzte Variablen enthalten; dieser Befehl Variablen, die von keiner Methode von *object* (oder Klasse, Superklassen, Mixins) automatisch eingebunden werden.


# Beispiele

Dieser Befehl gibt eine zum Speichern in einem Tcl-Skript geeignete Prozedur aus:

```
proc printProc {procName} {
    set result [list proc $procName]
    set formals {}
    foreach var [info args $procName] {
        if {[info default $procName $var def]} {
            lappend formals [list $var $def]
        } else {
            # Still need the list-quoting because variable
            # names may properly contain spaces.
            lappend formals [list $var]
        }
    }
    puts [lappend result $formals [info body $procName]]
}
```

## Beispiele mit Objekten

Jedes Objekt kennt seine Klasse; diese Information ist per Introspection leicht abrufbar:

```
oo::class create c
c create o
puts [info object class o]
                     → prints "::c"
puts [info object class c]
                     → prints "::oo::class"
```

Die Introspection kann ermitteln, welche Klasse eine Methode implementiert und wie sie definiert ist:

```
proc getDef {obj method} {
    foreach inf [info object call $obj $method] {
        lassign $inf calltype name locus methodtype

        # Annahme: keine Weiterleitungen oder Filter, daher keine
        # Prüfung von $calltype oder $methodtype...

        if {$locus eq "object"} {
            return [info object definition $obj $name]
        } else {
            return [info class definition $locus $name]
        }
    }
    error "no definition for $method"
}
```

Alternativ durch manuelles Durchlaufen der Vererbungskette (einfache Einzelvererbung, keine komplexen Mixins; dann ist **info object call** deutlich einfacher):

```
proc getDef {obj method} {
    if {$method in [info object methods $obj]} {
        # Annahme: keine Weiterleitungen
        return [info object definition $obj $method]
    }

    set cls [info object class $obj]

    while {$method ni [info class methods $cls]} {
        # Einfacher Fall angenommen
        set cls [lindex [info class superclass $cls] 0]
        if {$cls eq ""} {
            error "no definition for $method"
        }
    }

    # Annahme: keine Weiterleitungen
    return [info class definition $cls $method]
}
```


[apply]: apply.md
[catch]: catch.md
[class]: class.md
[const]: const.md
[CrtObjCmd]: ../tcl-c/CrtObjCmd.md
[define]: define.md
[eval]: eval.md
[file]: file.md
[global]: global.md
[interp]: interp.md
[load]: load.md
[my]: my.md
[namespace]: namespace.md
[next]: next.md
[object]: object.md
[source]: source.md
[string]: string.md
[tclvars]: tclvars.md
[unknown]: unknown.md
[uplevel]: uplevel.md
[upvar]: upvar.md
[variable]: variable.md
[zlib]: zlib.md
