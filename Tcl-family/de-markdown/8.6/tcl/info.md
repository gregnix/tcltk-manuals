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

Dieser Befehl liefert Informationen über verschiedene Interna des Tcl-Interpreters. Die zulässigen *option*s (abkürzbar) sind:

**info args** *procname*
: Gibt eine Liste mit den Namen der Argumente der Prozedur *procname* in Reihenfolge zurück. *Procname* muss der Name einer Tcl-Befehlsprozedur sein.

**info body** *procname*
: Gibt den Rumpf der Prozedur *procname* zurück. *Procname* muss der Name einer Tcl-Befehlsprozedur sein.

**info class** *subcommand class* ?*arg ...*
: [Gibt Informationen über die Klasse *class* zurück. Die *subcommand*s sind unter [Klassen-Introspection] unten beschrieben.]{version="8.6"}

**info cmdcount**
: Gibt die Gesamtzahl der in diesem Interpreter aufgerufenen Befehle zurück.

**info commands** ?*pattern*?
: Ohne *pattern* eine Liste aller Tcl-Befehlsnamen, die im aktuellen Namespace sichtbar sind (ohne qualifizierten Namen ausführbar), einschließlich in C geschriebener eingebauter Befehle und per **proc** definierter Befehlsprozeduren. Mit *pattern* nur passende Namen; Abgleich wie bei [string match][string]. *pattern* kann ein qualifizierter Name wie **Foo::print\*** sein — Namespace-Kette mit **::** und am Ende Glob-Sonderzeichen für Befehle in diesem Namespace. Bei qualifiziertem *pattern* ist jeder Befehlsname mit dem Namespace qualifiziert; zurückgegeben werden nur Befehle des genannten Namespace.

**info complete** *command*
: Gibt **1** zurück, wenn *command* ein vollständiger Tcl-Befehl ist (keine ungeschlossenen Anführungszeichen, Klammern, eckigen Klammern oder Array-Elementnamen). Sonst **0**. Typischerweise in zeilenorientierten Eingabeumgebungen, damit Benutzer mehrzeilige Befehle eingeben können; ist der Befehl unvollständig, kann das Skript die Auswertung verzögern, bis weitere Zeilen den Befehl vervollständigen.

**info coroutine**
: [Gibt den Namen der gerade ausführenden **coroutine** zurück oder die leere Zeichenkette, wenn keine Coroutine läuft oder die aktuelle Coroutine gelöscht wurde (aber seit dem Löschen noch nicht zurückgekehrt ist oder ein yield ausgeführt hat).]{version="8.6"}

**info default** *procname arg varname*
: *Procname* muss der Name einer Tcl-Befehlsprozedur sein und *arg* der Name eines Arguments dieser Prozedur. Hat *arg* keinen Standardwert, gibt der Befehl **0** zurück. Andernfalls gibt er **1** zurück und legt den Standardwert von *arg* in der Variable *varname* ab.

**info errorstack** ?*interp*?
: [Gibt in programmatisch leicht parsebarer Form die Funktionsnamen und Argumente jeder Ebene aus dem Aufrufstack des letzten Fehlers im angegebenen *interp* zurück, oder im aktuellen, falls nicht angegeben.]{version="8.6"}

    Die Form ist eine Liste gerader Länge aus abwechselnden Token und Parametern. Token sind derzeit **CALL**, **UP** oder **INNER**; weitere Werte können künftig eingeführt werden. **CALL** kennzeichnet einen Prozeduraufruf; der Parameter ist das entsprechende **info level** **0**. **UP** kennzeichnet einen durch [uplevel] oder Ähnliches erzeugten Wechsel der Variablenframes und bezieht sich auf das vorherige **CALL**-Element; der Parameter ist der Ebenenversatz. **INNER** bezeichnet den „inneren Kontext“ — den innersten atomaren Befehl oder Bytecode-Befehl, der den Fehler auslöste, samt Argumenten, sofern verfügbar. Während **CALL** und **UP** komplexe Aufrufpfade abbilden, fokussiert **INNER** die fehlerhafte Operation im innersten Prozeduraufruf, bis auf Subausdruck-Ebene.

    Diese Information steht auch im Eintrag **-errorstack** des Options-Dictionarys von [catch] mit drei Argumenten; **info errorstack** ist eine bequeme Möglichkeit, sie für nicht abgefangene Fehler auf oberster Ebene in einer interaktiven [tclsh] abzurufen.

