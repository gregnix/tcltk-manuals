---
CommandName: pt
title: pt
ManualSection: n
Version: 1
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

pt – Anwendung für Parser-Tools

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[pt]{.cmd} [generate]{.lit} [resultformat]{.arg} [options...]{.optarg} [resultfile]{.arg} [inputformat]{.arg} [inputfile]{.arg}
:::

# Beschreibung

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Dokument beschreibt **pt**, die Hauptanwendung des Moduls, einen *Parser-Generator*. Es richtet sich an Personen, die einen Parser für eine von ihnen entwickelte Sprache erstellen möchten. Sollten Sie stattdessen die Anwendung anpassen wollen, finden Sie die grundlegenden Informationen im Abschnitt [Interne Abläufe] der Anwendung.

Es befindet sich in der Benutzeranwendungsschicht der Parser-Tools.

Bild: arch\_user\_app

# Befehlszeile

**pt** **generate** *resultformat* ?*options...*? *resultfile* *inputformat* *inputfile*
: Dieser Unterbefehl der Anwendung liest die in der Datei *inputfile* im Format *inputformat* gespeicherte Parsing-Expression-Grammatik ein, wandelt sie gemäß den vom Benutzer festgelegten (formatspezifischen) Optionen in das *resultformat* um und speichert das Ergebnis in der Datei *resultfile*.

    Die Datei *inputfile* muss vorhanden sein, während die Datei *resultfile* angelegt werden kann, wobei ein bereits vorhandener Inhalt überschrieben wird. Fehlende Verzeichnisse im Pfad zur Datei *resultfile* werden ebenfalls angelegt.

    Die genaue Form des Ergebnisses sowie die von den bekannten Ergebnisformaten unterstützten Optionen werden in den folgenden Abschnitten dieses Dokuments erläutert; die nachstehende Liste dient als Index, der die Namen der Formate den entsprechenden Abschnitten zuordnet. In alphabetischer Reihenfolge:

    **c**
    : Ein *resultformat*. Siehe Abschnitt [C-Parser].

    **container**
    : Ein *resultformat*. Siehe Abschnitt [Grammatik-Container].

    **critcl**
    : Ein *resultformat*. Siehe Abschnitt [In Tcl eingebetteter C-Parser].

    **json**
    : Ein *input*- und *resultformat*. Siehe Abschnitt [JSON-Austausch von Grammatiken].

    **oo**
    : Ein *resultformat*. Siehe Abschnitt [TclOO-Parser].

    **peg**
    : Ein *input*- und *resultformat*. Siehe Abschnitt [PEG-Spezifikationssprache].

    **snit**
    : Ein *resultformat*. Siehe Abschnitt [Snit-Parser].



Von den sieben möglichen Ergebnissen sind vier reine Parser (**c**, **critcl**, **oo**, und **snit**), eines (**container**) stellt Code bereit, der in Verbindung mit einem generischen Parser (auch als Grammatik-Interpreter bezeichnet) verwendet werden kann, und die letzten beiden (**json** und **peg**) erfüllen eine Doppelfunktion als Eingabeformate und ermöglichen die Transformation von Grammatiken zum Austausch, zur Neuformatierung und Ähnlichem.

Die erstellten Parser lassen sich in drei Kategorien einteilen:

```
+ --- C ---> critcl, c
|
+ --- specialized -+
|                  |
---+                  + --- Tcl -> snit, oo
|
+ --- interpreted (Tcl) ------> container
```

**Specialized parsers implemented in C**
: Die schnellsten Parser werden bei Verwendung der Ergebnisformate **c** und **critcl** erstellt. Ersteres gibt den rohen C-Code für den Parser zurück, während letzteres diesen mithilfe von *CriTcl* in ein Tcl-Paket einbindet.

    Dadurch ist Letzteres wesentlich einfacher zu verwenden als Ersteres. Andererseits lässt sich Ersteres durch eine Vielzahl von Optionen an die Anforderungen der Benutzer anpassen, was beispielsweise die Verwendung des Parsers außerhalb einer Tcl-Umgebung ermöglicht – eine Funktion, die das Format **critcl** nicht unterstützt. Daher ist das Format **c** für fortgeschrittene Benutzer oder Benutzer mit besonderen Anforderungen gedacht.

    Ein Nachteil aller Parser in diesem Abschnitt ist die Notwendigkeit, sie über einen C-Compiler zu kompilieren, um sie tatsächlich ausführbar zu machen. Nicht jeder verfügt über die dafür erforderlichen Werkzeuge. Die Parser im nächsten Abschnitt richten sich an Personen, die solchen Einschränkungen unterliegen.

**Specialized parsers implemented in Tcl**
: Da die Parser in diesem Abschnitt in Tcl implementiert sind, arbeiten sie deutlich langsamer als alle Beispiele aus dem vorherigen Abschnitt. Andererseits ermöglicht dies ihren Einsatz in reinen Tcl-Umgebungen oder in Umgebungen, in denen nur eine begrenzte Anzahl von Paketen zulässig ist. Im letzteren Fall ist es von Vorteil, sich für die Einbindung der C-basierten Laufzeitunterstützung (siehe Hinweise unten) in die Umgebung einzusetzen, um die Auswirkungen von Tcl auf die Geschwindigkeit dieser Parser zu verringern.

    Die relevanten Formate sind **snit** und **oo**. Beide place ihr Ergebnis in einem Tcl-Paket, das jeweils ein **snit::type** bzw. TclOO **class** enthält.

    Von der unterstützenden Laufzeitumgebung, bei der es sich um das Paket **pt::rde** handelt, muss der Benutzer nichts weiter wissen, als dass sie existiert und dass die Parser davon abhängig sind. Kenntnisse über die von der Laufzeitumgebung für die Nutzung durch die Parser exportierte API werden von den Benutzern der Parser *nicht* benötigt.

**Interpreted parsing implemented in Tcl**
: Die letzte Kategorie: die Grammatikinterpretation. Das bedeutet, dass ein Interpreter für Parsing-Ausdruck-Grammatiken die Beschreibung der Grammatik, anhand derer die Eingabe analysiert werden soll, heranzieht und diese als Leitfaden für den Analyse-Prozess verwendet. Dies ist die langsamste der verfügbaren Optionen, da der Interpreter die konfigurierte Grammatik kontinuierlich durchlaufen muss, während die spezialisierten Parser aus den vorangegangenen Abschnitten das relevante Wissen über die Grammatik bereits fest integriert haben.

    Der Einsatz der Interpretation ist nur dann sinnvoll, wenn die Grammatik für bestimmte Eingaben vom Benutzer interaktiv geändert werden kann, da die Interpretation nach jeder Änderung eine schnelle Anpassung ermöglicht, während die vorherigen Methoden die Generierung eines völlig neuen Parsers erfordern, was nicht so schnell ist. Ist die zu verwendende Grammatik hingegen feststehend, sind die vorherigen Methoden weitaus vorteilhafter, da die Zeit für die Generierung des Parsers im Vergleich zur Laufzeit des Parser-Codes verschwindend gering ist.

    Das entsprechende Ergebnisformat ist **container**. Es generiert (schnell) Grammatikbeschreibungen (anstelle eines vollständigen Parsers), die der vom Grammatik-Interpreter von ParserTools erwarteten API entsprechen. Letzterer wird durch das Paket **pt::peg::interp** bereitgestellt.


Alle von **critcl**, **snit** und **oo** generierten Parser sowie der Grammatik-Interpreter nutzen eine gemeinsame API für den Zugriff auf die eigentliche Parsing-Funktionalität, wodurch sie alle über eine hohe Kompatibilität verfügen. Dies wird im Spezifikationsdokument *Parser-API* beschrieben.

# PEG-Spezifikationssprache

