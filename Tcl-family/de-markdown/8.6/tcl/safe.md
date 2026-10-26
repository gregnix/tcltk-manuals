---
CommandName: Safe Tcl
ManualSection: n
Version: 8.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - interp(n)
 - library(n)
 - load(n)
 - package(n)
 - source(n)
 - unknown(n)
Keywords:
 - alias
 - auto-loading
 - auto_mkindex
 - load
 - parent interpreter
 - safe interpreter
 - child interpreter
 - source
Copyright:
 - Copyright (c) 1995-1996 Sun Microsystems, Inc.
---

# NAME

safe - Erstellt und manipuliert sichere Interpreter

# ÜBERSICHT

## OPTIONEN

::: {.synopsis} :::
[::safe::interpCreate]{.cmd} [child]{.optarg} [options]{.optdot} 
[::safe::interpInit]{.cmd} [child]{.arg} [options]{.optdot} 
[::safe::interpConfigure]{.cmd} [child]{.arg} [options]{.optdot} 
[::safe::interpDelete]{.cmd} [child]{.arg} 
[::safe::interpAddToAccessPath]{.cmd} [child]{.arg} [directory]{.arg} 
[::safe::interpFindInAccessPath]{.cmd} [child]{.arg} [directory]{.arg} 
[::safe::setLogCmd]{.cmd} [cmd arg]{.optdot} 
:::

?**-accessPath** *pathList*? ?**-statics** *boolean*? ?**-noStatics**? ?**-nested** *boolean*? ?**-nestedLoadOk**? ?**-deleteHook** *script*?

# BESCHREIBUNG

Safe Tcl ist ein Mechanismus zum sicheren Ausführen nicht vertrauenswürdiger Tcl-Skripte und zur vermittelten Bereitstellung potenziell gefährlicher Funktionalität für solche Skripte.

Safe Tcl stellt sicher, dass nicht vertrauenswürdige Tcl-Skripte der hostenden Anwendung keinen Schaden zufügen können. Es verhindert Angriffe auf Integrität und Vertraulichkeit. Nicht vertrauenswürdige Tcl-Skripte können den Zustand der hostenden Anwendung oder des Computers nicht beschädigen. Nicht vertrauenswürdige Skripte können außerdem keine auf dem hostenden Computer oder in der hostenden Anwendung gespeicherten Informationen an Dritte weitergeben.

Safe Tcl ermöglicht einem Eltern-Interpreter, sichere, eingeschränkte Interpreter zu erzeugen, die eine vordefinierte Menge von Aliasen für die Befehle **source**, **load**, **file**, **encoding** und **exit** enthalten und die Auto-Load- und Paketmechanismen nutzen können.

Dem sicheren Interpreter werden keine Kenntnisse über die Struktur des Dateisystems preisgegeben, weil er nur Zugriff auf einen virtualisierten Pfad mit Token hat. Wenn der sichere Interpreter eine Datei sourcen möchte, verwendet er das Token im virtuellen Pfad als Teil des zu sourcenden Dateinamens; der Eltern-Interpreter übersetzt das Token transparent in einen echten Verzeichnisnamen und führt die angeforderte Operation aus (siehe den Abschnitt **SICHERHEIT** unten). Verschiedene Sicherheitsstufen können über die optionalen Schalter der unten beschriebenen Befehle gewählt werden.

Alle von Safe Tcl im Eltern-Interpreter bereitgestellten Befehle befinden sich im Namespace **safe**.

# BEFEHLE

Im Eltern-Interpreter stehen folgende Befehle zur Verfügung:

**::safe::interpCreate** ?*child*? ?*options\...*?
: Erstellt einen sicheren Interpreter, installiert die im Abschnitt **ALIASSE** beschriebenen Aliasen und initialisiert den Auto-Load- und Paketmechanismus gemäß den übergebenen *options*. Siehe den Abschnitt **OPTIONEN** unten für eine Beschreibung der optionalen Argumente. Wird das Argument *child* weggelassen, wird ein Name erzeugt. **::safe::interpCreate** gibt stets den Interpreter-Namen zurück.

    Der Interpreter-Name *child* darf Namespace-Trennzeichen enthalten, jedoch weder führende noch nachgestellte Namespace-Trennzeichen und keine überzähligen Doppelpunkte in Namespace-Trennzeichen. Der Interpreter-Name ist relativ zum globalen Namespace :: qualifiziert, nicht relativ zum Namespace, in dem der Befehl **::safe::interpCreate** ausgewertet wird.

**::safe::interpInit** *child* ?*options\...*?
: Dieser Befehl ähnelt **interpCreate**, erzeugt den sicheren Interpreter jedoch nicht. *child* muss auf andere Weise erzeugt worden sein, z. B. mit **interp create** **-safe**. Der Interpreter-Name *child* darf Namespace-Trennzeichen enthalten, unter denselben Einschränkungen wie bei **interpCreate**.

