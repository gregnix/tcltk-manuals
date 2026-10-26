---
CommandName: term::interact::pager
title: term::interact::pager
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - control
 - pager
 - terminal
 - text display
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::interact::pager – Terminal-Widget, Paging

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [term::interact::pager]{.lit} [0.2]{.optlit}
[term::interact::pager]{.cmd} [object]{.arg} [text]{.arg} [options...]{.optarg}
[object]{.ins} [interact]{.sub}
[object]{.ins} [done]{.sub}
[object]{.ins} [clear]{.sub}
[object]{.ins} [text]{.sub} [text]{.arg}
[object]{.ins} [configure]{.sub}
[object]{.ins} [configure]{.sub} [option]{.arg}
[object]{.ins} [configure]{.sub} [option]{.arg} [value...]{.arg}
[object]{.ins} [cget]{.sub} [option]{.arg}
:::

# Beschreibung

Dieses Paket enthält eine Klasse zur Erstellung einer einfachen Textanzeige mit Seitenumschaltung.

# API für Klassen

Das Paket exportiert einen einzigen Befehl, den Befehl „class“, der die Erstellung von Pager-Instanzen ermöglicht. Seine API lautet wie folgt:

**term::interact::pager** *object* *text* ?*options*...?
: Dieser Befehl erstellt ein neues Pager-Objekt mit dem Namen *object*, initialisiert es und gibt den vollqualifizierten Namen des Objektbefehls als Ergebnis zurück.

    Das Argument ist der anzuzeigende Text, dem gegebenenfalls Konfigurationsoptionen und deren Werte folgen. Die Optionen werden im Abschnitt [Konfiguration] erläutert.


# Objekt-API

Die durch den Befehl „class“ erstellten Objekte stellen die nachfolgend aufgeführten Methoden bereit:

*object* **interact**
: Zeigt den Pager an der konfigurierten Stelle auf dem Bildschirm an und beginnt mit der Interaktion. Dadurch wird eine eigene Ereignisschleife für die Verarbeitung eingehender Zeichen eröffnet. Die Methode gibt zurück, wenn die Interaktion abgeschlossen ist. Die möglichen Interaktionen stehen im Abschnitt [Interaktion].

*object* **done**
: Diese Methode kann von benutzerdefinierten Aktionen verwendet werden, um die Interaktion mit dem Objekt zu beenden.

*object* **clear**
: Diese Methode kann von benutzerdefinierten Aktionen verwendet werden, um den Pager vom Terminal zu entfernen.

*object* **text** *text*
: Mit dieser Methode lässt sich der vom Pager angezeigte Text ändern. Der Pager setzt die Anzeige zurück, sodass die erste Zeile des Textes oben erscheint.

*object* **configure**
: siehe unten ...

*object* **configure** *option*
: siehe unten ...

*object* **configure** *option* *value*...
: siehe unten ...

*object* **cget** *option*
: Standardmethoden zum Abrufen und Konfigurieren der Optionen des Pagers.


# Konfiguration

Eine Pager-Instanz erkennt die folgenden Optionen:

**-in** chan
: Legt den Kanal fest, aus dem Zeichenfolgen gelesen werden sollen. Der Standardwert lautet **stdin**.

**-out** chan
: Legt den Kanal fest, in den der Inhalt des Pagers geschrieben werden soll. Der Standardwert ist **stdout**.

**-column** int
: Legt die Spalte des Terminals fest, in der der linke Rand der Pager-Anzeige erscheinen soll. Der Standardwert ist 0, d. h. die Spalte ganz links.

**-line** int
: Legt die Zeile des Terminals fest, in der der obere Rand der Pager-Anzeige erscheinen soll. Der Standardwert ist 0, d. h. die oberste Zeile.

**-height** int
: Legt die maximale Anzahl der Textzeilen fest, die auf dem Bildschirm angezeigt werden sollen. Der Standardwert beträgt 25.

**-actions** dict
: Legt ein Dictionary fest, das zusätzliche Aktionen enthält, wobei Zeichenfolgen als Schlüssel verwendet werden. Hinweis: Diese Zeichenfolgen können die im Abschnitt [Interaktion] beschriebenen fest programmierten Zeichenfolgen nicht überschreiben.


# Interaktion

Ein Pager-Objekt erkennt die unten aufgeführten Steuersequenzen und verhält sich wie beschrieben. Der Benutzer kann über die Konfiguration weitere Steuersequenzen festlegen, auf die reagiert werden soll, kann diese Standardeinstellungen jedoch nicht überschreiben.

Cursor Up
: Der Text wird um eine Zeile nach unten gescrollt, wodurch oben eine weitere Zeile sichtbar wird. Der Pager reagiert nicht, wenn die erste Zeile des Textes bereits angezeigt wird.

Cursor Down
: Der Text wird um eine Zeile nach oben gescrollt, wodurch am unteren Rand eine weitere Zeile sichtbar wird. Der Pager reagiert nicht, wenn die letzte Zeile des Textes bereits angezeigt wird.

Page Up
: Der Text wird um eine Seite nach unten gescrollt. Der Pager reagiert nicht, wenn die erste Zeile des Textes bereits angezeigt wird.

Page Down
: Der Text wird um eine Seite nach oben gescrollt. Der Pager reagiert nicht, wenn die letzte Zeile des Textes bereits angezeigt wird.

Enter/Return
: Die Interaktion mit dem Objekt wurde beendet.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *term* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Terminalsteuerung

# Copyright

```
Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
