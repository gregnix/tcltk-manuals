---
CommandName: pt::peg::to::peg
ManualSection: n
Version: 1.0.3
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - EBNF
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

# NAME

pt::peg::to::peg – PEG-Konvertierung. Schreibt das Format PEG

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pt::peg::to::peg]{.lit} [1.0.3]{.optlit} 
[package]{.cmd} [require]{.sub} [pt::peg]{.lit} 
[package]{.cmd} [require]{.sub} [pt::pe]{.lit} 
[package]{.cmd} [require]{.sub} [text::write]{.lit} 
[pt::peg::to::peg]{.cmd} [reset]{.sub} 
[pt::peg::to::peg]{.cmd} [configure]{.sub} 
[pt::peg::to::peg]{.cmd} [configure]{.sub} [option]{.arg} 
[pt::peg::to::peg]{.cmd} [configure]{.sub} [option]{.arg} [value...]{.arg} 
[pt::peg::to::peg]{.cmd} [convert]{.sub} [serial]{.arg} 
:::

# BESCHREIBUNG

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket implementiert den Konverter, der Parsing Expression Grammars in PEG-Markup umwandelt.

Es befindet sich im Abschnitt „Export“ der Kernschicht der Parser-Tools und kann entweder direkt mit den anderen Paketen dieser Schicht oder indirekt über den von **pt::peg::export** bereitgestellten Export-Manager verwendet werden. Letzteres ist für den Einsatz in nicht vertrauenswürdigen Umgebungen vorgesehen und erfolgt über das entsprechende Export-Plugin **pt::peg::export::peg**, das zwischen Konverter und Export-Manager angesiedelt ist.

Bild: arch_core_eplugins

# API

Die von diesem Paket bereitgestellte API entspricht der Spezifikation der Converter-API, die in der Spezifikation *Parser Tools Export API* zu finden ist.

**pt::peg::to::peg** **reset**
: Dieser Befehl setzt die Konfiguration des Pakets auf die Standardeinstellungen zurück.

**pt::peg::to::peg** **configure**
: Dieser Befehl gibt ein Dictionary zurück, das die aktuelle Konfiguration des Pakets enthält.

**pt::peg::to::peg** **configure** *option*
: Dieser Befehl gibt den aktuellen Wert der angegebenen *option* des Pakets zurück. Die Liste der zulässigen Optionen finden Sie im Abschnitt **OPTIONEN**.

**pt::peg::to::peg** **configure** *option* *value*...
: Dieser Befehl setzt die angegebenen *option*s des Pakets auf die angegebenen *value*s. Eine Übersicht über die zulässigen Optionen finden Sie im Abschnitt **OPTIONEN**.

**pt::peg::to::peg** **convert** *serial*
: Dieser Befehl nimmt die kanonische Serialisierung einer Parsing-Expression-Grammatik entgegen, wie sie im Abschnitt **PEG-SERIALISIERUNGSFORMAT** festgelegt ist und in *serial* enthalten ist, und generiert gemäß der aktuellen Paketkonfiguration ein PEG-Markup, das die Grammatik kodiert. Die erzeugte Zeichenkette wird anschließend als Ergebnis des Befehls zurückgegeben.


# OPTIONEN

Der Konverter in die PEG-Sprache erkennt die folgenden Optionen und passt sein Verhalten entsprechend der dort festgelegten Vorgabe an.

**-file** string
: Der Wert dieser Option ist der Name der Datei oder einer anderen Einheit, aus der die Grammatik stammt und für die der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-name** string
: Der Wert dieser Option ist der Name der Grammatik, die wir gerade verarbeiten. Der Standardwert lautet **a_pe_grammar**.

**-user** string
: Der Wert dieser Option ist der Name des Benutzers, unter dem der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-template** string
: Der Wert dieser Option ist eine Zeichenkette, in die der generierte Text und die Werte der anderen Optionen eingefügt werden sollen. Es wird erwartet, dass die verschiedenen Speicherorte für Benutzerdaten mit den unten aufgeführten Platzhaltern angegeben werden. Der Standardwert lautet „**@code@**“.


**@user@**
: Ist durch den Wert der Option **-user** zu ersetzen.

**@format@**
: Ist durch die Konstante **PEG** zu ersetzen.

**@file@**
: Ist durch den Wert der Option **-file** zu ersetzen.

**@name@**
: Ist durch den Wert der Option **-name** zu ersetzen.

**@code@**
: Wird durch den generierten Text ersetzt.


# PEG-SPEZIFIKATIONSSPRACHE

**peg**, eine Sprache zur Spezifikation von Parsing-Expression-Grammatiken, soll sowohl für Menschen lesbar als auch schreibbar sein, dabei jedoch streng genug, um eine maschinelle Verarbeitung zu ermöglichen. Wie jede Computersprache. Sie wurde definiert, um das Verfassen einer Grammatik-Spezifikation zu vereinfachen – etwas, wofür sich die anderen in den Parser-Tools vorhandenen Formate nicht eignen.

Sie wird formal durch die unten gezeigte Grammatik festgelegt, die in sich selbst geschrieben ist. Eine Einführung in die Sprache steht im *PEG Language Tutorial*.

