---
CommandName: pt::ast
title: pt::ast
ManualSection: n
Version: 1.2
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

pt::ast – Serialisierung abstrakter Syntaxbäume

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::ast]{.lit} [1.2]{.optlit}
[::pt::ast]{.cmd} [verify]{.lit} [serial]{.arg} [canonvar]{.optarg}
[::pt::ast]{.cmd} [verify-as-canonical]{.lit} [serial]{.arg}
[::pt::ast]{.cmd} [canonicalize]{.lit} [serial]{.arg}
[::pt::ast]{.cmd} [print]{.lit} [serial]{.arg}
[::pt::ast]{.cmd} [bottomup]{.lit} [cmdprefix]{.arg} [ast]{.arg}
[cmdprefix]{.cmd} [ast]{.arg}
[::pt::ast]{.cmd} [topdown]{.lit} [cmdprefix]{.arg} [pe]{.arg}
[::pt::ast]{.cmd} [equal]{.lit} [seriala]{.arg} [serialb]{.arg}
[::pt::ast]{.cmd} [new0]{.lit} [s]{.arg} [loc]{.arg} [child...]{.optarg}
[::pt::ast]{.cmd} [new]{.lit} [s]{.arg} [start]{.arg} [end]{.arg} [child...]{.optarg}
:::

# Beschreibung

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket stellt Befehle zur Verfügung, mit denen Sie die von den Parser-Tools verwalteten und im Abschnitt [AST-Serialisierungsformat] beschriebenen Serialisierungen abstrakter Syntaxbäume bearbeiten können.

Dies ist ein unterstützendes Paket in der Kernschicht der Parser-Tools.

IMAGE: arch\_core\_support

# API

**::pt::ast** **verify** *serial* ?*canonvar*?
: Dieser Befehl überprüft, ob der Inhalt von *serial* eine gültige Serialisierung eines abstrakten Syntaxbaums ist, und löst einen Fehler aus, wenn dies nicht der Fall ist. Das Ergebnis des Befehls ist die leere Zeichenkette.

    Wenn das Argument *canonvar* angegeben wird, wird es als Name einer Variablen im aufrufenden Kontext interpretiert. In diese Variable wird genau dann geschrieben, wenn *serial* eine gültige reguläre Serialisierung ist. Ihr Wert ist ein Boolescher Wert, wobei **True** angibt, dass die Serialisierung nicht nur gültig, sondern auch *kanonisch* ist. Bei einer gültigen, aber nicht kanonischen Serialisierung wird **False** geschrieben.

    Informationen zur Spezifikation von Serialisierungen finden Sie im Abschnitt [AST-Serialisierungsformat].

**::pt::ast** **verify-as-canonical** *serial*
: Dieser Befehl überprüft, ob der Inhalt von *serial* eine gültige *kanonische* Serialisierung eines abstrakten Syntaxbaums ist, und löst einen Fehler aus, falls dies nicht der Fall ist. Das Ergebnis des Befehls ist die leere Zeichenkette.

    Informationen zur Spezifikation kanonischer Serialisierungen finden Sie im Abschnitt [AST-Serialisierungsformat].

**::pt::ast** **canonicalize** *serial*
: Dieser Befehl geht davon aus, dass der Inhalt von *serial* eine gültige *reguläre* Serialisierung einer abstrakten Syntax ist, und löst einen Fehler aus, wenn dies nicht der Fall ist.

    Anschließend wandelt er die Eingabe in die *kanonische* Serialisierung des enthaltenen Baums um und gibt diese als Ergebnis zurück. Wenn die Eingabe bereits kanonisch ist, wird sie unverändert zurückgegeben.

    Zur Spezifikation regulärer und kanonischer Serialisierungen siehe den Abschnitt [AST-Serialisierungsformat].

**::pt::ast** **print** *serial*
: Dieser Befehl geht davon aus, dass das Argument *serial* eine gültige Serialisierung eines abstrakten Syntaxbaums enthält, und gibt eine Zeichenkette zurück, die diesen Baum in einer für Menschen lesbaren Form enthält.

    Das genaue Format dieser Darstellung ist nicht spezifiziert und darf nicht für die Analyse oder andere maschinelle Vorgänge herangezogen werden.

    Informationen zur Spezifikation von Serialisierungen finden Sie im Abschnitt [AST-Serialisierungsformat].

**::pt::ast** **bottomup** *cmdprefix* *ast*
: Dieser Befehl durchläuft den abstrakten Syntaxbaum *ast* von unten nach oben bis zur Wurzel und ruft dabei für jeden Knoten das Befehlspräfix *cmdprefix* auf. Dies bedeutet, dass die Kindknoten eines Knotens N vor N selbst verarbeitet werden.

    Das Befehlspräfix hat die Signatur

    **cmdprefix** *ast*
    : Das heißt, er wird mit dem AST-Knoten aufgerufen, an dem sich der Durchlauf gerade befindet.

        Das vom Befehlspräfix gegebene Ergebnis ersetzt *ast* in dem Knoten, dessen Kindknoten es war, wodurch Transformationen des Baums ermöglicht werden.

        Dies bedeutet auch, dass für jeden inneren Knoten der Inhalt der Kindknoten den Ergebnissen der Befehlspräfixe entspricht, die für die Kindknoten dieses Knotens aufgerufen wurden.


