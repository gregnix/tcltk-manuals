---
CommandName: doctools::html::cssdefaults
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - CSS
 - HTML
 - doctools
 - export
 - plugin
 - style
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::html::cssdefaults – Standard-CSS-Stil für HTML-Export-Plugins

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::html::cssdefaults]{.lit} [0.2]{.optlit} 
[::doctools::html::cssdefaults::contents]{.cmd} 
:::

# BESCHREIBUNG

Dieses Paket stellt einen einzigen Befehl bereit, der den Zugriff auf den Text des Standard-CSS-Stils ermöglicht, der für das von den verschiedenen HTML-Export-Plugins erzeugte HTML-Markup verwendet werden soll.

Hierbei handelt es sich um ein internes Paket von doctools, das für *Export*-Plugins bestimmt ist, d. h. für die Pakete, die doctools-bezogene Dokumentation in andere Formate konvertieren, insbesondere in *HTML*.

# API

**::doctools::html::cssdefaults::contents**
: Dieser Befehl gibt den Text des Standard-CSS-Stils zurück, der für das von den verschiedenen HTML-Export-Plugins generierte HTML-Markup verwendet werden soll.


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
