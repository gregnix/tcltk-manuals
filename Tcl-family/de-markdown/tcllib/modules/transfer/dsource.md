---
CommandName: transfer::data::source
title: transfer::data::source
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - channel
 - copy
 - data source
 - transfer
Copyright:
 - Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

transfer::data::source – Datenquelle

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.0]{.optlit}
[package]{.cmd} [require]{.sub} [transfer::copy]{.lit} [0.3]{.optlit}
[package]{.cmd} [require]{.sub} [transfer::data::source]{.lit} [0.3]{.optlit}
[transfer::data::source]{.cmd} [objectName]{.arg} [options...]{.optarg}
[objectName]{.ins} [method]{.sub} [arg arg]{.optdot}
[objectName]{.ins} [destroy]{.sub}
[objectName]{.ins} [type]{.sub}
[objectName]{.ins} [data]{.sub}
[objectName]{.ins} [size]{.sub}
[objectName]{.ins} [valid]{.sub} [msgvar]{.arg}
[objectName]{.ins} [transmit]{.sub} [channel]{.arg} [blocksize]{.arg} [done]{.arg}
:::

# Beschreibung

Dieses Paket enthält Objekte, die in erster Linie die Herkunft bestimmter zu übertragender Daten beschreiben. Sie sind zudem in der Lage, mithilfe des Basis-Pakets **transfer::copy** die Übertragung der beschriebenen Informationen an einen Kanal zu initiieren.

# API

## Paketbefehle

**transfer::data::source** *objectName* ?*options*...?
: Dieser Befehl erstellt ein neues Datenquellenobjekt mit einem zugehörigen Tcl-Befehl, dessen Name *objectName* lautet. Dieser *object*-Befehl wird in den Abschnitten [Objektbefehl] und [Objektmethoden] ausführlich erläutert. Die unterstützten *options* werden im Abschnitt [Optionen] erläutert.

    Der Objektbefehl wird im aktuellen Namespace erstellt, wenn *objectName* nicht vollständig qualifiziert ist; andernfalls erfolgt die Erstellung im angegebenen Namespace. Der vollständig qualifizierte Name des Objektbefehls wird als Ergebnis des Befehls zurückgegeben.


## Objektbefehl

Alle mit dem Befehl **::transfer::data::source** erstellten Objekte haben die folgende allgemeine Form:

*objectName* **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt [Objektmethoden].


## Objektmethoden

*objectName* **destroy**
: Diese Methode löscht das Objekt. Dies ist unbedenklich, solange eine vom Objekt initiierte Übertragung aktiv ist, da alle für die Übertragung erforderlichen Daten bereits kopiert wurden und nach Abschluss der Übertragung kein Zugriff mehr auf das initiierende Objekt erfolgt. Das heißt, die Übertragung ist vollständig vom Quellobjekt selbst getrennt.

*objectName* **type**
: Diese Methode gibt eine Zeichenkette zurück, die den Typ der Daten beschreibt, auf die sich das Objekt bezieht. Die möglichen Werte und ihre Bedeutungen lauten:

    **undefined**
    : Es wurden entweder gar keine Daten angegeben oder diese waren unvollständig. Das Objekt kennt den Typ nicht.

    **string**
    : Die zu übertragenden Daten sind in einer Zeichenkette enthalten.

    **channel**
    : Die zu übertragenden Daten sind in einem Kanal enthalten.


*objectName* **data**
: Diese Methode gibt je nach Typ der Daten, auf die sich das Objekt bezieht, einen Wert zurück, über den auf die Daten zugegriffen werden kann. Die Methode löst einen Fehler aus, wenn der Typ **undefined** ist. Beim Typ **string** gibt es als Rückgabewert die Daten selbst, während beim Typ **channel** das Rückgabewert das Handle des Kanals ist, der die Daten enthält.

*objectName* **size**
: Diese Methode gibt einen Wert zurück, der vom Typ der Daten, auf die sich das Objekt bezieht, sowie von der Größe dieser Daten abhängt. Die Methode löst einen Fehler aus, wenn der Typ „**undefined**“ ist. Die Rückgabe eines negativen Werts signalisiert, dass das Objekt die absolute Größe nicht im Voraus ermitteln kann (wie beispielsweise bei Daten in einem Kanal).

*objectName* **valid** *msgvar*
: Diese Methode überprüft die Konfiguration des Objekts auf Gültigkeit. Sie gibt einen booleschen Wert zurück, dessen Wert „**True**“ lautet, wenn das Objekt gültig ist, und andernfalls „**False**“. Im letzteren Fall wird die Variable, deren Name in *msgvar* gespeichert ist, auf eine Fehlermeldung gesetzt, die das bei der Konfiguration festgestellte Problem beschreibt. Andernfalls bleibt diese Variable unverändert.

*objectName* **transmit** *channel* *blocksize* *done*
: Diese Methode leitet eine Übertragung der referenzierten Daten an den angegebenen *channel* ein. Wenn die Übertragung abgeschlossen ist, wird das Befehlspräfix *done* aufgerufen, gemäß den Regeln für die Option **-command** des Befehls [transfer::copy::do][copyops] im Paket **transfer::copy**. Die Angabe *blocksize* legt die Größe der Blöcke fest, die in einem Durchgang übertragen werden sollen. Siehe dazu die Option **-blocksize** des Befehls [transfer::copy::do][copyops] im Paket **transfer::copy**.


## Optionen

Alle Datenquellen unterstützen die unten aufgeführten Optionen. Zu beachten ist, dass die ersten vier Optionen sich teilweise gegenseitig ausschließen, da jede eine andere Art von Datenquelle und zugehörigen Inhalt festlegt. Werden diese Optionen mehrmals angegeben, wird die zuletzt angegebene Option zur tatsächlichen Konfiguration des Objekts herangezogen.

**-string** *text*
: Diese Option legt fest, dass die Datenquelle eine direkte Zeichenkette ist und das zugehörige Argument die betreffende Zeichenkette enthält.

**-channel** *handle*
: Diese Option legt fest, dass die Datenquelle ein Kanal ist, und das zugehörige Argument ist das Handle des Kanals, der die Daten enthält.

**-file** *path*
: Diese Option legt fest, dass die Daten aus einer Datei stammen, und das zugehörige Argument ist der Pfad zu der Datei, die die Daten enthält.

**-variable** *varname*
: Diese Option legt fest, dass die Datenquelle eine in einer Variablen gespeicherte Zeichenkette ist und das zugehörige Argument den Namen der betreffenden Variablen enthält. Es wird davon ausgegangen, dass es sich um eine globale Variable oder eine Variable im Namespace handelt, die im globalen Namespace verankert ist.

**-size** *int*
: Diese Option legt die Größe der Datenübertragung fest. Sie ist optional und hat standardmäßig den Wert -1. Dieser Wert sowie jeder andere Wert kleiner als Null bewirkt, dass alle Daten aus der Quelle übertragen werden.

**-progress** *command*
: Wenn diese Option festgelegt ist, wird damit ein Befehl definiert, der für jeden übertragenen Byte-Block aufgerufen wird, sodass der Benutzer den Fortschritt der Datenübertragung überwachen kann. Die Rückruffunktion wird stets mit einem zusätzlichen Argument aufgerufen, nämlich der Anzahl der bisher übertragenen Bytes.


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


[copyops]: copyops.md
