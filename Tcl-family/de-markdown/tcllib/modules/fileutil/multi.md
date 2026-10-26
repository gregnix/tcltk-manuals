---
CommandName: fileutil::multi
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: file utilities
Keywords:
 - copy
 - file utilities
 - move
 - multi-file
 - remove
Copyright:
---

# NAME

fileutil::multi – Bearbeitung mehrerer Dateien, Scatter/Gather, Standardobjekt

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil::multi]{.lit} [0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [fileutil::multi::op]{.lit} [0.5.4]{.optlit} 
[package]{.cmd} [require]{.sub} [wip]{.lit} [1.1]{.optlit} 
[::fileutil::multi]{.cmd} [word]{.optdot} 
:::

# BESCHREIBUNG

Dieses Paket bietet einen einzigen Befehl, um Aktionen an mehreren Dateien durchzuführen, die anhand von Glob-Mustern ausgewählt wurden. Es handelt sich um eine dünne Schicht über dem Paket **fileutil::multi::op**, das Objekte für denselben Zweck bereitstellt. Dieses Paket erstellt lediglich ein einziges solches Objekt und leitet alle Dateibefhle an dieses weiter.

Im Mittelpunkt steht eine domänenspezifische Sprache, die die einfache Spezifizierung von Operationen zum Kopieren und/oder Verschieben und/oder Löschen mehrerer Dateien ermöglicht. Alternative Namen wären „Scatter/Gather-Prozessor“ oder vielleicht sogar „Assembler“. Die detaillierte Spezifikation dieser Sprache sowie Beispiele finden Sie in der Dokumentation zum Paket **fileutil::multi::op**.

# ÖFFENTLICHE API

Der Hauptbefehl des Pakets lautet:

**::fileutil::multi** ?*word*...?
: Dieser Befehl interpretiert die angegebenen Wörter als auszuführende Dateibefehle. Informationen zu den zulässigen Befehlen, ihrer Syntax und Semantik finden Sie im Abschnitt **FILE API** der Dokumentation zum Paket **fileutil::multi::op**. Das Ergebnis des Befehls ist das Ergebnis des zuletzt ausgeführten Dateibefehls.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *fileutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge
