---
CommandName: doctools::idx::export::html
title: doctools::idx::export::html
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - HTML
 - doctools
 - export
 - index
 - serialization
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::idx::export::html – HTML-Export-Plugin

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [doctools::idx::export::html]{.lit} [0.3]{.optlit}
[package]{.cmd} [require]{.sub} [doctools::text]{.lit}
[package]{.cmd} [require]{.sub} [doctools::html]{.lit}
[package]{.cmd} [require]{.sub} [doctools::html::cssdefaults]{.lit}
[export]{.cmd} [serial]{.arg} [configuration]{.arg}
:::

# Beschreibung

Dieses Paket implementiert das doctools-Export-Plugin für Schlüsselwortindizes zur Erzeugung von HTML-Markup.

Hierbei handelt es sich um ein internes Paket von doctools, das von den übergeordneten Verwaltungspaketen zur Verwaltung von Schlüsselwortindizes verwendet wird, insbesondere von **doctools::idx::export**, dem Exportmanager.

Die Nutzung über einen herkömmlichen Interpreter ist zwar möglich, jedoch nur unter Umwegen, und wird nicht empfohlen. Die korrekte Vorgehensweise zur Nutzung dieser Funktionalität erfolgt über das Paket **doctools::idx::export** und die darin bereitgestellten Exportmanager-Objekte.

# API

Die von diesem Paket bereitgestellte API entspricht der Spezifikation der docidx-Export-Plugin-API, Version 2.

**export** *serial* *configuration*
: Dieser Befehl nimmt die kanonische Serialisierung eines Schlüsselwortindexes, wie im Abschnitt [Serialisierungsformat für Schlüsselwortindizes] festgelegt und in *serial* enthalten, sowie die *configuration* (ein Dictionary), und erzeugt HTML-Markup, das den Index kodiert. Die erzeugte Zeichenkette wird anschließend als Ergebnis des Befehls zurückgegeben.


# Konfiguration

Das HTML-Export-Plugin erkennt die folgenden Konfigurationsvariablen und ändert sein Verhalten so, wie sie es vorgeben.

string *user*
: Diese Standard-Konfigurationsvariable enthält den Namen des Benutzers, der den Prozess ausführt, welcher das Export-Plugin aufgerufen hat. Das Plugin schreibt diese Angabe in den Herkunftskommentar am Anfang des erzeugten Dokuments.

string *file*
: Diese Standardkonfigurationsvariable enthält den Namen der Datei, aus der der Index stammt. Diese Variable kann ungesetzt sein oder die leere Zeichenkette enthalten. Das Plugin fügt diese Information, sofern sie definiert ist, d. h. gesetzt ist und nicht die leere Zeichenkette enthält, in den Herkunftskommentar am Anfang des generierten Dokuments ein.

dictionary *map*
: Diese Standardkonfigurationsvariable enthält ein Dictionary, das die symbolischen Dateinamen in den Verweisen auf Handbuchseiten den tatsächlichen Dateinamen und/oder URLs zuordnet, die in der Ausgabe verwendet werden sollen.

    URL-Verweise und symbolische Dateinamen ohne Zuordnung werden unverändert verwendet.

boolean *newlines*
: Ist dieses Flag gesetzt, bricht das Plugin den erzeugten HTML-Code auf mehrere Zeilen um, mit jedem Markup-Befehl in einer eigenen Zeile.

    Ist dieses Flag nicht gesetzt (die Vorgabe), wird das ganze Dokument in eine einzige Zeile geschrieben, mit möglichst wenig Abstand zwischen allen Elementen.

boolean *indented*
: Ist dieses Flag gesetzt, rückt das Plugin die Markup-Befehle entsprechend dem Aufbau der Indizes ein. Damit das wirkt, ist auch **newlines** gesetzt.

    Ist dieses Flag nicht gesetzt (die Vorgabe), wird die Ausgabe gemäß dem Wert von **newlines** formatiert, und es wird nicht eingerückt.

string *meta*
: Diese Variable soll ein HTML-Fragment aufnehmen (Vorgabe: leer). Das enthaltene Fragment wird in die erzeugte Ausgabe im Abschnitt <head> des Dokuments eingefügt, unmittelbar nach dem Tag <title>.

string *header*
: Diese Variable soll ein HTML-Fragment aufnehmen (Vorgabe: leer). Das enthaltene Fragment wird in die erzeugte Ausgabe unmittelbar nach dem Titel-Tag <h1> im Hauptteil des Dokuments eingefügt, in der class.header <div>'ision.

string *footer*
: Diese Variable soll ein HTML-Fragment aufnehmen (Vorgabe: leer). Das enthaltene Fragment wird in die erzeugte Ausgabe unmittelbar vor dem Tag </body> eingefügt, in der class.footer <div>'ision.

