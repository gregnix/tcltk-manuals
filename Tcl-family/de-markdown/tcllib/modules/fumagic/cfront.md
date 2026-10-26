---
CommandName: fileutil::magic::cfront
ManualSection: n
Version: 1.3.3
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

fileutil::magic::cfront – Generatorkern für den Compiler von magic(5)-Dateien

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil::magic::cfront]{.lit} [1.3.3]{.optlit} 
[package]{.cmd} [require]{.sub} [fileutil::magic::cgen]{.lit} [1.2.0]{.optlit} 
[package]{.cmd} [require]{.sub} [fileutil::magic::rt]{.lit} [1.2.0]{.optlit} 
[package]{.cmd} [require]{.sub} [struct::list]{.lit} 
[package]{.cmd} [require]{.sub} [fileutil]{.lit} 
[::fileutil::magic::cfront::compile]{.cmd} [path...]{.arg} 
[::fileutil::magic::cfront::generate]{.cmd} [compressed boolean]{.optarg} -- [path...]{.arg} 
[::fileutil::magic::cfront::install]{.cmd} [path...]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt das Frontend eines Compilers bereit, der magic(5)-Dateien in Erkenner auf der Grundlage des Erkenner-Laufzeitpakets **fileutil::magic::rt** umwandelt. Zum Generator-Backend dieses Compilers siehe das Paket **fileutil::magic::cgen**.

# BEFEHLE

**::fileutil::magic::cfront::compile** *path*...
: Dieser Befehl nimmt die Pfade einer oder mehrerer Dateien und Verzeichnisse und kompiliert alle diese Dateien sowie die Dateien in allen Verzeichnissen zu einem einzigen Analysator für alle in diesen Dateien angegebenen Dateitypen. Er gibt eine Liste zurück, deren erstes Element eine Liste von Dictionarys je Datei mit Analysatorskripten ist und deren zweites Element eine Liste von Analysatorbefehlen. Alle Dateien müssen im Format von magic(5) vorliegen. Das Ergebnis des Befehls ist ein Tcl-Skript, das den erzeugten Erkenner enthält.

**::fileutil::magic::cfront::generate** ?*compressed*
: **boolean**? -- *path*... Dieser Befehl verhält sich hinsichtlich der angegebenen *path*-Argumente wie **::fileutil::magic::cfront::compile**, packt das entstehende Erkenner-Skript dann in eine Variable namens **named** und eine Prozedur namens **analyzer** und gibt das entstehende Skript zurück. Das Argument *compressed* hat die Vorgabe **boolean** **true**, das heißt, Leerzeichen im zurückgegebenen Skript werden minimiert. Das Argument *--* ist immer erforderlich.

**::fileutil::magic::cfront::install** *path*...
: Dieser Befehl verhält sich hinsichtlich der angegebenen Pfadargumente wie **::fileutil::magic::cfront::compile**. Er erzeugt mit **::fileutil::magic::cfront::generate** ein Erkenner-Skript und wertet dieses Skript im aktuellen Interpreter aus, damit der Befehl **::fileutil::magic::filetype** es verwendet.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *fileutil :: magic* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Programmierwerkzeuge
