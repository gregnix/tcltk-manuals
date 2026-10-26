---
CommandName: doctools::idx::export
ManualSection: n
Version: 0.2.2
TclPart: tcllib
TclDescription: Documentation tools
Keywords:
 - HTML
 - conversion
 - docidx
 - documentation
 - export
 - formatting
 - generation
 - index
 - json
 - keyword index
 - manpage
 - markup
 - nroff
 - plugin
 - reference
 - tcler's wiki
 - text
 - url
 - wiki
Copyright:
 - Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

doctools::idx::export – Export von Schlüsselwortindizes

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [doctools::idx::export]{.lit} [0.2.2]{.optlit} 
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [struct::map]{.lit} 
[package]{.cmd} [require]{.sub} [doctools::idx::structure]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [pluginmgr]{.lit} 
[::doctools::idx::export]{.cmd} [objectName]{.arg} 
[objectName]{.cmd} [method]{.sub} [arg arg]{.optdot} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [export]{.sub} [serial]{.lit} [serial]{.arg} [format]{.optarg} 
[objectName]{.ins} [export]{.sub} [object]{.lit} [object]{.arg} [format]{.optarg} 
[objectName]{.ins} [config]{.sub} [names]{.lit} 
[objectName]{.ins} [config]{.sub} [get]{.lit} 
[objectName]{.ins} [config]{.sub} [set]{.lit} [name]{.arg} [value]{.optarg} 
[objectName]{.ins} [config]{.sub} [unset]{.lit} [pattern...]{.arg} 
[export]{.cmd} [serial]{.arg} [configuration]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt eine Klasse zur Verwaltung der Plugins für den Export von Schlüsselwortindizes in andere Formate bereit, d. h. für deren Konvertierung beispielsweise in *docidx*, *HTML* usw.

Dies ist eine der drei öffentlichen Säulen, auf denen die Verwaltung von Schlüsselwortindizes ruht. Die beiden anderen Säulen sind

**\[1\]**
: *Import von Schlüsselwortindizes* sowie

**\[2\]**
: *Halten von Schlüsselwortindizes* Informationen über **BEGRIFFE** von Schlüsselwortindizes und ihre Bestandteile stehen im gleichnamigen Abschnitt. Informationen über die Datenstruktur, die die wesentliche Eingabe der von diesem Paket bereitgestellten Manager-Objekte ist, stehen im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES**. Das Plugin-System unserer Klasse basiert auf dem Paket **pluginmgr** und ist so konfiguriert, dass es nach Plugins sucht, die

**\[1\]**
: die Umgebungsvariable **DOCTOOLS_IDX_EXPORT_PLUGINS**,

**\[2\]**
: die Umgebungsvariable **DOCTOOLS_IDX_PLUGINS**,

**\[3\]**
: die Umgebungsvariable **DOCTOOLS_PLUGINS**,

**\[4\]**
: der Pfad „*~/.doctools/idx/export/plugin*“

**\[5\]**
: der Pfad „*~/.doctools/idx/plugin*“

**\[6\]**
: der Pfad „*~/.doctools/plugin*“

**\[7\]**
: der Pfad „*~/.doctools/idx/export/plugins*“

**\[8\]**
: der Pfad „*~/.doctools/idx/plugins*“

**\[9\]**
: der Pfad „*~/.doctools/plugins*“

**\[10\]**
: der Registrierungseintrag „HKEY_CURRENT_USER\\SOFTWARE\\DOCTOOLS\\IDX\\EXPORT\\PLUGINS“

**\[11\]**
: der Registrierungseintrag „HKEY_CURRENT_USER\\SOFTWARE\\DOCTOOLS\\IDX\\PLUGINS“

**\[12\]**
: der Registrierungseintrag „HKEY_CURRENT_USER\\SOFTWARE\\DOCTOOLS\\PLUGINS“. Die letzten drei werden nur verwendet, wenn das Paket auf einem Rechner mit dem Betriebssystem Windows(tm) ausgeführt wird. Das gesamte System wird mit sechs vordefinierten Export-Plugins ausgeliefert, nämlich


