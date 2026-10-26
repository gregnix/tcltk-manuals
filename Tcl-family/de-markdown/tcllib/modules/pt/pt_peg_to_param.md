---
CommandName: pt::peg::to::param
title: pt::peg::to::param
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - EBNF
 - LL(k)
 - PARAM
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

pt::peg::to::param – PEG-Konvertierung. Schreibt das Format PARAM

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::peg::to::param]{.lit} [1.1]{.optlit}
[package]{.cmd} [require]{.sub} [pt::peg]{.lit}
[package]{.cmd} [require]{.sub} [pt::pe]{.lit}
[pt::peg::to::param]{.cmd} [reset]{.lit}
[pt::peg::to::param]{.cmd} [configure]{.lit}
[pt::peg::to::param]{.cmd} [configure]{.lit} [option]{.arg}
[pt::peg::to::param]{.cmd} [configure]{.lit} [option]{.arg} [value...]{.arg}
[pt::peg::to::param]{.cmd} [convert]{.lit} [serial]{.arg}
:::

# Beschreibung

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket implementiert den Konverter zur Umwandlung von Parsing Expression Grammars in PARAM-Markup.

Es befindet sich im Abschnitt „Export“ der Kernschicht der Parser-Tools und kann entweder direkt mit den anderen Paketen dieser Schicht oder indirekt über den von **pt::peg::export** bereitgestellten Export-Manager verwendet werden. Letzteres ist für den Einsatz in nicht vertrauenswürdigen Umgebungen vorgesehen und erfolgt über das entsprechende Export-Plugin **pt::peg::export::param**, das zwischen Konverter und Export-Manager angesiedelt ist.

Bild: arch\_core\_eplugins

# API

Die von diesem Paket bereitgestellte API entspricht der Spezifikation der Converter-API, die in der Spezifikation *Parser Tools Export API* zu finden ist.

**pt::peg::to::param** **reset**
: Dieser Befehl setzt die Konfiguration des Pakets auf die Standardeinstellungen zurück.

**pt::peg::to::param** **configure**
: Dieser Befehl gibt ein Dictionary zurück, das die aktuelle Konfiguration des Pakets enthält.

**pt::peg::to::param** **configure** *option*
: Dieser Befehl gibt den aktuellen Wert der angegebenen *option* des Pakets zurück. Die Liste der zulässigen Optionen finden Sie im Abschnitt [Optionen].

**pt::peg::to::param** **configure** *option* *value*...
: Dieser Befehl setzt die angegebenen *option*s des Pakets auf die angegebenen *value*s. Eine Übersicht über die zulässigen Optionen finden Sie im Abschnitt [Optionen].

**pt::peg::to::param** **convert** *serial*
: Dieser Befehl nimmt die kanonische Serialisierung einer Parsing-Expression-Grammatik entgegen, wie sie im Abschnitt [PEG-Serialisierungsformat] festgelegt ist und in *serial* enthalten ist, und generiert gemäß der aktuellen Paketkonfiguration eine PARAM-Markup-Kodierung der Grammatik. Die erzeugte Zeichenkette wird anschließend als Ergebnis des Befehls zurückgegeben.


# Optionen

Der Konverter für das PARAM-Markup erkennt die folgenden Konfigurationsvariablen und passt sein Verhalten entsprechend deren Vorgaben an.

**-template** string
: Der Wert dieser Konfigurationsvariablen ist eine Zeichenkette, in die der generierte Text und die übrigen Konfigurationseinstellungen eingefügt werden sollen. Es wird erwartet, dass die verschiedenen Speicherorte für Benutzerdaten mithilfe der unten aufgeführten Platzhalter angegeben werden. Der Standardwert lautet „**@code@**“.

    **@user@**
    : Ist durch den Wert der Konfigurationsvariablen **-user** zu ersetzen.

    **@format@**
    : Ist durch die Konstante **PARAM** zu ersetzen.

    **@file@**
    : Ist durch den Wert der Konfigurationsvariablen **-file** zu ersetzen.

    **@name@**
    : Ist durch den Wert der Konfigurationsvariablen **-name** zu ersetzen.

    **@code@**
    : Wird durch den generierten Text ersetzt.


