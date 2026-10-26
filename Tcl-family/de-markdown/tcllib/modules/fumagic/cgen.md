---
CommandName: fileutil::magic::cgen
ManualSection: n
Version: 1.2.0
TclPart: tcllib
TclDescription: file utilities
Links:
 - file(1)
 - fileutil
 - magic(5)
Keywords:
 - file recognition
 - file type
 - file utilities
 - mime
 - type
Copyright:
---

# NAME

fileutil::magic::cgen – Generatorkern für den Compiler von magic(5)-Dateien

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil::magic::cgen]{.lit} [1.2.0]{.optlit} 
[package]{.cmd} [require]{.sub} [fileutil::magic::rt]{.lit} [1.2.0]{.optlit} 
[package]{.cmd} [require]{.sub} [struct::tree]{.lit} 
[package]{.cmd} [require]{.sub} [struct::list]{.lit} 
[::fileutil::magic::cgen::2tree]{.cmd} [script]{.arg} 
[::fileutil::magic::cgen::treedump]{.cmd} [tree]{.arg} 
[::fileutil::magic::cgen::treegen]{.cmd} [tree]{.arg} [node]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt das Generator-Backend eines Compilers bereit, der magic(5)-Dateien in Erkenner auf der Grundlage des Erkenner-Laufzeitpakets **fileutil::magic::rt** umwandelt. Zum Compiler-Frontend, das diesen Generator verwendet, siehe das Paket **fileutil::magic::cfront**.

# BEFEHLE

**::fileutil::magic::cgen::2tree** *script*
: Dieser Befehl wandelt den durch das *script* angegebenen Erkenner in einen Baum um und gibt den Objektbefehl dieses Baums als Ergebnis zurück. Der Baum kommt aus dem Paket **struct::tree**. Das *script* hat das in magic(5) festgelegte Format.

**::fileutil::magic::cgen::treedump** *tree*
: Dieser Befehl nimmt einen von **::fileutil::magic::cgen::2tree** erzeugten *tree* und gibt eine Zeichenkette zurück, die den Baum für Menschen lesbar kodiert, als Hilfe bei der Fehlersuche.

**::fileutil::magic::cgen::treegen** *tree* *node*
: Dieser Befehl nimmt einen von **::fileutil::magic::cgen::2tree** erzeugten *tree* und gibt ein Tcl-Skript zurück, den Erkenner für die Dateitypen, die der am *node* gewurzelte Teilbaum darstellt. Das erzeugte Skript verwendet ausgiebig die Befehle des Erkenner-Laufzeitpakets **fileutil::magic::rt**.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *fileutil :: magic* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge
