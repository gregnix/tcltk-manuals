---
CommandName: log
ManualSection: n
Version: 1.5
TclPart: tcllib
TclDescription: Logging facility
Keywords:
 - log
 - log level
 - message
 - message level
Copyright:
 - Copyright (c) 2001-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

log – Prozeduren zur Protokollierung von Meldungen aus Bibliotheken und Anwendungen.

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [log]{.lit} [1.5]{.optlit} 
[::log::levels]{.cmd} 
[::log::lv2longform]{.cmd} [level]{.arg} 
[::log::lv2color]{.cmd} [level]{.arg} 
[::log::lv2priority]{.cmd} [level]{.arg} 
[::log::lv2cmd]{.cmd} [level]{.arg} 
[::log::lv2channel]{.cmd} [level]{.arg} 
[::log::lvCompare]{.cmd} [level1]{.arg} [level2]{.arg} 
[::log::lvSuppress]{.cmd} [level]{.arg} { [suppress]{.arg} 1 } 
[::log::lvSuppressLE]{.cmd} [level]{.arg} { [suppress]{.arg} 1 } 
[::log::lvIsSuppressed]{.cmd} [level]{.arg} 
[::log::lvCmd]{.cmd} [level]{.arg} [cmd]{.arg} 
[::log::lvCmdForall]{.cmd} [cmd]{.arg} 
[::log::lvChannel]{.cmd} [level]{.arg} [chan]{.arg} 
[::log::lvChannelForall]{.cmd} [chan]{.arg} 
[::log::lvColor]{.cmd} [level]{.arg} [color]{.arg} 
[::log::lvColorForall]{.cmd} [color]{.arg} 
[::log::log]{.cmd} [level]{.arg} [text]{.arg} 
[::log::logarray]{.cmd} [level]{.arg} [arrayvar]{.arg} [pattern]{.optarg} 
[::log::loghex]{.cmd} [level]{.arg} [text]{.arg} [data]{.arg} 
[::log::logsubst]{.cmd} [level]{.arg} [msg]{.arg} 
[::log::logMsg]{.cmd} [text]{.arg} 
[::log::logError]{.cmd} [text]{.arg} 
[::log::Puts]{.cmd} [level]{.arg} [text]{.arg} 
:::

# BESCHREIBUNG

Das **log**-Paket enthält Befehle, mit denen Bibliotheken und Anwendungen Informationen über ihren internen Ablauf und ihren Status gezielt protokollieren können.

Um das Paket zu verwenden, führen Sie einfach folgenden Befehl aus:

```
    package require log
    log::log notice "Some message"
```

Wie oben zu sehen ist, ist jede an die Protokollierungsfunktion übergebene Meldung mit einer *Stufe* verknüpft, die die Wichtigkeit der Meldung bestimmt. Der Benutzer kann dann auswählen, welche Stufen protokolliert werden sollen, welche Befehle für die Protokollierung der einzelnen Stufen verwendet werden sollen und in welchen Kanal die Meldung geschrieben werden soll. Im folgenden Beispiel ist die Protokollierung aller Meldungen der Stufe **debug** deaktiviert.

```
    package require log
    log::lvSuppress debug
    log::log debug "Unseen message" ; # No output
```

Standardmäßig werden alle Meldungen, die einer Fehlerstufe zugeordnet sind (**emergency**, **alert**, **critical** und **error**), an **stderr** geschrieben. Meldungen mit einem anderen Schweregrad werden an **stdout** ausgegeben. Im folgenden Beispiel wird das Log-Modul so umkonfiguriert, dass **debug**-Meldungen ebenfalls an **stderr** ausgegeben werden.

```
    package require log
    log::lvChannel debug stderr
    log::log debug "Written to stderr"
```

Jeder Meldungsgrad ist zudem mit einem Befehl verknüpft, der beim Protokollieren einer Meldung dieses Grades verwendet wird. Das oben beschriebene Verhalten beruht beispielsweise darauf, dass alle Meldungsgrade standardmäßig den Standardbefehl **::log::Puts** verwenden, um beliebige Meldungen zu protokollieren. Im folgenden Beispiel werden alle Meldungen der Stufe **notice** zur Protokollierung an den nicht standardmäßigen Befehl **toText** übergeben. Dadurch wird die Einstellung des Kanals für solche Meldungen deaktiviert, vorausgesetzt, dass **toText** diese nicht selbst verwendet.

```
    package require log
    log::lvCmd notice toText
    log::log notice "Handled by \"toText\""
```

Eine weitere von dieser Einrichtung gepflegte Datenbank ist eine Zuordnung von Nachrichtenebenen zu Farben. Die Informationen in dieser Datenbank haben *keinen* Einfluss auf das Verhalten des Moduls. Sie werden lediglich als Service bereitgestellt und in Erwartung der Nutzung dieser Funktion in der **tk**-based-Anwendung, die möglicherweise Meldungsprotokolle in Farben kennzeichnen möchte.

# API

Folgende Befehle stehen zur Verfügung:

**::log::levels**
: Gibt die Namen aller bekannten Ebenen in alphabetischer Reihenfolge zurück.

**::log::lv2longform** *level*
: Wandelt jede eindeutige Abkürzung eines Levelnamens in den vollständigen Name des Levels um.

**::log::lv2color** *level*
: Wandelt jeden Level-Name, einschließlich einzigartiger Abkürzungen, in die entsprechende Farbe um.

**::log::lv2priority** *level*
: Wandelt jeden Level-Name, einschließlich einzigartiger Abkürzungen, in die entsprechende Priorität um.

**::log::lv2cmd** *level*
: Wandelt jeden Level-Namen, einschließlich einzigartiger Abkürzungen, in das Befehlspräfix um, das zum Verfassen von Nachrichten mit diesem Level verwendet wird.

**::log::lv2channel** *level*
: Wandelt jeden Level-Name, einschließlich einzigartiger Abkürzungen, in den Kanal um, den **::log::Puts** verwendet, um Nachrichten mit diesem Level zu schreiben.

**::log::lvCompare** *level1* *level2*
: Vergleicht zwei Ebenen (einschließlich eindeutiger Abkürzungen) hinsichtlich ihrer Priorität. Dieser Befehl kann über die Option -command von lsort verwendet werden. Das Ergebnis ist entweder -1, 0 oder 1 oder ein Fehler. Ein Ergebnis von -1 bedeutet, dass Ebene1 eine geringere Priorität hat als Ebene2. 0 bedeutet, dass beide Ebenen die gleiche Priorität haben. 1 bedeutet, dass Ebene1 eine höhere Priorität hat als Ebene2.

**::log::lvSuppress** *level* {*suppress* 1}
: (De-)aktiviert die Ausgabe von Meldungen der festgelegten Stufe. Auch hier sind eindeutige Abkürzungen für die Stufe zulässig.

**::log::lvSuppressLE** *level* {*suppress* 1}
: (De-)aktiviert die Ausgabe von Meldungen mit der festgelegten Stufe oder einer niedrigeren Priorität. Auch hier sind eindeutige Abkürzungen für die Stufe zulässig.

**::log::lvIsSuppressed** *level*
: Fragt das Paket ab, ob die angegebene Stufe derzeit unterdrückt ist. Eindeutige Abkürzungen von Stufennamen sind zulässig.

**::log::lvCmd** *level* *cmd*
: Legt für die angegebene Stufe fest, mit welchem Befehl die Nachrichten dieser Stufe geschrieben werden sollen. Eindeutige Abkürzungen der Stufennamen sind zulässig. Bei dem Befehl handelt es sich eigentlich um ein Befehlspräfix, und diese Funktion fügt vor dem Aufruf zwei Argumente an: die Stufe der Nachricht und die Nachricht selbst, in dieser Reihenfolge.

**::log::lvCmdForall** *cmd*
: Legt für alle bekannten Ebenen fest, mit welchem Befehl die Nachrichten dieser Ebene geschrieben werden sollen. Der Befehl handelt eigentlich von einem Befehlspräfix, und diese Funktion fügt vor dem Aufruf zwei Argumente an: die Ebene der Nachricht und die Nachricht selbst, in dieser Reihenfolge.

**::log::lvChannel** *level* *chan*
: Legt für die angegebene Ebene fest, in welchen Kanal **::log::Puts** (der Standardbefehl) die Meldungen dieser Ebene schreiben soll. Eindeutige Abkürzungen der Stufennamen sind zulässig. Der Befehl ist eigentlich ein Befehlspräfix, und diese Funktion fügt vor dem Aufruf zwei Argumente an: die Stufe der Nachricht und die Nachricht selbst, in dieser Reihenfolge.

**::log::lvChannelForall** *chan*
: Legt für alle bekannten Ebenen fest, mit welchem Kanal **::log::Puts** (der Standardbefehl) die Meldungen dieser Ebene schreiben soll. Der Befehl ist eigentlich ein Befehlspräfix, und diese Funktion fügt vor dem Aufruf zwei Argumente an: die Ebene der Meldung und die Meldung selbst, in dieser Reihenfolge.