**::pt::ast** **topdown** *cmdprefix* *pe*
: Dieser Befehl durchläuft den abstrakten Syntaxbaum *ast* von der Wurzel bis zu den Blättern und ruft dabei für jeden Knoten das Befehlspräfix *cmdprefix* auf. Dies bedeutet, dass die Kindknoten eines Knotens N erst nach N verarbeitet werden.

    Das Befehlspräfix hat dieselbe Signatur wie bei **bottomup** (siehe oben).

    Das vom Befehlspräfix gegebene Ergebnis wird *ignoriert*.

**::pt::ast** **equal** *seriala* *serialb*
: Dieser Befehl prüft die beiden abstrakten Syntaxbäume *seriala* und *serialb* auf strukturelle Übereinstimmung. Das Ergebnis des Befehls ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn die Bäume identisch sind, andernfalls auf **false**.

    Der Zeichenkettenvergleich ist nur dann brauchbar, wenn davon ausgegangen werden kann, dass es sich bei den beiden Bäumen um reine Tcl-Listen handelt.

**::pt::ast** **new0** *s* *loc* ?*child*...?
: Dieser Befehl erstellt den AST für einen nichtterminalen Knoten, der sich auf das Symbol *s* an der Position *loc* in der Eingabe bezieht, sowie die Menge der Kindknoten *child* …, von links nach rechts. Letztere kann leer sein. Der erzeugte Knoten wird als Ergebnis des Befehls zurückgegeben. Die Endposition ist *loc*-1, d. h. ein Zeichen vor dem Start. Dieser Knotentyp ist für Regeln möglich, die optionale Teile enthalten.

**::pt::ast** **new** *s* *start* *end* ?*child*...?
: Dieser Befehl erstellt den AST für einen nichtterminalen Knoten, der sich auf das Symbol *s* bezieht, das den Positionsbereich von *start* bis *end* in der Eingabe abdeckt, sowie die Menge der Kindknoten *child* …, von links nach rechts. Letztere kann leer sein. Der erstellte Knoten wird als Ergebnis des Befehls zurückgegeben.


# AST-Serialisierungsformat

An dieser Stelle legen wir das Format fest, das von den Parser-Tools verwendet wird, um abstrakte Syntaxbäume (ASTs) als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Jeder Knoten in einem AST repräsentiert ein nichtterminales Symbol einer Grammatik sowie den Bereich der Tokens/Zeichen in der Eingabe, den dieses Symbol abdeckt. ASTs enthalten keine terminalen Symbole, d. h. keine Tokens/Zeichen. Diese lassen sich anhand der Position eines Symbols aus der Eingabe rekonstruieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Ein Baum kann zwar mehr als eine reguläre Serialisierung aufweisen, jedoch ist genau nur eine davon *kanonisch*.

Reguläre Serialisierung
: 1. Die Serialisierung eines beliebigen AST entspricht der Serialisierung seines Wurzelknotens.

    2. Die Serialisierung eines beliebigen Knotens ist eine Tcl-Liste, die mindestens drei Elemente enthält.

        1. Das erste Element ist der Name des im Knoten gespeicherten nichtterminalen Symbols.

        2. Das zweite und dritte Element geben die Positionen des ersten und letzten Tokens in dem Token-Strom an, den der Knoten repräsentiert (abdeckt).

            1. Positionen werden als nicht-negative ganzzahlige Offsets vom Anfang des Token-Stroms angegeben, wobei das erste im Strom gefundene Token am Offset 0 (Null) liegt.

            2. Die Endposition muss mindestens so groß sein wie die Startposition.


        3. Alle Elemente nach den ersten drei sind die Kindknoten des Knotens, selbst wieder Knoten. Die Serialisierung eines Knotens ohne Kindknoten, also eines Blattknotens, hat daher genau drei Elemente. In der Liste steht der linke Kindknoten zuerst und der rechte zuletzt.



Kanonische Serialisierung
: Die kanonische Serialisierung eines abstrakten Syntaxbaums hat das im vorigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen dieses Baums eindeutig ist.

    1. Die Zeichenfolgendarstellung des Werts entspricht der kanonischen Darstellung einer reinen Tcl-Liste. Das heißt, sie enthält keine überflüssigen Leerzeichen.



## Beispiel

Unter der Annahme der folgenden Parsing Expression Grammar

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

und der Eingabezeichenkette

```
 120+5
```

Dann sollte ein Parser den folgenden abstrakten Syntaxbaum liefern (mit Ausnahme von Leerzeichen)

```
set ast {Expression 0 4
    {Factor 0 4
        {Term 0 2
            {Number 0 2
                {Digit 0 0}
                {Digit 1 1}
                {Digit 2 2}
            }
        }
        {AddOp 3 3}
        {Term 4 4
            {Number 4 4
                {Digit 4 4}
            }
        }
    }
}
```

Oder, grafischer

```
+- Digit 0 0 | 1
|            |
+- Term 0 2 --- Number 0 2 -+- Digit 1 1 | 2
|                           |            |
|                           +- Digit 2 2 | 0
|                                        |
Expression 0 4 --- Factor 0 4 -+----------------------------- AddOp 3 3 | +
|                                        |
+- Term 4 4 --- Number 4 4 --- Digit 4 4 | 5
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
