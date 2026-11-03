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

Dieser Befehl liefert Informationen über verschiedene Interna des Tcl-Interpreters. Die zulässigen *option*-Argumente (die abgekürzt werden dürfen) sind:

**info args** *procname*
: Gibt eine Liste zurück, die der Reihe nach die Namen der Argumente der Prozedur *procname* enthält. *Procname* muss der Name einer Tcl-Befehlsprozedur sein.

**info body** *procname*
: Gibt den Rumpf der Prozedur *procname* zurück. *Procname* muss der Name einer Tcl-Befehlsprozedur sein.

**info class** *subcommand class* ?*arg ...*
: [Gibt Informationen über die Klasse *class* zurück. Die *subcommand*-Argumente sind unter [Klassen-Introspection] unten beschrieben.]{version="8.6"}

**info cmdcount**
: Gibt die Gesamtzahl der in diesem Interpreter aufgerufenen Befehle zurück.

**info commands** ?*pattern*?
: Ist *pattern* nicht angegeben, gibt der Befehl eine Liste der Namen aller Tcl-Befehle zurück, die im aktuellen Namespace sichtbar sind (d. h. ohne qualifizierten Namen ausführbar). Dazu gehören sowohl die in C geschriebenen eingebauten Befehle als auch die mit dem Befehl **proc** definierten Befehlsprozeduren. Ist *pattern* angegeben, werden nur die Namen zurückgegeben, die *pattern* entsprechen. Der Abgleich folgt denselben Regeln wie bei [string match][string]. *pattern* kann ein qualifizierter Name wie **Foo::print\*** sein. Das heißt, es kann mit einer Folge von Namespace-Namen, die durch doppelte Doppelpunkte (**::**) getrennt sind, einen bestimmten Namespace angeben und am Ende Sonderzeichen für den Musterabgleich enthalten, um eine Menge von Befehlen in diesem Namespace auszuwählen. Ist *pattern* ein qualifizierter Name, ist in der zurückgegebenen Liste jeder Befehlsname mit dem Namen des angegebenen Namespace qualifiziert, und es werden nur die Befehle zurückgegeben, die im genannten Namespace definiert sind.

**info complete** *command*
: Gibt **1** zurück, wenn *command* ein vollständiger Tcl-Befehl ist, d. h. keine nicht geschlossenen Anführungszeichen, geschweiften Klammern, eckigen Klammern oder Array-Elementnamen enthält. Scheint der Befehl nicht vollständig zu sein, wird **0** zurückgegeben. Dieser Befehl wird typischerweise in zeilenorientierten Eingabeumgebungen verwendet, damit Benutzer Befehle eingeben können, die sich über mehrere Zeilen erstrecken. Ist der Befehl nicht vollständig, kann das Skript seine Auswertung aufschieben, bis weitere Zeilen eingegeben wurden, die den Befehl vervollständigen.

**info coroutine**
: [Gibt den Namen der gerade ausgeführten **coroutine** zurück oder die leere Zeichenkette, wenn entweder gerade keine Coroutine ausgeführt wird oder die aktuelle Coroutine gelöscht wurde (seit dem Löschen aber noch nicht zurückgekehrt ist und auch kein yield ausgeführt hat).]{version="8.6"}

**info default** *procname arg varname*
: *Procname* muss der Name einer Tcl-Befehlsprozedur sein und *arg* der Name eines Arguments dieser Prozedur. Hat *arg* keinen Standardwert, gibt der Befehl **0** zurück. Andernfalls gibt er **1** zurück und legt den Standardwert von *arg* in der Variable *varname* ab.

