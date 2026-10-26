---
CommandName: docidx_plugin_apiref
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation tools
Links:
 - docidx_intro
 - docidx_lang_cmdref
 - docidx_lang_faq
 - docidx_lang_intro
 - docidx_lang_syntax
 - doctools::idx
Keywords:
 - formatting engine
 - index
 - index formatter
 - keywords
 - markup
 - plugin
 - semantic markup
Copyright:
 - Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

docidx_plugin_apiref – API-Referenz für das docidx-Plugin

# ÜBERSICHT

::: {.synopsis} :::
[dt_fmap]{.cmd} [symfname]{.arg} 
[dt_format]{.cmd} 
[dt_read]{.cmd} [file]{.arg} 
[dt_source]{.cmd} [file]{.arg} 
[ex_cappend]{.cmd} [text]{.arg} 
[ex_cget]{.cmd} [varname]{.arg} 
[ex_cis]{.cmd} [cname]{.arg} 
[ex_cname]{.cmd} 
[ex_cpop]{.cmd} [cname]{.arg} 
[ex_cpush]{.cmd} [cname]{.arg} 
[ex_cset]{.cmd} [varname]{.arg} [value]{.arg} 
[ex_lb]{.cmd} [newbracket]{.optarg} 
[ex_rb]{.cmd} [newbracket]{.optarg} 
[idx_initialize]{.cmd} 
[idx_listvariables]{.cmd} 
[idx_numpasses]{.cmd} 
[idx_postprocess]{.cmd} [text]{.arg} 
[idx_setup]{.cmd} [n]{.arg} 
[idx_shutdown]{.cmd} 
[idx_varset]{.cmd} [varname]{.arg} [text]{.arg} 
[fmt_plain_text]{.cmd} [text]{.arg} 
:::

# BESCHREIBUNG

Dieses Dokument richtet sich an *Plugin-Entwickler*, d. h. an Entwickler, die eine *Formatierungs-Engine* für Indizes für ein bestimmtes Ausgabeformat X erstellen möchten.

Es legt die Interaktion zwischen dem Paket **doctools::idx** und dessen Plugins fest, d. h. die Schnittstelle, an die sich jede Indexformatierungs-Engine halten muss.

Dieses Dokument befasst sich mit Version 1 der Schnittstelle.

Ein Leser, der sich hingegen eher für die Auszeichnungssprache selbst interessiert, sollte mit der *Einleitung in die Sprache docidx* beginnen und von dort aus zu den formalen Spezifikationen übergehen, d. h. zur *Syntax der Sprache docidx* und zur *Befehlsreferenz der Sprache docidx*.

# ÜBERBLICK

Die API für eine Indexformatierungs-Engine besteht aus zwei Hauptabschnitten.

Einerseits gibt es eine Reihe von Befehlen, mit denen das Plugin das Frontend abfragen kann. Diese Befehle werden vom Frontend bereitgestellt und in den Plugin-Interpreter eingebunden. Eine detaillierte Beschreibung finden Sie im Abschnitt **FRONTEND-BEFEHLE**.

Andererseits muss das Plugin einen eigenen Satz von Befehlen bereitstellen, die dann vom Frontend bei der Verarbeitung der Eingaben in einer bestimmten Reihenfolge aufgerufen werden. Auch diese lassen sich in zwei Kategorien einteilen: Verwaltung und Formatierung. Eine detaillierte Beschreibung finden Sie im Abschnitt **PLUGIN-BEFEHLE** und dessen Unterabschnitten.

# FRONTEND-BEFEHLE

In diesem Abschnitt wird die Reihe von Befehlen festgelegt, mit denen ein Plugin – auch als Indexformatierungs-Engine bezeichnet – das Frontend abfragen kann. Diese Befehle werden vom Frontend bereitgestellt und in den Plugin-Interpreter eingebunden.

Das heißt, eine Indexformatierungs-Engine kann davon ausgehen, dass alle folgenden Befehle vorhanden sind, wenn einer ihrer eigenen Befehle (wie im Abschnitt **PLUGIN-BEFEHLE** festgelegt) ausgeführt wird.

Darüber hinaus kann davon ausgegangen werden, dass er uneingeschränkten Zugriff auf seinen eigenen sicheren Interpreter hat und somit weder die anderen Teile des Prozessors noch das Dateisystem beschädigen kann. Er kann den gesamten Prozess jedoch beenden oder hängen lassen, indem er ihn beendet oder eine Endlosschleife ausführt.

