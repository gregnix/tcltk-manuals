---
CommandName: tcl::chan::halfpipe
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - callbacks
 - fifo
 - in-memory channel
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2009, 2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcl::chan::halfpipe – In-Memory-Kanal, eine Hälfte eines FIFO2

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::chan::events]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::chan::halfpipe]{.lit} [1.0.2]{.optlit} 
[::tcl::chan::halfpipe]{.cmd} [-option value]{.optdot} 
[objectCmd]{.ins} [put]{.sub} [bytes]{.arg} 
:::

# BESCHREIBUNG

Das Paket „**tcl::chan::halfpipe**“ stellt einen Befehl bereit, mit dem eine Hälfte eines „**tcl::chan::fifo2**“-Paares erstellt wird. Das Schreiben in einen solchen Kanal löst eine Reihe von Rückruffunktionen aus, die die Daten anschließend verarbeiten. Dies ähnelt einem Kanal-Handler, verfügt jedoch über eine wesentlich einfachere API.

Die interne Klasse „**TclOO**“, die den Kanal-Handler implementiert, ist eine Unterklasse des Rahmens „**tcl::chan::events**“.

# API

**::tcl::chan::halfpipe** ?**-option** *value*...?
: Dieser Befehl erstellt einen Halfpipe-Kanal und konfiguriert ihn mit den Rückruffunktionen, die ausgeführt werden sollen, wenn der Kanal geschlossen wird, Daten in ihn geschrieben wurden oder er leer ist. Eine Liste der Optionen und der zugehörigen Semantik finden Sie im Abschnitt **OPTIONEN**. Das Ergebnis des Befehls ist eine Liste mit zwei Elementen: dem Handle des neuen Kanals und dem Objektbefehl des Kanalhandlers, in dieser Reihenfolge. Letzteres wird dem Aufrufer übergeben, um ihm Zugriff auf die Methode **put** zum Hinzufügen von Daten zum Kanal zu gewähren. Zwei Halfpipes mit etwas Verbindungslogik in den Rückruffunktionen ergeben zusammen ein **tcl::chan::fifo2**.

*objectCmd* **put** *bytes*
: Diese Methode des Kanal-Handler-Objekts fügt die Daten *bytes* in den Kanal ein, sodass sie von dort gelesen werden können.


# OPTIONEN

**-close-command** cmdprefix
: Diese Rückruffunktion wird aufgerufen, wenn der Kanal geschlossen wird. Es wird ein einziges Argument übergeben: das Handle des Kanals, der geschlossen wird. Das Ergebnis der Rückruffunktion wird ignoriert.

**-write-command** cmdprefix
: Diese Rückruffunktion wird aufgerufen, wenn Daten in den Kanal geschrieben werden. Es werden zwei Argumente übergeben: das Handle des Kanals, in den geschrieben wird, und die geschriebenen Daten. Das Ergebnis der Rückruffunktion wird ignoriert.

**-empty-command** cmdprefix
: Diese Rückruffunktion wird aufgerufen, wenn der Kanal keine Daten mehr zum Lesen enthält. Es wird ein einziges Argument übergeben: das Handle des Kanals.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *virtchannel* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Kanäle

# COPYRIGHT

```
Copyright (c) 2009, 2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