**info errorstack** ?*interp*?
: [Gibt in einer Form, die sich programmatisch leicht auswerten lässt, die Funktionsnamen und Argumente jeder Ebene des Aufrufstacks des letzten Fehlers im angegebenen *interp* zurück oder, falls *interp* nicht angegeben ist, im aktuellen Interpreter.]{version="8.6"}

    Diese Form ist eine Liste gerader Länge, in der sich Token und Parameter abwechseln. Token sind derzeit entweder **CALL**, **UP** oder **INNER**, doch künftig können weitere Werte hinzukommen. **CALL** kennzeichnet einen Prozeduraufruf; sein Parameter ist das entsprechende **info level** **0**. **UP** kennzeichnet einen Wechsel der Variablen-Frames, der durch [uplevel] oder Ähnliches entsteht, und bezieht sich auf das vorherige **CALL**-Element. Sein Parameter ist der Ebenenversatz. **INNER** bezeichnet den „inneren Kontext“. Das ist der innerste atomare Befehl oder die innerste Bytecode-Instruktion, die den Fehler ausgelöst hat, samt ihren Argumenten, sofern verfügbar. Während **CALL** und **UP** es ermöglichen, komplexen Aufrufpfaden zu folgen, zielt **INNER** genau auf die fehlerhafte Operation im innersten Prozeduraufruf, sogar bis auf die Ebene von Teilausdrücken.

    Diese Information ist auch im Eintrag **-errorstack** des Options-Dictionarys enthalten, das [catch] mit drei Argumenten zurückgibt; **info errorstack** ist ein bequemer Weg, sie bei nicht abgefangenen Fehlern auf oberster Ebene in einer interaktiven [tclsh] abzurufen.

**info exists** *varName*
: Gibt **1** zurück, wenn die Variable mit dem Namen *varName* im aktuellen Kontext (entweder als globale oder als lokale Variable) existiert und definiert wurde, indem ihr ein Wert zugewiesen wurde; andernfalls gibt der Befehl **0** zurück.

**info frame** ?*number*?
: Dieser Befehl bietet Zugriff auf alle Frames des Stacks, auch auf diejenigen, die vor **info level** verborgen sind. Ist *number* nicht angegeben, gibt der Befehl eine Zahl zurück, die die Frame-Ebene des Befehls angibt. Sie ist 1, wenn der Befehl auf oberster Ebene aufgerufen wird. Ist *number* angegeben, ist das Ergebnis ein Dictionary mit den Positionsinformationen für den Befehl auf der Stack-Ebene *number*.

    Ist *number* positiv (> 0), wählt es eine bestimmte Stack-Ebene aus (1 bezeichnet den äußersten aktiven Befehl, 2 den Befehl, den dieser aufgerufen hat, und so weiter bis zur aktuellen Frame-Ebene, die **info frame** selbst bezeichnet). Andernfalls gibt es eine Ebene relativ zum aktuellen Befehl an (0 bezeichnet den aktuellen Befehl, d. h. **info frame** selbst, -1 seinen Aufrufer und so weiter).

    Das entspricht der Arbeitsweise von **info level**, nur meldet dieser Unterbefehl alle Frames, etwa mittels [source] eingelesene Skripte, Aufrufe von [eval] und [uplevel] usw.

    Beachten Sie, dass bei verschachtelten Befehlen wie „foo \[bar \[x\]\]“ ein innerhalb von „x“ aufgerufenes **info frame** nur „x“ sieht. Das ist genauso wie bei **info level** und bei Fehler-Stack-Traces.

    Das Ergebnis-Dictionary kann die unten aufgeführten Schlüssel enthalten; ihre Werte haben die jeweils angegebene Bedeutung:

    **type**
    : Dieser Eintrag ist immer vorhanden und beschreibt die Art der Position des Befehls. Die erkannten Werte sind [source], **proc**, **eval** und **precompiled**.

        [source]
        : Bedeutet, dass der Befehl in einem Skript steht, das mit dem Befehl [source] geladen wurde.

        **proc**
        : Bedeutet, dass der Befehl in einem dynamisch erzeugten Prozedurrumpf steht.

        [eval]
        : Bedeutet, dass der Befehl von [eval] oder [uplevel] ausgeführt wird.

        **precompiled**
        : Bedeutet, dass der Befehl in einem vorkompilierten Skript steht (das mit dem Paket **tbcload** geladen werden kann) und dass keine weiteren Informationen verfügbar sind.


    **line**
    : Dieser Eintrag liefert die Nummer der Zeile, in der der Befehl innerhalb des Skripts steht, zu dem er gehört. Für den Typ **precompiled** ist diese Information nicht vorhanden. Beim Typ [source] wird sie relativ zum Anfang der Datei gezählt, bei den letzten beiden Typen dagegen relativ zum Anfang des Skripts.

    [file]
    : Dieser Eintrag ist nur beim Typ [source] vorhanden. Er liefert den normalisierten Pfad der Datei, in der der Befehl steht.

    **cmd**
    : Dieser Eintrag liefert die Zeichenkettendarstellung des Befehls. Das ist normalerweise die Form ohne Ersetzungen. Bei Befehlen, die eine kanonisch aufgebaute Liste sind (z. B. vom Befehl [list] erzeugt) und von [eval] ausgeführt werden, ist es jedoch die Form nach den Ersetzungen, da sie keine andere Zeichenkettendarstellung haben. Dabei wird darauf geachtet, dass die Kanonizität einer solchen Liste nicht verloren geht.

    **proc**
    : Dieser Eintrag ist nur vorhanden, wenn der Befehl im Rumpf einer regulären Tcl-Prozedur steht. Er liefert dann den Namen dieser Prozedur.

    **lambda**
    : Dieser Eintrag ist nur vorhanden, wenn der Befehl im Rumpf einer anonymen Tcl-Prozedur, d. h. eines Lambdas, steht. Er liefert dann die vollständige Definition dieses Lambdas.

    **level**
    : Dieser Eintrag ist nur vorhanden, wenn es zum abgefragten Frame einen entsprechenden Frame gibt, den **info level** zurückgibt. Er liefert den Index dieses Frames relativ zur aktuellen Ebene (0 und negative Zahlen).


    Bemerkenswert ist, dass bei Prozeduren, die statisch in Dateien definiert sind, die Positionen der Befehle in ihren Rümpfen mit dem Typ [source] und absoluten Zeilennummern gemeldet werden und nicht mit dem Typ **proc**. Dasselbe gilt für Prozeduren, die in statisch definierten Prozeduren verschachtelt sind, und für wörtliche eval-Skripte in Dateien oder in statisch definierten Prozeduren.

    Im Gegensatz dazu zählen Prozedurdefinitionen und [eval] innerhalb einer dynamisch mit [eval] ausgewerteten Umgebung die Zeilennummern relativ zum Anfang ihres Skripts, selbst wenn sie relativ zum Anfang des äußeren dynamischen Skripts zählen könnten. Diese Art der Nummerierung ist meist sinnvoller.

    Anders beschrieben: Dateibasierte Positionen werden so tief wie möglich verfolgt. Wo das nicht möglich ist, werden die Zeilen relativ zum kleinstmöglichen [eval]- oder Prozedurrumpf gezählt, da dieser Gültigkeitsbereich meist leichter zu finden ist als ein dynamischer äußerer Gültigkeitsbereich.

    Die syntaktische Form **{\*}** wird wie [eval] behandelt. Das heißt: Erhält sie ein wörtliches Listenargument, verfolgt das System auch die Zeilennummer innerhalb der Listenwörter; andernfalls werden alle Zeilennummern relativ zum Anfang jedes Worts gezählt (kleinster Gültigkeitsbereich).

**info functions** ?*pattern*?
: Ist *pattern* nicht angegeben, gibt der Befehl eine Liste aller derzeit definierten mathematischen Funktionen zurück. Ist *pattern* angegeben, werden nur die Funktionen zurückgegeben, deren Name *pattern* entspricht. Der Abgleich folgt denselben Regeln wie bei [string match][string].

**info globals** ?*pattern*?
: Ist *pattern* nicht angegeben, gibt der Befehl eine Liste aller Namen der derzeit definierten globalen Variablen zurück. Globale Variablen sind Variablen im globalen Namespace. Ist *pattern* angegeben, werden nur die Namen zurückgegeben, die *pattern* entsprechen. Der Abgleich folgt denselben Regeln wie bei [string match][string].

