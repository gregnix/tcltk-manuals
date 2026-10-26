---
CommandName: mkdoc
ManualSection: n
Version: 0.7.2
TclPart: tcllib
TclDescription: Source code documentation using Markdown
Copyright:
 - Copyright (c) 2019-2024, Detlef Groth <detlef(at)dgroth(dot)de>
---

# NAME

mkdoc – Extrahiert Markdown-Kommentare aus dem Quellcode und konvertiert diese optional in HTML

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [Markdown]{.lit} [1.2.2]{.optlit} 
[package]{.cmd} [require]{.sub} [yaml]{.lit} [0.4.2]{.optlit} 
[package]{.cmd} [require]{.sub} [mkdoc]{.lit} [0.7.2]{.optlit} 
[package]{.cmd} [require]{.sub} [hook]{.lit} 
[::mkdoc::mkdoc]{.cmd} [infile]{.arg} [outfile]{.arg} [-css cssfile]{.optarg} 
[::mkdoc::run]{.cmd} [infile]{.arg} 
:::

# BESCHREIBUNG

Das Paket **mkdoc** stellt einen Befehl bereit, mit dem in den Code eingebettete Dokumentation extrahiert und diese Kommentare optional in HTML konvertiert werden können. Letzteres erfolgt unter Verwendung des Tcllib-Pakets **Markdown**. Jede Zeile der eingebetteten Dokumentation beginnt mit dem speziellen Kommentar-Marker **#'**.

**::mkdoc::mkdoc** *infile* *outfile* ?**-css** *cssfile*?
: Der Befehl liest die angegebene *infile* und extrahiert die Codekommentare, die der Marker **#'** einleitet.  Ist *outfile* eine Datei „*.html*“ oder „*.htm*“, wird das Markdown mit einem Vorgabestil oder mit dem angegebenen Stylesheet *cssfile* nach HTML umgewandelt. Alle Argumente sind Pfade der Dateien, aus denen gelesen oder in die geschrieben wird. Das Ergebnis des Befehls ist die leere Zeichenkette. Die unterstützte Markdown-Syntax und ihre Erweiterungen stehen im Abschnitt **FORMATIERUNG**.

**::mkdoc::run** *infile*
: Der Befehl liest die angegebene *infile*, extrahiert die eingebettete Dokumentation und führt dann den Inhalt des ersten Beispiels aus, also des in **\`\`\`** gesetzten Blocks im Abschnitt **Example**. Hier ist ein solches Beispiel, das der Tcl-Interpreter ausführt


```
    #' ## <a name="example">Example</a>
    #'
    #' ```
    #' puts "Hello mkdoc package"
    #' puts "I am in the example section"
    #' ```
```

*GEFAHR, VORSICHT*. Lässt sich die *infile* nicht öffnen, *beendet* der Befehl den ganzen Prozess.

Von der Verwendung dieses Befehls im allgemeinen Kontext wird abgeraten.

# BEISPIELE

Das folgende Beispiel veranschaulicht die Konvertierung der Dokumentation, die in der Datei „*mkdoc.tcl*“ selbst eingebettet ist:

```
    package require mkdoc
    # extracting the Markdown
    mkdoc::mkdoc mkdoc.tcl mkdoc.md
    # converting Markdown to HTML
    mkdoc::mkdoc mkdoc.md mkdoc.html
    # direct conversion without intermediate file
    mkdoc::mkdoc mkdoc.tcl mkdoc.html
```

# FORMATIERUNG

Das Paket unterstützt die Syntax, die das Tcllib-Paket **Markdown** unterstützt.

Darüber hinaus unterstützt es eine Reihe einfacher YAML-Header, deren Informationen in entsprechende HTML-**meta**-Tags eingefügt werden. Die unterstützten Schlüssel sind

**author**
: Setzt den Autor des Dokuments. Die Vorgabe ist **NN**.

**title**
: Setzt den Dokumenttitel. Die Vorgabe ist **Documentation filename**.

**date**
: Setzt das Dokumentdatum. Die Vorgabe ist der aktuelle Tag.

**css**
: Setzt ein eigenes CSS-Stylesheet. Die Vorgabe ist das interne Stylesheet von mkdoc. *Hinweis*: Im Ausgabemodus Markdown werden diese Kopfzeilen einfach in das Ergebnis durchgereicht. Das ist richtig, denn Verarbeiter wie **pandoc** können sie ebenfalls nutzen. Die Syntax zeigt das Beispiel unten:


```
    #' ---
    #' title: mkdoc::mkdoc 0.7.1
    #' author: Detlef Groth, Schwielowsee, Germany
    #' date: 2022-04-17
    #' css: mini.css
    #' ---
    #'
```

Eine weitere Erweiterung gegenüber dem üblichen Markdown ist die Unterstützung von Includes auf einer einzigen Ebene.

Die Syntax zeigt das Beispiel unten:

```
    #' #include "path/to/include/file"
```

*Hinweis*, die doppelten Anführungszeichen um den Pfad gehören zur Syntax.

*Vorsicht* außerdem, dass relative Pfade relativ zum aktuellen Arbeitsverzeichnis aufgelöst werden und *nicht* relativ zum Ort der einbindenden Datei.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese dem Autor des Pakets. Bitte teilen Sie ihm auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation mit.

# COPYRIGHT AM CODE

Art der BSD-Lizenz:

Die folgenden Bedingungen gelten für alle Dateien, die mit der Software in Zusammenhang stehen, sofern in einzelnen Dateien nicht ausdrücklich etwas anderes angegeben ist.

Die Autoren erteilen hiermit die Erlaubnis, diese Software und ihre Dokumentation für jeden beliebigen Zweck zu nutzen, zu vervielfältigen, zu ändern, zu verbreiten und zu lizenzieren, vorausgesetzt, dass die vorhandenen Copyright-Hinweise in allen Kopien beibehalten werden und dass dieser Hinweis bei jeder Weitergabe wörtlich übernommen wird. Für keine der zulässigen Verwendungszwecke ist eine schriftliche Vereinbarung, eine Lizenz oder die Zahlung von Lizenzgebühren erforderlich. Änderungen an dieser Software können durch ihre Autoren urheberrechtlich geschützt sein und müssen nicht den hier beschriebenen Lizenzbedingungen entsprechen, sofern die neuen Bedingungen auf der ersten Seite jeder Datei, für die sie gelten, deutlich angegeben sind.

In keinem Fall haften die Autoren oder Vertreiber gegenüber Dritten für direkte, indirekte, besondere, zufällige oder Folgeschäden, die sich aus der Nutzung dieser Software, ihrer Dokumentation oder daraus abgeleiteter Werke ergeben, selbst wenn die Autoren auf die Möglichkeit solcher Schäden hingewiesen wurden.

Die Autoren und Vertreiber schließen ausdrücklich jegliche Gewährleistung aus, einschließlich, aber nicht beschränkt auf die stillschweigenden Gewährleistungen der Marktgängigkeit, der Eignung für einen bestimmten Zweck und der Nichtverletzung von Rechten Dritter. Diese Software wird „wie besehen“ bereitgestellt, und die Autoren und Vertreiber sind nicht verpflichtet, Wartung, Support, Updates, Erweiterungen oder Modifikationen bereitzustellen.

*EINGESCHRÄNKTE RECHTE*: Die Nutzung, Vervielfältigung oder Offenlegung durch die Regierung unterliegt den Einschränkungen, die in Unterabsatz (c) (1) (ii) der Klausel über Rechte an technischen Daten und Computersoftware gemäß DFARS 252.227-7013 und FAR 52.227-19 festgelegt sind.

# KATEGORIE

Textverarbeitung

# COPYRIGHT

```
Copyright (c) 2019-2024, Detlef Groth <detlef(at)dgroth(dot)de>
```
