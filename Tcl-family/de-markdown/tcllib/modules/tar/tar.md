---
CommandName: tar
ManualSection: n
Version: 0.15
TclPart: tcllib
TclDescription: Tar file handling
Keywords:
 - archive
 - tape archive
 - tar
Copyright:
---

# NAME

tar – Erstellen, Entpacken und Bearbeiten von Tar-Dateien

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [tar]{.lit} [0.15]{.optlit} 
[::tar::contents]{.cmd} [tarball]{.arg} [-chan]{.optlit} [-gzip]{.optlit} 
[::tar::stat]{.cmd} [tarball]{.arg} [file]{.optarg} [-chan]{.optlit} [-gzip]{.optlit} 
[::tar::untar]{.cmd} [tarball]{.arg} [args]{.arg} 
[::tar::get]{.cmd} [tarball]{.arg} [fileName]{.arg} [-chan]{.optlit} [-gzip]{.optlit} 
[::tar::create]{.cmd} [tarball]{.arg} [files]{.arg} [args]{.arg} 
[::tar::add]{.cmd} [tarball]{.arg} [files]{.arg} [args]{.arg} 
[::tar::remove]{.cmd} [tarball]{.arg} [files]{.arg} 
:::

# BESCHREIBUNG

*Hinweis*: Ab Version 0.8 unterstützen die Befehle des tar-Readers (contents, stats, get, untar) die GNU-LongName-Erweiterung (Header-Typ \\'L') für lange Pfade.

# VORSICHT!

Bei allen Befehlen gilt bei Verwendung von **-chan** ...

**\[1\]**
: Es wird davon ausgegangen, dass der Kanal zum Lesen geöffnet und für binäre Eingaben konfiguriert wurde.

**\[2\]**
: Es wird davon ausgegangen, dass sich die Kanalposition am Anfang einer gültigen TAR-Datei befindet.

**\[3\]**
: Die Befehle *ändern* die Kanalposition, während sie ihre Aufgabe ausführen.

**\[4\]**
: Die Befehle schließen den Kanal *nicht*.

**\[5\]**
: Mit anderen Worten: Die Befehle hinterlassen den Kanal in einem Zustand, der höchstwahrscheinlich für die Verwendung durch weitere **tar**-Befehle ungeeignet ist. Wenn Sie dies dennoch tut, führt dies höchstwahrscheinlich zu Fehlern, fehlerhaften Daten usw. usw.

**\[6\]**
: Es liegt in der Verantwortung des Nutzers, den Kanal wieder auf eine geeignete Position einzustellen.

**\[7\]**
: Wenn eine Kanal-Transformation verwendet wird, die grundsätzlich nicht durchsuchbar ist, beispielsweise **gunzip**, obliegt es dem Benutzer, (a) die Transformation aufzuheben, bevor er den Kanal an eine geeignete Position zurückspringt, und (b) sie anschließend wieder anzuwenden. Zur Unterstützung der gzip-Komprimierung:

**\[1\]**
: Es werden Fehler ausgegeben, wenn versucht wird, aus komprimierten tar-Archiven zu lesen, während keine Komprimierungsunterstützung (d. h. **::zlib**) verfügbar ist.

**\[2\]**
: Beim Versuch, ein unkomprimiertes tar-Archiv zu lesen, werden Fehler ausgegeben, wenn der Benutzer eine Komprimierung angefordert hat (**-gzip**). Beim Versuch, ein komprimiertes tar-Archiv zu lesen, werden keine Fehler ausgegeben, wenn keine Komprimierung angefordert wurde und diese unterstützt wird. In diesem Fall aktivieren die Befehle automatisch den Code, der die Komprimierung verarbeitet.

**\[3\]**
: Beim Versuch, komprimierte TAR-Archive zu bearbeiten, werden Fehler ausgegeben. Siehe die Befehle **tar::add** und **tar::remove**. Dies wird nicht unterstützt.

**\[4\]**
: Die Erstellung komprimierter TAR-Archive wird jedoch unterstützt, da das Archiv dabei sequenziell geschrieben wird, was eine Streaming-Komprimierung ermöglicht.


# BEFEHLE

**::tar::contents** *tarball* ?**-chan**? ?**-gzip**?
: Gibt eine Liste der in *tarball* enthaltenen Dateien zurück. Die Reihenfolge ist nicht sortiert und hängt davon ab, in welcher Reihenfolge die Dateien im Archiv gespeichert wurden. Wenn die Option **-chan** vorhanden ist, wird *tarball* als offener Kanal interpretiert. Es wird davon ausgegangen, dass der Kanal zum Lesen geöffnet und für binäre Eingaben konfiguriert wurde. Der Befehl schließt den Kanal *nicht*.

**::tar::stat** *Tarball* ?Datei? ?**-chan**? ?**-gzip**?
: Gibt ein verschachteltes Wörterbuch zurück, das Informationen zur genannten „Datei“ in *tarball* enthält, oder zu allen Dateien, wenn keine angegeben wurde. Die oberste Ebene besteht aus Paaren aus Dateinamen und Informationen. Die Informationen bestehen aus einem Dict mit den Schlüsseln „**mode** **uid** **gid** **size** **mtime** **type** **linkname** **uname** **gname** **devmajor** **devminor**“.


```
% ::tar::stat tarball.tar
foo.jpg {mode 0644 uid 1000 gid 0 size 7580 mtime 811903867 type file linkname {} uname user gname wheel devmajor 0 devminor 0}
```

