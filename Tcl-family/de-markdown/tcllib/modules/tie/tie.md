---
CommandName: tie
title: tie
ManualSection: n
Version: 1.3
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - array
 - database
 - file
 - metakit
 - persistence
 - tie
 - untie
Copyright:
 - Copyright (c) 2004-2021 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tie – Persistenz von Arrays

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [tie]{.lit} [1.3]{.optlit}
[::tie::tie]{.cmd} [arrayvarname]{.arg} [options...]{.arg} [dstype]{.arg} [dsname...]{.arg}
[::tie::untie]{.cmd} [arrayvarname]{.arg} [token]{.optarg}
[::tie::info]{.cmd} [ties]{.lit} [arrayvarname]{.arg}
[::tie::info]{.cmd} [types]{.lit}
[::tie::info]{.cmd} [type]{.lit} [dstype]{.arg}
[::tie::register]{.cmd} [dsclasscmd]{.arg} [as]{.lit} [dstype]{.arg}
[dsclasscmd]{.cmd} [objname]{.arg} [dsname...]{.optarg}
[ds]{.cmd} [destroy]{.lit}
[ds]{.cmd} [names]{.lit}
[ds]{.cmd} [size]{.lit}
[ds]{.cmd} [get]{.lit}
[ds]{.cmd} [set]{.lit} [dict]{.arg}
[ds]{.cmd} [unset]{.lit} [pattern]{.optarg}
[ds]{.cmd} [setv]{.lit} [index]{.arg} [value]{.arg}
[ds]{.cmd} [unsetv]{.lit} [index]{.arg}
[ds]{.cmd} [getv]{.lit} [index]{.arg}
:::

# Beschreibung

Das Paket **tie** bietet einen Rahmen für die Erstellung persistenter Tcl-Array-Variablen. Zu beachten ist, dass der bereitgestellte Mechanismus so allgemein gehalten ist, dass er auch für die Verteilung der Inhalte von Tcl-Arrays auf mehrere Threads und Prozesse, d. h. für die Kommunikation, genutzt werden kann.

Dies – Persistenz und Kommunikation – wird erreicht, indem eine Tcl-Array-Variable an eine *Datenquelle* *gebunden* wird. Beispiele für Datenquellen sind andere Tcl-Arrays und Dateien.

Beachten Sie, dass eine einzelne Tcl-Array-Variable mit mehr als einer *Datenquelle* verknüpft werden kann. Gerade diese Funktion ermöglicht es, den Rahmen auch für die Kommunikation zu nutzen. Verknüpfen Sie einfach mehrere Tcl-Arrays in verschiedenen Client-Prozessen mit einem Tcl-Array auf einem Server, und alle Änderungen an einem dieser Arrays werden an alle anderen weitergegeben. Natürlich sind auch weniger zentralisierte Varianten davon möglich.

# Verwendung von Ties

## Tie-API

In diesem Abschnitt wird die grundlegende API beschrieben, mit der Verknüpfungen zwischen Tcl-Array-Variablen und Datenquellen hergestellt und aufgehoben werden. Diese Schnittstelle ist die einzige, mit der sich ein Gelegenheitsnutzer befassen muss. Die folgenden Abschnitte über die verschiedenen internen Schnittstellen können getrost übersprungen werden.

