---
CommandName: hook
title: hook
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: Hooks
Links:
 - uevent(n)
Keywords:
 - callback
 - event
 - hook
 - observer
 - producer
 - publisher
 - subject
 - subscriber
 - uevent
Copyright:
 - Copyright (c) 2010, by William H. Duquette
---

# Name

hook – Hooks

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [hook]{.lit} [0.3]{.optlit}
[hook]{.cmd} [bind]{.lit} [subject]{.optarg} [hook]{.optarg} [observer]{.optarg} [cmdPrefix]{.optarg}
[hook]{.cmd} [call]{.lit} [subject]{.arg} [hook]{.arg} [args...]{.optarg}
[hook]{.cmd} [forget]{.lit} [object]{.arg}
[hook]{.cmd} [cget]{.lit} [option]{.arg}
[hook]{.cmd} [configure]{.lit} [option]{.lit} [value]{.arg} ...
:::

# Beschreibung

Dieses Paket stellt den Ensemble-Befehl **hook** bereit, der das Subject-Observer-Muster implementiert. Es ermöglicht *Subjekten* – bei denen es sich um *Module*, *Objekte*, *Widgets* usw. handeln kann –, *Hooks* synchron aufzurufen, die an eine beliebige Anzahl von Abonnenten, sogenannte *Beobachter*, gebunden sein können. Ein Subject kann eine beliebige Anzahl unterschiedlicher Hooks aufrufen, und eine beliebige Anzahl von Observern kann Rückruffunktionen an einen bestimmten Hook binden, der von einem bestimmten Subject aufgerufen wird. Hook-Bindungen können abgefragt und gelöscht werden.

Diese Man-Seite dient ausschließlich als Nachschlagewerk.

# Begriffe

## Einleitung

Tcl-Module senden Benachrichtigungen an andere Module in der Regel auf zwei Arten: über Tk-Ereignisse und über Callback-Optionen wie die Option **-yscrollcommand** des Text-Widgets. Tk-Ereignisse stehen nur in Tk zur Verfügung, und Callback-Optionen erfordern eine enge Kopplung zwischen den Modulen, die die Benachrichtigung senden und empfangen.

Eine lose Kopplung zwischen Sender und Empfänger ist jedoch häufig wünschenswert. Im Sinne des Model-View-Controller-Musters kann eine Ansicht einen Befehl (der auf einer Benutzereingabe beruht) an den Controller senden, der daraufhin das Modell aktualisiert. Das Modell kann dann einen Hook aufrufen, *den alle relevanten Ansichten abonnieren.* Das Model ist von den Views entkoppelt und muss tatsächlich nicht wissen, ob überhaupt Views existieren. Derzeit verfügt Tcl/Tk über keinen Standardmechanismus zur Implementierung einer derartigen losen Kopplung. Dieses Paket definiert einen neuen Befehl, **hook**, der genau einen solchen Mechanismus implementiert.

## Bindings

Der Befehl **hook** verwaltet eine Sammlung von Hook-Bindings. Ein Hook-Binding besteht aus vier Elementen:

1. Ein *subject*: Der Name der Entität, die den Hook aufrufen wird.

2. Der *hook* selbst. Ein Hook spiegelt in der Regel ein Ereignis im Leben des *subject* wider, das für andere Entitäten von Interesse sein könnte. Ein *hook* hat einen Namen und kann zudem Argumente haben. Hook-Namen sind beliebige Zeichenfolgen. Jedes *subject* muss die Namen und Argumente der Hooks dokumentieren, die es aufrufen kann.

3. Der Name des *observer*, der den *hook* vom *subject* empfangen möchte.

4. Ein Befehlspräfix, an das die *hook*-Argumente angehängt werden, wenn die Bindung ausgeführt wird.


## Subjekte und Beobachter

