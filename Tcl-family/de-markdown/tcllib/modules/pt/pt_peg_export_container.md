---
CommandName: pt::peg::export::container
title: pt::peg::export::container
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - CONTAINER
 - EBNF
 - LL(k)
 - PEG
 - TDPL
 - context-free languages
 - export
 - expression
 - grammar
 - matching
 - parser
 - parsing expression
 - parsing expression grammar
 - plugin
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

pt::peg::export::container – PEG-Export-Plugin. CONTAINER-Format schreiben

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::peg::export::container]{.lit} [1]{.optlit}
[package]{.cmd} [require]{.sub} [pt::peg::to::container]{.lit}
[export]{.cmd} [serial]{.arg} [configuration]{.arg}
:::

# Beschreibung

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket implementiert das Export-Plugin für Parsing Expression Grammars zur Erzeugung von CONTAINER-Markup.

Es befindet sich im Abschnitt „Export“ der Kernschicht der Parser-Tools und ist für die Verwendung durch **pt::peg::export**, den Exportmanager, vorgesehen, der zwischen diesem und der entsprechenden Kernkonvertierungsfunktionalität, die von [pt::peg::to::container][pt_peg_to_container] bereitgestellt wird, angesiedelt ist.

IMAGE: arch\_core\_eplugins

Zwar ist die direkte Verwendung dieses Pakets mit einem herkömmlichen Interpreter möglich, doch wird davon dringend abgeraten, da hierfür eine Reihe von Umwegen erforderlich ist, um die erwartete Umgebung bereitzustellen. Die richtige Vorgehensweise bei der Nutzung dieser Funktionalität hängt von der jeweiligen Situation ab:

1. In einer nicht vertrauenswürdigen Umgebung erfolgt der ordnungsgemäße Zugriff über das Paket **pt::peg::export** und die darin bereitgestellten Exportmanager-Objekte.

2. In einer vertrauenswürdigen Umgebung wird einfach das Paket [pt::peg::to::container][pt_peg_to_container] verwendet und direkt auf die zentralen Konvertierungsfunktionen zugegriffen.


# API

Die von diesem Paket bereitgestellte API entspricht der Spezifikation der Plugin-API, die in der Spezifikation *Parser Tools Export API* zu finden ist.

**export** *serial* *configuration*
: Dieser Befehl nimmt die kanonische Serialisierung einer Parsing Expression Grammar entgegen, wie sie im Abschnitt [PEG-Serialisierungsformat] festgelegt ist und in *serial* enthalten ist, sowie die *configuration*, ein Dictionary, und generiert CONTAINER-Markup, das die Grammatik kodiert. Die erzeugte Zeichenkette wird anschließend als Ergebnis des Befehls zurückgegeben.


# Konfiguration

Das CONTAINER-Export-Plugin erkennt die folgenden Konfigurationsvariablen und passt sein Verhalten entsprechend deren Vorgaben an.

enum *mode*
: Der Wert dieser Konfigurationsvariablen legt fest, welche Methoden von **pt::peg**-Instanzen das Plugin zur Festlegung der Grammatik verwendet. Es gibt zwei zulässige Werte

    **bulk**
    : In diesem Modus werden die Methoden **start**, **add**, **modes** und **rules** verwendet, um die Grammatik pauschal festzulegen, d. h. als eine Menge von nichtterminalen Symbolen sowie zwei Dictionarys, die die Symbole ihren semantischen Modi und Parsing-Ausdrücken zuordnen.

        Dieser Modus ist der Standardmodus.

    **incremental**
    : In diesem Modus werden die Methoden **start**, **add**, **mode** und **rule** verwendet, um die Grammatik stückweise festzulegen, wobei jedes Nichtterminal über einen eigenen Block von Definitionsbefehlen verfügt.


