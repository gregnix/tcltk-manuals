---
CommandName: pt::peg_language
ManualSection: n
Version: 1.1
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

pt::peg_language – Tutorium zur PEG-Sprache

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
:::

# BESCHREIBUNG

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Willkommen zum Tutorial bzw. zur Einleitung in die **PEG-SPEZIFIKATIONSSPRACHE**. Wenn Sie bereits mit der Sprache, die wir im Folgenden behandeln werden, vertraut sind und lediglich Ihr Gedächtnis auffrischen möchten, können Sie natürlich direkt zum oben genannten Abschnitt springen und dort die vollständige formale Spezifikation lesen.

# WAS IST DAS?

**peg**, eine Sprache zur Spezifikation von Parsing-Expression-Grammatiken, soll sowohl für Menschen lesbar als auch schreibbar sein, dabei jedoch streng genug, um eine maschinelle Verarbeitung zu ermöglichen. Wie jede Computersprache. Sie wurde definiert, um das Verfassen einer Grammatik-Spezifikation zu vereinfachen – etwas, wofür sich die anderen in den Parser-Tools vorhandenen Formate nicht eignen.

# DIE ELEMENTE DER SPRACHE

## Grundlegender Aufbau

Die allgemeine Gliederung einer textbasierten PEG sieht wie folgt aus:

```
PEG <<name>> (<<start-expression>>)
   <<rules>>
END;
```

*Hinweis*: Wir verwenden Text in doppelten spitzen Klammern als Platzhalter für noch nicht erläuterte Begriffe.

## Namen

Namen werden hauptsächlich zur Identifizierung der nichtterminalen Symbole der Grammatik verwendet, d. h. der Elemente, die auf der linken Seite eines \<rule> stehen. Eine Ausnahme bildet der Name, der nach dem Schlüsselwort **PEG** angegeben wird (siehe vorherigen Abschnitt); dabei handelt es sich um den Namen der gesamten Grammatik selbst.

Der Aufbau eines Namens ist einfach:

**\[1\]**
: Es beginnt mit einem Buchstaben, einem Unterstrich oder einem Doppelpunkt, gefolgt von

**\[2\]**
: null oder mehr Buchstaben, Ziffern, Unterstriche oder Doppelpunkte. Oder, in der formalen Textnotation:


```
    ([_:] / <alpha>) ([_:] / <alnum>)*
```

Beispiele für Namen:

```
    Hello
    ::world
    _:submarine55_
```

Beispiele für Text, bei dem es sich *nicht* um Namen handelt:

```
    12
    .bogus
    0wrong
    @location
```

## Regeln

Den Hauptteil des Textes einer Grammatikbeschreibung bilden die Regeln. Jede Regel definiert die Satzstruktur eines nichtterminalen Symbols. Ihre Grundstruktur lautet

```
     <<name>>  <-  <<expression>> ;
```

Mit \<name> wird das zu definierende nichtterminale Symbol festgelegt, während \<expression> nach dem Pfeil (<-) dessen Struktur deklariert.

Hinweis: Jede Regel endet mit einem einzelnen Semikolon, auch die letzte. Das heißt, das Semikolon dient als *Regelabschluss*, nicht als Trennzeichen.

Wir können so viele Regeln haben, wie wir möchten, solange wir jedes nichtterminale Symbol höchstens einmal definieren und für jedes nichtterminale Symbol, das in einem Ausdruck vorkommt – d. h. entweder im Startausdruck der Grammatik oder auf der rechten Seite einer Regel –, mindestens eine Regel vorsehen.

## Ausdrücke

Die *Parsing*-Ausdrücke bilden den Kern jeder Spezifikation. Sie legen die Struktur des gesamten Dokuments (<\<start-expression>>) sowie aller nichtterminalen Symbole fest.

Alle Ausdrücke setzen sich aus *atomaren Ausdrücken* und *Operatoren* zusammen, die diese miteinander verbinden. Es gibt Operatoren zur Auswahl zwischen Alternativen, zur Wiederholung von Teilen und für Vorausschau-Bedingungen. Es gibt jedoch keinen expliziten Operator für die Aneinanderreihung (auch als *Verkettung* bezeichnet) von Teilen. Diese wird durch die einfache Platzierung der Teile nebeneinander festgelegt.

