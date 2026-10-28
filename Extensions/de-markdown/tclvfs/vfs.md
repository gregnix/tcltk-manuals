---
CommandName: vfs
title: vfs
ManualSection: n
Version: 1.4
TclPart: Vfs
TclDescription: Tcl-only Virtual File Systems
Keywords:
 - vfs
 - filesystem
 - file
Copyright:
 - Copyright (c) 2001-2003, Vince Darley
---

# Name

::vfs - Befehle und Prozeduren zum Anlegen virtueller Dateisysteme

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit}
[package]{.cmd} [require]{.sub} [vfs]{.lit} [1.4]{.optlit}
[vfs::filesystem]{.cmd} [info]{.arg}
[vfs::filesystem]{.cmd} [mount]{.arg}
[vfs::filesystem]{.cmd} [unmount]{.arg}
[vfs::accessMode]{.cmd} [mode]{.arg}
[vfs::matchDirectories]{.cmd} [types]{.arg}
[vfs::matchFiles]{.cmd} [types]{.arg}
[vfs::matchCorrectTypes]{.cmd} [types]{.arg} [filelist]{.arg} [inDir]{.optarg}
:::

# Beschreibung

Das Paket **::vfs** liefert Befehle, um virtuelle Dateisysteme abzufragen, einzuhängen und auszuhängen, und als Tcl-Bibliotheken Hilfen zum Schreiben neuer virtueller Dateisysteme in Tcl. Sobald ein virtuelles Dateisystem steht, gelten darin die Tcl-Befehle **file**, **glob**, **cd**, **pwd** und **open**, einschließlich ihrer C-Schnittstellen in der Tcl-Bibliothek (zum Beispiel **Tcl\_FSOpenFileChannel**, **Tcl\_FSMatchInDirectory**, …). Sauber geschriebene Erweiterungen wie Tk, die Dateien öffnen oder lesen, erreichen das virtuelle Dateisystem ebenfalls. Weil die gesamte Dateisystemarbeit von Tcl durch eine Schicht läuft, lässt sie sich abfangen. Genau das tut dieses Paket. Das ist etwas anderes, als den Befehl **file** in Tcl zu überladen. Ersetzt werden C-Befehle wie **access** und **stat**. Wenige Befehle auf dieser niedrigen Ebene genügen, damit alle Befehle der höheren Ebenen arbeiten, unabhängig davon, was in der Dateisystemschicht geschieht.

Die Dateisystem-Hooks von Tcl gelten je Prozess. Jeder Tcl-Interpreter im selben Prozess sieht dasselbe Dateisystem, einschließlich der virtuellen Dateisysteme.

Der Befehl **package require vfs** lädt diese Bibliothek. Er trägt die vfs-Hooks in das Dateisystem von Tcl ein, und sie bleiben, bis Tcl endet (eine Steuerung dafür könnte später an Tcl durchgereicht werden). Zu diesem Zeitpunkt ist noch kein neues Dateisystem eingehängt, die Wirkung bleibt also klein. **package require vfs** hat zwei Wirkungen. Erstens sorgt der Aufruf in **jedem** Tcl-Interpreter dafür, dass die vfs-Hooks genau einmal im Kern von Tcl eingetragen werden. Werden Interpreter später gelöscht, bleiben die Hooks eingetragen, bis Tcl endet. Zweitens stellt der Aufruf den Befehl **vfs::filesystem** bereit. Damit fängt der Interpreter Dateisystembefehle ab und behandelt sie mit Tcl-Code in diesem Interpreter.

Drei wenig unterstützte Unterbefehle von **vfs::filesystem** sind **fullynormalize path**, **posixerror int** und **internalerror ?script?**. Sie normalisieren einen Pfad einschließlich eines symbolischen Links am Ende, ordnen einen POSIX-Fehlercode einem Tcl-Fehler zu und fangen interne Fehler in tclvfs-Umsetzungen ab.

**vfs::filesystem** *mount* *?-volume?* *path* *command*
: Ein virtuelles Dateisystem muss eingehängt werden. Dabei erklärt man dem Paket vfs, dass alle Unterverzeichnisse eines *path* im Dateisystem von dem angegebenen *command* behandelt werden. Das ist ein Tcl-Befehl oder eine Prozedur in dem Interpreter, in dem **vfs::filesystem** ausgeführt wird. Mit dem Flag *?-volume?* wird der Einhängepunkt bei Tcl zusätzlich als neues Volume eingetragen, wie ein neues Laufwerk, das in *file volumes* erscheint. Das ist sinnvoll und für einen brauchbaren Betrieb nötig bei Einhängungen wie *ftp://*. Für Pfade innerhalb des nativen Dateisystems wird das Flag nicht angegeben. Die neuen Einhängungen gelten sofort in allen Interpretern des Prozesses. Wird der Interpreter später gelöscht, fallen alle Einhängungen weg, die er abfängt, und damit ändert sich die Sicht aller Interpreter auf das Dateisystem.

**vfs::filesystem** *unmount* *path*
: Hängt das virtuelle Dateisystem aus, das unter *path* eingehängt war, und nimmt es damit aus dem Dateisystem von Tcl. War dort nichts eingehängt, entsteht ein Fehler.

