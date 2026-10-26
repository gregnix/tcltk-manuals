---
CommandName: zipfile::decode
title: zipfile::decode
ManualSection: n
Version: 0.11.0
TclPart: tcllib
TclDescription: Zip archive handling
Keywords:
 - decompression
 - zip
Copyright:
 - Copyright (c) 2008-2022 Andreas Kupries
---

# Name

zipfile::decode – Zugriff auf ZIP-Archive

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [fileutil::decode]{.lit} [0.2.1]{.lit}
[package]{.cmd} [require]{.sub} [Trf]{.lit}
[package]{.cmd} [require]{.sub} [zlibtcl]{.lit}
[package]{.cmd} [require]{.sub} [zipfile::decode]{.lit} [0.11.0]{.optlit}
[::zipfile::decode::archive]{.cmd}
[::zipfile::decode::close]{.cmd}
[::zipfile::decode::comment]{.cmd} [adict]{.arg}
[::zipfile::decode::content]{.cmd} [archive]{.arg}
[::zipfile::decode::copyfile]{.cmd} [adict]{.arg} [path]{.arg} [dst]{.arg}
[::zipfile::decode::files]{.cmd} [adict]{.arg}
[::zipfile::decode::filetime]{.cmd} [adict]{.arg} [path]{.arg}
[::zipfile::decode::getfile]{.cmd} [zdict]{.arg} [path]{.arg}
[::zipfile::decode::hasfile]{.cmd} [adict]{.arg} [path]{.arg}
[::zipfile::decode::filesize]{.cmd} [zdict]{.arg} [path]{.arg}
[::zipfile::decode::filecomment]{.cmd} [zdict]{.arg} [path]{.arg}
[::zipfile::decode::iszip]{.cmd} [archive]{.arg}
[::zipfile::decode::open]{.cmd} [archive]{.arg}
[::zipfile::decode::unzip]{.cmd} [adict]{.arg} [dstdir]{.arg}
[::zipfile::decode::unzipfile]{.cmd} [archive]{.arg} [dstdir]{.arg}
:::

# Beschreibung

Hinweis: Die Pakete „Trf“ und „zlibtcl“ sind nicht erforderlich, wenn TCL 8.6 verfügbar ist. Dieses Paket enthält Befehle zum Entpacken von ZIP-Archiven und zum Zugriff auf deren Inhalt.

# API

**::zipfile::decode::archive**
: Dieser Befehl dekodiert die zuletzt geöffnete (und noch nicht geschlossene) ZIP-Archivdatei. Das Ergebnis des Befehls ist ein Dictionary, das den Inhalt des Archivs beschreibt. Die Struktur dieses Dictionarys ist nicht öffentlich. Der Zugriff sollte ordnungsgemäß über die bereitgestellten Zugriffsbefehle dieses Pakets erfolgen.

**::zipfile::decode::close**
: Dieser Befehl gibt alle Zustandsdaten frei, die mit dem letzten Aufruf von **::zipfile::decode::open** verbunden sind. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::zipfile::decode::comment** *adict*
: Dieser Befehl nimmt ein Dictionary entgegen, das die derzeit geöffnete ZIP-Archivdatei beschreibt, wie sie von **::zipfile::decode::archive** zurückgegeben wird, und gibt den globalen Kommentar des Archivs zurück.

**::zipfile::decode::content** *archive*
: Dies ist ein Komfortbefehl, der die angegebene ZIP-*Archiv*-Datei entpackt und als Ergebnis die Liste der darin enthaltenen Pfade gibt.

**::zipfile::decode::copyfile** *adict* *path* *dst*
: Dieser Befehl nimmt ein Dictionary entgegen, das die aktuell geöffnete ZIP-Archivdatei beschreibt, wie sie von **::zipfile::decode::archive** zurückgegeben wird, und kopiert den entpackten Inhalt der Datei mit dem Pfad *path* im Archiv in die Datei *dst*. Wenn die Datei im Archiv nicht gefunden wird, wird ein Fehler ausgelöst.

