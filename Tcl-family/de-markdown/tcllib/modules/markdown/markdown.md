---
CommandName: markdown
title: markdown
ManualSection: n
Version: 1.2.4
TclPart: tcllib
TclDescription: Markdown to HTML Converter
Copyright:
---

# Name

markdown – Konvertiert Markdown-Text in HTML

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [Markdown]{.lit} [1.2.4]{.lit}
[package]{.cmd} [require]{.sub} [textutil]{.lit} [0.8]{.optlit}
[::Markdown::convert]{.cmd} [markdown]{.arg}
[::Markdown::register]{.cmd} [langspec]{.arg} [converter]{.arg}
[::Markdown::get\_lang\_counter]{.cmd}
[::Markdown::reset\_lang\_counter]{.cmd}
:::

# Beschreibung

Das Paket **Markdown** bietet einen Befehl, um mit Markdown formatierten Text in HTML umzuwandeln.

**::Markdown::convert** *markdown*
: Dieser Befehl nimmt einen Markdown-Textblock entgegen und gibt einen HTML-Block zurück.

    Der Konverter unterstützt zwei Arten der Syntaxhervorhebung für umschlossene Code-Blöcke: Hervorhebung über einen registrierten Konverter (siehe **::Markdown::register**) oder reine JavaScript-Hervorhebung, z. B. über „highlight.js“, wobei der im Markup verwendete Sprachbezeichner als CSS-Klasse des „code“-Elements im zurückgegebenen Markup festgelegt wird.

**::Markdown::register** *langspec* *converter*
: Registriert einen sprachspezifischen Konverter zur Aufbereitung eines Codeblocks (z. B. Syntaxhervorhebung). Markdown unterstützt umschlossene Codeblöcke mit einer optionalen Sprachangabe (z. B. „tcl“). Wenn der Markdown-Parser einen solchen Code-Block verarbeitet und ein Konverter für die angegebene Sprachangabe registriert ist, wird der Konverter mit dem rohen Code-Block als Argument aufgerufen. Der Konverter soll als Ergebnis die Markup-Darstellung des Code-Blocks geben. Der angegebene Konverter kann ein beliebiger Tcl-Befehl sein; der rohe Textblock wird beim Aufruf als letztes Argument hinzugefügt.

**::Markdown::get\_lang\_counter**
: Gibt ein Wörterbuch zurück, das den Sprachbezeichner und die Anzahl der Vorkommen in umschlossenen Codeblöcken enthält. Diese Funktion kann beispielsweise verwendet werden, um festzustellen, ob bestimmte CSS- oder JavaScript-Header für die Darstellung eingebunden werden sollen, ohne dass das gerenderte Ergebnis nachbearbeitet werden muss.

**::Markdown::reset\_lang\_counter**
: Setzt die Sprachzähler zurück.


# Unterstützte Markdown-Syntax

Dieser Markdown-Konverter unterstützt das ursprüngliche Markdown von Gruber und Swartz (weitere Informationen finden Sie auf deren [syntax](https://daringfireball.net/projects/markdown/syntax) Seite):

- Absätze

- Header im ATX- und Setext-Stil

- Zitate

- Hervorhebung und starke Hervorhebung

- ungeordnete und geordnete Listen

- Inline-Links, Referenz-Links und automatische Links

- Inline- und Referenzbilder

- Inline-Code

- Code-Blöcke (mit vier Einrückungszeichen oder einem Tabulator)

- Inline-HTML

- Backslash-Escape-Zeichen

- horizontale Linien


Darüber hinaus wird die folgende erweiterte Markdown-Syntax unterstützt, die aus [PHP Markdown Extra](https://michelf.ca/projects/php-markdown/extra/) und [GFM (Github Flavoured Markdown)](https://github.github.com/gfm/) stammt:

- Pipe-Tabellen

- eingeschlossene Code-Blöcke (mit optionalem Sprachbezeichner)


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *textutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Textverarbeitung
