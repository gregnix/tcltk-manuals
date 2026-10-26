---
CommandName: doctools::idx::export::nroff
ManualSection: n
Version: 0.4
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - doctools
 - export
 - index
 - nroff
 - serialization
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::idx::export::nroff – nroff-Export-Plugin

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::idx::export::nroff]{.lit} [0.4]{.optlit} 
[package]{.cmd} [require]{.sub} [doctools::text]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::nroff::man_macros]{.lit} 
[export]{.cmd} [serial]{.arg} [configuration]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket implementiert das doctools-Export-Plugin für Schlüsselwortindizes zur Erzeugung von nroff-Markup.

Hierbei handelt es sich um ein internes Paket von doctools, das von den übergeordneten Verwaltungspaketen zur Verwaltung von Schlüsselwortindizes verwendet wird, insbesondere von **doctools::idx::export**, dem Exportmanager.

Die Nutzung über einen herkömmlichen Interpreter ist zwar möglich, jedoch nur unter Umwegen, und wird nicht empfohlen. Die korrekte Vorgehensweise zur Nutzung dieser Funktionalität erfolgt über das Paket **doctools::idx::export** und die darin bereitgestellten Exportmanager-Objekte.

# API

Die von diesem Paket bereitgestellte API entspricht der Spezifikation der docidx-Export-Plugin-API, Version 2.

**export** *serial* *configuration*
: Dieser Befehl nimmt die kanonische Serialisierung eines Schlüsselwortindexes, wie im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES** festgelegt und in *serial* enthalten, sowie die *configuration* (ein Dictionary), und erzeugt nroff-Markup, das den Index kodiert. Die erzeugte Zeichenkette wird anschließend als Ergebnis des Befehls zurückgegeben.


# KONFIGURATION

Das nroff-Export-Plugin erkennt die folgenden Konfigurationsvariablen und ändert sein Verhalten so, wie sie es vorgeben.

string *user*
: Diese Standard-Konfigurationsvariable enthält den Namen des Benutzers, der den Prozess ausführt, welcher das Export-Plugin aufgerufen hat. Das Plugin schreibt diese Angabe in den Herkunftskommentar am Anfang des erzeugten Dokuments.

string *file*
: Diese Standardkonfigurationsvariable enthält den Namen der Datei, aus der der Index stammt. Diese Variable kann ungesetzt sein oder die leere Zeichenkette enthalten. Das Plugin fügt diese Information, sofern sie definiert ist, d. h. gesetzt ist und nicht die leere Zeichenkette enthält, in den Herkunftskommentar am Anfang des generierten Dokuments ein.

boolean *inline*
: Ist dieses Flag gesetzt (Standard), fügt das Plugin die Definitionen des *man*-Makrosatzes direkt in die Ausgabe. Ist dieses Flag nicht gesetzt, fügt das Plugin einen Verweis auf die Definitionen des *man*-Makrosatzes in die Ausgabe, jedoch nicht die Makrodefinitionen selbst. *Hinweis*: Dieses Plugin ignoriert die Standard-Konfigurationsvariablen **format** und **map** sowie ihre Werte.


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
