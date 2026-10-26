---
CommandName: uevent
title: uevent
ManualSection: n
Version: 0.3.2
TclPart: tcllib
TclDescription: User events
Links:
 - hook(n)
Keywords:
 - bind
 - event
 - generate event
 - hook
 - unbind
Copyright:
 - Copyright (c) 2007-2012 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

uevent – Benutzerereignisse

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [uevent]{.lit} [0.3.2]{.optlit}
[package]{.cmd} [require]{.sub} [logger]{.lit}
[::uevent::bind]{.cmd} [tag]{.arg} [event]{.arg} [command]{.arg}
[command]{.cmd} [tag]{.arg} [event]{.arg} [details]{.arg}
[::uevent::unbind]{.cmd} [token]{.arg}
[::uevent::generate]{.cmd} [tag]{.arg} [event]{.arg} [details]{.optarg}
[::uevent::list]{.cmd}
[::uevent::list]{.cmd} [tag]{.arg}
[::uevent::list]{.cmd} [tag]{.arg} [event]{.arg}
[::uevent::watch::tag::add]{.cmd} [pattern]{.arg} [command]{.arg}
[{\*}command]{.cmd} [bound]{.lit} [tag]{.arg}
[{\*}command]{.cmd} [unbound]{.lit} [tag]{.arg}
[::uevent::watch::tag::remove]{.cmd} [token]{.arg}
[::uevent::watch::event::add]{.cmd} [tag\_pattern]{.arg} [event\_pattern]{.arg} [command]{.arg}
[{\*}command]{.cmd} [bound]{.lit} [tag]{.arg} [event]{.arg}
[{\*}command]{.cmd} [unbound]{.lit} [tag]{.arg} [event]{.arg}
[::uevent::watch::event::remove]{.cmd} [token]{.arg}
:::

# Beschreibung

Dieses Paket bietet eine allgemeine Funktion zur Verarbeitung von Benutzerereignissen. Es ermöglicht die Zuordnung beliebiger Befehle zu beliebigen Ereignissen auf beliebigen Tags, das Aufheben von Bindungen sowie die Erzeugung von Ereignissen.

Der wesentliche Unterschied zum im Tcl/Tk-Kern integrierten Ereignissystem besteht darin, dass dieses lediglich virtuelle Ereignisse erzeugen kann, und zwar ausschließlich für Widgets. Es ist nicht möglich, die integrierten Funktionen zu nutzen, um Ereignisse an beliebige (Pseudo-)Objekte zu binden, und es ist auch nicht in der Lage, Ereignisse für solche Objekte zu erzeugen.

Hier können wir davon ausgehen, dass jedes betreffende Objekt durch ein eigenes Tag dargestellt wird. Dies ist möglich, da wir beliebige Tags zulassen.

Weitere Unterschiede:

1. Das Paket nutzt zur Abwicklung aller Vorgänge lediglich eine zweistufige Hierarchie – Tags und Ereignisse –, während das Tcl/Tk-System drei Ebenen verwendet, nämlich Objekte, Tags und Ereignisse, wobei zwischen Objekten und Tags eine n:m-Beziehung besteht.

2. Dieses Paket löst alle zugewiesenen Befehle für eine Kombination aus Tag und Ereignis aus, wobei diese voneinander unabhängig sind. Ein zugewiesener Befehl kann den Ereignisverarbeitungskern nicht dazu zwingen, die Verarbeitung eines nachfolgenden Befehls abzubrechen.


# API

Das Paket exportiert acht Befehle, wie im Folgenden angegeben. Beachten Sie, dass wenn das Paket innerhalb von Tcl 8.5+ verwendet wird, alle übergeordneten Befehle Ensembles sind, d. h., die Trennzeichen „::“ können durch Leerzeichen ersetzt werden.

**::uevent::bind** *tag* *event* *command*
: Mit diesem Befehl wird das Präfix *command* so registriert, dass es ausgelöst wird, wenn das *event* für das *tag* eintritt. Das Ergebnis des Befehls ist ein undurchsichtiges Token, das die Bindung repräsentiert. Bitte beachten Sie: Wird dieselbe Kombination aus <*tag*,*event*,*command*> mehrfach verwendet, gibt der Befehl bei jedem Aufruf dasselbe Token zurück.

    Die Signatur des Präfixes *command* lautet

    - **command** *tag* *event* *details*


    wobei *details* das bzw. die Argumente des Ereignisses enthält. Der Inhalt ist ereignisspezifisch und muss zwischen dem eigentlichen Erzeuger des Ereignisses und dem Empfänger vereinbart werden. Dieses Paket überträgt lediglich die Informationen und führt darüber hinaus keine weitere Verarbeitung durch.

