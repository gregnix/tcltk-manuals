---
CommandName: debug::caller
title: debug::caller
ManualSection: n
Version: 1.2
TclPart: tcllib
TclDescription: debug narrative
Keywords:
 - debug
 - log
 - narrative
 - trace
Copyright:
 - Copyright (c) 2012-2015, Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

debug::caller – Debug-Erzählung – Aufrufer

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [debug::caller]{.lit} [1.2]{.optlit}
[debug]{.cmd} [caller]{.lit} [args...]{.optarg}
:::

# Beschreibung

# API

[debug] **caller** ?*args*...?
: Diese Methode ist nützlich, um in einem tag-spezifischen Präfix automatisch Aufruferinformationen für alle Verwendungen des Tags bereitzustellen. Oder in einer Nachricht, wenn nur bestimmte Plätze solche Details benötigen.

    Darüber hinaus erkennt sie die verschiedenen internen Formen von Aufrufen für Methoden, die vom OO-System **snit** generiert werden, und schreibt diese zur besseren Lesbarkeit in ihre ursprüngliche Form um. Gleiches gilt für **TclOO**.

    Wenn *args* festgelegt werden, werden diese als ganzzahlige Indizes von Befehlsargumenten behandelt, die in der Ausgabe *nicht* angezeigt werden sollen. Die betreffenden Argumente werden stattdessen durch **\*** ersetzt. Der wichtigste vorgesehene Anwendungsfall hierfür ist der Ausschluss von Argumenten, von denen erwartet wird, dass sie große Tcl-Werte enthalten, d. h. lange Listen, große Dictionarys usw., um zu verhindern, dass sie die Erzählung überfrachten.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *debug* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Debugging, Ablaufverfolgung und Protokollierung

# Copyright

```
Copyright (c) 2012-2015, Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[debug]: debug.md