**::tie::tie** *arrayvarname* *options*... *dstype* *dsname*...
: Dieser Befehl stellt eine Verknüpfung zwischen dem Tcl-Array her, dessen Name durch das Argument *arrayvarname* angegeben wird, und der *Datenquelle*, die durch das Argument *dstype* und die Reihe von *dsname*-Argumenten identifiziert wird. Alle Änderungen, die nach der Ausführung dieses Befehls am Tcl-Array vorgenommen werden, werden zur sicheren Aufbewahrung (oder zur Verteilung) in der *Datenquelle* gespeichert.

    Das Ergebnis des Befehls ist stets ein Token, das die neue Verknüpfung identifiziert. Dieses Token kann später verwendet werden, um diese spezifische Verknüpfung aufzuheben.

    varname *arrayvarname* (in)
    : Der Name der Tcl-Array-Variablen, mit der die neue Verbindung hergestellt werden soll.

    name|command *dstype* (in)
    : Dieses Argument legt den Typ der *Datenquelle* fest, auf die Sie zugreifen möchten. Der *dstype* kann einer der folgenden Werte sein: **log**, **array**, **remotearray**, **file**, **growfile** oder **dsource**; darüber hinaus kann der Programmierer weitere Datenquellentypen registrieren. Auf jeden *dstype* folgen ein oder mehrere Argumente, die die *Datenquelle* identifizieren, an die das Array gebunden werden soll.

    string *dsname* (in)
    : Die Reihe von *dsname*-Argumenten, die auf den *dstype* folgen, identifiziert die *Datenquelle*, mit der wir eine Verbindung herstellen möchten, und muss für den gewählten Typ geeignet sein.


    Der Befehl unterstützt eine Reihe weiterer Optionen, die den Prozess der Einrichtung der Verbindung zwischen dem Tcl-Array und der *Datenquelle* steuern.

    **-open**
    : Das Tcl-Array für die neue Verknüpfung wird aus der *Datenquelle* *geladen*, und der zuvor vorhandene Inhalt des Tcl-Arrays wird gelöscht. Es wird darauf geachtet, den bisherigen Inhalt *nicht* zu löschen, falls die Erstellung der Verknüpfung fehlschlägt.

        Diese Option und die Option **-save** schließen sich gegenseitig aus. Wenn weder diese noch die Option **-save** angegeben sind, wird diese Option als Standard angenommen.

    **-save**
    : Das Tcl-Array für die neue Verknüpfung wird in der *Datenquelle* *gespeichert*, und der zuvor vorhandene Inhalt der *Datenquelle* wird gelöscht.

        Diese Option und die Option **-open** schließen sich gegenseitig aus. Wenn weder diese Option noch die Option **-open** festgelegt wird, wird standardmäßig die Option **-open** angenommen.

    **-merge**
    : Die Verwendung dieser Option verhindert das Löschen bereits vorhandener Inhalte und führt stattdessen eine Zusammenführung der Daten durch. Sie kann in Verbindung mit **-open** oder **-save** festgelegt werden. Diese Optionen legen fest, wie mit Daten verfahren wird, die sowohl im Tcl-Array als auch in der *Datenquelle* vorhanden sind, d. h. mit Duplikaten.

        Wenn **-open** verwendet wird, haben die Daten in der *Datenquelle* Vorrang. Mit anderen Worten: Bei Duplikaten werden die Daten aus der *Datenquelle* in das Tcl-Array geladen.

        Bei Verwendung mit **-save** haben die Daten im Tcl-Array Vorrang. Mit anderen Worten: Bei Duplikaten werden die Daten aus dem Tcl-Array in die *Datenquelle* gespeichert.


**::tie::untie** *arrayvarname* ?*token*?
: Dieser Befehl löst eine oder mehrere Verknüpfungen auf, die mit dem durch *arrayvarname* benannten Tcl-Array verbunden sind. Wird kein *token* angegeben, werden alle Verknüpfungen zu diesem Tcl-Array aufgelöst. Andernfalls wird nur die Verbindung entfernt, für die das Token steht, sofern diese tatsächlich mit dem Array verbunden ist. Der Versuch, eine bestimmte Verbindung zu entfernen, die nicht zu dem angegebenen Array gehört, führt zu einem Fehler.

    Zu beachten ist, dass durch das Aufheben einer Verbindung zwar die paketinternen Verwaltungsinformationen zerstört werden, die *Datenquelle*, die von der Verbindung verwaltet wurde, jedoch nicht verändert, sondern lediglich geschlossen wird.

    Nachdem der Befehl zurückgibt, werden keine der am Array vorgenommenen Änderungen mehr in der *Datenquelle* gespeichert.

    Das Ergebnis des Befehls ist eine leere Zeichenkette.

    varname *arrayname* (in)
    : Der Name einer Tcl-Array-Variablen, die möglicherweise Verknüpfungen aufweist.

    handle *token* (in)
    : Ein Handle, das eine bestimmte Verbindung repräsentiert. Dieses Argument ist optional.


**::tie::info** **ties** *arrayvarname*
: Dieser Befehl gibt eine Liste der „Ties“ zurück, die der durch *arrayvarname* bezeichneten Tcl-Array-Variablen zugeordnet sind. Die Ergebnisliste ist leer, wenn der Variablen keine „Ties“ zugeordnet sind.

**::tie::info** **types**
: Dieser Befehl gibt ein Dictionary zurück, das die registrierten Typen sowie die ihnen zugeordneten Klassenbefehle enthält.

**::tie::info** **type** *dstype*
: Dieser Befehl gibt den vollständig aufgelösten Befehl für eine Klasse mit dem Namen des Typs zurück. Das bedeutet, dass der Befehl einer Kette von Typdefinitionen bis zu deren Ende folgt.


## Standarddatenquellentypen

Dieses Paket stellt die folgenden sechs Typen als Beispiele und Standarddatenquellen bereit.

**log**
: Diese *Datenquelle* verwaltet weder tatsächliche Daten noch sorgt sie für deren dauerhafte Speicherung. Sie akzeptiert keine identifizierenden Argumente. Alle Änderungen werden lediglich in **stdout** protokolliert.

**array**
: Diese *Datenquelle* verwendet ein reguläres Tcl-Array als Quelle für die persistenten Daten. Sie akzeptiert ein einziges identifizierendes Argument, nämlich den Namen dieses Tcl-Arrays. Alle Änderungen werden in dieses Array übernommen.

**remotearray**
: Diese *Datenquelle* ähnelt **array**. Der Unterschied besteht darin, dass auf das Tcl-Array, auf das wir spiegeln, nicht direkt zugegriffen werden kann, sondern nur über einen Befehl vom Typ **send**.

    Er akzeptiert drei identifizierende Argumente: den Namen des anderen Tcl-Arrays, den Befehls-Präfix für den **send**-ähnlichen Zugriffs-Befehl sowie eine Kennung für die Remote-Entität, die das Array hostet – in dieser Reihenfolge. Alle Änderungen werden über das Befehlspräfix auf dieses Array gespiegelt. Alle Befehle werden im Kontext des globalen Namespaces ausgeführt.

    „**send**-ähnlich“ bedeutet, dass das Befehlspräfix die Syntax und Semantik von **send** aufweisen muss. Das heißt, es handelt sich um einen Kanal, über den wir beliebige Befehle an eine andere Instanz senden können. Die *Datenquelle* des Remote-Arrays verwendet jedoch ausschließlich die Befehle **set**, **unset**, **array exists**, **array names**, **array set** und **array get**, um Werte im Remote-Array abzurufen und festzulegen.

    Das Befehlspräfix und die Entitäts-ID sind voneinander getrennt, damit die Datenquelle beim Zusammenstellen der eigentlichen Befehle Optionen wie **-async** verwenden kann.

    Beispiele für Befehlspräfixe, aufgeführt zusammen mit der ID der Remote-Entität, ohne Optionen. Tatsächlich ist nur der Teil vor der ID das Befehlspräfix:

    **send** *tkname*
    : Das Tcl-Array befindet sich in einem entfernten Interpreter und wird über die X-Kommunikation von Tk aufgerufen.

    **comm::comm send** *hostportid*
    : Das Tcl-Array befindet sich in einem Remote-Interpreter und wird über einen Socket aufgerufen.

    **thread::send** *threadid*
    : Das Tcl-Array befindet sich in einem Remote-Interpreter in einem anderen Thread dieses Prozesses.


**file**
: Diese *Datenquelle* verwendet eine einzelne Datei als Quelle für die persistenten Daten. Sie akzeptiert ein einziges identifizierendes Argument: den Pfad zu dieser Datei. Die Datei muss sowohl lesbar als auch beschreibbar sein. Sie darf noch nicht vorhanden sein; in diesem Fall legt die *Datenquelle* sie an. Nur in diesem (und ausschließlich in diesem) Fall muss das Verzeichnis, in dem sich die Datei befindet, ebenfalls vorhanden und beschreibbar sein.

    Alle Änderungen werden in der Datei als korrekte Tcl-Befehle gespeichert, wobei pro Operation ein Befehl steht. Mit anderen Worten: Die Datei enthält stets ein korrektes Tcl-Skript.

    Existiert die Datei bereits, wenn die sie verwendende „tie“-Verbindung eingerichtet wird, wird sie komprimiert, d. h., überflüssige Operationen werden entfernt, sofern das darin gespeicherte Operationenprotokoll entweder mindestens eine Operation enthält, die das gesamte Array löscht, oder mindestens das 1,5-Fache an Operationen im Vergleich zu den Einträgen im geladenen Array aufweist.

**growfile**
: Diese *Datenquelle* ähnelt **file** hinsichtlich des Speichermediums für die Array-Daten und ihrer Konfiguration. Im Gegensatz zu ersterer geht sie jedoch davon aus und stellt sicher, dass das verknüpfte Array niemals schrumpft. Das heißt: Das Anlegen neuer Array-Einträge sowie die Änderung bestehender Einträge ist zulässig, das Löschen von Einträgen hingegen nicht und führt dazu, dass die Datenquelle Fehler meldet.

    Diese Einschränkung ermöglicht es uns, sowohl das Dateiformat als auch den Zugriff auf die Datei radikal zu vereinfachen. Zum einen wird die Datei nur einmal gelesen, und der interne Cache kann nicht ungültig gemacht werden. Zweitens beschränkt sich das Schreiben von Daten auf ein einfaches Anhängen, und es ist kein Komprimierungsschritt erforderlich. Das Format des Inhalts ist die Zeichenfolgendarstellung eines Dictionarys, das am Ende unbegrenzt schrittweise erweitert werden kann.

**dsource**
: Diese *Datenquelle* verwendet ein explizit angegebenes *Datenquellenobjekt* als Quelle für die persistenten Daten. Sie akzeptiert ein einziges identifizierendes Argument, das Befehlspräfix, d. h. den Objektbefehl.

    Um diesen Typ zu verwenden, müssen Sie wissen, wie der Rahmen Verknüpfungen verwaltet und was **data source objects** sind.

    Alle Änderungen werden an das angegebene Objekt weitergeleitet.


# Neue Datenquellen anlegen

Dieser Abschnitt ist für den gelegentlichen Nutzer von Ties nicht von Interesse. Nur Entwickler, die neue Datenquellen erstellen möchten, müssen die hier bereitgestellten Informationen kennen.

## Datenquellen-Objekte

Alle Verknüpfungen werden intern durch ein In-Memory-Objekt dargestellt, das als Vermittler zwischen dem Verknüpfungs-Rahmen und der jeweiligen *Datenquelle* – wie beispielsweise einem Array, einer Datei usw. – fungiert. Dies ist das *Datenquellen-Objekt*.

Die Klasse „**data source class**“ ist *keine* generische Klasse, sondern spezifisch für den Typ der *Datenquelle*. Um eine neue *Datenquelle* zu erstellen, müssen wir eine solche Klasse schreiben und diese anschließend als neuen Typ beim Rahmen registrieren.

In den folgenden Unterabschnitten werden die verschiedenen APIs beschrieben, denen ein **data source class** und die von ihm generierten Objekte entsprechen müssen, um die Kompatibilität mit dem tie-Rahmen zu gewährleisten.

Datenquellenobjekte werden normalerweise automatisch vom Rahmen erstellt und gelöscht, wenn eine Verknüpfung angelegt oder entfernt wird. Diese Verwaltung kann durch die Verwendung des Typs „dsource“ explizit umgangen werden. Die *Datenquelle* für diesen Typ ist selbst ein *Datenquellenobjekt*, und dieses Objekt befindet sich außerhalb des Geltungsbereichs des Tie-Rahmens und wird von diesem nicht verwaltet. Mit anderen Worten: Dieser Typ ermöglicht die Erstellung von Ties, die mit bereits vorhandenen *Datenquellenobjekten* kommunizieren, und diese Objekte bleiben auch nach dem Entfernen der Ties, die sie nutzen, erhalten.

## Eine neue Datenquellenklasse registrieren

Nachdem ein **data source class** geschrieben wurde, muss es als neuer Typ im Rahmen registriert werden.

**::tie::register** *dsclasscmd* **as** *dstype*
: Durch die Verwendung dieses Befehls speichert das Tie-Framework den Befehl für die Klasse *dsclasscmd* eines **data source class** unter dem Namen *dstype*.

    Nach dem Aufruf akzeptiert das Argument *dstype* des Basisbenutzerbefehls **::tie::tie** *dstype* als Typnamen und wandelt diesen intern in den entsprechenden Befehl für die Klasse um, um **data source objects** für die neue *Datenquelle* anzulegen.


## Datenquellenklasse

Jede Datenquellenklasse wird durch einen einzelnen Befehl dargestellt, der auch als *Klassenbefehl* oder *Objektbefehl* bezeichnet wird. Seine Syntax lautet

