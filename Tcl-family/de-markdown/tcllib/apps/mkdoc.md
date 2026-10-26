---
CommandName: mkdoc
ManualSection: n
Version: 0.7.0
TclPart: tcllib
TclDescription: Source code documentation using Markdown
Copyright:
 - Copyright (c) 2019-2022, Detlef Groth <detlef(at)dgroth(dot)de>
---

# NAME

mkdoc – Anwendung zum Extrahieren und Konvertieren von Quellcode-Dokumentation

# ÜBERSICHT

::: {.synopsis} :::
[mkdoc]{.cmd} [--help]{.sub} 
[mkdoc]{.cmd} [--version]{.sub} 
[mkdoc]{.cmd} [--license]{.sub} 
[mkdoc]{.cmd} [input]{.arg} [output]{.arg} [--css cssfile]{.optarg} 
:::

# BESCHREIBUNG

Dieses Dokument beschreibt **mkdoc**, eine Anwendung zum Extrahieren von Dokumentation, die in Quellcode-Dateien eingebettet ist, seien es „*.tcl*“-Dateien oder andere.

# BEFEHLSZEILE

**mkdoc** **--help**
: Die Anwendung gibt eine kurze Hilfe auf die Standardausgabe aus und beendet sich.

**mkdoc** **--version**
: Die Anwendung gibt ihre Versionsnummer auf der Standardausgabe aus und wird beendet.

**mkdoc** **--license**
: Die Anwendung gibt ihre Lizenz auf der Standardausgabe aus und wird beendet.

**mkdoc** *input* *output* ?**--css** *cssfile*?
: Die Anwendung liest die Datei *input* ein, extrahiert die darin enthaltene Dokumentation und schreibt sie in die Datei *output*. Wenn die Ausgabedatei nicht die Endung „*.md*“ hat, wird die extrahierte Dokumentation vor dem Schreiben in HTML konvertiert. Wenn die Generierung und das Schreiben von HTML erfolgen, kann das Standard-CSS-Stylesheet überschrieben werden, indem über die Option **--css** der Pfad zu einem benutzerdefinierten Stylesheet festgelegt wird. Wenn die Eingabedatei eine „*.md*“-Datei ist, wird erwartet, dass sie Markdown im Originalformat enthält, anstatt in Code eingebettetes Markdown. Wenn die Datei hingegen als Code betrachtet wird, wird erwartet, dass die Dokumentation in allen Zeilen enthalten ist, die mit dem Marker **#'** beginnen. Bei Skriptsprachen wie Tcl bedeutet das Zeichen **#** dieses Markers, dass die Dokumentation in den entsprechend gekennzeichneten Kommentaren enthalten ist. Bei anderen Sprachen müssen der Marker und die Dokumentation möglicherweise in mehrzeilige Kommentare eingebettet werden.


# BEISPIELE

```
    # Create HTML manual for a CPP file using a custom style sheet
    mkdoc sample.cpp sample.html --css manual.css

    # Extract the documentation from code as simple Markdown, ready to be processed
    # further, for example with pandoc, or similar
    mkdoc sample.cpp sample.md

    # Convert a Markdown file to HTML
    mkdoc sample.md sample.html
```

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
Copyright (c) 2019-2022, Detlef Groth <detlef(at)dgroth(dot)de>
```
