---
CommandName: doctools::toc
ManualSection: n
Version: 2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - HTML
 - TMML
 - conversion
 - doctoc markup
 - documentation
 - formatting
 - generation
 - json
 - latex
 - markup
 - nroff
 - parsing
 - plugin
 - reference
 - table
 - table of contents
 - tcler's wiki
 - text
 - wiki
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::toc – Aufnehmen von Inhaltsverzeichnissen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::toc]{.lit} [2]{.optlit} 
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::toc::structure]{.lit} 
[package]{.cmd} [require]{.sub} [struct::tree]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[::doctools::toc]{.cmd} [objectName]{.arg} 
[objectName]{.cmd} [method]{.sub} [arg arg]{.optdot} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [+]{.sub} [reference]{.lit} [id]{.arg} [label]{.arg} [docid]{.arg} [desc]{.arg} 
[objectName]{.ins} [+]{.sub} [division]{.lit} [id]{.arg} [label]{.arg} [docid]{.optarg} 
[objectName]{.ins} [remove]{.sub} [id]{.arg} 
[objectName]{.ins} [up]{.sub} [id]{.arg} 
[objectName]{.ins} [next]{.sub} [id]{.arg} 
[objectName]{.ins} [prev]{.sub} [id]{.arg} 
[objectName]{.ins} [child]{.sub} [id]{.arg} [label]{.arg} [...]{.optdot} 
[objectName]{.ins} [element]{.sub} [...]{.optdot} 
[objectName]{.ins} [children]{.sub} [id]{.arg} 
[objectName]{.ins} [type]{.sub} [id]{.arg} 
[objectName]{.ins} [full-label]{.sub} [id]{.arg} 
[objectName]{.ins} [elabel]{.sub} [id]{.arg} [newlabel]{.optarg} 
[objectName]{.ins} [description]{.sub} [id]{.arg} [newdesc]{.optarg} 
[objectName]{.ins} [document]{.sub} [id]{.arg} [newdocid]{.optarg} 
[objectName]{.ins} [title]{.sub} 
[objectName]{.ins} [title]{.sub} [text]{.arg} 
[objectName]{.ins} [label]{.sub} 
[objectName]{.ins} [label]{.sub} [text]{.arg} 
[objectName]{.ins} [importer]{.sub} 
[objectName]{.ins} [importer]{.sub} [object]{.arg} 
[objectName]{.ins} [exporter]{.sub} 
[objectName]{.ins} [exporter]{.sub} [object]{.arg} 
[objectName]{.ins} [deserialize]{.sub} [=]{.lit} [data]{.arg} [format]{.optarg} 
[objectName]{.ins} [deserialize]{.sub} [+=]{.lit} [data]{.arg} [format]{.optarg} 
[objectName]{.ins} [serialize]{.sub} [format]{.optarg} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine Klasse bereit, die Inhaltsverzeichnisse aufnimmt und programmgesteuert bearbeitet.

Dies ist eine der drei öffentlichen Säulen, auf denen die Verwaltung von Inhaltsverzeichnissen beruht. Die beiden anderen Säulen sind

**\[1\]**
: *Exportieren von Inhaltsverzeichnissen*, und

**\[2\]**
: *Importieren von Inhaltsverzeichnissen* Zu den **BEGRIFFE** der Inhaltsverzeichnisse und ihrer Teile siehe den gleichnamigen Abschnitt. Zur Datenstruktur, mit der Inhaltsverzeichnisse als Werte kodiert werden, siehe den Abschnitt **SERIALISIERUNGSFORMAT FÜR INHALTSVERZEICHNISSE**. Das ist das einzige Format, das diese Klasse unmittelbar kennt. Umwandlungen von und in jedes andere Format übernehmen Export- und Import-Manager-Objekte. Die lassen sich einem Container zuordnen, müssen es aber nicht; das ist nur eine Bequemlichkeit.


# BEGRIFFE

**\[1\]**
: Ein *Inhaltsverzeichnis* besteht aus einer (möglicherweise leeren) Liste von *Elementen*.

**\[2\]**
: Jedes Element in der Liste wird durch seine Bezeichnung gekennzeichnet.

**\[3\]**
: Jedes Element ist entweder ein *Verweis* oder ein *Abschnitt*.

**\[4\]**
: Jeder Verweis hat ein zugehöriges Dokument, das durch eine symbolische Kennung identifiziert wird, sowie eine Textbeschreibung.

**\[5\]**
: Jeder Abschnitt kann ein zugehöriges Dokument haben, das durch eine symbolische Kennung identifiziert wird.

