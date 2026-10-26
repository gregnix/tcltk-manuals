---
CommandName: doctools::toc::export
title: doctools::toc::export
ManualSection: n
Version: 0.2.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - HTML
 - conversion
 - doctoc
 - documentation
 - export
 - formatting
 - generation
 - json
 - manpage
 - markup
 - nroff
 - plugin
 - reference
 - table
 - table of contents
 - tcler's wiki
 - text
 - url
 - wiki
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

doctools::toc::export – Exportieren von Inhaltsverzeichnissen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::toc::export]{.lit} [0.2.2]{.optlit}
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::map]{.lit}
[package]{.cmd} [require]{.sub} [doctools::toc::structure]{.lit}
[package]{.cmd} [require]{.sub} [snit]{.lit}
[package]{.cmd} [require]{.sub} [pluginmgr]{.lit}
[::doctools::toc::export]{.cmd} [objectName]{.arg}
[objectName]{.cmd} [method]{.lit} [arg arg]{.optdot}
[objectName]{.ins} [destroy]{.sub}
[objectName]{.ins} [export]{.sub} [serial]{.lit} [serial]{.arg} [format]{.optarg}
[objectName]{.ins} [export]{.sub} [object]{.lit} [object]{.arg} [format]{.optarg}
[objectName]{.ins} [config]{.sub} [names]{.lit}
[objectName]{.ins} [config]{.sub} [get]{.lit}
[objectName]{.ins} [config]{.sub} [set]{.lit} [name]{.arg} [value]{.optarg}
[objectName]{.ins} [config]{.sub} [unset]{.lit} [pattern...]{.arg}
[export]{.cmd} [serial]{.arg} [configuration]{.arg}
:::

# Beschreibung

Dieses Paket stellt eine Klasse zur Verwaltung der Plugins für den Export von Inhaltsverzeichnissen in andere Formate bereit, d. h. für deren Konvertierung beispielsweise in *doctoc*, *HTML* usw.

Dies ist eine der drei öffentlichen Säulen, auf denen die Verwaltung von Inhaltsverzeichnissen beruht. Die beiden anderen Säulen sind

1. *Importieren von Inhaltsverzeichnissen*, und

2. *Aufnehmen von Inhaltsverzeichnissen*


Zu den [Begriffe] der Inhaltsverzeichnisse und ihrer Teile siehe den gleichnamigen Abschnitt. Zur Datenstruktur, die den von diesem Paket bereitgestellten Manager-Objekten im Wesentlichen als Eingabe dient, siehe den Abschnitt [Serialisierungsformat für Inhaltsverzeichnisse].

Das Plugin-System der Klasse beruht auf dem Paket **pluginmgr** und sucht Plugins über

1. die Umgebungsvariable **DOCTOOLS\_TOC\_EXPORT\_PLUGINS**,

2. die Umgebungsvariable **DOCTOOLS\_TOC\_PLUGINS**,

3. die Umgebungsvariable **DOCTOOLS\_PLUGINS**,

4. der Pfad „*~/.doctools/toc/export/plugin*“

5. der Pfad „*~/.doctools/toc/plugin*“

6. der Pfad „*~/.doctools/plugin*“

7. der Pfad „*~/.doctools/toc/export/plugins*“

8. der Pfad „*~/.doctools/toc/plugins*“

9. der Pfad „*~/.doctools/plugins*“

10. der Registrierungseintrag „HKEY\_CURRENT\_USER\\SOFTWARE\\DOCTOOLS\\TOC\\EXPORT\\PLUGINS“

11. der Registrierungseintrag „HKEY\_CURRENT\_USER\\SOFTWARE\\DOCTOOLS\\TOC\\PLUGINS“

12. der Registrierungseintrag „HKEY\_CURRENT\_USER\\SOFTWARE\\DOCTOOLS\\PLUGINS“.


Die letzten drei werden nur verwendet, wenn das Paket auf einem Rechner mit dem Betriebssystem Windows(tm) ausgeführt wird.

Das gesamte System wird mit sechs vordefinierten Export-Plugins ausgeliefert, nämlich

doctoc
: Einzelheiten stehen in *doctoc export plugin*.

html
: Einzelheiten stehen in *html export plugin*.

json
: Einzelheiten stehen in *json export plugin*.

nroff
: Einzelheiten stehen in *nroff export plugin*.

text
: Einzelheiten stehen in *text export plugin*.