**::log::lvColor** *level* *color*
: Legt für die angegebene Ebene die Farbe fest, die bei einem Aufruf von **::log::lv2color** für diese Ebene zurückgegeben wird. Eindeutige Abkürzungen der Ebenennamen sind zulässig.

**::log::lvColorForall** *color*
: Legt für alle bekannten Ebenen die Farbe fest, die bei einem Aufruf von **::log::lv2color** zurückgegeben wird. Eindeutige Abkürzungen der Ebenennamen sind zulässig.

**::log::log** *level* *text*
: Protokolliert eine Meldung gemäß den Vorgaben für Befehle, Kanäle und Unterdrückung. Mit anderen Worten: Der Befehl führt keine Aktion aus, wenn die angegebene Stufe unterdrückt ist. Ist sie nicht unterdrückt, wird die eigentliche Protokollierung an den angegebenen Befehl weitergeleitet. Ist für die Stufe kein Befehl angegeben, wird die Meldung nicht protokolliert. Der Standardbefehl **::log::Puts** schreibt die Meldung in den für die jeweilige Stufe angegebenen Kanal. Ist für die Stufe kein Kanal angegeben, wird die Meldung nicht protokolliert. Eindeutige Abkürzungen von Level-Namen sind zulässig. Fehler im eigentlichen Protokollierungsbefehl werden *nicht* abgefangen, sondern an den Aufrufer weitergeleitet, da sie auf Fehlkonfigurationen der Protokollierungsfunktion oder Fehler im Code des Aufrufers selbst hinweisen können.

**::log::logarray** *level* *arrayvar* ?*pattern*?
: Ähnlich wie **::log::log**, protokolliert jedoch den Inhalt der angegebenen Array-Variablen *arrayvar*, gegebenenfalls beschränkt auf Einträge, die dem *Muster* entsprechen. Das Muster ist standardmäßig **\*** (d. h. alle Einträge), sofern kein Muster angegeben wurde.

**::log::loghex** *level* *text* *data*
: Ähnlich wie **::log::log**, geht jedoch davon aus, dass *data* Binärdaten enthält. Diese werden in eine gemischte Hex- und ASCII-Darstellung konvertiert, bevor sie in das Protokoll geschrieben werden.

**::log::logsubst** *level* *msg*
: Ähnlich wie **::log::log**, jedoch kann *msg* Ersetzungen und Variablenverweise enthalten, die zunächst im Aufrufer-Gültigkeitsbereich ausgewertet werden. Der Zweck dieses Befehls besteht darin, im Fall ohne Protokollierung Overhead zu vermeiden, wenn die Erstellung der Protokollmeldung aufwendig ist. Etwaige Fehler bei der Ersetzung lösen bei der Befehlsausführung einen Fehler aus. Das folgende Beispiel zeigt eine XML-Textdarstellung, die nur im Debug-Modus generiert wird:


```
    log::logsubst debug {XML of node $node is '[$node toXml]'}
```

**::log::logMsg** *text*
: Komfort-Wrapper für **::log::log**. Entspricht dem **::log::log info text**.

**::log::logError** *text*
: Komfort-Wrapper für **::log::log**. Entspricht dem **::log::log error text**.

**::log::Puts** *level* *text*
: Der Standard-Log-Befehl schreibt Meldungen und deren Schweregrade in vom Benutzer festgelegte Kanäle. Es wird davon ausgegangen, dass die Unterdrückungsprüfungen vom Aufrufer durchgeführt wurden. Es werden vollständige Schweregraddesignationen erwartet; Abkürzungen sind *nicht zulässig*.


# STUFEN

Das Paket definiert derzeit die folgenden Protokollstufen, wobei die Stufe mit der höchsten Priorität an erster Stelle steht.

**•**
: Notfall

**•**
: Warnung

**•**
: kritisch

**•**
: Fehler

**•**
: Fehler

**•**
: Hinweis

**•**
: Info

**•**
: debug *Hinweis*: Standardmäßig werden alle Meldungen der Stufen **warning** bis hinunter zu **debug** unterdrückt. Dies geschieht bewusst, da (unserer Meinung nach) die Debugging-Ausgabe in den meisten Situationen unerwünscht ist. Die meisten Nutzer möchten eine solche Ausgabe nur dann sehen, wenn sie tatsächlich eine Anwendung debuggen.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *log* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge

# COPYRIGHT

```
Copyright (c) 2001-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
