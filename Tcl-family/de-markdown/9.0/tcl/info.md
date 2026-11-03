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
: Gibt die Namen der Parameter der Prozedur mit dem Namen *procname* zurück.

[info]{.cmd} [body]{.sub} [procname]{.arg}
: Gibt den Rumpf der Prozedur mit dem Namen *procname* zurück.

[info]{.cmd} [class]{.sub} [subcommand]{.arg} [class]{.arg} [arg ...]{.optarg}
: Gibt Informationen über die Klasse mit dem Namen *class* zurück. Siehe [Klassen-Introspection] unten.

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
: Gibt die Namen aller Befehle zurück, die im aktuellen Namespace sichtbar sind. Ist *pattern* angegeben, werden nur die Namen zurückgegeben, die gemäß [string match][string] passen. Nur die letzte Komponente von *pattern* ist ein Muster. Andere Komponenten bezeichnen einen Namespace. Siehe **NAMENSAUFLÖSUNG** in der Dokumentation zu [namespace]\(n).

[info]{.cmd} [complete]{.sub} [command]{.arg}
: Gibt **1** zurück, wenn *command* ein vollständiger Befehl ist, und andernfalls **0**. Wird typischerweise in zeilenorientierten Eingabeumgebungen verwendet, damit Benutzer Befehle eingeben können, die sich über mehrere Zeilen erstrecken.

[info]{.cmd} [constant]{.sub} [varName]{.arg}
: [Gibt **1** zurück, wenn *varName* eine Konstantenvariable ist (siehe [const]), sonst **0**.]{version="TIP677"}

[info]{.cmd} [consts]{.sub} [pattern]{.optarg}
: [Gibt die Liste der Konstantenvariablen (siehe [const]) im aktuellen Gültigkeitsbereich zurück oder, falls *pattern* angegeben ist, die Liste der Konstantenvariablen, die *pattern* entsprechen, ähnlich wie bei **info vars**.]{version="TIP677"}

[info]{.cmd} [coroutine]{.sub}
: Gibt den Namen der aktuellen **coroutine** zurück oder die leere Zeichenkette, wenn keine aktuelle Coroutine existiert oder die aktuelle Coroutine gelöscht wurde.

[info]{.cmd} [default]{.sub} [procname]{.arg} [parameter]{.arg} [varname]{.arg}
: Hat der Parameter *parameter* der Prozedur mit dem Namen *procname* einen Standardwert, wird dieser Wert in *varname* gespeichert und **1** zurückgegeben. Andernfalls wird **0** zurückgegeben.

[info]{.cmd} [errorstack]{.sub} [interp]{.optarg}
: Gibt für den letzten Fehler im aktuellen Interpreter oder, falls angegeben, im Interpreter mit dem Namen *interp* eine Beschreibung des aktiven Befehls auf jeder Ebene zurück.

    Die Beschreibung ist ein Dictionary aus Token und Parametern. Token sind derzeit entweder **CALL**, **UP** oder **INNER**, doch künftig können weitere Werte hinzukommen. **CALL** kennzeichnet einen Befehlsaufruf; sein Parameter ist das entsprechende **info level** **0**. **UP** kennzeichnet einen Wechsel der Variablen-Frames, der durch [uplevel] oder Ähnliches entsteht, und bezieht sich auf das vorherige **CALL**-Element. Sein Parameter ist der Ebenenversatz. **INNER** bezeichnet den „inneren Kontext“. Das ist der innerste atomare Befehl oder die innerste Bytecode-Instruktion, die den Fehler ausgelöst hat, samt ihren Argumenten, sofern verfügbar. Während **CALL** und **UP** eine Spur des Aufrufpfads liefern, liefert **INNER** Einzelheiten zur fehlerhaften Operation im innersten Prozeduraufruf, sogar bis auf die Ebene von Teilausdrücken.

    Diese Information ist auch im Eintrag **-errorstack** des Options-Dictionarys enthalten, das [catch] mit drei Argumenten zurückgibt; **info errorstack** ist ein bequemer Weg, sie bei nicht abgefangenen Fehlern auf oberster Ebene in einem interaktiven **interpreter** abzurufen.

[info]{.cmd} [exists]{.sub} [varName]{.arg}
: Gibt **1** zurück, wenn eine Variable mit dem Namen *varName* sichtbar ist und definiert wurde, und andernfalls **0**.

