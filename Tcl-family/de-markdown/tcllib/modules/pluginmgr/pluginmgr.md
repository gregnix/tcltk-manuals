---
CommandName: pluginmgr
title: pluginmgr
ManualSection: n
Version: 0.5
TclPart: tcllib
TclDescription: Plugin management
Keywords:
 - plugin management
 - plugin search
Copyright:
 - Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

pluginmgr – Ein Plugin verwalten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pluginmgr]{.lit} [0.5]{.optlit}
[::pluginmgr]{.cmd} [objectName]{.arg} [option value...]{.optarg}
[::pluginmgr::paths]{.cmd} [objectName]{.arg} [name...]{.arg}
[objectName]{.cmd} [method]{.lit} [arg arg]{.optdot}
[objectName]{.ins} [clone]{.sub}
[objectName]{.ins} [configure]{.sub}
[objectName]{.ins} [configure]{.sub} [option]{.arg}
[objectName]{.ins} [configure]{.sub} [-option]{.lit} [value...]{.arg}
[objectName]{.ins} [cget]{.sub} [-option]{.lit}
[objectName]{.ins} [destroy]{.sub}
[objectName]{.ins} [do]{.sub} [arg...]{.arg}
[objectName]{.ins} [interpreter]{.sub}
[objectName]{.ins} [plugin]{.sub}
[objectName]{.ins} [load]{.sub} [string]{.arg}
[objectName]{.ins} [unload]{.sub}
[objectName]{.ins} [list]{.sub}
[objectName]{.ins} [path]{.sub} [path]{.arg}
[objectName]{.ins} [paths]{.sub}
:::

# Beschreibung

Dieses Paket stellt Befehle und Objekte für die allgemeine Verwaltung von Plugins bereit, die in eine Anwendung geladen werden können.

Um die Einführung eines weiteren Systems zur Lokalisierung von Tcl-Code zu vermeiden, baut das von diesem Paket bereitgestellte System auf dem regulären Paketverwaltungssystem auf. Jedes Plugin gilt als Paket, und ein einfacher Aufruf von **package require** genügt, um es zu finden und zu laden, sofern es vorhanden ist. Zusätzliche Pfade werden nur dann benötigt, wenn ein Plugin-Manager Teil einer verpackten Anwendung ist und nach Plugins suchen muss, die außerhalb dieser Anwendung vorhanden sind. Für diesen Fall stellt das Paket einen Befehl bereit, mit dem sich ein allgemeiner Satz solcher Pfade anhand der Namen des betreffenden Plugin-Managers und/oder der betreffenden Anwendung erstellen lässt.

Der wichtigste Beitrag dieses Pakets ist ein generischer Rahmen, der die einfache Deklaration von

1. Wie der Name eines Plugins in den Namen des Pakets übersetzt wird, das es implementiert, und umgekehrt.

2. Die Liste der Befehle, die ein Plugin als API bereitstellen muss, sowie die Liste komplexerer Prüfungen in Form von Code.

3. Die Liste der Befehle, die das Plugin von der Umgebung erwartet.


Das ermöglicht dann die einfache Erstellung von Plugin-Managern, die auf bestimmte Plugin-Typen einer Anwendung zugeschnitten sind.

Der gesamte Plugin-Code gilt als nicht vertrauenswürdig und wird stets in einem sicheren Interpreter ausgeführt. Der Interpreter ist hinreichend freigeschaltet, damit Plugins alle zusätzlich benötigten Pakete laden können.

# Öffentliche API

## Paketbefehle

**::pluginmgr** *objectName* ?*option value*...?
: Dieser Befehl erstellt ein neues Plugin-Manager-Objekt mit einem zugehörigen Tcl-Befehl, dessen Name *objectName* lautet. Dieser *object*-Befehl wird in den Abschnitten [Objektbefehl] und [Objektmethoden] ausführlich erläutert. Der Objektbefehl wird im aktuellen Namespace erstellt, wenn *objectName* nicht vollständig qualifiziert ist, andernfalls im angegebenen Namespace.

    Die Optionen und ihre Werte nach dem Namen des Objekts legen die Anfangskonfiguration des Manager-Objekts fest und geben die zutreffenden Plugins sowie deren API an.

