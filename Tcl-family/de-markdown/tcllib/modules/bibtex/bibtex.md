---
CommandName: bibtex
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: bibtex
Keywords:
 - bibliography
 - bibtex
 - parsing
 - text processing
Copyright:
 - Copyright (c) 2005 for documentation, Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

bibtex – BibTeX-Dateien parsen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [bibtex]{.lit} [0.8]{.optlit} 
[::bibtex::parse]{.cmd} [options]{.optarg} [text]{.optarg} 
[::bibtex::parse]{.cmd} [text]{.arg} 
[::bibtex::parse]{.cmd} [-command cmd]{.optarg} [-channel]{.lit} [chan]{.arg} 
[::bibtex::parse]{.cmd} [-recordcommand recordcmd]{.optarg} [-preamblecommand preamblecmd]{.optarg} [-stringcommand stringcmd]{.optarg} [-commentcommand commentcmd]{.optarg} [-progresscommand progresscmd]{.optarg} [-casesensitivestrings bool]{.optarg} (text | [-channel]{.lit} [chan)]{.arg} 
[::bibtex::wait]{.cmd} [token]{.arg} 
[::bibtex::destroy]{.cmd} [token]{.arg} 
[::bibtex::addStrings]{.cmd} [token]{.arg} [stringdict]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält Befehle zum Parsen von Literaturverzeichnissen im BibTeX-Format.

**::bibtex::parse** ?*options*? ?*text*?
: Dies ist die allgemeine Form des Befehls zum Parsen eines Literaturverzeichnisses. Je nach den Optionen beim Aufruf gibt er entweder ein Token für den Parser oder die geparsten Einträge des eingegebenen Literaturverzeichnisses zurück. Statt sofort zu parsen und ein vorgegebenes Format zurückzugeben, kann der Befehl auch in einen ereignisbasierten Parse-Stil wechseln. Alle relevanten Einträge der Eingabe werden dann über Rückrufbefehle gemeldet, im Stil von SAX.

**::bibtex::parse** *text*
: In dieser Form nimmt der Befehl an, dass der angegebene *text* ein Literaturverzeichnis im BibTeX-Format ist, parst ihn und gibt eine Liste mit einem Element je Datensatz im Literaturverzeichnis zurück. Kommentare, String-Definitionen, Präambeln usw. erscheinen im Ergebnis nicht. Jedes Element ist eine Liste aus Datensatztyp, Bibliographieschlüssel und Datensatzdaten, in dieser Reihenfolge. Die Datensatzdaten sind ein Dictionary; seine Schlüssel sind die Schlüssel des Datensatzes, mit den zugehörigen Werten.

**::bibtex::parse** ?**-command** *cmd*? **-channel** *chan*
: In dieser Form liest der Befehl das Literaturverzeichnis vom angegebenen Tcl-Kanal *chan* und gibt anschließend dieselbe Datenstruktur zurück wie oben beschrieben. Ist die Option **-command** angegeben, ist das Ergebnis stattdessen ein Handle des Parsers, und die gesamte Verarbeitung erfolgt inkrementell im Hintergrund. Ist die Eingabe vollständig gelesen, wird die Rückruffunktion *cmd* mit dem Ergebnis des Parsens aufgerufen. Die Rückruffunktion ist so definiert


**cmd** *token* *parseresult*
: Das Parsergebnis weist – bei den einfacheren Formen des Parsers – die oben erläuterte Struktur auf.


*Hinweis*: Der Parser schließt den Kanal *nicht*, nachdem er ihn vollständig gelesen hat. Das bleibt Aufgabe des Nutzers des Parsers.

