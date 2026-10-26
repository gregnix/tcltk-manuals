---
CommandName: doctools::toc::parse
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - doctoc
 - doctools
 - lexer
 - parser
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::toc::parse – Parsing von Text im doctoc-Format

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::toc::parse]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::toc::structure]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::msgcat]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::tcl::parse]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [struct::list]{.lit} 
[package]{.cmd} [require]{.sub} [struct::stack]{.lit} 
[::doctools::toc::parse]{.cmd} [text]{.sub} [text]{.arg} 
[::doctools::toc::parse]{.cmd} [file]{.sub} [path]{.arg} 
[::doctools::toc::parse]{.cmd} [includes]{.sub} 
[::doctools::toc::parse]{.cmd} [include]{.sub} [add]{.lit} [path]{.arg} 
[::doctools::toc::parse]{.cmd} [include]{.sub} [remove]{.lit} [path]{.arg} 
[::doctools::toc::parse]{.cmd} [include]{.sub} [clear]{.lit} 
[::doctools::toc::parse]{.cmd} [vars]{.sub} 
[::doctools::toc::parse]{.cmd} [var]{.sub} [set]{.lit} [name]{.arg} [value]{.arg} 
[::doctools::toc::parse]{.cmd} [var]{.sub} [unset]{.lit} [name]{.arg} 
[::doctools::toc::parse]{.cmd} [var]{.sub} [clear]{.lit} [pattern]{.optarg} 
:::

# BESCHREIBUNG

Dieses Paket stellt Befehle bereit, die in der Auszeichnungssprache *doctoc* geschriebenen Text parsen und in die kanonische Serialisierung des im Text kodierten Inhaltsverzeichnisses umwandeln. Das Format ist im Abschnitt **SERIALISIERUNGSFORMAT FÜR INHALTSVERZEICHNISSE** festgelegt.

Hierbei handelt es sich um ein internes Paket von doctools, das von den übergeordneten Paketen zur Verarbeitung von *doctoc*-Dokumenten verwendet wird.

# API

**::doctools::toc::parse** **text** *text*
: Der Befehl nimmt die in *text* enthaltene Zeichenkette und parst sie unter der Annahme, dass sie ein mit der Auszeichnungssprache *doctoc* geschriebenes Dokument enthält. Erweist sich die Annahme als falsch, wird ein Fehler ausgelöst. Das Format dieser Fehler ist im Abschnitt **PARSING-FEHLER** beschrieben. Bei Erfolg gibt der Befehl die kanonische Serialisierung des Inhaltsverzeichnisses zurück, das im Text kodiert war. Das Format ist im Abschnitt **SERIALISIERUNGSFORMAT FÜR INHALTSVERZEICHNISSE** festgelegt.

**::doctools::toc::parse** **file** *path*
: Entspricht **text**, mit dem Unterschied, dass der zu analysierende Text aus der durch *path* angegebenen Datei gelesen wird.

**::doctools::toc::parse** **includes**
: Diese Methode gibt die aktuelle Liste der Suchpfade zurück, die bei der Suche nach Include-Dateien verwendet werden.

**::doctools::toc::parse** **include add** *path*
: Diese Methode fügt den *path* zur Liste der Pfade hinzu, die bei der Suche nach einer Include-Datei durchsucht werden. Der Aufruf wird ignoriert, wenn der Pfad schon in der Liste steht. Die Methode gibt die leere Zeichenkette als Ergebnis zurück.

**::doctools::toc::parse** **include remove** *path*
: Diese Methode entfernt den *path* aus der Liste der Pfade, die bei der Suche nach einer Include-Datei durchsucht werden. Der Aufruf wird ignoriert, wenn der Pfad nicht in der Liste steht. Die Methode gibt die leere Zeichenkette als Ergebnis zurück.

**::doctools::toc::parse** **include clear**
: Diese Methode leert die Liste der Suchpfade für Include-Dateien.

**::doctools::toc::parse** **vars**
: Diese Methode gibt ein Dictionary zurück, das die aktuellen vordefinierten Variablen enthält, die der Auszeichnungsbefehl **vset** während der Verarbeitung kennt.

