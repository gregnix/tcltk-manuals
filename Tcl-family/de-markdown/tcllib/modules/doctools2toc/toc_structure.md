---
CommandName: doctools::toc::structure
title: doctools::toc::structure
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - deserialization
 - doctoc
 - doctools
 - serialization
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::toc::structure – Doctoc-Serialisierungswerkzeuge

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::toc::structure]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [logger]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[::doctools::toc::structure]{.cmd} [verify]{.lit} [serial]{.arg} [canonvar]{.optarg}
[::doctools::toc::structure]{.cmd} [verify-as-canonical]{.lit} [serial]{.arg}
[::doctools::toc::structure]{.cmd} [canonicalize]{.lit} [serial]{.arg}
[::doctools::toc::structure]{.cmd} [print]{.lit} [serial]{.arg}
[::doctools::toc::structure]{.cmd} [merge]{.lit} [seriala]{.arg} [serialb]{.arg}
:::

# Beschreibung

Dieses Paket stellt Befehle für die Arbeit mit den Serialisierungen von Inhaltsverzeichnissen bereit, wie sie das System doctools v2 verwaltet und wie sie im Abschnitt [Serialisierungsformat für Inhaltsverzeichnisse] festgelegt sind.

Es ist ein internes Paket von doctools, für die übergeordneten Pakete, die Inhaltsverzeichnisse bearbeiten und sie in verschiedene andere Formate umwandeln und daraus zurück, etwa Dokumente in der Auszeichnung *doctoc*.

# API

**::doctools::toc::structure** **verify** *serial* ?*canonvar*?
: Dieser Befehl prüft, ob der Inhalt von *serial* eine gültige *reguläre* Serialisierung eines Inhaltsverzeichnisses ist, und löst einen Fehler aus, wenn das nicht zutrifft. Das Ergebnis des Befehls ist die leere Zeichenkette.

    Ist das Argument *canonvar* angegeben, gilt es als Name einer Variablen im aufrufenden Kontext. In diese Variable wird genau dann geschrieben, wenn *serial* eine gültige reguläre Serialisierung ist. Ihr Wert ist ein boolescher Wert, **True**, wenn die Serialisierung nicht nur gültig, sondern auch *kanonisch* ist. **False** wird bei einer gültigen, aber nicht kanonischen Serialisierung geschrieben.

    Reguläre und kanonische Serialisierungen sind im Abschnitt [Serialisierungsformat für Inhaltsverzeichnisse] festgelegt.

**::doctools::toc::structure** **verify-as-canonical** *serial*
: Dieser Befehl prüft, ob der Inhalt von *serial* eine gültige *kanonische* Serialisierung eines Inhaltsverzeichnisses ist, und löst einen Fehler aus, wenn das nicht zutrifft. Das Ergebnis des Befehls ist die leere Zeichenkette.

    Kanonische Serialisierungen sind im Abschnitt [Serialisierungsformat für Inhaltsverzeichnisse] festgelegt.

**::doctools::toc::structure** **canonicalize** *serial*
: Dieser Befehl setzt voraus, dass der Inhalt von *serial* eine gültige *reguläre* Serialisierung eines Inhaltsverzeichnisses ist, und löst einen Fehler aus, wenn das nicht zutrifft.

    Danach wandelt er die Eingabe in die *kanonische* Serialisierung des enthaltenen Inhaltsverzeichnisses um und gibt sie als Ergebnis zurück. Ist die Eingabe schon kanonisch, wird sie unverändert zurückgegeben.

    Reguläre und kanonische Serialisierungen sind im Abschnitt [Serialisierungsformat für Inhaltsverzeichnisse] festgelegt.

**::doctools::toc::structure** **print** *serial*
: Dieser Befehl setzt voraus, dass das Argument *serial* eine gültige reguläre Serialisierung eines Inhaltsverzeichnisses enthält, und gibt eine Zeichenkette zurück, die dieses Inhaltsverzeichnis in einer für Menschen lesbaren Form enthält.

    Das genaue Format dieser Form ist nicht festgelegt und eignet sich nicht zum Parsen oder für andere maschinelle Verarbeitung.

    Reguläre Serialisierungen sind im Abschnitt [Serialisierungsformat für Inhaltsverzeichnisse] festgelegt.

**::doctools::toc::structure** **merge** *seriala* *serialb*
: Dieser Befehl nimmt die regulären Serialisierungen zweier Inhaltsverzeichnisse entgegen und bildet daraus ihre Vereinigung. Das Ergebnis des Befehls ist die kanonische Serialisierung dieses vereinigten Inhaltsverzeichnisses.

    Titel und Bezeichnung des Ergebnisses stammen aus dem in *serialb* enthaltenen Inhaltsverzeichnis.

    Das ganze Inhaltsverzeichnis und seine Abschnitte werden rekursiv auf dieselbe Weise zusammengeführt:

    1. Alle Verweise, die in beiden Abschnitten vorkommen (an ihrer Bezeichnung erkannt), werden vereinigt; Dokumentkennungen und Beschreibungen stammen aus dem zweiten Inhaltsverzeichnis.

    2. Alle Abschnitte, die in beiden Abschnitten vorkommen (an ihrer Bezeichnung erkannt), werden vereinigt, mit der optionalen Dokumentkennung aus dem zweiten Inhaltsverzeichnis, falls dort eine steht, sonst aus dem ersten. Die Elemente im Abschnitt werden rekursiv mit demselben Algorithmus zusammengeführt, der in dieser Liste beschrieben ist.

    3. Typkonflikte zwischen Elementen, also zwei Elemente mit derselben Bezeichnung, aber unterschiedlichem Typ, führen zu einem Fehler bei der Zusammenführung.

    4. Alle Elemente, die im zweiten Abschnitt, aber nicht im ersten vorkommen, werden ans Ende der Elementliste im Ergebnis der Zusammenführung angehängt.


    Reguläre und kanonische Serialisierungen sind im Abschnitt [Serialisierungsformat für Inhaltsverzeichnisse] festgelegt.