**::bibtex::parse** ?**-recordcommand**   *recordcmd*? ?**-preamblecommand** *preamblecmd*? ?**-stringcommand**   *stringcmd*? ?**-commentcommand**  *commentcmd*? ?**-progresscommand** *progresscmd*? ?**-casesensitivestrings** *bool*? (*text* | **-channel** *chan*)
: Dies ist die Form des Parsers auf der niedrigsten Ebene. Zurückgegeben wird ein Handle für den Parser. Während der Verarbeitung ruft er die angegebenen Rückrufbefehle für jede im Literaturverzeichnis gefundene Art von Daten auf. Die Verarbeitung läuft inkrementell im Hintergrund, genau dann und nur dann, wenn ein Tcl-Kanal *chan* angegeben ist. Bei einem *text* erfolgt die Verarbeitung sofort, und alle Rückruffunktionen werden aufgerufen, bevor der Befehl selbst zurückkehrt. Die Rückruffunktionen, also *\*cmd*, sind sämtlich Befehlspräfixe und werden mit zusätzlichen Argumenten am Ende aufgerufen. Die Bedeutung der Argumente hängt von der Rückruffunktion ab und wird unten erklärt. Das erste Argument ist immer das Handle des Parsers, der die Rückruffunktion aufruft.


**-casesensitivestrings**
: Diese Option nimmt einen booleschen Wert entgegen. Ist sie gesetzt, unterscheidet die Verarbeitung der String-Makros Groß- und Kleinschreibung. Voreingestellt ist die Verarbeitung ohne diese Unterscheidung.

**recordcmd** *token* *type* *key* *recorddict*
: Diese Rückruffunktion wird aufgerufen, wenn der Parser einen Datensatz des Literaturverzeichnisses in der Eingabe erkennt. Die Argumente sind der Datensatztyp, der Bibliographieschlüssel des Datensatzes und ein Dictionary mit den Schlüsseln und Werten, die den Datensatz beschreiben. Alle dem Parser bekannten String-Makros sind bereits expandiert.

**preamblecmd** *token* *preambletext*
: Diese Rückruffunktion wird aufgerufen, wenn der Parser einen @preamble-Block in der Eingabe erkennt. Das einzige weitere Argument ist der Text im Präambel-Block. Standardmäßig werden solche Einträge ignoriert.

**stringcmd** *token* *stringdict*
: Diese Rückruffunktion wird aufgerufen, wenn der Parser eine Makrodefinition auf @string-Basis in der Eingabe erkennt. Das Argument ist ein Dictionary mit den Makronamen als Schlüsseln und den Ersetzungszeichenketten als Werten. Standardmäßig werden solche Definitionen dem Zustand des Parsers hinzugefügt, zur Verwendung in späteren Datensätzen.

**commentcmd** *token* *commenttext*
: Diese Rückruffunktion wird aufgerufen, wenn der Parser einen Kommentar in der Eingabe erkennt. Das einzige weitere Argument ist der Kommentartext. Standardmäßig werden solche Einträge ignoriert.

**progresscmd** *token* *percent*
: Diese Rückruffunktion wird während der Verarbeitung aufgerufen, um dem Benutzer den bisherigen Fortschritt mitzuteilen. Ihr Argument ist der Prozentsatz der verarbeiteten Daten, als ganze Zahl zwischen **0** und **100**. Bei inkrementeller Verarbeitung ist der Prozentsatz immer **-1**, weil die Gesamtzahl der Einträge vorher nicht bekannt ist.


**::bibtex::wait** *token*
: Dieser Befehl wartet, bis der durch *token* dargestellte Parser fertig ist, und kehrt dann zurück. Das zurückgegebene Ergebnis ist die leere Zeichenkette.

**::bibtex::destroy** *token*
: Dieser Befehl räumt den gesamten internen Zustand auf, der zum Parser mit dem Handle *token* gehört, und zerstört ihn damit. Der Befehl kann aus den Rückruffunktionen des Parsers heraus aufgerufen werden, um die Verarbeitung zu beenden.

**::bibtex::addStrings** *token* *stringdict*
: Dieser Befehl fügt die im Dictionary *stringdict* gespeicherten Makrodefinitionen dem Parser mit dem Handle *token* hinzu. Die Schlüssel des Dictionarys sind die Makronamen, die Werte ihre Ersetzungszeichenketten. Dieser Befehl hat die passende Signatur, um als **-stringcommand**-Rückruffunktion bei einem Aufruf von **::bibtex::parse** zu dienen.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *bibtex* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung

# COPYRIGHT

```
Copyright (c) 2005 for documentation, Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