Der Einfachheit halber werden in diesem Dokument Subjekte und Beobachter gemeinsam als *Objekte* bezeichnet, wobei keine Anforderungen hinsichtlich der tatsächlichen Implementierung dieser *Objekte* gestellt werden. Ein Objekt kann ein **TclOO**-, **Snit**- oder **XOTcl**-Objekt, ein Tcl-Befehl, ein Namespace, ein Modul, ein von einem anderen Objekt verwaltetes Pseudo-Objekt (so wie Tags vom Tk-Text-Widget verwaltet werden) oder einfach ein bekannter Name.

Die Namen von Subjekten und Beobachtern sind beliebige Zeichenfolgen; da „**hook**“ jedoch möglicherweise auf Paketebene verwendet wird, sind Konventionen erforderlich, um Namenskonflikte zwischen Paketen zu vermeiden, die von verschiedenen Personen erstellt wurden.

Daher sollte jeder im Code auf Kern- oder Paketebene verwendete Subjekt- oder Beobachtername wie ein Tcl-Befehlsname aussehen und in einem Namespace definiert sein, der zu dem jeweiligen Paket gehört. Betrachten Sie beispielsweise einen Ensemble-Befehl **::foo**, der eine Reihe von Pseudo-Objekten erstellt und **hook** zum Versenden von Benachrichtigungen verwendet. Die Pseudo-Objekte tragen Namen, die keine Befehle sind, und existieren in einem eigenen Namespace, ähnlich wie Dateihandles. Um Namenskonflikte mit Subjekten zu vermeiden, die von anderen Paketen definiert wurden, sollten Benutzer von **hook** diese **::foo**-Handles Namen wie **::foo::1**, **::foo::2** und so weiter.

Da Objektnamen beliebige Zeichenfolgen sind, kann der Anwendungscode beliebige zusätzliche Konventionen verwenden, die sich aus den Anforderungen der Anwendung ergeben.

# Literatur

Hook stellt die folgenden Befehle zur Verfügung:

**hook** **bind** ?*subject*? ?*hook*? ?*observer*? ?*cmdPrefix*?
: Dieser Unterbefehl dient zum Erstellen, Aktualisieren, Löschen und Abfragen von Hook-Bindungen.

    Wird er ohne Argumente aufgerufen, gibt er eine Liste der Subjekte mit Hooks zurück, an die derzeit Beobachter gebunden sind.

    Wird er mit einem Argument – einem *subject* – aufgerufen, gibt er eine Liste der Hooks dieses Subjekts zurück, an die derzeit Beobachter gebunden sind.

    Wird er mit zwei Argumenten – einem *subject* und einem *hook* – aufgerufen, gibt er eine Liste der Beobachter zurück, die derzeit an dieses *subject* und diesen *hook* gebunden sind.

    Wird er mit drei Argumenten – einem *subject*, einem *hook* und einem *observer* – aufgerufen, gibt er die eigentliche Bindung, das Befehlspräfix, das wenn der Hook aufgerufen wird, ausgeführt werden soll, oder die leere Zeichenkette zurück, falls keine solche Bindung vorhanden ist.

    Wird er mit vier Argumenten aufgerufen, erstellt, aktualisiert oder löscht er eine Bindung. Ist *cmdPrefix* die leere Zeichenkette, werden alle bestehenden Bindungen für das *subject*, den *hook* und den *observer* gelöscht; nichts wird zurückgegeben. Andernfalls muss *cmdPrefix* ein Befehlspräfix sein, das so viele zusätzliche Argumente entgegennimmt, wie für *subject* und *hook* dokumentiert sind. Die Bindung wird hinzugefügt oder aktualisiert, und der Beobachter wird zurückgegeben.

    Wenn der *observer* die leere Zeichenkette „“, ist, wird ein neues Binding unter Verwendung eines automatisch generierten Beobachternamens der Form **::hook::ob**<**number**> erstellt. Der automatisch generierte Name wird zurückgegeben und kann wie gewohnt zum Abfragen, Aktualisieren und Löschen der Bindung verwendet werden. Werden stets automatische Beobachternamen verwendet, wird der Beobachtername faktisch zu einer eindeutigen Bindungs-ID.

    Es ist möglich, **hook bind** aufzurufen, um eine Bindung an ein *Subjekt* und einen *hook* zu erstellen oder zu löschen, während man sich in einer Beobachterbindung für dasselbe *Subjekt* und denselben *hook* befindet. Die folgenden Regeln legen fest, was geschieht, wenn

    ```
        hook bind $s $h $o $binding
    ```

    wird während der Ausführung von

    ```
        hook call $s $h
    ```

    1. Eine Bindung wird nach ihrer Löschung niemals mehr aufgerufen.

    2. Wenn eine Bindung aufgerufen wird, wird stets das zuletzt angegebene Befehlspräfix verwendet.

    3. Die Menge der Beobachter, deren Bindings aufgerufen werden sollen, wird zu Beginn der Ausführung dieser Methode festgelegt und ändert sich danach nicht mehr, mit der Ausnahme, dass gelöschte Bindings nicht aufgerufen werden.


    Insbesondere:

    1. Wenn die Bindung von **$o** mit **$s** und **$h** gelöscht wird und die Bindung von **$o** während dieser Ausführung von

        ```
            hook call $s $h
        ```

    2. Es wird nicht aufgerufen. (Hinweis: Sie ist möglicherweise bereits aufgerufen worden; und aller Wahrscheinlichkeit nach löscht sie sich gerade selbst.)

    3. Wenn **$o** das Befehlspräfix ändert, das an **$s** und **$h** gebunden ist, und wenn die Bindung von **$o** während dieser Ausführung von

        ```
            hook call $s $h
        ```

    4. Die neue Bindung wird wenn der Zeitpunkt gekommen ist aufgerufen. (Allerdings ist es wahrscheinlich wieder die Bindung „**$o**“, die die Änderung vornimmt.)

    5. Wenn ein neuer Beobachter an **$s** und **$h** gebunden wird, wird seine Bindung erst beim nächsten Aufruf von

        ```
            hook call $s $h
        ```


**hook** **call** *subject* *hook* ?*args*...?
: Dieser Befehl wird aufgerufen, wenn das benannte *subject* den benannten *hook* aufrufen möchte. Alle relevanten Bindungen werden mit den angegebenen Argumenten im globalen Namespace aufgerufen. Hinweis: Die Bindungen werden synchron aufgerufen, bevor der Befehl zurückgibt; dadurch können die *args* Verweise auf Entitäten enthalten, die sofort nach dem Aufruf des Hooks bereinigt werden.

    Die Reihenfolge, in der die Bindungen aufgerufen werden, ist nicht garantiert. Wenn die Reihenfolge unter den Beobachtern gewahrt bleiben soll, definieren Sie einen Beobachter und lassen Sie dessen Bindings die anderen Rückruffunktionen direkt in der richtigen Reihenfolge aufrufen.

    Da der Mechanismus **hook** darauf ausgelegt ist, eine lose Kopplung zu unterstützen, wird davon ausgegangen, dass das *Subjekt* weder Kenntnis von den Beobachtern hat noch Erwartungen hinsichtlich der Rückgabewerte hegt. Dies hat eine Reihe von Konsequenzen:

    1. **hook call** gibt die leere Zeichenkette zurück.

    2. Normale Werte, die von Beobachter-Bindungen gegeben werden, werden ignoriert.

    3. Fehler und andere Ausnahmewerte werden standardmäßig normal weitergegeben. Dies entspricht jedoch selten den Erwartungen, da die Subjekte in der Regel keine Kenntnis von den Beobachtern haben und daher nicht über die erforderlichen Kompetenzen verfügen, um mit deren Fehlern umzugehen. Da es sich hierbei um ein anwendungsspezifisches Problem handelt, werden Anwendungen in der Regel ein **-errorcommand** definieren wollen.


    Wenn die Konfigurationsoption **-errorcommand** einen nicht leeren Wert aufweist, wird dieser Wert bei allen Fehlern und anderen Ausnahmerückgaben in Observer-Bindungen aufgerufen. Weitere Informationen zu Konfigurationsoptionen finden Sie unter **hook configure** weiter unten.

