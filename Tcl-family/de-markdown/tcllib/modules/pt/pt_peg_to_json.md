---
CommandName: pt::peg::to::json
title: pt::peg::to::json
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - EBNF
 - JSON
 - LL(k)
 - PEG
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

# Name

pt::peg::to::json – PEG-Konvertierung. Schreibt das Format JSON

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::peg::to::json]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [pt::peg]{.lit}
[package]{.cmd} [require]{.sub} [json::write]{.lit}
[pt::peg::to::json]{.cmd} [reset]{.lit}
[pt::peg::to::json]{.cmd} [configure]{.lit}
[pt::peg::to::json]{.cmd} [configure]{.lit} [option]{.arg}
[pt::peg::to::json]{.cmd} [configure]{.lit} [option]{.arg} [value...]{.arg}
[pt::peg::to::json]{.cmd} [convert]{.lit} [serial]{.arg}
:::

# Beschreibung

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket implementiert den Konverter, der Parsing Expression Grammars in JSON-Markup umwandelt.

Es befindet sich im Abschnitt „Export“ der Kernschicht der Parser-Tools und kann entweder direkt mit den anderen Paketen dieser Schicht oder indirekt über den von **pt::peg::export** bereitgestellten Export-Manager verwendet werden. Letzteres ist für den Einsatz in nicht vertrauenswürdigen Umgebungen vorgesehen und erfolgt über das entsprechende Export-Plugin **pt::peg::export::json**, das zwischen Konverter und Export-Manager angesiedelt ist.

Bild: arch\_core\_eplugins

# API

Die von diesem Paket bereitgestellte API entspricht der Spezifikation der Converter-API, die in der Spezifikation *Parser Tools Export API* zu finden ist.

**pt::peg::to::json** **reset**
: Dieser Befehl setzt die Konfiguration des Pakets auf die Standardeinstellungen zurück.

**pt::peg::to::json** **configure**
: Dieser Befehl gibt ein Dictionary zurück, das die aktuelle Konfiguration des Pakets enthält.

**pt::peg::to::json** **configure** *option*
: Dieser Befehl gibt den aktuellen Wert der angegebenen *option* des Pakets zurück. Die Liste der zulässigen Optionen finden Sie im Abschnitt [Optionen].

**pt::peg::to::json** **configure** *option* *value*...
: Dieser Befehl setzt die angegebenen *option*s des Pakets auf die angegebenen *value*s. Eine Übersicht über die zulässigen Optionen finden Sie im Abschnitt [Optionen].

**pt::peg::to::json** **convert** *serial*
: Dieser Befehl nimmt die kanonische Serialisierung einer Parsing-Expression-Grammatik entgegen, wie sie im Abschnitt [PEG-Serialisierungsformat] festgelegt ist und in *serial* enthalten ist, und generiert gemäß der aktuellen Paketkonfiguration ein JSON-Markup, das die Grammatik kodiert. Die erzeugte Zeichenkette wird anschließend als Ergebnis des Befehls zurückgegeben.


# Optionen

Der Konverter für das JSON-Grammatik-Austauschformat erkennt die folgenden Variablen der Konfiguration und passt sein Verhalten entsprechend ihrer Festlegung an.

**-file** string
: Der Wert dieser Option ist der Name der Datei oder einer anderen Einheit, aus der die Grammatik stammt und für die der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-name** string
: Der Wert dieser Option ist der Name der Grammatik, die wir gerade verarbeiten. Der Standardwert lautet **a\_pe\_grammar**.

**-user** string
: Der Wert dieser Option ist der Name des Benutzers, unter dem der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-indented** boolean
: Wenn diese Option aktiviert ist, teilt das System das generierte JSON-Objekt in Zeilen auf und rückt es entsprechend seiner inneren Struktur ein, wobei jeder Schlüssel eines Dictionarys in einer eigenen Zeile steht.

    Ist die Option nicht aktiviert (Standardeinstellung), wird das gesamte JSON-Objekt in einer einzigen Zeile ausgegeben, wobei der Abstand zwischen allen Elementen so gering wie möglich gehalten wird.