[info]{.cmd} [frame]{.sub} [depth]{.optarg}
: Gibt die Tiefe des Aufrufs von **info frame** selbst zurück. Andernfalls gibt der Befehl ein Dictionary zurück, das den aktiven Befehl in der Tiefe *depth* beschreibt. Diese Tiefe zählt alle Befehle, die für **info level** sichtbar sind, und zusätzlich Befehle, die keine neue Ebene erzeugen, etwa [eval], [source] oder *uplevel*. Die Frame-Tiefe ist immer größer als die aktuelle Ebene.

    Ist *depth* größer als **0**, bezeichnet es den Frame in dieser Tiefe. Andernfalls gibt es die Anzahl der Frames oberhalb des aktuellen Frames an.

    Wie bei **info level** und bei Fehler-Traces sieht ein innerhalb von „x“ aufgerufenes **info frame** bei verschachtelten Befehlen wie „foo \[bar \[x\]\]“ nur „x“.

    Das Dictionary kann folgende Schlüssel enthalten:

    **type**
    : Immer vorhanden. Mögliche Werte sind [source], **proc**, **eval** und **precompiled**.

        [source]
        : Ein Skript, das mit dem Befehl [source] geladen wurde.

        **proc**
        : Der Rumpf einer Prozedur, der nicht auf eine Zeile in einem bestimmten Skript zurückverfolgt werden konnte.

        [eval]
        : Der Rumpf eines Skripts, das an [eval] oder [uplevel] übergeben wurde.

        **precompiled**
        : Ein vorkompiliertes Skript (ladbar mit dem Paket **tbcload**), zu dem keine weiteren Informationen verfügbar sind.


    **line**
    : Die Zeilennummer des Befehls innerhalb seines Skripts. Für **precompiled**-Befehle nicht verfügbar. Ist der Typ [source], ist die Zeilennummer relativ zum Anfang der Datei, bei den letzten beiden Typen dagegen relativ zum Anfang des Skripts.

    [file]
    : Liefert beim Typ [source] den normalisierten Pfad der Datei, die den Befehl enthält.

    **cmd**
    : Der Befehl, bevor Ersetzungen durchgeführt wurden.

    **proc**
    : Beim Typ **proc** der Name der Prozedur, die den Befehl enthält.

    **lambda**
    : Bei einem Befehl in einem Skript, das mit dem Befehl [apply] als Rumpf einer unbenannten Routine ausgewertet wird, die Definition dieser Routine.

    **level**
    : Bei einem Frame, der einer Ebene entspricht: (noch festzulegen).


    Lässt sich ein Befehl bis zu seiner wörtlichen Definition in einem Skript zurückverfolgen, z. B. bei Prozeduren, die in statisch definierten Prozeduren verschachtelt sind, und bei wörtlichen eval-Skripten in Dateien oder statisch definierten Prozeduren, dann ist sein Typ [source] und seine Position die absolute Zeilennummer im Skript. Andernfalls ist sein Typ **proc** und seine Position seine Zeilennummer innerhalb des Prozedurrumpfs.

    Im Gegensatz dazu zählen Prozedurdefinitionen und [eval] innerhalb einer dynamisch [eval]uierten Umgebung die Zeilennummern relativ zum Anfang ihres Skripts, selbst wenn sie relativ zum Anfang des äußeren dynamischen Skripts zählen könnten. Diese Art der Nummerierung ist meist sinnvoller.

    Anders beschrieben: Dateibasierte Positionen werden so tief wie möglich verfolgt. Wo das nicht möglich ist, werden die Zeilen relativ zum kleinstmöglichen [eval]- oder Prozedurrumpf gezählt, da dieser Gültigkeitsbereich meist leichter zu finden ist als ein dynamischer äußerer Gültigkeitsbereich.

    Die syntaktische Form **{\*}** wird wie [eval] behandelt. Das heißt: Erhält sie ein wörtliches Listenargument, verfolgt das System auch die Zeilennummer innerhalb der Listenwörter; andernfalls werden alle Zeilennummern relativ zum Anfang jedes Worts gezählt (kleinster Gültigkeitsbereich).

[info]{.cmd} [functions]{.sub} [pattern]{.optarg}
: Ist *pattern* nicht angegeben, gibt der Befehl eine Liste aller derzeit definierten mathematischen Funktionen zurück. Ist *pattern* angegeben, werden nur die Namen zurückgegeben, die *pattern* gemäß [string match][string] entsprechen.

[info]{.cmd} [globals]{.sub} [pattern]{.optarg}
: Ist *pattern* nicht angegeben, gibt der Befehl eine Liste aller Namen der derzeit definierten globalen Variablen zurück. Globale Variablen sind Variablen im globalen Namespace. Ist *pattern* angegeben, werden nur die Namen zurückgegeben, die *pattern* entsprechen. Der Abgleich folgt denselben Regeln wie bei [string match][string].