Um auf die importierten Befehle zurückzukommen: Alle Befehle mit dem Präfix *dt\_* bieten eingeschränkten Zugriff auf bestimmte Teile des Frontends, während die Befehle mit dem Präfix *ex\_* Zugriff auf den Zustand des Objekts **textutil::expander** gewähren, das die Hauptanalyse der Eingabe innerhalb des Frontends durchführt. Diese Befehle sollten nur unter ganz besonderen Umständen verwendet werden.

**dt_fmap** *symfname*
: Abfragebefehl. Er gibt den tatsächlichen Pfadnamen zurück, der in der Ausgabe anstelle des symbolischen Dateinamens *symfname* verwendet werden soll. Wird für *symfname* keine Zuordnung festgelegt, gibt er die unveränderte Eingabe zurück. Die erforderlichen Zuordnungen werden mit der Methode **map** eines Frontends eingerichtet, wie im Abschnitt **Objektmethoden** der Dokumentation zum Paket **doctools::idx** erläutert.

**dt_format**
: Abfragebefehl. Er gibt den Namen des Formats zurück, das der Index-Formatierungs-Engine zugeordnet ist.

**dt_read** *file*
: Kontrollierter Zugriff auf das Dateisystem. Gibt den Inhalt von *file* für beliebige Zwecke des Plugins zurück. Es können nur Dateien geladen werden, die sich entweder im selben Verzeichnis wie die Datei mit der Engine oder in einem darunterliegenden Verzeichnis befinden. Der Versuch, eine Datei außerhalb dieses Verzeichnisses zu laden, führt zu einem Fehler.

**dt_source** *file*
: Kontrollierter Zugriff auf das Dateisystem. Dieser Befehl ermöglicht es der Index-Formatierungs-Engine, zusätzlichen Tcl-Code zu laden, den sie möglicherweise benötigt. Es können nur Dateien geladen werden, die sich entweder im selben Verzeichnis wie die Datei mit der Engine oder in einem darunterliegenden Verzeichnis befinden. Der Versuch, eine Datei außerhalb dieses Verzeichnisses zu laden, führt zu einem Fehler.

**ex_cappend** *text*
: Fügt im aktuellen Kontext eine Zeichenkette an die Ausgabe an. Dieser Befehl sollte von Makros oder Anwendungscode nur selten verwendet werden.

**ex_cget** *varname*
: Ruft den Wert der im aktuellen Kontext definierten Variablen *varname* ab.

**ex_cis** *cname*
: Ermittelt, ob der Name des aktuellen Kontexts *cname* lautet oder nicht.

**ex_cname**
: Gibt den Namen des aktuellen Kontexts zurück.

**ex_cpop** *cname*
: Entnimmt einen Kontext aus dem Kontextstapel und gibt die gesamte in diesem Kontext gesammelte Ausgabe zurück. Der Kontext muss den Namen *cname* tragen; andernfalls tritt ein Fehler auf.

**ex_cpush** *cname*
: Fügt einen Kontext mit dem Namen *cname* auf den Kontextstapel ein. Der Kontext muss vor Abschluss der Erweiterung durch **cpop** vom Stapel entfernt werden, andernfalls tritt ein Fehler auf.

**ex_cset** *varname* *value*
: Setzt die Variable *varname* im aktuellen Kontext auf den Wert *value*.

**ex_lb** ?*newbracket*?
: Gibt den aktuellen Wert der linken Makroauswertungsklammer zurück; dies dient zur Verwendung als oder innerhalb eines Makros, wenn die Klammer in den Ausgabetext aufgenommen werden soll. Wenn *newbracket* festgelegt wird, wird dies zur neuen Klammer und zurückgegeben.

**ex_rb** ?*newbracket*?
: Gibt den aktuellen Wert der rechten Klammer der Makroauswertung zurück; dies dient zur Verwendung als oder innerhalb eines Makros, wenn die Klammer in den Ausgabetext aufgenommen werden soll. Wenn *newbracket* festgelegt wird, wird dies zur neuen Klammer und zurückgegeben.


# PLUGIN-BEFEHLE

Das Plugin muss einen eigenen Satz von Befehlen bereitstellen, die dann vom Frontend bei der Verarbeitung der Eingaben in einer bestimmten Reihenfolge aufgerufen werden. Diese lassen sich in zwei Kategorien einteilen: Verwaltung und Formatierung. Die erwarteten Namen, Signaturen und Aufgaben dieser Befehle werden in den folgenden beiden Unterabschnitten näher beschrieben.

## Verwaltungsbefehle

Die Verwaltungsbefehle, die ein Plugin bereitstellen muss, werden vom Frontend verwendet, um

**\[1\]**
: das Plugin zu initialisieren und zu beenden

