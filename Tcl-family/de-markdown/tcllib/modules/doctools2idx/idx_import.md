---
CommandName: doctools::idx::import
title: doctools::idx::import
ManualSection: n
Version: 0.2.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - conversion
 - docidx
 - documentation
 - import
 - index
 - json
 - keyword index
 - manpage
 - markup
 - parsing
 - plugin
 - reference
 - url
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::idx::import – Import von Schlüsselwortindizes

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::idx::import]{.lit} [0.2.2]{.optlit}
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::map]{.lit}
[package]{.cmd} [require]{.sub} [doctools::idx::structure]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [pluginmgr]{.lit}
[::doctools::idx::import]{.cmd} [objectName]{.arg}
[objectName]{.cmd} [method]{.lit} [arg arg]{.optdot}
[objectName]{.ins} [destroy]{.sub}
[objectName]{.ins} [import]{.sub} [text]{.lit} [text]{.arg} [format]{.optarg}
[objectName]{.ins} [import]{.sub} [file]{.lit} [path]{.arg} [format]{.optarg}
[objectName]{.ins} [import]{.sub} [object]{.lit} [text]{.lit} [object]{.arg} [text]{.arg} [format]{.optarg}
[objectName]{.ins} [import]{.sub} [object]{.lit} [file]{.lit} [object]{.arg} [path]{.arg} [format]{.optarg}
[objectName]{.ins} [config]{.sub} [names]{.lit}
[objectName]{.ins} [config]{.sub} [get]{.lit}
[objectName]{.ins} [config]{.sub} [set]{.lit} [name]{.arg} [value]{.optarg}
[objectName]{.ins} [config]{.sub} [unset]{.lit} [pattern...]{.arg}
[objectName]{.ins} [includes]{.sub}
[objectName]{.ins} [include]{.sub} [add]{.lit} [path]{.arg}
[objectName]{.ins} [include]{.sub} [remove]{.lit} [path]{.arg}
[objectName]{.ins} [include]{.sub} [clear]{.lit}
[IncludeFile]{.cmd} [currentfile]{.arg} [path]{.arg}
[import]{.cmd} [text]{.arg} [configuration]{.arg}
:::

# Beschreibung

Dieses Paket stellt eine Klasse zur Verwaltung der Plugins für den Import von Schlüsselwortindizes aus anderen Formaten bereit, d. h. für deren Konvertierung aus beispielsweise *docidx*, *json* usw.

Dies ist eine der drei öffentlichen Säulen, auf denen die Verwaltung von Schlüsselwortindizes ruht. Die beiden anderen Säulen sind

1. *Export von Schlüsselwortindizes* sowie

2. *Halten von Schlüsselwortindizes*


Informationen über [Begriffe] von Schlüsselwortindizes und ihre Bestandteile stehen im gleichnamigen Abschnitt. Informationen über die Datenstruktur, die die wesentliche Ausgabe der von diesem Paket bereitgestellten Manager-Objekte ist, stehen im Abschnitt [Serialisierungsformat für Schlüsselwortindizes].

Das Plugin-System unserer Klasse basiert auf dem Paket **pluginmgr** und ist so konfiguriert, dass es nach Plugins sucht, die

1. die Umgebungsvariable **DOCTOOLS\_IDX\_IMPORT\_PLUGINS**,

2. die Umgebungsvariable **DOCTOOLS\_IDX\_PLUGINS**,

3. die Umgebungsvariable **DOCTOOLS\_PLUGINS**,

4. der Pfad „*~/.doctools/idx/import/plugin*“

5. der Pfad „*~/.doctools/idx/plugin*“

6. der Pfad „*~/.doctools/plugin*“

7. der Pfad „*~/.doctools/idx/import/plugins*“

8. der Pfad „*~/.doctools/idx/plugins*“

9. der Pfad „*~/.doctools/plugins*“

10. der Registrierungseintrag „HKEY\_CURRENT\_USER\\SOFTWARE\\DOCTOOLS\\IDX\\IMPORT\\PLUGINS“

11. der Registrierungseintrag „HKEY\_CURRENT\_USER\\SOFTWARE\\DOCTOOLS\\IDX\\PLUGINS“