# Serialisierungsformat für Inhaltsverzeichnisse

Hier ist das Format festgelegt, in dem die Pakete von doctools v2 Inhaltsverzeichnisse als unveränderliche Werte für den Transport, den Vergleich und Ähnliches serialisieren.

Es wird zwischen *regulären* und *kanonischen* Serialisierungen unterschieden. Ein Inhaltsverzeichnis kann mehr als eine reguläre Serialisierung haben, *kanonisch* ist aber genau eine.

regular serialization
: 1. Die Serialisierung eines beliebigen Inhaltsverzeichnisses ist ein verschachteltes Tcl-Dictionary.

    2. Dieses Dictionary enthält genau einen Schlüssel, **doctools::toc**, und dessen Wert. Dieser Wert enthält den Inhalt des Inhaltsverzeichnisses.

    3. Der Inhalt des Inhaltsverzeichnisses ist ein Tcl-Dictionary mit dem Titel des Inhaltsverzeichnisses, einer Bezeichnung und seinen Elementen. Die maßgeblichen Schlüssel und ihre Werte sind

        **title**
        : Der Wert ist eine Zeichenkette mit dem Titel des Inhaltsverzeichnisses.

        **label**
        : Der Wert ist eine Zeichenkette mit einer Bezeichnung für das Inhaltsverzeichnis.

        **items**
        : Der Wert ist eine Tcl-Liste mit den Elementen des Inhaltsverzeichnisses, in der Reihenfolge, in der sie angezeigt werden sollen.

            Jedes Element ist eine Tcl-Liste mit dem Typ des Eintrags und seiner Beschreibung, in dieser Reihenfolge. Anders gesagt ist es ein Tcl-Dictionary mit genau einem Schlüssel, dem Eintragstyp, abgebildet auf die Beschreibung des Eintrags.

            Die beiden zulässigen Eintragstypen und ihre Beschreibungen sind

            **reference**
            : Dieser Punkt beschreibt einen einzelnen Eintrag im Inhaltsverzeichnis, der auf ein einzelnes Dokument verweist. Sein Wert ist dazu ein Tcl-Dictionary mit einer Kennung für das referenzierte Dokument, einer Bezeichnung und einer längeren Textbeschreibung, die dem Eintrag zugeordnet werden kann. Die maßgeblichen Schlüssel und ihre Werte sind

                **id**
                : Der Wert ist eine Zeichenkette mit der Kennung des Dokuments, das zu dem Eintrag gehört.

                **label**
                : Der Wert ist eine Zeichenkette mit einer Bezeichnung für diesen Eintrag. Diese Zeichenkette kennzeichnet den Eintrag ebenfalls, und keine zwei Einträge (Verweise und Abschnitte) in der enthaltenden Liste dürfen dieselbe Bezeichnung haben.

                **desc**
                : Der Wert ist eine Zeichenkette mit einer längeren Beschreibung dieses Eintrags.


            **division**
            : Dieser Punkt beschreibt eine Gruppe von Einträgen im Inhaltsverzeichnis und erzeugt damit eine Hierarchie von Einträgen. Sein Wert ist dazu ein Tcl-Dictionary mit einer Bezeichnung für die Gruppe, einer optionalen Kennung eines Dokuments für die ganze Gruppe und der Liste der Einträge in der Gruppe. Die maßgeblichen Schlüssel und ihre Werte sind

                **id**
                : Der Wert ist eine Zeichenkette mit der Kennung des Dokuments, das zur ganzen Gruppe gehört. Dieser Schlüssel ist optional.

                **label**
                : Der Wert ist eine Zeichenkette mit einer Bezeichnung für die Gruppe. Diese Zeichenkette kennzeichnet den Eintrag ebenfalls, und keine zwei Einträge (Verweise und Abschnitte) in der enthaltenden Liste dürfen dieselbe Bezeichnung haben.

                **items**
                : Der Wert ist eine Tcl-Liste mit den Elementen der Gruppe, in der Reihenfolge, in der sie angezeigt werden sollen. Diese Liste hat denselben Aufbau wie der Wert des Schlüssels **items** für das ganze Inhaltsverzeichnis, siehe oben. Damit schließt sich die rekursive Definition der Struktur: Abschnitte enthalten dieselben Arten von Elementen wie das ganze Inhaltsverzeichnis, einschließlich weiterer Abschnitte.





canonical serialization
: Die kanonische Serialisierung eines Inhaltsverzeichnisses hat das im vorigen Punkt festgelegte Format und erfüllt zusätzlich die folgenden Bedingungen. Dadurch ist sie unter allen möglichen Serialisierungen dieses Inhaltsverzeichnisses eindeutig.

    1. Die Schlüssel in allen verschachtelten Tcl-Dictionaries sind in aufsteigender Wörterbuchreihenfolge sortiert, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.



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
