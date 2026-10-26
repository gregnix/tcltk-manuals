---
CommandName: pt::peg::to::tclparam
ManualSection: n
Version: 1.0.4
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - EBNF
 - LL(k)
 - PEG
 - TCLPARAM
 - TDPL
 - context-free languages
 - conversion
 - expression
 - format conversion
 - grammar
 - matching
 - parser
 - parsing expression
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - serialization
 - state
 - top-down parsing languages
 - transducer
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

pt::peg::to::tclparam – PEG-Konvertierung. Schreibt das Format TCLPARAM

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pt::peg::to::tclparam]{.lit} [1.0.4]{.optlit} 
[pt::peg::to::tclparam]{.cmd} [reset]{.sub} 
[pt::peg::to::tclparam]{.cmd} [configure]{.sub} 
[pt::peg::to::tclparam]{.cmd} [configure]{.sub} [option]{.arg} 
[pt::peg::to::tclparam]{.cmd} [configure]{.sub} [option]{.arg} [value...]{.arg} 
[pt::peg::to::tclparam]{.cmd} [convert]{.sub} [serial]{.arg} 
:::

# BESCHREIBUNG

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket implementiert den Konverter zur Umwandlung von Parsing Expression Grammars in TCLPARAM-Markup.

Es befindet sich im Abschnitt „Export“ der Kernschicht der Parser-Tools und kann entweder direkt mit den anderen Paketen dieser Schicht oder indirekt über den von **pt::peg::export** bereitgestellten Export-Manager verwendet werden. Letzteres ist für den Einsatz in nicht vertrauenswürdigen Umgebungen vorgesehen und erfolgt über das entsprechende Export-Plugin **pt::peg::export::tclparam**, das zwischen Konverter und Export-Manager angesiedelt ist.

Bild: arch_core_eplugins

# API

Die von diesem Paket bereitgestellte API entspricht der Spezifikation der Converter-API, die in der Spezifikation *Parser Tools Export API* zu finden ist.

**pt::peg::to::tclparam** **reset**
: Dieser Befehl setzt die Konfiguration des Pakets auf die Standardeinstellungen zurück.

**pt::peg::to::tclparam** **configure**
: Dieser Befehl gibt ein Dictionary zurück, das die aktuelle Konfiguration des Pakets enthält.

**pt::peg::to::tclparam** **configure** *option*
: Dieser Befehl gibt den aktuellen Wert der angegebenen *option* des Pakets zurück. Die Liste der zulässigen Optionen finden Sie im Abschnitt **OPTIONEN**.

**pt::peg::to::tclparam** **configure** *option* *value*...
: Dieser Befehl setzt die angegebenen *option*s des Pakets auf die angegebenen *value*s. Eine Übersicht über die zulässigen Optionen finden Sie im Abschnitt **OPTIONEN**.

**pt::peg::to::tclparam** **convert** *serial*
: Dieser Befehl nimmt die kanonische Serialisierung einer Parsing-Expression-Grammatik entgegen, wie sie im Abschnitt **PEG-SERIALISIERUNGSFORMAT** festgelegt ist und in *serial* enthalten ist, und generiert gemäß der aktuellen Paketkonfiguration ein TCLPARAM-Markup, das die Grammatik kodiert. Die erzeugte Zeichenkette wird anschließend als Ergebnis des Befehls zurückgegeben.


# OPTIONEN

Der Konverter für das Tcl/PARAM-Markup erkennt die folgenden Konfigurationsvariablen und passt sein Verhalten entsprechend deren Vorgaben an.

**-template** string
: Der Wert dieser Konfigurationsvariablen ist eine Zeichenkette, in die der generierte Text und die übrigen Konfigurationseinstellungen eingefügt werden sollen. Es wird erwartet, dass die verschiedenen Speicherorte für Benutzerdaten mithilfe der unten aufgeführten Platzhalter angegeben werden. Der Standardwert lautet „**@code@**“.


**@user@**
: Ist durch den Wert der Konfigurationsvariablen **-user** zu ersetzen.

**@format@**
: Ist durch die Konstante **Tcl/PARAM** zu ersetzen.

**@file@**
: Ist durch den Wert der Konfigurationsvariablen **-file** zu ersetzen.

**@name@**
: Ist durch den Wert der Konfigurationsvariablen **-name** zu ersetzen.

**@code@**
: Wird durch den generierten Tcl-Code ersetzt.


: Die folgenden Konfigurationsvariablen sind insofern besonders, als sie im generierten Code vorkommen und dort ebenfalls ersetzt werden.


**@runtime@**
: Ist durch den Wert der Konfigurationsvariablen **runtime-command** zu ersetzen.

**@self@**
: Ist durch den Wert der Konfigurationsvariablen **self-command** zu ersetzen.

**@def@**
: Ist durch den Wert der Konfigurationsvariablen **proc-command** zu ersetzen.

**@ns@**
: Ist durch den Wert der Konfigurationsvariablen **namespace** zu ersetzen.

**@main@**
: Ist durch den Wert der Konfigurationsvariablen **main** zu ersetzen.

**@prelude@**
: Ist durch den Wert der Konfigurationsvariablen **prelude** zu ersetzen.


