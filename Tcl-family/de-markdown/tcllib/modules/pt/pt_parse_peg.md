---
CommandName: pt_parse_peg
title: pt_parse_peg
ManualSection: i
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

# Name

pt\_parse\_peg – Parser-Tools: PEG-Parser

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::parse::peg]{.lit} [1]{.lit}
[pt::parse::peg]{.cmd} [objectName]{.optarg}
[objectName]{.ins} [destroy]{.sub}
[objectName]{.ins} [parse]{.sub} [chan]{.arg}
[objectName]{.ins} [parset]{.sub} [text]{.arg}
:::

# Beschreibung

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket stellt eine Klasse bereit, deren Instanzen Parser für Parsing Expression Grammars in Textform sind.

# API für Klassen

**pt::parse::peg** ?*objectName*?
: Der Klassenbefehl erstellt Parser-Instanzen, d. h. Objekte. Das Ergebnis des Befehls ist der vollqualifizierte Name der Instanz.

    Wenn kein *objectName* angegeben wird, generiert die Klasse einen automatischen Namen und verwendet diesen. Wenn der *objectName* zwar angegeben wurde, jedoch nicht vollqualifiziert ist, wird die Instanz im aktuellen Namespace erstellt.


# Instanz-API

Alle Parser-Instanzen stellen mindestens die unten aufgeführten Methoden bereit:

*objectName* **destroy**
: Diese Methode löscht die Parser-Instanz, gibt den gesamten belegten Speicher sowie alle anderen Ressourcen frei und löscht den Instanzbefehl.

    Das Ergebnis des Befehls ist die leere Zeichenkette.

*objectName* **parse** *chan*
: Bei dieser Methode wird der Parser mit dem Inhalt von *chan* als Eingabe ausgeführt (beginnend an der aktuellen Position im Kanal), bis kein weiteres Parsen mehr möglich ist, entweder weil das Parsen abgeschlossen ist oder weil ein Syntaxfehler aufgetreten ist.

    Zu beachten ist, dass die Parser-Tools auf Tcl 8.5+ basieren. Mit anderen Worten: Das Kanalargument ist nicht auf Dateien, Sockets usw. beschränkt. Uns steht die volle Leistungsfähigkeit von *reflektierten Kanälen* zur Verfügung.

    Es sei außerdem darauf hingewiesen, dass der Parser die Zeichen bei Bedarf aus dem Eingabestrom abruft. Wenn ein durch dieses Paket erstellter Parser im Push-Modus, d. h. ereignisgesteuert betrieben werden muss, ist es erforderlich, auf Tcl 8.6+ umzusteigen und **coroutine::auto** zu verwenden, um ihn in eine Coroutine zu verpacken, wobei **read** entsprechend für den Push-Betrieb angepasst werden muss.

    Nach erfolgreicher Ausführung gibt der Befehl einen abstrakten Syntaxbaum (AST) als Ergebnis zurück. Dieser AST hat die in Abschnitt **AST-SERIALISIERUNGSFORMAT** festgelegte Form. Als einfache verschachtelte Tcl-Liste kann er anschließend mit beliebigen Tcl-Befehlen des Benutzers weiterverarbeitet werden, um Transformationen, semantische Prüfungen usw. durchzuführen. Um dies zu erleichtern, bietet das Paket **pt::ast** eine Reihe von Hilfsbefehlen zur Validierung der Grundstruktur des Baums, zu dessen Ausgabe für Debugging-Zwecke sowie zum Durchlaufen des Baums entweder von unten nach oben oder von oben nach unten.

    Wird ein Syntaxfehler festgestellt, löst der Befehl stattdessen einen Fehler aus. Dieser Fehler ist eine Tcl-Liste mit vier Elementen, die in der unten aufgeführten Reihenfolge Folgendes enthält:

    1. Die Zeichenfolge **pt::rde**, die darauf hinweist, dass es sich um einen Parser-Laufzeitfehler handelt.

    2. Die Position des Parsing-Fehlers, angegeben als Zeichenversatz vom Anfang der geparsten Eingabe.

    3. Die Position des Parsing-Fehlers, nun als Liste mit zwei Elementen, die die Zeilennummer und die Spalte innerhalb der Zeile enthalten.

    4. Eine Menge atomarer Parsing-Ausdrücke, welche die Zeichen und/oder Nichtterminale kodieren, die der Parser an der Fehlerstelle erwartet, aber nicht vorgefunden hat. Informationen zur Spezifikation atomarer Parsing-Ausdrücke finden Sie im Abschnitt **PE-SERIALISIERUNGSFORMAT**.


*objectName* **parset** *text*
: Diese Methode führt den Parser aus, wobei die Zeichenfolge in *text* als Eingabe verwendet wird. In allen anderen Punkten verhält sie sich wie die oben gezeigte Methode **parse**.


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