wiki
: Einzelheiten stehen in *wiki export plugin*.


Wer ein eigenes Export-Plugin für ein Format schreiben will, also ein *Plugin-Entwickler*, muss den Abschnitt [Referenz zur Export-Plugin-API v2] lesen und verstehen. Er legt die Interaktion zwischen diesem Paket und seinen Plugins im Einzelnen fest.

# Begriffe

1. Ein *Inhaltsverzeichnis* besteht aus einer (möglicherweise leeren) Liste von *Elementen*.

2. Jedes Element in der Liste wird durch seine Bezeichnung gekennzeichnet.

3. Jedes Element ist entweder ein *Verweis* oder ein *Abschnitt*.

4. Jeder Verweis hat ein zugehöriges Dokument, das durch eine symbolische Kennung identifiziert wird, sowie eine Textbeschreibung.

5. Jeder Abschnitt kann ein zugehöriges Dokument haben, das durch eine symbolische Kennung identifiziert wird.

6. Jeder Abschnitt besteht aus einer (möglicherweise leeren) Liste von *Elementen*, und jedes Element folgt den Regeln aus Punkt 2 und den darüber stehenden Punkten.


Einige Anmerkungen

1. Die genannten Regeln spannen einen Baum von Elementen auf, mit Verweisen als Blättern und Abschnitten als inneren Knoten, und jedes Element ist ein Eintrag im ganzen Inhaltsverzeichnis.

2. Die kennzeichnenden Bezeichnungen eines Elements E sind innerhalb seines Abschnitts (oder des Inhaltsverzeichnisses) eindeutig, und die volle Bezeichnung eines Elements E ist die Liste der Bezeichnungen aller Knoten auf dem eindeutigen Pfad von der Wurzel des Baums nach E, einschließlich E.


# API

## Paketbefehle

**::doctools::toc::export** *objectName*
: Dieser Befehl erzeugt ein neues Export-Manager-Objekt mit einem zugehörigen Tcl-Befehl namens *objectName*. Dieser Befehl *object* ist in den Abschnitten [Objektbefehl] und [Objektmethoden] vollständig beschrieben. Der Objektbefehl entsteht im aktuellen Namespace, wenn *objectName* nicht vollqualifiziert ist, sonst im angegebenen Namespace.


## Objektbefehl

Alle mit dem Befehl **::doctools::toc::export** erstellten Objekte haben die folgende allgemeine Form:

**objectName** **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt [Objektmethoden].


## Objektmethoden

*objectName* **destroy**
: Diese Methode löscht das Objekt, für das sie aufgerufen wird.

*objectName* **export serial** *serial* ?*format*?
: Diese Methode nimmt die kanonische Serialisierung eines Inhaltsverzeichnisses in *serial* und wandelt sie mit dem Export-Plugin für das angegebene *format* in dieses *format* um. Wird kein Plugin für das Format gefunden, wird ein Fehler ausgelöst. Die durch die Umwandlung erzeugte Zeichenkette wird als Ergebnis dieser Methode zurückgegeben.

    Wird kein Format angegeben, verwendet die Methode **doctoc**.

    Was eine *kanonische* Serialisierung ist, steht im Abschnitt [Serialisierungsformat für Inhaltsverzeichnisse].

    Das Plugin muss der Schnittstelle im Abschnitt [Referenz zur Export-Plugin-API v2] entsprechen.

*objectName* **export object** *object* ?*format*?
: Diese Methode ist eine bequeme Hülle um die im vorigen Punkt beschriebene Methode **export serial**. Sie erwartet, dass *object* ein Objektbefehl mit einer Methode **serialize** ist, die die kanonische Serialisierung eines Inhaltsverzeichnisses zurückgibt. Sie ruft diese Methode auf, gibt das Ergebnis an **export serial** weiter und gibt die entstandene Zeichenkette als eigenes Ergebnis zurück.

*objectName* **config names**
: Diese Methode gibt eine Liste zurück, die die Namen aller dem Objekt derzeit bekannten Konfigurationsvariablen enthält.

*objectName* **config get**
: Diese Methode gibt ein Dictionary zurück, das die Namen und Werte aller dem Objekt derzeit bekannten Konfigurationsvariablen enthält.

