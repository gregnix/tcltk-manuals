---
CommandName: cache::async
title: cache::async
ManualSection: n
Version: 0.3.2
TclPart: tcllib
TclDescription: In-memory caches
Keywords:
 - asynchronous
 - cache
 - callback
 - synchronous
Copyright:
 - Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

cache::async – Asynchroner In-Memory-Cache

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [cache::async]{.lit} [0.3.2]{.optlit}
[::cache::async]{.cmd} [objectName]{.arg} [commandprefix]{.arg} [options...]{.optarg}
[objectName]{.ins} [get]{.sub} [key]{.arg} [donecmdprefix]{.arg}
[objectName]{.ins} [set]{.sub} [key]{.arg} [value]{.arg}
[objectName]{.ins} [unset]{.sub} [key]{.arg}
[objectName]{.ins} [exists]{.sub} [key]{.arg}
[objectName]{.ins} [clear]{.sub} [key]{.optarg}
:::

# Beschreibung

Dieses Paket stellt Objekte bereit, die Daten im Arbeitsspeicher zwischenspeichern und hinsichtlich Anfragen und Antworten asynchron arbeiten. Die Objekte sind unabhängig von Cache-Schlüsseln und -Werten, und unbekannte Methoden werden an den Anbieter der zwischengespeicherten Daten weitergeleitet. Diese beiden Eigenschaften erleichtern die Verwendung von Caches als Fassade für jeden beliebigen Datenanbieter.

# API

Das Paket exportiert eine Klasse namens „**cache::async**“, wie im Folgenden beschrieben.

**::cache::async** *objectName* *commandprefix* ?*options*...?
: Der Befehl erstellt ein neues *Cache*-Objekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *objectName* lautet. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Objekt auszuführen.

    Das *commandprefix* ist die Aktion, die ausgeführt werden soll, wenn ein Benutzer Daten aus dem Cache anfordert und der Cache den Schlüssel noch nicht kennt. Wenn der Befehl ausgeführt wird, erhält der *commandprefix* drei zusätzliche Argumente: die Zeichenkette **get**, den angeforderten Schlüssel und das Cache-Objekt selbst in Form seines Objektbefehls – in dieser Reihenfolge. Die Ausführung der Aktion erfolgt in einem Idle-Handler, wodurch sie von der ursprünglichen Anfrage entkoppelt wird.

    Die einzige unterstützte Option ist

    **-full-async-results**
    : Diese Option legt das Verhalten des Caches für den Fall fest, dass die angeforderten Schlüssel dem Cache zum Zeitpunkt der **get**-Anfrage bereits bekannt sind. Standardmäßig werden solche Anfragen ebenfalls asynchron beantwortet. Wird diese Option auf „**false**“ gesetzt, wird der Cache gezwungen, synchron auf diese Anfragen zu reagieren, allerdings weiterhin über die angegebene Rückruffunktion.



Die durch die oben genannten Klassenbefehle erstellten Objektbefehle haben folgende Form:

*objectName* **get** *key* *donecmdprefix*
: Diese Methode fordert die Daten für den *key* aus dem Cache an. Wenn die Daten noch nicht bekannt sind, wird das bei der Erstellung des Cache-Objekts festgelegte Befehlspräfix verwendet, um diese Informationen abzufragen.

    Sobald die Informationen verfügbar sind oder werden, wird das *donecmdprefix* ausgeführt, um das Ergebnis an den Aufrufer zu übermitteln. Dieser Befehl wird entweder mit 2 oder 3 Argumenten aufgerufen, d. h.

    1. Die Zeichenfolge „**set**“, der *key* und der Wert.

    2. Die Zeichenfolge „**unset**“ und der *key*.


    Diese beiden Möglichkeiten dienen dazu, entweder den Wert für den *key* anzugeben oder zu signalisieren, dass für den *key* kein Wert definiert ist. Letzteres unterscheidet sich von dem Fall, dass der Cache den *key* nicht kennt.

    Bei einem Cache-Objekt, das auf vollständige Asynchronität konfiguriert ist (Standard), wird das *donecmdprefix* stets in einem Idle-Handler ausgeführt, wodurch es von der Anfrage entkoppelt wird. Andernfalls wird die Rückruffunktion synchron aufgerufen, wenn der *key* dem Cache zum Zeitpunkt des Aufrufs bekannt ist.

    Ein weiterer wichtiger Aspekt des Verhaltens des Caches: Da er asynchron arbeitet, ist es möglich, dass mehrere **get**-Anfragen für denselben *key* gestellt werden, bevor dieser antworten kann. In diesem Fall sendet der Cache nur eine Datenanfrage an den Anbieter – und zwar für die erste dieser Anfragen –, setzt die anderen aus und benachrichtigt sie alle, wenn die Daten verfügbar sind.

*objectName* **set** *key* *value*
: siehe unten ...

*objectName* **unset** *key*
: Diese beiden Methoden stehen zur Verfügung, damit Nutzer des Caches dem Cache Schlüssel entweder mit einem *value* oder als undefiniert mitteilen können.

    Es wird erwartet, dass der Datenanbieter (siehe *commandprefix* des Konstruktors) diese Methoden als Antwort auf Datenanfragen für unbekannte Schlüssel verwendet.

    Hinweis: Dies entspricht der eigenen API des Caches gegenüber seinem Aufrufer: Der Cache ruft das *donecmd* von **get**-Anfragen auf, die an ihn selbst gerichtet wurden – entweder mit „set key value“ oder „unset key“ –, im Gegensatz zur Ausgabe von **get**-Anfragen an seinen eigenen Anbieter sendet, wobei er sich selbst anstelle des *donecmd* einsetzt und erwartet, entweder mit „set key Wert“ oder „unset key“ aufgerufen zu werden.

    Dies bedeutet auch, dass diese Methoden das *donecmd* aller **get**-Anfragen aufrufen, die auf Informationen über den geänderten *key* warten.

*objectName* **exists** *key*
: Diese Methode fragt den Cache nach Informationen zum *key* ab und gibt einen booleschen Wert zurück. Das Ergebnis lautet **true**, wenn der Schlüssel bekannt ist, andernfalls **false**.

*objectName* **clear** ?*key*?
: Diese Methode setzt den Status entweder des angegebenen *key* oder aller dem Cache bekannten Schlüssel zurück, sodass diese als unbekannt gelten. Dadurch wird erreicht, dass bei künftigen **get**-Anfragen die Informationen erneut vom Anbieter geladen werden müssen.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *cache* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Copyright

```
Copyright (c) 2008 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