**info hostname**
: Gibt den Namen des Rechners zurück, auf dem dieser Aufruf ausgeführt wird. Beachten Sie, dass nicht garantiert ist, dass dieser Name der vollqualifizierte Domainname des Rechners ist. Haben Rechner mehrere verschiedene Namen (wie es auf Systemen mit installiertem TCP/IP (DNS) und NetBIOS-basiertem Netzwerk üblich ist), wird der Name zurückgegeben, der für TCP/IP-Netzwerke geeignet ist.

**info level** ?*number*?
: Ist *number* nicht angegeben, gibt der Befehl eine Zahl zurück, die die Stack-Ebene der aufrufenden Prozedur angibt, oder 0, wenn der Befehl auf oberster Ebene aufgerufen wird. Ist *number* angegeben, ist das Ergebnis eine Liste aus dem Namen und den Argumenten des Prozeduraufrufs auf der Stack-Ebene *number*. Ist *number* positiv, wählt es eine bestimmte Stack-Ebene aus (1 bezeichnet die oberste aktive Prozedur, 2 die Prozedur, die diese aufgerufen hat, und so weiter); andernfalls gibt es eine Ebene relativ zur aktuellen Ebene an (0 bezeichnet die aktuelle Prozedur, -1 ihren Aufrufer und so weiter). Weitere Informationen zur Bedeutung der Stack-Ebenen finden Sie beim Befehl [uplevel].

**info library**
: Gibt den Namen des Bibliotheksverzeichnisses zurück, in dem die Standard-Tcl-Skripte gespeichert sind. Das ist tatsächlich der Wert der Variable [tcl\_library][tclvars]; er kann durch Setzen von [tcl\_library][tclvars] geändert werden.

**info loaded** ?*interp*?
: Gibt eine Liste zurück, die alle Pakete beschreibt, die mit dem Befehl [load] in *interp* geladen wurden. Jedes Listenelement ist eine Teilliste mit zwei Elementen: dem Namen der Datei, aus der das Paket geladen wurde, und dem Namen des Pakets. Bei statisch geladenen Paketen ist der Dateiname eine leere Zeichenkette. Ist *interp* weggelassen, werden Informationen zu allen Paketen zurückgegeben, die in irgendeinem Interpreter des Prozesses geladen wurden. Um eine Liste nur der Pakete im aktuellen Interpreter zu erhalten, geben Sie für das Argument *interp* eine leere Zeichenkette an.

**info locals** ?*pattern*?
: Ist *pattern* nicht angegeben, gibt der Befehl eine Liste aller Namen der derzeit definierten lokalen Variablen zurück, einschließlich der Argumente der aktuellen Prozedur, falls vorhanden. Variablen, die mit den Befehlen [global], [upvar] und [variable] definiert wurden, werden nicht zurückgegeben. Ist *pattern* angegeben, werden nur die Namen zurückgegeben, die *pattern* entsprechen. Der Abgleich folgt denselben Regeln wie bei [string match][string].

**info nameofexecutable**
: Gibt den vollständigen Pfadnamen der Binärdatei zurück, aus der die Anwendung aufgerufen wurde. Konnte Tcl die Datei nicht ermitteln, wird eine leere Zeichenkette zurückgegeben.

**info object** *subcommand object* ?*arg ...*
: [Gibt Informationen über das Objekt *object* zurück. Die *subcommand*-Argumente sind unter [Objekt-Introspection] unten beschrieben.]{version="8.6"}

**info patchlevel**
: Gibt den Wert der globalen Variable [tcl\_patchLevel][tclvars] zurück, die standardmäßig die genaue Version der Tcl-Bibliothek enthält.

