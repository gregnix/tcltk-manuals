---
CommandName: tcl::chan::std
ManualSection: n
Version: 1.2
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - reflected channel
 - standard io
 - stdin
 - stdout
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcl::chan::std – Standards-E/A, Zusammenführung von stdin und stdout

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::chan::core]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::chan::std]{.lit} [1.2]{.optlit} 
[::tcl::chan::std]{.cmd} 
:::

# BESCHREIBUNG

Das Paket **tcl::chan::std** stellt einen Befehl bereit, mit dem ein Standardkanal erstellt wird, der stdin und stdout zu einem einzigen les- und schreibbaren Kanal zusammenfasst. Das Ergebnis lässt sich nicht wie die ursprünglichen Standardkanäle durchsuchbar machen.

Die interne Klasse „**TclOO**“, die den Kanal-Handler implementiert, ist eine Unterklasse des Rahmens „**tcl::chan::core**“.

# API

**::tcl::chan::std**
: Dieser Befehl erstellt den Kanal „std“ und gibt dessen Handle zurück. Der Kanal wird nur einmal, beim ersten Aufruf, erstellt, und alle nachfolgenden Aufrufe geben lediglich dieses Handle zurück.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *virtchannel* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Kanäle

# COPYRIGHT

```
Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
