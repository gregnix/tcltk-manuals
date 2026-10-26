---
CommandName: zipfs
title: zipfs
ManualSection: n
Version: 1.0
TclPart: Zipfs
TclDescription: zipfs Commands
Links:
 - tclsh(1)
 - file(n)
 - zipfs(3)
 - zlib(n)
Keywords:
 - compress
 - filesystem
 - zip
Copyright:
 - Copyright (c) 2015 Jan Nijtmans <jan.nijtmans@gmail.com>
 - Copyright (c) 2015 Christian Werner <chw@ch-werner.de>
 - Copyright (c) 2015 Sean Woods <yoda@etoyoc.com>
---

# Name

zipfs - ZIP-Archive in Tcl einbinden und damit arbeiten

# Übersicht

::: {.synopsis} :::
[zipfs]{.cmd} [canonical]{.sub} [mountpoint]{.optarg} [filename]{.arg}
[zipfs]{.cmd} [exists]{.sub} [filename]{.arg}
[zipfs]{.cmd} [find]{.sub} [directoryName]{.arg}
[zipfs]{.cmd} [info]{.sub} [filename]{.arg}
[zipfs]{.cmd} [list]{.sub} [(-glob|-regexp)]{.optarg} [pattern]{.optarg}
[zipfs]{.cmd} [lmkimg]{.sub} [outfile]{.arg} [inlist]{.arg} [password]{.optarg} [infile]{.optarg}
[zipfs]{.cmd} [lmkzip]{.sub} [outfile]{.arg} [inlist]{.arg} [password]{.optarg}
[zipfs]{.cmd} [mkimg]{.sub} [outfile]{.arg} [indir]{.arg} [strip]{.optarg} [password]{.optarg} [infile]{.optarg}
[zipfs]{.cmd} [mkkey]{.sub} [password]{.arg}
[zipfs]{.cmd} [mkzip]{.sub} [outfile]{.arg} [indir]{.arg} [strip]{.optarg} [password]{.optarg}
[zipfs]{.cmd} [mount]{.sub} [zipfile]{.optarg} [mountpoint]{.optarg} [password]{.optarg}
[zipfs]{.cmd} [mountdata]{.sub} [data]{.arg} [mountpoint]{.arg}
[zipfs]{.cmd} [root]{.sub}
[zipfs]{.cmd} [unmount]{.sub} [mountpoint]{.arg}
:::

# Beschreibung

Der Befehl **zipfs** ermöglicht Tcl, den Inhalt einer ZIP-Archivdatei als virtuelles Dateisystem einzubinden. Die ZIP-Archiv-Unterstützung von Tcl ist auf grundlegende Funktionen und Optionen beschränkt. Unterstützte Speichermethoden umfassen nur STORE und DEFLATE mit optionaler einfacher Verschlüsselung, ausreichend um eine oberflächliche Einsicht in den Inhalt zu verhindern, aber nicht um den Zugriff selbst durch einen nur mäßig entschlossenen Angreifer zu verhindern. Starke Verschlüsselung, mehrteilige Archive, Plattform-Metadaten, zip64-Formate und andere Kompressionsmethoden wie bzip2 werden nicht unterstützt.

Dateien in eingebundenen Archiven können beschrieben werden, aber neue Dateien oder Verzeichnisse können nicht erstellt werden. Außerdem sind Änderungen an Dateien auf das eingebundene Archiv im Speicher beschränkt und werden nicht auf die Platte geschrieben.

Pfade in eingebundenen Archiven sind auf allen Plattformen groß-/kleinschreibungssensitiv.

[zipfs]{.cmd} [canonical]{.sub} [mountpoint]{.optarg} [filename]{.arg}
: Nimmt den Namen einer Datei, *filename*, und liefert als Ergebnis, wohin sie in einem zipfs-Mountpunkt abgebildet wäre. Wenn angegeben, gibt *mountpoint* an, innerhalb welches Mounts die Abbildung erfolgt; wenn weggelassen, wird die Hauptwurzel des zipfs-Systems verwendet.

[zipfs]{.cmd} [exists]{.sub} [filename]{.arg}
: Gibt 1 zurück, wenn der angegebene Dateiname im eingebundenen zipfs existiert, und 0, wenn nicht.

[zipfs]{.cmd} [find]{.sub} [directoryName]{.arg}
: Gibt die Liste der Pfade unter dem Verzeichnis *directoryName* zurück, das nicht innerhalb eines zipfs-eingebundenen Archivs liegen muss. Die Pfade werden mit *directoryName* vorangestellt. Dieser Befehl wird auch von den Befehlen **zipfs mkzip** und **zipfs mkimg** verwendet.