**dsclasscmd** *objname* ?*dsname*...?
: Das erste Argument des Befehls „class“ ist der Name des zu erstellenden *Datenquellenobjekts*. Der Rahmen liefert stets die Zeichenfolge **%AUTO%**, um anzuzeigen, dass der Befehl „class“ nicht nur das Objekt, sondern auch den Objektnamen generieren muss.

    Darauf folgt eine Reihe von Argumenten, die die Datenquelle identifizieren, für die das neue Objekt bestimmt ist. Dabei handelt es sich um dieselben *dsname*-Argumente, die auch dem grundlegenden Benutzerbefehl **::tie::tie** übergeben werden. Ihre tatsächliche Bedeutung hängt von der *Datenquellenklasse* ab.

    Das Ergebnis des Befehls „class“ muss der vollqualifizierte Name des neuen *Datenquellenobjekts* sein, d. h. der Name des *Objektbefehls*. Die Schnittstelle, der dieser Befehl folgen muss, wird im Abschnitt [API für Datenquellenobjekte] beschrieben.


## API für Datenquellenobjekte

Bitte lesen Sie zunächst den Abschnitt [Datenquellenklasse], um zu erfahren, wie Sie neue *Objektbefehle* erstellen können.

Jeder *Objektbefehl* für ein *Datenquellen*-Objekt muss mindestens die unten aufgeführten Methoden bereitstellen, um eine ordnungsgemäße Zusammenarbeit mit dem „tie“-Rahmen zu gewährleisten. Beachten Sie, dass die Namen der meisten Methoden mit den Unterbefehlen des integrierten Befehls **array** übereinstimmen.

**ds** **destroy**
: Diese Methode wird aufgerufen, wenn das Objekt **ds** gelöscht wird. Es muss nun alle seine internen Ressourcen freigeben, die mit der externen Datenquelle verknüpft sind.

**ds** **names**
: Dieser Befehl muss eine Liste geben, die die Namen aller Schlüssel enthält, die in der *Datenquelle* gefunden wurden, mit der das Objekt kommuniziert. Dies entspricht **array names**.

**ds** **size**
: Dieser Befehl muss eine Ganzzahl geben, die die Anzahl der Schlüssel festlegt, die in der *Datenquelle* gefunden wurden, mit der das Objekt kommuniziert. Dies entspricht **array size**.

**ds** **get**
: Dieser Befehl muss ein Dictionary geben, das die Daten enthält, die in der *Datenquelle* gefunden wurden, mit der das Objekt kommuniziert. Dies entspricht **array get**.

**ds** **set** *dict*
: Dieser Befehl nimmt ein Dictionary entgegen und fügt dessen Inhalt der Datenquelle hinzu, mit der das Objekt kommuniziert. Dies entspricht dem Befehl **array set**.

**ds** **unset** ?*pattern*?
: Dieser Befehl nimmt ein Muster entgegen und entfernt alle Elemente aus der *Datenquelle*, deren Schlüssel diesem Muster entsprechen. Wird kein Muster angegeben, wird standardmäßig „**\***“ verwendet, was zur Entfernung aller Elemente führt. Dies entspricht nahezu dem Befehl „**array unset**“.

**ds** **setv** *index* *value*
: Dieser Befehl muss den *value* in der *Datenquelle*, mit der das Objekt kommuniziert, unter dem Schlüssel *index* speichern.

    Das Ergebnis des Befehls wird ignoriert. Wird ein Fehler ausgelöst, wird dieser als Fehler der Set-Operation angezeigt, die den Methodenaufruf verursacht hat.

**ds** **unsetv** *index*
: Dieser Befehl muss den Wert unter dem Schlüssel *index* aus der *Datenquelle* entfernen, mit der das Objekt kommuniziert.

    Das Ergebnis des Befehls wird ignoriert. Wird ein Fehler ausgelöst, wird dieser als Fehler der Löschoperation angezeigt, die den Methodenaufruf verursacht hat.

**ds** **getv** *index*
: Dieser Befehl muss den Wert für den Schlüssel *index* in der *Datenquelle* zurückgeben, mit der das Objekt kommuniziert.


Und hier finden Sie eine kleine Tabelle, in der die Methoden der *Datenquelle* mit den regulären Tcl-Befehlen für den Zugriff auf ein Array verglichen werden.

```
        Regular Tcl             Data source
        -----------             -----------
        array names a           ds names
        array size  a           ds size
        array get   a           ds get
        array set   a dict      ds set   dict
        array unset a pattern   ds unset ?pattern?
        -----------             -----------
        set a($idx) $val        ds setv   idx val
        unset a($idx)           ds unsetv idx
        $a($idx)                ds getv   idx
        -----------             -----------
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *tie* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge

# Copyright

```
Copyright (c) 2004-2021 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
