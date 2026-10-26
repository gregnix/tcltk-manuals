---
CommandName: zipfile::mkzip
ManualSection: n
Version: 1.2.4
TclPart: tcllib
TclDescription: Zip archive creation
Keywords:
 - decompression
 - zip
Copyright:
 - Copyright (c) 2009 Pat Thoyts
---

# NAME

zipfile::mkzip – ZIP-Archiv erstellen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.6]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [zipfile::mkzip]{.lit} [1.2.4]{.optlit} 
[::zipfile::mkzip::mkzip]{.cmd} [zipfile]{.arg} [-zipkit]{.optlit} [-runtime prefix]{.optarg} [-comment string]{.optarg} [-directory rootpath]{.optarg} [-prepend-base-directory bool]{.optarg} [-exclude exclude]{.optarg} [--]{.optlit} [path]{.optdot} 
:::

# BESCHREIBUNG

Dieses Paket nutzt die zlib-Funktionen in Tcl 8.6, um ZIP-Archive zu erstellen.

# API

**::zipfile::mkzip::mkzip** *zipfile* ?**-zipkit**? ?**-runtime** *prefix*? ?**-comment** *string*? ?**-directory** *rootpath*? ?**-prepend-base-directory** *bool*? ?**-exclude** *exclude*? ?**--**? ?*path*...?
: Aus *http://wiki.tcl.tk/15158* Dieser Befehl erstellt ein ZIP-Archiv aus einer Verzeichnisstruktur und nutzt dabei ausschließlich die Kernfunktionen von Tcl 8.6. Die resultierende ZIP-Datei sollte mit anderen **zip**-Programmen kompatibel sein – mit der möglichen Ausnahme der Unicode-Unterstützung. Die durch diesen Befehl erzeugten Dateien verwenden die UTF-8-Kodierung für alle Dateinamen und Kommentare, und es wurde insbesondere unter Windows festgestellt, dass **info-zip** und die in Windows integrierte ZIP-Ansicht diesen Teil der ZIP-Dateispezifikation nur unzureichend unterstützen. Das Programm **7-Zip** zeigt UTF-8-Dateinamen jedoch korrekt an, und das Paket **vfs::zip** verwendet diese natürlich. Wenn Sie


```
::mkzip::mkzip mystuff.tm -zipkit -directory mystuff.vfs
```

: Es packt Ihren virtuellen Dateisystembaum „*mystuff.vfs/*“ in ein ZIP-Archiv mit einem geeigneten Header, sodass Sie es unter Unix als ausführbar kennzeichnen können und es mit tclkit laufen sollte. Alternativ kannst du es auch mit **tclsh** oder **wish** 8.6 ausführen, wenn du möchtest. Um den Header der ausführbaren Datei zu ändern, legen Sie das **-runtime** „*preface*“ fest, wobei „preface“ eine Datei ist, deren Inhalt Sie voranstellen möchten. Unter Windows können Sie beispielsweise ein selbstextrahierendes ZIP-Archiv erstellen, indem Sie


```
mkzip mystuff.exe -directory mystuff.vfs -runtime unzipsfx.exe
```

: Die Datei „*unzipsfx.exe*“ ist der selbstextrahierende Stub von Info-Zip. Zulässige Optionen:


**-runtime** Pfad
: Diese Option legt eine Datei fest, die als Präfix für das eigentliche ZIP-Archiv verwendet werden soll. Wenn angegeben, wird **-zipkit** ignoriert.

**-zipkit**
: Weist den Befehl an, ein Präfix zu generieren, das das Archiv zu einem ZIP-basierten Starkit macht. Wird ignoriert, wenn **-runtime** vorhanden ist.

**-comment** Zeichenfolge
: Diese Option legt einen globalen Kommentar fest, der in das generierte Archiv eingefügt werden soll.

**-directory** Pfad
: Diese Option legt das Verzeichnis fest, das in das generierte Archiv placed werden soll. Wenn angegeben, werden alle *Pfad*-Argumente *ignoriert*.

**-prepend-base-directory** bool
: Wenn diese Option aktiviert ist, wird allen Pfaden, die dem Archiv hinzugefügt werden, der Endteil des Pfads **-directory** vorangestellt. Die Option wird ignoriert, wenn die Option **-directory** nicht angegeben ist. Standardmäßig ist diese Option auf **false** gesetzt.

**-exclude** Liste
: Diese Option legt eine Liste von Wildcard-Mustern fest. Alle Pfade, die mit mindestens einem dieser Muster übereinstimmen, werden nicht in das erzeugte Archiv platziert. Die Standardeinstellung dieser Option lautet


```
    CVS/* */CVS/* *~ ".#*" "*/.#*"
```

**--**
: Diese Option markiert das Ende der Optionen und sorgt dafür, dass alle nachfolgenden Wörter als Argumente verarbeitet werden, auch wenn sie mit einem Bindestrich beginnen.


Zulässige Argumente:

Pfad *Pfad*
: Jeder Pfad ist ein Verzeichnis oder eine Datei, die in das generierte Archiv platziert werden soll. Hinweis: Diese werden ignoriert, wenn die Option **-directory** festgelegt wird.


# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *zipfile* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Dateien

# COPYRIGHT

```
Copyright (c) 2009 Pat Thoyts
```