**-aligned** boolean
: Wenn diese Option aktiviert ist, sorgt das System dafür, dass die Werte der Schlüssel in einem Dictionary vertikal zueinander ausgerichtet sind, um einen ansprechenden Effekt wie bei einer Tabelle zu erzielen. Damit dies funktioniert, muss zudem die Option **-indented** gesetzt sein.

    Wenn die Option nicht gesetzt ist (Standardeinstellung), wird die Ausgabe gemäß dem Wert von **indented** formatiert, ohne dass versucht wird, die Werte der Dictionary-Schlüssel auszurichten.


# JSON-Austauschformat für Grammatiken

Das Format **json** für Parsing Expression Grammars wurde als Datenaustauschformat geschrieben, das nicht an Tcl gebunden ist. Es wurde definiert, um den Austausch von Grammatiken mit PackRat/PEG-basierten Parsergeneratoren für andere Sprachen zu ermöglichen.

Dies wird durch die folgenden Regeln formal festgelegt:

1. Das JSON-Format eines jeden PEG ist ein JSON-Objekt.

2. Dieses Objekt enthält einen einzigen Schlüssel, **pt::grammar::peg**, sowie dessen Wert. Dieser Wert enthält den Inhalt der Grammatik.

3. Der Inhalt der Grammatik ist ein JSON-Objekt, das die Menge der nichtterminalen Symbole und den Startausdruck enthält. Die relevanten Schlüssel und ihre Werte lauten

    **rules**
    : Der Wert ist ein JSON-Objekt, dessen Schlüssel die Namen der in der Grammatik bekannten nichtterminalen Symbole sind.

        1. Jedes nichtterminale Symbol darf nur einmal vorkommen.

        2. Die leere Zeichenkette ist kein zulässiges nichtterminales Symbol.

        3. Der Wert für jedes Symbol ist selbst ein JSON-Objekt. Die relevanten Schlüssel und ihre Werte in diesem Dictionary lauten

            **is**
            : Der Wert ist eine JSON-Zeichenkette, die die Tcl-Serialisierung des Parsing-Ausdrucks enthält, der die Satzstruktur des Symbols beschreibt, wie im Abschnitt [PE-Serialisierungsformat] festgelegt.

            **mode**
            : Der Wert ist ein JSON-Wert mit einem von drei Werten, die festlegen, wie ein Parser den durch das Symbol erzeugten semantischen Wert verarbeiten soll.

                **value**
                : Der semantische Wert des nichtterminalen Symbols ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminale selbst besteht, dessen Kindknoten die ASTs der rechten Seite des Symbols sind.

                **leaf**
                : Der semantische Wert des Nichtterminalsymbols ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminal besteht, der keine Kindknoten hat. Alle durch die rechte Seite des Symbols erzeugten ASTs werden verworfen.

                **void**
                : Das Nichtterminal hat keinen semantischen Wert. Alle ASTs, die durch die rechte Seite des Symbols erzeugt werden, werden (ebenfalls) verworfen.




    **start**
    : Der Wert ist eine JSON-Zeichenkette, die die Tcl-Serialisierung des Start-Parsing-Ausdrucks der Grammatik enthält, wie im Abschnitt [PE-Serialisierungsformat] beschrieben.


4. Die Terminalsymbole der Grammatik werden implizit als die Menge aller Terminalsymbole festgelegt, die im Startausdruck und auf der rechten Seite der Grammatikregeln verwendet werden.


Als Anmerkung für den fortgeschrittenen Leser: Dies entspricht im Wesentlichen der Tcl-Serialisierung von PEGs, wie sie im Abschnitt [PEG-Serialisierungsformat] festgelegt ist, nur dass die Tcl-Dictionaries und Listen dieses Formats auf JSON-Objekte und Arrays abgebildet werden. Lediglich die Parsing-Ausdrücke selbst werden nicht weiter übersetzt, sondern als JSON-Zeichenketten beibehalten, die eine verschachtelte Tcl-Liste enthalten, und auch für das JSON gibt es kein Konzept der Kanonizität.

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

Eine JSON-Serialisierung dafür lautet