Hier sind die Operatoren, geordnet nach ihrer Priorität (d. h. der Stärke der Bindung), vom höchsten zum niedrigsten Wert:

```
    # Binary operators.

    <<expression-1>>     <<expression-2>>  # sequence. parse 1, then 2.
    <<expression-1>>  /  <<expression-2>>  # alternative. try to parse 1, and parse 2 if 1 failed to parse.

    # Prefix operators. Lookahead constraints. Same priority.

    & <<expression>>  # Parse expression, ok on successful parse.
    ! <<expression>>  # Ditto, except ok on failure to parse.

    # Suffix operators. Repetition. Same priority.

    <<expression>> ?  # Parse expression none, or once (repeat 0 or 1).
    <<expression>> *  # Parse expression zero or more times.
    <<expression>> +  # Parse expression one or more times.

    # Expression nesting

    ( <<expression>> ) # Put an expression in parens to change its priority.
```

Damit können wir nun den im Abschnitt **Namen** angegebenen formalen Ausdruck für Namen zerlegen:

```
    ([_:] / <alpha>) ([_:] / <alnum>)*
```

Es ist eine Sequenz aus zwei Teilen,

```
    [_:] / <alpha>
```

und

```
    ([_:] / <alnum>)*
```

Die Klammern um die Teile hielten deren innere Alternativen trotz der normalerweise höheren Priorität der Sequenz zusammen. Jeder der beiden Teile stellt eine Alternative dar, wobei der zweite Teil zusätzlich null- oder mehrmals wiederholt wird, sodass wir die folgenden drei atomaren Ausdrücke erhalten:

```
    [_:]
    <alpha>
    <alnum>
```

Und *atomare Ausdrücke* sind unser nächstes Thema. Sie lassen sich in drei Klassen einteilen:

**\[1\]**
: Namen, d. h. nichtterminale Symbole,

**\[2\]**
: Zeichenfolgenliterale und

**\[3\]**
: Zeichenklassen. Die Namen sind Ihnen bereits bekannt; falls nicht, lesen Sie bitte den Abschnitt **Namen** zur Auffrischung. Zeichenfolgenliterale sind einfach. Sie werden entweder durch ein einfaches oder ein doppeltes Apostroph begrenzt (d. h., sie beginnen und enden damit), und zwischen den Begrenzungszeichen können beliebige Zeichen stehen, mit Ausnahme des Begrenzungszeichens selbst. Sie können auch leer sein. Beispiele für Zeichenfolgen sind


```
    ''
    ""
    'hello'
    "umbra"
    "'"
    '"'
```

Die beiden letzten Beispiele veranschaulichen, wie sich jedes Begrenzungszeichen in eine Zeichenfolge einfügen lässt.

Zum Schluss unter den atomaren Ausdrücken die Zeichenklassen. Es gibt eine Reihe vordefinierter Klassen, unten aufgeführt, und die Möglichkeit, eigene zu bilden. Die vordefinierten Klassen lauten:

```
    <alnum>    # Any unicode alphabet or digit character (string is alnum).
    <alpha>    # Any unicode alphabet character (string is alpha).
    <ascii>    # Any unicode character below codepoint 0x80 (string is ascii).
    <control>  # Any unicode control character (string is control).
    <ddigit>   # The digit characters [0-9].
    <digit>    # Any unicode digit character (string is digit).
    <graph>    # Any unicode printing character, except space (string is graph).
    <lower>    # Any unicode lower-case alphabet character (string is lower).
    <print>    # Any unicode printing character, incl. space (string is print).
    <punct>    # Any unicode punctuation character (string is punct).
    <space>    # Any unicode space character (string is space).
    <upper>    # Any unicode upper-case alphabet character (string is upper).
    <wordchar> # Any unicode word character (string is wordchar).
    <xdigit>   # The hexadecimal digit characters [0-9a-fA-F].
    .          # Any character, except end of input.
```

