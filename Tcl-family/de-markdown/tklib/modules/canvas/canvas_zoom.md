---
CommandName: canvas::zoom
ManualSection: n
Version: 0.2.1
TclPart: tklib
TclDescription: Variations on a canvas
Keywords:
 - zoom
Copyright:
---

# NAME

canvas::zoom – Zoom-Steuerung für canvas::sqmap

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [Tk]{.lit} [8.4]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [uevent::onidle]{.lit} 
[package]{.cmd} [require]{.sub} [canvas::zoom]{.lit} [0.2.1]{.optlit} 
[::canvas::zoom]{.cmd} [pathName]{.arg} [options]{.optarg} 
:::

# BESCHREIBUNG

Dieses Paket enthält ein Widget, mit dem der Benutzer einer Kartenanzeige den Zoomfaktor steuern kann.

# API

**::canvas::zoom** *pathName* ?options?
: Erstellt das Zoom-Steuerelement *pathName* und konfiguriert es. Die vom neuen Widget unterstützten Methoden und Optionen werden in den folgenden Abschnitten beschrieben. Das Ergebnis des Befehls ist *pathName*.


## Optionen

**-orient**
: Der Wert für diese Option lautet entweder **vertical** oder **horizontal** und legt die Ausrichtung der Hauptachse des Widgets fest. Der Standardwert ist **vertical**.

**-levels**
: Der Wert für diese Option ist eine nicht-negative ganze Zahl. Er legt die Anzahl der zu unterstützenden Zoomstufen fest.

**-variable**
: Der Wert für diese Option ist der Name einer globalen oder einer in einem Namespace definierten Variable, die mit dem Widget verknüpft ist. Änderungen der Zoomstufe, die am Widget vorgenommen werden, werden an diese Variable weitergegeben, und umgekehrt werden Änderungen an der Variablen in das Widget übernommen.

**-command**
: Diese Option legt ein Befehlspräfix fest. Diese Rückruffunktion wird immer dann aufgerufen, wenn sich die Zoomstufe ändert. Sie wird mit zwei zusätzlichen Argumenten aufgerufen: dem Zoom-Widget und der neuen Zoomstufe, in dieser Reihenfolge.


## Methoden

Das Widget unterstützt keine Methoden, die über die Standardmethoden (**configure**, **cget** usw.) hinausgehen.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Dieses Dokument und das darin beschriebene Paket enthalten zweifellos Fehler und andere Probleme. Bitte melden Sie diese in der Kategorie *canvas* der [Tklib-Tracker](http://core.tcl-lang.org/tklib/reportlist). Bitte melden Sie dort auch Ihre Ideen für Verbesserungen am Paket oder an der Dokumentation.