**vfs::filesystem** *info* *?path?*
: Ohne Argumente gibt der Befehl die Liste aller eingehängten Dateisysteme zurück, über alle Interpreter. Mit einem Pfadargument kommt das *command* für diesen Pfad zurück. Ist für den Pfad kein vfs eingehängt, entsteht ein Fehler. Derzeit lässt sich nicht feststellen, in welchem Interpreter jeder Befehl ausgewertet wird.

**vfs::filesystem** *fullynormalize* *path*
: Expandiert *path* vollständig, wie 'file normalize', und folgt dabei auch Links im letzten Pfadbestandteil.


# Ein virtuelles Dateisystem nur in Tcl

Das Paket vfs fängt jede Dateisystemoperation ab, die in einen Einhängepunkt fällt, und gibt sie an das *command* des Einhängepunkts in dem Interpreter weiter, der ihn eingetragen hat. Das entspricht auf C-Ebene einer Auswertung wie *eval $command \[list $subcmd $root $relative $actualpath\] $args*.

*subcmd* ist einer der Werte *access*, *createdirectory*, *deletefile*, *fileattributes*, *matchindirectory*, *open*, *removedirectory*, *stat*, *utime*. Behandelt *command* jeden dieser Fälle passend, entsteht ein vollständiges virtuelles Dateisystem, das Tcl vom nativen Dateisystem nicht unterscheidet. (Einschränkung: derzeit werden nicht alle berechtigungsbezogenen Flags von 'glob' an Tcl durchgereicht.)

Die übrigen Argumente nennen den Dateipfad, auf dem die Operation arbeitet (jeder Befehl arbeitet auf einem solchen Pfad), und weitere Argumente, die die Aktion braucht. Der Dateipfad besteht aus drei Argumenten: *root* ist der Teil des Pfads außerhalb des Einhängepunkts dieses Dateisystems, *relative* ist der Teil innerhalb dieses Dateisystems, und *actualpath* ist der ursprüngliche, nicht normalisierte Name des Pfads, wie ihn der aktuelle Befehl verwendet hat, egal ob er aus Tcl oder aus C kam. Ist zum Beispiel *C:/foo/bar/mount.zip/xxx/yyy* ein Pfad im Dateisystem, *mount.zip* ein Zip-Archiv, das auf sich selbst eingehängt ist und *xxx/yyy* enthält, das Arbeitsverzeichnis liegt in *xxx*, und ausgewertet wird ein Befehl wie *file exists yyy*, dann ist *root* gleich C:/foo/bar/mount.zip, *relative* ist *xxx/yyy* und *actualpath* ist *yyy*. Das Trennzeichen zwischen *root* und *relative* entfällt.

Die meisten Dateisystemoperationen brauchen für ein richtiges Ergebnis nur das Argument *relative*. Für manche Unterbefehle sind die anderen Argumente nötig.

Fast alle diese Befehle kehren entweder ordnungsgemäß zurück (auf C-Ebene mit dem Ergebnis TCL\_OK) oder sie melden den passenden POSIX-Fehlercode mit vfs::filesystem posixerror. Ein geworfener Tcl-Fehler gilt als Fehler der Umsetzung und wird als unbekannter POSIX-Fehler des Dateisystemaufrufs gelesen. Ausgenommen sind die Dateisystembefehle, die eine Tcl-Fehlermeldung direkt angeben dürfen: open (wenn ein Interpreter übergeben wird), matchindirectory und fileattributes (nur bei einer set- oder get-Operation). Diese drei Befehle dürfen jede Tcl-Fehlermeldung werfen; sie geht an den Aufrufer. Sie dürfen auch einen POSIX-Fehler werfen, der passend behandelt wird.

Die Befehle im Einzelnen (*r-r-a* steht für das übliche Argumenttripel *root*, *relative* und *actualpath*):

*command* *access* *r-r-a* *mode*
: Gibt TCL\_OK zurück oder wirft einen POSIX-Fehler, je nachdem, ob der angegebene Zugriffsmodus (eine ganze Zahl) zur Datei passt.

*command* *createdirectory* *r-r-a*
: Legt ein Verzeichnis mit dem angegebenen Namen an. Der Befehl darf annehmen, dass alle Unterverzeichnisse im Pfad vorhanden und gültig sind und dass der gewünschte Pfad noch nicht existiert. Darum kümmert sich Tcl.

*command* *deletefile* *r-r-a*
: Löscht die angegebene Datei.

*command* *fileattributes* *r-r-a* *?index?* *?value?*
: Sind weder index noch value angegeben, kommt die Liste aller zulässigen Attributnamen zurück. Ist *index* angegeben, aber kein Wert, liefert der Befehl den Wert des *index*-ten Attributs der Datei, gezählt in der Reihenfolge der Liste ohne Argumente. Ist auch ein Wert angegeben, setzt der Befehl das *index*-te Attribut der Datei auf diesen Wert.