*objectName* **config set** *name* ?*value*?
: Diese Methode setzt die Konfigurationsvariable *name* auf den angegebenen *value* und gibt den neuen Wert der Variablen zurück.

    Wird kein Wert angegeben, gibt sie nur den aktuellen Wert zurück, ohne ihn zu ändern.

    Der Benutzer kann die vordefinierten Konfigurationsvariablen **user** und **format** zwar setzen, das bleibt aber ohne Wirkung; diese Werte werden beim Aufruf eines Export-Plugins intern überschrieben.

*objectName* **config unset** *pattern*...
: Diese Methode löscht alle Konfigurationsvariablen, auf die die angegebenen *pattern*s passen. Wird kein Muster angegeben, löscht sie alle derzeit definierten Konfigurationsvariablen.


# Referenz zur Export-Plugin-API v2

Plugins verwalten in diesem Paket die Unterstützung für jedes Ausgabeformat jenseits des [Serialisierungsformat für Inhaltsverzeichnisse]. Hier ist die API festgelegt, über die die von diesem Paket erzeugten Objekte mit ihren Plugins verkehren.

Ein Plugin für dieses Paket muss die nachfolgend aufgeführten Regeln einhalten:

1. Ein Plugin ist ein Paket.

2. Der Name eines Plugin-Pakets hat die Form doctools::toc::export::**FOO**, wobei **FOO** der Name des Formats ist, für das das Plugin die Ausgabe erzeugt. Dieser Name ist auch das Argument der verschiedenen Methoden **export** der Export-Manager-Objekte, um eine Zeichenkette zu erhalten, die ein Inhaltsverzeichnis in diesem Format kodiert.

3. Das Plugin kann davon ausgehen, dass das Paket **doctools::toc::export::plugin** vorhanden ist, was darauf hindeutet, dass es von einem echten Plugin-Manager aufgerufen wurde.

4. Ein Plugin muss einen Befehl bereitstellen, dessen Signatur wie unten dargestellt lautet.

    **export** *serial* *configuration*
    : Immer wenn ein Export-Manager von **doctools::toc** eine Ausgabe für ein Inhaltsverzeichnis erzeugen muss, ruft er diesen Befehl auf.

        string *serial*
        : Dieses Argument enthält die *kanonische* Serialisierung des Inhaltsverzeichnisses, für das die Ausgabe erzeugt wird. Was eine *kanonische* Serialisierung ist, steht im Abschnitt [Serialisierungsformat für Inhaltsverzeichnisse].

        dictionary *configuration*
        : Dieses Argument enthält die bei der Erzeugung anzuwendende Konfiguration, als Dictionary von Variablennamen auf Werte.

            Die folgenden Konfigurationsvariablen haben eine vorgegebene Bedeutung, an die sich alle Plugins halten müssen, auch wenn sie diese Angabe nach eigenem Ermessen ignorieren können. Jede weitere Konfigurationsvariable, die ein Plugin erkennt, ist in der Handbuchseite dieses Plugins beschrieben.

            user
            : Diese Variable soll den Namen des Benutzers enthalten, dem der Prozess gehört, der das Plugin aufruft.

            format
            : Diese Variable soll den Namen des Formats enthalten, dessen Plugin aufgerufen wird.

            file
            : Diese Variable soll, wenn der Benutzer des Inhaltsverzeichnisobjekts sie definiert, den Namen der Eingabedatei enthalten, für die das Plugin seine Ausgabe erzeugt.

            map
            : Diese Variable soll, wenn der Benutzer des Inhaltsverzeichnisobjekts sie definiert, ein Dictionary enthalten, das die in den Einträgen verwendeten symbolischen Dokumentkennungen auf tatsächliche Pfade (oder URLs) abbildet. Ein Plugin muss damit umgehen können, dass eine Dokumentkennung in dieser Abbildung keinen Eintrag hat.




5. Ein einzelner Nutzungszyklus eines Plugins besteht aus den Aufrufen des Befehls **export**. Dieser Aufruf muss das Plugin in einem Zustand hinterlassen, in dem ein weiterer Nutzungszyklus ohne Probleme ablaufen kann.


# Serialisierungsformat für Inhaltsverzeichnisse

Hier ist das Format festgelegt, in dem die Pakete von doctools v2 Inhaltsverzeichnisse als unveränderliche Werte für den Transport, den Vergleich und Ähnliches serialisieren.

Es wird zwischen *regulären* und *kanonischen* Serialisierungen unterschieden. Ein Inhaltsverzeichnis kann mehr als eine reguläre Serialisierung haben, *kanonisch* ist aber genau eine.