12. der Registrierungseintrag „HKEY\_CURRENT\_USER\\SOFTWARE\\DOCTOOLS\\PLUGINS“.


Die letzten drei werden nur verwendet, wenn das Paket auf einem Rechner mit dem Betriebssystem Windows(tm) ausgeführt wird.

Das gesamte System wird mit zwei vordefinierten Import-Plugins ausgeliefert, nämlich

docidx
: Weitere Informationen finden Sie unter *docidx-Import-Plugin*.

json
: Weitere Informationen finden Sie unter *JSON-Import-Plugin*.


Für Leser, die ein eigenes Import-Plugin für ein bestimmtes Format erstellen möchten – d. h. für *Plugin-Entwickler* –, ist es unbedingt erforderlich, den Abschnitt zu lesen und zu verstehen, der die [Referenz zur Import-Plugin-API v2] enthält, da darin die Interaktion zwischen diesem Paket und seinen Plugins detailliert festgelegt wird.

# Begriffe

1. Ein *Schlüsselwortindex* besteht aus einer (möglicherweise leeren) Menge von *Schlüsselwörtern*.

2. Jedes Schlüsselwort in der Menge wird durch seinen Namen identifiziert.

3. Jedes Schlüsselwort verfügt über eine (möglicherweise leere) Menge von *Referenzen*.

4. Eine Referenz kann mit mehr als einem Schlüsselwort verknüpft sein.

5. Eine Referenz, die nicht mit mindestens einem Schlüsselwort verknüpft ist, ist jedoch nicht möglich.

6. Jede Referenz wird durch ihr Ziel identifiziert, das je nach Referenztyp (**url** oder **manpage**) entweder als URL oder als symbolischer Dateiname angegeben wird.

7. Der Typ einer Referenz (URL oder manpage) hängt nur von der Referenz selbst ab und nicht von den Schlüsselwörtern, denen sie zugeordnet ist.

8. Zusätzlich zu einem Typ verfügt jede Referenz auch über eine beschreibende Bezeichnung. Diese Bezeichnung hängt ausschließlich von der Referenz selbst ab und nicht von den Schlüsselwörtern, denen sie zugeordnet ist.


Einige Hinweise

1. manpage-Referenzen sind für Verweise auf die Dokumente gedacht, für die der Index erstellt wurde. Ihr Ziel ist ein symbolischer Dateiname, der das Dokument identifiziert, und Export-Plugins können symbolische durch tatsächliche Dateinamen ersetzen, wenn das festgelegt ist.

2. URL-Referenzen hingegen sind für Verweise auf alles andere gedacht, etwa Websites. Ihr Ziel ist eine URL.

3. URL- und manpage-Referenzen teilen sich zwar einen Namensraum für ihre Bezeichner, das sollte jedoch kein Problem sein, denn manpage-Bezeichner sind symbolische Dateinamen und sollten daher nie wie URLs aussehen, die Bezeichner der URL-Referenzen.


# API

## Paketbefehle

**::doctools::idx::import** *objectName*
: Dieser Befehl erstellt ein neues Import-Manager-Objekt mit einem zugehörigen Tcl-Befehl, dessen Name *objectName* lautet. Dieser *object*-Befehl wird in den Abschnitten [Objektbefehl] und [Objektmethoden] ausführlich erläutert. Der Objektbefehl wird unter dem aktuellen Namespace erstellt, wenn *objectName* nicht vollständig qualifiziert ist; andernfalls erfolgt die Erstellung im angegebenen Namespace.


## Objektbefehl

Alle mit dem Befehl **::doctools::idx::import** erstellten Objekte haben die folgende allgemeine Form:

**objectName** **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt [Objektmethoden].


## Objektmethoden

*objectName* **destroy**
: Diese Methode löscht das Objekt, für das sie aufgerufen wird.

