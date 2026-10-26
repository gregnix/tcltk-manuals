---
CommandName: fileutil_traverse
title: fileutil_traverse
ManualSection: n
Version: 0.7
TclPart: tcllib
TclDescription: file utilities
Keywords:
 - directory traversal
 - traversal
Copyright:
---

# Name

fileutil\_traverse – Iteratives Durchlaufen von Verzeichnissen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [fileutil::traverse]{.lit} [0.7]{.optlit}
[package]{.cmd} [require]{.sub} [fileutil]{.lit}
[package]{.cmd} [require]{.sub} [control]{.lit}
[::fileutil::traverse]{.cmd} [objectName]{.optarg} [path]{.arg} [option value...]{.optarg}
[$traverser]{.cmd} [command]{.lit} [arg arg]{.optdot}
[$traverser]{.cmd} [files]{.lit}
[$traverser]{.cmd} [foreach]{.lit} [filevar]{.arg} [script]{.arg}
[$traverser]{.cmd} [next]{.lit} [filevar]{.arg}
:::

# Beschreibung

Dieses Paket stellt Objekte für die programmgesteuerte Durchquerung von Verzeichnishierarchien bereit. Der wichtigste vom Paket exportierte Befehl lautet:

**::fileutil::traverse** ?*objectName*? *path* ?*option* *value*...?
: Der Befehl erstellt ein neues Traversal-Objekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *objectName* lautet. Dieser Befehl kann verwendet werden, um verschiedene Operationen auf dem Traverser auszuführen. Wenn die Zeichenkette **%AUTO%** als *objectName* verwendet wird, wird vom Paket selbst ein eindeutiger Name generiert.

    Informationen zu den unterstützten Optionen finden Sie im Abschnitt [Optionen]. Beachten Sie, dass alle diese Optionen nur bei der Erstellung des Traversal-Objekts festgelegt werden können. Eine spätere Änderung ist nicht möglich und führt bei einem entsprechenden Versuch zu Fehlern.

    Der Objektbefehl hat die folgende allgemeine Form:

    **$traverser** **command** ?*arg arg ...*?
    : Der *Befehl* und seine *Argumente* bestimmen das genaue Verhalten des Objekts.



Für Traversierungsobjekte sind folgende Befehle möglich:

**$traverser** **files**
: Diese Methode ist die oberste Ebene, die von Durchlaufobjekten bereitgestellt wird. Bei ihrer Ausführung gibt sie eine Liste zurück, die die Namen aller Dateien und Verzeichnisse enthält, die der aktuellen Konfiguration des Durchlaufobjekts entsprechen.

**$traverser** **foreach** *filevar* *script*
: Die übergeordnete Methode [files][multiop] (siehe oben) basiert auf dieser Methode der mittleren Ebene. Bei ihrer Aufrufung ermittelt sie alle Dateien und Verzeichnisse, die der aktuellen Konfiguration entsprechen, und führt für jeden Pfad das *Skript* aus. Der aktuell betrachtete Pfad wird in der Variable gespeichert, die mit *filevar* benannt ist. Sowohl die Variable als auch das Skript befinden sich im Kontext des Aufrufers der Methode und werden dort ausgeführt. In der Methode [files][multiop] speichert das Skript die gefundenen Pfade lediglich in der Liste, die zurückgegeben wird.

**$traverser** **next** *filevar*
: Dies ist die unterste Schnittstelle zum Traverser, auf der alle übergeordneten Methoden aufbauen. Bei Aufruf gibt sie einen booleschen Wert zurück, der angibt, ob ein Pfad gefunden wurde, der der aktuellen Konfiguration entspricht (**True**), oder nicht (**False**). Wurde ein Pfad gefunden, wird dieser im Kontext des Aufrufers in der durch *filevar* benannten Variablen gespeichert.

    Die **foreach**-Methode ruft diese Methode einfach in einer Schleife auf, bis sie **False** gibt. Diese Methode wird bereitgestellt, damit wir eine Verzeichnishierarchie auch schrittweise und ereignisgesteuert durchlaufen können.

    Beachten Sie, dass der Durchlaufer symbolische Links verfolgt, es sei denn, dies würde dazu führen, dass er in einen Link-Zyklus gerät. Mit anderen Worten: Der Befehl sorgt dafür, dass er sich beim Auftreffen auf zirkuläre Link-Strukturen *nicht* in Endlosschleifen verliert. Beachten Sie, dass auch Links, denen nicht gefolgt wird, dennoch im Ergebnis erscheinen.


# Optionen

**-prefilter** command\_prefix
: Diese Rückruffunktion wird für Verzeichnisse ausgeführt. Ihr Ergebnis bestimmt, ob der Traverser das Verzeichnis rekursiv durchläuft oder nicht. Standardmäßig werden alle Verzeichnisse rekursiv durchsucht. Die Rückruffunktion wird mit einem einzigen Argument aufgerufen, dem *absoluten* Pfad des Verzeichnisses, und muss einen booleschen Wert zurückgeben: **True**, wenn das Verzeichnis den Filter passiert, und **False**, wenn nicht.

**-filter** command\_prefix
: Diese Rückruffunktion wird für alle Pfade ausgeführt. Ihr Ergebnis bestimmt, ob der aktuelle Pfad ein gültiges Ergebnis ist, und wird von **next** zurückgegeben. Standardmäßig werden alle Pfade als gültig akzeptiert. Die Rückruffunktion wird mit einem einzigen Argument aufgerufen, dem zu prüfenden *absoluten* Pfad, und muss einen booleschen Wert zurückgeben: **True**, wenn der Pfad den Filter passiert, und **False**, wenn nicht.

**-errorcmd** command\_prefix
: Diese Rückruffunktion wird für alle Pfade ausgeführt, bei denen der Traverser Probleme hat. Dazu gehören beispielsweise Fälle, in denen er nicht in diese Pfade wechseln oder deren Status abrufen kann usw. Standardmäßig werden solche Probleme ignoriert. Die Rückruffunktion wird mit zwei Argumenten aufgerufen: dem *absoluten* Pfad, bei dem der Fehler aufgetreten ist, und der Fehlermeldung. Auch Fehler, die von den Filter-Callbacks ausgelöst werden, werden über diese Rückruffunktion behandelt. Fehler, die vom Fehler-Callback selbst ausgelöst werden, werden nicht abgefangen und ignoriert, sondern an den Aufrufer weitergeleitet, also an den, der **next** aufgerufen hat. Alle anderen Ergebnisse der Rückruffunktion werden ignoriert.


# Fehler und Inkompatibilitäten

**0.4.4**
: In dieser Version wurde das fehlerhafte System des Traversers zur Verarbeitung von Symlinks durch ein korrekt funktionierendes ersetzt, das alle zulässigen, nicht zyklischen Pfade unter einem Basis-Verzeichnis ordnungsgemäß auflistet.

    Das ist zwar korrekt, bedeutet aber, dass die Aufzählung bestimmter pathologischer Verzeichnishierarchien mit sich gegenseitig verweisenden Symlinks nun etwa O(n\*\*2) Zeit in Anspruch nimmt, während der ursprüngliche fehlerhafte Code aufgrund seiner Fehlerhaftigkeit O(n) schaffte.

    Ein konkretes Beispiel und Extremfall ist die „*/sys*“-Hierarchie unter Linux, wo einige hundert Geräte sowohl unter „*/sys/devices*“ als auch unter „*/sys/class*“ existieren, wobei die beiden Unterhierarchien miteinander verknüpft sind, was Millionen zulässiger Pfade zur Aufzählung erzeugt. Die auf drei Geräte reduzierte Struktur sieht in etwa so aus:

    ```
    	/sys/class/tty/tty0 --> ../../dev/tty0
    	/sys/class/tty/tty1 --> ../../dev/tty1
    	/sys/class/tty/tty2 --> ../../dev/tty1

    	/sys/dev/tty0/bus
    	/sys/dev/tty0/subsystem --> ../../class/tty
    	/sys/dev/tty1/bus
    	/sys/dev/tty1/subsystem --> ../../class/tty
    	/sys/dev/tty2/bus
    	/sys/dev/tty2/subsystem --> ../../class/tty
    ```

    Wenn Sie es mit einer solchen pathologischen Hierarchie zu tun hat, empfiehlt es sich, die Option **-prefilter** zu verwenden, um zu verhindern, dass der Traverser symbolische Links verfolgt, und zwar wie folgt:

    ```
        package require fileutil::traverse

        proc NoLinks {fileName} {
            if {[string equal [file type $fileName] link]} {
                return 0
            }
            return 1
        }

        fileutil::traverse T /sys/devices -prefilter NoLinks
        T foreach p {
            puts $p
        }
        T destroy
    ```


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *fileutil* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Programmierwerkzeuge


[multiop]: multiop.md