**info exists** *varName*
: Gibt **1** zurück, wenn die Variable *varName* im aktuellen Kontext (global oder lokal) existiert und durch Zuweisung eines Werts definiert wurde, sonst **0**.

**info frame** ?*number*?
: Zugriff auf alle Frames des Stacks, auch die für **info level** verborgenen. Ohne *number* eine Zahl mit der Frame-Ebene des Befehls (**1** bei Aufruf auf oberster Ebene). Mit *number* ein Dictionary mit Positionsinformationen für den Befehl auf der *number*-ten Stack-Ebene.

    Ist *number* positiv (> 0), wählt es eine bestimmte Stack-Ebene (**1** = äußerster aktiver Befehl, **2** = von ihm aufgerufener Befehl usw. bis zur aktuellen Frame-Ebene, die **info frame** selbst bezeichnet); andernfalls eine Ebene relativ zum aktuellen Befehl (**0** = aktueller Befehl, also **info frame** selbst, **-1** = sein Aufrufer usw.).

    Ähnlich wie **info level**, meldet dieser Unterbefehl aber alle Frames, etwa per [source] geladene Skripte, [eval]s, [uplevel]s usw.

    Bei verschachtelten Befehlen wie „foo \[bar \[x\]\]“ sieht ein innerhalb von „x“ aufgerufenes **info frame** nur „x“ — wie bei **info level** und Fehler-Stack-Traces.

    Das Ergebnis-Dictionary kann folgende Schlüssel mit den angegebenen Bedeutungen enthalten:

    **type**
    : Immer vorhanden; beschreibt die Art der Befehlsposition. Erkannte Werte: [source], **proc**, **eval** und **precompiled**.

        [source]
        : Der Befehl steht in einem per [source] geladenen Skript.

        **proc**
        : Der Befehl steht im dynamisch erzeugten Rumpf einer Prozedur.

        [eval]
        : Der Befehl wird von [eval] oder [uplevel] ausgeführt.

        **precompiled**
        : Der Befehl steht in einem vorkompilierten Skript (ladbar mit dem Paket **tbcload**); weitere Informationen sind nicht verfügbar.


    **line**
    : Zeilennummer des Befehls innerhalb des Skripts, zu dem er gehört. Nicht vorhanden bei Typ **precompiled**. Bei Typ [source] relativ zum Dateianfang, bei den letzten beiden Typen relativ zum Skriptanfang.

    [file]
    : Nur bei Typ [source]: normalisierter Pfad der Datei, in der der Befehl steht.

    **cmd**
    : Zeichenketten-Darstellung des Befehls, meist unsubstituiert; bei kanonisch konstruierten Listen (z. B. von [list]), die [eval] ausführt, die substituierte Form, da keine andere Darstellung existiert. Die Kanonizität bleibt dabei erhalten.

    **proc**
    : Nur wenn der Befehl im Rumpf einer regulären Tcl-Prozedur steht: Name dieser Prozedur.

    **lambda**
    : Nur im Rumpf einer anonymen Tcl-Prozedur (Lambda): vollständige Definition dieses Lambdas.

    **level**
    : Nur wenn der abgefragte Frame einem von **info level** zurückgegebenen Frame entspricht: Index dieses Frames relativ zur aktuellen Ebene (**0** und negative Zahlen).


    Bei in Dateien statisch definierten Prozeduren werden Befehle in ihren Rümpfen mit Typ [source] und absoluten Zeilennummern gemeldet, nicht als Typ **proc**. Gleiches gilt für in statischen Prozeduren verschachtelte Prozeduren und wörtliche eval-Skripte in Dateien oder statischen Prozeduren.

    Prozedurdefinitionen und [eval] in einer dynamisch [eval]uierten Umgebung zählen Zeilennummern relativ zum Skriptanfang, auch wenn sie relativ zum äußeren dynamischen Skript zählen könnten. Diese Art von Nummer ist meist aussagekräftiger.

    Anders formuliert: dateibasierte Positionen werden so tief wie möglich verfolgt; wo das nicht möglich ist, werden Zeilen relativ zum kleinstmöglichen [eval]- oder Prozedurrumpf gezählt — dieser Gültigkeitsbereich ist meist leichter zu finden als ein dynamischer äußerer.

    Die syntaktische Form **{\*}** wird wie [eval] behandelt: Bei wörtlichem Listenargument verfolgt das System die Zeilennummer innerhalb der Listenelemente; andernfalls werden alle Zeilennummern relativ zum Anfang jedes Worts gezählt (kleinster Gültigkeitsbereich).