*objectName* **import text** *text* ?*format*?
: Diese Methode nimmt den *text* und wandelt ihn mit dem Import-Plugin für das angegebene *format* in die kanonische Serialisierung eines Schlüsselwortindexes um. Wird kein Plugin für das Format gefunden, wird ein Fehler ausgelöst. Die durch den Konvertierungsprozess erzeugte Serialisierung wird als Ergebnis dieser Methode zurückgegeben.

    Wenn kein Format festgelegt wird, verwendet die Methode standardmäßig **docidx**.

    Die Spezifikation dessen, was eine *kanonische* Serialisierung ist, finden Sie im Abschnitt [Serialisierungsformat für Schlüsselwortindizes].

    Das Plugin muss der im Abschnitt [Referenz zur Import-Plugin-API v2] spezifizierten Schnittstelle entsprechen.

*objectName* **import file** *path* ?*format*?
: Diese Methode ist eine praktische Hülle um die im vorherigen Punkt beschriebene Methode **import text**. Sie liest den Inhalt der angegebenen Datei in den Arbeitsspeicher ein, übergibt das Ergebnis an **import text** und gibt die daraus resultierende Serialisierung als eigenes Ergebnis zurück.

*objectName* **import object text** *object* *text* ?*format*?
: Diese Methode ist eine praktische Hülle um die im vorherigen Punkt beschriebene Methode **import text**. Sie setzt voraus, dass *object* ein Objektbefehl ist, der eine **deserialize**-Methode unterstützt, welche die kanonische Serialisierung eines Schlüsselwortindexes erwartet. Sie importiert den Text mithilfe von **import text** und übergibt die resultierende Serialisierung anschließend über **deserialize** an das *object*. Diese Methode gibt als Ergebnis die leere Zeichenkette zurück.

*objectName* **import object file** *object* *path* ?*format*?
: Diese Methode verhält sich wie **import object text**, mit dem Unterschied, dass sie den zu konvertierenden Text aus der angegebenen Datei liest, anstatt ihn als Argument zu erhalten.

*objectName* **config names**
: Diese Methode gibt eine Liste zurück, die die Namen aller dem Objekt derzeit bekannten Konfigurationsvariablen enthält.

*objectName* **config get**
: Diese Methode gibt ein Dictionary zurück, das die Namen und Werte aller dem Objekt derzeit bekannten Konfigurationsvariablen enthält.

*objectName* **config set** *name* ?*value*?
: Diese Methode setzt die Konfigurationsvariable *name* auf den angegebenen *value* und gibt den neuen Wert der Variablen zurück.

    Wird kein Wert angegeben, gibt sie lediglich den aktuellen Wert zurück, ohne ihn zu ändern.

    Hinweis: Der Benutzer kann zwar die vordefinierten Konfigurationsvariablen **user** und **format** setzen, dies hat jedoch keine Auswirkungen; diese Werte werden intern beim Aufruf eines Import-Plugins überschrieben.

*objectName* **config unset** *pattern*...
: Diese Methode löscht alle Konfigurationsvariablen, auf die die angegebenen *pattern*s passen. Wird kein Muster angegeben, löscht sie alle derzeit definierten Konfigurationsvariablen.

*objectName* **includes**
: Diese Methode gibt eine Liste zurück, die die derzeit festgelegten Pfade enthält, die bei der Verarbeitung der Eingabe zur Suche nach Include-Dateien verwendet werden sollen. Die Reihenfolge der Pfade in der Liste entspricht der Reihenfolge, in der sie verwendet werden – vom ersten bis zum letzten –, und entspricht zudem der Reihenfolge, in der sie dem Objekt hinzugefügt wurden.

*objectName* **include add** *path*
: Diese Methode fügt den angegebenen *path* zur Liste der Pfade hinzu, in denen bei der Verarbeitung der Eingabe nach Include-Dateien gesucht wird. Der Pfad wird am Ende der Liste angehängt, sodass er erst nach allen zuvor hinzugefügten Pfaden durchsucht wird. Das Ergebnis des Befehls ist die leere Zeichenkette.

    Die Methode führt keine Aktion aus, wenn der Pfad bereits bekannt ist.

