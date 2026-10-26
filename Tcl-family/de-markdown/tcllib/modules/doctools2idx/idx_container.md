---
CommandName: doctools::idx
ManualSection: n
Version: 2.1
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - HTML
 - TMML
 - conversion
 - docidx markup
 - documentation
 - formatting
 - generation
 - index
 - json
 - keyword index
 - latex
 - manpage
 - markup
 - nroff
 - parsing
 - plugin
 - reference
 - tcler's wiki
 - text
 - url
 - wiki
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::idx – Halten von Schlüsselwortindizes

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::idx]{.lit} [2.1]{.optlit} 
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::idx::structure]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[::doctools::idx]{.cmd} [objectName]{.arg} 
[objectName]{.cmd} [method]{.sub} [arg arg]{.optdot} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [key]{.sub} [add]{.lit} [name]{.arg} 
[objectName]{.ins} [key]{.sub} [remove]{.lit} [name]{.arg} 
[objectName]{.ins} [key]{.sub} [references]{.lit} [name]{.arg} 
[objectName]{.ins} [keys]{.sub} 
[objectName]{.ins} [reference]{.sub} [add]{.lit} [type]{.arg} [key]{.arg} [name]{.arg} [label]{.arg} 
[objectName]{.ins} [reference]{.sub} [remove]{.lit} [name]{.arg} 
[objectName]{.ins} [reference]{.sub} [label]{.lit} [name]{.arg} 
[objectName]{.ins} [reference]{.sub} [keys]{.lit} [name]{.arg} 
[objectName]{.ins} [reference]{.sub} [type]{.lit} [name]{.arg} 
[objectName]{.ins} [references]{.sub} 
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

Dieses Paket stellt eine Klasse zum Aufnehmen und programmatischen Bearbeiten von Schlüsselwortindizes bereit.

Dies ist eine der drei öffentlichen Säulen, auf denen die Verwaltung von Schlüsselwortindizes ruht. Die beiden anderen Säulen sind

**\[1\]**
: *Export von Schlüsselwortindizes* sowie

**\[2\]**
: *Import von Schlüsselwortindizes* Informationen über **BEGRIFFE** von Schlüsselwortindizes und ihre Bestandteile stehen im gleichnamigen Abschnitt. Informationen über die Datenstruktur, mit der Schlüsselwortindizes als Werte kodiert werden, stehen im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES**. Dies ist das einzige Format, das dieser Klasse direkt bekannt ist. Konvertierungen von und in jedes andere Format werden von Export- und Import-Manager-Objekten übernommen. Diese können einem Container zugeordnet werden, müssen es jedoch nicht; das ist lediglich eine Erleichterung.


# BEGRIFFE

**\[1\]**
: Ein *Schlüsselwortindex* besteht aus einer (möglicherweise leeren) Menge von *Schlüsselwörtern*.

**\[2\]**
: Jedes Schlüsselwort in der Menge wird durch seinen Namen identifiziert.

**\[3\]**
: Jedes Schlüsselwort verfügt über eine (möglicherweise leere) Menge von *Referenzen*.

**\[4\]**
: Eine Referenz kann mit mehr als einem Schlüsselwort verknüpft sein.

**\[5\]**
: Eine Referenz, die nicht mit mindestens einem Schlüsselwort verknüpft ist, ist jedoch nicht möglich.

**\[6\]**
: Jede Referenz wird durch ihr Ziel identifiziert, das je nach Referenztyp (**url** oder **manpage**) entweder als URL oder als symbolischer Dateiname angegeben wird.

**\[7\]**
: Der Typ einer Referenz (URL oder manpage) hängt nur von der Referenz selbst ab und nicht von den Schlüsselwörtern, denen sie zugeordnet ist.

**\[8\]**
: Zusätzlich zu einem Typ verfügt jede Referenz auch über eine beschreibende Bezeichnung. Diese Bezeichnung hängt ausschließlich von der Referenz selbst ab und nicht von den Schlüsselwörtern, denen sie zugeordnet ist. Einige Hinweise