**info functions** ?*pattern*?
: Ohne *pattern* alle derzeit definierten mathematischen Funktionen. Mit *pattern* nur Funktionen, deren Name *pattern* entspricht; Abgleich wie bei [string match][string].

**info globals** ?*pattern*?
: Ohne *pattern* alle Namen derzeit definierter globaler Variablen (Variablen im globalen Namespace). Mit *pattern* nur passende Namen; Abgleich wie bei [string match][string].

**info hostname**
: Gibt den Namen des Rechners zurück, auf dem diese Ausführung läuft. Dieser Name ist nicht garantiert der vollqualifizierte Domainname. Haben Rechner mehrere Namen (häufig bei TCP/IP (DNS) und NetBIOS), wird der für TCP/IP-Netzwerke geeignete Name zurückgegeben.

**info level** ?*number*?
: Ohne *number* eine Zahl mit der Stack-Ebene der aufrufenden Prozedur, oder **0** bei Aufruf auf oberster Ebene. Mit *number* eine Liste aus Name und Argumenten des Prozeduraufrufs auf Ebene *number*. Ist *number* positiv, wählt es eine Stack-Ebene (**1** = oberste aktive Prozedur, **2** = von ihr aufgerufene, …); andernfalls relativ zur aktuellen Ebene (**0** = aktuelle Prozedur, **-1** = Aufrufer, …). Siehe [uplevel] zur Bedeutung der Stack-Ebenen.

**info library**
: Name des Bibliotheksverzeichnisses mit Standard-Tcl-Skripten — tatsächlich der Wert der Variable [tcl\_library][tclvars], änderbar durch Setzen von [tcl\_library][tclvars].

**info loaded** ?*interp*?
: Liste aller mit [load] in *interp* geladenen Pakete. Jedes Listenelement ist eine Zweierliste aus Dateiname und Paketname. Bei statisch geladenen Paketen ist der Dateiname leer. Ohne *interp* Informationen zu allen in einem beliebigen Interpreter des Prozesses geladenen Paketen. Für nur den aktuellen Interpreter leere Zeichenkette für *interp* angeben.

**info locals** ?*pattern*?
: Ohne *pattern* alle Namen derzeit definierter lokaler Variablen, einschließlich Argumente der aktuellen Prozedur. Mit [global], [upvar] und [variable] definierte Variablen werden nicht zurückgegeben. Mit *pattern* nur passende Namen; Abgleich wie bei [string match][string].

**info nameofexecutable**
: Vollständiger Pfadname der Binärdatei, mit der die Anwendung gestartet wurde. Konnte Tcl die Datei nicht identifizieren, leere Zeichenkette.

**info object** *subcommand object* ?*arg ...*
: [Gibt Informationen über das Objekt *object* zurück. Die *subcommand*s sind unter [Objekt-Introspection] unten beschrieben.]{version="8.6"}

**info patchlevel**
: Wert der globalen Variable [tcl\_patchLevel][tclvars], die standardmäßig die exakte Version der Tcl-Bibliothek enthält.

**info procs** ?*pattern*?
: Ohne *pattern* alle Namen von Tcl-Befehlsprozeduren im aktuellen Namespace. Mit *pattern* nur passende im aktuellen Namespace; Abgleich wie bei [string match][string]. Enthält *pattern* Namespace-Trenner, wählen sie relativ zum aktuellen Namespace (oder global bei **::** am Anfang) den Namespace; das Muster ist der Teil nach dem letzten Trenner.

**info script** ?*filename*?
: Wird gerade eine Tcl-Skriptdatei ausgewertet ([Tcl\_EvalFile][Eval] aktiv oder [source]), Name der innersten verarbeiteten Datei. Mit *filename* wird der Rückgabewert für die Dauer des aktiven Aufrufs auf diesen Namen geändert — nützlich in virtuellen Dateisystemen. Sonst leere Zeichenkette.