regular serialization
: 1. Die Serialisierung eines beliebigen Inhaltsverzeichnisses ist ein verschachteltes Tcl-Dictionary.

    2. Dieses Dictionary enthält genau einen Schlüssel, **doctools::toc**, und dessen Wert. Dieser Wert enthält den Inhalt des Inhaltsverzeichnisses.

    3. Der Inhalt des Inhaltsverzeichnisses ist ein Tcl-Dictionary mit dem Titel des Inhaltsverzeichnisses, einer Bezeichnung und seinen Elementen. Die maßgeblichen Schlüssel und ihre Werte sind

        **title**
        : Der Wert ist eine Zeichenkette mit dem Titel des Inhaltsverzeichnisses.

        **label**
        : Der Wert ist eine Zeichenkette mit einer Bezeichnung für das Inhaltsverzeichnis.

        **items**
        : Der Wert ist eine Tcl-Liste mit den Elementen des Inhaltsverzeichnisses, in der Reihenfolge, in der sie angezeigt werden sollen.

            Jedes Element ist eine Tcl-Liste mit dem Typ des Eintrags und seiner Beschreibung, in dieser Reihenfolge. Anders gesagt ist es ein Tcl-Dictionary mit genau einem Schlüssel, dem Eintragstyp, abgebildet auf die Beschreibung des Eintrags.

            Die beiden zulässigen Eintragstypen und ihre Beschreibungen sind

            **reference**
            : Dieser Punkt beschreibt einen einzelnen Eintrag im Inhaltsverzeichnis, der auf ein einzelnes Dokument verweist. Sein Wert ist dazu ein Tcl-Dictionary mit einer Kennung für das referenzierte Dokument, einer Bezeichnung und einer längeren Textbeschreibung, die dem Eintrag zugeordnet werden kann. Die maßgeblichen Schlüssel und ihre Werte sind

                **id**
                : Der Wert ist eine Zeichenkette mit der Kennung des Dokuments, das zu dem Eintrag gehört.

                **label**
                : Der Wert ist eine Zeichenkette mit einer Bezeichnung für diesen Eintrag. Diese Zeichenkette kennzeichnet den Eintrag ebenfalls, und keine zwei Einträge (Verweise und Abschnitte) in der enthaltenden Liste dürfen dieselbe Bezeichnung haben.

                **desc**
                : Der Wert ist eine Zeichenkette mit einer längeren Beschreibung dieses Eintrags.


            **division**
            : Dieser Punkt beschreibt eine Gruppe von Einträgen im Inhaltsverzeichnis und erzeugt damit eine Hierarchie von Einträgen. Sein Wert ist dazu ein Tcl-Dictionary mit einer Bezeichnung für die Gruppe, einer optionalen Kennung eines Dokuments für die ganze Gruppe und der Liste der Einträge in der Gruppe. Die maßgeblichen Schlüssel und ihre Werte sind

                **id**
                : Der Wert ist eine Zeichenkette mit der Kennung des Dokuments, das zur ganzen Gruppe gehört. Dieser Schlüssel ist optional.

                **label**
                : Der Wert ist eine Zeichenkette mit einer Bezeichnung für die Gruppe. Diese Zeichenkette kennzeichnet den Eintrag ebenfalls, und keine zwei Einträge (Verweise und Abschnitte) in der enthaltenden Liste dürfen dieselbe Bezeichnung haben.

                **items**
                : Der Wert ist eine Tcl-Liste mit den Elementen der Gruppe, in der Reihenfolge, in der sie angezeigt werden sollen. Diese Liste hat denselben Aufbau wie der Wert des Schlüssels **items** für das ganze Inhaltsverzeichnis, siehe oben. Damit schließt sich die rekursive Definition der Struktur: Abschnitte enthalten dieselben Arten von Elementen wie das ganze Inhaltsverzeichnis, einschließlich weiterer Abschnitte.





canonical serialization
: Die kanonische Serialisierung eines Inhaltsverzeichnisses hat das im vorigen Punkt festgelegte Format und erfüllt zusätzlich die folgenden Bedingungen. Dadurch ist sie unter allen möglichen Serialisierungen dieses Inhaltsverzeichnisses eindeutig.

    1. Die Schlüssel in allen verschachtelten Tcl-Dictionaries sind in aufsteigender Wörterbuchreihenfolge sortiert, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.



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
