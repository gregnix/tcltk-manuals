---
CommandName: doctools::idx::parse
title: doctools::idx::parse
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - docidx
 - doctools
 - lexer
 - parser
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::idx::parse – Parsen von Text im docidx-Format

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::idx::parse]{.lit} [0.2]{.optlit}
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [doctools::idx::structure]{.lit}
[package]{.cmd} [require]{.sub} [doctools::msgcat]{.lit}
[package]{.cmd} [require]{.sub} [doctools::tcl::parse]{.lit}
[package]{.cmd} [require]{.sub} [fileutil]{.lit}
[package]{.cmd} [require]{.sub} [logger]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [struct::list]{.lit}
[package]{.cmd} [require]{.sub} [struct::stack]{.lit}
[::doctools::idx::parse]{.cmd} [text]{.lit} [text]{.arg}
[::doctools::idx::parse]{.cmd} [file]{.lit} [path]{.arg}
[::doctools::idx::parse]{.cmd} [includes]{.lit}
[::doctools::idx::parse]{.cmd} [include]{.lit} [add]{.lit} [path]{.arg}
[::doctools::idx::parse]{.cmd} [include]{.lit} [remove]{.lit} [path]{.arg}
[::doctools::idx::parse]{.cmd} [include]{.lit} [clear]{.lit}
[::doctools::idx::parse]{.cmd} [vars]{.lit}
[::doctools::idx::parse]{.cmd} [var]{.lit} [set]{.lit} [name]{.arg} [value]{.arg}
[::doctools::idx::parse]{.cmd} [var]{.lit} [unset]{.lit} [name]{.arg}
[::doctools::idx::parse]{.cmd} [var]{.lit} [clear]{.lit} [pattern]{.optarg}
:::

# Beschreibung

Dieses Paket enthält Befehle zum Parsen von Text, der in der Markup-Sprache *docidx* verfasst ist, und zum Konvertieren dieses Textes in die kanonische Serialisierung des im Text kodierten Schlüsselwortindexes. Eine Beschreibung des Formats finden Sie im Abschnitt [Serialisierungsformat für Schlüsselwortindizes].

Hierbei handelt es sich um ein internes Paket von doctools, das von den übergeordneten Paketen zur Verarbeitung von *docidx*-Dokumenten verwendet wird.

# API

**::doctools::idx::parse** **text** *text*
: Der Befehl nimmt die in *text* enthaltene Zeichenkette entgegen und analysiert sie unter der Annahme, dass es sich um ein Dokument handelt, das mit der Markup-Sprache *docidx* verfasst wurde. Sollte sich diese Annahme als falsch erweisen, wird ein Fehler ausgelöst. Das Format dieser Fehler wird im Abschnitt [Parsing-Fehler] beschrieben.

    Wenn der Befehl erfolgreich ist, gibt er die kanonische Serialisierung des im Text kodierten Schlüsselwortindexes zurück. Eine Spezifikation dieses Formats finden Sie im Abschnitt [Serialisierungsformat für Schlüsselwortindizes].

**::doctools::idx::parse** **file** *path*
: Entspricht **text**, mit dem Unterschied, dass der zu analysierende Text aus der durch *path* angegebenen Datei gelesen wird.

**::doctools::idx::parse** **includes**
: Diese Methode gibt die aktuelle Liste der Suchpfade zurück, die bei der Suche nach Include-Dateien verwendet werden.

**::doctools::idx::parse** **include add** *path*
: Diese Methode fügt den *path* zur Liste der Pfade hinzu, die bei der Suche nach einer Include-Datei durchsucht werden. Der Aufruf wird ignoriert, wenn der Pfad schon in der Liste steht. Die Methode gibt die leere Zeichenkette als Ergebnis zurück.

**::doctools::idx::parse** **include remove** *path*
: Diese Methode entfernt den *path* aus der Liste der Pfade, die bei der Suche nach einer Include-Datei durchsucht werden. Der Aufruf wird ignoriert, wenn der Pfad nicht in der Liste steht. Die Methode gibt die leere Zeichenkette als Ergebnis zurück.

**::doctools::idx::parse** **include clear**
: Diese Methode leert die Liste der Suchpfade für Include-Dateien.

**::doctools::idx::parse** **vars**
: Diese Methode gibt ein Dictionary zurück, das die aktuellen vordefinierten Variablen enthält, die der Auszeichnungsbefehl **vset** während der Verarbeitung kennt.

**::doctools::idx::parse** **var set** *name* *value*
: Diese Methode nimmt die Variable *name* in die Menge der vordefinierten Variablen auf, die der Auszeichnungsbefehl **vset** während der Verarbeitung kennt, und gibt ihr den angegebenen *value*. Die Methode gibt die leere Zeichenkette als Ergebnis zurück.

**::doctools::idx::parse** **var unset** *name*
: Diese Methode entfernt die Variable *name* aus der Menge der vordefinierten Variablen, die der Auszeichnungsbefehl **vset** während der Verarbeitung kennt. Die Methode gibt die leere Zeichenkette als Ergebnis zurück.

**::doctools::idx::parse** **var clear** ?*pattern*?
: Diese Methode entfernt alle Variablen, auf die das *pattern* passt, aus der Menge der vordefinierten Variablen, die der Auszeichnungsbefehl **vset** während der Verarbeitung kennt. Die Methode gibt die leere Zeichenkette als Ergebnis zurück.

    Der Abgleich erfolgt mit **string match**, und das Vorgabemuster, wenn keines angegeben ist, ist **\***.


# Parsing-Fehler