Wenn die Option **-chan** vorhanden ist, wird *tarball* als offener Kanal interpretiert. Es wird davon ausgegangen, dass der Kanal zum Lesen geöffnet und für binäre Eingaben konfiguriert wurde. Der Befehl schließt den Kanal *nicht*.

**::tar::untar** *tarball* *args*
: Entpackt den *Tarball*. *-file* und *-glob* beschränken das Entpacken auf Dateien, die genau mit dem angegebenen Argument übereinstimmen oder dessen Muster erfüllen. Es wird kein Fehler ausgelöst, wenn keine Dateien übereinstimmen. Gibt eine Liste der extrahierten Dateinamen und die Dateigröße zurück. Bei nicht regulären Dateien ist die Größe null. Führende Pfadtrennzeichen werden entfernt, sodass Pfade immer relativ sind.


**-dir** Verzeichnisname
: Verzeichnis, in das extrahiert werden soll. Verwendet **pwd**, wenn kein Verzeichnis angegeben wurde.

**-file** Dateiname
: Entpackt nur die Datei mit diesem Name. Der Name wird mit dem im Archiv gespeicherten vollständigen Pfad einschließlich der Verzeichnisse abgeglichen.

**-glob**-Muster
: Es werden nur Dateien extrahiert, die diesem „Glob“-Muster entsprechen. Das Muster wird mit dem vollständigen, im Archiv gespeicherten Pfad abgeglichen.

**-nooverwrite**
: Bereits vorhandene Dateien nicht überschreiben.

**-nomtime**
: Behält den Zeitpunkt der Dateiänderung als aktuellen Zeitpunkt bei, anstatt ihn auf den Wert im Archiv zu setzen.

**-noperms**
: Unter Unix sollten Sie die Dateiberechtigungen auf die aktuelle umask belassen, anstatt sie auf die im Archiv enthaltenen Werte festzulegen.

**-chan**
: Wenn diese Option angegeben ist, wird *tarball* als geöffneter Kanal interpretiert. Es wird davon ausgegangen, dass der Kanal zum Lesen geöffnet und für binäre Eingaben konfiguriert wurde. Der Befehl schließt den Kanal *nicht*.


```
% foreach {file size} [::tar::untar tarball.tar -glob *.jpg] {
puts "Extracted $file ($size bytes)"
}
```

**::tar::get** *tarball* *fileName* ?**-chan**? ?**-gzip**?
: Gibt den Inhalt von *Dateiname* aus dem *Tarball* zurück.


```
% set readme [::tar::get tarball.tar doc/README] {
% puts $readme
}
```

Wenn die Option **-chan** vorhanden ist, wird *tarball* als offener Kanal interpretiert. Es wird davon ausgegangen, dass der Kanal zum Lesen geöffnet und für binäre Eingaben konfiguriert wurde. Der Befehl schließt den Kanal *nicht*.

Es wird ein Fehler ausgelöst, wenn der Dateiname im tar-Archiv nicht gefunden wird.

**::tar::create** *tarball* *files* *args*
: Erstellt eine neue TAR-Datei, die die *Dateien* enthält. *Dateien* muss als einzelnes Argument festgelegt werden, das eine gültige Liste von Dateinamen darstellt.


**-dereference**
: Normalerweise speichert **create** Links als tatsächliche Verweise auf eine Datei, die im Archiv vorhanden sein kann oder auch nicht. Wenn Sie diese Option legen, wird stattdessen die Datei gespeichert, auf die der Link verweist.

**-chan**
: Wenn diese Option angegeben ist, wird *tarball* als offener Kanal interpretiert. Es wird davon ausgegangen, dass der Kanal zum Schreiben geöffnet und für binäre Ausgabe konfiguriert wurde. Der Befehl schließt den Kanal *nicht*.


```
% ::tar::create new.tar [glob -nocomplain file*]
% ::tar::contents new.tar
file1 file2 file3
```

**::tar::add** *tarball* *files* *args*
: Fügt *Dateien* am Ende des vorhandenen *Tarballs* an. *Dateien* müssen als einzelnes Argument angegeben werden, das eine gültige Liste von Dateinamen darstellt.


**-dereference**
: Normalerweise speichert **add** Links als tatsächliche Links, die auf eine Datei verweisen, die im Archiv vorhanden sein kann oder auch nicht. Wenn Sie diese Option legen, wird stattdessen die Datei gespeichert, auf die der Link verweist.

**-prefix** Zeichenfolge
: Normalerweise speichert **add** Dateien unter genau dem Namen, der als Argument angegeben wurde. Durch die Angabe von „-prefix“ wird jedem Namen die *Zeichenkette* vorangestellt.

**-quick**
: Die einzige sichere Methode, die Position im *Tarball* zu finden, an der neue Dateien hinzugefügt werden können, besteht darin, ihn von Anfang an zu lesen. Wenn der *Tarball* jedoch mit einer „Blocksize“ von 1 geschrieben wurde (wie es bei diesem Paket der Fall ist), können Sie diese Position alternativ auch durch Suchen vom Ende aus ermitteln. Die Option „-quick“ weist **add** an, Letzteres zu tun.


**::tar::remove** *tarball* *files*
: Entfernt *Dateien* aus dem *Tarball*. Es wird kein Fehler ausgegeben, wenn die Datei im Tarball nicht vorhanden ist. Es sind Schreibrechte für das Verzeichnis sowie freier Speicherplatz in einer Größe erforderlich, die mindestens der Größe des Tarballs entspricht.


```
% ::tar::remove new.tar {file2 file3}
% ::tar::contents new.tar
file3
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *tar* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dateiformate
