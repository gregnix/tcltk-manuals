---
CommandName: pt::peg::export
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - EBNF
 - LL(k)
 - PEG
 - TDPL
 - context-free languages
 - expression
 - grammar
 - matching
 - parser
 - parsing expression
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - state
 - top-down parsing languages
 - transducer
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

pt::peg::export – PEG-Export

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [struct::map]{.lit} 
[package]{.cmd} [require]{.sub} [pt::peg]{.lit} 
[package]{.cmd} [require]{.sub} [pluginmgr]{.lit} 
[package]{.cmd} [require]{.sub} [pt::peg::export]{.lit} [1.0.2]{.optlit} 
[::pt::peg::export]{.cmd} [objectName]{.arg} 
[objectName]{.cmd} [method]{.sub} [arg arg]{.optdot} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [export]{.sub} [serial]{.lit} [serial]{.arg} [format]{.optarg} 
[objectName]{.ins} [export]{.sub} [object]{.lit} [object]{.arg} [format]{.optarg} 
[objectName]{.ins} [configuration]{.sub} [names]{.lit} 
[objectName]{.ins} [configuration]{.sub} [get]{.lit} 
[objectName]{.ins} [configuration]{.sub} [set]{.lit} [name]{.arg} [value]{.optarg} 
[objectName]{.ins} [configuration]{.sub} [unset]{.lit} [pattern...]{.arg} 
:::

# BESCHREIBUNG

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket stellt einen Manager für Parsing Expression Grammars bereit. Jede Instanz verwaltet eine Menge von Plugins für den Export dieser Grammatiken in andere Formate, also für ihre Umwandlung zum Beispiel nach *nroff*, *HTML* und so weiter.

Es befindet sich im Abschnitt „Export“ der Kernschicht der Parser-Tools und ist eine der drei Säulen, auf denen die Verwaltung von Parsing Expression Grammars beruht.

IMAGE: arch_core_export

Die beiden anderen Säulen sind, wie oben dargestellt,

**\[1\]**
: *PEG-Import* sowie

**\[2\]**
: *PEG-Speicherung*. Informationen zur Datenstruktur, die den Hauptteil der Eingaben für die von diesem Paket bereitgestellten Manager-Objekte bildet, finden Sie im Abschnitt **PEG-SERIALISIERUNGSFORMAT**. Das Plugin-System dieser Klasse basiert auf dem Paket **pluginmgr** und ist so konfiguriert, dass es nach Plugins sucht, die

**\[1\]**
: die Umgebungsvariable **GRAMMAR_PEG_EXPORT_PLUGINS**,

**\[2\]**
: die Umgebungsvariable **GRAMMAR_PEG_PLUGINS**,

**\[3\]**
: die Umgebungsvariable **GRAMMAR_PLUGINS**,

**\[4\]**
: der Pfad „*~/.grammar/peg/export/plugin*“

**\[5\]**
: der Pfad „*~/.grammar/peg/plugin*“

**\[6\]**
: der Pfad „*~/.grammar/plugin*“

**\[7\]**
: der Pfad „*~/.grammar/peg/export/plugins*“

**\[8\]**
: der Pfad „*~/.grammar/peg/plugins*“

**\[9\]**
: der Pfad „*~/.grammar/plugins*“

**\[10\]**
: der Registrierungseintrag „HKEY_CURRENT_USER\\SOFTWARE\\GRAMMAR\\PEG\\EXPORT\\PLUGINS“

**\[11\]**
: der Registrierungseintrag „HKEY_CURRENT_USER\\SOFTWARE\\GRAMMAR\\PEG\\PLUGINS“

**\[12\]**
: der Registrierungseintrag „HKEY_CURRENT_USER\\SOFTWARE\\GRAMMAR\\PLUGINS“. Die letzten drei werden nur verwendet, wenn das Paket auf einem Rechner mit dem Betriebssystem Windows(tm) ausgeführt wird. Das gesamte System wird mit drei vordefinierten Export-Plugins ausgeliefert, nämlich


**container**
: Weitere Informationen finden Sie unter *PEG Export Plugin. To CONTAINER format*.

**json**
: Weitere Informationen finden Sie unter *PEG Export Plugin. To JSON format*.

**peg**
: Weitere Informationen finden Sie unter *PEG Export Plugin. To PEG format*. Für Leser, die ein eigenes Export-Plugin für ein bestimmtes Format erstellen möchten, d. h. *Plugin-Entwickler*, ist das Lesen und Verstehen der Spezifikation der *Parser Tools Export API* unerlässlich, da diese die Interaktion zwischen diesem Paket und seinen Plugins ausführlich dokumentiert.


# API

## Paketbefehle

**::pt::peg::export** *objectName*
: Dieser Befehl erstellt ein neues Export-Manager-Objekt mit einem zugehörigen Tcl-Befehl, dessen Name *objectName* lautet. Dieser *object*-Befehl wird in den Abschnitten **Objektbefehl** und **Objektmethoden** ausführlich erläutert. Der Objektbefehl wird unter dem aktuellen Namespace erstellt, wenn *objectName* nicht vollständig qualifiziert ist; andernfalls erfolgt die Erstellung im angegebenen Namespace.


## Objektbefehl

Alle mit dem Befehl **::pt::peg::export** erstellten Objekte haben die folgende allgemeine Form:

**objectName** **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt **Objektmethoden**.


## Objektmethoden

*objectName* **destroy**
: Diese Methode löscht das Objekt, für das sie aufgerufen wird.

*objectName* **export serial** *serial* ?*format*?
: Diese Methode nimmt die kanonische Serialisierung einer in *serial* gespeicherten Parsing Expression Grammar und wandelt sie mit dem Export-Plugin für das angegebene *format* in dieses Format um. Wenn für das Format kein Plugin gefunden werden konnte, schlägt der Vorgang mit einer Fehlermeldung fehl. Die durch den Konvertierungsprozess erzeugte Zeichenkette wird als Ergebnis dieser Methode zurückgegeben. Wenn kein *format* angegeben wird, verwendet die Methode standardmäßig **text**. Die Spezifikation dessen, was eine *kanonische* Serialisierung ist, finden Sie im Abschnitt **PEG-SERIALISIERUNGSFORMAT**. Das Plugin muss der in der Spezifikation *Parser Tools Export API* dokumentierten Schnittstelle entsprechen.

*objectName* **export object** *object* ?*format*?
: Diese Methode ist eine praktische Hülle um die im vorherigen Punkt beschriebene Methode **export serial**. Sie setzt voraus, dass *object* ein Objektbefehl ist, der eine **serialize**-Methode unterstützt, welche die kanonische Serialisierung einer Parsing Expression Grammar zurückgibt. Sie ruft diese Methode auf, übergibt das Ergebnis an **export serial** und gibt die resultierende Zeichenkette als eigenes Ergebnis zurück.

*objectName* **configuration names**
: Diese Methode gibt eine Liste zurück, die die Namen aller dem Objekt derzeit bekannten Konfigurationsoptionen enthält.

*objectName* **configuration get**
: Diese Methode gibt ein Dictionary zurück, das die Namen und Werte aller dem Objekt derzeit bekannten Konfigurationsoptionen enthält.

*objectName* **configuration set** *name* ?*value*?
: Diese Methode setzt die Konfigurationsoption *name* auf den angegebenen *value* und gibt den neuen Wert der Option zurück. Wird kein Wert angegeben, wird lediglich der aktuelle Wert zurückgegeben, ohne ihn zu ändern. Beachten Sie, dass diese Konfigurationsoptionen und ihre Werte bei der Durchführung des eigentlichen Exports lediglich an ein Plugin übergeben werden. Die Validierung erfolgt durch das Plugin, nicht durch den Manager.

*objectName* **configuration unset** *pattern*...
: Diese Methode hebt alle Konfigurationsoptionen auf, die den angegebenen *pattern*s entsprechen. Wird kein *pattern* angegeben, werden alle derzeit definierten Konfigurationsoptionen aufgehoben.


# PEG-SERIALISIERUNGSFORMAT

Hier legen wir das Format fest, das von den Parser-Tools verwendet wird, um Parsing Expression Grammars als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Auch wenn ein PEG mehr als eine reguläre Serialisierung haben kann, ist jeweils genau eine davon *kanonisch*.

**Reguläre Serialisierung**
: 


**\[1\]**
: Die Serialisierung eines beliebigen PEG ist ein verschachteltes Tcl-Dictionary.

**\[2\]**
: Dieses Dictionary enthält einen einzigen Schlüssel, **pt::grammar::peg**, sowie dessen Wert. Dieser Wert enthält den Inhalt der Grammatik.

**\[3\]**
: Der Inhalt der Grammatik besteht aus einem Tcl-Dictionary, das die Menge der nichtterminalen Symbole und den Startausdruck enthält. Die relevanten Schlüssel und ihre Werte lauten