[info]{.cmd} [hostname]{.sub}
: Gibt den Namen des aktuellen Rechners zurück.

    Es ist nicht garantiert, dass dieser Name der vollqualifizierte Domainname des Rechners ist. Haben Rechner mehrere verschiedene Namen, wie es auf Systemen mit installiertem TCP/IP (DNS) und NetBIOS-basiertem Netzwerk üblich ist, wird der Name zurückgegeben, der für TCP/IP-Netzwerke geeignet ist.

[info]{.cmd} [level]{.sub} [level]{.optarg}
: Ist *number* nicht angegeben, gibt der Befehl die Ebene zurück, von der aus diese Routine aufgerufen wurde. Andernfalls gibt er den vollständigen Befehl zurück, der auf der angegebenen Ebene aktiv ist. Ist *number* größer als **0**, ist es die gewünschte Ebene. Andernfalls liegt die Ebene *number* Ebenen oberhalb der aktuellen Ebene. Ein vollständiger Befehl besteht aus den Wörtern des Befehls nach Durchführung aller Ersetzungen; er ist also eine Liste. Weitere Informationen zu Ebenen finden Sie bei [uplevel].

[info]{.cmd} [library]{.sub}
: Gibt den Wert von [tcl\_library][tclvars] zurück. Das ist der Name des Bibliotheksverzeichnisses, in dem die mit Tcl verteilten Skripte gespeichert sind.

[info]{.cmd} [loaded]{.sub} [interp]{.optarg} [prefix]{.optarg}
: Gibt den Namen jeder Datei zurück, die in *interp* mit dem Befehl [load] und dem Präfix *prefix* geladen wurde. Ist *prefix* nicht angegeben, gibt der Befehl eine Liste zurück, in der jedes Element aus dem Namen der geladenen Datei und dem Präfix besteht, für das die Datei geladen wurde. Bei einem statisch geladenen Paket ist der Dateiname die leere Zeichenkette. Für *interp* bezeichnet die leere Zeichenkette den aktuellen Interpreter.

[info]{.cmd} [locals]{.sub} [pattern]{.optarg}
: Ist *pattern* angegeben, gibt der Befehl den Namen jeder lokalen Variable zurück, die *pattern* gemäß [string match][string] entspricht. Andernfalls gibt er den Namen jeder lokalen Variable zurück. Eine Variable, die mit [global], [upvar] oder [variable] definiert wurde, ist nicht lokal.

[info]{.cmd} [nameofexecutable]{.sub}
: Gibt den absoluten Pfadnamen des Programms für den aktuellen Interpreter zurück. Lässt sich keine solche Datei ermitteln, wird eine leere Zeichenkette zurückgegeben.

[info]{.cmd} [object]{.sub} [subcommand]{.arg} [object]{.arg} [arg ...]{.optarg}
: Gibt Informationen über das Objekt mit dem Namen *object* zurück. *subcommand* wird unten unter [Objekt-Introspection] beschrieben.

[info]{.cmd} [patchlevel]{.sub}
: Gibt den Wert der globalen Variable [tcl\_patchLevel][tclvars] zurück, in der die genaue Version der Tcl-Bibliothek bei der Initialisierung gespeichert wird.

[info]{.cmd} [procs]{.sub} [pattern]{.optarg}
: Gibt die Namen aller sichtbaren Prozeduren zurück. Ist *pattern* angegeben, werden nur die Namen zurückgegeben, die gemäß [string match][string] passen. Nur die letzte Komponente von *pattern* wird tatsächlich als Muster betrachtet. Alle qualifizierenden Komponenten wählen lediglich einen Namespace aus. Siehe **NAMENSAUFLÖSUNG** in der Dokumentation zu [namespace]\(n).

[info]{.cmd} [script]{.sub} [filename]{.optarg}
: Gibt den Pfadnamen des innersten Skripts zurück, das gerade ausgewertet wird, oder die leere Zeichenkette, wenn sich kein Pfadname ermitteln lässt. Ist *filename* angegeben, legt dieser Wert für die Dauer des innersten aktiven Skripts den Rückgabewert aller künftigen Aufrufe von **info script** fest. Das ist in Anwendungen mit virtuellen Dateisystemen nützlich.

[info]{.cmd} [sharedlibextension]{.sub}
: Gibt die Erweiterung zurück, die auf dieser Plattform für die Namen gemeinsam genutzter Bibliotheken verwendet wird, z. B. **.so** unter Solaris. Gibt die leere Zeichenkette zurück, wenn gemeinsam genutzte Bibliotheken auf dieser Plattform nicht unterstützt werden.