**::pluginmgr::paths** *objectName* *name*...
: Dieser Hilfsbefehl fügt dem angegebenen Objekt eine Reihe von Pfaden hinzu, basierend auf den angegebenen *name*s. Er sucht nach:

    1. Die Umgebungsvariable *name*\_PLUGINS. Ihr Inhalt wird als Liste von Paketpfaden interpretiert. Die Einträge müssen entweder durch **:** (unix) oder **;** (windows) getrennt sein.

        Der Name wird in Großbuchstaben umgewandelt.

    2. Der Registrierungseintrag "HKEY\_LOCAL\_MACHINE\\SOFTWARE\\*name*\\PLUGINS". Sein Inhalt wird als Liste von Paketpfaden interpretiert. Die Einträge müssen durch **;** getrennt sein. Dieser Eintrag wird nur unter Windows (tm) berücksichtigt.

        Die Groß- und Kleinschreibung der Buchstaben wird nicht geändert.

    3. Der Registrierungseintrag "HKEY\_CURRENT\_USER\\SOFTWARE\\*name*\\PLUGINS". Sein Inhalt wird als Liste von Paketpfaden interpretiert. Die Einträge müssen durch **;** getrennt sein. Dieser Eintrag wird nur unter Windows (tm) berücksichtigt.

        Die Groß- und Kleinschreibung der Buchstaben wird nicht geändert.

    4. Das Verzeichnis "*~/.name*/plugin".

    5. Das Verzeichnis "*~/.name*/plugins".

        Die Groß- und Kleinschreibung der Buchstaben wird nicht geändert.


    Er fügt alle auf diese Weise gefundenen Pfade zur Liste der vom Objekt verwalteten Paketpfade hinzu.

    Wenn *name* einen Namespace-Pfad enthält, wird jedes Element der Liste für jedes Präfix von *name* wiederholt, wobei :-Folgen in das passende Trennzeichen umgewandelt werden (Unterstrich für Umgebungsvariablen, Backslash für Registrierungseinträge und / für Verzeichnisse).

    Beispiele:

    ```
        ::pluginmgr::paths ::obj docidx

        => env  DOCIDX_PLUGINS
           reg  HKEY_LOCAL_MACHINE\SOFTWARE\docidx\PLUGINS
           reg  HKEY_CURRENT_USER\SOFTWARE\docidx\PLUGINS
           path ~/.docidx/plugins

        ::pluginmgr::paths ::obj doctools::idx

        => env  DOCTOOLS_PLUGINS
           env  DOCTOOLS_IDX_PLUGINS
           reg  HKEY_LOCAL_MACHINE\SOFTWARE\doctools\PLUGINS
           reg  HKEY_LOCAL_MACHINE\SOFTWARE\doctools\idx\PLUGINS
           reg  HKEY_CURRENT_USER\SOFTWARE\doctools\PLUGINS
           reg  HKEY_CURRENT_USER\SOFTWARE\doctools\idx\PLUGINS
           path ~/.doctools/plugin
           path ~/.doctools/idx/plugin
    ```


## Objektbefehl

Alle Befehle, die durch den Befehl **::pluginmgr** erstellt wurden (siehe Abschnitt [Paketbefehle]), haben die folgende allgemeine Form und können verwendet werden, um verschiedene Operationen auf ihrem Plugin-Manager-Objekt auszuführen.

**objectName** **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt [Objektmethoden].


## Objektmethoden

*objectName* **clone**
: Diese Methode erstellt ein neues Plugin-Verwaltungsobjekt und gibt den zugehörigen Objektbefehl zurück. Das erzeugte Objekt ist ein Klon des Objekts, auf das die Methode angewendet wurde. Das neue Objekt hat also dieselbe Konfiguration wie das aktuelle Objekt. Was den Zustand betrifft: Wenn im aktuellen Objekt ein Plugin geladen ist, werden dieses Plugin und der gesamte zugehörige Zustand in den erzeugten Klon verschoben, und das aktuelle Objekt wird in den Grundzustand zurückgesetzt (kein Plugin geladen). Auf diese Weise ist ein konfigurierter Plugin-Manager auch eine Fabrik für geladene Plugins.

*objectName* **configure**
: Die Methode gibt eine Liste aller bekannten Optionen und deren aktuelle Werte zurück, wenn sie ohne Argumente aufgerufen wird.

*objectName* **configure** *option*
: Die Methode verhält sich wie die Methode **cget**, wenn sie mit einem einzigen Argument aufgerufen wird, und gibt den Wert der durch dieses Argument festgelegten Option zurück.

*objectName* **configure** **-option** *value*...
: Die Methode konfiguriert die angegebenen **option**s des Objekts neu und setzt sie auf die zugehörigen *value*s, wenn sie mit einer geraden Anzahl von Argumenten (mindestens zwei) aufgerufen wird.

    Die zulässigen Optionen sind im Abschnitt [Objekt-Konfiguration] beschrieben.

*objectName* **cget** **-option**
: Diese Methode erwartet eine zulässige Konfigurationsoption als Argument und gibt den aktuellen Wert dieser Option für das Objekt zurück, für das die Methode aufgerufen wurde.

    Die zulässigen Konfigurationsoptionen sind im Abschnitt [Objekt-Konfiguration] beschrieben.

*objectName* **destroy**
: Diese Methode löscht das Objekt, für das sie aufgerufen wird.

*objectName* **do** *arg*...
: Diese Methode interpretiert ihre Argumentliste als die Wörter eines Befehls und führt diesen Befehl im Ausführungskontext des Plugins aus. Das Ergebnis des ausgeführten Befehls wird zum Ergebnis der Methode. Der Aufruf schlägt mit einer Fehlermeldung fehl, wenn kein gültiges Plugin in das Manager-Objekt geladen wurde.

*objectName* **interpreter**
: Diese Methode gibt das Handle des sicheren Interpreters zurück, in den das aktuelle Plugin geladen ist. Eine leere Zeichenkette als Rückgabewert zeigt an, dass der Manager derzeit kein gültiges Plugin geladen hat.

*objectName* **plugin**
: Diese Methode gibt den Namen des aktuell geladenen Plugins zurück. Eine leere Zeichenkette als Rückgabewert zeigt an, dass der Manager derzeit kein gültiges Plugin geladen hat.

*objectName* **load** *string*
: Diese Methode lädt ein benanntes Plugin, führt die Validierung des Plugins durch und initialisiert es im Manager-Objekt.

    Der zum Auffinden und Laden des Plugins verwendete Algorithmus lautet wie folgt:

    1. Wenn die *string* den Pfad zu einer vorhandenen Datei enthält, wird diese Datei als Implementierung des Plugins verwendet.

    2. Andernfalls wird der Name des Plugins anhand des Werts der Option **-pattern** in einen Paketnamen übersetzt und anschließend über die reguläre Paketverwaltung geladen.

    3. Der Ladevorgang schlägt fehl.


    Der Algorithmus zur Validierung und Initialisierung des geladenen Codes lautet wie folgt:

    1. Wenn die Option **-api** nicht leer ist, werden Introspektionsbefehle verwendet, um sicherzustellen, dass das Plugin die aufgeführten Befehle bereitstellt.

    2. Wenn die Option **-check** nicht leer ist, wird das angegebene Befehlspräfix aufgerufen.

    3. Wenn einer der beiden oben genannten Schritte fehlschlägt, wird das Kandidaten-Plugin wieder entladen.

    4. Ansonsten werden alle über die Option **-cmds** angegebenen Befehle im Plugin installiert.


    Ein zuvor geladenes Plugin wird verworfen, jedoch nur, wenn das neue Plugin gefunden und erfolgreich validiert sowie initialisiert wurde. Dabei kommt es zu keiner gegenseitigen Beeinflussung von altem und neuem Plugin, da beide in getrennte sichere Interpreter gelegt werden.

*objectName* **unload**
: Diese Methode entlädt das aktuell geladene Plugin. Sie gibt die leere Zeichenkette zurück. Der Aufruf wird stillschweigend ignoriert, wenn überhaupt kein Plugin geladen ist.

*objectName* **list**
: Diese Methode nutzt den Inhalt der Option **-pattern**, um alle Pakete zu ermitteln, die als Plugins im Zuständigkeitsbereich dieses Manager-Objekts gelten können. Sie wandelt deren Namen in Plugin-Namen um und gibt eine Liste zurück, die diese enthält.