```
PEG pe_grammar_for_peg (Grammar)

	# --------------------------------------------------------------------
        # Syntactical constructs

        Grammar         <- WHITESPACE Header Definition* Final EOF ;

        Header          <- PEG Identifier StartExpr ;
        Definition      <- Attribute? Identifier IS Expression SEMICOLON ;
        Attribute       <- (VOID / LEAF) COLON ;
        Expression      <- Sequence (SLASH Sequence)* ;
        Sequence        <- Prefix+ ;
        Prefix          <- (AND / NOT)? Suffix ;
        Suffix          <- Primary (QUESTION / STAR / PLUS)? ;
        Primary         <- ALNUM / ALPHA / ASCII / CONTROL / DDIGIT / DIGIT
                        /  GRAPH / LOWER / PRINTABLE / PUNCT / SPACE / UPPER
                        /  WORDCHAR / XDIGIT
                        / Identifier
                        /  OPEN Expression CLOSE
                        /  Literal
                        /  Class
                        /  DOT
                        ;
        Literal         <- APOSTROPH  (!APOSTROPH  Char)* APOSTROPH  WHITESPACE
                        /  DAPOSTROPH (!DAPOSTROPH Char)* DAPOSTROPH WHITESPACE ;
        Class           <- OPENB (!CLOSEB Range)* CLOSEB WHITESPACE ;
        Range           <- Char TO Char / Char ;

        StartExpr       <- OPEN Expression CLOSE ;
void:   Final           <- "END" WHITESPACE SEMICOLON WHITESPACE ;

        # --------------------------------------------------------------------
        # Lexing constructs

        Identifier      <- Ident WHITESPACE ;
leaf:   Ident           <- ([_:] / <alpha>) ([_:] / <alnum>)* ;
        Char            <- CharSpecial / CharOctalFull / CharOctalPart
                        /  CharUnicode / CharUnescaped
                        ;

leaf:   CharSpecial     <- "\\" [nrt'"\[\]\\] ;
leaf:   CharOctalFull   <- "\\" [0-3][0-7][0-7] ;
leaf:   CharOctalPart   <- "\\" [0-7][0-7]? ;
leaf:   CharUnicode     <- "\\" 'u' HexDigit (HexDigit (HexDigit HexDigit?)?)? ;
leaf:   CharUnescaped   <- !"\\" . ;

void:   HexDigit        <- [0-9a-fA-F] ;

void:   TO              <- '-'           ;
void:   OPENB           <- "["           ;
void:   CLOSEB          <- "]"           ;
void:   APOSTROPH       <- "'"           ;
void:   DAPOSTROPH      <- '"'           ;
void:   PEG             <- "PEG" !([_:] / <alnum>) WHITESPACE ;
void:   IS              <- "<-"    WHITESPACE ;
leaf:   VOID            <- "void"  WHITESPACE ; # Implies that definition has no semantic value.
leaf:   LEAF            <- "leaf"  WHITESPACE ; # Implies that definition has no terminals.
void:   SEMICOLON       <- ";"     WHITESPACE ;
void:   COLON           <- ":"     WHITESPACE ;
void:   SLASH           <- "/"     WHITESPACE ;
leaf:   AND             <- "&"     WHITESPACE ;
leaf:   NOT             <- "!"     WHITESPACE ;
leaf:   QUESTION        <- "?"     WHITESPACE ;
leaf:   STAR            <- "*"     WHITESPACE ;
leaf:   PLUS            <- "+"     WHITESPACE ;
void:   OPEN            <- "("     WHITESPACE ;
void:   CLOSE           <- ")"     WHITESPACE ;
leaf:   DOT             <- "."     WHITESPACE ;

leaf:   ALNUM           <- "<alnum>"    WHITESPACE ;
leaf:   ALPHA           <- "<alpha>"    WHITESPACE ;
leaf:   ASCII           <- "<ascii>"    WHITESPACE ;
leaf:   CONTROL         <- "<control>"  WHITESPACE ;
leaf:   DDIGIT          <- "<ddigit>"   WHITESPACE ;
leaf:   DIGIT           <- "<digit>"    WHITESPACE ;
leaf:   GRAPH           <- "<graph>"    WHITESPACE ;
leaf:   LOWER           <- "<lower>"    WHITESPACE ;
leaf:   PRINTABLE       <- "<print>"    WHITESPACE ;
leaf:   PUNCT           <- "<punct>"    WHITESPACE ;
leaf:   SPACE           <- "<space>"    WHITESPACE ;
leaf:   UPPER           <- "<upper>"    WHITESPACE ;
leaf:   WORDCHAR        <- "<wordchar>" WHITESPACE ;
leaf:   XDIGIT          <- "<xdigit>"   WHITESPACE ;

void:   WHITESPACE      <- (" " / "\t" / EOL / COMMENT)* ;
void:   COMMENT         <- '#' (!EOL .)* EOL ;
void:   EOL             <- "\n\r" / "\n" / "\r" ;
void:   EOF             <- !. ;

        # --------------------------------------------------------------------
END;
```

## Beispiel

Unser Beispiel legt die Grammatik eines einfachen Taschenrechners mit vier Grundrechenarten fest.

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

Mit höherwertigen Merkmalen der Notation, also den Zeichenklassen (vordefiniert und selbst definiert), lässt sich dieses Beispiel so umschreiben:

```
PEG calculator (Expression)
    Sign       <- [-+]                                          ;
    Number     <- Sign? <ddigit>+                               ;
    Expression <- Term (AddOp Term)*                            ;
    MulOp      <- [*/]						;
    Term       <- Factor (MulOp Factor)*                        ;
    AddOp      <- [-+]						;
    Factor     <- '(' Expression ')' / Number                   ;
END;
```

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