[info]{.cmd} [tclversion]{.sub}
: Gibt den Wert der globalen Variable [tcl\_version][tclvars] zurück, in der die Haupt- und Nebenversion der Tcl-Bibliothek gespeichert sind.

[info]{.cmd} [vars]{.sub} [pattern]{.optarg}
: Ist *pattern* nicht angegeben, gibt der Befehl die Namen aller sichtbaren Variablen zurück. Ist *pattern* angegeben, werden nur die Namen zurückgegeben, die gemäß [string match][string] passen. Nur die letzte Komponente von *pattern* ist ein Muster. Andere Komponenten bezeichnen einen Namespace. Siehe **NAMENSAUFLÖSUNG** in der Dokumentation zu [namespace]\(n). Ist *pattern* ein qualifizierter Name, sind die Ergebnisse vollqualifiziert.

    Eine Variable, die deklariert, aber noch nicht mit einem Wert belegt wurde, ist in den Ergebnissen enthalten.


## Klassen-Introspection

Die folgenden *subcommand*-Werte werden von **info class** unterstützt:

[info]{.cmd} [class]{.sub} [call]{.lit} [class]{.arg} [method]{.arg}
: Gibt eine Beschreibung der Methodenimplementierungen zurück, mit denen eine stereotype Instanz die Implementierung von *method* durch *class* erhält (stereotype Instanzen sind Objekte, die von einer Klasse instanziiert wurden, ohne dass objektspezifische Definitionen hinzugefügt wurden). Das ist eine Liste von Listen mit je vier Elementen. Jede Teilliste besteht aus einem Wort, das die allgemeine Art der Methodenimplementierung beschreibt (**method** für eine gewöhnliche Methode, **filter** für einen angewendeten Filter, [**private** für eine private Methode,]{version="TIP500"} und [unknown] für eine Methode, die bei der Behandlung unbekannter Methoden aufgerufen wird), einem Wort mit dem Namen der jeweils aufgerufenen Methode (bei der Art **method** immer gleich *method*, bei der Art [unknown] „[unknown]“), einem Wort mit dem vollqualifizierten Namen der Klasse, die die Methode definiert hat, und einem Wort, das die Art der Methodenimplementierung beschreibt (siehe **info class methodtype**).

    Beachten Sie, dass nicht geprüft wird, ob die Methodenimplementierungen tatsächlich [next] verwenden, um die Kontrolle entlang der Aufrufkette weiterzugeben, [und dass die Aufrufketten, die dieser Befehl liefert, tatsächlich keine privaten Methoden enthalten.]{version="TIP500"}

[info]{.cmd} [class]{.sub} [constructor]{.lit} [class]{.arg}
: Dieser Unterbefehl gibt eine Beschreibung der Definition des Konstruktors der Klasse *class* zurück. Die Definition wird als Liste mit zwei Elementen beschrieben: Das erste Element ist die Liste der Argumente des Konstruktors in einer Form, die sich für die Übergabe an einen weiteren Aufruf von **proc** oder an eine Methodendefinition eignet, und das zweite Element ist der Rumpf des Konstruktors. Ist kein Konstruktor vorhanden, gibt der Unterbefehl die leere Liste zurück.

[info]{.cmd} [class]{.sub} [definition]{.lit} [class]{.arg} [method]{.arg}
: Dieser Unterbefehl gibt eine Beschreibung der Definition der Methode mit dem Namen *method* der Klasse *class* zurück. Die Definition wird als Liste mit zwei Elementen beschrieben: Das erste Element ist die Liste der Argumente der Methode in einer Form, die sich für die Übergabe an einen weiteren Aufruf von **proc** oder an eine Methodendefinition eignet, und das zweite Element ist der Rumpf der Methode.

[info]{.cmd} [class]{.sub} [definitionnamespace]{.lit} [class]{.arg} [kind]{.optarg}
: [Dieser Unterbefehl gibt den Definitions-Namespace für Definitionen der Art *kind* der Klasse *class* zurück; der Definitions-Namespace wirkt sich nur auf die Instanzen von *class* aus, nicht auf *class* selbst. *kind* kann entweder **-class** sein, um den Definitions-Namespace für [oo::define][define] zurückzugeben, oder **-instance**, um den Definitions-Namespace für [oo::objdefine][define] zurückzugeben; die Art **-class** ist die Vorgabe (was allerdings nur bei Klassen wirklich nützlich ist, die Unterklassen von [oo::class][class] sind).]{version="TIP524"}

    Stellt *class* keinen Definitions-Namespace der angegebenen Art bereit, gibt dieser Befehl die leere Zeichenkette zurück. In diesem Fall ermitteln die Befehle [oo::define][define] und [oo::objdefine][define] anhand der Vererbungshierarchie der Klassen, welcher Definitions-Namespace verwendet wird.