Das Format der Parsing-Fehlermeldungen, die bei Verstößen gegen die *docidx*-Markup-Syntax ausgegeben werden, ist für Menschen lesbar und nicht für die maschinelle Verarbeitung vorgesehen. Daher wird es nicht dokumentiert.

*Allerdings* ist der an die Meldung angehängte errorCode maschinenlesbar und hat das folgende Format:

1. Der Fehlercode ist eine Liste, wobei jedes Element einen einzelnen in der Eingabe gefundenen Fehler beschreibt. Die Liste enthält mindestens ein Element, möglicherweise auch mehrere.

2. Jedes Fehlerelement ist eine Liste, die sechs Zeichenfolgen enthält, welche einen Fehler detailliert beschreiben. Die Zeichenfolgen lauten

    1. Der Pfad der Datei, in der der Fehler aufgetreten ist. Dieser kann leer sein.

    2. Der Bereich des Tokens, an dem der Fehler gefunden wurde. Dieser Bereich ist eine Liste aus zwei Elementen mit dem Offset des ersten und des letzten Zeichens im Bereich, gezählt vom Anfang der Eingabe (der Datei). Offsets zählen ab null.

    3. Die Zeile, in der das erste Zeichen nach dem Fehler steht. Zeilen zählen ab eins.

    4. Die Spalte, in der das erste Zeichen nach dem Fehler steht. Spalten zählen ab null.

    5. Der Nachrichtencode des Fehlers. Dieser Wert kann als Argument von **msgcat::mc** dienen, um eine lokalisierte Fehlermeldung zu erhalten, sofern die Anwendung **doctools::msgcat::init** passend aufgerufen hat, um die nötigen Nachrichtenkataloge zu initialisieren (siehe Paket **doctools::msgcat**).

    6. Eine Auflistung der Details zum Fehler, wie beispielsweise der betroffene Markup-Befehl. Im Falle des Meldungscodes **docidx/include/syntax** entspricht dieser Wert der Menge der in der eingebundenen Datei gefundenen Fehler, wobei das hier beschriebene Format verwendet wird.



# \[docidx\]-Notation von Schlüsselwortindizes

Das docidx-Format für Schlüsselwortindizes, auch als *docidx-Markup-Sprache* bezeichnet, ist zu umfangreich, um in einem einzigen Abschnitt behandelt zu werden. Der interessierte Leser sollte mit dem Dokument beginnen

1. *Einleitung in die docidx-Sprache*


und von dort zu den formalen Spezifikationen weitergehen, d. h. den Dokumenten

1. *Syntax der docidx-Sprache* und

2. *Befehlsreferenz der docidx-Sprache*,


um die Sprache gründlich zu verstehen.

# Serialisierungsformat für Schlüsselwortindizes

Hier legen wir das Format fest, das von den doctools-v2-Paketen verwendet wird, um Schlüsselwortindizes als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Ein Schlüsselwortindex kann zwar mehr als eine reguläre Serialisierung aufweisen, doch genau eine davon ist *kanonisch*.

reguläre Serialisierung
: 1. Eine Index-Serialisierung ist ein verschachteltes Tcl-Dictionary.

    2. Dieses Dictionary enthält einen einzigen Schlüssel, **doctools::idx**, sowie dessen Wert. Dieser Wert enthält den Inhalt des Index.

    3. Der Inhalt des Indexes besteht aus einem Tcl-Dictionary, das den Titel des Indexes, eine Bezeichnung sowie die Schlüsselwörter und Verweise enthält. Die entsprechenden Schlüssel und ihre Werte lauten

        **title**
        : Der Wert ist eine Zeichenkette, die den Titel des Indexes enthält.

        **label**
        : Der Wert ist eine Zeichenkette, die eine Bezeichnung für den Index enthält.

        **keywords**
        : Der Wert ist ein Tcl-Dictionary, das die dem Index bekannten Schlüsselwörter als Schlüssel verwendet. Die zugehörigen Werte sind Listen, die die Bezeichner der Referenzen enthalten, die diesem bestimmten Schlüsselwort zugeordnet sind.

            Jeder in diesen Listen verwendete Referenzbezeichner muss als Schlüssel im Dictionary **references** vorhanden sein; dessen Definition steht im nächsten Punkt.

        **references**
        : Der Wert ist ein Tcl-Dictionary, das die dem Index bekannten Bezeichner der Referenzen als Schlüssel verwendet. Die zugehörigen Werte sind Listen mit zwei Elementen, die in dieser Reihenfolge den Typ und die Bezeichnung der Referenz enthalten.

            Jeder Schlüssel hier muss mindestens einem Schlüsselwort zugeordnet sein, d. h., er muss in mindestens einer der Referenzlisten vorkommen, die die Werte im Dictionary **keywords** bilden; die Definition hierfür steht im vorherigen Punkt.


    4. Der *type* einer Referenz kann einen von zwei Werten annehmen,

        **manpage**
        : Der Bezeichner der Referenz wird als symbolischer Dateiname interpretiert, der sich auf eines der Dokumente bezieht, für die der Index erstellt wurde.

        **url**
        : Der Bezeichner der Referenz wird als URL interpretiert, die auf einen externen Ort verweist, beispielsweise eine Website usw.



kanonische Serialisierung
: Die kanonische Serialisierung eines Schlüsselwortindexes hat das im vorherigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen des Schlüsselwortindexes eindeutig ist.

    1. Die Schlüssel in allen verschachtelten Tcl-Dictionaries sind in aufsteigender Wörterbuchreihenfolge sortiert, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.

    2. Die für jedes Schlüsselwort des Indexes aufgeführten Referenzen – sofern vorhanden – werden in aufsteigender Wörterbuchordnung ihrer *Bezeichnungen* aufgelistet, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.



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
