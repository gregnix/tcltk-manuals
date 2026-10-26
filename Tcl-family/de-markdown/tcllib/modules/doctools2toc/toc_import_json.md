---
CommandName: doctools::toc::import::json
ManualSection: n
Version: 0.2.1
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - JSON
 - deserialization
 - doctools
 - import
 - table of contents
 - toc
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::toc::import::json – JSON-Import-Plugin

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::toc::import::json]{.lit} [0.2.1]{.optlit} 
[package]{.cmd} [require]{.sub} [doctools::toc::structure]{.lit} 
[package]{.cmd} [require]{.sub} [json]{.lit} 
[import]{.cmd} [string]{.arg} [configuration]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket implementiert das Import-Plugin von doctools für Inhaltsverzeichnisse, zum Parsen von JSON-Markup.

Es ist ein internes Paket von doctools, für die übergeordneten Verwaltungspakete, die Inhaltsverzeichnisse bearbeiten, insbesondere **doctools::toc::import**, den Import-Manager.

Der Aufruf aus einem gewöhnlichen Interpreter ist möglich, aber nur mit Verrenkungen, und wird nicht empfohlen. Der vorgesehene Weg führt über das Paket **doctools::toc::import** und die Import-Manager-Objekte, die es bereitstellt.

# API

Die von diesem Paket bereitgestellte API erfüllt die Spezifikation der doctoc-Import-Plugin-API, Version 2.

**import** *string* *configuration*
: Dieser Befehl nimmt die *string* entgegen und parst sie als JSON-Markup, das ein Inhaltsverzeichnis kodiert, im Kontext der angegebenen *configuration* (ein Dictionary). Das Ergebnis des Befehls ist die kanonische Serialisierung dieses Inhaltsverzeichnisses, in der Form aus dem Abschnitt **SERIALISIERUNGSFORMAT FÜR INHALTSVERZEICHNISSE**.


# JSON-NOTATION VON INHALTSVERZEICHNISSEN

Das für Inhaltsverzeichnisse verwendete JSON-Format ist eine direkte Abbildung des **SERIALISIERUNGSFORMAT FÜR INHALTSVERZEICHNISSE**, wobei Tcl-Dictionaries JSON-Objekten und Tcl-Listen JSON-Arrays entsprechen. Zum Beispiel ist die Tcl-Serialisierung

```
doctools::toc {
    items {
        {reference {
	    desc {DocTools - Tables of Contents}
	     id introduction.man
	     label doctools::toc::introduction
	}}
	{division {
	     id processing.man
	     items {
	         {reference {
		     desc {doctoc serialization utilities}
		     id structure.man
		     label doctools::toc::structure
		 }}
		 {reference {
		     desc {Parsing text in doctoc format}
		     id parse.man
		     label doctools::toc::parse
		 }}
	     }
             label Processing
        }}
    }
    label {Table of Contents}
    title TOC
}
```

entspricht der JSON-Zeichenkette

```
{
    "doctools::toc" : {
        "items" : [{
            "reference" : {
                "desc"  : "DocTools - Tables of Contents",
                "id"    : "introduction.man",
                "label" : "doctools::toc::introduction"
            }
        },{
            "division" : {
                "id"    : "processing.man",
                "items" : [{
                    "reference" : {
                        "desc"  : "doctoc serialization utilities",
                        "id"    : "structure.man",
                        "label" : "doctools::toc::structure"
                    }
                },{
                    "reference" : {
                        "desc"  : "Parsing text in doctoc format",
                        "id"    : "parse.man",
                        "label" : "doctools::toc::parse"
                    }
                }],
                "label" : "Processing"
            }
        }],
        "label" : "Table of Contents",
        "title" : "TOC"
    }
}
```

# SERIALISIERUNGSFORMAT FÜR INHALTSVERZEICHNISSE

Hier ist das Format festgelegt, in dem die Pakete von doctools v2 Inhaltsverzeichnisse als unveränderliche Werte für den Transport, den Vergleich und Ähnliches serialisieren.

Es wird zwischen *regulären* und *kanonischen* Serialisierungen unterschieden. Ein Inhaltsverzeichnis kann mehr als eine reguläre Serialisierung haben, *kanonisch* ist aber genau eine.

**regular serialization**
: 


**\[1\]**
: Die Serialisierung eines beliebigen Inhaltsverzeichnisses ist ein verschachteltes Tcl-Dictionary.

**\[2\]**
: Dieses Dictionary enthält genau einen Schlüssel, **doctools::toc**, und dessen Wert. Dieser Wert enthält den Inhalt des Inhaltsverzeichnisses.

**\[3\]**
: Der Inhalt des Inhaltsverzeichnisses ist ein Tcl-Dictionary mit dem Titel des Inhaltsverzeichnisses, einer Bezeichnung und seinen Elementen. Die maßgeblichen Schlüssel und ihre Werte sind


**title**
: Der Wert ist eine Zeichenkette mit dem Titel des Inhaltsverzeichnisses.

**label**
: Der Wert ist eine Zeichenkette mit einer Bezeichnung für das Inhaltsverzeichnis.

**items**
: Der Wert ist eine Tcl-Liste mit den Elementen des Inhaltsverzeichnisses, in der Reihenfolge, in der sie angezeigt werden sollen. Jedes Element ist eine Tcl-Liste mit dem Typ des Eintrags und seiner Beschreibung, in dieser Reihenfolge. Anders gesagt ist es ein Tcl-Dictionary mit genau einem Schlüssel, dem Eintragstyp, abgebildet auf die Beschreibung des Eintrags. Die beiden zulässigen Eintragstypen und ihre Beschreibungen sind


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


**canonical serialization**
: Die kanonische Serialisierung eines Inhaltsverzeichnisses hat das im vorigen Punkt festgelegte Format und erfüllt zusätzlich die folgenden Bedingungen. Dadurch ist sie unter allen möglichen Serialisierungen dieses Inhaltsverzeichnisses eindeutig.


**\[1\]**
: Die Schlüssel in allen verschachtelten Tcl-Dictionaries sind in aufsteigender Wörterbuchreihenfolge sortiert, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textformatierer-Plugin

# COPYRIGHT

```
Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