**-name** string
: Der Wert dieser Konfigurationsvariablen ist der Name der Grammatik, für die die Konvertierung durchgeführt wird. Der Standardwert lautet **a\_pe\_grammar**.

**-user** string
: Der Wert dieser Konfigurationsvariablen ist der Name des Benutzers, für den die Konvertierung durchgeführt wird. Der Standardwert lautet **unknown**.

**-file** string
: Der Wert dieser Konfigurationsvariablen ist der Name der Datei oder einer anderen Einheit, aus der die Grammatik stammt und für die die Konvertierung durchgeführt wird. Der Standardwert lautet **unknown**.


# PARAM-Code-Darstellung von Parsing-Expression-Grammatiken

Die PARAM-Code-Darstellung von Parsing-Ausdruck-Grammatiken ist ein Assembler-ähnlicher Text, der die in der *PackRat Machine Specification* dokumentierten Befehle der virtuellen Maschine verwendet, ergänzt um einige weitere Befehle zur Steuerung des Programmablaufs (jump ok, jump fail, call symbol, return).

Es ist nicht wirklich nützlich, außer vielleicht als Hilfsmittel, um zu veranschaulichen, wie eine Grammatik im Allgemeinen kompiliert wird, ohne sich von den Nebenaspekten eines Rahmens ablenken zu lassen – also ähnlich wie der unterstützende C- und Tcl-Code, der von den anderen von PARAM abgeleiteten Formaten generiert wird.

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

Eine mögliche PARAM-Serialisierung hierfür lautet

```
# -*- text -*-
# Parsing Expression Grammar 'TEMPLATE'.
# Generated for unknown, from file 'TEST'

#
# Grammar Start Expression
#

<<MAIN>>:
         call              sym_Expression
         halt

#
# value Symbol 'AddOp'
#

sym_AddOp:
# /
#     '-'
#     '+'

         symbol_restore    AddOp
  found! jump              found_7
         loc_push

         call              choice_5

   fail! value_clear
     ok! value_leaf        AddOp
         symbol_save       AddOp
         error_nonterminal AddOp
         loc_pop_discard

found_7:
     ok! ast_value_push
         return

choice_5:
# /
#     '-'
#     '+'

         error_clear

         loc_push
         error_push

         input_next        "t -"
     ok! test_char         "-"

         error_pop_merge
     ok! jump              oknoast_4

         loc_pop_rewind
         loc_push
         error_push

         input_next        "t +"
     ok! test_char         "+"

         error_pop_merge
     ok! jump              oknoast_4

         loc_pop_rewind
         status_fail
         return

oknoast_4:
         loc_pop_discard
         return
#
# value Symbol 'Digit'
#

sym_Digit:
# /
#     '0'
#     '1'
#     '2'
#     '3'
#     '4'
#     '5'
#     '6'
#     '7'
#     '8'
#     '9'

         symbol_restore    Digit
  found! jump              found_22
         loc_push

         call              choice_20

   fail! value_clear
     ok! value_leaf        Digit
         symbol_save       Digit
         error_nonterminal Digit
         loc_pop_discard

found_22:
     ok! ast_value_push
         return

choice_20:
# /
#     '0'
#     '1'
#     '2'
#     '3'
#     '4'
#     '5'
#     '6'
#     '7'
#     '8'
#     '9'

         error_clear

         loc_push
         error_push

         input_next        "t 0"
     ok! test_char         "0"

         error_pop_merge
     ok! jump              oknoast_19

         loc_pop_rewind
         loc_push
         error_push

         input_next        "t 1"
     ok! test_char         "1"

         error_pop_merge
     ok! jump              oknoast_19

         loc_pop_rewind
         loc_push
         error_push

         input_next        "t 2"
     ok! test_char         "2"

         error_pop_merge
     ok! jump              oknoast_19

         loc_pop_rewind
         loc_push
         error_push

         input_next        "t 3"
     ok! test_char         "3"

         error_pop_merge
     ok! jump              oknoast_19

         loc_pop_rewind
         loc_push
         error_push

         input_next        "t 4"
     ok! test_char         "4"

         error_pop_merge
     ok! jump              oknoast_19

         loc_pop_rewind
         loc_push
         error_push

         input_next        "t 5"
     ok! test_char         "5"

         error_pop_merge
     ok! jump              oknoast_19

         loc_pop_rewind
         loc_push
         error_push

         input_next        "t 6"
     ok! test_char         "6"

         error_pop_merge
     ok! jump              oknoast_19

         loc_pop_rewind
         loc_push
         error_push

         input_next        "t 7"
     ok! test_char         "7"

         error_pop_merge
     ok! jump              oknoast_19

         loc_pop_rewind
         loc_push
         error_push

         input_next        "t 8"
     ok! test_char         "8"

         error_pop_merge
     ok! jump              oknoast_19

         loc_pop_rewind
         loc_push
         error_push

         input_next        "t 9"
     ok! test_char         "9"

         error_pop_merge
     ok! jump              oknoast_19

         loc_pop_rewind
         status_fail
         return

oknoast_19:
         loc_pop_discard
         return
#
# value Symbol 'Expression'
#

sym_Expression:
# /
#     x
#         '\('
#         (Expression)
#         '\)'
#     x
#         (Factor)
#         *
#             x
#                 (MulOp)
#                 (Factor)

         symbol_restore    Expression
  found! jump              found_46
         loc_push
         ast_push

         call              choice_44

   fail! value_clear
     ok! value_reduce      Expression
         symbol_save       Expression
         error_nonterminal Expression
         ast_pop_rewind
         loc_pop_discard

found_46:
     ok! ast_value_push
         return

choice_44:
# /
#     x
#         '\('
#         (Expression)
#         '\)'
#     x
#         (Factor)
#         *
#             x
#                 (MulOp)
#                 (Factor)

         error_clear

         ast_push
         loc_push
         error_push

         call              sequence_27

         error_pop_merge
     ok! jump              ok_43

         ast_pop_rewind
         loc_pop_rewind
         ast_push
         loc_push
         error_push

         call              sequence_40

         error_pop_merge
     ok! jump              ok_43

         ast_pop_rewind
         loc_pop_rewind
         status_fail
         return

ok_43:
         ast_pop_discard
         loc_pop_discard
         return

sequence_27:
# x
#     '\('
#     (Expression)
#     '\)'

         loc_push
         error_clear

         error_push

         input_next        "t ("
     ok! test_char         "("

         error_pop_merge
   fail! jump              failednoast_29
         ast_push
         error_push

         call              sym_Expression

         error_pop_merge
   fail! jump              failed_28
         error_push

         input_next        "t )"
     ok! test_char         ")"

         error_pop_merge
   fail! jump              failed_28

         ast_pop_discard
         loc_pop_discard
         return

failed_28:
         ast_pop_rewind

failednoast_29:
         loc_pop_rewind
         return

sequence_40:
# x
#     (Factor)
#     *
#         x
#             (MulOp)
#             (Factor)

         ast_push
         loc_push
         error_clear

         error_push

         call              sym_Factor

         error_pop_merge
   fail! jump              failed_41
         error_push

         call              kleene_37

         error_pop_merge
   fail! jump              failed_41

         ast_pop_discard
         loc_pop_discard
         return

failed_41:
         ast_pop_rewind
         loc_pop_rewind
         return

kleene_37:
# *
#     x
#         (MulOp)
#         (Factor)

         loc_push
         error_push

         call              sequence_34

         error_pop_merge
   fail! jump              failed_38
         loc_pop_discard
         jump              kleene_37

failed_38:
         loc_pop_rewind
         status_ok
         return

sequence_34:
# x
#     (MulOp)
#     (Factor)

         ast_push
         loc_push
         error_clear

         error_push

         call              sym_MulOp

         error_pop_merge
   fail! jump              failed_35
         error_push

         call              sym_Factor

         error_pop_merge
   fail! jump              failed_35

         ast_pop_discard
         loc_pop_discard
         return

failed_35:
         ast_pop_rewind
         loc_pop_rewind
         return
#
# value Symbol 'Factor'
#

sym_Factor:
# x
#     (Term)
#     *
#         x
#             (AddOp)
#             (Term)

         symbol_restore    Factor
  found! jump              found_60
         loc_push
         ast_push

         call              sequence_57

   fail! value_clear
     ok! value_reduce      Factor
         symbol_save       Factor
         error_nonterminal Factor
         ast_pop_rewind
         loc_pop_discard

found_60:
     ok! ast_value_push
         return

sequence_57:
# x
#     (Term)
#     *
#         x
#             (AddOp)
#             (Term)

         ast_push
         loc_push
         error_clear

         error_push

         call              sym_Term

         error_pop_merge
   fail! jump              failed_58
         error_push

         call              kleene_54

         error_pop_merge
   fail! jump              failed_58

         ast_pop_discard
         loc_pop_discard
         return

failed_58:
         ast_pop_rewind
         loc_pop_rewind
         return

kleene_54:
# *
#     x
#         (AddOp)
#         (Term)

         loc_push
         error_push

         call              sequence_51

         error_pop_merge
   fail! jump              failed_55
         loc_pop_discard
         jump              kleene_54

failed_55:
         loc_pop_rewind
         status_ok
         return

sequence_51:
# x
#     (AddOp)
#     (Term)

         ast_push
         loc_push
         error_clear

         error_push

         call              sym_AddOp

         error_pop_merge
   fail! jump              failed_52
         error_push

         call              sym_Term

         error_pop_merge
   fail! jump              failed_52

         ast_pop_discard
         loc_pop_discard
         return

failed_52:
         ast_pop_rewind
         loc_pop_rewind
         return
#
# value Symbol 'MulOp'
#

sym_MulOp:
# /
#     '*'
#     '/'

         symbol_restore    MulOp
  found! jump              found_67
         loc_push

         call              choice_65

   fail! value_clear
     ok! value_leaf        MulOp
         symbol_save       MulOp
         error_nonterminal MulOp
         loc_pop_discard

found_67:
     ok! ast_value_push
         return

choice_65:
# /
#     '*'
#     '/'

         error_clear

         loc_push
         error_push

         input_next        "t *"
     ok! test_char         "*"

         error_pop_merge
     ok! jump              oknoast_64

         loc_pop_rewind
         loc_push
         error_push

         input_next        "t /"
     ok! test_char         "/"

         error_pop_merge
     ok! jump              oknoast_64

         loc_pop_rewind
         status_fail
         return

oknoast_64:
         loc_pop_discard
         return
#
# value Symbol 'Number'
#

sym_Number:
# x
#     ?
#         (Sign)
#     +
#         (Digit)

         symbol_restore    Number
  found! jump              found_80
         loc_push
         ast_push

         call              sequence_77

   fail! value_clear
     ok! value_reduce      Number
         symbol_save       Number
         error_nonterminal Number
         ast_pop_rewind
         loc_pop_discard

found_80:
     ok! ast_value_push
         return

sequence_77:
# x
#     ?
#         (Sign)
#     +
#         (Digit)

         ast_push
         loc_push
         error_clear

         error_push

         call              optional_70

         error_pop_merge
   fail! jump              failed_78
         error_push

         call              poskleene_73

         error_pop_merge
   fail! jump              failed_78

         ast_pop_discard
         loc_pop_discard
         return

failed_78:
         ast_pop_rewind
         loc_pop_rewind
         return

optional_70:
# ?
#     (Sign)

         loc_push
         error_push

         call              sym_Sign

         error_pop_merge
   fail! loc_pop_rewind
     ok! loc_pop_discard
         status_ok
         return

poskleene_73:
# +
#     (Digit)

         loc_push

         call              sym_Digit

   fail! jump              failed_74

loop_75:
         loc_pop_discard
         loc_push
         error_push

         call              sym_Digit

         error_pop_merge
     ok! jump              loop_75
         status_ok

failed_74:
         loc_pop_rewind
         return
#
# value Symbol 'Sign'
#

sym_Sign:
# /
#     '-'
#     '+'

         symbol_restore    Sign
  found! jump              found_86
         loc_push

         call              choice_5

   fail! value_clear
     ok! value_leaf        Sign
         symbol_save       Sign
         error_nonterminal Sign
         loc_pop_discard

found_86:
     ok! ast_value_push
         return
#
# value Symbol 'Term'
#

sym_Term:
# (Number)

         symbol_restore    Term
  found! jump              found_89
         loc_push
         ast_push

         call              sym_Number

   fail! value_clear
     ok! value_reduce      Term
         symbol_save       Term
         error_nonterminal Term
         ast_pop_rewind
         loc_pop_discard

found_89:
     ok! ast_value_push
         return

#
#
```

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