**info procs** ?*pattern*?
: Ist *pattern* nicht angegeben, gibt der Befehl eine Liste aller Namen von Tcl-Befehlsprozeduren im aktuellen Namespace zurück. Ist *pattern* angegeben, werden nur die Prozedurnamen im aktuellen Namespace zurückgegeben, die *pattern* entsprechen. Der Abgleich folgt denselben Regeln wie bei [string match][string]. Enthält *pattern* Namespace-Trenner, wählen diese den Namespace aus, in dem gesucht wird, und zwar relativ zum aktuellen Namespace (oder relativ zum globalen Namespace, wenn *pattern* mit **::** beginnt); als Suchmuster gilt der Teil nach dem letzten Namespace-Trenner.

**info script** ?*filename*?
: Wird gerade eine Tcl-Skriptdatei ausgewertet (d. h. ist ein Aufruf von [Tcl\_EvalFile][Eval] aktiv oder gibt es einen aktiven Aufruf des Befehls [source]), gibt dieser Befehl den Namen der innersten Datei zurück, die gerade verarbeitet wird. Ist *filename* angegeben, wird der Rückgabewert dieses Befehls für die Dauer des aktiven Aufrufs so geändert, dass er diesen Namen zurückgibt. Das ist in Anwendungen mit virtuellen Dateisystemen nützlich. Andernfalls gibt der Befehl eine leere Zeichenkette zurück.

**info sharedlibextension**
: Gibt die Erweiterung zurück, die auf dieser Plattform für die Namen von Dateien mit gemeinsam genutzten Bibliotheken verwendet wird (zum Beispiel **.so** unter Solaris). Werden gemeinsam genutzte Bibliotheken auf dieser Plattform nicht unterstützt, wird eine leere Zeichenkette zurückgegeben.

**info tclversion**
: Gibt den Wert der globalen Variable [tcl\_version][tclvars] zurück, die standardmäßig die Haupt- und Nebenversion der Tcl-Bibliothek enthält.

**info vars** ?*pattern*?
: Ist *pattern* nicht angegeben, gibt der Befehl eine Liste aller Namen der derzeit sichtbaren Variablen zurück. Dazu gehören lokale Variablen und derzeit sichtbare globale Variablen. Ist *pattern* angegeben, werden nur die Namen zurückgegeben, die *pattern* entsprechen. Der Abgleich folgt denselben Regeln wie bei [string match][string]. *pattern* kann ein qualifizierter Name wie **Foo::option\*** sein. Das heißt, es kann mit einer Folge von Namespace-Namen, die durch doppelte Doppelpunkte (**::**) getrennt sind, einen bestimmten Namespace angeben und am Ende Sonderzeichen für den Musterabgleich enthalten, um eine Menge von Variablen in diesem Namespace auszuwählen. Ist *pattern* ein qualifizierter Name, ist in der zurückgegebenen Liste jede passende Namespace-Variable mit dem Namen ihres Namespace qualifiziert. Beachten Sie, dass eine derzeit sichtbare Variable möglicherweise noch nicht „existiert“, wenn sie nicht gesetzt wurde (z. B. eine Variable, die mit [variable] deklariert, aber nicht gesetzt wurde).


## Klassen-Introspection

Die folgenden *subcommand*-Werte werden von **info class** unterstützt:

**info class call** *class method*
: [Gibt eine Beschreibung der Methodenimplementierungen zurück, mit denen eine stereotype Instanz die Implementierung von *method* durch *class* erhält (stereotype Instanzen sind Objekte, die von einer Klasse instanziiert wurden, ohne dass objektspezifische Definitionen hinzugefügt wurden). Das ist eine Liste von Listen mit je vier Elementen. Jede Teilliste besteht aus einem Wort, das die allgemeine Art der Methodenimplementierung beschreibt (**method** für eine gewöhnliche Methode, **filter** für einen angewendeten Filter und [unknown] für eine Methode, die bei der Behandlung unbekannter Methoden aufgerufen wird), einem Wort mit dem Namen der jeweils aufgerufenen Methode (bei der Art **method** immer gleich *method*, bei der Art [unknown] „[unknown]“), einem Wort mit dem vollqualifizierten Namen der Klasse, die die Methode definiert hat, und einem Wort, das die Art der Methodenimplementierung beschreibt (siehe **info class methodtype**).]{version=""}

    Beachten Sie, dass nicht geprüft wird, ob die Methodenimplementierungen tatsächlich [next] verwenden, um die Kontrolle entlang der Aufrufkette weiterzugeben.