**\[2\]**
: die Anzahl der Durchgänge zu ermitteln, die über die Eingabe laufen müssen

**\[3\]**
: jeden Durchgang zu initialisieren und zu beenden

**\[4\]**
: Engine-Parameter abzufragen und zu initialisieren. Nachdem das Plugin geladen wurde und die Frontend-Befehle eingerichtet sind, werden die Befehle in der folgenden Reihenfolge aufgerufen:


```
    idx_numpasses -> n
    idx_listvariables -> vars

    idx_varset var1 value1
    idx_varset var2 value2
    ...
    idx_varset varK valueK
    idx_initialize
    idx_setup 1
    ...
    idx_setup 2
    ...
    ...
    idx_setup n
    ...
    idx_postprocess
    idx_shutdown
    ...
```

Das heißt, zunächst werden die Anzahl der Durchgänge und die Menge der verfügbaren Engine-Parameter festgelegt, woraufhin Aufrufe zur Einstellung der Parameter folgen. Dieser zweite Teil ist optional.

Nachdem das Plugin initialisiert wurde, wird die angegebene Anzahl von Durchgängen ausgeführt, das Endergebnis durchläuft einen globalen Nachbearbeitungsschritt und schließlich wird das Plugin wieder beendet. Darauf können weitere Konvertierungen folgen, wobei die Sequenz bei **idx_varset** neu gestartet wird.

In jedem Durchgang, d. h. nach dem Aufruf von **idx_setup**, verarbeitet das Frontend die Eingabe und ruft die Formatierungsbefehle auf, sobald Markup erkannt wird. Dies bedeutet, dass die Reihenfolge der Formatierungsbefehle durch die Grammatik der docidx-Markup-Sprache bestimmt wird, wie sie in der Spezifikation *Syntax der docidx-Sprache* festgelegt ist.

Eine andere Sichtweise auf die Abfolge ist folgende:

**•**
: Zunächst werden einige grundlegende Parameter festgelegt.

**•**
: Dann bildet alles, beginnend mit dem ersten „**idx_varset**“ bis hin zu „**idx_shutdown**“, einen *Lauf*, d. h. die Formatierung einer einzelnen Eingabe. Auf jeden Lauf können weitere folgen.

**•**
: In jeden Lauf sind ein oder mehrere *Durchgänge* eingebettet, die jeweils mit **idx_setup** beginnen und so lange andauern, bis entweder das nächste **idx_setup** oder **idx_postprocess** erreicht ist. Wenn zur Durchführung der Formatierung mehrere Durchgänge erforderlich sind, ist nur die Ausgabe des letzten Durchgangs relevant. Die Ausgabe aller vorhergehenden, vorbereitenden Durchgänge wird ignoriert. Die Befehle, ihre Namen, Signaturen und Aufgaben lauten im Einzelnen wie folgt:


**idx_initialize**
: *Initialisierung/Beendigung*. Dieser Befehl wird zu Beginn jedes Konvertierungslaufs als erster Befehl dieses Laufs aufgerufen. Hinweis: Ein Lauf ist kein Durchgang, sondern kann aus mehreren Durchgängen bestehen. Er muss den allgemeinen Zustand des Plugins initialisieren, über die beim Laden durchgeführte Initialisierung hinaus. Es wird kein Rückgabewert erwartet, und jeder zurückgegebene Wert wird ignoriert.

**idx_listvariables**
: *Initialisierung/Beendigung* und *Engine-Parameter*. Der zweite Befehl wird aufgerufen, nachdem der Plugin-Code geladen wurde, d. h. unmittelbar nach **idx_numpasses**. Er muss eine Liste zurückgeben, die die Namen der Parameter enthält, die das Frontend zur Konfiguration der Engine einstellen kann. Diese Liste kann leer sein.

**idx_numpasses**
: *Initialisierung/Beendigung* und *Durchgangsverwaltung*. Der erste Befehl, der nach dem Laden des Plugin-Codes aufgerufen wird. Vor diesem Befehl wird kein anderer Befehl der Engine aufgerufen. Er muss die Anzahl der Durchgänge zurückgeben, die diese Engine benötigt, um das Eingabedokument vollständig zu verarbeiten. Dieser Wert muss eine ganze Zahl sein, die größer oder gleich eins ist.

**idx_postprocess** *text*
: *Initialisierung/Beendigung*. Dieser Befehl wird unmittelbar nach dem letzten Durchgang eines Laufs aufgerufen. Sein Argument ist das Ergebnis der durch diesen Durchgang erzeugten Konvertierung. Er dient dazu, der Engine die Möglichkeit zu geben, globale Änderungen am erzeugten Dokument vorzunehmen. Ist für ein bestimmtes Format keine Nachbearbeitung erforderlich, muss der Befehl lediglich das Argument zurückgeben. Es wird erwartet, dass ein Wert zurückgegeben wird, nämlich das Endergebnis der Formatierung der Eingabe.

