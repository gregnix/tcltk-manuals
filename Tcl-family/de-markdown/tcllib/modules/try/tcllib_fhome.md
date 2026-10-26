---
CommandName: file::home
title: file::home
ManualSection: n
Version: 1
TclPart: tcllib
TclDescription: Forward compatibility implementation of [file home]
Copyright:
 - Copyright (c) 2024 Andreas Kupries, BSD licensed
---

# Name

file::home – file home – Das Home-Verzeichnis des aktuellen oder eines anderen Benutzers gibt zurück

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.x]{.lit}
[package]{.cmd} [require]{.sub} [fhome]{.lit} [1]{.optlit}
[file]{.cmd} [home]{.lit} [user]{.optarg}
:::

# Beschreibung

Dieses Paket bietet eine Paket-Implementierung des Tcl-9-Unterbefehls [file home](https://www.tcl-lang.org/man/tcl/TclCmd/file.html) (TIP 602) für Tcl 8.x.

**file** **home** ?*user*?
: Gibt das Home-Verzeichnis des aktuellen Benutzers oder, wenn angegeben, des angegebenen *Benutzers* zurück.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *file* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Hilfsprogramme

# Copyright

```
Copyright (c) 2024 Andreas Kupries, BSD licensed
```