*objectName* **include remove** *path*
: Diese Methode entfernt den angegebenen *path* aus der Liste der Pfade, die bei der Verarbeitung der Eingabe zur Suche nach Include-Dateien herangezogen werden. Das Ergebnis des Befehls ist die leere Zeichenkette.

    Die Methode führt keine Aktion aus, wenn der Pfad nicht bekannt ist.

*objectName* **include clear**
: Diese Methode löscht die Liste der Pfade, die bei der Verarbeitung der Eingabe zur Suche nach Include-Dateien herangezogen werden. Das Ergebnis des Befehls ist die leere Zeichenkette.


# Referenz zur Import-Plugin-API v2

Dieses Paket nutzt Plugins, um die Unterstützung für alle Eingabeformate zu verwalten, die über das [Serialisierungsformat für Schlüsselwortindizes] hinausgehen. Hier legen wir die API fest, über die die von diesem Paket erstellten Objekte mit ihren Plugins interagieren.

Ein Plugin für dieses Paket muss die nachfolgend aufgeführten Regeln einhalten:

1. Ein Plugin ist ein Paket.

2. Der Name eines Plugin-Pakets hat die Form doctools::idx::import::**FOO**, wobei **FOO** der Name des Formats ist, das das Plugin einliest. Dieser Name ist zugleich das Argument, das den verschiedenen **import**-Methoden von Import-Manager-Objekten übergeben werden muss, um die kanonische Serialisierung eines Schlüsselwortindexes aus diesem Format zu erhalten.

3. Das Plugin kann davon ausgehen, dass das Paket **doctools::idx::export::plugin** vorhanden ist, was darauf hindeutet, dass es von einem echten Plugin-Manager aufgerufen wurde.

4. Das Plugin kann davon ausgehen, dass ein Befehl **IncludeFile** vorhanden ist, mit der Signatur

    **IncludeFile** *currentfile* *path*
    : Dieser Befehl muss vom Plugin aufgerufen werden, wenn es eine eingebundene Datei verarbeiten soll, wenn das Format ein solches Konzept vorsieht. Ein Beispiel für ein solches Format wäre *docidx*.

        Das Plugin muss die folgenden Argumente übergeben

        string *currentfile*
        : Der Pfad der Datei, die es gerade verarbeitet. Das kann die leere Zeichenkette sein, wenn keiner bekannt ist.

        string *path*
        : Der Pfad der Include-Datei, wie ihn die gerade verarbeitete Include-Anweisung angibt.


        Das Ergebnis des Befehls ist eine Liste mit fünf Elementen, die Folgendes enthält:

        1. Ein boolesches Flag, das Erfolg (**True**) oder Misserfolg (**False**) des Vorgangs angibt.

        2. Im Erfolgsfall den Inhalt der eingebundenen Datei, andernfalls die leere Zeichenkette.

        3. Der aufgelöste, d. h. der absolute Pfad der eingebundenen Datei, sofern möglich, oder das unveränderte *path*-Argument. Dies dient zur Anzeige in einer Fehlermeldung oder als *currentfile*-Argument eines weiteren Aufrufs von **IncludeFile**, falls diese Datei weitere Dateien enthält.

        4. Im Erfolgsfall eine leere Zeichenkette und im Fehlerfall einen Code, der den Grund dafür angibt, und zwar einen der folgenden:

            notfound
            : Die angegebene Datei konnte nicht gefunden werden.

            notread
            : Die angegebene Datei wurde gefunden, konnte jedoch nicht in den Arbeitsspeicher geladen werden.


        5. Eine leere Zeichenfolge im Falle eines Erfolgs oder eines Fehlers mit dem Code **notfound** sowie eine zusätzliche Fehlermeldung, die den Grund für einen Fehler mit dem Code **notread** näher erläutert.



