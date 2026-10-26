---
CommandName: dtplite
ManualSection: n
Version: 1.0.5
TclPart: tcllib
TclDescription: Documentation toolbox
Links:
 - docidx introduction
 - doctoc introduction
 - doctools introduction
Keywords:
 - HTML
 - TMML
 - conversion
 - docidx
 - doctoc
 - doctools
 - manpage
 - markup
 - nroff
Copyright:
 - Copyright (c) 2004-2013 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

dtplite – Ein schlanker DocTools-Markup-Prozessor

# ÜBERSICHT

::: {.synopsis} :::
[dtplite]{.cmd} [-o]{.sub} [output]{.arg} [options]{.optarg} [format]{.arg} [inputfile]{.arg} 
[dtplite]{.cmd} [validate]{.sub} [inputfile]{.arg} 
[dtplite]{.cmd} [-o]{.sub} [output]{.arg} [options]{.optarg} [format]{.arg} [inputdirectory]{.arg} 
[dtplite]{.cmd} [-merge]{.sub} [-o]{.lit} [output]{.arg} [options]{.optarg} [format]{.arg} [inputdirectory]{.arg} 
:::

# BESCHREIBUNG

Die in diesem Dokument beschriebene Anwendung **dtplite** ist der Nachfolger des äußerst einfachen **mpexpand**. In ihrer Funktionalität ist sie vom doctools-Prozessor **dtp** beeinflusst und damit wesentlich leistungsfähiger als **mpexpand**, und dennoch genauso benutzerfreundlich; auf jeden Fall einfacher als **dtp** mit seiner Vielzahl an Unterbefehlen und Optionen.

**dtplite** basiert, ebenso wie die beiden anderen Prozessoren, auf dem Paket **doctools**.

## Anwendungsfälle

**dtplite** wurde unter Berücksichtigung der folgenden drei Anwendungsfälle entwickelt.

**\[1\]**
: Validierung eines einzelnen Dokuments, d. h. Überprüfung, ob es im gültigen doctools-Format verfasst wurde. Dieser Modus kann auch verwendet werden, um eine vorläufige Version der formatierten Ausgabe für ein einzelnes Dokument zu erhalten, die in einem Browser, mit nroff usw. angezeigt werden kann, wodurch eine Korrekturlesung der Formatierung ermöglicht wird.

**\[2\]**
: Erstellung der formatierten Dokumentation für ein einzelnes Paket, d. h. aller Manpages sowie einer Tabelle mit Inhaltsverzeichnis und einem Index mit Schlüsselwörtern.

**\[3\]**
: Eine Erweiterung der bisherigen Vorgehensweise, eine Methode zur einfachen Erstellung eines Dokumentationsbaums für mehrere Pakete und insbesondere einer einheitlichen Tabelle mit Inhaltsverzeichnis und Index für Schlüsselwörter. Darüber hinaus möchten wir auch die vom HTML-Formatierer bereitgestellten Anpassungsfunktionen nutzen. Es ist zwar nicht das einzige Format, das die Anwendung generieren können sollte, doch gehen wir davon aus, dass es am häufigsten verwendet wird, und es ist eines der wenigen, die Anpassungsmöglichkeiten bieten. Wir ermöglichen es dem Aufrufer, eine Kopfzeile, eine Fußzeile, ein Stylesheet sowie Daten für eine Navigationsleiste am oberen Rand des generierten Dokuments festzulegen. Zwar können alle diese Elemente festgelegt werden, sofern die Formatierungs-Engine einen entsprechenden Parameter bereitstellt (siehe Abschnitt **Optionen**), doch unterliegen die beiden letztgenannten einer internen Verarbeitung, die sie spezifisch für HTML macht.


## Befehlszeile

**dtplite** **-o** *output* ?Optionen? *format* *inputfile*
: Dies ist die Form für den Anwendungsfall \[1\]. Die *options* werden später im Abschnitt **Optionen** erläutert.


path *output* (in)
: Dieses Argument legt fest, wohin das generierte Dokument geschrieben werden soll. Es kann sich dabei um den Pfad zu einer Datei oder einem Verzeichnis handeln oder um „**-**“. Der letzte Wert bewirkt, dass die Anwendung das generierte Dokument in „**stdout**“ schreibt. Wenn der *output* nicht existiert, muss \[file dirname \$output\] vorhanden sein und es muss sich um ein beschreibbares Verzeichnis handeln. Das generierte Dokument wird in eine Datei in diesem Verzeichnis geschrieben, wobei der Name dieser Datei aus *inputfile*, *format* und dem für die Option **-ext** angegebenen Wert (sofern vorhanden) abgeleitet wird.