**idx_setup** *n*
: *Initialisierung/Beendigung* und *Durchgangsverwaltung*. Dieser Befehl wird zu Beginn jedes Durchgangs über die Eingabe in einem Lauf aufgerufen. Sein Argument ist die Nummer des Durchgangs, der gerade begonnen hat. Die Durchgänge werden ab **1** aufwärts gezählt. Der Befehl muss den internen Zustand des Plugins für diesen bestimmten Durchgang einrichten. Es wird kein Rückgabewert erwartet, und jeder zurückgegebene Wert wird ignoriert.

**idx_shutdown**
: *Initialisierung/Beendigung*. Dieser Befehl wird am Ende jedes Konvertierungslaufs aufgerufen. Er ist der letzte Befehl, der in einem Lauf ausgeführt wird. Er muss alle laufspezifischen Zustände im Plugin bereinigen. Nach dem Aufruf muss sich die Engine in einem Zustand befinden, der den Start eines weiteren Laufs ermöglicht, ohne dass Informationen aus dem letzten Lauf in diesen neuen Lauf übergreifen. Es wird kein Rückgabewert erwartet, und jeder zurückgegebene Wert wird ignoriert.

**idx_varset** *varname* *text*
: *Engine-Parameter*. Dieser Befehl wird vom Frontend aufgerufen, um einen Engine-Parameter auf einen bestimmten Wert zu setzen. Der zu ändernde Parameter wird durch *varname* angegeben, der einzustellende Wert durch *text*. Der Befehl muss einen Fehler auslösen, wenn ein unbekannter *varname* verwendet wird. Nur die von **idx_listvariables** zurückgegebenen Namen gelten als bekannt. Die Werte aller Engine-Parameter müssen über Durchgänge und Läufe hinweg erhalten bleiben.


## Formatierungsbefehle

Die Formatierungsbefehle müssen die Formatierung für das Ausgabeformat für alle Markup-Befehle der docidx-Markup-Sprache implementieren, mit Ausnahme von **lb**, **rb**, **vset**, **include** und **comment**. Diese Ausnahmen werden vom Frontend verarbeitet und sind für das Plugin nicht sichtbar. Im Gegenzug muss ein Befehl zur Formatierung von Klartext bereitgestellt werden, für etwas, das in der Eingabe überhaupt kein Markup enthält.

Das bedeutet, dass jeder der fünf in der *docidx-Sprachbefehlsreferenz* angegebenen Markup-Befehle, die nicht zu den oben aufgeführten Ausnahmen gehören, einen entsprechenden Formatierungsbefehl besitzt, der dieselben Argumente wie der Markup-Befehl akzeptiert und dessen Name dem Namen des Markup-Befehls mit dem vorangestellten Präfix *fmt\_* entspricht.

Von allen Befehlen wird erwartet, dass sie ihre Eingabe gemäß der in der Befehlsreferenz festgelegten Semantik in irgendeiner Weise formatieren und den Teil davon, den sie für notwendig erachten, als Ergebnis zurückgeben, das der Ausgabe hinzugefügt wird.

Um eine im Wesentlichen doppelte Darstellung der Befehlsreferenz zu vermeiden, führen wir hier keinen der Befehle auf und verweisen den Leser lediglich auf die *Befehlsreferenz der docidx-Sprache*, in der deren Syntax und Beschreibung zu finden sind. Die einzige Ausnahme bildet der Formatierer für einfachen Text, für den es keinen entsprechenden Markup-Befehl gibt.

Die Reihenfolge, in der Formatierungsbefehle aufgerufen werden, ist nicht so streng festgelegt wie bei den Verwaltungsbefehlen, sondern richtet sich nach der Grammatik der docidx-Auszeichnungssprache, wie sie in der Spezifikation *Syntax der docidx-Sprache* festgelegt ist.

**fmt_plain_text** *text*
: *Kein zugehöriger Markup-Befehl*. Wird vom Frontend für jeden im Eingabetext vorkommenden Klartext aufgerufen. Er muss alle für Klartext erforderlichen speziellen Verarbeitungsschritte durchführen. Als Ergebnis des Befehls wird der formatierte Text erwartet, der der Ausgabe hinzugefügt wird. Ist keine spezielle Verarbeitung erforderlich, muss er sein Argument einfach unverändert zurückgeben.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2007 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
