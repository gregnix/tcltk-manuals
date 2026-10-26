---
CommandName: doctools::nroff::man_macros
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - doctools
 - export
 - macros
 - man_macros
 - nroff
 - plugin
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::nroff::man_macros – Definition des nroff-man-Makrosatzes für NROFF-Export-Plugins

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::nroff::man_macros]{.lit} [0.2]{.optlit} 
[::doctools::nroff::man_macros::contents]{.cmd} 
:::

# BESCHREIBUNG

Dieses Paket stellt einen einzigen Befehl bereit, der Zugriff auf die Definition des nroff-*man*-Makrosatzes gewährt, der für das von den verschiedenen NROFF-Export-Plugins generierte NROFF-Markup verwendet werden soll.

Hierbei handelt es sich um ein internes Paket von doctools, das für *Export*-Plugins bestimmt ist, d. h. für die Pakete, die doctools-bezogene Dokumentation in andere Formate konvertieren, insbesondere *nroff*.

# API

**::doctools::nroff::man_macros::contents**
: Dieser Befehl gibt den Text der Definition des nroff-*man*-Makrosatzes zurück, der für das von den verschiedenen NROFF-Export-Plugins erzeugte NROFF-Markup verwendet werden soll.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
