---
CommandName: htmlparse
ManualSection: n
Version: 1.2.3
TclPart: tcllib
TclDescription: HTML Parser
Links:
 - struct::tree
Keywords:
 - html
 - parsing
 - queue
 - tree
Copyright:
---

# NAME

htmlparse – Prozeduren zum Parsen von HTML-Zeichenketten

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [struct::stack]{.lit} [1.3]{.lit} 
[package]{.cmd} [require]{.sub} [cmdline]{.lit} [1.1]{.lit} 
[package]{.cmd} [require]{.sub} [htmlparse]{.lit} [1.2.3]{.optlit} 
[::htmlparse::parse]{.cmd} [-cmd cmd]{.optarg} [-vroot tag]{.optarg} [-split n]{.optarg} [-incvar var]{.optarg} [-queue q]{.optarg} [html]{.arg} 
[::htmlparse::debugCallback]{.cmd} [clientdata]{.optarg} [tag]{.arg} [slash]{.arg} [param]{.arg} [textBehindTheTag]{.arg} 
[::htmlparse::mapEscapes]{.cmd} [html]{.arg} 
[::htmlparse::2tree]{.cmd} [html]{.arg} [tree]{.arg} 
[::htmlparse::removeVisualFluff]{.cmd} [tree]{.arg} 
[::htmlparse::removeFormDefs]{.cmd} [tree]{.arg} 
:::

# BESCHREIBUNG

Das **htmlparse**-Paket stellt Befehle bereit, mit denen Bibliotheken und Anwendungen HTML-Inhalte in einer Zeichenkette in eine Darstellung ihrer Wahl zerlegen können.

Folgende Befehle stehen zur Verfügung:

**::htmlparse::parse** ?-cmd *cmd*? ?-vroot *tag*? ?-split *n*? ?-incvar *var*? ?-queue *q*? *html*
: Dieser Befehl ist der grundlegende Parser für HTML. Er nimmt eine HTML-Zeichenkette entgegen, analysiert sie und ruft für jedes gefundene Tag ein Befehlspräfix auf. Der HTML-Code muss nicht gültig sein, damit dieser Parser funktioniert. Es liegt in der Verantwortung des für jedes Tag aufgerufenen Befehls, dies zu überprüfen. Eine weitere Aufgabe des aufgerufenen Befehls ist die Verarbeitung von Tag-Attributen und Zeichenentitäten (Escape-Zeichen). Der Parser stellt dem aufgerufenen Befehl die nicht interpretierten Tag-Attribute zur Verfügung, um bei Ersterem zu helfen, und das Paket als Ganzes bietet einen Hilfsbefehl, **::htmlparse::mapEscapes**, zur Unterstützung bei der Behandlung von Letzterem. Der Parser ignoriert *tatsächlich* führende DOCTYPE-Deklarationen und alle gültigen HTML-Kommentare, auf die er stößt. Alle Informationen, die über die HTML-Zeichenkette selbst hinausgehen, werden über Optionen festgelegt; diese werden im Folgenden erläutert. Zum besseren Verständnis der Optionen folgen hier einige weitere Hintergrundinformationen zum Parser. Er ist in der Lage, unvollständige Tags in der ihm übergebenen HTML-Zeichenkette zu erkennen. Unter normalen Umständen führt dies dazu, dass der Parser einen Fehler auslöst; wenn jedoch die Option *-incvar* verwendet wird, um eine globale (oder Namespace-)Variable festzulegen, speichert der Parser den unvollständigen Teil der Eingabe stattdessen in dieser Variablen. Dies ist eine große Hilfe bei der Verarbeitung von schrittweise eintreffendem HTML, da der Parser alles verarbeitet, was er kann, und die Verarbeitung des unvollständigen Teils aufschiebt, bis weitere Daten eingetroffen sind. Ein weiteres Merkmal des Parsers sind seine zwei möglichen Betriebsmodi. Der Normalmodus wird aktiviert, wenn die Option *-queue* in der Befehlszeile, mit der der Parser aufgerufen wird, nicht vorhanden ist. Ist sie vorhanden, wechselt der Parser stattdessen in den inkrementellen Modus. Der Hauptunterschied besteht darin, dass ein Parser im Normalmodus für jedes Tag, auf das er stößt, sofort das Befehlspräfix aufruft. Im inkrementellen Modus hingegen generiert der Parser eine Reihe von Skripten, die das Befehlspräfix für Gruppen von Tags in der HTML-Zeichenkette aufrufen, und speichert diese Skripte anschließend in der angegebenen Warteschlange. Es liegt dann in der Verantwortung des Aufrufers des Parsers, die Ausführung der Skripte in der Warteschlange sicherzustellen. *Hinweis*: Das dem Parser übergebene Warteschlangen-Objekt muss dieselbe Schnittstelle bereitstellen wie die in tcllib -> struct definierte Warteschlange. Das bedeutet beispielsweise, dass alle über dieses tcllib-Modul erstellten Warteschlangen hier sofort verwendet werden können. Die Warteschlange muss jedoch nicht unbedingt aus tcllib -> struct stammen, solange dieselbe Schnittstelle bereitgestellt wird. In beiden Modi gibt der Parser eine leere Zeichenkette an den Aufrufer zurück. Die Option *-split* kann einem Parser im inkrementellen Modus übergeben werden, um die Größe der von ihm erstellten Gruppen festzulegen. Mit anderen Worten: -split 5 bedeutet, dass jedes der generierten Skripte den Befehls-Präfix-Befehl für 5 aufeinanderfolgende Tags in der HTML-Zeichenkette aufruft. Ein Parser im Normalmodus ignoriert diese Option und ihren Wert. Die Option *-vroot* legt ein virtuelles Stamm-Tag fest. Ein Parser im Normalmodus ruft den Befehl dafür unmittelbar vor und nach der Verarbeitung der TAGs im HTML-Text auf und simuliert so, dass die HTML-Zeichenkette von einer Kombination aus \<vroot> und \</VROOT> umschlossen ist. Im inkrementellen Modus ist der Parser jedoch nicht in der Lage, das schließende virtuelle Stamm-Tag bereitzustellen, da er nie weiß, wann die Eingabe vollständig ist. In diesem Fall enthält das erste Skript, das bei jedem Aufruf des Parsers generiert wird, als ersten Befehl einen Aufruf des Befehlspräfixes für das virtuelle Stamm-Tag. Die folgenden Optionen stehen zur Verfügung:


**-cmd** *cmd*
: Der Befehl, der für jedes Tag in der HTML-Zeichenkette aufgerufen werden soll. Der Standardwert lautet *::htmlparse::debugCallback*.

**-vroot** *tag*
: Das virtuelle Root-Tag, das im Normalmodus um den HTML-Code herum eingefügt wird. Im inkrementellen Modus ist es das erste Tag in jedem vom Parser verarbeiteten Block, es gibt jedoch keine schließenden Tags. Der Standardwert ist *hmstart*.

**-split** *n*
: Die Größe der Gruppen, die von einem Parser im inkrementellen Modus erzeugt werden. Wird im normalen Modus ignoriert. Der Standardwert ist 10. Werte <= 0 sind nicht zulässig.

**-incvar** *var*
: Der Name der Variablen, in der unvollständiger HTML-Code gespeichert werden soll. Dies ist vor allem im inkrementellen Modus sinnvoll. Der Parser löst einen Fehler aus, wenn er unvollständigen HTML-Code erkennt und keinen Speicherort dafür hat. Dies ist im normalen Modus sinnvoll. Es werden nur unvollständige Tags erkannt, nicht jedoch fehlende Tags. Optional, Standardwert ist „keine Variable“.


*Schnittstelle zum Befehlspräfix*
: Im Normalmodus ruft der Parser das Befehlspräfix auf, dem vier Argumente angehängt werden. Eine Beschreibung finden Sie unter **::htmlparse::debugCallback**. Im inkrementellen Modus rufen die generierten Skripte das Befehlspräfix jedoch mit fünf angehängten Argumenten auf. Die letzten vier davon sind dieselben wie oben erwähnt. Das erste ist eine Platzhalterzeichenfolge (**@win@**) für einen „clientdata“-Wert, der später während der eigentlichen Ausführung der generierten Skripte bereitgestellt wird. Dies könnte beispielsweise ein tk-Pfad für ein Fenster sein. Dies ermöglicht es dem Nutzer dieses Pakets, HTML-Zeichenfolgen vorzuverarbeiten, ohne sie während der Analyse einer bestimmten Verbindung zuzuordnen. Diese Verbindung kann später erfolgen. Das bedeutet auch, dass es möglich ist, vorverarbeitetes HTML zwischenzuspeichern. Natürlich hindert nichts den Nutzer des Parsers daran, den Platzhalter durch eine leere Zeichenfolge zu ersetzen.


