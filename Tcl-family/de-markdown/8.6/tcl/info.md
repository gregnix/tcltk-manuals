---
CommandName: info
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

# NAME

info - Informationen über den Zustand des Tcl-Interpreters

# ÜBERSICHT

::: {.synopsis} :::
[info]{.cmd} [option]{.arg} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Dieser Befehl liefert Informationen über verschiedene Interna des Tcl-Interpreters. Die zulässigen *option*s (abkürzbar) sind:

**info args** *procname*
: Gibt eine Liste mit den Namen der Argumente der Prozedur *procname* in Reihenfolge zurück. *Procname* muss der Name einer Tcl-Befehlsprozedur sein.

**info body** *procname*
: Gibt den Rumpf der Prozedur *procname* zurück. *Procname* muss der Name einer Tcl-Befehlsprozedur sein.

**info class** *subcommand class* ?*arg ...*
: Gibt Informationen über die Klasse *class* zurück. Die *subcommand*s sind unter **KLASSEN-INTROSPECTION** beschrieben.

**info cmdcount**
: Gibt die Gesamtzahl der in diesem Interpreter aufgerufenen Befehle zurück.

**info commands** ?*pattern*?
: Ohne *pattern* eine Liste aller Tcl-Befehlsnamen, die im aktuellen Namespace sichtbar sind (ohne qualifizierten Namen ausführbar), einschließlich in C geschriebener eingebauter Befehle und per **proc** definierter Befehlsprozeduren. Mit *pattern* nur passende Namen; Abgleich wie bei **string match**. *pattern* kann ein qualifizierter Name wie **Foo::print\*** sein — Namespace-Kette mit **::** und am Ende Glob-Sonderzeichen für Befehle in diesem Namespace. Bei qualifiziertem *pattern* ist jeder Befehlsname mit dem Namespace qualifiziert; zurückgegeben werden nur Befehle des genannten Namespace.

**info complete** *command*
: Gibt **1** zurück, wenn *command* ein vollständiger Tcl-Befehl ist (keine ungeschlossenen Anführungszeichen, Klammern, eckigen Klammern oder Array-Elementnamen). Sonst **0**. Typischerweise in zeilenorientierten Eingabeumgebungen, damit Benutzer mehrzeilige Befehle eingeben können; ist der Befehl unvollständig, kann das Skript die Auswertung verzögern.

**info coroutine**
: Gibt den Namen der gerade ausführenden **coroutine** zurück oder die leere Zeichenkette, wenn keine Coroutine läuft oder die aktuelle Coroutine gelöscht wurde (aber noch nicht zurückgekehrt oder yielded hat).

**info default** *procname arg varname*
: *Procname* muss eine Tcl-Befehlsprozedur sein und *arg* der Name eines Arguments. Hat *arg* keinen Standardwert, gibt der Befehl **0** zurück. Andernfalls **1** und der Standardwert von *arg* wird in *varname* abgelegt.

**info errorstack** ?*interp*?
: Gibt in programmatisch leicht parsebarer Form die Funktionsnamen und Argumente jeder Ebene aus dem Aufrufstack des letzten Fehlers im angegebenen *interp* zurück, oder im aktuellen, falls nicht angegeben.

::: {.info -version="8.6"}
Die Form ist eine Liste gerader Länge aus abwechselnden Token und Parametern. Token sind derzeit **CALL**, **UP** oder **INNER**; weitere Werte können künftig eingeführt werden. **CALL** kennzeichnet einen Prozeduraufruf; der Parameter ist das entsprechende **info level** **0**. **UP** kennzeichnet einen durch **uplevel** oder Ähnliches erzeugten Wechsel der Variablenframes und bezieht sich auf das vorherige **CALL**-Element; der Parameter ist der Ebenenversatz. **INNER** bezeichnet den „inneren Kontext“ — den innersten atomaren Befehl oder Bytecode-Befehl, der den Fehler auslöste, samt Argumenten, sofern verfügbar. Während **CALL** und **UP** komplexe Aufrufpfade abbilden, fokussiert **INNER** die fehlerhafte Operation im innersten Prozeduraufruf, bis auf Subausdruck-Ebene.
:::    Diese Information steht auch im Eintrag **-errorstack** des Options-Dictionarys von **catch** mit drei Argumenten; **info errorstack** ist eine bequeme Möglichkeit, sie für nicht abgefangene Fehler auf oberster Ebene in **tclsh** abzurufen.

**info exists** *varName*
: Gibt **1** zurück, wenn die Variable *varName* im aktuellen Kontext (global oder lokal) existiert und durch Zuweisung definiert wurde, sonst **0**.