[info]{.cmd} [class]{.sub} [destructor]{.lit} [class]{.arg}
: Dieser Unterbefehl gibt den Rumpf des Destruktors der Klasse *class* zurück. Ist kein Destruktor vorhanden, gibt er die leere Zeichenkette zurück.

[info]{.cmd} [class]{.sub} [filters]{.lit} [class]{.arg}
: Dieser Unterbefehl gibt die Liste der Filtermethoden zurück, die auf der Klasse gesetzt sind.

[info]{.cmd} [class]{.sub} [forward]{.lit} [class]{.arg} [method]{.arg}
: Dieser Unterbefehl gibt die Argumentliste der Methodenweiterleitung mit dem Namen *method* zurück, die auf der Klasse mit dem Namen *class* gesetzt ist.

[info]{.cmd} [class]{.sub} [instances]{.lit} [class]{.arg} [pattern]{.optarg}
: Dieser Unterbefehl gibt eine Liste der Instanzen der Klasse *class* zurück. Ist das optionale Argument *pattern* angegeben, beschränkt es die Liste der zurückgegebenen Instanzen auf diejenigen, die gemäß den Regeln von [string match][string] darauf passen.

[info]{.cmd} [class]{.sub} [methods]{.lit} [class]{.arg} [options...]{.optarg}
: Dieser Unterbefehl gibt eine Liste aller öffentlichen (d. h. exportierten) Methoden der Klasse mit dem Namen *class* zurück. Jede der folgenden *option*s kann angegeben werden; sie legen genau fest, welche Methodennamen zurückgegeben werden:

    [-all]{.lit}
    : Ist der Schalter **-all** angegeben [und der Schalter **-scope** nicht angegeben]{version="TIP500"}, enthält die Liste der Methoden nicht nur die von der Klasse definierten Methoden, sondern auch die von den Oberklassen und Mixins der Klasse definierten.

    [-private]{.lit}
    : Ist der Schalter **-private** angegeben [und der Schalter **-scope** nicht angegeben]{version="TIP500"}, enthält die Liste der Methoden auch die nicht exportierten Methoden der Klasse (sowie der Oberklassen und Mixins, wenn auch **-all** angegeben ist). [Beachten Sie, dass diese Benennung unglücklicherweise mit echten privaten Methoden kollidiert; der Optionsname wird aus Gründen der Abwärtskompatibilität beibehalten.]{version="TIP500"}

    [-scope]{.lit} [scope]{.arg}
    : [Gibt eine Liste aller Methoden von *class* zurück, welche die angegebene Sichtbarkeit *scope* haben. Wird diese Option angegeben, werden die Optionen **-all** und **-private** beide ignoriert. Gültige Werte für *scope* sind:]{version="TIP500"}

        [**public**]{version="TIP500"}
        : [Es werden nur Methoden mit der Sichtbarkeit *public* zurückgegeben (d. h. solche, die von überall aus von jeder Instanz dieser Klasse aufgerufen werden können).]{version="TIP500"}

        [**unexported**]{version="TIP500"}
        : [Es werden nur Methoden mit der Sichtbarkeit *unexported* zurückgegeben (d. h. solche, die nur über [my] aufgerufen werden können).]{version="TIP500"}

        [**private**]{version="TIP500"}
        : [Es werden nur Methoden mit der Sichtbarkeit *private* zurückgegeben (d. h. solche, die nur aus den Methoden dieser Klasse heraus aufgerufen werden können).]{version="TIP500"}



[info]{.cmd} [class]{.sub} [methodtype]{.lit} [class]{.arg} [method]{.arg}
: Dieser Unterbefehl gibt eine Beschreibung der Art der Implementierung zurück, die für die Methode mit dem Namen *method* der Klasse *class* verwendet wird. Ist das Ergebnis **method**, lassen sich mit **info class definition** weitere Informationen ermitteln; ist das Ergebnis **forward**, lassen sich mit **info class forward** weitere Informationen ermitteln.

[info]{.cmd} [class]{.sub} [mixins]{.lit} [class]{.arg}
: Dieser Unterbefehl gibt eine Liste aller Klassen zurück, die in die Klasse mit dem Namen *class* eingemischt wurden.

