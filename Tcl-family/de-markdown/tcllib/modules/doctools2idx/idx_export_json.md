---
CommandName: doctools::idx::export::json
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - JSON
 - doctools
 - export
 - index
 - serialization
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::idx::export::json – JSON-Export-Plugin

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::idx::export::json]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [textutil::adjust]{.lit} 
[export]{.cmd} [serial]{.arg} [configuration]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket implementiert das doctools-Export-Plugin für Schlüsselwortindizes zur Erzeugung von JSON-Markup.

Hierbei handelt es sich um ein internes Paket von doctools, das von den übergeordneten Verwaltungspaketen zur Verwaltung von Schlüsselwortindizes verwendet wird, insbesondere von **doctools::idx::export**, dem Exportmanager.

Die Nutzung über einen herkömmlichen Interpreter ist zwar möglich, jedoch nur unter Umwegen, und wird nicht empfohlen. Die korrekte Vorgehensweise zur Nutzung dieser Funktionalität erfolgt über das Paket **doctools::idx::export** und die darin bereitgestellten Exportmanager-Objekte.

# API

Die von diesem Paket bereitgestellte API entspricht der Spezifikation der docidx-Export-Plugin-API, Version 2.

**export** *serial* *configuration*
: Dieser Befehl nimmt die kanonische Serialisierung eines Schlüsselwortindexes, wie im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES** festgelegt und in *serial* enthalten, sowie die *configuration* (ein Dictionary), und erzeugt JSON-Markup, das den Index kodiert. Die erzeugte Zeichenkette wird anschließend als Ergebnis des Befehls zurückgegeben.


# JSON-NOTATION VON SCHLÜSSELWORTINDIZES

Das für Schlüsselwortindizes verwendete JSON-Format ist eine direkte Umsetzung des **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES**, bei der Tcl-Dictionaries als JSON-Objekte und Tcl-Listen als JSON-Arrays abgebildet werden. Beispielsweise entspricht die Tcl-Serialisierung

```
doctools::idx {
	label {Keyword Index}
	keywords {
		changelog  {changelog.man cvs.man}
		conversion {doctools.man docidx.man doctoc.man apps/dtplite.man mpexpand.man}
		cvs        cvs.man
	}
	references {
		apps/dtplite.man {manpage dtplite}
		changelog.man    {manpage doctools::changelog}
		cvs.man          {manpage doctools::cvs}
		docidx.man       {manpage doctools::idx}
		doctoc.man       {manpage doctools::toc}
		doctools.man     {manpage doctools}
		mpexpand.man     {manpage mpexpand}
	}
	title {}
}
```

der JSON-Zeichenkette

```
{
    "doctools::idx" : {
        "label"      : "Keyword Index",
        "keywords"   : {
            "changelog"  : ["changelog.man","cvs.man"],
            "conversion" : ["doctools.man","docidx.man","doctoc.man","apps\/dtplite.man","mpexpand.man"],
            "cvs"        : ["cvs.man"],
        },
        "references" : {
            "apps\/dtplite.man" : ["manpage","dtplite"],
            "changelog.man"     : ["manpage","doctools::changelog"],
            "cvs.man"           : ["manpage","doctools::cvs"],
            "docidx.man"        : ["manpage","doctools::idx"],
            "doctoc.man"        : ["manpage","doctools::toc"],
            "doctools.man"      : ["manpage","doctools"],
            "mpexpand.man"      : ["manpage","mpexpand"]
        },
        "title"      : ""
    }
}
```

# KONFIGURATION

Das JSON-Export-Plugin erkennt die folgenden Konfigurationsvariablen und ändert sein Verhalten so, wie sie es vorgeben.

boolean *indented*
: Ist dieses Flag gesetzt, bricht das Plugin den erzeugten JSON-Code auf mehrere Zeilen um und rückt ihn entsprechend seinem inneren Aufbau ein, mit jedem Schlüssel eines Dictionarys in einer eigenen Zeile. Ist dieses Flag nicht gesetzt (die Vorgabe), wird das ganze JSON-Objekt in eine einzige Zeile geschrieben, mit möglichst wenig Abstand zwischen allen Elementen.

boolean *aligned*
: Ist dieses Flag gesetzt, sorgt der Generator dafür, dass die Werte der Schlüssel in einem Dictionary senkrecht zueinander ausgerichtet sind, mit dem Effekt einer Tabelle. Damit das wirkt, ist auch **indented** gesetzt. Ist dieses Flag nicht gesetzt (die Vorgabe), wird die Ausgabe gemäß dem Wert von **indented** formatiert, ohne die Werte der Dictionary-Schlüssel auszurichten. *Hinweis*: Dieses Plugin ignoriert die Standard-Konfigurationsvariablen **user**, **format**, **file** und **map** sowie ihre Werte.


# SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES

Hier legen wir das Format fest, das von den doctools-v2-Paketen verwendet wird, um Schlüsselwortindizes als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Ein Schlüsselwortindex kann zwar mehr als eine reguläre Serialisierung aufweisen, doch genau eine davon ist *kanonisch*.

**reguläre Serialisierung**
: 


**\[1\]**
: Eine Index-Serialisierung ist ein verschachteltes Tcl-Dictionary.

**\[2\]**
: Dieses Dictionary enthält einen einzigen Schlüssel, **doctools::idx**, sowie dessen Wert. Dieser Wert enthält den Inhalt des Index.

**\[3\]**
: Der Inhalt des Indexes besteht aus einem Tcl-Dictionary, das den Titel des Indexes, eine Bezeichnung sowie die Schlüsselwörter und Verweise enthält. Die entsprechenden Schlüssel und ihre Werte lauten


**title**
: Der Wert ist eine Zeichenkette, die den Titel des Indexes enthält.

**label**
: Der Wert ist eine Zeichenkette, die eine Bezeichnung für den Index enthält.

**keywords**
: Der Wert ist ein Tcl-Dictionary, das die dem Index bekannten Schlüsselwörter als Schlüssel verwendet. Die zugehörigen Werte sind Listen, die die Bezeichner der Referenzen enthalten, die diesem bestimmten Schlüsselwort zugeordnet sind. Jeder in diesen Listen verwendete Referenzbezeichner muss als Schlüssel im Dictionary **references** vorhanden sein; dessen Definition steht im nächsten Punkt.

**references**
: Der Wert ist ein Tcl-Dictionary, das die dem Index bekannten Bezeichner der Referenzen als Schlüssel verwendet. Die zugehörigen Werte sind Listen mit zwei Elementen, die in dieser Reihenfolge den Typ und die Bezeichnung der Referenz enthalten. Jeder Schlüssel hier muss mindestens einem Schlüsselwort zugeordnet sein, d. h., er muss in mindestens einer der Referenzlisten vorkommen, die die Werte im Dictionary **keywords** bilden; die Definition hierfür steht im vorherigen Punkt.


**\[4\]**
: Der *type* einer Referenz kann einen von zwei Werten annehmen,


**manpage**
: Der Bezeichner der Referenz wird als symbolischer Dateiname interpretiert, der sich auf eines der Dokumente bezieht, für die der Index erstellt wurde.

**url**
: Der Bezeichner der Referenz wird als URL interpretiert, die auf einen externen Ort verweist, beispielsweise eine Website usw.


**kanonische Serialisierung**
: Die kanonische Serialisierung eines Schlüsselwortindexes hat das im vorherigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen des Schlüsselwortindexes eindeutig ist.


**\[1\]**
: Die Schlüssel in allen verschachtelten Tcl-Dictionaries sind in aufsteigender Wörterbuchreihenfolge sortiert, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.

**\[2\]**
: Die für jedes Schlüsselwort des Indexes aufgeführten Referenzen – sofern vorhanden – werden in aufsteigender Wörterbuchordnung ihrer *Bezeichnungen* aufgelistet, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.


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
