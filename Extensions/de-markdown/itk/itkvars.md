---
CommandName: itkvars
title: itkvars
ManualSection: n
Version: 3.0
TclPart: itk
TclDescription: "[incr Tk]"
Keywords:
 - itcl
 - itk
 - variables
Copyright:
 - Copyright (c) 1993-1998 Lucent Technologies, Inc.
---

# Name

itkvars - Variablen, die \[incr\\ Tk\] verwendet

# Beschreibung

Die folgenden globalen Variablen werden von der Bibliothek **\[incr Tk\]** automatisch erzeugt und verwaltet. Soweit unten nichts anderes vermerkt ist, sollten anwendungsspezifischer Code und Benutzer diese Variablen gewöhnlich als nur lesbar behandeln.

**itk::library**
: Wenn ein Interpreter erzeugt wird, initialisiert **\[incr Tk\]** diese Variable mit dem Namen eines Verzeichnisses, das die Systembibliothek der Skripte von **\[incr Tk\]** enthält. Der Anfangswert von **itk::library** wird aus der Umgebungsvariable ITK\_LIBRARY gesetzt, falls sie existiert, sonst aus einem einkompilierten Wert.

    Wenn **\[incr Tk\]** einem Interpreter hinzugefügt wird, führt es das Skript "**init.itk**" in diesem Verzeichnis aus. Dieses Skript sucht seinerseits nach weiteren Skriptdateien mit dem Namen "**init.***xxx*". Megawidget-Bibliotheken werden automatisch initialisiert, wenn sie in diesem Verzeichnis ein Skript namens "**init.***xxx*" installieren, wobei „*xxx*“ der Name der Megawidget-Bibliothek ist. Die Bibliothek **\[incr Widgets\]** installiert zum Beispiel das Skript "**init.iwidgets**" in diesem Verzeichnis. Dieses Skript richtet den Namespace „iwidgets“ ein und bereitet das automatische Laden aller Befehle von **\[incr Widgets\]** vor.