[zipfs]{.cmd} [info]{.sub} [file]{.arg}
: Gibt Informationen über die angegebene *file* im eingebundenen zipfs zurück. Die Informationen bestehen aus:

    1. dem Namen der ZIP-Archivdatei, die die Datei enthält,

    2. der Größe der Datei nach der Dekompression,

    3. der komprimierten Größe der Datei und

    4. dem Offset der komprimierten Daten in der ZIP-Archivdatei.


    Als Sonderfall liefert eine Abfrage des Mountpunkts den Beginn der ZIP-Daten als Offset in (4), was verwendet werden kann, um die ZIP-Informationen aus einer ausführbaren Datei abzuschneiden. Eine Abfrage eines Vorfahren eines Mountpunkts löst einen Fehler aus.

[zipfs]{.cmd} [list]{.sub} [(-glob|-regexp)]{.optarg} [pattern]{.optarg}
: Wenn *pattern* nicht angegeben ist, gibt der Befehl eine Liste von Dateien über alle zipfs-eingebundenen Archive zurück. Wenn *pattern* angegeben ist, werden nur die Pfade zurückgegeben, die dem Muster entsprechen. Standardmäßig oder mit der Option **-glob** wird das Muster als Glob-Muster behandelt und der Abgleich erfolgt wie für den Befehl [string match][string] beschrieben. Alternativ kann die Option **-regexp** verwendet werden, um den Abgleich von **pattern** als regulären Ausdruck festzulegen. Die Dateinamen werden in beliebiger Reihenfolge zurückgegeben. Beachten Sie, dass Pfadtrennzeichen beim Abgleich als normale Zeichen behandelt werden. Daher sollten Schrägstriche als Pfadtrennzeichen im Muster verwendet werden. Die zurückgegebenen Pfade umfassen nur diejenigen, die tatsächlich im Archiv sind, und nicht Zwischenverzeichnisse in Mount-Pfaden.

[zipfs]{.cmd} [mount]{.sub}
: siehe unten ...

[zipfs]{.cmd} [mount]{.sub} [mountpoint]{.arg}
: siehe unten ...

[zipfs]{.cmd} [mount]{.sub} [zipfile]{.arg} [mountpoint]{.arg} [password]{.optarg}
: Der Befehl **zipfs mount** bindet ZIP-Archive als Tcl-virtuelle Dateisysteme ein und gibt Informationen über aktuelle Mounts zurück.

    Ohne Argumente gibt der Befehl ein Dictionary zurück, das Mountpunkte den Pfaden der zugehörigen ZIP-Archive zuordnet.

    In der Form mit einem Argument gibt der Befehl den Dateipfad des ZIP-Archivs zurück, das am angegebenen Mountpunkt eingebunden ist.

    In der dritten Form bindet der Befehl das ZIP-Archiv *zipfile* als Tcl-virtuelles Dateisystem am *mountpoint* ein. Nach Ausführung dieses Befehls erscheinen die in *zipfile* enthaltenen Dateien für Tcl als reguläre Dateien am Mountpunkt. Wenn *mountpoint* als leerer String angegeben wird, wird standardmäßig **\[zipfs root\]** verwendet. Der Befehl gibt den normalisierten Mountpunkt-Pfad zurück.

    Wenn *mountpoint* nicht unter der zipfs-Dateisystemwurzel liegt, wird er relativ dazu normalisiert. Beispielsweise würde ein Mountpunkt, der als **mt** oder **/mt** übergeben wird, zu **//zipfs:/mt** normalisiert (wenn **zipfs root** "//zipfs:/" zurückgibt). Es wird ein Fehler ausgelöst, wenn der Mountpunkt ein Laufwerk oder ein UNC-Volume enthält.

    **Hinweis:** Da das aktuelle Arbeitsverzeichnis ein vom Betriebssystem verwaltetes Konzept ist, funktioniert [cd] in ein eingebundenes Archiv nur im aktuellen Prozess und dann nicht vollständig konsistent (z. B. wenn eine Shared Library direkten Zugriff auf das Betriebssystem statt über Tcls Dateisystem-API verwendet, sieht sie das aktuelle Verzeichnis nicht innerhalb des Mounts und kann nicht auf die Dateien im Mount zugreifen).