**info class constructor** *class*
: [Dieser Unterbefehl gibt eine Beschreibung der Definition des Konstruktors der Klasse *class* zurück. Die Definition wird als Liste mit zwei Elementen beschrieben: Das erste Element ist die Liste der Argumente des Konstruktors in einer Form, die sich für die Übergabe an einen weiteren Aufruf von **proc** oder an eine Methodendefinition eignet, und das zweite Element ist der Rumpf des Konstruktors. Ist kein Konstruktor vorhanden, gibt der Unterbefehl die leere Liste zurück.]{version="8.6"}

**info class definition** *class method*
: [Dieser Unterbefehl gibt eine Beschreibung der Definition der Methode mit dem Namen *method* der Klasse *class* zurück. Die Definition wird als Liste mit zwei Elementen beschrieben: Das erste Element ist die Liste der Argumente der Methode in einer Form, die sich für die Übergabe an einen weiteren Aufruf von **proc** oder an eine Methodendefinition eignet, und das zweite Element ist der Rumpf der Methode.]{version="8.6"}

**info class destructor** *class*
: [Dieser Unterbefehl gibt den Rumpf des Destruktors der Klasse *class* zurück. Ist kein Destruktor vorhanden, gibt er die leere Zeichenkette zurück.]{version="8.6"}

**info class filters** *class*
: [Dieser Unterbefehl gibt die Liste der Filtermethoden zurück, die auf der Klasse gesetzt sind.]{version="8.6"}

**info class forward** *class method*
: [Dieser Unterbefehl gibt die Argumentliste der Methodenweiterleitung mit dem Namen *method* zurück, die auf der Klasse mit dem Namen *class* gesetzt ist.]{version="8.6"}

**info class instances** *class* ?*pattern*?
: [Dieser Unterbefehl gibt eine Liste der Instanzen der Klasse *class* zurück. Ist das optionale Argument *pattern* angegeben, beschränkt es die Liste der zurückgegebenen Instanzen auf diejenigen, die gemäß den Regeln von [string match][string] darauf passen.]{version="8.6"}

**info class methods** *class* ?*options...*?
: [Dieser Unterbefehl gibt eine Liste aller öffentlichen (d. h. exportierten) Methoden der Klasse mit dem Namen *class* zurück. Jedes der folgenden *option*-Argumente kann angegeben werden; sie legen genau fest, welche Methodennamen zurückgegeben werden:]{version="8.6"}

    **-all**
    : [Ist der Schalter **-all** angegeben, enthält die Liste der Methoden nicht nur die von der Klasse definierten Methoden, sondern auch die von den Oberklassen und Mixins der Klasse definierten.]{version="8.6"}

    **-private**
    : [Ist der Schalter **-private** angegeben, enthält die Liste der Methoden auch die privaten (d. h. nicht exportierten) Methoden der Klasse (sowie der Oberklassen und Mixins, wenn auch **-all** angegeben ist).]{version="8.6"}


**info class methodtype** *class method*
: [Dieser Unterbefehl gibt eine Beschreibung der Art der Implementierung zurück, die für die Methode mit dem Namen *method* der Klasse *class* verwendet wird. Ist das Ergebnis **method**, lassen sich mit **info class definition** weitere Informationen ermitteln; ist das Ergebnis **forward**, lassen sich mit **info class forward** weitere Informationen ermitteln.]{version="8.6"}

**info class mixins** *class*
: [Dieser Unterbefehl gibt eine Liste aller Klassen zurück, die in die Klasse mit dem Namen *class* eingemischt wurden.]{version="8.6"}

**info class subclasses** *class* ?*pattern*?
: [Dieser Unterbefehl gibt eine Liste der direkten Unterklassen der Klasse *class* zurück. Ist das optionale Argument *pattern* angegeben, beschränkt es die Liste der zurückgegebenen Klassen auf diejenigen, die gemäß den Regeln von [string match][string] darauf passen.]{version="8.6"}