*command* *matchindirectory* *r-r-a* *pattern* *types*
: Gibt die Liste der Dateien oder Verzeichnisse im angegebenen Pfad zurück. Der Pfad ist immer der Name eines vorhandenen Verzeichnisses. Die Einträge passen zum *pattern* und zu den angegebenen *types*. Wichtig ist, dass der Befehl *types*-Anforderungen richtig behandelt, die nur Verzeichnisse (oder nur Dateien) verlangen: Für jedes rekursive Globbing erzeugt Tcl selbst beim Dateisystem Anforderungen, die nur Verzeichnisse treffen. Hilfe dazu steht unten bei **vfs::matchDirectories**.

*command* *open* *r-r-a* *mode* *permissions*
: *mode* ist einer der Werte "r", "w", "a", "w+", "a+". Wird dabei eine Datei angelegt, bestimmen *permissions* die Modi dafür. Schlägt das Öffnen fehl, ist ein Fehler zu werfen. Gelingt es, gibt der Befehl eine Liste mit einem oder zwei Elementen zurück. Das erste Element ist Pflicht und der Name des angelegten Kanals. Das zweite Element, falls vorhanden, ist eine Tcl-Rückruffunktion für das Schließen des Kanals, damit das vfs aufräumen kann. Tcl wertet diese Rückruffunktion unmittelbar vor dem Schließen des Kanals aus. Der Kanal besteht noch, und alle vorhandenen Daten sind hineingeschrieben. Die Rückruffunktion kann zum Beispiel an den Anfang des Kanals gehen, den Inhalt lesen und ihn anderswo ablegen, etwa komprimiert oder auf einem entfernten FTP-Server. Rückgabecode und Fehler der Rückruffunktion werden ignoriert, es sei denn, das Skript 'internalerror' ist angegeben; dann gehen sie an dieses Skript. Will die Rückruffunktion einen Fehler melden, muss sie das asynchron tun, zum Beispiel mit bgerror.

*command* *removedirectory* *r-r-a* *recursive*
: Löscht das angegebene Verzeichnis. *recursive* ist 0 oder 1. Bei 1 wird auch ein nicht leeres Verzeichnis mitsamt Inhalt rekursiv gelöscht. Bei 0 und einem nicht leeren Verzeichnis ist ein POSIX-Fehler (EEXIST) zu werfen.

*command* *stat* *r-r-a*
: Gibt eine Liste gerader Länge mit Paaren aus Feldname und Wert für den Inhalt einer stat-Struktur zurück. Die Reihenfolge ist gleichgültig. Die Optionsnamen sind dev (long), ino (long), mode (int), nlink (long), uid (long), gid (long), size (long), atime (long), mtime (long), ctime (long), type (eine Zeichenkette, entweder "directory" oder "file"). Der Typ jedes Arguments steht in Klammern. Die Prozedur kehrt daher etwa so zurück: *return \[list dev 0 type file mtime 1234 ...\]*.

*command* *utime* *r-r-a* *actime* *mtime*
: Setzt Zugriffs- und Änderungszeit der angegebenen Datei. Gelesen werden sie mit 'stat'.


# VFS-Hilfen

Die vfslib stellt Tcl-Prozeduren bereit, die beim Schreiben der Befehlsprozeduren für die genannten Fälle helfen. Das sind:

**vfs::accessMode** *mode*
: Wandelt einen ganzzahligen Zugriffsmodus *access* in eine handlichere Zeichenkette um, eine von F, X, W, XW, R, RX, RW.

**vfs::matchDirectories** *types*
: Sollen laut *types* Verzeichnisse enthalten sein?

**vfs::matchFiles** *types*
: Sollen laut *types* Dateien enthalten sein?

**vfs::matchCorrectTypes** *types* *filelist* *?inDir?*
: Gibt den Teil der *filelist* zurück, der zu den angegebenen *types* passt. Die Elemente sind absolute Pfade oder Namen von Dateien in *inDir*.


# VFS-Fehlersuche

Zum Untersuchen von Problemen in der Umsetzung dient zum Beispiel: vfs::filesystem internalerror report ; proc report {} { puts stderr $::errorInfo }

# Einschränkungen

Der vfs-Code hat sehr wenige Einschränkungen. Eine Feinheit: wird ein virtuelles Dateisystem, das Groß- und Kleinschreibung unterscheidet, in ein System eingehängt, das sie nicht unterscheidet (das übliche Dateisystem von Windows oder MacOS), und der eigene Code verlässt sich auf die Gleichbehandlung, dann läuft er im virtuellen Dateisystem nicht richtig. Code, der sich darauf verlässt, liefe unter Tcl auf Unix ebenfalls nicht. Der Ausweg ist, den Code zu korrigieren.

Später können die Befehle *link* und *lstat* dazukommen, damit virtuelle Dateisysteme Links lesen und schreiben. Die C-Schnittstelle kann das. Diese Erweiterung reicht es an Tcl noch nicht durch.

Die Tcl-Funktion 'Tcl\_FSMatchInDirectory' nimmt verschiedene Typangaben in einer Struktur Tcl\_GlobTypeData entgegen. Derzeit wird daraus nur das Feld 'type' durchgereicht. Die Felder 'permissions' und der MacOS-Typ mit Creator bleiben unbeachtet.