(Pfad|Handle) *format* (in)
: Dieses Argument legt fest, welche Formatierungs-Engine bei der Verarbeitung der Eingabe verwendet werden soll, und bestimmt somit das Format des erzeugten Dokuments. Die von der Anwendung unterstützten Möglichkeiten finden Sie im Abschnitt **Formate**.

path *inputfile* (in)
: Dieses Argument legt den Pfad zu der zu verarbeitenden Datei fest. Die Datei muss vorhanden und lesbar sein und im *doctools*-Format vorliegen.


**dtplite** **validate** *inputfile*
: Dies ist eine vereinfachte Form für den Anwendungsfall \[1\]. Das Format „validate“ erzeugt keinerlei Ausgabe; es werden lediglich Syntaxprüfungen durchgeführt. Daher ist die Angabe einer Ausgabedatei oder anderer Optionen nicht erforderlich und wird weggelassen.

**dtplite** **-o** *output* ?Optionen? *format* *inputdirectory*
: Dies ist die Form für den Anwendungsfall \[2\]. Es unterscheidet sich von der Form für den Anwendungsfall \[1\] dadurch, dass die Eingabedokumente über ein Verzeichnis statt über eine Datei angegeben werden. Die übrigen Argumente sind identisch, mit Ausnahme von *output*, das nun den Pfad zu einem vorhandenen und beschreibbaren Verzeichnis angeben muss. Bei den Eingabedokumenten handelt es sich um alle Dateien im *inputdirectory* oder in einem seiner Unterverzeichnisse, die von **fileutil::fileType** als Dateien im *doctools*-Format erkannt wurden.

**dtplite** **-merge** **-o** *output* ?Optionen? *format* *inputdirectory*
: Dies ist die Form für den Anwendungsfall \[3\]. Der einzige Unterschied zur Form für den Anwendungsfall \[2\] besteht in der zusätzlichen Option **-merge**. Bei jedem solchen Aufruf werden die generierten Dokumente, die aus dem Prozess der Eingabedokumente unter *inputdirectory* oder einem seiner Unterverzeichnisse stammen, mit den Dateien unter *output* zusammengeführt. Auf diese Weise ist es möglich, die einheitliche Dokumentation für eine beliebige Anzahl von Paketen schrittweise aufzubauen. Beachten Sie, dass alle Pakete zweimal durchlaufen werden müssen, um vollständig korrekte Querverweise zu erhalten (bei Formaten, die diese unterstützen).


## Optionen

In diesem Abschnitt werden alle Optionen beschrieben, die dem Benutzer der Anwendung zur Verfügung stehen, mit Ausnahme der Optionen **-o** und **-merge**. Diese beiden wurden bereits im Abschnitt **Befehlszeile** beschrieben.

**-exclude** Zeichenfolge
: Diese Option legt ein Ausschlussmuster (Glob-Muster) fest. Alle Dateien, die als zu verarbeitende Manpages identifiziert wurden und dem Ausschlussmuster entsprechen, werden ignoriert. Die Option kann mehrfach angegeben werden, wobei jede Angabe ein weiteres Muster zur Liste der Ausschlüsse hinzufügt.

**-ext** Zeichenfolge
: Wenn der Name einer Ausgabedatei aus dem Namen einer Eingabedatei abgeleitet werden muss, wird standardmäßig der Name des *format* als Erweiterung verwendet. Diese Option hebt dies jedoch auf und erzwingt die Verwendung von *string* als Erweiterung. Diese Option wird ignoriert, wenn der Name der Ausgabedatei vollständig über die Option **-o** festgelegt ist. Bei mehrfacher Verwendung ist nur die letzte Definition maßgeblich.

**-header** Datei
: Diese Option kann genau dann verwendet werden, wenn die Auswahl das *format* ausgewählt hat, das einen Engine-Parameter namens „header“ bereitstellt. Sie übernimmt den Inhalt der angegebenen Datei und weist ihn diesem Parameter zu, damit die Engine ihn entsprechend nutzen kann. Die HTML-Engine fügt den Text unmittelbar nach dem Tag **\<body>** ein. Sind Navigationsschaltflächen vorhanden (siehe Option **-nav** weiter unten), wird der für diese generierte HTML-Code vor der endgültigen Zuweisung an den Parameter an die hier stammenden Header-Daten angehängt. Bei mehrfacher Verwendung ist nur die letzte Definition relevant.