**peg**, eine Sprache zur Spezifikation von Parsing-Expression-Grammatiken, soll sowohl für Menschen lesbar als auch schreibbar sein, dabei jedoch streng genug, um eine maschinelle Verarbeitung zu ermöglichen. Wie jede Computersprache. Sie wurde definiert, um das Verfassen einer Grammatik-Spezifikation zu vereinfachen – etwas, wofür sich die anderen in den Parser-Tools vorhandenen Formate nicht eignen.

Wenn Sie eine Einleitung zur Sprache oder deren formale Spezifikation einsehen möchten, lesen Sie bitte das *PEG-Sprach-Tutorial*.

Wenn dieses Format als Ergebnisformat verwendet wird, unterstützt es die folgenden Optionen:

**-file** string
: Der Wert dieser Option ist der Name der Datei oder einer anderen Einheit, aus der die Grammatik stammt und für die der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-name** string
: Der Wert dieser Option ist der Name der Grammatik, die wir gerade verarbeiten. Der Standardwert lautet **a\_pe\_grammar**.

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



# JSON-Austausch von Grammatiken

Das Format **json** für Parsing Expression Grammars wurde als Datenaustauschformat geschrieben, das nicht an Tcl gebunden ist. Es wurde definiert, um den Austausch von Grammatiken mit PackRat/PEG-basierten Parsergeneratoren für andere Sprachen zu ermöglichen.

Die formale Spezifikation des JSON-Grammatik-Austauschformats finden Sie in *The JSON Grammar Exchange Format*.

Wenn dieses Format als Ergebnisformat verwendet wird, unterstützt es die folgenden Optionen:

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


# In Tcl eingebetteter C-Parser

Das Format **critcl** ist ausführbarer Code, ein Parser für die Grammatik. Es handelt sich um ein Tcl-Paket, dessen eigentliche Parser-Implementierung in C geschrieben und über das Paket **critcl** in Tcl eingebettet ist.

Dieses Ergebnisformat unterstützt die folgenden Optionen:

**-file** string
: Der Wert dieser Option ist der Name der Datei oder einer anderen Einheit, aus der die Grammatik stammt und für die der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-name** string
: Der Wert dieser Option ist der Name der Grammatik, die wir gerade verarbeiten. Der Standardwert lautet **a\_pe\_grammar**.

**-user** string
: Der Wert dieser Option ist der Name des Benutzers, unter dem der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-class** string
: Der Wert dieser Option ist der Name der zu generierenden Klasse ohne führende Doppelpunkte. Der Standardwert lautet **CLASS**.

    Bei einem einfachen Wert wie **X** ohne Doppelpunkte, beispielsweise Klasse, lautet der Parser-Befehl **X**::**X**. Bei einem Wert mit Namespace wie **X::Y** lautet der Parser-Befehl hingegen **X::Y**.

**-package** string
: Der Wert dieser Option ist der Name des zu erstellenden Pakets. Der Standardwert lautet **PACKAGE**.

**-version** string
: Der Wert dieser Option gibt die Version des zu erstellenden Pakets an. Der Standardwert lautet **1**.


# C-Parser

Das Format **c** ist ausführbarer Code, nämlich ein Parser für die Grammatik. Die Parser-Implementierung ist in C geschrieben und lässt sich mithilfe einer Vielzahl von Optionen an die Bedürfnisse der Benutzer anpassen.

Das Format **critcl** ist beispielsweise als vordefinierte Konfiguration dieser Optionen auf Basis des Generators für **c** implementiert.

Dieses Ergebnisformat unterstützt die folgenden Optionen:

**-file** string
: Der Wert dieser Option ist der Name der Datei oder einer anderen Einheit, aus der die Grammatik stammt und für die der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-name** string
: Der Wert dieser Option ist der Name der Grammatik, die wir gerade verarbeiten. Der Standardwert lautet **a\_pe\_grammar**.