**hook** **forget** *object*
: Dieser Befehl löscht alle vorhandenen Bindungen, in denen das genannte *object* entweder als *subject* oder als *observer* auftritt. Durch diese Methode gelöschte Bindungen werden nie wieder aufgerufen. Insbesondere gilt:

    1. Wenn bei einem Aufruf von **hook call** ein Beobachter übersehen wird, werden etwaige noch nicht aufgerufene Bindungen, die dieser möglicherweise zum betreffenden Subjekt und Hook hatte, anschließend *nicht* aufgerufen.

    2. Wenn ein Subjekt **$s** während eines Aufrufs von

        ```
        hook call $s $h
        ```

    3. vergessen wird, gibt **hook call** zurück, sobald die aktuelle Bindung zurückkehrt. Es werden keine weiteren Bindungen aufgerufen.


**hook** **cget** *option*
: Dieser Befehl gibt den Wert einer der Konfigurationsoptionen des Befehls „**hook**“ zurück.

**hook** **configure** **option** *value* ...
: Dieser Befehl legt den Wert einer oder mehrerer Konfigurationsoptionen des Befehls „**hook**“ fest:

    **-errorcommand** *cmdPrefix*
    : Wenn der Wert dieser Option die leere Zeichenkette „“, gibt, werden Fehler und andere Ausnahmen, die in Bindungsskripten auftreten, wie gewohnt weitergegeben. Andernfalls muss es sich um ein Befehlspräfix handeln, das drei zusätzliche Argumente entgegennimmt:

        1. eine Liste mit vier Elementen {Thema, Aufhänger, Argumentliste, Beobachter},

        2. die Ergebniszeichenfolge und

        3. das Dictionary der Rückgabemöglichkeiten.


        Anhand dieser Informationen kann **-errorcommand** entscheiden, ob der Fehler protokolliert, **interp bgerror** aufgerufen, die fehlerhafte Bindung gelöscht (wodurch verhindert wird, dass der Fehler ein zweites Mal auftritt) oder Ähnliches erfolgen soll.

    **-tracecommand** *cmdPrefix*
    : Der Wert der Option sollte ein Befehlspräfix sein, das vier Argumente entgegennimmt:

        1. a *subject*,

        2. a *hook*,

        3. eine Liste der Werte der Argumente des Hooks sowie

        4. eine Liste der *Objekte*, für die der Hook aufgerufen wurde.


        Der Befehl wird für jeden aufgerufenen Hook ausgeführt. Auf diese Weise kann die Anwendung die Ausführung der Hooks zu Debugging-Zwecken nachverfolgen.



# Beispiel

Das Modul **::model** ruft den Hook <Update> als Reaktion auf Befehle auf, die die Daten des Modells ändern:

```
     hook call ::model <Update>
```

Das Megawidget „**.view**“ zeigt den Modellstatus an und muss über Modellaktualisierungen informiert werden. Daher abonniert es den Hook „<Update>“ des Modells „::model“.

```
     hook bind ::model <Update> .view [list .view ModelUpdate]
```

Wenn **::model** den Hook aufruft, wird der Unterbefehl „ModelUpdate“ von **.view** aufgerufen.

Später wird das Megawidget „**.view**“ zerstört. In seinem Destruktor teilt es dem *hook* mit, dass es nicht mehr existiert:

```
     hook forget .view
```

Alle Bindings, die **.view** betreffen, werden gelöscht.

# Danksagungen

Hook wurde von William H. Duquette entwickelt und umgesetzt.

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *hook* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge

# Copyright

```
Copyright (c) 2010, by William H. Duquette
```