**-footer** Datei
: Wie **-header**, mit folgenden Unterschieden: Alle Navigationsschaltflächen werden ignoriert, der entsprechende erforderliche Engine-Parameter hat den Namen „footer“ und die Daten werden unmittelbar vor dem Tag **\</body>** eingefügt. Bei mehrfacher Verwendung ist nur die letzte Definition relevant.

**-style** Datei
: Diese Option kann genau dann verwendet werden, wenn die Auswahl das *format* ausgewählt hat, das einen Engine-Parameter mit dem Namen „meta“ bereitstellt. Wenn dies der Fall ist, wird ein HTML-Codeabschnitt generiert, der die *file* als Stylesheet für das generierte Dokument deklariert, und dieser wird dem Parameter zugewiesen. Die HTML-Engine fügt diesen Code unmittelbar nach dem Tag **\<head>** in das Dokument ein. Bei der Verarbeitung eines Eingabeverzeichnisses wird die Stylesheet-Datei in das Ausgabeverzeichnis kopiert, und der generierte HTML-Code verweist auf diese Kopie, um das Ergebnis in sich geschlossener zu gestalten. Bei der Verarbeitung einer Eingabedatei gibt es keinen Speicherort, an den das Stylesheet kopiert werden könnte, weshalb einfach wie angegeben auf die Datei verwiesen wird. Bei mehrfacher Verwendung ist nur die letzte Definition relevant.

**-toc** Pfad
: Diese Option legt eine Doctoc-Datei fest, die für das Inhaltsverzeichnis verwendet werden soll, anstatt ein eigenes zu erstellen. Bei mehrfacher Verwendung ist nur die letzte Definition maßgeblich.

**-pre+toc** Bezeichnung Pfad|Text
: ...siehe nächstes...

**-post+toc** Bezeichnung Pfad|Text
: Diese Option legt zusätzliche Doctoc-Dateien (oder Texte) fest, die in der Navigationsleiste verwendet werden sollen. Die Positionierung und die Handhabung bei mehrfacher Verwendung entsprechen den Optionen **-prenav** und **-postnav**; siehe unten.

**-nav** Bezeichnung URL
: ...siehe nächstes...

**-prenav** Bezeichnung URL
: Legt eine Navigationsschaltfläche mit der anzuzeigenden *label* und der *url* fest, auf die verwiesen wird. Diese Option kann genau dann verwendet werden, wenn das ausgewählte *format* einen Engine-Parameter namens „header“ bereitstellt. Der dafür erzeugte HTML-Code wird an die Daten aus der Option **-header** angehängt, bevor er in die erzeugten Dokumente eingefügt wird. Bei mehrfacher Verwendung werden alle Angaben gesammelt und eine Navigationsleiste erzeugt, die erste Angabe am linken Rand und die letzte am rechten. Die URL kann relativ sein. In diesem Fall wird davon ausgegangen, dass sie relativ zu den Hauptdateien (Inhaltsverzeichnis und Index für Schlüsselwörter) ist, und sie wird durch eine Transformation so umgewandelt, dass alle anderen Verweise weiterhin korrekt funktionieren.

**-postnav** Bezeichnung URL
: Legt eine Navigationsschaltfläche mit der anzuzeigenden *label* und der *url* fest, auf die verwiesen wird. Diese Option kann nur dann verwendet werden, wenn das ausgewählte *format* einen Engine-Parameter namens „header“ bereitstellt. Der dafür erzeugte HTML-Code wird an die Daten aus der Option **-header** angehängt, bevor er in die erzeugten Dokumente eingefügt wird. Bei mehrfacher Verwendung werden alle Angaben gesammelt und eine Navigationsleiste erzeugt, die letzte Angabe am rechten Rand und die erste am linken. Die URL kann relativ sein. In diesem Fall wird davon ausgegangen, dass sie relativ zu den Hauptdateien (Inhaltsverzeichnis und Index für Schlüsselwörter) ist, und sie unterliegt einer Transformation, damit alle anderen Verweise weiterhin korrekt funktionieren.


## Formate

Zunächst wird das Argument *format* als Pfad zu einer TCL-Datei interpretiert, die den Code für die angeforderte Formatierungs-Engine enthält. Das Argument wird genau dann als Name eines der unten aufgeführten vordefinierten Formate interpretiert, wenn der Pfad nicht existiert.

