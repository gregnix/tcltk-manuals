---
CommandName: tcldocstrip
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Textprocessing toolbox
Links:
 - docstrip
Keywords:
 - \.dtx
 - LaTeX
 - conversion
 - docstrip
 - documentation
 - literate programming
 - markup
 - source
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcldocstrip – Tcl-basierter Docstrip-Prozessor

# ÜBERSICHT

::: {.synopsis} :::
[tcldocstrip]{.cmd} [output]{.arg} [options]{.optarg} [input]{.arg} [guards]{.optarg} 
[tcldocstrip]{.cmd} [options]{.optarg} [output]{.arg} (?options? [input]{.arg} [guards)...]{.arg} 
[tcldocstrip]{.cmd} [-guards]{.sub} [input]{.arg} 
:::

# BESCHREIBUNG

Die in diesem Dokument beschriebene Anwendung, **tcldocstrip**, ist eine Weiterentwicklung von **docstrip**, einem einfachen Werkzeug zur literaten Programmierung für LaTeX.

**tcldocstrip** basiert auf dem Paket **docstrip**.

## Anwendungsfälle

**tcldocstrip** wurde unter Berücksichtigung der folgenden drei Anwendungsfälle entwickelt.

**\[1\]**
: Konvertierung einer einzelnen Eingabedatei gemäß den aufgeführten Bedingungen in die bereinigte Ausgabe. Hiermit wird der einfachste Fall behandelt, bei dem eine Reihe von Bedingungen ein einzelnes Dokument in einer einzigen Eingabedatei festlegen.

**\[2\]**
: Das Zusammenfügen, d. h. die Zusammenstellung einer Ausgabe aus mehreren Schutzgruppen in einer bestimmten Reihenfolge und möglicherweise aus verschiedenen Dateien. Dies ist der zweite häufige Fall. Ein Dokument, das sich über mehrere Eingaben und/oder über verschiedene Schutzgruppen erstreckt.

**\[3\]**
: Extraktion und Auflistung aller eindeutigen Ausdrücke und Schutzmechanismen, die innerhalb eines Dokuments verwendet werden, um einer Person, die das betreffende Dokument nicht verfasst hat, dabei zu helfen, sich mit diesem vertraut zu machen.


## Befehlszeile

**tcldocstrip** *output* ?Optionen? *input* ?*guards*?
: Dies ist die Form für den Anwendungsfall \[1\]. Sie wandelt die Datei *input* gemäß den angegebenen *guards* und Optionen um. Das Ergebnis wird in die genannte Datei *output* geschrieben. Die Verwendung der Zeichenfolge **-** als Name der Ausgabedatei signalisiert, dass das Ergebnis in die Datei **stdout** geschrieben werden soll. Die Guards sind dokumentspezifisch und müssen dem Aufrufer bekannt sein. Die *options* werden später im Abschnitt **Optionen** erläutert.


path *output* (in)
: Dieses Argument legt fest, wohin das generierte Dokument geschrieben werden soll. Es kann sich dabei um den Pfad zu einer Datei oder einem Verzeichnis handeln oder um „**-**“. Der letzte Wert bewirkt, dass die Anwendung das generierte Dokument in „**stdout**“ speichert. Wenn der *output* nicht existiert, muss „\[file dirname \$output\]“ vorhanden sein und es muss sich um ein beschreibbares Verzeichnis handeln.

path *inputfile* (in)
: Dieses Argument legt den Pfad zu der zu verarbeitenden Datei fest. Die Datei muss vorhanden und lesbar sein sowie im *docstrip*-Format vorliegen.


**tcldocstrip** ?Optionen? *output* (?Optionen? *input* *guards*)...
: Dies ist die Form für den Anwendungsfall \[2\]. Sie unterscheidet sich von der Form für den Anwendungsfall \[1\] dadurch, dass Optionen vor der Ausgabedatei angegeben werden können, die allgemein gelten, und dass mehr als eine Eingabedatei angegeben werden kann, wobei jede über eigene, eingabespezifische Optionen und Guards verfügt. Sie extrahiert Daten aus den verschiedenen Dateien *input* gemäß den angegebenen *options* und *guards* und schreibt das Ergebnis in die angegebene Datei *output*, und zwar in der Reihenfolge, in der sie in der Befehlszeile angegeben wurden. Vor der Ausgabedatei angegebene Optionen sind globale Einstellungen, während die vor jeder Eingabedatei angegebenen Optionen nur für diese jeweilige Eingabedatei gelten. Nicht angegebene Werte werden aus den globalen Einstellungen oder den Standardwerten übernommen. Bei der Form \[1\] führt die Verwendung der Zeichenfolge **-** als Ausgabe dazu, dass die Anwendung auf stdout schreibt. Die Verwendung der Zeichenfolge **.** für eine Eingabedatei signalisiert, dass die letzte Eingabedatei erneut verwendet werden soll. Dies ermöglicht die Zusammenstellung der Ausgabe aus einer Eingabedatei unter Verwendung mehrerer unterschiedlicher Schutzsätze, ohne dass jedes Mal der vollständige Name der Datei angegeben werden muss.

**tcldocstrip** **-guards** *input*
: Dies ist die Form für den Anwendungsfall \[3\]. Es ermittelt die Guard-Bedingungen sowie die eindeutigen Guard-Ausdrücke, die im angegebenen *input*-Dokument verwendet werden. Die gefundenen Zeichenfolgen werden in die Standardausgabe geschrieben, wobei pro Zeile eine Zeichenfolge ausgegeben wird.


## Optionen

In diesem Abschnitt werden alle Optionen beschrieben, die dem Benutzer der Anwendung zur Verfügung stehen, mit Ausnahme der Option **-guards**. Diese Option wurde bereits im Abschnitt **Befehlszeile** beschrieben.

**-metaprefix** Zeichenfolge
: Diese Option wird vom Befehl **docstrip::extract** übernommen, der vom Paket **docstrip** bereitgestellt wird. Sie legt die Zeichenkette fest, durch die das Präfix „%%“ einer Metakommentarzeile ersetzt wird. Der Standardwert ist „%%“. Bei Tcl-Code wäre dies typischerweise „#“.

**-onerror** mode
: Diese Option wird vom Befehl **docstrip::extract** übernommen, der im Paket **docstrip** bereitgestellt wird. Sie legt fest, welche Maßnahme ergriffen wird, wenn ein Formatfehler im zu verarbeitenden *text* erkannt wird. Die Einstellungsmöglichkeiten sind:


**ignore**
: Ignoriert den Fehler und fährt fort, als wäre nichts geschehen.

**puts**
: Schreibt eine Fehlermeldung nach **stderr** und setzt die Verarbeitung fort.

**throw**
: Es wird ein Fehler ausgelöst. **::errorCode** ist auf eine Liste gesetzt, deren erstes Element **DOCSTRIP** ist, deren zweites Element die Fehlerart angibt und deren drittes Element die Zeilennummer ist, in der der Fehler festgestellt wurde. Dies ist die Standardeinstellung.


**-trimlines** bool
: Diese Option wird vom Befehl **docstrip::extract** übernommen, der vom Paket **docstrip** bereitgestellt wird. Legt fest, ob *Leerzeichen* am Zeilenende vor dem Prozess der Zeile entfernt werden sollen. Der Standardwert ist **true**.

**-preamble** Text
: ...siehe nächstes...

**-postamble** Text
: ...siehe nächstes...

**-nopreamble**
: ...siehe nächstes...

**-nopostamble**
: Die Optionen -no\*amble deaktivieren die Vor- und Nachschriften der Datei vollständig, während die Optionen -\*amble den *user*-Teil der Vor- und Nachschriften der Datei festlegen. Dieser Teil kann leer sein; in diesem Fall werden nur die Standardteile angezeigt. Dies ist die Standardeinstellung. Sind Präambeln aktiviert, werden sie vor dem eigentlichen Inhalt einer generierten Datei eingefügt. Ebenso werden Postambeln, sofern sie aktiviert sind, nach dem eigentlichen Inhalt einer generierten Datei eingefügt.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *docstrip* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