Und die Syntax für benutzerdefinierte Zeichenklassen lautet

```
    [ <<range>>* ]
```

wobei jeder Bereich entweder aus einem einzelnen Zeichen besteht oder die Form

```
   <<character>> - <character>>
```

Beispiele für Zeichenklassen, die in dieser Einleitung schon vorgekommen sind, sind

```
    [_:]
    [0-9]
    [0-9a-fA-F]
```

Wir sind mit den Ausdrücken fast fertig. Als Letztes müssen wir noch erläutern, wie die Zeichen in Klassen und Zeichenfolgenliteralen festgelegt werden.

Grundsätzlich stehen die Zeichen in der Eingabe für sich selbst; darüber hinaus gibt es verschiedene Arten von Escape-Syntax, um Steuerzeichen oder Zeichen darzustellen, die außerhalb der Kodierung liegen, in der der Text vorliegt.

Alle Escape-Sequenzen beginnen mit einem Backslash-Zeichen („\\“, Unicode-Codepunkt 0x5C). Darauf folgt eine Folge von Oktalziffern, von „u“ gefolgt von Hexadezimalziffern oder ein reguläres Zeichen aus einem festgelegten Satz für verschiedene Steuerzeichen. Einige Beispiele:

```
    \n \r \t \' \" \[ \] \\ #
    \000 up to \277         # octal escape, all ascii character, leading 0's can be removed.
    \u2CA7                  # hexadecimal escape, all unicode characters.
    #                       # Here 2ca7 <=> Koptic Small Letter Tau
```

## Leerzeichen und Kommentare

Ein Thema, das bisher noch nicht angesprochen wurde, sind Leerzeichen und Kommentare.

Als Leerzeichen gelten alle Unicode-Leerzeichen, d. h. alle Zeichen der Klasse \<space> sowie Kommentare. Letztere sind Zeichenfolgen, die mit einem „#“ (Hash, Unicode-Codepunkt 0x23) beginnen und am nächsten Zeilenende enden.

Zwischen allen syntaktischen Elementen einer Grammatikbeschreibung können Leerzeichen beliebig verwendet werden. Innerhalb von syntaktischen Elementen, wie Namen, Zeichenfolgenliteralen, vordefinierten Zeichenklassen usw., dürfen sie nicht verwendet werden.

## Attribute von Nichtterminalen

Zum Schluss noch ein etwas fortgeschritteneres Thema. Im Abschnitt **Regeln** haben wir die Struktur einer Regel wie folgt dargestellt:

```
     <<name>>  <-  <<expression>> ;
```

Das stimmt nicht ganz. Es ist möglich, dem Nichtterminal in der Regel einen semantischen Modus zuzuordnen, indem man diesen vor dem Namen angibt und durch einen Doppelpunkt davon trennt, d. h. indem man schreibt:

```
    <<mode>> : <<name>>  <-  <<expression>> ;
```

Diese Schreibweise ist ebenfalls zulässig. Dieser Modus ist optional. Die bekannten Modi und ihre Bedeutungen lauten wie folgt:

**value**
: Der semantische Wert des nichtterminalen Symbols ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminale selbst besteht, dessen Kindknoten die ASTs der rechten Seite des Symbols sind.

**leaf**
: Der semantische Wert des Nichtterminalsymbols ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminal besteht, der keine Kindknoten hat. Alle durch die rechte Seite des Symbols erzeugten ASTs werden verworfen.

**void**
: Das Nichtterminal hat keinen semantischen Wert. Alle durch die rechte Seite des Symbols generierten ASTs werden (ebenfalls) verworfen. Von diesen drei Modi können nur **leaf** und **void** direkt angegeben werden. **value** wird implizit durch das Fehlen eines Modus vor dem Nichtterminal festgelegt. Mit all diesen Kenntnissen sollte es nun möglich sein, die formale Spezifikation der im nächsten Abschnitt dargestellten Textdarstellung – die in dieser Sprache verfasst ist – nicht nur zu lesen, sondern auch zu verstehen.


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
