---
CommandName: pieBoxLabeler
ManualSection: n
Version: 6.6
TclPart: tklib
TclDescription: pieBoxLabeler class
Links:
 - canvasLabel
 - pie
 - piePeripheralLabeler
Keywords:
 - canvas
 - labeler
 - pie
 - slice
Copyright:
 - Copyright (c) 1995-2004 Jean-Luc Fontaine <jfontain@free.fr>
---

# NAME

pieBoxLabeler – Labeler-Klasse von tkpiechart im Kastenstil

# ÜBERSICHT

::: {.synopsis} :::
[stooop::new]{.cmd} [pieBoxLabeler]{.sub} [canvas]{.arg} [options]{.optarg} 
[switched::configure]{.cmd} [pieBoxLabelerObject]{.arg} [options]{.optarg} 
[switched::cget]{.cmd} [pieBoxLabelerObject]{.arg} [option]{.arg} 
:::

# BESCHREIBUNG

Das Labeler-Objekt im Kastenstil setzt die Segmentbeschriftungen eines Objekts **pie** und wird dem Konstruktor von pie über die Option **-labeler** übergeben. Siehe die Handbuchseite der Klasse **pie**.

Die Beschriftungen stehen in 2 Spalten unter der Kreisdiagrammgrafik. Jeder Beschriftungstext steht rechts von einem Rechteck, dessen Hintergrundfarbe zum zugehörigen Segment passt. Der Anteilswert des Segments steht rechts vom Beschriftungstext, getrennt durch ein Semikolon. Jede Beschriftung ist ein canvasLabel-Objekt. Weitere Angaben stehen auf der Handbuchseite der Klasse **canvasLabel**.

Ein Objekt **pieBoxLabeler** muss nicht gelöscht werden. Die Klasse pie erledigt das.

**stooop::new** **pieBoxLabeler** *canvas* ?options?
: Erzeugt ein pieBoxLabeler-Objekt im angegebenen Tk-Canvas. Zurückgegeben wird der Objektbezeichner, in diesem Dokument *pieBoxLabelerObject*.

**switched::configure** *pieBoxLabelerObject* ?options?
: Konfiguriert ein pieBoxLabeler-Objekt oder gibt alle Optionen mit ihren aktuellen Werten zurück, wenn keine Optionen übergeben werden.

**switched::cget** *pieBoxLabelerObject* *option*
: Gibt einen Optionswert des angegebenen pieBoxLabeler-Objekts zurück.


# OPTIONEN

**-font** value
: Eine Schrift für die Segmentbeschriftungen. Fehlt die Angabe, ist die Schrift systemabhängig.

**-justify** value
: Ausrichtung der Beschriftungen in der eigenen Spalte. Einer von *left*, *center* oder *right*. Voreingestellt ist *left*. Ist die Ausrichtung *right*, fluchten die rechten Kanten aller Spaltenbeschriftungen.

**-offset** value
: Abstand zwischen der Kreisdiagrammgrafik und der nächsten Segmentbeschriftung. Der Wert hat eine der Formen aus dem Abschnitt *KOORDINATEN* der Handbuchseite **canvas**.


# TAGS

Der Labeler hat das folgende besondere Tag. Einzelheiten stehen auf der Handbuchseite **canvas** im Abschnitt *ITEM-IDS UND TAGS*:

**•**
: pieBoxLabeler(pieBoxLabelerObject)


# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *tkpiechart* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.

# COPYRIGHT

```
Copyright (c) 1995-2004 Jean-Luc Fontaine <jfontain@free.fr>
```