**info class superclasses** *class*
: [Dieser Unterbefehl gibt eine Liste der direkten Oberklassen der Klasse *class* in der Reihenfolge des Vererbungsvorrangs zurück.]{version="8.6"}

**info class variables** *class*
: [Dieser Unterbefehl gibt eine Liste aller Variablen zurück, die für die Klasse mit dem Namen *class* deklariert wurden (d. h. die in den Methoden, im Konstruktor und im Destruktor der Klasse automatisch vorhanden sind).]{version="8.6"}


## Objekt-Introspection

Die folgenden *subcommand*-Werte werden von **info object** unterstützt:

**info object call** *object method*
: [Gibt eine Beschreibung der Methodenimplementierungen zurück, mit denen *object* die Methode *method* implementiert. Das ist eine Liste von Listen mit je vier Elementen. Jede Teilliste besteht aus einem Wort, das die allgemeine Art der Methodenimplementierung beschreibt (**method** für eine gewöhnliche Methode, **filter** für einen angewendeten Filter und [unknown] für eine Methode, die bei der Behandlung unbekannter Methoden aufgerufen wird), einem Wort mit dem Namen der jeweils aufgerufenen Methode (bei der Art **method** immer gleich *method*, bei der Art [unknown] „[unknown]“), einem Wort, das angibt, was die Methode definiert hat (der vollqualifizierte Name der Klasse oder die wörtliche Zeichenkette **object**, wenn die Methodenimplementierung an einer Instanz liegt), und einem Wort, das die Art der Methodenimplementierung beschreibt (siehe **info object methodtype**).]{version="8.6"}

    Beachten Sie, dass nicht geprüft wird, ob die Methodenimplementierungen tatsächlich [next] verwenden, um die Kontrolle entlang der Aufrufkette weiterzugeben.

**info object class** *object* ?*className*?
: [Ist *className* nicht angegeben, gibt dieser Unterbefehl die Klasse des Objekts *object* zurück. Ist *className* angegeben, gibt dieser Unterbefehl einen booleschen Wert zurück, der angibt, ob *object* zu dieser Klasse gehört.]{version="8.6"}

**info object definition** *object method*
: [Dieser Unterbefehl gibt eine Beschreibung der Definition der Methode mit dem Namen *method* des Objekts *object* zurück. Die Definition wird als Liste mit zwei Elementen beschrieben: Das erste Element ist die Liste der Argumente der Methode in einer Form, die sich für die Übergabe an einen weiteren Aufruf von **proc** oder an eine Methodendefinition eignet, und das zweite Element ist der Rumpf der Methode.]{version="8.6"}

**info object filters** *object*
: [Dieser Unterbefehl gibt die Liste der Filtermethoden zurück, die auf dem Objekt gesetzt sind.]{version="8.6"}

**info object forward** *object method*
: [Dieser Unterbefehl gibt die Argumentliste der Methodenweiterleitung mit dem Namen *method* zurück, die auf dem Objekt mit dem Namen *object* gesetzt ist.]{version="8.6"}

**info object isa** *category object* ?*arg*?
: [Dieser Unterbefehl prüft, ob ein Objekt zu einer bestimmten Kategorie gehört, und gibt einen booleschen Wert zurück, der angibt, ob das Argument *object* die Kriterien der Kategorie erfüllt. Die unterstützten Kategorien sind:]{version="8.6"}

    **info object isa class** *object*
    : [Gibt zurück, ob *object* eine Klasse ist (d. h. eine Instanz von [oo::class][class] oder einer ihrer Unterklassen).]{version="8.6"}

    **info object isa metaclass** *object*
    : [Gibt zurück, ob *object* eine Klasse ist, die Klassen erzeugen kann (d. h. ob es [oo::class][class] oder eine Unterklasse davon ist).]{version="8.6"}

    **info object isa mixin** *object class*
    : [Gibt zurück, ob *class* direkt in *object* eingemischt ist.]{version="8.6"}

    **info object isa object** *object*
    : [Gibt zurück, ob *object* wirklich ein Objekt ist.]{version="8.6"}

    **info object isa typeof** *object class*
    : [Gibt zurück, ob *class* der Typ von *object* ist (d. h. ob *object* eine Instanz von *class* oder einer ihrer Unterklassen ist, direkt oder indirekt).]{version="8.6"}


