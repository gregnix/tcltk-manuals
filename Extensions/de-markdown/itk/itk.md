---
CommandName: itk
title: itk
ManualSection: n
Version: 3.0
TclPart: itk
TclDescription: "[incr Tk]"
Keywords:
 - class
 - object
 - object-oriented
 - mega-widget
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

itk - Rahmen für den Bau von Megawidgets in Tcl/Tk

# Beschreibung

Megawidgets sind Widgets auf hoher Ebene, die aus Tk-Widgets als Komponenten gebaut werden, gewöhnlich ohne C-Code. Eine Dateiauswahlbox kann zum Beispiel einige Listboxen, einige Entry-Widgets und einige Steuerschaltflächen enthalten. Diese einzelnen Widgets werden so zusammengesetzt, dass sie wie ein großes Widget wirken. Ein Megawidget für eine Dateiauswahlbox lässt sich mit einem Befehl wie diesem erzeugen:

```
fileselectionbox .fsb -background blue -foreground white
```

Sobald es erzeugt ist, lässt es sich mit einem Befehl wie diesem neu konfigurieren:

```
.fsb configure -background green -foreground black
```

und alle seine internen Komponenten ändern die Farbe. Jedes Megawidget hat eine Menge von Methoden, mit denen es sich bedienen lässt. Die aktuelle Auswahl lässt sich aus einer Dateiauswahlbox zum Beispiel so abfragen:

```
set fileName [.fsb get]
```

Im Ergebnis sieht ein Megawidget aus und verhält sich genau wie ein Tk-Widget, lässt sich aber erheblich leichter umsetzen.

**\[incr Tk\]** ist ein Rahmen für den Bau von Megawidgets. Es verwendet **\[incr Tcl\]**, um das Objektparadigma zu unterstützen, und fügt Basisklassen hinzu, die das voreingestellte Widget-Verhalten liefern.

Alle Widgets von **\[incr Tk\]** sind von der Basisklasse [Archetype] abgeleitet. Diese Klasse verwaltet interne Komponenten-Widgets und stellt Methoden wie „configure“ und „cget“ bereit, mit denen sich auf Konfigurationsoptionen zugreifen lässt.

Die Basisklasse [Widget] erbt alles von [Archetype] und fügt einen Tk-Frame hinzu, der als Container für das Megawidget dient. Sie wird verwendet, um Megawidgets zu bauen, die in anderen Frames und Toplevel-Fenstern sitzen. Abgeleitete Klassen erzeugen weitere interne Komponenten und packen sie in den Frame „hull“, den die Basisklasse [Widget] erzeugt.

Die Basisklasse [Toplevel] erbt alles von [Archetype], fügt aber ein Tk-Toplevel hinzu, das als Container für das Megawidget dient. Sie wird verwendet, um Megawidgets wie Dialogfenster zu bauen, die ein eigenes Toplevel-Fenster haben. Abgeleitete Klassen erzeugen weitere interne Komponenten und packen sie in das Toplevel „hull“, das die Basisklasse [Toplevel] erzeugt.

# Bibliothek \[incr Widgets\]

**\[incr Widgets\]** ist eine Megawidget-Bibliothek, die mit **\[incr Tk\]** gebaut ist. Sie lässt sich sofort einsetzen und enthält mehr als 30 verschiedene Widget-Klassen, darunter:

-
: fileselectiondialog

-
: tabnotebook

-
: panedwindow

-
: combobox

-
: optionmenu

-
: scrolledlistbox

-
: scrolledframe

-
: messagedialog

-
: und viele weitere ...


Die Demo **catalog** im Verzeichnis „iwidgets/demos“ zeigt alle verfügbaren Widgets in Aktion. Jede Widget-Klasse hat eine eigene Handbuchseite, die die verfügbaren Merkmale beschreibt.


[Archetype]: Archetype.md
[Toplevel]: Toplevel.md
[Widget]: Widget.md