**\[1\]**
: manpage-Referenzen sind für Verweise auf die Dokumente gedacht, für die der Index erstellt wurde. Ihr Ziel ist ein symbolischer Dateiname, der das Dokument identifiziert, und Export-Plugins können symbolische durch tatsächliche Dateinamen ersetzen, wenn das festgelegt ist.

**\[2\]**
: URL-Referenzen hingegen sind für Verweise auf alles andere gedacht, etwa Websites. Ihr Ziel ist eine URL.

**\[3\]**
: URL- und manpage-Referenzen teilen sich zwar einen Namensraum für ihre Bezeichner, das sollte jedoch kein Problem sein, denn manpage-Bezeichner sind symbolische Dateinamen und sollten daher nie wie URLs aussehen, die Bezeichner der URL-Referenzen.


# API

## Paketbefehle

**::doctools::idx** *objectName*
: Dieser Befehl erstellt ein neues Container-Objekt mit einem zugehörigen Tcl-Befehl, dessen Name *objectName* lautet. Dieser *object*-Befehl wird in den Abschnitten **Objektbefehl** und **Objektmethoden** ausführlich erläutert. Der Objektbefehl wird im aktuellen Namespace erstellt, wenn *objectName* nicht vollständig qualifiziert ist; andernfalls erfolgt die Erstellung im angegebenen Namespace.


## Objektbefehl

Alle mit dem Befehl **::doctools::idx** erstellten Objekte haben die folgende allgemeine Form:

**objectName** **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt **Objektmethoden**.


## Objektmethoden

*objectName* **destroy**
: Diese Methode löscht das Objekt, für das sie aufgerufen wird.

*objectName* **key add** *name*
: Diese Methode fügt das Schlüsselwort *name* zum Index hinzu. Wenn das Schlüsselwort bereits vorhanden ist, erfolgt keine Aktion. Das Ergebnis der Methode ist die leere Zeichenkette.

*objectName* **key remove** *name*
: Diese Methode entfernt das Schlüsselwort *name* aus dem Index. Wenn das Schlüsselwort bereits entfernt wurde, erfolgt keine Aktion. Alle Verweise, bei denen dieses Schlüsselwort die letzte Zuordnung war, werden ebenfalls entfernt. Das Ergebnis der Methode ist die leere Zeichenkette.

*objectName* **key references** *name*
: Diese Methode gibt eine Liste zurück, die die Namen aller Referenzen enthält, die mit dem Schlüsselwort *name* verknüpft sind. Es wird ein Fehler ausgelöst, wenn das Schlüsselwort dem Index nicht bekannt ist. Die Reihenfolge der Referenzen in der Liste ist nicht definiert.

*objectName* **keys**
: Diese Methode gibt eine Liste zurück, die die Namen aller dem Index bekannten Schlüsselwörter enthält. Die Reihenfolge der Schlüsselwörter in der Liste ist nicht definiert.

*objectName* **reference add** *type* *key* *name* *label*
: Diese Methode fügt die Referenz *name* zum Index hinzu und ordnet sie dem Schlüsselwort *key* zu. Die beiden anderen Argumente enthalten den *type* bzw. die *label* der Referenz. Der Typ muss mit den gespeicherten Informationen übereinstimmen, falls die Referenz bereits existiert; das heißt, diese Informationen sind unveränderlich, sobald die Referenz bekannt ist. Die einzige Möglichkeit, ihn zu ändern, besteht darin, die Referenz zu löschen und neu anzulegen. Die Bezeichnung hingegen wird automatisch auf den Wert des Arguments aktualisiert, wobei zuvor gespeicherte Informationen überschrieben werden. Sollte die Referenz bereits existieren, wird sie einfach mit dem *key* verknüpft. Sollte dies ebenfalls bereits der Fall sein, wird nichts unternommen, sondern lediglich die *label* auf den neuen Wert aktualisiert.  Das Ergebnis der Methode ist die leere Zeichenkette. Das *type*-Argument muss entweder **manpage** oder **url** lauten.