```
{
    "pt::grammar::peg" : {
        "rules" : {
            "AddOp"     : {
                "is"   : "\/ {t -} {t +}",
                "mode" : "value"
            },
            "Digit"     : {
                "is"   : "\/ {t 0} {t 1} {t 2} {t 3} {t 4} {t 5} {t 6} {t 7} {t 8} {t 9}",
                "mode" : "value"
            },
            "Expression" : {
                "is"   : "\/ {x {t (} {n Expression} {t )}} {x {n Factor} {* {x {n MulOp} {n Factor}}}}",
                "mode" : "value"
            },
            "Factor"    : {
                "is"   : "x {n Term} {* {x {n AddOp} {n Term}}}",
                "mode" : "value"
            },
            "MulOp"     : {
                "is"   : "\/ {t *} {t \/}",
                "mode" : "value"
            },
            "Number"    : {
                "is"   : "x {? {n Sign}} {+ {n Digit}}",
                "mode" : "value"
            },
            "Sign"      : {
                "is"   : "\/ {t -} {t +}",
                "mode" : "value"
            },
            "Term"      : {
                "is"   : "n Number",
                "mode" : "value"
            }
        },
        "start" : "n Expression"
    }
}
```

und eine Tcl-Serialisierung davon lautet

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

Die Ähnlichkeit des Letzteren mit JSON dürfte ziemlich offensichtlich sein.

# PEG-Serialisierungsformat

Hier legen wir das Format fest, das von den Parser-Tools verwendet wird, um Parsing Expression Grammars als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Auch wenn eine PEG mehr als eine reguläre Serialisierung haben kann, ist jeweils genau eine davon *kanonisch*.

Reguläre Serialisierung
: 1. Die Serialisierung eines beliebigen PEG ist ein verschachteltes Tcl-Dictionary.

    2. Dieses Dictionary enthält einen einzigen Schlüssel, **pt::grammar::peg**, sowie dessen Wert. Dieser Wert enthält den Inhalt der Grammatik.

    3. Der Inhalt der Grammatik besteht aus einem Tcl-Dictionary, das die Menge der nichtterminalen Symbole und den Startausdruck enthält. Die relevanten Schlüssel und ihre Werte lauten

        **rules**
        : Der Wert ist ein Tcl-Dictionary, dessen Schlüssel die Namen der in der Grammatik bekannten nichtterminalen Symbole sind.

            1. Jedes nichtterminale Symbol darf nur einmal vorkommen.

            2. Die leere Zeichenkette ist kein zulässiges nichtterminales Symbol.

            3. Der Wert für jedes Symbol ist selbst ein Tcl-Dictionary. Die entsprechenden Schlüssel und ihre Werte in diesem Dictionary lauten

                **is**
                : Der Wert entspricht der Serialisierung des Parsing-Ausdrucks, der die Satzstruktur des Symbols beschreibt, wie im Abschnitt [PE-Serialisierungsformat] festgelegt.

                **mode**
                : Der Wert kann einer von drei Werten sein, die festlegen, wie ein Parser mit dem durch das Symbol erzeugten semantischen Wert umgehen soll.

                    **value**
                    : Der semantische Wert des nichtterminalen Symbols ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminale selbst besteht, dessen Kindknoten die ASTs der rechten Seite des Symbols sind.

                    **leaf**
                    : Der semantische Wert des Nichtterminalsymbols ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminal besteht, der keine Kindknoten hat. Alle durch die rechte Seite des Symbols erzeugten ASTs werden verworfen.

                    **void**
                    : Das Nichtterminal hat keinen semantischen Wert. Alle ASTs, die durch die rechte Seite des Symbols erzeugt werden, werden (ebenfalls) verworfen.




        **start**
        : Der Wert entspricht der Serialisierung des Start-Parsing-Ausdrucks der Grammatik, wie im Abschnitt [PE-Serialisierungsformat] beschrieben.


    4. Die Terminalsymbole der Grammatik werden implizit als die Menge aller Terminalsymbole festgelegt, die im Startausdruck und auf der rechten Seite der Grammatikregeln verwendet werden.


Kanonische Serialisierung
: Die kanonische Serialisierung einer Grammatik hat das im vorherigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen dieser Grammatik eindeutig ist.

    1. Die Schlüssel in allen verschachtelten Tcl-Dictionaries sind in aufsteigender Wörterbuchreihenfolge sortiert, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.

    2. Die Zeichenfolgendarstellung des Werts entspricht der kanonischen Darstellung eines Tcl-Dictionaries. Das heißt, sie enthält keine überflüssigen Leerzeichen.



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

# PE-Serialisierungsformat

Hier legen wir das Format fest, das von den Parser-Tools verwendet wird, um Parsing-Ausdrücke als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Auch wenn ein Parsing-Ausdruck mehr als eine reguläre Serialisierung aufweisen kann, ist jeweils genau eine davon *kanonisch*.

