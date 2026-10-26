---
CommandName: mpexpand
ManualSection: n
Version: 1.0
TclPart: tcllib
TclDescription: Documentation toolbox
Links:
 - expander(n)
 - format(n)
 - formatter(n)
Keywords:
 - HTML
 - TMML
 - conversion
 - manpage
 - markup
 - nroff
Copyright:
 - Copyright (c) 2002 Andreas Kupries <andreas_kupries@users.sourceforge.net>
 - Copyright (c) 2003 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

mpexpand – Markup-Prozessor

# ÜBERSICHT

::: {.synopsis} :::
[mpexpand]{.cmd} [-module module]{.optarg} [format]{.arg} [infile|-]{.arg} [outfile|-]{.arg} 
[mpexpand.all]{.cmd} [-verbose]{.optarg} [module]{.optarg} 
:::

# BESCHREIBUNG

Diese Manpage beschreibt einen Prozessor bzw. Konverter für Manpages im doctools-Format, wie in **doctools_fmt** festgelegt. Der Prozessor basiert auf dem Paket **doctools**.

**mpexpand** ?-module *module*? *format* *infile*|- *outfile*|-
: Der Prozessor nimmt drei Argumente entgegen: den Code, der beschreibt, welche Formatierung als Ausgabe erzeugt werden soll, die Datei, aus der die Auszeichnung gelesen wird, und die Datei, in die die erzeugte Ausgabe geschrieben wird. Wenn *infile* „**-**“ ist, liest der Prozessor von **stdin**. Wenn *outfile* „**-**“ ist, schreibt der Prozessor nach **stdout**. Wenn die Option *-module* vorhanden ist, überschreibt ihr Wert die interne Definition des Modulnamens. Die derzeit bekannten Ausgabeformate sind


**nroff**
: Der Prozessor erzeugt eine \*roff-Ausgabe, das Standardformat für Unix-Manpages.

**html**
: Der Prozessor erzeugt HTML-Ausgabe zur Verwendung in Webbrowsern und zur Anzeige durch sie.

**tmml**
: Der Prozessor erzeugt TMML-Ausgaben, die Tcl Manpage Markup Language, eine Ableitung von XML.

**latex**
: Der Prozessor erzeugt eine LaTeX-Ausgabe.

**wiki**
: Der Prozessor erzeugt Wiki-Markup, wie es **wikit** versteht.

**list**
: Der Prozessor extrahiert die von **manpage_begin** bereitgestellten Informationen.

**null**
: Der Prozessor erzeugt keine Ausgabe.


**mpexpand.all** ?*-verbose*? ?*module*?
: Dieser Befehl verwendet **mpexpand**, um alle möglichen Ausgabeformate für alle Manpages im aktuellen Verzeichnis zu generieren. Die Manpages werden anhand der Erweiterung „*.man*“ erkannt. Wenn *-verbose* angegeben ist, listet der Befehl seine Aktionen auf, bevor er sie ausführt. Die *module*-Angabe wird an **mpexpand** übergeben.


# HINWEISE

Mögliche zukünftige Formate sind Klartext, PDF und PostScript.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2002 Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2003 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