**::safe::interpConfigure** *child* ?*options\...*?
: Werden keine *options* angegeben, gibt der Befehl die Einstellungen aller Optionen für den benannten sicheren Interpreter als Liste von Optionen und deren aktuellen Werten für dieses *child* zurück. Wird genau ein weiteres Argument übergeben, liefert er eine Liste mit 2 Elementen *name* und *value*, wobei *name* der vollständige Name dieser Option ist und *value* der aktuelle Wert für diese Option und das *child*. Werden mehr als zwei weitere Argumente übergeben, wird der sichere Interpreter neu konfiguriert und ausschließlich die angegebenen Optionen geändert. Siehe den Abschnitt **OPTIONEN** unten für die Optionsbeschreibung. Beispiel:

```
# Neuen Interp mit derselben Konfiguration wie "$i0" erzeugen:
set i1 [safe::interpCreate {*}[safe::interpConfigure $i0]]

# Aktuellen deleteHook abfragen
set dh [safe::interpConfigure $i0  -del]

# Nur das Attribut statics loading ok eines Interpreters und seinen
# deleteHook ändern (Rest unverändert lassen):
safe::interpConfigure $i0  -delete {foo bar} -statics 0
```

**::safe::interpDelete** *child*
: Löscht den sicheren Interpreter und räumt die zugehörigen Datenstrukturen des Eltern-Interpreters auf. Wurde für diesen Interpreter ein *deleteHook*-Skript angegeben, wird es vor dem Löschen des Interpreters mit dem Namen des Interpreters als zusätzlichem Argument ausgewertet.

**::safe::interpFindInAccessPath** *child* *directory*
: Dieser Befehl sucht und gibt das Token für das reale Verzeichnis *directory* im aktuellen virtuellen Zugriffspfad des sicheren Interpreters zurück. Er erzeugt einen Fehler, wenn das Verzeichnis nicht gefunden wird. Beispiel:

```
$child eval [list set tk_library \
      [::safe::interpFindInAccessPath $name $tk_library]]
```

**::safe::interpAddToAccessPath** *child* *directory*
: Dieser Befehl fügt *directory* dem im Eltern-Interpreter für den sicheren Interpreter verwalteten virtuellen Pfad hinzu und gibt das Token zurück, mit dem der sichere Interpreter auf Dateien in diesem Verzeichnis zugreifen kann. Befindet sich das Verzeichnis bereits im virtuellen Pfad, wird nur das Token zurückgegeben, ohne das Verzeichnis erneut hinzuzufügen. Beispiel:

```
$child eval [list set tk_library \
      [::safe::interpAddToAccessPath $name $tk_library]]
```

**::safe::setLogCmd** ?*cmd arg\...*?
: Dieser Befehl installiert ein Skript, das bei interessanten Ereignissen im Lebenszyklus eines sicheren Interpreters aufgerufen wird. Ohne Argumente gibt er das aktuell installierte Skript zurück. Mit einem Argument, der leeren Zeichenkette, wird das aktuell installierte Skript entfernt und die Protokollierung abgeschaltet. Das Skript wird mit einem zusätzlichen Argument aufgerufen, einer Zeichenkette, die das Ereignis beschreibt. Der Hauptzweck ist die Unterstützung beim Debuggen sicherer Interpreter. Mit dieser Einrichtung können vollständige Fehlermeldungen erhalten werden, während der sichere Interpreter nur generische Fehlermeldungen erhält. So kann ein sicherer Interpreter keine Meldungen über Fehler und andere Ereignisse sehen, die sensible Informationen wie echte Verzeichnisnamen enthalten könnten.

    Beispiel:

```
::safe::setLogCmd puts stderr
```

Unten steht die Ausgabe einer Beispielsitzung, in der ein sicherer Interpreter versuchte, eine Datei zu sourcen, die nicht in seinem virtuellen Zugriffspfad gefunden wurde. Beachten Sie, dass der sichere Interpreter nur eine Fehlermeldung erhielt, dass die Datei nicht gefunden wurde:

```
NOTICE for child interp10 : Created
NOTICE for child interp10 : Setting accessPath=(/foo/bar) staticsok=1 nestedok=0 deletehook=()
NOTICE for child interp10 : auto_path in interp10 has been set to {$p(:0:)}
ERROR for child interp10 : /foo/bar/init.tcl: no such file or directory
```

## OPTIONEN

Die folgenden Optionen gelten gemeinsam für **::safe::interpCreate**,
**::safe::interpInit** und **::safe::interpConfigure**. Jeder Optionsname kann auf seinen minimalen eindeutigen Namen abgekürzt werden. Optionsnamen sind nicht case-sensitiv.

