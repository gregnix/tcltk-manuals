---
CommandName: doctools::toc::export::html
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - HTML
 - doctools
 - export
 - serialization
 - table of contents
 - toc
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::toc::export::html – HTML-Export-Plugin

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::toc::export::html]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [doctools::text]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::html]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::html::cssdefaults]{.lit} 
[export]{.cmd} [serial]{.arg} [configuration]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket implementiert das Export-Plugin von doctools für Inhaltsverzeichnisse, zur Erzeugung von HTML-Markup.

Es ist ein internes Paket von doctools, für die übergeordneten Verwaltungspakete, die Inhaltsverzeichnisse bearbeiten, insbesondere **doctools::toc::export**, den Export-Manager.

Der Aufruf aus einem gewöhnlichen Interpreter ist möglich, aber nur mit Verrenkungen, und wird nicht empfohlen. Der vorgesehene Weg führt über das Paket **doctools::toc::export** und die Export-Manager-Objekte, die es bereitstellt.

# API

Die von diesem Paket bereitgestellte API erfüllt die Spezifikation der doctoc-Export-Plugin-API, Version 2.

**export** *serial* *configuration*
: Dieser Befehl nimmt die kanonische Serialisierung eines Inhaltsverzeichnisses entgegen, wie im Abschnitt **SERIALISIERUNGSFORMAT FÜR INHALTSVERZEICHNISSE** festgelegt und in *serial* enthalten, dazu die *configuration*, ein Dictionary, und erzeugt HTML-Markup, das das Inhaltsverzeichnis kodiert. Die erzeugte Zeichenkette wird als Ergebnis des Befehls zurückgegeben.


# KONFIGURATION

Das HTML-Export-Plugin erkennt die folgenden Konfigurationsvariablen und ändert sein Verhalten so, wie sie es vorgeben.

string *user*
: Diese Standard-Konfigurationsvariable enthält den Namen des Benutzers, der den Prozess ausführt, welcher das Export-Plugin aufgerufen hat. Das Plugin schreibt diese Angabe in den Herkunftskommentar am Anfang des erzeugten Dokuments.

string *file*
: Diese Standard-Konfigurationsvariable enthält den Namen der Datei, aus der das Inhaltsverzeichnis stammt. Diese Variable kann ungesetzt sein oder die leere Zeichenkette enthalten. Das Plugin schreibt diese Angabe, wenn sie definiert ist, das heißt gesetzt und nicht die leere Zeichenkette, in den Herkunftskommentar am Anfang des erzeugten Dokuments.

dictionary *map*
: Diese Standard-Konfigurationsvariable enthält ein Dictionary, das die (symbolischen) Dokumentkennungen in Verweisen auf die tatsächlichen Dateinamen und/oder URLs abbildet, die in der Ausgabe verwendet werden. Dokumentkennungen ohne Abbildung bleiben unverändert.

boolean *newlines*
: Ist dieses Flag gesetzt, bricht das Plugin den erzeugten HTML-Code auf mehrere Zeilen um, mit jedem Markup-Befehl in einer eigenen Zeile. Ist dieses Flag nicht gesetzt (die Vorgabe), wird das ganze Dokument in eine einzige Zeile geschrieben, mit möglichst wenig Abstand zwischen allen Elementen.

boolean *indented*
: Ist dieses Flag gesetzt, rückt das Plugin die Markup-Befehle entsprechend dem Aufbau der Indizes ein. Damit das wirkt, ist auch **newlines** gesetzt. Ist dieses Flag nicht gesetzt (die Vorgabe), wird die Ausgabe gemäß dem Wert von **newlines** formatiert, und es wird nicht eingerückt.

string *meta*
: Diese Variable soll ein HTML-Fragment aufnehmen (Vorgabe: leer). Das enthaltene Fragment wird in die erzeugte Ausgabe im Abschnitt \<head> des Dokuments eingefügt, unmittelbar nach dem Tag \<title>.

string *header*
: Diese Variable soll ein HTML-Fragment aufnehmen (Vorgabe: leer). Das enthaltene Fragment wird in die erzeugte Ausgabe unmittelbar nach dem Titel-Tag \<h1> im Hauptteil des Dokuments eingefügt, in der class.header \<div>'ision.

string *footer*
: Diese Variable soll ein HTML-Fragment aufnehmen (Vorgabe: leer). Das enthaltene Fragment wird in die erzeugte Ausgabe unmittelbar vor dem Tag \</body> eingefügt, in der class.footer \<div>'ision.

dictionary *rid*
: Der Wert dieser Variablen (Vorgabe: leer) bildet Verweise auf die Bezeichner ab, die als ihre Ankernamen dienen. Jeder Verweis **FOO**, der nicht im Dictionary steht, verwendet **REF-FOO** als Anker, also sich selbst mit vorangestellter Zeichenkette **REF-**.

string *sepline*
: Der Wert dieser Variablen ist die Zeichenkette für die Trennkommentare, die in die Ausgabe eingefügt werden, wenn die Ausgabe auf mehrere Zeilen umgebrochen und/oder eingerückt wird. Die Vorgabe besteht aus 60 Bindestrichen.

string *class.main*
: Diese Variable enthält den Klassennamen für die \<div>'ivision des Hauptbereichs im erzeugten Dokument. Die Vorgabe ist **doctools**.

string *class.header*
: Diese Variable enthält den Klassennamen für die \<div>'ision des Kopfbereichs im erzeugten Dokument. Die Vorgabe ist **toc-header**.  Dieser Abschnitt enthält den Dokumenttitel, den vom Benutzer angegebenen **header**, sofern vorhanden, und eine sichtbare Trennlinie.

string *class.title*
: Diese Variable enthält den Klassennamen für das Tag \<h1>, das den Dokumenttitel umschließt. Die Vorgabe ist **toc-title**.

string *class.navsep*
: Diese Variable enthält den Klassennamen für die Trenner \<hr> in den Kopf- und Fußabschnitten des erzeugten Dokuments. Die Vorgabe ist **toc-navsep**.

string *class.contents*
: Diese Variable enthält den Klassennamen für das XXXXX, das im erzeugten Dokument die Schlüsselwörter und ihre Verweise aufnimmt. Die Vorgabe ist **toc-contents**.

string *class.ref*
: Diese Variable enthält den Klassennamen für die Tabellenelemente, die Verweise auf andere Dokumente sind. Die Vorgabe ist **toc-ref**.

string *class.div*
: Diese Variable enthält den Klassennamen für die Tabellenelemente, die Abschnitte sind. Die Vorgabe ist **toc-div**.

string *class.footer*
: Diese Variable enthält den Klassennamen für die \<div>'ision des Fußbereichs im erzeugten Dokument. Die Vorgabe ist **toc-footer**. Dieser Abschnitt enthält eine im Browser sichtbare Trennlinie und den vom Benutzer angegebenen **footer**, sofern vorhanden. *Hinweis*: Dieses Plugin ignoriert die Standard-Konfigurationsvariable **format** und ihren Wert.


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