[zipfs]{.cmd} [mountdata]{.sub} [data]{.arg} [mountpoint]{.arg}
: Bindet den ZIP-Archivinhalt *data* als Tcl-virtuelles Dateisystem am *mountpoint* ein.

[zipfs]{.cmd} [root]{.sub}
: Gibt einen konstanten String zurück, der den Mountpunkt für zipfs-Volumes auf der aktuellen Plattform angibt. Der Benutzer sollte sich nicht darauf verlassen, dass der Mountpunkt auf allen Plattformen derselbe konstante String ist.

[zipfs]{.cmd} [unmount]{.sub} [mountpoint]{.arg}
: Hängt ein zuvor am *mountpoint* eingebundenes ZIP-Archiv ab. Der Befehl schlägt mit einer Fehlerausnahme fehl, wenn noch Dateien innerhalb des eingebundenen Archivs geöffnet sind.


## Befehle zur ZIP-Erstellung

Dieses Paket stellt außerdem mehrere Befehle bereit, die bei der Erstellung von ZIP-Archiven als Tcl-Anwendungen helfen.

[zipfs]{.cmd} [mkzip]{.sub} [outfile]{.arg} [indir]{.arg} [strip]{.optarg} [password]{.optarg}
: Erstellt eine ZIP-Archivdatei namens *outfile* aus dem Inhalt des Eingabeverzeichnisses *indir* (nur reguläre Dateien) mit optionalem ZIP-Passwort *password*. Beim Verarbeiten der Dateien unter *indir* wird das optionale Dateinamenpräfix in *strip* vom Anfang des jeweiligen Dateinamens entfernt, falls es nicht leer ist. Beim Strippen ist es üblich, entweder den gesamten Quellverzeichnisnamen oder den Namen des übergeordneten Verzeichnisses zu entfernen.

    **Vorsicht:** Die Wahl des Parameters *indir* (abzüglich des optional gestrippten Präfixes) bestimmt den späteren Wurzelnamen des Archivinhalts.

[zipfs]{.cmd} [mkimg]{.sub} [outfile]{.arg} [indir]{.arg} [strip]{.optarg} [password]{.optarg} [infile]{.optarg}
: Erstellt ein Image (potenziell eine neue ausführbare Datei) ähnlich wie **zipfs mkzip**; siehe diesen Befehl für eine Beschreibung der meisten Parameter dieses Befehls, da sie sich hier identisch verhalten. Wenn *outfile* existiert, wird es stillschweigend überschrieben.

    Wenn der Parameter *infile* angegeben ist, wird diese Datei vor das ZIP-Archiv gesetzt, andernfalls wird die von [info nameofexecutable][info] zurückgegebene Datei verwendet (d. h. die ausführbare Datei des laufenden Prozesses, typischerweise [wish] oder [tclsh]). Wenn der Parameter *password* nicht der leere String ist, wird eine verschleierte Version dieses Passworts (siehe **zipfs mkkey**) zwischen Image- und ZIP-Teil der Ausgabedatei platziert und der Inhalt des ZIP-Teils mit diesem Passwort geschützt. Wenn das Ausgangs-Image bereits ein ZIP-Archiv angehängt hat, wird es aus der Kopie in *outfile* entfernt, bevor das neue ZIP-Archiv hinzugefügt wird.

    Wenn es eine Datei **main.tcl** im Wurzelverzeichnis des resultierenden Archivs gibt und die Image-Datei, an die das Archiv angehängt ist, eine [tclsh]- (oder [wish]-)Instanz ist (standardmäßig wahr, hängt aber von der Konfiguration ab), dann ist das resultierende Image eine ausführbare Datei, die nach dem Einbinden des ZIP-Archivs das Skript in **main.tcl** per [source] ausführt und nach Ausführung dieses Skripts per [exit] beendet.

    **Hinweis:** [tclsh] und [wish] können mit dynamischer oder statischer Bindung der Kernimplementierungsbibliotheken gebaut werden. Bei dynamischer Bindung sind die Tcl\_Library-Inhalte der Basisanwendung an die Shared Libraries **libtcl** bzw. **libtk** angehängt. Bei statischer Bindung sind die Tcl\_Library-Inhalte usw. an die Anwendung [tclsh] oder [wish] angehängt. Bei Verwendung von **mkimg** mit einem statisch gebauten tclsh liegt es in der Verantwortung des Benutzers, das angehängte Archiv zu erhalten, indem er es zuerst an einen temporären Ort extrahiert und dann die gewünschten zusätzlichen Dateien hinzufügt, bevor das neue Archiv erstellt und an die neue Anwendung angehängt wird.