*Beachten Sie eine Einschränkung*: Wenn die Interpretation des Formats als Pfad zu dem Tcl-Skript, das die Engine implementiert, erfolgreich war, muss dieses Skript nicht nur die Engine-API für doctools, d. h. *doctools_api*, sondern auch die APIs für *doctoc_api* und *docidx_api* implementieren. Andernfalls schlägt die Erstellung einer Tabelle mit Inhaltsverzeichnis und einem Index für Schlüsselwörter fehl.

Liste der vordefinierten Formate, d. h. derjenigen, die vom Paket **doctools** bereitgestellt werden:

**nroff**
: Der Prozessor erzeugt eine \*roff-Ausgabe, das Standardformat für Unix-Manpages.

**html**
: Der Prozessor erzeugt HTML-Ausgabe, die in Webbrowsern verwendet und dort angezeigt wird. Diese Engine ist derzeit die einzige, die die verschiedenen Engine-Parameter bereitstellt, die für die zusätzliche Anpassung der Ausgabe erforderlich sind.

**tmml**
: Der Prozessor erzeugt TMML-Ausgaben, die Tcl Manpage Markup Language, eine Ableitung von XML.

**latex**
: Der Prozessor erzeugt eine LaTeX-Ausgabe.

**wiki**
: Der Prozessor erzeugt Wiki-Markup, wie es **wikit** versteht.

**list**
: Der Prozessor extrahiert die von **manpage_begin** bereitgestellten Informationen. Dieses Format wird intern verwendet, um die Metadaten zu extrahieren, aus denen sowohl das Inhaltsverzeichnis als auch der Index für Schlüsselwörter abgeleitet werden.

**null**
: Der Prozessor erzeugt keine Ausgabe. Dies entspricht dem Fehlercode **validate**.


## Verzeichnisstrukturen

In diesem Abschnitt beschreiben wir die Verzeichnisstrukturen, die von der Anwendung unter *output* bei der Verarbeitung aller Dokumente in einem *inputdirectory* erzeugt werden. Mit anderen Worten: Dies ist nur für die Anwendungsfälle \[2\] und \[3\] relevant.

**\[2\]**
: Wenn ein einzelner Satz von Eingabedokumenten verarbeitet wird, wird die folgende Verzeichnisstruktur erstellt. Die verwendete Erweiterung dient der Ausgabe im HTML-Format; dies ist jedoch für die Struktur nicht relevant und wurde lediglich verwendet, um korrekte Namen der Dateien zu gewährleisten.


```
    output/
        toc.html
        index.html
        files/
            path/to/FOO.html
```

: Die letzte Zeile in den Beispielen zeigt das Dokument, das für eine Datei namens FOO generiert wurde, die sich unter folgendem Pfad befindet:


```
    inputdirectory/path/to/FOO
```

**\[3\]**
: Wenn viele Pakete zu einem einheitlichen Dokumentensatz zusammengeführt werden, ist die erzeugte Verzeichnisstruktur etwas tiefer gegliedert:


```
    output
        .toc
        .idx
        .tocdoc
        .idxdoc
        .xrf
        toc.html
        index.html
        FOO1/
            ...
        FOO2/
            toc.html
            files/
                path/to/BAR.html
```

: Jedes der Verzeichnisse FOO1, … enthält die für das Paket FOO1, … generierten Dokumente und folgt der für den Anwendungsfall \[2\] dargestellten Struktur. Die einzige Ausnahme besteht darin, dass kein paketbezogener Index vorhanden ist. Die Dateien „*.toc*“, „*.idx*“ und „*.xrf*“ enthalten den internen Status der gesamten Ausgabe und werden beim nächsten Aufruf gelesen und aktualisiert. Ihr Inhalt wird nicht dokumentiert. Löschen Sie diese Dateien, wenn alle für die Ausgabe gewünschten Pakete verarbeitet wurden, d. h. wenn die Ausgabe vollständig ist. Die Dateien „*.tocdoc*“ und „*.idxdoc*“ sind Zwischendateien im doctoc- bzw. docidx-Markup, die das Hauptinhaltsverzeichnis und den Index für die Dokumentensammlung vor deren Konvertierung in das gewählte Ausgabeformat enthalten. Sie bleiben an Ort und Stelle, d. h. sie werden nicht gelöscht, um als Beispiele für die Markup-Formate von doctoc und docidx zu dienen.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2004-2013 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
