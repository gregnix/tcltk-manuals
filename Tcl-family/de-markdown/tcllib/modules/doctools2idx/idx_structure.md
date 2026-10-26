---
CommandName: doctools::idx::structure
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - deserialization
 - docidx
 - doctools
 - serialization
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::idx::structure – Docidx-Serialisierungsdienstprogramme

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::idx::structure]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[::doctools::idx::structure]{.cmd} [verify]{.sub} [serial]{.arg} [canonvar]{.optarg} 
[::doctools::idx::structure]{.cmd} [verify-as-canonical]{.sub} [serial]{.arg} 
[::doctools::idx::structure]{.cmd} [canonicalize]{.sub} [serial]{.arg} 
[::doctools::idx::structure]{.cmd} [print]{.sub} [serial]{.arg} 
[::doctools::idx::structure]{.cmd} [merge]{.sub} [seriala]{.arg} [serialb]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt Befehle zur Verfügung, zur Bearbeitung der Serialisierungen von Schlüsselwortindizes, die vom doctools-System v2 verwaltet und im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES** beschrieben werden.

Hierbei handelt es sich um ein internes Paket von doctools, das von übergeordneten Paketen genutzt wird, die Schlüsselwortindizes verarbeiten und sie in verschiedene andere Formate und aus ihnen umwandeln, wie beispielsweise Dokumente, die mit *docidx*-Markup erstellt wurden.

# API

**::doctools::idx::structure** **verify** *serial* ?*canonvar*?
: Dieser Befehl überprüft, ob der Inhalt von *serial* eine gültige *reguläre* Serialisierung eines Schlüsselwortindexes ist, und löst einen Fehler aus, wenn dies nicht der Fall ist. Das Ergebnis des Befehls ist die leere Zeichenkette. Wenn das Argument *canonvar* angegeben wird, wird es als Name einer Variablen im aufrufenden Kontext interpretiert. In diese Variable wird genau dann geschrieben, wenn *serial* eine gültige reguläre Serialisierung ist. Ihr Wert ist ein Boolescher Wert, wobei **True** angibt, dass die Serialisierung nicht nur gültig, sondern auch *kanonisch* ist. Bei einer gültigen, aber nicht kanonischen Serialisierung wird **False** geschrieben. Informationen zur Spezifikation regulärer und kanonischer Schlüsselwortindex-Serialisierungen finden Sie im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES**.

**::doctools::idx::structure** **verify-as-canonical** *serial*
: Dieser Befehl überprüft, ob der Inhalt von *serial* eine gültige *kanonische* Serialisierung eines Schlüsselwortindexes darstellt, und löst einen Fehler aus, falls dies nicht der Fall ist. Das Ergebnis des Befehls ist die leere Zeichenkette. Informationen zur Spezifikation kanonischer Serialisierungen von Schlüsselwortindizes finden Sie im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES**.

**::doctools::idx::structure** **canonicalize** *serial*
: Dieser Befehl geht davon aus, dass der Inhalt von *serial* eine gültige *reguläre* Serialisierung eines Schlüsselwortindexes ist, und löst einen Fehler aus, falls dies nicht der Fall ist. Anschließend wandelt er die Eingabe in die *kanonische* Serialisierung des enthaltenen Schlüsselwortindexes um und gibt diese als Ergebnis zurück. Wenn die Eingabe bereits kanonisch ist, wird sie unverändert zurückgegeben. Informationen zur Spezifikation regulärer und kanonischer Index-Serialisierungen für Schlüsselwörter finden Sie im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES**.

**::doctools::idx::structure** **print** *serial*
: Dieser Befehl geht davon aus, dass das Argument *serial* eine gültige reguläre Serialisierung eines Schlüsselwortindexes enthält, und gibt eine Zeichenkette zurück, die diesen Index in einer für Menschen lesbaren Form enthält. Das genaue Format dieser Zeichenkette ist nicht festgelegt und darf nicht für die Analyse oder andere maschinelle Vorgänge herangezogen werden. Informationen zur Spezifikation regulärer Schlüsselwortindex-Serialisierungen finden Sie im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES**.

**::doctools::idx::structure** **merge** *seriala* *serialb*
: Dieser Befehl akzeptiert die regulären Serialisierungen zweier Schlüsselwortindizes und erstellt daraus deren Vereinigung. Das Ergebnis des Befehls ist die kanonische Serialisierung dieses vereinigten Schlüsselwortindexes. Titel und Bezeichnung des resultierenden Indexes werden aus dem in *serialb* enthaltenen Index übernommen. Die Menge der Schlüsselwörter, Referenzen und ihrer Verbindungen ist die Vereinigung der Mengen der Schlüsselwörter und Referenzen der beiden Eingaben. Informationen zur Spezifikation regulärer und kanonischer Schlüsselwortindex-Serialisierungen finden Sie im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES**.


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

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
