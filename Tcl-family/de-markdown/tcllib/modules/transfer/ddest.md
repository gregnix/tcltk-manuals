---
CommandName: transfer::data::destination
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Data transfer facilities
Keywords:
 - channel
 - copy
 - data destination
 - transfer
Copyright:
 - Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

transfer::data::destination – Datenziel

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} [1.0]{.optlit} 
[package]{.cmd} [require]{.sub} [transfer::data::destination]{.lit} [0.3]{.optlit} 
[transfer::data::destination]{.cmd} [objectName]{.arg} [options]{.optdot} 
[objectName]{.ins} [method]{.sub} [arg arg]{.optdot} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [put]{.sub} [chunk]{.arg} 
[objectName]{.ins} [done]{.sub} 
[objectName]{.ins} [valid]{.sub} [msgvar]{.arg} 
[objectName]{.ins} [receive]{.sub} [channel]{.arg} [done]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket enthält Objekte, die in erster Linie das Ziel einer Datenübertragung beschreiben. Sie sind zudem in der Lage, den Empfang von Informationen aus einem Kanal an das beschriebene Ziel zu initiieren.

# API

**transfer::data::destination** *objectName* ?*options*...?
: Dieser Befehl erstellt ein neues Datenzielobjekt mit einem zugehörigen Tcl-Befehl, dessen Name *objectName* lautet. Dieser *object*-Befehl wird in den Abschnitten **Objektbefehl** und **Objektmethoden** ausführlich erläutert. Die unterstützten *options* werden im Abschnitt **Optionen** erläutert. Der Objektbefehl wird im aktuellen Namespace erstellt, wenn *objectName* nicht vollständig qualifiziert ist; andernfalls erfolgt die Erstellung im angegebenen Namespace. Der vollständig qualifizierte Name des Objektbefehls wird als Ergebnis des Befehls zurückgegeben.


## Objektbefehl

Alle mit dem Befehl **::transfer::data::destination** erstellten Objekte haben die folgende allgemeine Form:

*objectName* **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt **Objektmethoden**.


## Objektmethoden

*objectName* **destroy**
: Diese Methode löscht das Objekt. Wenn dies geschieht, während das Objekt gerade mit dem Empfang von Informationen aus einem Kanal beschäftigt ist, führt dies später zu Fehlern, sobald der Empfang abgeschlossen ist und versucht wird, auf die nun fehlenden Datenstrukturen des gelöschten Objekts zuzugreifen.

*objectName* **put** *chunk*
: Die Hauptrezeptormethode. Speichert den empfangenen *chunk* am konfigurierten Speicherort. Sie muss für jedes empfangene Datenelement aufgerufen werden.

*objectName* **done**
: Die Sekundärrezeptor-Methode. Schließt den Empfänger ab. Sie muss aufgerufen werden, wenn der Empfangskanal „EOF“ signalisiert. Danach können weder diese Methode noch die Methode **put** mehr aufgerufen werden.

*objectName* **valid** *msgvar*
: Diese Methode überprüft die Konfiguration des Objekts auf Gültigkeit. Sie gibt einen booleschen Wert zurück, dessen Wert „**True**“ lautet, wenn das Objekt gültig ist, und andernfalls „**False**“. Im letzteren Fall wird die Variable, deren Name in *msgvar* gespeichert ist, auf eine Fehlermeldung gesetzt, die das bei der Konfiguration festgestellte Problem beschreibt. Andernfalls bleibt diese Variable unverändert.

*objectName* **receive** *channel* *done*
: Diese Methode leitet den Empfang von Daten aus dem angegebenen *channel* ein. Die empfangenen Daten werden über Aufrufe der Methoden **put** und **done** im konfigurierten Ziel gespeichert. Wenn der Empfang abgeschlossen ist, wird das Befehlspräfix *done* aufgerufen, wobei die Anzahl der empfangenen Zeichen als einziges zusätzliches Argument angehängt wird.


## Optionen

Alle Datenziele unterstützen die unten aufgeführten Optionen. Zu beachten ist, dass alle Optionen halb-exklusiv sind und jeweils einen anderen Zieltyp sowie zugehörige Informationen festlegen. Werden diese Optionen mehrmals angegeben, wird die zuletzt angegebene Option zur tatsächlichen Konfiguration des Objekts herangezogen.

**-channel** *handle*
: Diese Option legt fest, dass das Ziel der Daten ein Kanal ist, und das zugehörige Argument ist das Handle des Kanals, in den die empfangenen Daten geschrieben werden sollen.

**-file** *path*
: Diese Option legt fest, dass das Ziel der Daten eine Datei ist, und das zugehörige Argument ist der Pfad der Datei, in die die empfangenen Daten geschrieben werden sollen.

**-variable** *varname*
: Diese Option legt fest, dass das Ziel der Daten eine Variable ist, und das zugehörige Argument enthält den Namen der Variable, in die die empfangenen Daten geschrieben werden sollen. Es wird davon ausgegangen, dass es sich um eine globale Variable oder eine Variable im Namespace handelt, die im globalen Namespace verankert ist.

**-progress** *command*
: Wenn diese Option festgelegt ist, wird damit ein Befehl definiert, der für jeden empfangenen Byte-Block aufgerufen wird, sodass der Benutzer den Fortschritt des Datenempfangs überwachen kann. Die Rückruffunktion wird stets mit einem zusätzlichen Argument aufgerufen, nämlich der Anzahl der bisher empfangenen Bytes.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *transfer* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Transfermodul

# COPYRIGHT

```
Copyright (c) 2006-2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