**info frame** ?*number*?
: Zugriff auf alle Frames des Stacks, auch die für **info level** verborgenen. Ohne *number* eine Zahl mit der Frame-Ebene des Befehls (**1** bei Aufruf auf oberster Ebene). Mit *number* ein Dictionary mit Positionsinformationen für den Befehl auf der *number*-ten Stack-Ebene.
    Ist *number* positiv (> 0), wählt es eine bestimmte Stack-Ebene (**1** = äußerster aktiver Befehl, **2** = von ihm aufgerufener, bis zur aktuellen Frame-Ebene von **info frame**); andernfalls eine Ebene relativ zum aktuellen Befehl (**0** = aktueller Befehl, also **info frame**, **-1** = Aufrufer, …).
    Ähnlich wie **info level**, meldet dieser Unterbefehl aber alle Frames (**source**, **eval**, **uplevel** usw.).
    Bei verschachtelten Befehlen wie „foo [bar [x]]“ sieht **info frame** innerhalb von „x“ nur „x“ — wie **info level** und Fehler-Stack-Traces.
    Das Ergebnis-Dictionary kann folgende Schlüssel mit den angegebenen Bedeutungen enthalten:

**type**
: Immer vorhanden; beschreibt die Art der Befehlsposition. Werte: **source**, **proc**, **eval**, **precompiled**.

**source**
: Der Befehl steht in einem per **source** geladenen Skript.

**proc**
: Der Befehl steht im dynamisch erzeugten Rumpf einer Prozedur.

**eval**
: Der Befehl wird von **eval** oder **uplevel** ausgeführt.

**precompiled**
: Der Befehl steht in einem vorkompilierten Skript (ladbar mit **tbcload**); weitere Informationen sind nicht verfügbar.


**line**
: Zeilennummer des Befehls innerhalb seines Skripts. Nicht bei Typ **precompiled**. Bei **source** relativ zum Dateianfang, bei den letzten beiden Typen relativ zum Skriptanfang.

**file**
: Nur bei Typ **source**: normalisierter Pfad der Datei.

**cmd**
: Zeichenketten-Darstellung des Befehls, meist unsubstituiert; bei kanonisch konstruierten Listen (z. B. von **list**), die **eval** ausführt, die substituierte Form, da keine andere Darstellung existiert. Die Kanonizität bleibt erhalten.

**proc**
: Nur wenn der Befehl im Rumpf einer regulären Tcl-Prozedur steht: Name dieser Prozedur.

**lambda**
: Nur im Rumpf einer anonymen Tcl-Prozedur (Lambda): vollständige Lambda-Definition.

**level**
: Nur wenn der abgefragte Frame einem von **info level** zurückgegebenen Frame entspricht: Index relativ zur aktuellen Ebene (**0** und negative Zahlen).


Bei in Dateien statisch definierten Prozeduren werden Befehle in ihren Rümpfen mit Typ **source** und absoluten Zeilennummern gemeldet, nicht als Typ **proc**. Gleiches gilt für in statischen Prozeduren verschachtelte Prozeduren und wörtliche **eval**-Skripte in Dateien oder statischen Prozeduren.

Prozedurdefinitionen und **eval** in dynamisch **eval**uierten Umgebungen zählen Zeilen relativ zum Skriptanfang, auch wenn sie relativ zum äußeren dynamischen Skript zählen könnten. Diese Art von Nummer ist meist aussagekräftiger.

Anders formuliert: dateibasierte Positionen werden so tief wie möglich verfolgt; wo das nicht möglich ist, werden Zeilen relativ zum kleinstmöglichen **eval**- oder Prozedurrumpf gezählt — dieser Gültigkeitsbereich ist meist leichter zu finden als ein dynamischer äußerer.

Die syntaktische Form **{*}** wird wie **eval** behandelt: Bei wörtlichem Listenargument verfolgt das System die Zeilennummer innerhalb der Listenelemente; andernfalls werden alle Zeilennummern relativ zum Anfang jedes Worts gezählt (kleinster Gültigkeitsbereich).

**info functions** ?*pattern*?
: Ohne *pattern* alle derzeit definierten mathematischen Funktionen. Mit *pattern* nur Funktionen, deren Name *pattern* entspricht; Abgleich wie bei **string match**.

**info globals** ?*pattern*?
: Ohne *pattern* alle Namen derzeit definierter globaler Variablen (im globalen Namespace). Mit *pattern* nur passende Namen; Abgleich wie bei **string match**.

**info hostname**
: Gibt den Namen des Rechners zurück, auf dem diese Ausführung läuft. Dieser Name ist nicht garantiert der vollqualifizierte Domainname. Haben Rechner mehrere Namen (häufig bei TCP/IP (DNS) und NetBIOS), wird der für TCP/IP-Netzwerke geeignete Name zurückgegeben.