[info]{.cmd} [class]{.sub} [properties]{.lit} [class]{.arg} [options...]{.optarg}
: [Dieser Unterbefehl gibt eine sortierte Liste der Eigenschaften zurück, die auf der Klasse mit dem Namen *class* definiert sind. Die *options* legen genau fest, welche Eigenschaften zurückgegeben werden:]{version="TIP558"}

    [-all]{.lit}
    : [Mit dieser Option werden auch die Eigenschaften der Oberklassen und Mixins der Klasse zurückgegeben.]{version="TIP558"}

    [-readable]{.lit}
    : [Diese Option (das Standardverhalten) fordert die lesbaren Eigenschaften an. Es werden nur lesbare oder nur schreibbare Eigenschaften zurückgegeben, nicht beide.]{version="TIP558"}

    [-writable]{.lit}
    : [Diese Option fordert die schreibbaren Eigenschaften an. Es werden nur lesbare oder nur schreibbare Eigenschaften zurückgegeben, nicht beide.]{version="TIP558"}


[info]{.cmd} [class]{.sub} [subclasses]{.lit} [class]{.arg} [pattern]{.optarg}
: Dieser Unterbefehl gibt eine Liste der direkten Unterklassen der Klasse *class* zurück. Ist das optionale Argument *pattern* angegeben, beschränkt es die Liste der zurückgegebenen Klassen auf diejenigen, die gemäß den Regeln von [string match][string] darauf passen.

[info]{.cmd} [class]{.sub} [superclasses]{.lit} [class]{.arg}
: Dieser Unterbefehl gibt eine Liste der direkten Oberklassen der Klasse *class* in der Reihenfolge des Vererbungsvorrangs zurück.

[info]{.cmd} [class]{.sub} [variables]{.lit} [class]{.arg} [-private]{.optlit}
: Dieser Unterbefehl gibt eine Liste aller Variablen zurück, die für die Klasse mit dem Namen *class* deklariert wurden (d. h. die in den Methoden, im Konstruktor und im Destruktor der Klasse automatisch vorhanden sind). [Ist die Option **-private** angegeben, listet er stattdessen die deklarierten privaten Variablen auf.]{version="TIP500"}


## Objekt-Introspection

Die folgenden *subcommand*-Werte werden von **info object** unterstützt:

[info]{.cmd} [object]{.sub} [call]{.lit} [object]{.arg} [method]{.arg}
: Gibt eine Beschreibung der Methodenimplementierungen zurück, mit denen *object* die Methode *method* implementiert. Das ist eine Liste von Listen mit je vier Elementen. Jede Teilliste besteht aus einem Wort, das die allgemeine Art der Methodenimplementierung beschreibt (**method** für eine gewöhnliche Methode, **filter** für einen angewendeten Filter, [**private** für eine private Methode,]{version="TIP500"} und [unknown] für eine Methode, die bei der Behandlung unbekannter Methoden aufgerufen wird), einem Wort mit dem Namen der jeweils aufgerufenen Methode (bei der Art **method** immer gleich *method*, bei der Art [unknown] „[unknown]“), einem Wort, das angibt, was die Methode definiert hat (der vollqualifizierte Name der Klasse oder die wörtliche Zeichenkette **object**, wenn die Methodenimplementierung an einer Instanz liegt), und einem Wort, das die Art der Methodenimplementierung beschreibt (siehe **info object methodtype**).

    Beachten Sie, dass nicht geprüft wird, ob die Methodenimplementierungen tatsächlich [next] verwenden, um die Kontrolle entlang der Aufrufkette weiterzugeben, [und dass die Aufrufketten, die dieser Befehl liefert, tatsächlich keine privaten Methoden enthalten.]{version="TIP500"}

[info]{.cmd} [object]{.sub} [class]{.lit} [object]{.arg} [className]{.optarg}
: Ist *className* nicht angegeben, gibt dieser Unterbefehl die Klasse des Objekts *object* zurück. Ist *className* angegeben, gibt dieser Unterbefehl einen booleschen Wert zurück, der angibt, ob *object* zu dieser Klasse gehört.

[info]{.cmd} [object]{.sub} [creationid]{.lit} [object]{.arg}
: [Gibt die eindeutige Erstellungskennung des Objekts *object* zurück. Diese Erstellungskennung ist für das Objekt (innerhalb eines Tcl-Interpreters) eindeutig und lässt sich weder beim Erzeugen des Objekts steuern noch nachträglich ändern.]{version="TIP500"}

    *Implementierungshinweis:* Die Erstellungskennung wird verwendet, um eindeutige Bezeichner zu erzeugen, die dem Objekt zugeordnet sind, insbesondere für private Variablen.

