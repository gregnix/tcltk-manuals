---
CommandName: term::interact::menu
title: term::interact::menu
ManualSection: n
Version: 0.2
TclPart: tcllib
TclDescription: Terminal control
Keywords:
 - control
 - menu
 - terminal
 - text display
Copyright:
 - Copyright (c) 2006 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

term::interact::menu – Terminal-Widget, Menü

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [term::interact::menu]{.lit} [0.2]{.optlit}
[term::interact::menu]{.cmd} [object]{.arg} [dict]{.arg} [options...]{.optarg}
[object]{.ins} [interact]{.sub}
[object]{.ins} [done]{.sub}
[object]{.ins} [clear]{.sub}
[object]{.ins} [configure]{.sub}
[object]{.ins} [configure]{.sub} [option]{.arg}
[object]{.ins} [configure]{.sub} [option]{.arg} [value...]{.arg}
[object]{.ins} [cget]{.sub} [option]{.arg}
:::

# Beschreibung

Dieses Paket enthält eine Klasse zur Erstellung eines einfachen Menü-Steuerelements.

# API für Klassen

Das Paket exportiert einen einzigen Befehl, den Befehl „class“, der die Erstellung von Menüinstanzen ermöglicht. Seine API lautet:

**term::interact::menu** *object* *dict* ?*options*...?
: Dieser Befehl erstellt ein neues Menüobjekt mit dem Namen *object*, initialisiert es und gibt den vollqualifizierten Namen des Objektbefehls als Ergebnis zurück.

    Das Argument ist das anzuzeigende Menü, gegebenenfalls gefolgt von Konfigurationsoptionen und deren Werten. Die Optionen werden im Abschnitt [Konfiguration] erläutert. Das Menü ist ein Dictionary, das Bezeichnungen symbolischen Aktionscodes zuordnet.


# Objekt-API

Die durch den Befehl „class“ erstellten Objekte stellen die nachfolgend aufgeführten Methoden bereit:

*object* **interact**
: Zeigt das Menü an der konfigurierten Stelle auf dem Bildschirm an und beginnt mit der Interaktion damit. Dabei wird eine eigene Ereignisschleife zur Verarbeitung eingehender Zeichen eröffnet. Die Methode gibt zurück, wenn die Interaktion abgeschlossen ist. Eine Beschreibung der möglichen Interaktionen finden Sie im Abschnitt [Interaktion].

    Die Methode gibt am Ende der Interaktion die symbolische Aktion des vom Benutzer ausgewählten Menüelements zurück.

*object* **done**
: Diese Methode kann von benutzerdefinierten Aktionen verwendet werden, um die Interaktion mit dem Objekt zu beenden.

*object* **clear**
: Diese Methode kann von benutzerdefinierten Aktionen verwendet werden, um das Menü vom Terminal zu entfernen.

*object* **configure**
: siehe unten ...

*object* **configure** *option*
: siehe unten ...

*object* **configure** *option* *value*...
: siehe unten ...

*object* **cget** *option*
: Standardmethoden zum Abrufen und Konfigurieren der Menüoptionen.


# Konfiguration

Eine Menüinstanz erkennt die folgenden Optionen:

**-in** chan
: Legt den Kanal fest, aus dem Zeichenfolgen gelesen werden sollen. Der Standardwert lautet **stdin**.

**-out** chan
: Legt den Kanal fest, in den der Menüinhalt geschrieben werden soll. Der Standardwert lautet **stdout**.

**-column** int
: Legt die Spalte des Terminals fest, in der der linke Rand der Menüanzeige erscheinen soll. Der Standardwert ist 0, d. h. die Spalte ganz links.

**-line** int
: Legt die Zeile des Terminals fest, in der der obere Rand der Menüanzeige erscheinen soll. Der Standardwert ist 0, d. h. die oberste Zeile.

**-height** int
: Legt die maximale Anzahl der Textzeilen fest, die auf dem Bildschirm angezeigt werden sollen. Der Standardwert beträgt 25.

**-actions** dict
: Legt ein Dictionary fest, das zusätzliche Aktionen enthält, wobei Zeichenfolgen als Schlüssel verwendet werden. Hinweis: Diese Zeichenfolgen können die im Abschnitt [Interaktion] beschriebenen fest programmierten Zeichenfolgen nicht überschreiben.

**-hilitleft** int
: siehe unten ...

**-hilitright** int
: Standardmäßig wird der gesamte ausgewählte Menüeintrag in der inversen Darstellung hervorgehoben. Sind diese beiden Optionen jedoch vorhanden, beschränken sie die inverse Darstellung auf den angegebenen Teilbereich des Eintrags.

**-framed** bool
: Standardmäßig wird das Menü so dargestellt, dass von den grafischen Elementen der Zeichenbox nur die Kopf- und Fußzeile verwendet werden. Wenn dieses Kennzeichen gesetzt ist, wird das Menü vollständig von einer Box umschlossen.


# Interaktion

Ein Menüobjekt erkennt die unten aufgeführten Steuersequenzen und verhält sich wie beschrieben. Der Benutzer kann über die Konfiguration weitere Steuersequenzen festlegen, auf die reagiert werden soll, kann diese Standardeinstellungen jedoch nicht überschreiben.

Cursor Up
: Die Auswahl wird um einen Eintrag nach oben verschoben, es sei denn, der erste Eintrag des Menüs ist bereits ausgewählt.

Cursor Down
: Die Auswahl wird um einen Eintrag nach unten verschoben, es sei denn, der letzte Eintrag des Menüs ist bereits ausgewählt.

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