**info object methods** *object* ?*option...*?
: [Dieser Unterbefehl gibt eine Liste aller öffentlichen (d. h. exportierten) Methoden des Objekts mit dem Namen *object* zurück. Jedes der folgenden *option*-Argumente kann angegeben werden; sie legen genau fest, welche Methodennamen zurückgegeben werden:]{version="8.6"}

    **-all**
    : [Ist der Schalter **-all** angegeben, enthält die Liste der Methoden nicht nur die vom Objekt definierten Methoden, sondern auch die von der Klasse und den Mixins des Objekts definierten sowie die der Oberklassen dieser Klassen.]{version="8.6"}

    **-private**
    : [Ist der Schalter **-private** angegeben, enthält die Liste der Methoden auch die privaten (d. h. nicht exportierten) Methoden des Objekts (sowie der Klassen, wenn auch **-all** angegeben ist).]{version="8.6"}


**info object methodtype** *object method*
: [Dieser Unterbefehl gibt eine Beschreibung der Art der Implementierung zurück, die für die Methode mit dem Namen *method* des Objekts *object* verwendet wird. Ist das Ergebnis **method**, lassen sich mit **info object definition** weitere Informationen ermitteln; ist das Ergebnis **forward**, lassen sich mit **info object forward** weitere Informationen ermitteln.]{version="8.6"}

**info object mixins** *object*
: [Dieser Unterbefehl gibt eine Liste aller Klassen zurück, die in das Objekt mit dem Namen *object* eingemischt wurden.]{version="8.6"}

**info object namespace** *object*
: [Dieser Unterbefehl gibt den Namen des internen Namespace des Objekts mit dem Namen *object* zurück.]{version="8.6"}

**info object variables** *object*
: [Dieser Unterbefehl gibt eine Liste aller Variablen zurück, die für das Objekt mit dem Namen *object* deklariert wurden (d. h. die in den Methoden des Objekts automatisch vorhanden sind).]{version="8.6"}

**info object vars** *object* ?*pattern*?
: [Dieser Unterbefehl gibt eine Liste aller Variablen im privaten Namespace des Objekts mit dem Namen *object* zurück. Ist das optionale Argument *pattern* angegeben, ist es ein Filter (in der Syntax eines Glob-Musters von [string match][string]), der die Liste der zurückgegebenen Variablen einschränkt. Beachten Sie, dass sich diese Liste von der Liste unterscheidet, die **info object variables** zurückgibt: Jene kann Variablen enthalten, die derzeit nicht gesetzt sind, während diese Variablen enthalten kann, die von keiner der Methoden von *object* (oder denen seiner Klasse, Oberklassen oder Mixins) automatisch eingebunden werden.]{version="8.6"}


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
        # Assume no forwards or filters, and hence no $calltype
        # or $methodtype checks...
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
        # Assume no forwards
        return [info object definition $obj $method]
    }
    set cls [info object class $obj]
    while {$method ni [info class methods $cls]} {
        # Assume the simple case
        set cls [lindex [info class superclass $cls] 0]
        if {$cls eq ""} {
            error "no definition for $method"
        }
    }
    # Assume no forwards
    return [info class definition $cls $method]
}
```


[catch]: catch.md
[class]: class.md
[Eval]: ../tcl-c/Eval.md
[eval]: eval.md
[file]: file.md
[global]: global.md
[list]: list.md
[load]: load.md
[next]: next.md
[source]: source.md
[string]: string.md
[tclsh]: tclsh.md
[tclvars]: tclvars.md
[unknown]: unknown.md
[uplevel]: uplevel.md
[upvar]: upvar.md
[variable]: variable.md
