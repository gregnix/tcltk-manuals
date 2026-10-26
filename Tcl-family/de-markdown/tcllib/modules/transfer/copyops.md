---
CommandName: transfer::copy
title: transfer::copy
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - channel
 - copy
 - transfer
Copyright:
 - Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

transfer::copy – Grundlagen der Datenübertragung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [transfer::copy]{.lit} [0.3]{.optlit}
[transfer::copy::do]{.cmd} [chan|string]{.lit} [data]{.arg} [outchannel]{.arg} [options...]{.optarg}
[transfer::copy::chan]{.cmd} [channel]{.arg} [outchannel]{.arg} [options...]{.optarg}
[transfer::copy::string]{.cmd} [string]{.arg} [outchannel]{.arg} [options...]{.optarg}
[transfer::copy::doChan]{.cmd} [channel]{.arg} [outchannel]{.arg} [optvar]{.arg}
[transfer::copy::doString]{.cmd} [string]{.arg} [outchannel]{.arg} [optvar]{.arg}
[transfer::copy::options]{.cmd} [outchannel]{.arg} [optionlist]{.arg} [optvar]{.arg}
:::

# Beschreibung

Dieses Paket stellt eine Reihe von Befehlen für die asynchrone Verarbeitung von Informationen bereit, die entweder in einer Zeichenkette oder in einem Kanal enthalten sind. Der Hauptvorteil dieses Pakets besteht darin, dass die hier enthaltenen Befehle eine benutzerfreundlichere Rückruffunktion bieten als der integrierte Befehl **fcopy**, wodurch die Nutzung dieser Funktionen einfacher ist als die des integrierten Befehls.

# API

**transfer::copy::do** **chan**|**string** *data* *outchannel* ?*options*...?
: Dieser Befehl überträgt die in *data* enthaltenen Informationen gemäß den *outchannel* an den *options*. Der Typ der in *data* enthaltenen Informationen wird durch das erste Argument bestimmt.

    Die für diesen Befehl verfügbaren Optionen entsprechen denen des Befehls **transfer::copy::options** und werden dort erläutert.

    **chan**
    : Das Argument *data* enthält das Handle eines Kanals, und die tatsächlich zu übertragenden Informationen werden aus diesem Kanal gelesen.

    **string**
    : Das Argument *data* enthält eine Zeichenkette, und dies sind die zu übertragenden Informationen.


**transfer::copy::chan** *channel* *outchannel* ?*options*...?
: Dieser Befehl ist eine kürzere und direktere Form des Befehls **transfer::copy::do chan**.

**transfer::copy::string** *string* *outchannel* ?*options*...?
: Dieser Befehl ist eine kürzere und direktere Form des Befehls **transfer::copy::do string**.

**transfer::copy::doChan** *channel* *outchannel* *optvar*
: Dieser Befehl ist eine alternative Form von **transfer::copy::chan**, die ihre Optionen nicht aus einer Argumentliste variabler Länge, sondern aus der Array-Variablen mit dem Namen *optvar* ausliest.

**transfer::copy::doString** *string* *outchannel* *optvar*
: Dieser Befehl ist eine alternative Form von **transfer::copy::string**, der seine Optionen nicht aus einer Argumentliste variabler Länge, sondern aus der durch *optvar* benannten Array-Variablen ausliest.

**transfer::copy::options** *outchannel* *optionlist* *optvar*
: Dieser Befehl ist der Optionsprozessor, der von allen oben genannten Befehlen verwendet wird, welche ihre Optionen aus einer Argumentliste variabler Länge auslesen. Er liest zunächst die Standardeinstellungen aus dem Kanal-Handle *outchannel* aus, verarbeitet anschließend die Liste der Optionen in *optionlist* und speichert schließlich die Ergebnisse in der durch *optvar* benannten Array-Variablen. Der Inhalt dieser Variablen liegt in einem Format vor, das von allen oben genannten Befehlen, die ihre Optionen aus einer Array-Variablen lesen, direkt verstanden wird.

    Die erkannten Optionen sind:

    **-blocksize** *int*
    : Diese Option legt die Größe der Blöcke fest, die in einem Vorgang übertragen werden sollen. Sie ist optional und nimmt standardmäßig den Wert von **-buffersize** an, wie er für den Ausgabekanal konfiguriert ist.

        Falls angegeben, muss ihr Wert eine ganze Zahl größer als Null sein.

    **-command** *commandprefix*
    : Diese Option legt die Rückruffunktion für den Abschluss des Vorgangs fest. Diese Option muss angegeben werden. Andernfalls oder wenn als Argument eine leere Liste angegeben wurde, wird ein Fehler ausgelöst.

        Ihr Wert muss ein Befehlspräfix sein, d. h. eine Liste, deren erstes Wort der auszuführende Befehl ist, gefolgt von Wörtern, die feste Argumente enthalten. Wenn die Rückruffunktion aufgerufen wird, werden dem Präfix ein oder zwei zusätzliche Argumente angehängt. Das erste Argument ist die Anzahl der übertragenen Bytes. Das optionale zweite Argument ist eine Fehlermeldung und wird genau dann hinzugefügt, wenn während der Übertragung ein Fehler aufgetreten ist.

    **-progress** *commandprefix*
    : Diese Option legt die Fortschritts-Rückruffunktion für den Vorgang fest. Sie ist optional und ist standardmäßig auf eine leere Liste gesetzt. Diese letzte Möglichkeit signalisiert, dass keine Rückmeldung angefordert wurde, und deaktiviert diese Funktion.

        Ihr Wert muss ein Befehlspräfix sein; siehe oben, **-command**, für eine ausführlichere Erläuterung. Wenn die Rückruffunktion aufgerufen wird, wird dem Präfix ein einziges zusätzliches Argument angehängt. Dieses Argument gibt die Anzahl der Bytes an, die bisher übertragen wurden.

    **-size** *int*
    : Diese Option legt die Anzahl der Bytes fest, die aus den Eingabedaten gelesen und übertragen werden sollen. Sie ist optional und standardmäßig auf „Alles übertragen“ eingestellt. Ihr Wert muss eine ganze Zahl sein; jeder Wert kleiner als Null hat dieselbe Bedeutung, d. h., es werden alle verfügbaren Daten übertragen. Jeder andere Wert entspricht der Anzahl der zu übertragenden Bytes.

        Alle Übertragungsbefehle lösen einen Fehler aus, wenn der Benutzer versucht, mehr Daten zu übertragen, als in der Eingabe verfügbar sind. Dies geschieht sofort, noch bevor die Übertragung tatsächlich beginnt, sofern es sich bei der Eingabe um eine Zeichenkette handelt. Andernfalls, d. h. bei einem Kanal als Eingabe, wird der Fehler in dem Moment ausgelöst, in dem die Unterlaufbedingung tatsächlich erkannt wird.

    **-encoding** *encodingname*
    : siehe unten ...

    **-eofchar** *eofspec*
    : siehe unten ...

    **-translation** *transspec*
    : Diese Optionen entsprechen denen, die vom integrierten Befehl **fconfigure** erkannt werden, und legen die Einstellungen für den Ausgabekanal fest, die während der Übertragung – und ausschließlich während dieser – aktiv sein sollen. Das heißt, die Einstellungen des Ausgabekanals vor der Übertragung werden gespeichert und am Ende einer Übertragung wiederhergestellt, unabhängig davon, ob diese erfolgreich war oder fehlgeschlagen ist. Keine dieser Optionen ist erforderlich; sofern sie nicht angegeben werden, gelten standardmäßig die Einstellungen des Ausgabekanals.



# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *transfer* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Transfermodul

# Copyright

```
Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
