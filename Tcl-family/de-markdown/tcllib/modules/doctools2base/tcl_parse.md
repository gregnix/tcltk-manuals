---
CommandName: doctools::tcl::parse
title: doctools::tcl::parse
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - Tcl syntax
 - command
 - doctools
 - parser
 - subst
 - word
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::tcl::parse – Verarbeitung von Text im Format „subst -novariables“

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [fileutil]{.lit}
[package]{.cmd} [require]{.sub} [logger]{.lit}
[package]{.cmd} [require]{.sub} [struct::list]{.lit}
[package]{.cmd} [require]{.sub} [struct::stack]{.lit}
[package]{.cmd} [require]{.sub} [struct::set]{.lit}
[package]{.cmd} [require]{.sub} [treeql]{.lit}
[package]{.cmd} [require]{.sub} [doctools::tcl::parse]{.lit} [0.2]{.optlit}
[::doctools::tcl::parse]{.cmd} [text]{.lit} [tree]{.arg} [text]{.arg} [root]{.optarg}
[::doctools::tcl::parse]{.cmd} [file]{.lit} [tree]{.arg} [path]{.arg} [root]{.optarg}
:::

# Beschreibung

Dieses Paket stellt Befehle zum Parsen von Text mit eingebetteten Tcl-Befehlen bereit, wie sie vom Tcl-Befehl „**subst -novariables**“ verarbeitet werden. Das Ergebnis des Parsens ist ein abstrakter Syntaxbaum.

Hierbei handelt es sich um ein internes Paket von doctools, das von den übergeordneten Parsern zur Verarbeitung der Markup-Sprachen *docidx*, *doctoc* und *doctools* verwendet wird.

# API

**::doctools::tcl::parse** **text** *tree* *text* ?*root*?
: Der Befehl nimmt den *text* und parst ihn unter der Annahme, dass er eine Zeichenkette enthält, die der eingebaute Tcl-Befehl **subst -novariables** annimmt. Andernfalls wird beim Parsen ein Fehler ausgelöst. Das für diese Fehler verwendete Format ist im Abschnitt [Fehlerformat] beschrieben.

    Der Befehl gibt als Ergebnis die leere Zeichenkette zurück. Das eigentliche Ergebnis des Parsens wird in die Baumstruktur *tree* unter dem Knoten *root* eingetragen. Wird *root* nicht angegeben, wird die Wurzel von *tree* verwendet. *tree* muss vorhanden sein und der Befehl eines Baumobjekts sein, das dieselben Methoden unterstützt wie die vom Paket **struct::tree** erzeugten Bäume.

    Im Fehlerfall bleibt *tree* in einem undefinierten Zustand.

**::doctools::tcl::parse** **file** *tree* *path* ?*root*?
: Entspricht **text**, mit dem Unterschied, dass der zu analysierende Text aus der durch *path* angegebenen Datei gelesen wird.


# Fehlerformat

Wenn der Parser ein Problem in der Eingabe feststellt, löst er einen Fehler in dem hier beschriebenen Format aus.

1. Die Meldung enthält den Grund für das Problem (unerwartetes Zeichen oder Ende der Eingabe), gegebenenfalls das betreffende Zeichen sowie die Zeile und Spalte, in der das Problem festgestellt wurde – und zwar in einer für Menschen lesbaren Form. Dieser Teil wird nicht näher dokumentiert, da sich sein Format nach unserem Ermessen ändern kann. Er ist für Menschen bestimmt, nicht für Maschinen.

2. Der Fehlercode enthält jedoch eine maschinenlesbare Darstellung des Problems in Form einer Liste mit fünf Elementen, die in der unten aufgeführten Reihenfolge Folgendes enthält:

    1. die konstante Zeichenkette **doctools::tcl::parse**

    2. die Ursache des Problems, eine von

        **char**
        : Unerwartetes Zeichen in der Eingabe

        **eof**
        : Unerwartetes Ende der Eingabe


    3. Die Position des Problems, gemessen als Versatz vom Anfang der Eingabe, in Zeichen. Hinweis: Zeilenmarkierungen zählen als ein Zeichen.

    4. Die Zeile, in der das Problem festgestellt wurde (gezählt ab 1 (eins)),

    5. Die Spalte, in der das Problem festgestellt wurde (gezählt ab 0 (Null))



# Baumstruktur

Nach der erfolgreichen Analyse einer Zeichenkette weist der generierte Baum folgende Struktur auf:

1. In den folgenden Punkten bezieht sich das Wort „Wurzel“ auf den Knoten, der beim Aufruf von **text** oder **file** als Wurzel des Baums festgelegt wurde. Dabei kann es sich um die tatsächliche Wurzel des Baums handeln.

2. Bei allen folgenden Punkten wird zudem die Möglichkeit bereits vorhandener Attribute in den bestehenden Knoten außer Acht gelassen. Wenn Attribute mit denselben Namen wie die vom Parser verwendeten Attribute vorhanden sind, werden die bereits vorhandenen Werte überschrieben. Attribute, deren Namen nicht mit den Attributen des Parsers kollidieren, bleiben unberührt.

3. Der Wurzelknoten weist keine Attribute auf.

4. Alle anderen Knoten verfügen über die folgenden Attribute

    type
    : Der Wert ist eine Zeichenkette aus der Menge { Command , Text , Word }

    range
    : Der Wert ist entweder leer oder eine Liste mit zwei Elementen, die ganzzahlige Werte enthält. Die Zahlen geben die Offsets des ersten und letzten Zeichens im Eingabetext des durch den Knoten beschriebenen Tokens an.

    line
    : Der Wert ist eine ganze Zahl und gibt die Zeile in der Eingabe an, in der das durch den Knoten beschriebene Token endet. Die Zeilen werden ab 1 (**eins**) gezählt.

    col
    : Der Wert ist eine ganze Zahl und gibt die Spalte in der Zeile der Eingabe an, in der das durch den Knoten beschriebene Token endet. Die Spalten werden ab 0 gezählt (**null**).


5. Die Kindknoten der Wurzel, sofern vorhanden, sind vom Typ Command und Text, in Halbalternation. Das bedeutet: Auf einen Text-Knoten muss ein Command-Knoten folgen, und auf einen Command-Knoten kann alles folgen, ein Text- oder ein weiterer Command-Knoten.

6. Die Kindknoten eines Command-Knotens, sofern vorhanden, sind vom Typ Command, Text und Word; sie beschreiben die Argumente des Befehls.

7. Die Kindknoten eines Word-Knotens, sofern vorhanden, sind vom Typ Command und Text, in Halbalternation. Das bedeutet: Auf einen Text-Knoten muss ein Command-Knoten folgen, und auf einen Command-Knoten kann alles folgen, ein Text- oder ein weiterer Command-Knoten.

8. Ein Word-Knoten ohne Kindknoten steht für die leere Zeichenkette.

9. Alle Text-Knoten sind Blätter des Baums.

10. Alle Blätter des Baums sind entweder Text- oder Command-Knoten. Word-Knoten können keine Blätter sein.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Dokumentationswerkzeuge

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
