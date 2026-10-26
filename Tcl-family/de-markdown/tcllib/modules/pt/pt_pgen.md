---
CommandName: pt::pgen
title: pt::pgen
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

pt::pgen – Parser-Generator

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::pgen]{.lit} [1.2]{.optlit}
[::pt::pgen]{.cmd} [inputformat]{.arg} [text]{.arg} [resultformat]{.arg} [options...]{.optarg}
:::

# Beschreibung

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket stellt einen Befehl bereit, der einen *Parser-Generator* implementiert, der Parsing Expression Grammars als Eingabe verwendet.

Es handelt sich um die Implementierung der Methode **generate** von **pt**, der *Parser Tools-Anwendung*.

Daher richtet sich dieses Dokument an Personen, die diesen Teil der Funktionalität von **pt** ändern und/oder erweitern möchten. Benutzer von **pt** werden hingegen auf die Manpage der Anwendung verwiesen, d. h. *Parser Tools Application*.

Es liegt in der Schicht der Benutzerpakete der Parser-Tools.

Bild: arch\_user\_pkg

# API

**::pt::pgen** *inputformat* *text* *resultformat* ?*options...*?
: Dieser Befehl nimmt die Parsing Expression Grammar in *text* (in dem durch *inputformat* festgelegten Format) entgegen und gibt dieselbe Grammatik im Format *resultformat* als Ergebnis des Befehls zurück.

    Die beiden bekannten Eingabeformate sind **peg** und **json**. Eine Einleitung in diese Formate, einschließlich ihrer formalen Spezifikationen, finden Sie im *PEG Language Tutorial* und in *The JSON Grammar Exchange Format*. Die zur Analyse dieser Formate verwendeten Pakete sind

    **peg**
    : [pt::peg::from::peg][pt_peg_from_peg]

    **json**
    : [pt::peg::from::json][pt_peg_from_json]


    Auf der Ausgabeseite sind die bekannten Formate und die Pakete, die sie erzeugen:

    **c**
    : [pt::peg::to::cparam][pt_peg_to_cparam]

    **container**
    : [pt::peg::to::container][pt_peg_to_container]

    **critcl**
    : [pt::peg::to::cparam][pt_peg_to_cparam] + **pt::cparam::configuration::critcl**

    **json**
    : [pt::peg::to::json][pt_peg_to_json]

    **oo**
    : [pt::peg::to::tclparam][pt_peg_to_tclparam] + **pt::tclparam::configuration::tcloo**

    **peg**
    : [pt::peg::to::peg][pt_peg_to_peg]

    **snit**
    : [pt::peg::to::tclparam][pt_peg_to_tclparam] + **pt::tclparam::configuration::snit**


    Die von den einzelnen Formaten unterstützten Optionen sind in den jeweiligen Paketen dokumentiert.


# Beispiel

In diesem Abschnitt arbeiten wir ein vollständiges Beispiel durch, beginnend mit einer PEG-Grammatik und endend mit der Ausführung des daraus generierten Parsers auf einer Eingabe, wobei wir der in der folgenden Abbildung dargestellten Gliederung folgen:

Bild: flow

Unsere Grammatik, von der angenommen wird, dass sie in der Datei „*calculator.peg*“ gespeichert ist, lautet wie folgt:

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

Daraus entsteht mit dem Skript „*gen*“ ein auf **snit** beruhender Parser.

```
package require Tcl 8.5
package require fileutil
package require pt::pgen

lassign $argv name
set grammar [fileutil::cat $name.peg]
set pclass  [pt::pgen peg $gr snit -class $name -file  $name.peg -name  $name]
fileutil::writeFile $name.tcl $pclass
exit 0
```

Der Aufruf lautet

```
 tclsh8.5 gen calculator
```

Damit liegen uns nun das Parser-Paket und die Klasse vor, die in die Datei „*calculator.tcl*“ geschrieben wurden. Unter der Annahme, dass dieses Paket anschließend ordnungsgemäß an einem Ort installiert wird, an dem Tcl es finden kann, können wir diese Klasse nun über ein Skript wie das folgende verwenden:

```
    package require calculator

    lassign $argv input
    set channel [open $input r]

    set parser [calculator]
    set ast [$parser parse $channel]
    $parser destroy
    close $channel

    ... now process the returned abstract syntax tree ...
```

wobei der in der Variable gespeicherte abstrakte Syntaxbaum wie folgt aussehen wird:

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

unter der Annahme, dass die Eingabedatei und der Kanal den Text enthielten

```
 120+5
```

Eine anschaulichere Darstellung des Baums wäre

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

Unabhängig davon liegt es an dieser Stelle in der Verantwortung der Benutzerin, mit dem Baum zu arbeiten, um das von ihr angestrebte Ziel zu erreichen. Das heißt, ihn zu analysieren, durch eine Transformation umzuwandeln usw. Das Paket **pt::ast** dürfte dabei hilfreich sein, da es Befehle bereitstellt, mit denen sich solche AST-Strukturen auf verschiedene Weise durchlaufen lassen.

Zu beachten ist, dass die hier verwendeten Parser eine Datenstruktur zurückgeben, die die Struktur der Eingabe gemäß der dem Parser zugrunde liegenden Grammatik abbildet. Während des Parsing-Prozesses gibt es *keine* Rückruffunktionen, d. h. keine *Parsing-Aktionen*, wie sie bei den meisten anderen Parsern zu finden sind.

Kehren wir zum letzten Codeausschnitt zurück, in dem der Parser für eine bestimmte Eingabe ausgeführt wird: Beachten Sie, wie die Parser-Instanz der festgelegten *Parser-API* folgt.

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


[pt_peg_from_json]: pt_peg_from_json.md
[pt_peg_from_peg]: pt_peg_from_peg.md
[pt_peg_to_container]: pt_peg_to_container.md
[pt_peg_to_cparam]: pt_peg_to_cparam.md
[pt_peg_to_json]: pt_peg_to_json.md
[pt_peg_to_peg]: pt_peg_to_peg.md
[pt_peg_to_tclparam]: pt_peg_to_tclparam.md