**-name** string
: Der Wert dieser Konfigurationsvariablen ist der Name der Grammatik, für die die Konvertierung durchgeführt wird. Der Standardwert lautet **a_pe_grammar**.

**-user** string
: Der Wert dieser Konfigurationsvariablen ist der Name des Benutzers, für den die Konvertierung durchgeführt wird. Der Standardwert lautet **unknown**.

**-file** string
: Der Wert dieser Konfigurationsvariablen ist der Name der Datei oder einer anderen Einheit, aus der die Grammatik stammt und für die die Konvertierung durchgeführt wird. Der Standardwert lautet **unknown**.

**-runtime-command** string
: Eine Tcl-Zeichenkette, die den Tcl-Befehl oder einen Verweis darauf darstellt, der zum Aufruf der PARAM-Anweisung aus Parser-Prozeduren gemäß dem gewählten Rahmen (Template) verwendet wird. Der Standardwert ist die leere Zeichenkette.

**-self-command** string
: Eine Tcl-Zeichenkette, die den Tcl-Befehl oder einen Verweis darauf darstellt, der verwendet wird, um die Parser-Prozeduren (Methoden …) aus einer anderen Parser-Prozedur heraus aufzurufen, entsprechend dem gewählten Rahmen (Template). Der Standardwert ist die leere Zeichenkette.

**-proc-command** string
: Der Name des Tcl-Befehls, der zur Definition von Prozeduren (Methoden …) verwendet wird, je nach gewähltem Rahmen (Template). Der Standardwert lautet **proc**.

**-namespace** string
: Der Name des Namespaces, in dem sich die Parser-Prozeduren (Methoden, …) befinden sollen, einschließlich des abschließenden „::“, das zur Trennung vom eigentlichen Prozedurnamen erforderlich ist. Der Standardwert ist **::**.

**-main** string
: Der Name der Hauptprozedur (Methode, …), die vom ausgewählten Rahmen (Template) aufgerufen werden soll, um mit der Analyse der Eingabe zu beginnen. Der Standardwert lautet **\__main**.

**-prelude** string
: Ein Codeausschnitt, der am Anfang jedes generierten Parsing-Befehls eingefügt werden soll. Der Standardwert ist die leere Zeichenkette.

**-indent** integer
: Die Anzahl der Zeichen, um die jede Zeile des generierten Codes eingerückt werden soll. Der Standardwert lautet **0**. Die hohe Parametrierbarkeit dieses Konverters, die sich in der Vielzahl der unterstützten Optionen zeigt, ist zwar für fortgeschrittene Benutzer ein Vorteil, da sie die Ausgabe des Konverters nach Bedarf anpassen können, doch für Anfänger wird der Wald vor lauter Bäumen wahrscheinlich nicht mehr zu erkennen sein. Um diesen Anwendern zu helfen, werden zwei Zusatzpakete bereitgestellt, die jeweils eine vorgefertigte Konfiguration enthalten, mit der sich sofort einsatzbereite vollständige Parser generieren lassen. Diese sind

**pt::tclparam::configuration::snit**
: Die generierten Parser sind Klassen, die auf dem Paket **snit** basieren, d. h. auf snit::type.

**pt::tclparam::configuration::tcloo**
: Die generierten Parser sind Klassen, die auf dem Paket **OO** basieren.


# TCL/PARAM-CODE-DARSTELLUNG VON PARSING-EXPRESSION-GRAMMATIKEN

Die Tcl/PARAM-Darstellung von Parsing Expression Grammars ist Tcl-Code, dessen Ausführung die Eingabe gemäß der Grammatik analysiert. Der Code basiert auf der in der *PackRat Machine Specification* dokumentierten virtuellen Maschine und verwendet deren Befehle sowie einige zusätzliche Befehle zur Steuerung des Kontrollflusses.

Hinweis: Der generierte Code für sich genommen ist nicht funktionsfähig. Er muss in einen Rahmen eingebettet werden, der Dienste wie den PARAM-Zustand, Implementierungen für die PARAM-Befehle usw. bereitstellt. Der Großteil eines solchen Rahmens muss über die Option **-template** festgelegt werden. Die zusätzlichen Optionen

**-indent** integer
: ...siehe nächstes...

**-main** string
: ...siehe nächstes...

**-namespace** string
: ...siehe nächstes...

**-prelude** string
: ...siehe nächstes...

**-proc-command** string
: ...siehe nächstes...

**-runtime-command** string
: ...siehe nächstes...

**-self-command** string
: stellen Codeausschnitte bereit, die den Rahmen und den erzeugten Code verbinden. Die entsprechenden Platzhalter befinden sich im *generierten* Code.


# PEG-SERIALISIERUNGSFORMAT

Hier legen wir das Format fest, das von den Parser-Tools verwendet wird, um Parsing Expression Grammars als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Auch wenn eine PEG mehr als eine reguläre Serialisierung haben kann, ist jeweils genau eine davon *kanonisch*.

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
: Für die Parsing-Ausdrücke **e1**, **e2**, … ist das Ergebnis von \[list / **e1** **e2** … \] ebenfalls ein Parsing-Ausdruck. Das ist die *geordnete Auswahl*, auch *priorisierte Auswahl* genannt.

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