**::htmlparse::debugCallback** ?*clientdata*? *tag slash param textBehindTheTag*
: Dieser Befehl ist die Standard-Callback-Funktion, die der Parser in **::htmlparse::parse** verwendet, wenn vom Benutzer kein eigener angegeben wurde. Er gibt lediglich seine Argumente an stdout aus. Diese Callback-Funktion kann sowohl im normalen als auch im inkrementellen Modus des aufrufenden Parsers verwendet werden. Mit anderen Worten: Er akzeptiert vier oder fünf Argumente. Die letzten vier Argumente werden im Folgenden beschrieben. Das optionale fünfte Argument enthält den Wert „clientdata“, der vom Parser im inkrementellen Modus an die Rückruffunktion übergeben wird. Alle Rückruffunktionen müssen bei den letzten vier Argumenten der Signatur dieses Befehls entsprechen, und Rückruffunktionen, die beim inkrementellen Parsen verwendet werden, müssen bei den letzten fünf Argumenten dieser Signatur entsprechen. Das erste Argument, *clientdata*, ist optional und nur vorhanden, wenn dieser Befehl von einem Parser im inkrementellen Modus aufgerufen wird. Es enthält alles, was der Benutzer dieses Pakets wünscht. Das zweite Argument, *tag*, enthält den Namen des Tags, das gerade vom Parser verarbeitet wird. Das dritte Argument, *slash*, ist entweder leer oder enthält ein Schrägstrichzeichen. Es ermöglicht der Rückruffunktion, zwischen öffnenden (slash ist leer) und schließenden Tags (slash enthält ein Schrägstrichzeichen) zu unterscheiden. Das vierte Argument, *param*, enthält die nicht interpretierte Liste der Parameter für das Tag. Das fünfte und letzte Argument, *textBehindTheTag*, enthält den Text, den der Parser hinter dem in *tag* genannten Tag gefunden hat.

**::htmlparse::mapEscapes** *html*
: Dieser Befehl nimmt eine HTML-Zeichenkette entgegen, ersetzt alle Escape-Sequenzen durch ihre tatsächlichen Zeichen und gibt anschließend die resultierende Zeichenkette zurück. HTML-Zeichenketten, die keine Escape-Sequenzen enthalten, werden unverändert zurückgegeben.

**::htmlparse::2tree** *html tree*
: Dieser Befehl ist ein Wrapper um **::htmlparse::parse**, der eine HTML-Zeichenkette (in *html*) entgegennimmt und diese in einen Baum umwandelt, der die logische Struktur des geparsten Dokuments enthält. Der Name des Baums wird dem Befehl als zweites Argument (*tree*) übergeben. Der Befehl generiert den Baum **nicht** selbst, sondern erwartet, dass der Aufrufer ihm einen bereits vorhandenen und leeren Baum übergibt. Er erwartet außerdem, dass das angegebene Baumobjekt dieselbe Schnittstelle wie das Baumobjekt in tcllib -> struct aufweist. Es muss nicht unbedingt aus tcllib -> struct stammen, muss aber dieselbe Schnittstelle bereitstellen. Die interne Rückruffunktion führt einige grundlegende Prüfungen der HTML-Gültigkeit durch und versucht, die grundlegendsten Fehler zu beheben. Der Befehl gibt den Inhalt seines zweiten Arguments zurück. Nebenwirkungen sind die Erstellung und Bearbeitung eines Baumobjekts. Jeder Knoten im generierten Baum repräsentiert ein Tag in der Eingabe. Der Name des Tags wird im Attribut *type* des Knotens gespeichert. Alle mit dem Tag mitgelieferten HTML-Attribute werden unverändert im Attribut *data* des Tags gespeichert. Mit anderen Worten: Der Befehl analysiert HTML-Attribute *nicht* in ihre Namen und Werte. Wenn ein Tag Text enthält, verfügt sein Knoten über untergeordnete Knoten vom Typ *PCDATA*, die diesen Text enthalten. Der Text wird im Attribut *data* dieser untergeordneten Knoten gespeichert.

**::htmlparse::removeVisualFluff** *tree*
: Dieser Befehl durchläuft einen von **::htmlparse::2tree** generierten Baum und entfernt alle Knoten, die visuelle und keine strukturellen Tags darstellen. Der Zweck des Befehls besteht darin, die Navigation im Baum zu vereinfachen, ohne sich in visuellen Informationen zu verlieren, die für die Suche irrelevant sind. Sein einziges Argument ist der Name des Baums, der bereinigt werden soll.

**::htmlparse::removeFormDefs** *tree*
: Genau wie **::htmlparse::removeVisualFluff** dient dieser Befehl dazu, die Größe des von **::htmlparse::2tree** generierten Baums zu reduzieren. Er entfernt alle Knoten, die Formulare und Formularelemente darstellen. Sein einziges Argument ist der Name des Baums, der verkleinert werden soll.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *htmlparse* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung
