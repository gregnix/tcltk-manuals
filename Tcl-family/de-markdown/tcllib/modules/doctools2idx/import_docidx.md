---
CommandName: doctools::idx::import::docidx
ManualSection: n
Version: 0.2.1
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - deserialization
 - docidx
 - doctools
 - import
 - index
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::idx::import::docidx – docidx-Import-Plugin

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::idx::import::docidx]{.lit} [0.2.1]{.optlit} 
[package]{.cmd} [require]{.sub} [doctools::idx::parse]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::idx::structure]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::msgcat]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::tcl::parse]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [struct::list]{.lit} 
[package]{.cmd} [require]{.sub} [struct::set]{.lit} 
[package]{.cmd} [require]{.sub} [struct::stack]{.lit} 
[package]{.cmd} [require]{.sub} [struct::tree]{.lit} 
[package]{.cmd} [require]{.sub} [treeql]{.lit} 
[import]{.cmd} [string]{.arg} [configuration]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket implementiert das doctools-Import-Plugin für Schlüsselwortindizes zum Parsen von docidx-Markup.

Hierbei handelt es sich um ein internes Paket von doctools, das von den übergeordneten Verwaltungspaketen zur Verwaltung von Schlüsselwortindizes verwendet wird, insbesondere von **doctools::idx::import**, dem Import-Manager.

Die Nutzung über einen herkömmlichen Interpreter ist zwar möglich, jedoch nur auf Umwegen, und wird nicht empfohlen. Die korrekte Vorgehensweise zur Nutzung dieser Funktionalität erfolgt über das Paket **doctools::idx::import** und die darin bereitgestellten Import-Manager-Objekte.

# API

Die von diesem Paket bereitgestellte API entspricht der Spezifikation der docidx-Import-Plugin-API, Version 2.

**import** *string* *configuration*
: Dieser Befehl nimmt den *string* und parst ihn im Kontext der angegebenen *configuration* (ein Dictionary) als docidx-Markup, das einen Schlüsselwortindex kodiert. Das Ergebnis des Befehls ist die kanonische Serialisierung dieses Schlüsselwortindexes in der im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES** angegebenen Form.


# \[DOCIDX\]-NOTATION VON SCHLÜSSELWORTINDIZES

Das docidx-Format für Schlüsselwortindizes, auch als *docidx-Markup-Sprache* bezeichnet, ist zu umfangreich, um in einem einzigen Abschnitt behandelt zu werden. Der interessierte Leser sollte mit dem Dokument beginnen

**\[1\]**
: *Einleitung in die docidx-Sprache* und von dort zu den formalen Spezifikationen weitergehen, d. h. den Dokumenten

**\[1\]**
: *Syntax der docidx-Sprache* und

**\[2\]**
: *Befehlsreferenz der docidx-Sprache*, um die Sprache gründlich zu verstehen.


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