**info level** ?*number*?
: Ohne *number* eine Zahl mit der Stack-Ebene der aufrufenden Prozedur, oder **0** bei Aufruf auf oberster Ebene. Mit *number* eine Liste aus Name und Argumenten des Prozeduraufrufs auf Ebene *number*. Ist *number* positiv, wählt es eine Stack-Ebene (**1** = oberste aktive Prozedur, **2** = von ihr aufgerufene, …); andernfalls relativ zur aktuellen Ebene (**0** = aktuelle Prozedur, **-1** = Aufrufer, …). Siehe **uplevel** zu Stack-Ebenen.

**info library**
: Name des Bibliotheksverzeichnisses mit Standard-Tcl-Skripten — Wert der Variable **tcl_library**, änderbar durch Setzen von **tcl_library**.

**info loaded** ?*interp*?
: Liste aller mit **load** in *interp* geladenen Pakete. Jedes Listenelement ist eine Zweierliste aus Dateiname und Paketname. Bei statisch geladenen Paketen ist der Dateiname leer. Ohne *interp* Informationen zu allen in einem beliebigen Interpreter des Prozesses geladenen Paketen. Für nur den aktuellen Interpreter leere Zeichenkette für *interp* angeben.

**info locals** ?*pattern*?
: Ohne *pattern* alle Namen derzeit definierter lokaler Variablen, einschließlich Argumente der aktuellen Prozedur. Mit **global**, **upvar** und **variable** definierte Variablen werden nicht zurückgegeben. Mit *pattern* nur passende Namen; Abgleich wie bei **string match**.

**info nameofexecutable**
: Vollständiger Pfadname der Binärdatei, mit der die Anwendung gestartet wurde. Konnte Tcl die Datei nicht identifizieren, leere Zeichenkette.

**info object** *subcommand object* ?*arg ...*
: Informationen über das Objekt *object*. *subcommand*s unter **OBJEKT-INTROSPECTION**.

**info patchlevel**
: Wert der globalen Variable **tcl_patchLevel** (exakte Tcl-Bibliotheksversion).

**info procs** ?*pattern*?
: Ohne *pattern* alle Namen von Tcl-Befehlsprozeduren im aktuellen Namespace. Mit *pattern* nur passende im aktuellen Namespace; Abgleich wie bei **string match**. Enthält *pattern* Namespace-Trenner, wählen sie relativ zum aktuellen Namespace (oder global bei **::** am Anfang) den Namespace; das Muster ist der Teil nach dem letzten Trenner.

**info script** ?*filename*?
: Wird gerade eine Tcl-Skriptdatei ausgewertet (**Tcl_EvalFile** aktiv oder **source**), Name der innersten verarbeiteten Datei. Mit *filename* wird der Rückgabewert für die Dauer des aktiven Aufrufs geändert — nützlich in virtuellen Dateisystemen. Sonst leere Zeichenkette.

**info sharedlibextension**
: Erweiterung für Dateinamen mit Shared Libraries auf dieser Plattform (z. B. **.so** unter Solaris). Leere Zeichenkette, wenn nicht unterstützt.

**info tclversion**
: Wert der globalen Variable **tcl_version** (Haupt- und Nebenversion der Tcl-Bibliothek).

**info vars** ?*pattern*?
: Ohne *pattern* alle derzeit sichtbaren Variablennamen (lokal und sichtbare globale). Mit *pattern* nur passende; Abgleich wie bei **string match**. *pattern* kann qualifiziert sein wie **Foo::option\***. Bei qualifiziertem *pattern* ist jede passende Namespace-Variable qualifiziert. Eine sichtbare Variable kann noch nicht „existieren“, wenn sie nicht gesetzt wurde (z. B. per **variable** deklariert, aber nicht gesetzt).


## Klassen-Introspection

::: {.info -version="8.6"}
Folgende *subcommand*-Werte unterstützt **info class**:
:::
**info class call** *class method*
: Beschreibung der Methodenimplementierungen für eine stereotype Instanz der Implementierung von *method* in *class* (stereotype Instanzen: vom Klasse erzeugte Objekte ohne objektspezifische Definitionen). Viererlisten: Implementierungstyp (**method**, **filter**, **unknown**), Methodenname (bei **method** *method*, bei **unknown** „**unknown**“), vollqualifizierter Klassenname, Implementierungstyp (siehe **info class methodtype**).

::: {.info -version=""}
Es wird nicht geprüft, ob die Implementierungen **next** entlang der Aufrufkette nutzen.
:::
**info class constructor** *class*
: Konstruktordefinition von *class* als Zweierliste (Argumentliste und Rumpf). Ohne Konstruktor die leere Liste.

**info class definition** *class method*
: Definition der Methode *method* von *class* als Zweierliste (Argumentliste und Rumpf).

**info class destructor** *class*
: Rumpf des Destruktors von *class*. Ohne Destruktor die leere Zeichenkette.

**info class filters** *class*
: Liste der Filtermethoden der Klasse.

**info class forward** *class method*
: Argumentliste der Weiterleitung *method* auf *class*.