dictionary *kwid*
: Der Wert dieser Variablen (Standard: leer) ordnet Schlüsselwörter den Bezeichnern zu, die als deren Anker verwendet werden sollen. Jedes Schlüsselwort **FOO**, das nicht im Dictionary enthalten ist, verwendet **KW-FOO** als Anker, d. h. ihm wird die Zeichenkette **KW-** vorangestellt.

string *sepline*
: Der Wert dieser Variablen ist die Zeichenkette für die Trennkommentare, die in die Ausgabe eingefügt werden, wenn die Ausgabe auf mehrere Zeilen umgebrochen und/oder eingerückt wird. Die Vorgabe besteht aus 60 Bindestrichen.

integer *kwidth*
: Diese Variable gibt die Breite der vom Plugin generierten Spalte für Schlüsselwörter in der Haupttabelle an, ausgedrückt als Prozentsatz der Gesamtbreite der Tabelle. Es handelt sich um eine ganze Zahl im Bereich von 1 bis 99. Bei der Wahl eines Wertes außerhalb dieses Bereichs wechselt der Generator zurück zur Standardeinstellung von 35 Prozent.

string *dot*
: Diese Variable enthält ein HTML-Fragment, das zwischen die Einträge der Navigationsleiste und die zu jedem Schlüsselwort gehörenden Referenzen eingefügt wird. Der Standardwert ist die HTML-Entität &#183;, d. h. das Aufzählungszeichen, auch bekannt als „Mittelpunkt“, bzw. das Unicode-Zeichen 00B7.

string *class.main*
: Diese Variable enthält den Klassennamen für die <div>'ivision des Hauptbereichs im erzeugten Dokument. Die Vorgabe ist **doctools**.

string *class.header*
: Diese Variable enthält den Namen der Klasse für den Kopfbereich (<div>) des erzeugten Dokuments. Der Standardwert lautet **idx-header**.  Dieser Bereich enthält den Dokumenttitel, den vom Benutzer angegebenen **header**, falls vorhanden, eine sichtbare Trennlinie sowie die Navigationsleiste für den schnellen Zugriff auf jeden Schlüsselwortabschnitt.

string *class.title*
: Diese Variable enthält den Namen der Klasse für das Tag <h1>, das den Dokumenttitel umschließt. Der Standardwert lautet **idx-title**.

string *class.navsep*
: Diese Variable enthält den Namen der Klasse für die Trennzeichen <hr> in den Kopf- und Fußzeilenabschnitten des generierten Dokuments. Der Standardwert lautet **idx-navsep**.

string *class.navbar*
: Diese Variable enthält den Namen der Klasse für den Navigationsbereich (<div>), der die Navigationsleiste des erzeugten Dokuments umschließt. Der Standardwert lautet **idx-kwnav**.

string *class.contents*
: Diese Variable enthält den Namen der Klasse <table>, die die Schlüsselwörter und deren Verweise im generierten Dokument enthält. Der Standardwert lautet **idx-contents**.

string *class.leader*
: Diese Variable enthält den Namen der Klasse für die Anker, die das Plugin beim Wechsel von einem Abschnitt zum nächsten in die Schlüsselwort-Tabelle einfügt (jeder Abschnitt enthält alle Schlüsselwörter, die mit einem bestimmten Anfangszeichen beginnen). Der Standardwert lautet **idx-leader**.

string *class.row0*
: Diese Variable enthält den Namen der Klasse, die zur Kennzeichnung der geraden Zeilen (<tr>) der Tabelle mit Schlüsselwörtern verwendet wird. Der Standardwert lautet **idx-even**.

string *class.row1*
: Diese Variable enthält den Namen der Klasse, die zur Kennzeichnung der ungeraden Zeilen (<tr>) der Tabelle mit Schlüsselwörtern verwendet wird. Der Standardwert lautet **idx-odd**.

string *class.keyword*
: Diese Variable enthält den Namen der Klasse, die zur Kennzeichnung der Schlüsselwortzelle/-Spalte (<td>) in der Tabelle der Schlüsselwörter des Dokuments verwendet wird. Der Standardwert lautet **idx-keyword**.

string *class.refs*
: Diese Variable enthält den Namen der Klasse, die zur Kennzeichnung der Referenzzellen/-Spalten (<td>) in der Tabelle der Schlüsselwörter des Dokuments verwendet wird. Der Standardwert lautet **idx-refs**.

string *class.footer*
: Diese Variable enthält den Namen der Klasse für den Fußbereich (<div>) des erzeugten Dokuments. Der Standardwert lautet **idx-footer**. Dieser Abschnitt enthält eine im Browser sichtbare Trennlinie sowie gegebenenfalls den vom Benutzer angegebenen Wert **footer**.


*Hinweis*: Dieses Plugin ignoriert die Standard-Konfigurationsvariable **format** und ihren Wert.

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

Textformatierer-Plugin

# Copyright

```
Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