string *template*
: Wenn diese Konfigurationsvariable gesetzt ist, wird davon ausgegangen, dass sie eine Zeichenkette enthält, in die der generierte Code und andere Konfigurationsdaten eingefügt werden sollen. Es wird erwartet, dass die verschiedenen Stellen mit den folgenden Platzhaltern angegeben werden:

    **@user@**
    : Ist durch den Wert der Konfigurationsvariablen **user** zu ersetzen.

    **@format@**
    : Ist durch die Konstante **CONTAINER** zu ersetzen.

    **@file@**
    : Ist durch den Wert der Konfigurationsvariablen **file** zu ersetzen.

    **@name@**
    : Ist durch den Wert der Konfigurationsvariablen **name** zu ersetzen.

    **@mode@**
    : Ist durch den Wert der Konfigurationsvariablen **mode** zu ersetzen.

    **@code@**
    : Wird durch den generierten Code ersetzt.


    Wenn diese Konfigurationsvariable nicht gesetzt oder leer ist, greift das Plugin auf eine Standardvorlage zurück, die als **@code@** definiert ist.


*Hinweis*: Dieses Plugin ignoriert je nach gewählter Vorlage die Standard-Konfigurationsvariablen **user**, **format**, **file** und ihre Werte.

Der Wert der Standardkonfigurationsvariablen **name** wird, wenn er festgelegt ist, als Name der Grammatik in der Ausgabe verwendet. Andernfalls greift das Plugin auf den Standardnamen **a\_pe\_grammar** zurück.

# Grammatik-Container

Das Format **container** ist eine weitere Form, Parsing Expression Grammars zu beschreiben. Zwar sind Daten in diesem Format ausführbar, sie stellen jedoch keinen Parser für die Grammatik dar. Sie müssen stets in Verbindung mit dem Paket **pt::peg::interp**, einem Grammatik-Interpreter, verwendet werden.

Das Format stellt Grammatiken mittels einer **snit::type** dar, d. h. einer Klasse, deren Instanzen API-kompatibel zu den Instanzen des Pakets **pt::peg::container** sind und die mit der jeweiligen Grammatik vorbelegt sind.

Es gibt keine direkte formale Spezifikation, die über das oben Gesagte hinausgeht.

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

Eine mögliche Container-Serialisierung hierfür lautet

```
snit::type a_pe_grammar {
    constructor {} {
        install myg using pt::peg::container ${selfns}::G
        $myg start {n Expression}
        $myg add   AddOp Digit Expression Factor MulOp Number Sign Term
        $myg modes {
            AddOp      value
            Digit      value
            Expression value
            Factor     value
            MulOp      value
            Number     value
            Sign       value
            Term       value
        }
        $myg rules {
            AddOp      {/ {t -} {t +}}
            Digit      {/ {t 0} {t 1} {t 2} {t 3} {t 4} {t 5} {t 6} {t 7} {t 8} {t 9}}
            Expression {/ {x {t \50} {n Expression} {t \51}} {x {n Factor} {* {x {n MulOp} {n Factor}}}}}
            Factor     {x {n Term} {* {x {n AddOp} {n Term}}}}
            MulOp      {/ {t *} {t /}}
            Number     {x {? {n Sign}} {+ {n Digit}}}
            Sign       {/ {t -} {t +}}
            Term       {n Number}
        }
        return
    }

    component myg
    delegate method * to myg
}
```

# PEG-Serialisierungsformat

Hier legen wir das Format fest, das von den Parser-Tools verwendet wird, um Parsing Expression Grammars als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Auch wenn ein PEG mehr als eine reguläre Serialisierung haben kann, ist jeweils genau eine davon *kanonisch*.

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
    : 1. Für die Parsing-Ausdrücke **e1**, **e2**, … ist das Ergebnis von \[list / **e1** **e2** … \] ebenfalls ein Parsing-Ausdruck. Hierbei handelt es sich um die *geordnete Auswahl*, auch bekannt als *priorisierte Auswahl*.

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


[pt_peg_to_container]: pt_peg_to_container.md
