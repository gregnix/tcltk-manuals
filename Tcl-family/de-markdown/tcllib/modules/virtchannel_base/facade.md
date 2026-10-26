---
CommandName: tcl::chan::facade
ManualSection: n
Version: 1.1
TclPart: tcllib
TclDescription: Reflected/virtual channel support
Keywords:
 - concatenation channel
 - reflected channel
 - tip 219
 - virtual channel
Copyright:
 - Copyright (c) 2011 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

tcl::chan::facade – Fassadenkanal

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [TclOO]{.lit} 
[package]{.cmd} [require]{.sub} [logger]{.lit} 
[package]{.cmd} [require]{.sub} [tcl::chan::core]{.lit} [1.1]{.optlit} 
[package]{.cmd} [require]{.sub} [tcl::chan::facade]{.lit} [1.1]{.optlit} 
[::tcl::chan::facade]{.cmd} [chan]{.arg} 
:::

# BESCHREIBUNG

Das Paket **tcl::chan::facade** stellt einen Befehl zur Verfügung, mit dem Fassaden für andere Kanäle erstellt werden können. Dabei handelt es sich um Kanäle, die einen einzigen untergeordneten Kanal besitzen und alle Vorgänge an diesen weiterleiten.

Fassaden dienen in erster Linie der Fehlerbehebung bei Aktionen auf einem Kanal. Zwar könnten die meisten Informationen durch eine virtuelle Kanal-Transformation nachverfolgt werden, doch hat diese keinen Zugriff auf die ereignisbezogenen Operationen; zudem sind sie nur in Tcl 8.6 verfügbar.

Daher handelt es sich hierbei um einen Kanal, der mit Tcl 8.5 genutzt werden kann und Zugriff auf alle Vorgänge innerhalb eines Kanals bietet.

Die auf dem Kanal abgefangenen Aktionen werden über das Paket **logger** protokolliert.

Darüber hinaus bieten die Fassaden die folgenden zusätzlichen Konfigurationsoptionen für Kanäle:

**-self**
: Das TclOO-Objekt, das die Fassade verwaltet.

**-fd**
: Der Griff des untergeordneten, d. h. umwickelten Kanals.

**-used**
: Der Zeitpunkt, zu dem der verpackte Kanal zuletzt von der Fassade gelesen oder beschrieben wurde, gemäß **clock milliseconds**. Der Wert **0** bedeutet, dass auf den untergeordneten Kanal bisher noch gar nicht zugegriffen wurde.

**-created**
: Der Zeitpunkt der Erstellung der Fassade gemäß **clock milliseconds**.

**-user**
: Ein frei definierbarer Wert, der den Nutzer der Fassade und den damit verbundenen Kanal identifiziert. Von diesen ist lediglich die Option **-user** beschreibbar.


# API

**::tcl::chan::facade** *chan*
: Dieser Befehl erstellt den Fassadenkanal um den angegebenen Kanal *chan* herum und gibt dessen Handle zurück.


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
