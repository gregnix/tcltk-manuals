---
CommandName: doctools::msgcat::idx::de
title: doctools::msgcat::idx::de
ManualSection: n
Version: 0.1
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - DE
 - catalog package
 - docidx
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

doctools::msgcat::idx::de – Nachrichtenkatalog für den docidx-Parser (DE)

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [msgcat]{.lit}
[package]{.cmd} [require]{.sub} [doctools::msgcat::idx::de]{.lit} [0.1]{.optlit}
:::

# Beschreibung

Das Paket **doctools::msgcat::idx::de** ist ein Unterstützungsmodul, das den deutschsprachigen (DE) Nachrichtenkatalog für den docidx-Parser im doctools-System der Version 2 bereitstellt. Als solches handelt es sich um ein internes Paket, mit dem ein normaler Benutzer (Entwickler) nicht in direkten Kontakt kommen sollte.

Wenn Sie zu dieser Gruppe gehören, lesen Sie bitte die Dokumentation zu einem der folgenden Pakete:

1. **doctools::doc**,

2. **doctools::toc**, oder

3. **doctools::idx**


Innerhalb der Systemarchitektur liegt dieses Paket unter dem Paket **doctools::msgcat**, das die allgemeine Verwaltung der Nachrichtenkataloge im System übernimmt. *Hinweis*: Zwischen dem Manager-Paket und den Katalogpaketen besteht *keine* explizite Abhängigkeit. Der Katalog ist ein Plugin, das dynamisch ausgewählt und geladen wird.

# API

Dieses Paket verfügt über keine exportierte API.

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