[zipfs]{.cmd} [mkkey]{.sub} [password]{.arg}
: Gibt bei dem Klartext-Argument *password* eine verschleierte Stringversion im gleichen Format zurück, das im Befehl **zipfs mkimg** verwendet wird.

[zipfs]{.cmd} [lmkimg]{.sub} [outfile]{.arg} [inlist]{.arg} [password]{.optarg} [infile]{.optarg}
: Dieser Befehl entspricht **zipfs mkimg**, aber anstelle eines Eingabeverzeichnisses muss *inlist* eine Tcl-Liste sein, deren ungerade Elemente die Namen der in das Archiv im Image zu kopierenden Dateien sind und deren gerade Elemente ihre jeweiligen Namen innerhalb dieses Archivs.

[zipfs]{.cmd} [lmkzip]{.sub} [outfile]{.arg} [inlist]{.arg} [password]{.optarg}
: Dieser Befehl entspricht **zipfs mkzip**, aber anstelle eines Eingabeverzeichnisses muss *inlist* eine Tcl-Liste sein, deren ungerade Elemente die Namen der in das Archiv zu kopierenden Dateien sind und deren gerade Elemente ihre jeweiligen Namen innerhalb dieses Archivs.


# Hinweis

Die aktuelle Syntax bestimmter Unterbefehle mit mehreren optionalen Parametern könnte sich in Zukunft ändern, um stattdessen ein Muster *?-option value?* zu unterstützen. Daher sollte die aktuelle Syntax nicht als stabil betrachtet werden.

# Beispiele

Einbinden eines ZIP-Archivs als Anwendungsverzeichnis, Ausführen von Code daraus und anschließendes Abhängen:

```
set zip myApp.zip
set base [file join [zipfs root] myApp]

zipfs mount $zip $base
# $base enthält jetzt den Inhalt von myApp.zip

source [file join $base app.tcl]
# Inhalt nutzen, Bibliotheken daraus laden, usw.

zipfs unmount $base
```

Erstellen eines ZIP-Archivs, wenn ein Verzeichnis mit dem einzupackenden Inhalt existiert. Beachten Sie, dass das Quellverzeichnis zweimal angegeben wird, um den äußeren Verzeichnisnamen von jedem Dateinamen im Archiv zu entfernen.

```
set sourceDirectory [file normalize myApp]
set targetZip myApp.zip

zipfs mkzip $targetZip $sourceDirectory $sourceDirectory
```

Verschlüsselung kann auf ZIP-Archive angewendet werden, indem beim Erstellen und beim Einbinden ein Passwort angegeben wird.

```
set zip myApp.zip
set sourceDir [file normalize myApp]
set password "hunter2"
set base [file join [zipfs root] myApp]

# Mit Passwort erstellen
zipfs mkzip $targetZip $sourceDir $sourceDir $password

# Mit Passwort einbinden
zipfs mount $zip $base $password
```

Das folgende Beispiel erstellt eine ausführbare Anwendung, indem ein ZIP-Archiv an die tclsh-Datei angehängt wird, von der es aufgerufen wurde, und die resultierende ausführbare Datei in der Datei "myApp.bin" gespeichert wird. Beim Erstellen eines ausführbaren Images mit Passwort wird das Passwort in verschleierter Form in die ausführbare Datei eingebettet, sodass die Anwendung Dateien im eingebetteten ZIP-Archiv lesen kann, eine oberflächliche Einsicht es jedoch nicht lesen kann.

```
set appDir [file normalize myApp]
set img "myApp.bin"
set password "hunter2"

# Einfachen Inhalt für eine Basisanwendung anlegen
file mkdir $appDir
set f [open $appDir/main.tcl w]
puts $f {
    puts "Hi. This is [info script]"
}
close $f

# Ausführbare Anwendung erstellen
zipfs mkimg $img $appDir $appDir $password

# jetzt überflüssigen temporären appDir-Ordner entfernen
file delete -force $appDir

# Ausführbare Datei starten, Ausgabe nach stdout
exec $img >@stdout
# gibt folgende Zeile aus, wenn [zipfs root] "//zipfs:/" zurückgibt:
# Hi. This is //zipfs:/app/main.tcl
```


[cd]: cd.md
[exit]: exit.md
[info]: info.md
[source]: source.md
[string]: string.md
[tclsh]: tclsh.md
[wish]: ../tk/wish.md