**::uevent::unbind** *token*
: Dieser Befehl hebt die durch das *token* dargestellte Ereignisbindung auf. Das Token muss das Ergebnis eines Aufrufs von **::uevent::bind** sein. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::uevent::generate** *tag* *event* ?*details*?
: Dieser Befehl generiert ein *event* für das *tag* und löst damit alle Befehle aus, die dieser Kombination zugeordnet sind. Das Argument *details* wird einfach unverändert an alle Ereignisbehandler weitergeleitet. Es liegt in der Verantwortung des Codes, der das Ereignis generiert und verarbeitet, eine Vereinbarung über das Format und den Inhalt der darin enthaltenen Informationen zu treffen. Das Ergebnis des Befehls ist die leere Zeichenkette.

    Beachten Sie, dass alle zugeordneten Befehle unabhängig voneinander ausgelöst werden. Die Ereignisbehandler dürfen keine bestimmte Reihenfolge voraussetzen. Sie werden zudem *nicht* synchron mit dem Aufruf dieses Befehls aufgerufen, sondern lediglich in die Ereigniswarteschlange zur Verarbeitung gestellt, wenn das System zur Ereignisschleife zurückkehrt.

    Das Erzeugen eines Ereignisses für ein unbekanntes Tag oder für eine <*tag*,*event*>-Kombination, der keine Befehle zugeordnet sind, ist zulässig; solche Aufrufe werden ignoriert.

**::uevent::list**
: In dieser Form gibt der Befehl eine Liste zurück, die die Namen aller Tags enthält, denen Ereignisse mit zugeordneten Befehlen zugeordnet sind.

**::uevent::list** *tag*
: In diesem Format gibt der Befehl eine Liste zurück, die die Namen aller Ereignisse für das *tag* enthält, denen Befehle zugeordnet sind. Die Angabe eines unbekannten Tags, d. h. eines Tags ohne Ereignis und ohne Befehle, führt dazu, dass der Befehl eine Fehlermeldung ausgibt.

**::uevent::list** *tag* *event*
: In diesem Format gibt der Befehl eine Liste zurück, die alle Befehle enthält, die dem *event* für das *tag* zugeordnet sind. Die Angabe eines unbekannten Tags oder eines unbekannten Ereignisses führt dazu, dass der Befehl eine Fehlermeldung ausgibt.

**::uevent::watch::tag::add** *pattern* *command*
: Dieser Befehl richtet eine Art umgekehrter Ereignisse ein. Diese Ereignisse werden ausgelöst – d. h., das Präfix *command* wird aufgerufen –, wenn Beobachter an bestimmte Tags gebunden oder von diesen getrennt werden.

    Beachten Sie, dass das Präfix *command* pro Tag nur zweimal aufgerufen wird: erstens, wenn der erste Befehl an ein beliebiges Ereignis des Tags gebunden wird, und zweitens, wenn der letzte an das Tag gebundene Befehl entfernt wird.

    Die Signatur des Präfixes *command* lautet

    - **{\*}command** **bound** *tag*
    - **{\*}command** **unbound** *tag*


    Das Ergebnis des Befehls ist ein Token, das den Watcher repräsentiert.

**::uevent::watch::tag::remove** *token*
: Dieser Befehl entfernt einen Beobachter für (Un-)Bind-Ereignisse bei Tags.

    Das Ergebnis des Befehls ist die leere Zeichenkette.

**::uevent::watch::event::add** *tag\_pattern* *event\_pattern* *command*
: Dieser Befehl richtet eine Art „umgekehrter Ereignisse“ ein. Dabei werden Ereignisse generiert – d. h., das Präfix *command* wird aufgerufen –, wenn Beobachter bestimmte Kombinationen aus Tags und Ereignissen binden oder die Bindung dazu aufheben.

    Beachten Sie, dass das Befehlspräfix pro Tag-/Ereigniskombination nur zweimal aufgerufen wird: erstens, wenn der erste Befehl daran gebunden wird, und zweitens, wenn der letzte daran gebundene Befehl entfernt wird.

    Die Signatur des *command*-Präfixes lautet

    - **{\*}command** **bound** *tag* *event*
    - **{\*}command** **unbound** *tag* *event*


    Das Ergebnis des Befehls ist ein Token, das den Watcher repräsentiert.

**::uevent::watch::event::remove** *token*
: Dieser Befehl entfernt einen Beobachter für (Un-)Bind-Ereignisse bei Tag-/Ereignis-Kombinationen.

    Das Ergebnis des Befehls ist die leere Zeichenkette.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *uevent* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge

# Copyright

```
Copyright (c) 2007-2012 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