**rules**
: Der Wert ist ein Tcl-Dictionary, dessen Schlüssel die Namen der in der Grammatik bekannten nichtterminalen Symbole sind.


**\[1\]**
: Jedes nichtterminale Symbol darf nur einmal vorkommen.

**\[2\]**
: Die leere Zeichenkette ist kein zulässiges nichtterminales Symbol.

**\[3\]**
: Der Wert für jedes Symbol ist selbst ein Tcl-Dictionary. Die entsprechenden Schlüssel und ihre Werte in diesem Dictionary lauten


**is**
: Der Wert entspricht der Serialisierung des Parsing-Ausdrucks, der die Satzstruktur des Symbols beschreibt, wie im Abschnitt **PE-SERIALISIERUNGSFORMAT** festgelegt.

**mode**
: Der Wert kann einer von drei Werten sein, die festlegen, wie ein Parser mit dem durch das Symbol erzeugten semantischen Wert umgehen soll.


**value**
: Der semantische Wert des nichtterminalen Symbols ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminale selbst besteht, dessen Kindknoten die ASTs der rechten Seite des Symbols sind.

**leaf**
: Der semantische Wert des Nichtterminalsymbols ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminal besteht, der keine Kindknoten hat. Alle durch die rechte Seite des Symbols erzeugten ASTs werden verworfen.

**void**
: Das Nichtterminal hat keinen semantischen Wert. Alle ASTs, die durch die rechte Seite des Symbols erzeugt werden, werden (ebenfalls) verworfen.


**start**
: Der Wert entspricht der Serialisierung des Start-Parsing-Ausdrucks der Grammatik, wie im Abschnitt **PE-SERIALISIERUNGSFORMAT** beschrieben.


**\[4\]**
: Die Terminalsymbole der Grammatik werden implizit als die Menge aller Terminalsymbole festgelegt, die im Startausdruck und auf der rechten Seite der Grammatikregeln verwendet werden.


**Kanonische Serialisierung**
: Die kanonische Serialisierung einer Grammatik hat das im vorherigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen dieser Grammatik eindeutig ist.


**\[1\]**
: Die Schlüssel in allen verschachtelten Tcl-Dictionaries sind in aufsteigender Wörterbuchreihenfolge sortiert, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.

**\[2\]**
: Die Zeichenfolgendarstellung des Werts entspricht der kanonischen Darstellung eines Tcl-Dictionaries. Das heißt, sie enthält keine überflüssigen Leerzeichen.


## Beispiel

Unter der Annahme der folgenden PEG für einfache mathematische Ausdrücke

```
PEG calculator (Expression)
    Digit      <- '0'/'1'/'2'/'3'/'4'/'5'/'6'/'7'/'8'/'9'       ;
    Sign       <- '-' / '+'                                     ;
    Number     <- Sign? Digit+                                  ;
    Expression <- Term (AddOp Term)*                            ;
    MulOp      <- '*' / '/'                                     ;
    Term       <- Factor (MulOp Factor)*                        ;
    AddOp      <- '+'/'-'                                       ;
    Factor     <- '(' Expression ')' / Number                   ;
END;
```

dann lautet seine kanonische Serialisierung (mit Ausnahme von Leerzeichen)

```
pt::grammar::peg {
    rules {
        AddOp      {is {/ {t -} {t +}}                                                                mode value}
        Digit      {is {/ {t 0} {t 1} {t 2} {t 3} {t 4} {t 5} {t 6} {t 7} {t 8} {t 9}}                mode value}
        Expression {is {x {n Term} {* {x {n AddOp} {n Term}}}}                                        mode value}
        Factor     {is {/ {x {t (} {n Expression} {t )}} {n Number}}                                  mode value}
        MulOp      {is {/ {t *} {t /}}                                                                mode value}
        Number     {is {x {? {n Sign}} {+ {n Digit}}}                                                 mode value}
        Sign       {is {/ {t -} {t +}}                                                                mode value}
        Term       {is {x {n Factor} {* {x {n MulOp} {n Factor}}}}                                    mode value}
    }
    start {n Expression}
}
```

# PE-SERIALISIERUNGSFORMAT

Hier legen wir das Format fest, das von den Parser-Tools verwendet wird, um Parsing-Ausdrücke als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Auch wenn ein Parsing-Ausdruck mehr als eine reguläre Serialisierung aufweisen kann, ist jeweils genau eine davon *kanonisch*.

**Reguläre Serialisierung**
: 


**Atomare Parsing-Ausdrücke**
: 


