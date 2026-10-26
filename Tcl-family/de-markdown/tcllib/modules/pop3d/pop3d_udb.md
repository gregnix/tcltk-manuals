---
CommandName: pop3d::udb
title: pop3d::udb
ManualSection: n
Version: 1.0.1
TclPart: tcllib
TclDescription: Tcl POP3 Server Package
Keywords:
 - internet
 - network
 - pop3
 - protocol
Copyright:
 - Copyright (c) 2002 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

pop3d::udb – Einfache Benutzerdatenbank für pop3d

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pop3d::udb]{.lit} [1.0.1]{.optlit}
[::pop3d::udb::new]{.cmd} [dbName]{.optarg}
[dbName]{.cmd} [option]{.arg} [arg arg]{.optdot}
[dbName]{.ins} [destroy]{.sub}
[dbName]{.ins} [add]{.sub} [user]{.arg} [pwd]{.arg} [storage]{.arg}
[dbName]{.ins} [remove]{.sub} [user]{.arg}
[dbName]{.ins} [rename]{.sub} [user]{.arg} [newName]{.arg}
[dbName]{.ins} [lookup]{.sub} [user]{.arg}
[dbName]{.ins} [exists]{.sub} [user]{.arg}
[dbName]{.ins} [who]{.sub}
[dbName]{.ins} [save]{.sub} [file]{.optarg}
[dbName]{.ins} [read]{.sub} [file]{.arg}
:::

# Beschreibung

Das Paket **pop3d::udb** stellt einfache Datenbanken im Arbeitsspeicher bereit, die zusammen mit dem POP3-Server-Kern aus dem Paket **pop3d** verwendet werden können. Die Datenbanken verwenden die Namen der Benutzer als Schlüssel und ordnen ihnen Passwörter und Speicherreferenzen zu.

Die von diesem Paket erzeugten Objekte können direkt in der Authentifizierungs-Rückruffunktion von POP3-Servern verwendet werden, die derselben Schnittstelle folgen wie die vom Paket **pop3d** erzeugten Server.

**::pop3d::udb::new** ?*dbName*?
: Dieser Befehl erstellt ein neues Datenbankobjekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *dbName* lautet.


Mit dem Befehl **dbName** können verschiedene Operationen auf der Datenbank ausgeführt werden. Er hat die folgende allgemeine Form:

**dbName** *option* ?*arg arg ...*?
: *Option* und die *arg*s legen das genaue Verhalten des Befehls fest.


Für Datenbankobjekte sind folgende Befehle möglich:

*dbName* **destroy**
: Löscht das Datenbankobjekt.

*dbName* **add** *user pwd storage*
: Fügt einen neuen Benutzer hinzu oder ändert die Daten eines vorhandenen Benutzers. Speichert das Passwort und die *storage*-Referenz für den angegebenen *user*.

*dbName* **remove** *user*
: Entfernt den angegebenen *user* aus der Datenbank.

*dbName* **rename** *user newName*
: Ändert den Namen des angegebenen *user* in *newName*.

*dbName* **lookup** *user*
: Sucht in der Datenbank nach dem angegebenen *user* und gibt eine Liste mit zwei Elementen zurück, in dieser Reihenfolge das zugehörige Passwort und die Speicherreferenz. Löst einen Fehler aus, wenn der Benutzer nicht gefunden wurde. Das ist die Schnittstelle, die die Authentifizierungs-Rückruffunktion des Pakets **pop3d** erwartet.

*dbName* **exists** *user*
: Gibt true zurück, wenn der angegebene *user* der Datenbank bekannt ist, andernfalls false.

*dbName* **who**
: Gibt eine Liste der in der Datenbank bekannten Benutzer zurück.

*dbName* **save** ?*file*?
: Speichert den Inhalt der Datenbank in der angegebenen *file*. Ist keine Datei angegeben, wird der Pfad verwendet, der zuletzt bei einem Aufruf von *dbName* **read** benutzt wurde. Die erzeugte Datei kann mit der Methode **read** gelesen werden.

*dbName* **read** *file*
: Liest die angegebene *file* und fügt die darin enthaltenen Benutzerdefinitionen zur Datenbank hinzu. Da die Datei tatsächlich per **source** ausgeführt wird, schützt ein sicherer Interpreter vor bösartigem Code. Dieser Interpreter kennt den Befehl **add**, mit dem Benutzer und die zugehörigen Daten in diese Datenbank aufgenommen werden. Der Befehl hat dieselbe Argumentsignatur wie die Methode **add**. Der Pfad der *file* wird intern gemerkt, damit er beim nächsten Aufruf von *dbName* **save** ohne Argument verwendet werden kann.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pop3d* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk

# Copyright

```
Copyright (c) 2002 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