**::doctools::toc::parse** **var set** *name* *value*
: Diese Methode nimmt die Variable *name* in die Menge der vordefinierten Variablen auf, die der Auszeichnungsbefehl **vset** während der Verarbeitung kennt, und gibt ihr den angegebenen *value*. Die Methode gibt die leere Zeichenkette als Ergebnis zurück.

**::doctools::toc::parse** **var unset** *name*
: Diese Methode entfernt die Variable *name* aus der Menge der vordefinierten Variablen, die der Auszeichnungsbefehl **vset** während der Verarbeitung kennt. Die Methode gibt die leere Zeichenkette als Ergebnis zurück.

**::doctools::toc::parse** **var clear** ?*pattern*?
: Diese Methode entfernt alle Variablen, auf die das *pattern* passt, aus der Menge der vordefinierten Variablen, die der Auszeichnungsbefehl **vset** während der Verarbeitung kennt. Die Methode gibt die leere Zeichenkette als Ergebnis zurück. Der Abgleich erfolgt mit **string match**, und das Vorgabemuster, wenn keines angegeben ist, ist **\***.


# PARSING-FEHLER

Das Format der Parsing-Fehlermeldungen, die bei Verstößen gegen die Auszeichnungssyntax von *doctoc* ausgelöst werden, ist für Menschen lesbar und nicht zur Verarbeitung durch Maschinen bestimmt. Deshalb ist es nicht dokumentiert.

*Allerdings* ist der an die Meldung angehängte errorCode maschinenlesbar und hat das folgende Format:

**\[1\]**
: Der Fehlercode ist eine Liste, wobei jedes Element einen einzelnen in der Eingabe gefundenen Fehler beschreibt. Die Liste enthält mindestens ein Element, möglicherweise auch mehrere.

**\[2\]**
: Jedes Fehlerelement ist eine Liste, die sechs Zeichenfolgen enthält, welche einen Fehler detailliert beschreiben. Die Zeichenfolgen lauten


**\[1\]**
: Der Pfad der Datei, in der der Fehler aufgetreten ist. Dieser kann leer sein.

**\[2\]**
: Der Bereich des Tokens, an dem der Fehler gefunden wurde. Dieser Bereich ist eine Liste aus zwei Elementen mit dem Offset des ersten und des letzten Zeichens im Bereich, gezählt vom Anfang der Eingabe (der Datei). Offsets zählen ab null.

**\[3\]**
: Die Zeile, in der das erste Zeichen nach dem Fehler steht. Zeilen zählen ab eins.

**\[4\]**
: Die Spalte, in der das erste Zeichen nach dem Fehler steht. Spalten zählen ab null.

**\[5\]**
: Der Nachrichtencode des Fehlers. Dieser Wert kann als Argument von **msgcat::mc** dienen, um eine lokalisierte Fehlermeldung zu erhalten, sofern die Anwendung **doctools::msgcat::init** passend aufgerufen hat, um die nötigen Nachrichtenkataloge zu initialisieren (siehe Paket **doctools::msgcat**).

**\[6\]**
: Eine Auflistung der Details zum Fehler, wie beispielsweise der betroffene Markup-Befehl. Im Falle des Fehlercodes **doctoc/include/syntax** entspricht dieser Wert der Menge der in der eingebundenen Datei gefundenen Fehler, wobei das hier beschriebene Format verwendet wird.


# \[DOCTOC\]-NOTATION VON INHALTSVERZEICHNISSEN

Das doctoc-Format für Inhaltsverzeichnisse, auch *doctoc markup language* genannt, ist zu umfangreich für einen einzigen Abschnitt. Der interessierte Leser beginnt mit dem Dokument

**\[1\]**
: *doctoc language introduction* und geht von dort weiter zu den formalen Spezifikationen, also den Dokumenten

**\[1\]**
: *doctoc language syntax* und

**\[2\]**
: *doctoc language command reference*, um die Sprache gründlich zu verstehen.


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

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