**docidx**
: Weitere Informationen finden Sie unter *docidx-Export-Plugin*.

**html**
: Einzelheiten stehen in *html export plugin*.

**json**
: Einzelheiten stehen in *json export plugin*.

**nroff**
: Einzelheiten stehen in *nroff export plugin*.

**text**
: Einzelheiten stehen in *text export plugin*.

**wiki**
: Weitere Informationen finden Sie unter *Wiki-Export-Plugin*. Für Leser, die ein eigenes Export-Plugin für ein bestimmtes Format erstellen möchten – d. h. für *Plugin-Entwickler* –, ist es unbedingt erforderlich, den Abschnitt zu lesen und zu verstehen, der die **REFERENZ ZUR EXPORT-PLUGIN-API V2** enthält, da darin die Interaktion zwischen diesem Paket und seinen Plugins im Detail festgelegt wird.


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

**::doctools::idx::export** *objectName*
: Dieser Befehl erstellt ein neues Export-Manager-Objekt mit einem zugehörigen Tcl-Befehl, dessen Name *objectName* lautet. Dieser *object*-Befehl wird in den Abschnitten **Objektbefehl** und **Objektmethoden** ausführlich erläutert. Der Objektbefehl wird unter dem aktuellen Namespace erstellt, wenn *objectName* nicht vollständig qualifiziert ist; andernfalls erfolgt die Erstellung im angegebenen Namespace.


## Objektbefehl

Alle mit dem Befehl **::doctools::idx::export** erstellten Objekte haben die folgende allgemeine Form:

**objectName** **method** ?*arg arg ...*?
: Die Methode **method** und ihre *arg*umente bestimmen das genaue Verhalten des Befehls. Detaillierte Angaben finden Sie im Abschnitt **Objektmethoden**.


## Objektmethoden

*objectName* **destroy**
: Diese Methode löscht das Objekt, für das sie aufgerufen wird.

*objectName* **export serial** *serial* ?*format*?
: Diese Methode nimmt die kanonische Serialisierung eines in *serial* gespeicherten Schlüsselwortindexes entgegen und konvertiert sie unter Verwendung des Export-Plugins für das jeweilige *format* in das angegebene *format*. Wird kein Plugin für das Format gefunden, wird ein Fehler ausgelöst. Die durch den Konvertierungsprozess erzeugte Zeichenkette wird als Ergebnis dieser Methode zurückgegeben. Wenn kein Format festgelegt wird, verwendet die Methode standardmäßig das Format **docidx**. Die Spezifikation dessen, was eine *kanonische* Serialisierung ist, finden Sie im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES**. Das Plugin muss der im Abschnitt **REFERENZ ZUR EXPORT-PLUGIN-API V2** spezifizierten Schnittstelle entsprechen.

*objectName* **export object** *object* ?*format*?
: Diese Methode ist eine praktische Hülle um die im vorherigen Punkt beschriebene Methode **export serial**. Sie setzt voraus, dass *object* ein Objektbefehl ist, der eine **serialize**-Methode unterstützt, die die kanonische Serialisierung eines Schlüsselwortindexes zurückgibt. Sie ruft diese Methode auf, übergibt das Ergebnis an **export serial** und gibt die resultierende Zeichenkette als eigenes Ergebnis zurück.

*objectName* **config names**
: Diese Methode gibt eine Liste zurück, die die Namen aller dem Objekt derzeit bekannten Konfigurationsvariablen enthält.

*objectName* **config get**
: Diese Methode gibt ein Dictionary zurück, das die Namen und Werte aller dem Objekt derzeit bekannten Konfigurationsvariablen enthält.

*objectName* **config set** *name* ?*value*?
: Diese Methode setzt die Konfigurationsvariable *name* auf den angegebenen *value* und gibt den neuen Wert der Variablen zurück. Wird kein Wert angegeben, gibt sie lediglich den aktuellen Wert zurück, ohne ihn zu ändern. Hinweis: Der Benutzer kann zwar die vordefinierten Konfigurationsvariablen **user** und **format** setzen, dies hat jedoch keine Auswirkungen; diese Werte werden intern beim Aufruf eines Import-Plugins überschrieben.