*objectName* **reference remove** *name*
: Die Referenz *name* wird aus dem Index entfernt. Alle Verknüpfungen mit Schlüsselwörtern werden aufgelöst und die entsprechenden Referenzbezeichnungen entfernt. Das Ergebnis der Methode ist die leere Zeichenkette.

*objectName* **reference label** *name*
: Diese Methode gibt die Bezeichnung zurück, die der Referenz *name* zugeordnet ist. Wird die Referenz nicht erkannt, wird ein Fehler ausgelöst.

*objectName* **reference keys** *name*
: Diese Methode gibt eine Liste zurück, die die Namen aller Schlüsselwörter enthält, die mit der Referenz *name* verknüpft sind. Es wird ein Fehler ausgelöst, wenn die Referenz dem Index nicht bekannt ist. Die Reihenfolge der Schlüsselwörter in der Liste ist nicht definiert.

*objectName* **reference type** *name*
: Diese Methode gibt den Typ der Referenz *name* zurück. Es wird ein Fehler ausgelöst, wenn die Referenz dem Index nicht bekannt ist.

*objectName* **references**
: Diese Methode gibt eine Liste zurück, die die Namen aller dem Index bekannten Referenzen enthält. Die Reihenfolge der Referenzen in der Liste ist nicht definiert.

*objectName* **title**
: Gibt den aktuell definierten Titel des Schlüsselwortindexes zurück.

*objectName* **title** *text*
: Setzt den Titel des Schlüsselwortindexes auf *text* und gibt ihn als Ergebnis des Befehls zurück.

*objectName* **label**
: Gibt die aktuell definierte Bezeichnung des Schlüsselwortindexes zurück.

*objectName* **label** *text*
: Setzt die Bezeichnung des Schlüsselwortindexes auf *text* und gibt diese als Ergebnis des Befehls zurück.

*objectName* **importer**
: Gibt das Import-Manager-Objekt zurück, das dem Container derzeit zugeordnet ist, sofern eines zugeordnet ist.

*objectName* **importer** *object*
: Hängt das *object* als Import-Manager an den Container an und gibt es als Ergebnis des Befehls zurück. Das *object* geht *nicht* in den Besitz des Containers über. Die Löschung des Containers löscht das *object* also *nicht*. Es wird erwartet, dass *object* eine Methode **import text** bereitstellt, die einen Text und einen Formatnamen entgegennimmt und die kanonische Serialisierung des im Text enthaltenen Schlüsselwortindexes zurückgibt, unter der Annahme des angegebenen Formats.

*objectName* **exporter**
: Gibt das Export-Manager-Objekt zurück, das dem Container derzeit zugeordnet ist, sofern eines zugeordnet ist.

*objectName* **exporter** *object*
: Hängt das *object* als Export-Manager an den Container an und gibt es als Ergebnis des Befehls zurück. Das *object* geht *nicht* in den Besitz des Containers über. Die Löschung des Containers löscht das *object* also *nicht*. Es wird erwartet, dass *object* eine Methode **export object** bereitstellt, die den Container und einen Formatnamen entgegennimmt und einen Text zurückgibt, der den im Container gespeicherten Schlüsselwortindex im angegebenen Format kodiert. Ferner wird erwartet, dass das *object* die Methode **serialize** des Containers verwendet, um die Serialisierung des Schlüsselwortindexes zu erhalten, aus der der Text erzeugt wird.

*objectName* **deserialize =** *data* ?*format*?
: Diese Methode ersetzt den Inhalt des Indexobjekts durch den in *data* enthaltenen Index. Wurde kein *format* angegeben, wird davon ausgegangen, dass es sich um die reguläre Serialisierung eines Schlüsselwortindexes handelt. Andernfalls verwendet das Objekt den angehängten Import-Manager, um die Daten aus dem angegebenen Format in eine für das Objekt verarbeitbare Serialisierung zu konvertieren. In diesem Fall wird ein Fehler ausgelöst, wenn dem Container kein Import-Manager zugeordnet ist. Das Ergebnis der Methode ist die leere Zeichenkette.

*objectName* **deserialize +=** *data* ?*format*?
: Diese Methode verhält sich im Wesentlichen wie **deserialize =**, mit dem Unterschied, dass sie den Schlüsselwortindex in den *data* mit seinem Inhalt zusammenführt, anstatt ihn zu ersetzen. Die Methode löst einen Fehler aus, wenn eine Zusammenführung nicht möglich ist, d. h. wenn dadurch ein ungültiger Index entstehen würde. In diesem Fall bleibt der vorhandene Inhalt unverändert. Das Ergebnis der Methode ist die leere Zeichenkette.

*objectName* **serialize** ?*format*?
: Diese Methode gibt den im Objekt enthaltenen Schlüsselwortindex zurück. Wenn kein *format* angegeben wird, entspricht das zurückgegebene Ergebnis der kanonischen Serialisierung des Inhalts. Andernfalls verwendet das Objekt den angehängten Exportmanager, um die Daten in das angegebene Format zu konvertieren. In diesem Fall wird ein Fehler ausgelöst, wenn dem Container kein Exportmanager zugeordnet ist.


# SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES

Hier legen wir das Format fest, das von den doctools-v2-Paketen verwendet wird, um Schlüsselwortindizes als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Ein Schlüsselwortindex kann zwar mehr als eine reguläre Serialisierung aufweisen, doch genau eine davon ist *kanonisch*.

**reguläre Serialisierung**
: 


**\[1\]**
: Eine Index-Serialisierung ist ein verschachteltes Tcl-Dictionary.

**\[2\]**
: Dieses Dictionary enthält einen einzigen Schlüssel, **doctools::idx**, sowie dessen Wert. Dieser Wert enthält den Inhalt des Index.

**\[3\]**
: Der Inhalt des Indexes besteht aus einem Tcl-Dictionary, das den Titel des Indexes, eine Bezeichnung sowie die Schlüsselwörter und Verweise enthält. Die entsprechenden Schlüssel und ihre Werte lauten


**title**
: Der Wert ist eine Zeichenkette, die den Titel des Indexes enthält.

**label**
: Der Wert ist eine Zeichenkette, die eine Bezeichnung für den Index enthält.

**keywords**
: Der Wert ist ein Tcl-Dictionary, das die dem Index bekannten Schlüsselwörter als Schlüssel verwendet. Die zugehörigen Werte sind Listen, die die Bezeichner der Referenzen enthalten, die diesem bestimmten Schlüsselwort zugeordnet sind. Jeder in diesen Listen verwendete Referenzbezeichner muss als Schlüssel im Dictionary **references** vorhanden sein; dessen Definition steht im nächsten Punkt.

**references**
: Der Wert ist ein Tcl-Dictionary, das die dem Index bekannten Bezeichner der Referenzen als Schlüssel verwendet. Die zugehörigen Werte sind Listen mit zwei Elementen, die in dieser Reihenfolge den Typ und die Bezeichnung der Referenz enthalten. Jeder Schlüssel hier muss mindestens einem Schlüsselwort zugeordnet sein, d. h., er muss in mindestens einer der Referenzlisten vorkommen, die die Werte im Dictionary **keywords** bilden; die Definition hierfür steht im vorherigen Punkt.


**\[4\]**
: Der *type* einer Referenz kann einen von zwei Werten annehmen,


**manpage**
: Der Bezeichner der Referenz wird als symbolischer Dateiname interpretiert, der sich auf eines der Dokumente bezieht, für die der Index erstellt wurde.

**url**
: Der Bezeichner der Referenz wird als URL interpretiert, die auf einen externen Ort verweist, beispielsweise eine Website usw.


**kanonische Serialisierung**
: Die kanonische Serialisierung eines Schlüsselwortindexes hat das im vorherigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen des Schlüsselwortindexes eindeutig ist.


**\[1\]**
: Die Schlüssel in allen verschachtelten Tcl-Dictionaries sind in aufsteigender Wörterbuchreihenfolge sortiert, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.

**\[2\]**
: Die für jedes Schlüsselwort des Indexes aufgeführten Referenzen – sofern vorhanden – werden in aufsteigender Wörterbuchordnung ihrer *Bezeichnungen* aufgelistet, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.


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