**::zipfile::decode::files** *adict*
: Dieser Befehl nimmt ein Dictionary entgegen, das die aktuell geöffnete ZIP-Archivdatei beschreibt, wie sie von **::zipfile::decode::archive** zurückgegeben wird, und gibt die Liste der im Archiv enthaltenen Dateien zurück.

**::zipfile::decode::filetime** *adict* *path*
: Dieser Befehl nimmt ein Dictionary entgegen, das die derzeit geöffnete ZIP-Archivdatei beschreibt, wie sie von **::zipfile::decode::archive** zurückgegeben wird, und gibt den Zeitstempel der Datei *Pfad* im Archiv zurück.

**::zipfile::decode::getfile** *zdict* *path*
: Dieser Befehl nimmt ein Dictionary entgegen, das die derzeit geöffnete ZIP-Archivdatei beschreibt, wie sie von **::zipfile::decode::archive** zurückgegeben wird, und gibt den entpackten Inhalt der Datei mit dem Pfad *path* im Archiv zurück. Wenn die Datei im Archiv nicht gefunden wird, wird ein Fehler ausgelöst.

**::zipfile::decode::hasfile** *adict* *path*
: Dieser Befehl nimmt ein Dictionary entgegen, das die aktuell geöffnete ZIP-Archivdatei beschreibt, wie es **::zipfile::decode::archive** gibt, und prüft, ob der angegebene *Pfad* im Archiv gefunden wird. Das Ergebnis des Befehls ist ein boolescher Wert: **true**, wenn der Pfad gefunden wird, andernfalls **false**.

**::zipfile::decode::filesize** *zdict* *path*
: Dieser Befehl nimmt ein Dictionary entgegen, das die aktuell geöffnete ZIP-Archivdatei beschreibt, wie sie von **::zipfile::decode::archive** zurückgegeben wird, und gibt die entpackte Größe der Datei *Pfad* im Archiv zurück. Wenn die Datei im Archiv nicht gefunden wird, wird ein Fehler ausgelöst.

**::zipfile::decode::filecomment** *zdict* *path*
: Dieser Befehl nimmt ein Dictionary entgegen, das die derzeit geöffnete ZIP-Archivdatei beschreibt, wie sie von **::zipfile::decode::archive** zurückgegeben wird, und gibt den dateispezifischen Kommentar der Datei *pfad* im Archiv zurück. Wenn die Datei im Archiv nicht gefunden wird, wird ein Fehler ausgelöst.

**::zipfile::decode::iszip** *archive*
: Dieser Befehl nimmt den Pfad einer vermeintlichen ZIP-*Archiv*-Datei entgegen und gibt als Ergebnis ein boolesches Flag zurück, das angibt, ob es sich tatsächlich um ein ZIP-Archiv handelt (**true**) oder nicht (**false**).

**::zipfile::decode::open** *archive*
: Dieser Befehl nimmt den Pfad einer ZIP-*Archiv*-Datei entgegen und bereitet diese für die Entpackung vor. Das Ergebnis des Befehls ist die leere Zeichenkette. Alle wichtigen Informationen werden im globalen Status gespeichert. Werden mehrere „open“-Aufrufe nacheinander ausgeführt, steht den anderen Befehlen nur der Status des letzten Aufrufs zur Verfügung.

**::zipfile::decode::unzip** *adict* *dstdir*
: Dieser Befehl nimmt ein Dictionary entgegen, das die derzeit geöffnete ZIP-Archivdatei beschreibt, wie es **::zipfile::decode::archive** zurückgibt, und entpackt das Archiv in das angegebene Zielverzeichnis *dstdir*. Das Ergebnis des Befehls ist die leere Zeichenkette.

**::zipfile::decode::unzipfile** *archive* *dstdir*
: Dies ist ein Komfort-Befehl, der die angegebene ZIP-*Archiv*-Datei in das angegebene Ziel-Verzeichnis *dstdir* entpackt.

    Das Ergebnis des Befehls ist die leere Zeichenkette.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *zipfile* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Dateien

# Copyright

```
Copyright (c) 2008-2022 Andreas Kupries
```