**info class instances** *class* ?*pattern*?
: Instanzen von *class*. Mit *pattern* nur passende gemäß **string match**.

**info class methods** *class* ?*options...*?
: Öffentliche Methoden von *class*. *option*s:

**-all**
: Mit **-all** auch Methoden von Superklassen und Mixins.

**-private**
: Mit **-private** auch private (nicht exportierte) Methoden (und bei **-all** von Superklassen und Mixins).


**info class methodtype** *class method*
: Implementierungstyp von *method* in *class*. Bei **method** → **info class definition**, bei **forward** → **info class forward**.

**info class mixins** *class*
: Gemischte Klassen in *class*.

**info class subclasses** *class* ?*pattern*?
: Direkte Unterklassen von *class*. Mit *pattern* nur passende gemäß **string match**.

**info class superclasses** *class*
: Direkte Superklassen von *class* in Vererbungsreihenfolge.

**info class variables** *class*
: Alle für *class* deklarierten Variablen (automatisch in Methoden, Konstruktor und Destruktor).


## Objekt-Introspection

::: {.info -version="8.6"}
Folgende *subcommand*-Werte unterstützt **info object**:
:::
**info object call** *object method*
: Beschreibung der Implementierungen von *method* für *object*. Viererlisten wie bei **info class call**; das dritte Wort: Definition (**object** oder Klassenname), viertes: **info object methodtype**.

::: {.info -version="8.6"}
Keine Prüfung auf **next** entlang der Aufrufkette.
:::
**info object class** *object* ?*className*?
: Ohne *className* die Klasse von *object*. Mit *className* boolesch, ob *object* von dieser Klasse ist.

**info object definition** *object method*
: Definition von *method* auf *object* als Zweierliste (Argumentliste und Rumpf).

**info object filters** *object*
: Filtermethoden des Objekts.

**info object forward** *object method*
: Argumentliste der Weiterleitung *method* auf *object*.

**info object isa** *category object* ?*arg*?
: Prüft die Kategorie; boolescher Wert. Kategorien:

**info object isa class** *object*
: Ob *object* eine Klasse ist (**oo::class** oder Unterklasse).

**info object isa metaclass** *object*
: Ob *object* Klassen erzeugen kann (**oo::class** oder Unterklasse).

**info object isa mixin** *object class*
: Ob *class* direkt in *object* gemischt ist.

**info object isa object** *object*
: Ob *object* wirklich ein Objekt ist.

**info object isa typeof** *object class*
: Ob *class* der Typ von *object* ist (direkt oder indirekt).


**info object methods** *object* ?*option...*?
: Öffentliche Methoden von *object*. *option*s:

**-all**
: Mit **-all** auch Methoden von Klasse, Mixins und deren Superklassen.

**-private**
: Mit **-private** auch private Methoden (und bei **-all** von Klassen).


**info object methodtype** *object method*
: Implementierungstyp von *method* auf *object*. Bei **method** → **info object definition**, bei **forward** → **info object forward**.

**info object mixins** *object*
: In *object* gemischte Klassen.

**info object namespace** *object*
: Interner Namespace von *object*.

**info object variables** *object*
: Für *object* deklarierte Variablen (automatisch in den Methoden des Objekts).

**info object vars** *object* ?*pattern*?
: Variablen im privaten Namespace von *object*. Mit *pattern* ein **string match**-Filter. Anders als **info object variables**: jene kann noch nicht gesetzte Variablen enthalten; dieser Befehl Variablen, die von keiner Methode von *object* (oder Klasse, Superklassen, Mixins) automatisch eingebunden werden.


# BEISPIELE

Dieser Befehl gibt eine zum Speichern in einem Tcl-Skript geeignete Prozedur aus:

```
proc printProc {procName} {
    set result [list proc $procName]
    set formals {}
    foreach var [info args $procName] {
        if {[info default $procName $var def]} {
            lappend formals [list $var $def]
        } else {
            # Listenquotierung nötig, da Variablennamen Leerzeichen enthalten dürfen.
            lappend formals [list $var]
        }
    }
    puts [lappend result $formals [info body $procName]]
}
```

## Beispiele mit Objekten

::: {.info -version="8.6"}
Jedes Objekt kennt seine Klasse; diese Information ist per Introspection leicht abrufbar:
:::
```
oo::class create c
c create o
puts [info object class o]
                     → prints "::c"
puts [info object class c]
                     → prints "::oo::class"
```

::: {.info -version="8.6"}
Die Introspection kann ermitteln, welche Klasse eine Methode implementiert und wie sie definiert ist:
:::
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

::: {.info -version="8.6"}
Alternativ durch manuelles Durchlaufen der Vererbungskette (einfache Einzelvererbung, keine komplexen Mixins; dann ist **info object call** deutlich einfacher):
:::
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