Reguläre Serialisierung
: siehe unten ...

    **Atomare Parsing-Ausdrücke**
    : 1. Die Zeichenfolge **epsilon** ist ein atomarer Parsing-Ausdruck. Sie passt auf die leere Zeichenfolge.

        2. Die Zeichenfolge **dot** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Zeichen.

        3. Die Zeichenfolge **alnum** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes alphabetische Unicode-Zeichen und jede Unicode-Ziffer. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        4. Die Zeichenfolge **alpha** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes alphabetische Unicode-Zeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        5. Die Zeichenfolge **ascii** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Zeichen unterhalb von U0080. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        6. Die Zeichenfolge **control** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Steuerzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        7. Die Zeichenfolge **digit** ist ein atomarer Parsing-Ausdruck. Sie passt auf jede Unicode-Ziffer. Das schließt auch Zeichen außerhalb des Bereichs \[0..9\] ein. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        8. Die Zeichenfolge **graph** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes druckbare Unicode-Zeichen außer dem Leerzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        9. Die Zeichenfolge **lower** ist ein atomarer Parsing-Ausdruck. Sie passt auf jeden Unicode-Kleinbuchstaben. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        10. Die Zeichenfolge **print** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes druckbare Unicode-Zeichen einschließlich des Leerzeichens. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        11. Die Zeichenfolge **punct** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Satzzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        12. Die Zeichenfolge **space** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Leerraumzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        13. Die Zeichenfolge **upper** ist ein atomarer Parsing-Ausdruck. Sie passt auf jeden Unicode-Großbuchstaben. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        14. Die Zeichenfolge **wordchar** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Wortzeichen. Das ist jedes alphanumerische Zeichen (siehe alnum) und jedes Verbindungssatzzeichen (zum Beispiel der Unterstrich). Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        15. Die Zeichenfolge **xdigit** ist ein atomarer Parsing-Ausdruck. Sie passt auf jede Hexadezimalziffer. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        16. Die Zeichenfolge **ddigit** ist ein atomarer Parsing-Ausdruck. Sie passt auf jede Dezimalziffer. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **regexp**.

        17. Der Ausdruck \[list t **x**\] ist ein atomarer Parsing-Ausdruck. Er passt auf die Terminalzeichenkette **x**.

        18. Der Ausdruck \[list n **A**\] ist ein atomarer Parsing-Ausdruck. Er passt auf das Nichtterminal **A**.


    **Zusammengesetzte Parsing-Ausdrücke**
    : 1. Für die Parsing-Ausdrücke **e1**, **e2**, … ist das Ergebnis von \[list / **e1** **e2** … \] ebenfalls ein Parsing-Ausdruck. Das ist die *geordnete Auswahl*, auch *priorisierte Auswahl* genannt.

        2. Für die Parsing-Ausdrücke **e1**, **e2**, … ist das Ergebnis von \[list x **e1** **e2** … \] ebenfalls ein Parsing-Ausdruck. Dies ist die *Sequenz*.

        3. Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list \* **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist der *Kleene-Abschluss*, der null oder mehr Wiederholungen beschreibt.

        4. Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list + **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist der *positive Kleene-Abschluss*, der eine oder mehrere Wiederholungen beschreibt.

        5. Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list & **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist das *And-Lookahead-Prädikat*.

        6. Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list ! **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist das *Not-Lookahead-Prädikat*.

        7. Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list ? **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist die *optionale Eingabe*.



Kanonische Serialisierung
: Die kanonische Serialisierung eines Parsing-Ausdrucks hat das im vorherigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen dieses Parsing-Ausdrucks eindeutig ist.

    1. Die Zeichenfolgendarstellung des Werts entspricht der kanonischen Darstellung einer reinen Tcl-Liste. Das heißt, sie enthält keine überflüssigen Leerzeichen.

    2. Terminale werden *nicht* als Bereiche kodiert (bei denen Anfang und Ende des Bereichs identisch sind).



## Beispiel

Unter der Annahme, dass der auf der rechten Seite der Regel dargestellte Parsing-Ausdruck gilt

```
    Expression <- Term (AddOp Term)*
```

dann lautet seine kanonische Serialisierung (mit Ausnahme von Leerzeichen)

```
    {x {n Term} {* {x {n AddOp} {n Term}}}}
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pt* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Parser und Grammatiken

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