**info sharedlibextension**
: Erweiterung für Dateinamen mit Shared Libraries auf dieser Plattform (z. B. **.so** unter Solaris). Leere Zeichenkette, wenn Shared Libraries nicht unterstützt werden.

**info tclversion**
: Wert der globalen Variable [tcl\_version][tclvars], die standardmäßig Haupt- und Nebenversion der Tcl-Bibliothek enthält.

**info vars** ?*pattern*?
: Ohne *pattern* alle derzeit sichtbaren Variablennamen (lokale und sichtbare globale). Mit *pattern* nur passende; Abgleich wie bei [string match][string]. *pattern* kann ein qualifizierter Name wie **Foo::option\*** sein — Namespace-Kette mit **::** und am Ende Glob-Sonderzeichen für Variablen in diesem Namespace. Bei qualifiziertem *pattern* ist jede passende Namespace-Variable mit ihrem Namespace qualifiziert. Eine sichtbare Variable kann noch nicht „existieren“, wenn sie nicht gesetzt wurde (z. B. per [variable] deklariert, aber nicht gesetzt).


## Klassen-Introspection

Folgende *subcommand*-Werte unterstützt **info class**:

**info class call** *class method*
: [Beschreibung der Methodenimplementierungen, die eine stereotype Instanz der Implementierung von *method* in *class* liefern (stereotype Instanzen: von der Klasse erzeugte Objekte ohne objektspezifische Definitionen). Das Ergebnis ist eine Liste von Viererlisten; jede besteht aus einem Wort für die Art der Implementierung (**method** für eine normale Methode, **filter** für einen angewendeten Filter, [unknown] für eine im Rahmen der Behandlung unbekannter Methoden aufgerufene Methode), dem Namen der aufgerufenen Methode (bei **method** stets *method*, bei [unknown] „[unknown]“), dem vollqualifizierten Namen der definierenden Klasse und einem Wort zum Implementierungstyp (siehe **info class methodtype**).]{version=""}

    Es wird nicht geprüft, ob die Implementierungen tatsächlich [next] zur Weitergabe entlang der Aufrufkette nutzen.

**info class constructor** *class*
: [Beschreibung der Konstruktordefinition von *class* als Zweierliste: erstes Element die Argumentliste (geeignet für **proc** oder Methodendefinition), zweites der Konstruktorrumpf. Ohne Konstruktor die leere Liste.]{version="8.6"}

**info class definition** *class method*
: [Beschreibung der Definition der Methode *method* von *class* als Zweierliste (Argumentliste und Methodenrumpf).]{version="8.6"}

**info class destructor** *class*
: [Rumpf des Destruktors von *class*. Ohne Destruktor die leere Zeichenkette.]{version="8.6"}

**info class filters** *class*
: [Liste der auf der Klasse gesetzten Filtermethoden.]{version="8.6"}

**info class forward** *class method*
: [Argumentliste der Methodenweiterleitung *method* auf der Klasse *class*.]{version="8.6"}

**info class instances** *class* ?*pattern*?
: [Liste der Instanzen von *class*. Mit optionalem *pattern* nur passende Instanzen gemäß [string match][string].]{version="8.6"}

**info class methods** *class* ?*options...*?
: [Liste aller öffentlichen (exportierten) Methoden von *class*. Folgende *option*s steuern die Auswahl:]{version="8.6"}

    **-all**
    : [Mit **-all** auch Methoden, die nicht von der Klasse selbst, sondern von ihren Superklassen und Mixins definiert sind.]{version="8.6"}

    **-private**
    : [Mit **-private** auch private (nicht exportierte) Methoden der Klasse (und bei **-all** der Superklassen und Mixins).]{version="8.6"}


**info class methodtype** *class method*
: [Beschreibung des Implementierungstyps der Methode *method* von *class*. Bei Ergebnis **method** weitere Infos mit **info class definition**, bei **forward** mit **info class forward**.]{version="8.6"}

**info class mixins** *class*
: [Liste aller in *class* gemischten Klassen.]{version="8.6"}

**info class subclasses** *class* ?*pattern*?
: [Liste direkter Unterklassen von *class*. Mit *pattern* nur passende Klassen gemäß [string match][string].]{version="8.6"}