*objectName* **config unset** *pattern*...
: Diese Methode löscht alle Konfigurationsvariablen, auf die die angegebenen *pattern*s passen. Wird kein Muster angegeben, löscht sie alle derzeit definierten Konfigurationsvariablen.


# REFERENZ ZUR EXPORT-PLUGIN-API V2

Dieses Paket nutzt Plugins, um die Unterstützung für alle Ausgabeformate zu verwalten, die über das **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES** hinausgehen. Hier legen wir die API fest, über die die von diesem Paket erstellten Objekte mit ihren Plugins interagieren.

Ein Plugin für dieses Paket muss die nachfolgend aufgeführten Regeln einhalten:

**\[1\]**
: Ein Plugin ist ein Paket.

**\[2\]**
: Der Name eines Plugin-Pakets hat die Form doctools::idx::export::**FOO**, wobei **FOO** der Name des Formats ist, für das das Plugin eine Ausgabe generieren wird. Dieser Name ist zugleich das Argument, das den verschiedenen **export**-Methoden von Export-Manager-Objekten übergeben werden muss, um eine Zeichenkette mit der Kodierung des Schlüsselwortindexes in diesem Format zu erhalten.

**\[3\]**
: Das Plugin kann davon ausgehen, dass das Paket **doctools::idx::export::plugin** vorhanden ist, was darauf hindeutet, dass es von einem echten Plugin-Manager aufgerufen wurde.

**\[4\]**
: Ein Plugin muss einen Befehl bereitstellen, dessen Signatur wie unten dargestellt lautet.


**export** *serial* *configuration*
: Immer wenn ein Exportmanager von **doctools::idx** eine Ausgabe für einen Index erstellen muss, wird dieser Befehl aufgerufen.


string *serial*
: Dieses Argument enthält die *kanonische* Serialisierung des Indexes, für den die Ausgabe generiert werden soll. Die Definition dessen, was eine *kanonische* Serialisierung ist, finden Sie im Abschnitt **SERIALISIERUNGSFORMAT FÜR SCHLÜSSELWORTINDIZES**.

dictionary *configuration*
: Dieses Argument enthält die bei der Erzeugung anzuwendende Konfiguration, als Dictionary von Variablennamen auf Werte. Die folgenden Konfigurationsvariablen haben eine vorgegebene Bedeutung, an die sich alle Plugins halten müssen, auch wenn sie diese Angabe nach eigenem Ermessen ignorieren können. Jede weitere Konfigurationsvariable, die ein Plugin erkennt, ist in der Handbuchseite dieses Plugins beschrieben.


**user**
: Diese Variable soll den Namen des Benutzers enthalten, dem der Prozess gehört, der das Plugin aufruft.

**format**
: Diese Variable soll den Namen des Formats enthalten, dessen Plugin aufgerufen wird.

**file**
: Diese Variable soll, wenn sie vom Benutzer des Index-Objekts definiert wurde, den Namen der Eingabedatei enthalten, für die das Plugin seine Ausgabe generiert.

**map**
: Diese Variable soll, wenn sie vom Benutzer des Indexobjekts definiert wurde, ein Dictionary enthalten, das die in den Referenzen vom Typ **manpage** verwendeten symbolischen Namen den tatsächlichen Pfaden (oder URLs) zuordnet. Ein Plugin muss in der Lage sein, den Fall zu behandeln, dass für einen symbolischen Namen kein Eintrag in diesem Dictionary vorhanden ist.


**\[5\]**
: Ein einzelner Nutzungszyklus eines Plugins besteht aus den Aufrufen des Befehls **export**. Dieser Aufruf muss das Plugin in einem Zustand hinterlassen, in dem ein weiterer Nutzungszyklus problemlos ausgeführt werden kann.


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
Copyright (c) 2009-2019 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
