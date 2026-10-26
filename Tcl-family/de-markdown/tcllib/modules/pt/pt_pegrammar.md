---
CommandName: pt::peg
title: pt::peg
ManualSection: n
Version: 1.1.1
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

# Name

pt::peg – Serialisierung der Parsing Expression Grammar

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::peg]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [pt::pe]{.lit}
[::pt::peg]{.cmd} [verify]{.lit} [serial]{.arg} [canonvar]{.optarg}
[::pt::peg]{.cmd} [verify-as-canonical]{.lit} [serial]{.arg}
[::pt::peg]{.cmd} [canonicalize]{.lit} [serial]{.arg}
[::pt::peg]{.cmd} [print]{.lit} [serial]{.arg}
[::pt::peg]{.cmd} [merge]{.lit} [seriala]{.arg} [serialb]{.arg}
[::pt::peg]{.cmd} [equal]{.lit} [seriala]{.arg} [serialb]{.arg}
:::

# Beschreibung

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket stellt Befehle zur Verfügung, für die Serialisierungen von Parsing Expression Grammars, wie die Parser-Tools sie verwalten und wie der Abschnitt [PEG-Serialisierungsformat] sie beschreibt.

Dies ist ein unterstützendes Paket in der Kernschicht der Parser-Tools.

Bild: arch\_core\_support

# API

**::pt::peg** **verify** *serial* ?*canonvar*?
: Dieser Befehl überprüft, ob der Inhalt von *serial* eine gültige Serialisierung eines Parsing-Ausdrucks ist, und löst einen Fehler aus, wenn dies nicht der Fall ist. Das Ergebnis des Befehls ist die leere Zeichenkette.

    Wenn das Argument *canonvar* festgelegt wird, wird es als Name einer Variablen im aufrufenden Kontext interpretiert. In diese Variable wird genau dann geschrieben, wenn *serial* eine gültige reguläre Serialisierung ist. Ihr Wert ist ein Boolescher Wert, wobei **True** angibt, dass die Serialisierung nicht nur gültig, sondern auch *kanonisch* ist. Bei einer gültigen, aber nicht kanonischen Serialisierung wird **False** geschrieben.

    Informationen zur Spezifikation von Serialisierungen finden Sie im Abschnitt [PE-Serialisierungsformat].

**::pt::peg** **verify-as-canonical** *serial*
: Dieser Befehl überprüft, ob der Inhalt von *serial* eine gültige *kanonische* Serialisierung einer PEG darstellt, und löst einen Fehler aus, falls dies nicht der Fall ist. Das Ergebnis des Befehls ist die leere Zeichenkette.

    Informationen zur Spezifikation kanonischer Serialisierungen finden Sie im Abschnitt [PEG-Serialisierungsformat].

**::pt::peg** **canonicalize** *serial*
: Dieser Befehl geht davon aus, dass der Inhalt von *serial* eine gültige *reguläre* Serialisierung einer PEG ist, und löst einen Fehler aus, wenn dies nicht der Fall ist.

    Anschließend wandelt er die Eingabe in die *kanonische* Serialisierung der enthaltenen PEG um und gibt diese als Ergebnis zurück. Ist die Eingabe bereits kanonisch, wird sie unverändert zurückgegeben.

    Zur Spezifikation regulärer und kanonischer Serialisierungen siehe den Abschnitt [PEG-Serialisierungsformat].

**::pt::peg** **print** *serial*
: Dieser Befehl geht davon aus, dass das Argument *serial* eine gültige Serialisierung eines Parsing-Ausdrucks enthält, und gibt eine Zeichenkette zurück, die diesen PE in einer für Menschen lesbaren Form enthält.

    Das genaue Format dieser Darstellung wird nicht festgelegt und darf nicht für das Parsen oder andere maschinengestützte Vorgänge herangezogen werden.

    Informationen zur Spezifikation von Serialisierungen finden Sie im Abschnitt [PEG-Serialisierungsformat].

**::pt::peg** **merge** *seriala* *serialb*
: Dieser Befehl akzeptiert die regulären Serialisierungen zweier Grammatiken und erstellt daraus deren Vereinigung. Das Ergebnis des Befehls ist die kanonische Serialisierung dieser vereinigten Grammatik.

    Ein Zusammenführungsfehler tritt auf, wenn für ein beliebiges nichtterminales Symbol S, das in beiden Eingabegrammatiken vorkommt, die beiden Eingabegrammatiken unterschiedliche semantische Modi festlegen.

    Der semantische Modus jedes nichtterminalen Symbols S ist der semantische Modus von S in einer seiner Eingabegrammatiken. Die vorherige Regel stellte sicher, dass diese Werte für Symbole, die in beiden Grammatiken vorkommen, identisch sind.

    Die rechte Seite jedes nichtterminalen Symbols S, das in beiden Eingabegrammatiken vorkommt, ist die Wahl zwischen den rechten Seiten von S in den Eingabegrammatiken, wobei der Parsing-Ausdruck von S in *seriala* an erster Stelle steht, es sei denn, beide Ausdrücke sind identisch. In diesem Fall wird der erste Ausdruck übernommen.

    Die rechte Seite jedes nichtterminalen Symbols S, das nur in einer der Eingabegrammatiken vorkommt, ist die rechte Seite von S in der jeweiligen Eingabegrammatik.

    Der Startausdruck der vereinheitlichten Grammatik ist die Auswahl zwischen den Startausdrücken der Eingabegrammatiken, wobei der Startausdruck von *seriala* an erster Stelle steht, es sei denn, beide Ausdrücke sind identisch. In diesem Fall wird der erste Ausdruck übernommen.

**::pt::peg** **equal** *seriala* *serialb*
: Dieser Befehl prüft die beiden Grammatiken *seriala* und *serialb* auf strukturelle Übereinstimmung. Das Ergebnis des Befehls ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn die Ausdrücke identisch sind, andernfalls auf **false**.

    Die Zeichenfolgenübereinstimmung ist nur dann anwendbar, wenn davon ausgegangen werden kann, dass es sich bei den beiden Grammatiken um reine Tcl-Listen und -Dictionaries handelt.


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