**info class superclasses** *class*
: [Liste direkter Superklassen von *class* in Vererbungsreihenfolge.]{version="8.6"}

**info class variables** *class*
: [Liste aller für *class* deklarierten Variablen (automatisch in Methoden, Konstruktor und Destruktor der Klasse vorhanden).]{version="8.6"}


## Objekt-Introspection

Folgende *subcommand*-Werte unterstützt **info object**:

**info object call** *object method*
: [Beschreibung der Methodenimplementierungen für die Implementierung von *method* in *object*. Viererlisten wie bei **info class call**: Art der Implementierung (**method**, **filter** oder [unknown]), Name der aufgerufenen Methode (bei **method** stets *method*, bei [unknown] „[unknown]“), was die Methode definierte (vollqualifizierter Klassenname oder die Zeichenkette **object** bei Instanzimplementierung) und Implementierungstyp (siehe **info object methodtype**).]{version="8.6"}

    Es wird nicht geprüft, ob die Implementierungen tatsächlich [next] zur Weitergabe entlang der Aufrufkette nutzen.

**info object class** *object* ?*className*?
: [Ohne *className* die Klasse von *object*. Mit *className* ein boolescher Wert, ob *object* von dieser Klasse ist.]{version="8.6"}

**info object definition** *object method*
: [Beschreibung der Definition der Methode *method* von *object* als Zweierliste (Argumentliste und Methodenrumpf).]{version="8.6"}

**info object filters** *object*
: [Liste der auf dem Objekt gesetzten Filtermethoden.]{version="8.6"}

**info object forward** *object method*
: [Argumentliste der Methodenweiterleitung *method* auf *object*.]{version="8.6"}

**info object isa** *category object* ?*arg*?
: [Prüft, ob ein Objekt zu einer Kategorie gehört; boolescher Wert. Unterstützte Kategorien:]{version="8.6"}

    **info object isa class** *object*
    : [Ob *object* eine Klasse ist (Instanz von [oo::class][class] oder Unterklasse).]{version="8.6"}

    **info object isa metaclass** *object*
    : [Ob *object* eine Klasse ist, die Klassen erzeugen kann ([oo::class][class] oder Unterklasse).]{version="8.6"}

    **info object isa mixin** *object class*
    : [Ob *class* direkt in *object* gemischt ist.]{version="8.6"}

    **info object isa object** *object*
    : [Ob *object* wirklich ein Objekt ist.]{version="8.6"}

    **info object isa typeof** *object class*
    : [Ob *class* der Typ von *object* ist (*object* Instanz von *class* oder Unterklasse, direkt oder indirekt).]{version="8.6"}


**info object methods** *object* ?*option...*?
: [Liste aller öffentlichen (exportierten) Methoden von *object*. Folgende *option*s steuern die Auswahl:]{version="8.6"}

    **-all**
    : [Mit **-all** auch Methoden von Klasse und Mixins des Objekts sowie deren Superklassen.]{version="8.6"}

    **-private**
    : [Mit **-private** auch private (nicht exportierte) Methoden des Objekts (und bei **-all** der Klassen).]{version="8.6"}


**info object methodtype** *object method*
: [Implementierungstyp der Methode *method* von *object*. Bei **method** → **info object definition**, bei **forward** → **info object forward**.]{version="8.6"}

**info object mixins** *object*
: [Liste aller in *object* gemischten Klassen.]{version="8.6"}

**info object namespace** *object*
: [Name des internen Namespace von *object*.]{version="8.6"}

**info object variables** *object*
: [Liste aller für *object* deklarierten Variablen (automatisch in den Methoden des Objekts vorhanden).]{version="8.6"}

**info object vars** *object* ?*pattern*?
: [Liste aller Variablen im privaten Namespace von *object*. Mit *pattern* ein Filter ([string match][string]-Glob). Anders als **info object variables**: jene kann noch nicht gesetzte Variablen enthalten; dieser Befehl Variablen, die von keiner Methode von *object* (oder Klasse, Superklassen, Mixins) automatisch eingebunden werden.]{version="8.6"}


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

Alternativ durch manuelles Durchlaufen der Vererbungskette (einfache Einzelvererbung, keine komplexen Mixins; dann ist **info object call** deutlich einfacher):

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