**-user** string
: Der Wert dieser Option ist der Name des Benutzers, unter dem der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-template** string
: Der Wert dieser Option ist eine Zeichenkette, in die der generierte Text und die übrigen Konfigurationseinstellungen eingefügt werden sollen. Es wird erwartet, dass die verschiedenen Speicherorte für Benutzerdaten mithilfe der unten aufgeführten Platzhalter angegeben werden. Der Standardwert lautet „**@code@**“.

    **@user@**
    : Ist durch den Wert der Option **-user** zu ersetzen.

    **@format@**
    : Ist durch die Konstante **C/PARAM** zu ersetzen.

    **@file@**
    : Ist durch den Wert der Option **-file** zu ersetzen.

    **@name@**
    : Ist durch den Wert der Option **-name** zu ersetzen.

    **@code@**
    : Wird durch den generierten Tcl-Code ersetzt.


    Die folgenden Optionen sind insofern besonders, als sie im generierten Code vorkommen und dort ebenfalls ersetzt werden.

    **@statedecl@**
    : Ist durch den Wert der Option **state-decl** zu ersetzen.

    **@stateref@**
    : Ist durch den Wert der Option **state-ref** zu ersetzen.

    **@strings@**
    : Ist durch den Wert der Option **string-varname** zu ersetzen.

    **@self@**
    : Ist durch den Wert der Option **self-command** zu ersetzen.

    **@def@**
    : Ist durch den Wert der Option **fun-qualifier** zu ersetzen.

    **@ns@**
    : Ist durch den Wert der Option **namespace** zu ersetzen.

    **@main@**
    : Ist durch den Wert der Option **main** zu ersetzen.

    **@prelude@**
    : Ist durch den Wert der Option **prelude** zu ersetzen.


**-state-decl** string
: Eine C-Zeichenkette, die die Argumentdeklaration darstellt, die in den generierten Parsing-Funktionen verwendet werden soll, um auf den Parsing-Zustand zu verweisen. Im Wesentlichen handelt es sich dabei um den Typ und den Namen des Arguments. Der Standardwert ist die Zeichenkette **RDE\_PARAM p**.

**-state-ref** string
: Eine C-Zeichenkette mit dem Argumentnamen, mit dem die erzeugten Parsing-Funktionen auf den Parsing-Zustand verweisen. Der Standardwert ist die Zeichenkette **p**.

**-self-command** string
: Eine C-Zeichenkette, die die Referenz angibt, die erforderlich ist, um die generierte Parser-Funktion (Methoden …) von einer anderen Parser-Funktion aus aufzurufen, entsprechend dem gewählten Rahmen (Template). Der Standardwert ist die leere Zeichenkette.

**-fun-qualifier** string
: Eine C-Zeichenkette mit den Attributen der erzeugten Funktionen (Methoden …) gemäß dem gewählten Rahmen (Template). Der Standardwert lautet **static**.

**-namespace** string
: Der Name des C-Namespaces, in dem sich die Parser-Funktionen (Methoden usw.) befinden sollen, oder ein allgemeines Präfix, das den Funktionsnamen vorangestellt werden soll. Der Standardwert ist die leere Zeichenkette.

**-main** string
: Der Name der Hauptfunktion (Methode, …), die vom ausgewählten Rahmen (Template) aufgerufen werden soll, um mit der Analyse der Eingabe zu beginnen. Der Standardwert ist **\__main**.

**-string-varname** string
: Der Name der Variablen, die für die Tabelle der Zeichenfolgen verwendet wird, auf die der generierte Parser zurückgreift, d. h. Fehlermeldungen, Symbolnamen usw. Der Standardwert lautet **p\_string**.

**-prelude** string
: Ein Codeausschnitt, der am Anfang jeder generierten Parsing-Funktion eingefügt werden soll. Der Standardwert ist die leere Zeichenkette.

**-indent** integer
: Die Anzahl der Zeichen, um die jede Zeile des generierten Codes eingerückt werden soll. Der Standardwert lautet **0**.