5. Ein Plugin muss einen Befehl bereitstellen, dessen Signatur wie unten dargestellt lautet.

    **import** *text* *configuration*
    : Immer wenn ein Importmanager von **doctools::idx** Eingabedaten für einen Index auswerten muss, wird dieser Befehl aufgerufen.

        string *text*
        : Dieses Argument enthält den Text, der den Index in dem Format kodiert, für das das Plugin bestimmt ist.

        dictionary *configuration*
        : Dieses Argument enthält die beim Parsen anzuwendende Konfiguration, als Dictionary von Variablennamen auf Werte.

            Die folgenden Konfigurationsvariablen haben eine vorgegebene Bedeutung, an die sich alle Plugins halten müssen, auch wenn sie diese Angabe nach eigenem Ermessen ignorieren können. Jede weitere Konfigurationsvariable, die ein Plugin erkennt, ist in der Handbuchseite dieses Plugins beschrieben.

            user
            : Diese Variable soll den Namen des Benutzers enthalten, dem der Prozess gehört, der das Plugin aufruft.

            format
            : Diese Variable soll den Namen des Formats enthalten, dessen Plugin aufgerufen wird.




6. Ein einzelner Nutzungszyklus eines Plugins besteht aus den Aufrufen des Befehls **import**. Dieser Aufruf muss das Plugin in einem Zustand hinterlassen, in dem ein weiterer Nutzungszyklus problemlos ausgeführt werden kann.


# Serialisierungsformat für Schlüsselwortindizes

Hier legen wir das Format fest, das von den doctools-v2-Paketen verwendet wird, um Schlüsselwortindizes als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Ein Schlüsselwortindex kann zwar mehr als eine reguläre Serialisierung aufweisen, doch genau eine davon ist *kanonisch*.

reguläre Serialisierung
: 1. Eine Index-Serialisierung ist ein verschachteltes Tcl-Dictionary.

    2. Dieses Dictionary enthält einen einzigen Schlüssel, **doctools::idx**, sowie dessen Wert. Dieser Wert enthält den Inhalt des Index.

    3. Der Inhalt des Indexes besteht aus einem Tcl-Dictionary, das den Titel des Indexes, eine Bezeichnung sowie die Schlüsselwörter und Verweise enthält. Die entsprechenden Schlüssel und ihre Werte lauten

        **title**
        : Der Wert ist eine Zeichenkette, die den Titel des Indexes enthält.

        **label**
        : Der Wert ist eine Zeichenkette, die eine Bezeichnung für den Index enthält.

        **keywords**
        : Der Wert ist ein Tcl-Dictionary, das die dem Index bekannten Schlüsselwörter als Schlüssel verwendet. Die zugehörigen Werte sind Listen, die die Bezeichner der Referenzen enthalten, die diesem bestimmten Schlüsselwort zugeordnet sind.

            Jeder in diesen Listen verwendete Referenzbezeichner muss als Schlüssel im Dictionary **references** vorhanden sein; dessen Definition steht im nächsten Punkt.

        **references**
        : Der Wert ist ein Tcl-Dictionary, das die dem Index bekannten Bezeichner der Referenzen als Schlüssel verwendet. Die zugehörigen Werte sind Listen mit zwei Elementen, die in dieser Reihenfolge den Typ und die Bezeichnung der Referenz enthalten.

            Jeder Schlüssel hier muss mindestens einem Schlüsselwort zugeordnet sein, d. h., er muss in mindestens einer der Referenzlisten vorkommen, die die Werte im Dictionary **keywords** bilden; die Definition hierfür steht im vorherigen Punkt.


    4. Der *type* einer Referenz kann einen von zwei Werten annehmen,

        **manpage**
        : Der Bezeichner der Referenz wird als symbolischer Dateiname interpretiert, der sich auf eines der Dokumente bezieht, für die der Index erstellt wurde.

        **url**
        : Der Bezeichner der Referenz wird als URL interpretiert, die auf einen externen Ort verweist, beispielsweise eine Website usw.



kanonische Serialisierung
: Die kanonische Serialisierung eines Schlüsselwortindexes hat das im vorherigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen des Schlüsselwortindexes eindeutig ist.

    1. Die Schlüssel in allen verschachtelten Tcl-Dictionaries sind in aufsteigender Wörterbuchreihenfolge sortiert, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.

    2. Die für jedes Schlüsselwort des Indexes aufgeführten Referenzen – sofern vorhanden – werden in aufsteigender Wörterbuchordnung ihrer *Bezeichnungen* aufgelistet, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.



# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Dokumentationswerkzeuge

# Copyright

```
Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