**\[6\]**
: Jeder Abschnitt besteht aus einer (möglicherweise leeren) Liste von *Elementen*, und jedes Element folgt den Regeln aus Punkt 2 und den darüber stehenden Punkten. Einige Anmerkungen

**\[1\]**
: Die genannten Regeln spannen einen Baum von Elementen auf, mit Verweisen als Blättern und Abschnitten als inneren Knoten, und jedes Element ist ein Eintrag im ganzen Inhaltsverzeichnis.

**\[2\]**
: Die kennzeichnenden Bezeichnungen eines Elements E sind innerhalb seines Abschnitts (oder des Inhaltsverzeichnisses) eindeutig, und die volle Bezeichnung eines Elements E ist die Liste der Bezeichnungen aller Knoten auf dem eindeutigen Pfad von der Wurzel des Baums nach E, einschließlich E.


# API

## Paketbefehle

**::doctools::toc** *objectName*
: Dieser Befehl erzeugt ein neues Container-Objekt mit einem zugehörigen Tcl-Befehl namens *objectName*. Dieser Befehl *object* ist in den Abschnitten **Objektbefehl** und **Objektmethoden** vollständig beschrieben. Der Objektbefehl entsteht im aktuellen Namespace, wenn *objectName* nicht vollqualifiziert ist, sonst im angegebenen Namespace.


## Objektbefehl

Alle mit dem Befehl **::doctools::toc** erstellten Objekte haben die folgende allgemeine Form:

**objectName** **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt **Objektmethoden**.


## Objektmethoden

*objectName* **destroy**
: Diese Methode löscht das Objekt, für das sie aufgerufen wird.

*objectName* **+ reference** *id* *label* *docid* *desc*
: Diese Methode fügt dem Inhaltsverzeichnis ein neues Verweis-Element hinzu, unter dem Element, das über sein Handle *id* angegeben ist. Dieses Elternelement muss ein Abschnitt oder die Wurzel sein. Andernfalls wird ein Fehler ausgelöst. Das neue Element wird nach außen durch sein *label* identifiziert, das innerhalb des Elternelements eindeutig sein muss. Andernfalls wird ein Fehler ausgelöst. Als Verweis bezieht es sich auf ein Dokument, das durch die symbolische Kennung *docid* identifiziert wird. Diese Kennung darf nicht die leere Zeichenkette sein, sonst wird ein Fehler ausgelöst. Neben der Bezeichnung hat das Element eine längere beschreibende Zeichenkette, übergeben in *desc*. Das Ergebnis der Methode ist das Handle (id) des neuen Elements.

*objectName* **+ division** *id* *label* ?*docid*?
: Diese Methode fügt dem Inhaltsverzeichnis ein neues Abschnitts-Element hinzu, unter dem Element, das über sein Handle *id* angegeben ist. Dieses Elternelement muss ein Abschnitt oder die Wurzel sein. Andernfalls wird ein Fehler ausgelöst. Das neue Element wird nach außen durch sein *label* identifiziert, das innerhalb des Elternelements eindeutig sein muss. Andernfalls wird ein Fehler ausgelöst. Als Abschnitt kann es auf ein Dokument verweisen, das durch die symbolische Kennung *docid* identifiziert wird, muss das aber nicht. Das Ergebnis der Methode ist das Handle (id) des neuen Elements.

*objectName* **remove** *id*
: Diese Methode entfernt das durch das Handle *id* bestimmte Element aus dem Inhaltsverzeichnis. Ist das Element ein Abschnitt, werden auch alle seine Kinder entfernt, sofern vorhanden. Das Wurzelelement des Inhaltsverzeichnisses lässt sich dagegen nicht entfernen, nur seine Kinder. Das Ergebnis der Methode ist die leere Zeichenkette.

*objectName* **up** *id*
: Diese Methode gibt das Handle des Elternelements des durch sein Handle *id* bestimmten Elements zurück, oder die leere Zeichenkette, wenn *id* die Wurzel bezeichnet.

*objectName* **next** *id*
: Diese Methode gibt das Handle des rechten Geschwisterelements des durch sein Handle *id* bestimmten Elements zurück, oder das Handle des Elternelements, wenn das Element kein rechtes Geschwisterelement hat, oder die leere Zeichenkette, wenn *id* die Wurzel bezeichnet.

*objectName* **prev** *id*
: Diese Methode gibt das Handle des linken Geschwisterelements des durch sein Handle *id* bestimmten Elements zurück, oder das Handle des Elternelements, wenn das Element kein linkes Geschwisterelement hat, oder die leere Zeichenkette, wenn *id* die Wurzel bezeichnet.

*objectName* **child** *id* *label* ?*...*?
: Diese Methode gibt das Handle eines Kindes des durch sein Handle *id* bestimmten Elements zurück. Das Kind selbst ist durch eine Folge von Bezeichnungen bestimmt.

*objectName* **element** ?*...*?
: Diese Methode gibt das Handle des Elements zurück, das durch eine Folge von Bezeichnungen bestimmt ist, beginnend bei der Wurzel des Inhaltsverzeichnisses. Die Folge der Bezeichnungen darf leer sein; dann wird das Handle des Wurzelelements zurückgegeben.

*objectName* **children** *id*
: Diese Methode gibt eine Liste mit den Handles aller Kinder des durch das Handle *id* bestimmten Elements zurück, vom ersten bis zum letzten, in dieser Reihenfolge.

*objectName* **type** *id*
: Diese Methode gibt den Typ des Elements zurück, entweder **reference** oder **division**.

*objectName* **full-label** *id*
: Diese Methode ist das Gegenstück zur Methode **element**. Sie wandelt das Handle *id* eines Elements in eine Liste von Bezeichnungen um, die das Element im ganzen Inhaltsverzeichnis vollständig bestimmen.

*objectName* **elabel** *id* ?*newlabel*?
: Diese Methode fragt die Bezeichnung des durch das Handle *id* bestimmten Elements ab und ändert sie gegebenenfalls. Ist das Argument *newlabel* vorhanden, wird die Bezeichnung auf diesen Wert gesetzt. In jedem Fall ist das Ergebnis der aktuelle Wert der Bezeichnung. Wird die Bezeichnung geändert, muss die neue Bezeichnung innerhalb des enthaltenden Abschnitts eindeutig sein, sonst wird ein Fehler ausgelöst. Bezieht sich *id* auf das Wurzelelement des Inhaltsverzeichnisses, ist diese Methode gleichbedeutend mit der Methode *label*, sie greift also auf die globale Bezeichnung des ganzen Inhaltsverzeichnisses zu.

*objectName* **description** *id* ?*newdesc*?
: Diese Methode fragt die Beschreibung des durch das Handle *id* bestimmten Elements ab und ändert sie gegebenenfalls. Ist das Argument *newdesc* vorhanden, wird die Beschreibung auf diesen Wert gesetzt. In jedem Fall ist das Ergebnis der aktuelle Wert der Beschreibung. Das Element muss ein Verweis sein, sonst wird ein Fehler ausgelöst.

*objectName* **document** *id* ?*newdocid*?
: Diese Methode fragt den Dokumentverweis des durch das Handle *id* bestimmten Elements ab und ändert ihn gegebenenfalls. Ist das Argument *newdocid* vorhanden, wird der Dokumentverweis auf diesen Wert gesetzt. In jedem Fall ist das Ergebnis der aktuelle Wert des Dokumentverweises. Den Verweis auf die leere Zeichenkette zu setzen hebt ihn auf und ist nur bei Abschnitten zulässig. Ist das Ergebnis umgekehrt die leere Zeichenkette, hat das Element keinen Dokumentverweis, und das kommt nur bei Abschnitten vor.

*objectName* **title**
: Gibt den aktuell festgelegten Titel des Inhaltsverzeichnisses zurück.

*objectName* **title** *text*
: Setzt den Titel des Inhaltsverzeichnisses auf *text* und gibt ihn als Ergebnis des Befehls zurück.

*objectName* **label**
: Gibt die aktuell festgelegte Bezeichnung des Inhaltsverzeichnisses zurück.

*objectName* **label** *text*
: Setzt die Bezeichnung des Inhaltsverzeichnisses auf *text* und gibt sie als Ergebnis des Befehls zurück.

*objectName* **importer**
: Gibt das Import-Manager-Objekt zurück, das dem Container derzeit zugeordnet ist, sofern eines zugeordnet ist.

*objectName* **importer** *object*
: Ordnet das *object* dem Container als Import-Manager zu und gibt es als Ergebnis des Befehls zurück. Das *object* geht dabei *nicht* in den Besitz des Containers über. Die Zerstörung des Containers zerstört das *object* also *nicht*. Erwartet wird, dass *object* eine Methode **import text** bereitstellt, die einen Text und einen Formatnamen entgegennimmt und die kanonische Serialisierung des im Text enthaltenen Inhaltsverzeichnisses zurückgibt, unter der Annahme des angegebenen Formats.

*objectName* **exporter**
: Gibt das Export-Manager-Objekt zurück, das dem Container derzeit zugeordnet ist, sofern eines zugeordnet ist.

*objectName* **exporter** *object*
: Ordnet das *object* dem Container als Export-Manager zu und gibt es als Ergebnis des Befehls zurück. Das *object* geht dabei *nicht* in den Besitz des Containers über. Die Zerstörung des Containers zerstört das *object* also *nicht*. Erwartet wird, dass *object* eine Methode **export object** bereitstellt, die den Container und einen Formatnamen entgegennimmt und einen Text zurückgibt, der das im Container gespeicherte Inhaltsverzeichnis im angegebenen Format kodiert. Weiter wird erwartet, dass das *object* die Methode **serialize** des Containers benutzt, um die Serialisierung des Inhaltsverzeichnisses zu holen, aus der der Text entsteht.

*objectName* **deserialize =** *data* ?*format*?
: Diese Methode ersetzt den Inhalt des Inhaltsverzeichnisobjekts durch das in *data* enthaltene Inhaltsverzeichnis. Wird kein *format* angegeben, gilt *data* als die reguläre Serialisierung eines Inhaltsverzeichnisses. Andernfalls wandelt das Objekt die Daten über den zugeordneten Import-Manager aus dem angegebenen Format in eine Serialisierung um, die es verarbeiten kann. In diesem Fall wird ein Fehler ausgelöst, wenn dem Container kein Import-Manager zugeordnet ist. Das Ergebnis der Methode ist die leere Zeichenkette.

*objectName* **deserialize +=** *data* ?*format*?
: Diese Methode verhält sich im Wesentlichen wie **deserialize =**, führt das Inhaltsverzeichnis in *data* aber mit dem eigenen Inhalt zusammen, statt ihn zu ersetzen. Die Methode löst einen Fehler aus, wenn das Zusammenführen nicht möglich ist, also ein ungültiges Inhaltsverzeichnis ergäbe. Der vorhandene Inhalt bleibt dann unverändert. Das Ergebnis der Methode ist die leere Zeichenkette.

*objectName* **serialize** ?*format*?
: Diese Methode gibt das im Objekt enthaltene Inhaltsverzeichnis zurück. Wird kein *format* angegeben, ist das Ergebnis die kanonische Serialisierung seines Inhalts. Andernfalls wandelt das Objekt die Daten über den zugeordneten Export-Manager in das angegebene Format um. In diesem Fall wird ein Fehler ausgelöst, wenn dem Container kein Export-Manager zugeordnet ist.


# SERIALISIERUNGSFORMAT FÜR INHALTSVERZEICHNISSE

Hier ist das Format festgelegt, in dem die Pakete von doctools v2 Inhaltsverzeichnisse als unveränderliche Werte für den Transport, den Vergleich und Ähnliches serialisieren.

Es wird zwischen *regulären* und *kanonischen* Serialisierungen unterschieden. Ein Inhaltsverzeichnis kann mehr als eine reguläre Serialisierung haben, *kanonisch* ist aber genau eine.

**regular serialization**
: 


**\[1\]**
: Die Serialisierung eines beliebigen Inhaltsverzeichnisses ist ein verschachteltes Tcl-Dictionary.

**\[2\]**
: Dieses Dictionary enthält genau einen Schlüssel, **doctools::toc**, und dessen Wert. Dieser Wert enthält den Inhalt des Inhaltsverzeichnisses.

**\[3\]**
: Der Inhalt des Inhaltsverzeichnisses ist ein Tcl-Dictionary mit dem Titel des Inhaltsverzeichnisses, einer Bezeichnung und seinen Elementen. Die maßgeblichen Schlüssel und ihre Werte sind


**title**
: Der Wert ist eine Zeichenkette mit dem Titel des Inhaltsverzeichnisses.

**label**
: Der Wert ist eine Zeichenkette mit einer Bezeichnung für das Inhaltsverzeichnis.

**items**
: Der Wert ist eine Tcl-Liste mit den Elementen des Inhaltsverzeichnisses, in der Reihenfolge, in der sie angezeigt werden sollen. Jedes Element ist eine Tcl-Liste mit dem Typ des Eintrags und seiner Beschreibung, in dieser Reihenfolge. Anders gesagt ist es ein Tcl-Dictionary mit genau einem Schlüssel, dem Eintragstyp, abgebildet auf die Beschreibung des Eintrags. Die beiden zulässigen Eintragstypen und ihre Beschreibungen sind


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


**canonical serialization**
: Die kanonische Serialisierung eines Inhaltsverzeichnisses hat das im vorigen Punkt festgelegte Format und erfüllt zusätzlich die folgenden Bedingungen. Dadurch ist sie unter allen möglichen Serialisierungen dieses Inhaltsverzeichnisses eindeutig.


**\[1\]**
: Die Schlüssel in allen verschachtelten Tcl-Dictionaries sind in aufsteigender Wörterbuchreihenfolge sortiert, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *doctools* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dokumentationswerkzeuge

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