**\[1\]**
: Die Zeichenfolge **epsilon** ist ein atomarer Parsing-Ausdruck. Sie passt auf die leere Zeichenfolge.

**\[2\]**
: Die Zeichenfolge **dot** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Zeichen.

**\[3\]**
: Die Zeichenfolge **alnum** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes alphabetische Unicode-Zeichen und jede Unicode-Ziffer. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[4\]**
: Die Zeichenfolge **alpha** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes alphabetische Unicode-Zeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[5\]**
: Die Zeichenfolge **ascii** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Zeichen unterhalb von U0080. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[6\]**
: Die Zeichenfolge **control** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Steuerzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[7\]**
: Die Zeichenfolge **digit** ist ein atomarer Parsing-Ausdruck. Sie passt auf jede Unicode-Ziffer. Das schließt auch Zeichen außerhalb des Bereichs \[0..9\] ein. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[8\]**
: Die Zeichenfolge **graph** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes druckbare Unicode-Zeichen außer dem Leerzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[9\]**
: Die Zeichenfolge **lower** ist ein atomarer Parsing-Ausdruck. Sie passt auf jeden Unicode-Kleinbuchstaben. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[10\]**
: Die Zeichenfolge **print** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes druckbare Unicode-Zeichen einschließlich des Leerzeichens. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[11\]**
: Die Zeichenfolge **punct** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Satzzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[12\]**
: Die Zeichenfolge **space** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Leerraumzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[13\]**
: Die Zeichenfolge **upper** ist ein atomarer Parsing-Ausdruck. Sie passt auf jeden Unicode-Großbuchstaben. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[14\]**
: Die Zeichenfolge **wordchar** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Wortzeichen. Das ist jedes alphanumerische Zeichen (siehe alnum) und jedes Verbindungssatzzeichen (zum Beispiel der Unterstrich). Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[15\]**
: Die Zeichenfolge **xdigit** ist ein atomarer Parsing-Ausdruck. Sie passt auf jede Hexadezimalziffer. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[16\]**
: Die Zeichenfolge **ddigit** ist ein atomarer Parsing-Ausdruck. Sie passt auf jede Dezimalziffer. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **regexp**.

**\[17\]**
: Der Ausdruck \[list t **x**\] ist ein atomarer Parsing-Ausdruck. Er passt auf die Terminalzeichenkette **x**.

**\[18\]**
: Der Ausdruck \[list n **A**\] ist ein atomarer Parsing-Ausdruck. Er passt auf das Nichtterminal **A**.


**Zusammengesetzte Parsing-Ausdrücke**
: 


**\[1\]**
: Für die Parsing-Ausdrücke **e1**, **e2**, … ist das Ergebnis von \[list / **e1** **e2** … \] ebenfalls ein Parsing-Ausdruck. Hierbei handelt es sich um die *geordnete Auswahl*, auch bekannt als *priorisierte Auswahl*.

**\[2\]**
: Für die Parsing-Ausdrücke **e1**, **e2**, … ist das Ergebnis von \[list x **e1** **e2** … \] ebenfalls ein Parsing-Ausdruck. Dies ist die *Sequenz*.

**\[3\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list \* **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist der *Kleene-Abschluss*, der null oder mehr Wiederholungen beschreibt.

**\[4\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list + **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist der *positive Kleene-Abschluss*, der eine oder mehrere Wiederholungen beschreibt.

**\[5\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list & **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist das *And-Lookahead-Prädikat*.

**\[6\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list ! **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist das *Not-Lookahead-Prädikat*.

**\[7\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list ? **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist die *optionale Eingabe*.


**Kanonische Serialisierung**
: Die kanonische Serialisierung eines Parsing-Ausdrucks hat das im vorherigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen dieses Parsing-Ausdrucks eindeutig ist.


**\[1\]**
: Die Zeichenfolgendarstellung des Werts entspricht der kanonischen Darstellung einer reinen Tcl-Liste. Das heißt, sie enthält keine überflüssigen Leerzeichen.

**\[2\]**
: Terminale werden *nicht* als Bereiche kodiert (bei denen Anfang und Ende des Bereichs identisch sind).


## Beispiel

Unter der Annahme, dass der auf der rechten Seite der Regel dargestellte Parsing-Ausdruck gilt

```
    Expression <- Term (AddOp Term)*
```

dann lautet seine kanonische Serialisierung (mit Ausnahme von Leerzeichen)

```
    {x {n Term} {* {x {n AddOp} {n Term}}}}
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pt* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Parser und Grammatiken

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