[info]{.cmd} [object]{.sub} [definition]{.lit} [object]{.arg} [method]{.arg}
: Dieser Unterbefehl gibt eine Beschreibung der Definition der Methode mit dem Namen *method* des Objekts *object* zurück. Die Definition wird als Liste mit zwei Elementen beschrieben: Das erste Element ist die Liste der Argumente der Methode in einer Form, die sich für die Übergabe an einen weiteren Aufruf von **proc** oder an eine Methodendefinition eignet, und das zweite Element ist der Rumpf der Methode.

[info]{.cmd} [object]{.sub} [filters]{.lit} [object]{.arg}
: Dieser Unterbefehl gibt die Liste der Filtermethoden zurück, die auf dem Objekt gesetzt sind.

[info]{.cmd} [object]{.sub} [forward]{.lit} [object]{.arg} [method]{.arg}
: Dieser Unterbefehl gibt die Argumentliste der Methodenweiterleitung mit dem Namen *method* zurück, die auf dem Objekt mit dem Namen *object* gesetzt ist.

[info]{.cmd} [object]{.sub} [isa]{.lit} [category]{.arg} [object]{.arg} [arg]{.optarg}
: Dieser Unterbefehl prüft, ob ein Objekt zu einer bestimmten Kategorie gehört, und gibt einen booleschen Wert zurück, der angibt, ob das Argument *object* die Kriterien der Kategorie erfüllt. Die unterstützten Kategorien sind:

    [info]{.cmd} [object]{.sub} [isa]{.lit} [class]{.lit} [object]{.arg}
    : Gibt zurück, ob *object* eine Klasse ist (d. h. eine Instanz von [oo::class][class] oder einer ihrer Unterklassen).

    [info]{.cmd} [object]{.sub} [isa]{.lit} [metaclass]{.lit} [object]{.arg}
    : Gibt zurück, ob *object* eine Klasse ist, die Klassen erzeugen kann (d. h. ob es [oo::class][class] oder eine Unterklasse davon ist).

    [info]{.cmd} [object]{.sub} [isa]{.lit} [mixin]{.lit} [object]{.arg} [class]{.arg}
    : Gibt zurück, ob *class* direkt in *object* eingemischt ist.

    [info]{.cmd} [object]{.sub} [isa]{.lit} [object]{.lit} [object]{.arg}
    : Gibt zurück, ob *object* wirklich ein Objekt ist.

    [info]{.cmd} [object]{.sub} [isa]{.lit} [typeof]{.lit} [object]{.arg} [class]{.arg}
    : Gibt zurück, ob *class* der Typ von *object* ist (d. h. ob *object* eine Instanz von *class* oder einer ihrer Unterklassen ist, direkt oder indirekt).


[info]{.cmd} [object]{.sub} [methods]{.lit} [object]{.arg} [option...]{.optarg}
: Dieser Unterbefehl gibt eine Liste aller öffentlichen (d. h. exportierten) Methoden des Objekts mit dem Namen *object* zurück. Jede der folgenden *option*s kann angegeben werden; sie legen genau fest, welche Methodennamen zurückgegeben werden:

    [-all]{.lit}
    : Ist der Schalter **-all** angegeben [und der Schalter **-scope** nicht angegeben]{version="TIP500"}, enthält die Liste der Methoden nicht nur die vom Objekt definierten Methoden, sondern auch die von der Klasse und den Mixins des Objekts definierten sowie die der Oberklassen dieser Klassen.

    [-private]{.lit}
    : Ist der Schalter **-private** angegeben [und der Schalter **-scope** nicht angegeben]{version="TIP500"}, enthält die Liste der Methoden auch die nicht exportierten Methoden des Objekts (sowie der Klassen, wenn auch **-all** angegeben ist). [Beachten Sie, dass diese Benennung unglücklicherweise mit echten privaten Methoden kollidiert; der Optionsname wird aus Gründen der Abwärtskompatibilität beibehalten.]{version="TIP500"}

    [-scope]{.lit} [scope]{.arg}
    : [Gibt eine Liste aller Methoden von *object* zurück, welche die angegebene Sichtbarkeit *scope* haben. Wird diese Option angegeben, werden die Optionen **-all** und **-private** beide ignoriert. Gültige Werte für *scope* sind:]{version="TIP500"}

        [**public**]{version="TIP500"}
        : [Es werden nur Methoden mit der Sichtbarkeit *public* zurückgegeben (d. h. solche, die von überall aus aufgerufen werden können).]{version="TIP500"}

        [**unexported**]{version="TIP500"}
        : [Es werden nur Methoden mit der Sichtbarkeit *unexported* zurückgegeben (d. h. solche, die nur über [my] aufgerufen werden können).]{version="TIP500"}

        [**private**]{version="TIP500"}
        : [Es werden nur Methoden mit der Sichtbarkeit *private* zurückgegeben (d. h. solche, die nur aus den Instanzmethoden dieses Objekts heraus aufgerufen werden können).]{version="TIP500"}