*objectName* **path** *path*
: Diese Methode fügt den angegebenen *path* zur Liste der zusätzlichen Paketpfade hinzu, die bei der Suche nach einem Plugin berücksichtigt werden. Sie gibt die leere Zeichenkette zurück. Doppelte Pfade werden ignoriert, d. h. jeder Pfad wird nur einmal hinzugefügt. Pfade werden absolut gemacht, jedoch nicht normalisiert.

*objectName* **paths**
: Diese Methode gibt eine Liste zurück, die alle zusätzlichen Pfade enthält, die dem Plugin-Manager-Objekt seit dessen Erstellung hinzugefügt wurden.


## Objekt-Konfiguration

Alle Plugin-Manager-Objekte unterstützen die folgenden Konfigurationsoptionen:

**-pattern** *string*
: Der Wert dieser Option ist ein Glob-Muster, das genau einen '\*'-Operator enthalten muss. Alle Pakete, deren Namen diesem Muster entsprechen, sind die vom Manager-Objekt erkannten Plugins. Umgekehrt ergibt das Ersetzen des '\*'-Operators durch einen Plugin-Namen den Namen des Pakets, das dieses Plugin implementiert.

    Diese Option hat keinen Vorgabewert, es sei denn, die Option **-name** wurde gesetzt. Sie muss gesetzt werden, bevor versucht wird, ein Plugin zu laden, entweder direkt oder über die Option **-name**.

**-api** *list*
: Der Wert dieser Option ist eine Liste von Befehlsnamen, und jedes geladene Plugin muss diese Befehle bereitstellen. Namen, die nicht vollständig qualifiziert sind, gelten als im globalen Namespace verortet. Wenn die Liste leer ist, werden keine Erwartungen an das Plugin gestellt. Der Standardwert ist die leere Liste.

**-check** *cmdprefix*
: Der Wert dieser Option wird als Befehlspräfix interpretiert. Sein Zweck besteht darin, komplexe Prüfungen an einem geladenen Plugin-Paket durchzuführen, um dessen Gültigkeit zu überprüfen; diese Prüfungen gehen über eine einfache Liste der bereitgestellten Befehle hinaus.

    Die Funktion wird mit dem Objektbefehl des Manager-Objekts als einzigem Argument aufgerufen und muss einen booleschen Wert zurückgeben. Ein Wert von **true** wird so interpretiert, dass das betreffende Plugin den Test bestanden hat. Der Aufruf erfolgt genau dann, wenn das betreffende Plugin bereits die über die Option **-api** festgelegte grundlegende API-Prüfung bestanden hat.

    Der Standardwert ist eine leere Liste, was dazu führt, dass das Manager-Objekt den Aufruf unterdrückt und davon ausgeht, dass das Kandidaten-Plugin den Test bestanden hat.

**-cmds** *dict*
: Der Wert dieser Option ist ein Dictionary. Es legt die Befehle fest, die dem Plugin zur Verfügung gestellt werden (als Schlüssel), sowie die vertrauenswürdigen Befehle in der Umgebung, die diese implementieren (als Werte). Die vertrauenswürdigen Befehle werden in dem durch die Option **-cmdip** angegebenen Interpreter ausgeführt. Der Standardwert ist ein leeres Dictionary.

**-cmdip** *ipspec*
: Der Wert dieser Option ist der Pfad des Interpreters, in dem die dem Plugin übergebenen vertrauenswürdigen Befehle ausgeführt werden. Der Standardwert ist eine leere Zeichenkette, die sich auf den aktuellen Interpreter bezieht.

**-setup** *cmdprefix*
: Der Wert dieser Option wird als Befehlspräfix interpretiert.

    Er wird immer dann aufgerufen, wenn ein neuer sicherer Interpreter für ein Plugin erstellt wurde, jedoch noch bevor das Plugin geladen wird. Als einzige Argumente werden ihm der Objektbefehl des Managers und das Interpreter-Handle übergeben. Jeder Rückgabewert wird ignoriert.

    Der Zweck besteht darin, einem Benutzer der Plugin-Verwaltung die Möglichkeit zu geben, Befehle, Pakete usw. zu definieren, die ein ausgewähltes Plugin beim Laden möglicherweise benötigt.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pluginmgr* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge

# Copyright

```
Copyright (c) 2005 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