**-comments** boolean
: Ein Flag, das die Generierung von Code-Kommentaren steuert, die den ursprünglichen Parsing-Ausdruck enthalten, für den eine Parsing-Funktion vorgesehen ist. Der Standardwert lautet **on**.


# Snit-Parser

Das Format **snit** ist ausführbarer Code, ein Parser für die Grammatik. Es handelt sich um ein Tcl-Paket, das ein **snit::type** enthält, d. h. eine Klasse, deren Instanzen Parser für die Eingabegrammatik sind.

Dieses Ergebnisformat unterstützt die folgenden Optionen:

**-file** string
: Der Wert dieser Option ist der Name der Datei oder einer anderen Einheit, aus der die Grammatik stammt und für die der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-name** string
: Der Wert dieser Option ist der Name der Grammatik, die wir gerade verarbeiten. Der Standardwert lautet **a\_pe\_grammar**.

**-user** string
: Der Wert dieser Option ist der Name des Benutzers, unter dem der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-class** string
: Der Wert dieser Option ist der Name der zu generierenden Klasse ohne führende Doppelpunkte. Hinweis: Dieser Wert dient gleichzeitig als Name des zu generierenden Pakets, wenn die Option **-package** nicht festgelegt ist (siehe unten). Der Standardwert lautet **CLASS** und gilt, wenn weder die Option **-class** noch die Option **-package** festgelegt wurden.

**-package** string
: Der Wert dieser Option ist der Name des zu generierenden Pakets ohne führende Doppelpunkte. Hinweis: Dieser Wert dient gleichzeitig als Name der zu generierenden Klasse, wenn die Option **-class** nicht festgelegt wurde (siehe oben). Der Standardwert lautet **PACKAGE** und gilt, wenn weder die Option **-package** noch die Option **-class** festgelegt wurden.

**-version** string
: Der Wert dieser Option gibt die Version des zu erstellenden Pakets an. Der Standardwert lautet **1**.


# TclOO-Parser

Das Format **oo** ist ausführbarer Code, ein Parser für die Grammatik. Es handelt sich um ein Tcl-Paket, das eine Klasse **TclOO** enthält, deren Instanzen Parser für die Eingabegrammatik sind.

Dieses Ergebnisformat unterstützt die folgenden Optionen:

**-file** string
: Der Wert dieser Option ist der Name der Datei oder einer anderen Einheit, aus der die Grammatik stammt und für die der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-name** string
: Der Wert dieser Option ist der Name der Grammatik, die wir gerade verarbeiten. Der Standardwert lautet **a\_pe\_grammar**.

**-user** string
: Der Wert dieser Option ist der Name des Benutzers, unter dem der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-class** string
: Der Wert dieser Option ist der Name der zu generierenden Klasse ohne führende Doppelpunkte. Hinweis: Dieser Wert dient gleichzeitig als Name des zu generierenden Pakets, wenn die Option **-package** nicht festgelegt ist (siehe unten). Der Standardwert lautet **CLASS** und gilt, wenn weder die Option **-class** noch die Option **-package** festgelegt wurden.

**-package** string
: Der Wert dieser Option ist der Name des zu generierenden Pakets ohne führende Doppelpunkte. Hinweis: Dieser Wert dient gleichzeitig als Name der zu generierenden Klasse, wenn die Option **-class** nicht festgelegt wurde (siehe oben). Der Standardwert lautet **PACKAGE** und gilt, wenn weder die Option **-package** noch die Option **-class** festgelegt wurden.

**-version** string
: Der Wert dieser Option gibt die Version des zu erstellenden Pakets an. Der Standardwert lautet **1**.


# Grammatik-Container

Das Format **container** ist eine weitere Form, Parsing Expression Grammars zu beschreiben. Zwar sind Daten in diesem Format ausführbar, sie stellen jedoch keinen Parser für die Grammatik dar. Sie müssen stets in Verbindung mit dem Paket **pt::peg::interp**, einem Grammatik-Interpreter, verwendet werden.

Das Format stellt Grammatiken mittels einer **snit::type** dar, d. h. einer Klasse, deren Instanzen API-kompatibel zu den Instanzen des Pakets **pt::peg::container** sind und die mit der jeweiligen Grammatik vorbelegt sind.

Dieses Ergebnisformat unterstützt die folgenden Optionen:

**-file** string
: Der Wert dieser Option ist der Name der Datei oder einer anderen Einheit, aus der die Grammatik stammt und für die der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-name** string
: Der Wert dieser Option ist der Name der Grammatik, die wir gerade verarbeiten. Der Standardwert lautet **a\_pe\_grammar**.

**-user** string
: Der Wert dieser Option ist der Name des Benutzers, unter dem der Befehl ausgeführt wird. Der Standardwert lautet **unknown**.

**-mode** **bulk**|**incremental**
: Der Wert dieser Option legt fest, welche Methoden von **pt::peg::container**-Instanzen zur Festlegung der Grammatik verwendet werden, d. h. zum Vorladen in den Container. Es gibt zwei zulässige Werte, die im Folgenden aufgeführt sind. Der Standardwert ist **bulk**.

    **bulk**
    : In diesem Modus werden die Methoden **start**, **add**, **modes** und **rules** verwendet, um die Grammatik pauschal festzulegen, d. h. als eine Menge von nichtterminalen Symbolen sowie zwei Dictionarys, die die Symbole ihren semantischen Modi und Parsing-Ausdrücken zuordnen.

        Dieser Modus ist der Standardmodus.

    **incremental**
    : In diesem Modus werden die Methoden **start**, **add**, **mode** und **rule** verwendet, um die Grammatik stückweise festzulegen, wobei jedes Nichtterminal über einen eigenen Block von Definitionsbefehlen verfügt.


**-template** string
: Der Wert dieser Option ist eine Zeichenkette, in die der generierte Code und die übrigen Konfigurationseinstellungen eingefügt werden sollen. Es wird erwartet, dass die verschiedenen Speicherorte für Benutzerdaten mithilfe der unten aufgeführten Platzhalter angegeben werden. Der Standardwert lautet „**@code@**“.

    **@user@**
    : Ist durch den Wert der Option **-user** zu ersetzen.

    **@format@**
    : Ist durch die Konstante **CONTAINER** zu ersetzen.

    **@file@**
    : Ist durch den Wert der Option **-file** zu ersetzen.

    **@name@**
    : Ist durch den Wert der Option **-name** zu ersetzen.

    **@mode@**
    : Ist durch den Wert der Option **-mode** zu ersetzen.

    **@code@**
    : Wird durch den generierten Code ersetzt.



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

Daraus erstellen wir einen SNIT-basierten Parser mithilfe von

```
pt generate snit calculator.tcl -class calculator -name calculator peg calculator.peg
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

Wichtig ist: Die hier verwendeten Parser geben eine Datenstruktur zurück, die die Struktur der Eingabe gemäß der dem Parser zugrunde liegenden Grammatik abbildet. Während des Parsing-Prozesses gibt es *keine* Rückruffunktionen, d. h. keine *Parsing-Aktionen*, wie sie bei den meisten anderen Parsern zu finden sind.

Kehren wir zum letzten Codeausschnitt zurück, in dem der Parser für eine bestimmte Eingabe ausgeführt wird: Beachten Sie, wie die Parser-Instanz der festgelegten *Parser-API* folgt.

# Interne Abläufe

Dieser Abschnitt richtet sich an Nutzer der Anwendung, die diese ändern oder erweitern möchten. Nutzer, die sich ausschließlich für die Erstellung von Parsern interessieren, können diesen Abschnitt überspringen.

Die Hauptfunktionalität der Anwendung ist im Paket **pt::pgen** zusammengefasst. Bitte lesen Sie dieses Paket, um weitere Informationen zu erhalten.

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