[info]{.cmd} [object]{.sub} [methodtype]{.lit} [object]{.arg} [method]{.arg}
: Dieser Unterbefehl gibt eine Beschreibung der Art der Implementierung zurück, die für die Methode mit dem Namen *method* des Objekts *object* verwendet wird. Ist das Ergebnis **method**, lassen sich mit **info object definition** weitere Informationen ermitteln; ist das Ergebnis **forward**, lassen sich mit **info object forward** weitere Informationen ermitteln.

[info]{.cmd} [object]{.sub} [mixins]{.lit} [object]{.arg}
: Dieser Unterbefehl gibt eine Liste aller Klassen zurück, die in das Objekt mit dem Namen *object* eingemischt wurden.

[info]{.cmd} [object]{.sub} [namespace]{.lit} [object]{.arg}
: Dieser Unterbefehl gibt den Namen des internen Namespace des Objekts mit dem Namen *object* zurück.

[info]{.cmd} [object]{.sub} [properties]{.lit} [object]{.arg} [options...]{.optarg}
: [Dieser Unterbefehl gibt eine sortierte Liste der Eigenschaften zurück, die auf dem Objekt mit dem Namen *object* definiert sind. Die *options* legen genau fest, welche Eigenschaften zurückgegeben werden:]{version="TIP558"}

    [-all]{.lit}
    : [Mit dieser Option werden auch die Eigenschaften der Klasse, der Oberklassen und der Mixins des Objekts zurückgegeben.]{version="TIP558"}

    [-readable]{.lit}
    : [Diese Option (das Standardverhalten) fordert die lesbaren Eigenschaften an. Es werden nur lesbare oder nur schreibbare Eigenschaften zurückgegeben, nicht beide.]{version="TIP558"}

    [-writable]{.lit}
    : [Diese Option fordert die schreibbaren Eigenschaften an. Es werden nur lesbare oder nur schreibbare Eigenschaften zurückgegeben, nicht beide.]{version="TIP558"}


[info]{.cmd} [object]{.sub} [variables]{.lit} [object]{.arg} [-private]{.optlit}
: Dieser Unterbefehl gibt eine Liste aller Variablen zurück, die für das Objekt mit dem Namen *object* deklariert wurden (d. h. die in den Methoden des Objekts automatisch vorhanden sind). [Ist die Option **-private** angegeben, listet er stattdessen die deklarierten privaten Variablen auf.]{version="TIP500"}

[info]{.cmd} [object]{.sub} [vars]{.lit} [object]{.arg} [pattern]{.optarg}
: Dieser Unterbefehl gibt eine Liste aller Variablen im privaten Namespace des Objekts mit dem Namen *object* zurück. Ist das optionale Argument *pattern* angegeben, ist es ein Filter (in der Syntax eines Glob-Musters von [string match][string]), der die Liste der zurückgegebenen Variablen einschränkt. Beachten Sie, dass sich diese Liste von der Liste unterscheidet, die **info object variables** zurückgibt: Jene kann Variablen enthalten, die derzeit nicht gesetzt sind, während diese Variablen enthalten kann, die von keiner der Methoden von *object* (oder denen seiner Klasse, Oberklassen oder Mixins) automatisch eingebunden werden.


# Beispiele

Dieser Befehl gibt eine Prozedur in einer Form aus, die sich zum Speichern in einem Tcl-Skript eignet:

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

Jedes Objekt kennt notwendigerweise seine Klasse; diese Information lässt sich durch Introspektion ganz einfach ermitteln:

```
oo::class create c
c create o
puts [info object class o]
                     → prints "::c"
puts [info object class c]
                     → prints "::oo::class"
```

Mit den Möglichkeiten der Introspektion lässt sich herausfinden, welche Klasse eine Methode implementiert und wie sie definiert ist. Diese Prozedur zeigt, wie das geht:

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

Dies ist ein alternativer Weg, die Definition nachzuschlagen; er durchsucht von Hand die Liste der Methoden entlang des Vererbungsbaums nach oben. Dieser Code geht davon aus, dass nur Einfachvererbung verwendet wird und dass eingemischte Klassen nicht auf komplexe Weise genutzt werden (in solchen Fällen ist **info object call** wie oben bei Weitem der einfachste Weg):

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