**-accessPath** *directoryList*
: Diese Option legt die Liste der Verzeichnisse fest, aus denen der sichere Interpreter Dateien **source**n und **load**en darf. Wird die Option nicht angegeben oder als leere Liste übergeben, verwendet der sichere Interpreter dieselben Verzeichnisse wie sein Eltern-Interpreter für Auto-Loading. Siehe den Abschnitt **SICHERHEIT** unten für Details zu virtuellen Pfaden, Token und Zugriffskontrolle.

**-statics** *boolean*
: Diese Option legt fest, ob der sichere Interpreter statisch verlinkte Pakete laden darf (wie **load {} Tk**). Der Standardwert ist **true**: sichere Interpreter dürfen statisch verlinkte Pakete laden.

**-noStatics**
: Diese Option ist eine Kurzform für **-statics false** und legt fest, dass der sichere Interpreter keine statisch verlinkten Pakete laden darf.

**-nested** *boolean*
: Diese Option legt fest, ob der sichere Interpreter Pakete in seine eigenen Unter-Interpreter laden darf. Der Standardwert ist **false**: sichere Interpreter dürfen keine Pakete in ihre eigenen Unter-Interpreter laden.

**-nestedLoadOk**
: Diese Option ist eine Kurzform für **-nested true** und legt fest, dass der sichere Interpreter Pakete in seine eigenen Unter-Interpreter laden darf.

**-deleteHook** *script*
: Wird diese Option mit einem nicht-leeren *script* angegeben, wird es im Eltern-Interpreter kurz vor dem tatsächlichen Löschen des sicheren Interpreters mit dem Namen des sicheren Interpreters als zusätzlichem Argument ausgewertet. Ein leerer Wert entfernt jedes aktuell installierte Lösch-Hook-Skript für diesen sicheren Interpreter. Der Standardwert (**{}**) bedeutet: kein Lösch-Rückruf.

# ALIASSE

In einem sicheren Interpreter stehen folgende Aliasen zur Verfügung:

**source** *fileName*
: Die angeforderte Datei, eine Tcl-Quelldatei, wird in den sicheren Interpreter gesourct, wenn sie gefunden wird. Der Alias **source** kann nur Dateien aus Verzeichnissen im virtuellen Pfad des sicheren Interpreters sourcen. Der Alias **source** verlangt, dass der sichere Interpreter eines der Token-Namen in seinem virtuellen Pfad verwendet, um das Verzeichnis anzugeben, in dem die zu sourcende Datei liegt. Siehe den Abschnitt **SICHERHEIT** für weitere Einschränkungen gültiger Dateinamen.

**load** *fileName*
: Die angeforderte Datei, eine Shared-Object-Datei, wird dynamisch in den sicheren Interpreter geladen, wenn sie gefunden wird. Der Dateiname muss ein im virtuellen Pfad des sicheren Interpreters genanntes Token enthalten, damit das Laden erfolgreich ist. Zusätzlich muss die Shared-Object-Datei einen sicheren Einstiegspunkt enthalten; siehe die Manpage des Befehls **load** für Details.

**file** ?*subCmd args\...*?
: Der Alias **file** bietet Zugriff auf eine sichere Teilmenge der Unterbefehle des Befehls **file**; er erlaubt nur die Unterbefehle **dirname**, **join**, **extension**, **root**, **tail**, **pathtype** und **split**. Für Details zu diesen Unterbefehlen siehe die Manpage des Befehls **file**.

**encoding** ?*subCmd args\...*?
: Der Alias **encoding** bietet Zugriff auf eine sichere Teilmenge der Unterbefehle des Befehls **encoding**; er verbietet das Setzen der Systemkodierung, erlaubt aber alle anderen Unterbefehle einschließlich **system** zum Abfragen der aktuellen Kodierung.

**exit**
: Der aufrufende Interpreter wird gelöscht und seine Auswertung gestoppt, der Tcl-Prozess, in dem dieser Interpreter existiert, wird jedoch nicht beendet.

# SICHERHEIT

Safe Tcl versucht nicht, Belästigungs- und Denial-of-Service-Angriffe vollständig zu verhindern. Diese Angriffsformen verhindern, dass Anwendung oder Benutzer den Computer vorübergehend für nützliche Arbeit nutzen können, z. B. durch Verbrauch der gesamten CPU-Zeit oder des gesamten Bildschirmplatzes. Diese Angriffe sind zwar ärgerlich, gelten im Allgemeinen jedoch als weniger wichtig als Integritäts- und Vertraulichkeitsangriffe, die Safe Tcl verhindern soll.

