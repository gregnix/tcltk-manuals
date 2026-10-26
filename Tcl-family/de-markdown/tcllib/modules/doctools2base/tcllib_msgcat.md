---
CommandName: doctools::msgcat
title: doctools::msgcat
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - catalog package
 - docidx
 - doctoc
 - doctools
 - i18n
 - internationalization
 - l10n
 - localization
 - message catalog
 - message package
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::msgcat – Verwaltung der Nachrichtenkataloge für die verschiedenen Dokumentenparser

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [msgcat]{.lit}
[package]{.cmd} [require]{.sub} [doctools::msgcat]{.lit} [0.2]{.optlit}
[::doctools::msgcat::init]{.cmd} [prefix]{.arg}
:::

# Beschreibung

Das Paket **doctools::msgcat** ist ein Unterstützungsmodul, das die Auswahl von Nachrichtenkatalogen für die verschiedenen Dokumentenverarbeitungspakete im doctools-System der Version 2 übernimmt. Als solches handelt es sich um ein internes Paket, mit dem ein normaler Benutzer (Entwickler) nicht in direkten Kontakt kommen sollte.

Wenn Sie zu dieser Gruppe gehören, lesen Sie bitte die Dokumentation zu einem der folgenden Pakete:

1. **doctools::doc**,

2. **doctools::toc**, oder

3. **doctools::idx**


Innerhalb der Systemarchitektur liegt dieses Paket unter den verschiedenen Parser-Paketen und wird von ihnen gemeinsam genutzt. Darunter liegen die Pakete, die die Nachrichtenkataloge für die verschiedenen Sprachen bereitstellen; sie sind jedoch keine expliziten Abhängigkeiten.

# API

**::doctools::msgcat::init** *prefix*
: Der Befehl sucht die Nachrichtenkataloge für alle von **msgcat::mcpreferences** zurückgegebenen Sprachen und lädt sie, sofern sie gefunden werden konnten. Er gibt eine ganze Zahl zurück, die angibt, wie viele Pakete gefunden und geladen wurden.

    Die Namen der Pakete, nach denen der Befehl sucht, haben die Form „doctools::msgcat::*prefix*::**langcode**“, wobei *prefix* das Argument des Befehls ist und der Wert **langcode** aus dem Ergebnis von **msgcat::mcpreferences** stammt.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Dokumentationswerkzeuge

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