Die in einem sicheren Interpreter verfügbaren Befehle sind zusätzlich zur sicheren Menge gemäß der Manpage **interp** vermittelte Aliasen für **source**, **load**, **exit** sowie sichere Teilmengen von **file** und **encoding**. Der sichere Interpreter kann Code auch per Auto-Load laden und das Laden von Paketen anfordern.

Da einige dieser Befehle auf das lokale Dateisystem zugreifen, besteht die Möglichkeit von Informationslecks über dessen Verzeichnisstruktur. Um dies zu verhindern, verwenden Befehle, die in einem sicheren Interpreter Dateinamen als Argumente erwarten, Token statt echter Verzeichnisnamen. Diese Token werden in einen echten Verzeichnisnamen übersetzt, während z. B. eine Anforderung zum Sourcen einer Datei vom Eltern-Interpreter vermittelt wird. Dieses virtuelle Pfadsystem wird im Eltern-Interpreter für jeden von **::safe::interpCreate** erzeugten oder von **::safe::interpInit** initialisierten sicheren Interpreter verwaltet; der Pfad bildet im sicheren Interpreter zugängliche Token auf reale Pfadnamen im lokalen Dateisystem ab und verhindert so, dass sichere Interpreter Kenntnis über die Dateisystemstruktur des Hosts erlangen, auf dem der Interpreter läuft. Die einzigen gültigen Dateinamen-Argumente für die dem Kind bereitgestellten Aliasen **source** und **load** sind Pfade der Form **\[file join** *token filename*__\]__ (d. h. im nativen Pfadformat: *token*__/__*filename* unter Unix und *token*__\\__*filename* unter Windows), wobei *token* eines der Verzeichnisse der *accessPath*-Liste repräsentiert und *filename* eine Datei in diesem Verzeichnis ist (Zugriff auf Unterverzeichnisse ist nicht erlaubt).

Wird ein Token in einem sicheren Interpreter in einer Anforderung zum Sourcen oder Laden einer Datei verwendet, wird das Token geprüft und in einen realen Pfadnamen übersetzt; die zu sourcende oder ladende Datei wird im Dateisystem gesucht. Der sichere Interpreter erlangt niemals Kenntnis des tatsächlichen Pfadnamens, unter dem die Datei im Dateisystem gespeichert ist.

Um weiteres potenzielles Informationslecken aus sensiblen Dateien zu verhindern, die versehentlich in der Menge der vom sicheren Interpreter sourcbaren Dateien enthalten sind, schränkt der Alias **source** den Zugriff auf Dateien ein, die folgende Bedingungen erfüllen: Der Dateiname darf höchstens vierzehn Zeichen lang sein, darf höchstens einen Punkt **.** enthalten, muss mit der Erweiterung **.tcl** enden oder **tclIndex** heißen.

Jedes Element der anfänglichen Zugriffspfad-Liste erhält ein Token, das im Kind-**auto_path** gesetzt wird; das erste Element dieser Liste wird als **tcl_library** des Kindes gesetzt.

Wird das Zugriffspfad-Argument nicht angegeben oder ist es die leere Liste, greift das Standardverhalten: Das Kind erhält Zugriff auf dieselben Pakete wie der Eltern-Interpreter (genauer: nur in Tcl geschriebene Pakete, die per Definition nicht gefährlich sind, weil sie im Kind-Interpreter laufen, und C-Erweiterungen mit einem \_SafeInit-Einstiegspunkt). Dazu wird der **auto_path** des Eltern-Interpreters zur Konstruktion des Kind-Zugriffspfads verwendet. Damit das Kind die Tcl-Bibliotheksdateien (einschließlich des Auto-Load-Mechanismus selbst) erfolgreich laden kann, wird **tcl_library** bei Bedarf hinzugefügt oder an die erste Position verschoben, sodass die Kind-**tcl_library** dieselbe wie die des Eltern-Interpreters ist (der reale Pfad bleibt dem Kind verborgen). Damit Auto-Loading für Kind und Eltern in diesem Standardfall gleich funktioniert, werden die Unterverzeichnisse erster Ebene jedes Verzeichnisses im Eltern-**auto_path** (falls noch nicht enthalten) ebenfalls dem Kind-Zugriffspfad hinzugefügt. Sie können jederzeit einen restriktiveren Pfad angeben, in dem bestimmte Unterverzeichnisse nie durchsucht werden, indem Sie Ihre Verzeichnisliste explizit mit dem Schalter **-accessPath** statt dieses Standardmechanismus angeben.

Wird *accessPath* nach der ersten Erzeugung oder Initialisierung geändert (z. B. über **interpConfigure -accessPath** *list*), wird im sicheren Interpreter automatisch **auto_reset** ausgewertet, um **auto_index** mit der neuen Token-Liste zu synchronisieren.
