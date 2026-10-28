---
CommandName: vfs-fsapi
title: vfs-fsapi
ManualSection: n
Version: 1.0
TclPart: vfs-fsapi
TclDescription: Tcl-level Virtual Filesystems
Links:
 - vfs
 - vfs-filesystems
Keywords:
 - file
 - filesystem
 - vfs
Copyright:
 - Copyright (c) 2001-2003 Vince Darley <vincentdarley@users.sourceforge.net>
 - Copyright (c) 2003 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

vfs-fsapi - API für die Umsetzung eines Dateisystems in Tcl

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.4]{.lit}
[package]{.cmd} [require]{.sub} [vfs]{.lit} [1.2.1]{.optlit}
[vfshandler]{.cmd} [subcmd]{.arg} [root]{.arg} [relative]{.arg} [actualpath]{.arg} [args...]{.arg}
[vfshandler]{.cmd} [access]{.lit} [root]{.arg} [relative]{.arg} [actualpath]{.arg} [mode]{.arg}
[vfshandler]{.cmd} [createdirectory]{.lit} [root]{.arg} [relative]{.arg} [actualpath]{.arg}
[vfshandler]{.cmd} [deletefile]{.lit} [root]{.arg} [relative]{.arg} [actualpath]{.arg}
[vfshandler]{.cmd} [fileattributes]{.lit} [root]{.arg} [relative]{.arg} [actualpath]{.arg} [index]{.optarg} [value]{.optarg}
[vfshandler]{.cmd} [matchindirectory]{.lit} [root]{.arg} [relative]{.arg} [actualpath]{.arg} [pattern]{.arg} [types]{.arg}
[vfshandler]{.cmd} [open]{.lit} [root]{.arg} [relative]{.arg} [actualpath]{.arg} [mode]{.arg} [permissions]{.arg}
[vfshandler]{.cmd} [removedirectory]{.lit} [root]{.arg} [relative]{.arg} [actualpath]{.arg} [recursive]{.arg}
[vfshandler]{.cmd} [stat]{.lit} [root]{.arg} [relative]{.arg} [actualpath]{.arg}
[vfshandler]{.cmd} [utime]{.lit} [root]{.arg} [relative]{.arg} [actualpath]{.arg} [actime]{.arg} [mtime]{.arg}
[vfs::accessMode]{.cmd} [mode]{.arg}
[vfs::matchDirectories]{.cmd} [types]{.arg}
[vfs::matchFiles]{.cmd} [types]{.arg}
[vfs::matchCorrectTypes]{.cmd} [types]{.arg} [filelist]{.arg} [inDir]{.optarg}
:::

# Beschreibung

Dieses Dokument beschreibt die API, mit der das Paket **vfs** mit Dateisystem-Umsetzungen in Tcl spricht.

# Überblick über den Handler

Das Paket **vfs** fängt jede Dateisystemoperation ab, die in einen Einhängepunkt fällt, und gibt sie an den Befehl **vfshandler** des Einhängepunkts in dem Interpreter weiter, der ihn eingetragen hat.

Behandelt der Handler jeden Fall, für den er aufgerufen wird, passend, entsteht ein vollständiges virtuelles Dateisystem, das Tcl vom nativen Dateisystem nicht unterscheidet. (Einschränkung: derzeit reicht **vfs** nicht alle berechtigungsbezogenen Flags von **glob** an Tcl durch.)

**vfshandler** *subcmd* *root* *relative* *actualpath* *args*...
: Das erste Argument nennt die Operation, die der Handler für den Dateisystemcode im Tcl-Kern ausführt. Der Rest nennt den Dateipfad, auf dem sie arbeitet, in verschiedenen Formen und Teilen, und weitere Argumente, die die Aktion braucht.

    Als Beispiel für die Behandlung eines Pfads durch die allgemeine Schicht dient "*C:/foo/bar/mount.zip/xxx/yyy*". Zusätzlich gelten die folgenden Bedingungen:

    1. "*mount.zip*" ist ein Zip-Archiv, das auf sich selbst eingehängt ist,

    2. dieses Zip-Archiv enthält eine Datei mit dem Pfad "*xxx/yyy*",

    3. das Arbeitsverzeichnis der Anwendung liegt im Verzeichnis "*xxx*",

    4. und der ausgeführte Befehl ist **file exists yyy**.


    Das Trennzeichen zwischen *root* und *relative* entfällt. Die meisten Dateisystemoperationen brauchen für ein richtiges Ergebnis nur das Argument *relative*. Manche brauchen die anderen Teile des Pfads.

    *subcmd*
    : Dieses Argument des Handlers ist eines von **access**, **createdirectory**, **deletefile**, **fileattributes**, **matchindirectory**, **open**, **removedirectory**, **stat** oder **utime**.

        Die allgemeine Schicht erwartet, dass die Unterbefehle eines Handlers Fehler mit **vfs::filesystem posixerror** und dem passenden POSIX-Fehlercode melden, statt einen Tcl-Fehler zu werfen. Geschieht das dennoch, gilt er als unbekannter POSIX-Fehler.

        Drei Ausnahmen: Werfen **open** (wenn ein Interpreter übergeben wird), **matchindirectory** oder **fileattributes** (nur bei einer set- oder get-Operation) einen Tcl-Fehler, geht dieser Fehler an den Aufrufer des Dateisystembefehls, der den Handler aufgerufen hat. Diese Unterbefehle dürfen trotzdem **vfs::filesystem posixerror** verwenden, um gewöhnliche Dateisystemfehler zu melden.

    *root*
    : Teil der Angabe des Pfads, auf dem die Operation arbeitet. Enthalten ist der Teil des Pfads außerhalb des Einhängepunkts dieses Dateisystems. Im Beispiel oben ist der Wert "*C:/foo/bar/mount.zip*".

    *relative*
    : Teil der Angabe des Pfads, auf dem die Operation arbeitet. Enthalten ist der Teil des Pfads innerhalb dieses Dateisystems. Im Beispiel oben ist der Wert "*xxx/yyy*".

    *actualpath*
    : Teil der Angabe des Pfads, auf dem die Operation arbeitet. Enthalten ist der ursprüngliche, nicht normalisierte Name des Pfads, wie ihn der aktuelle Befehl verwendet hat, egal ob er aus Tcl oder aus C kam. Im Beispiel oben ist der Wert "*yyy*".



# Handler-Methoden

**vfshandler** **access** *root* *relative* *actualpath* *mode*
: Meldet einen POSIX-Fehler, wenn der angegebene Zugriffsmodus *mode* (eine ganze Zahl) nicht zur Datei oder zum Verzeichnis des Pfads passt. Die allgemeine Schicht ignoriert jeden nicht leeren Rückgabewert.

    Der Befehl **vfs::accessMode** (siehe Abschnitt [Handler-Umgebung]) wandelt die ganze Zahl *mode* in eine leichter zu prüfende Zeichenkette um.

**vfshandler** **createdirectory** *root* *relative* *actualpath*
: Legt ein Verzeichnis mit dem angegebenen Namen an. Der Befehl darf annehmen, dass alle Unterverzeichnisse im Pfad vorhanden und gültig sind und dass der gewünschte Pfad noch nicht existiert. Darum kümmert sich Tcl.

**vfshandler** **deletefile** *root* *relative* *actualpath*
: Löscht die angegebene Datei.

**vfshandler** **fileattributes** *root* *relative* *actualpath* ?*index*? ?*value*?
: Der Befehl gibt eine Liste mit den Namen aller zulässigen Attribute zurück, wenn weder *index* noch *value* angegeben sind.

    Er gibt den Wert des *index*-ten Attributs zurück, wenn *index* angegeben ist, *value* aber nicht. Gezählt wird in der Reihenfolge der Namen aus dem Aufruf ohne *index* und ohne *value*. Das erste Attribut hat den Index **0**.

    Sind *index* und *value* angegeben, setzt der Befehl das *index*-te Attribut auf *value*.

**vfshandler** **matchindirectory** *root* *relative* *actualpath* *pattern* *types*
: Gibt die Liste der Dateien oder Verzeichnisse im angegebenen Pfad zurück, die zum Glob-Muster *pattern* passen und zur angegebenen Liste *types*. Der Pfad ist immer der Name eines vorhandenen Verzeichnisses.

    *Hinweis:* Bei jedem rekursiven Globbing erzeugt Tcl bei den beteiligten Dateisystemen Anforderungen, die nur Verzeichnisse treffen. Dieser Unterbefehl muss solche Anforderungen und solche nur für Dateien richtig behandeln, sonst geht es schief.

    Die Befehle **vfs::matchDirectories** und **vfs::matchFiles** (siehe Abschnitt [Handler-Umgebung]) helfen dabei erheblich.

**vfshandler** **open** *root* *relative* *actualpath* *mode* *permissions*
: Gibt entweder eine Liste zur erfolgreich geöffneten Datei zurück oder wirft einen Fehler, der das Misslingen beschreibt.

    Die Liste bei Erfolg hat mindestens ein und höchstens zwei Elemente. Das erste Element ist Pflicht und das Handle des Kanals, der den Zugriff auf den Inhalt der Datei ermöglicht.

    Ist ein zweites Element angegeben, gilt es als Rückruffunktion, also als Befehlspräfix. Dieses Präfix wird so ausgeführt, wie es dasteht, ohne zusätzliche Argumente. Nötige Argumente gehören zum Ergebnis des Aufrufs von **open**.

    Ist die Rückruffunktion vorhanden, wird sie unmittelbar vor dem Schließen des Kanals *durch die allgemeine Dateisystemschicht* ausgewertet. Die Rückruffunktion selbst darf **close** nicht aufrufen.

    Der Kanal ist noch lebendig genug für **seek** und **read**. Alle vorhandenen Daten sind bereits hineingeschrieben. Die Rückruffunktion kann also an den Anfang dieses Kanals gehen, den Inhalt lesen und die gesammelten Daten anderswo ablegen. Sie räumt damit die Ressourcen einer geöffneten Datei auf und macht ein beschreibbares Dateisystem überhaupt erst möglich.

    Im Normalfall werden Rückgabecode und Fehler der Rückruffunktion ignoriert. Fehler sind dann asynchron zu melden, zum Beispiel mit **bgerror**. Ist über den Unterbefehl **internalerror** ein Skript zur Fehlerbehandlung für das Dateisystem angegeben, gehen alle hier geworfenen Fehler an dieses Skript.

    *mode*
    : ist einer der Werte **r**, **w**, **a**, **w+** oder **a+**.

    *permissions*
    : bestimmt den nativen Modus, mit dem die geöffnete Datei angelegt wird. Relevant nur, wenn der Öffnungsmodus *mode* das Anlegen einer noch nicht vorhandenen Datei verlangt, also nicht **r** ist.


**vfshandler** **removedirectory** *root* *relative* *actualpath* *recursive*
: Löscht das angegebene Verzeichnis. Das Argument *recursive* ist ein boolescher Wert. Ist der Wert **true**, wird auch ein nicht leeres Verzeichnis mitsamt Inhalt rekursiv gelöscht. Ist der Wert **false** und das Verzeichnis nicht leer, ist ein POSIX-Fehler (**EEXIST**) zu werfen.

**vfshandler** **stat** *root* *relative* *actualpath*
: Das Ergebnis ist eine Liste aus Schlüsseln und Werten in einer Form, die der eingebaute Befehl **array set** annimmt. Sie beschreibt den Inhalt einer stat-Struktur. Die Reihenfolge der Schlüssel ist gleichgültig.

    Der Unterbefehl endet daher etwa so:

    ```
    return [list dev 0 type file mtime 1234 ...].
    ```

    als letzten Befehl seiner Umsetzung.

    Das Dateisystem liefert die folgenden Schlüssel und ihre Werte:

    **dev**
    : Eine lange ganze Zahl, die Gerätenummer des Pfads, für den stat aufgerufen wurde.

    **ino**
    : Eine lange ganze Zahl, die Inode-Nummer des Pfads, für den stat aufgerufen wurde. Jeder Pfad, den das Dateisystem behandelt, soll durch die Kombination aus Gerätenummer und Inode-Nummer eindeutig sein. Wird das verletzt, scheitern Algorithmen höherer Ebenen, die Gerät und Inode verfolgen müssen, auf jede erdenkliche Weise.

        Ein Beispiel ist ein Verzeichnisdurchlauf, der sich mit Gerät und Inode aus Endlosschleifen durch symbolische Links heraushält. Nicht eindeutige Angaben zu Gerät und Inode lassen einen solchen Durchlauf Pfade überspringen, weil er sie fälschlich schon gesehen hat.

    **mode**
    : Eine ganze Zahl, der Zugriffsmodus des Pfads. Diesen Modus prüft der Unterbefehl **access**.

    **nlink**
    : Eine lange ganze Zahl, die Zahl der harten Links auf den angegebenen Pfad.

    **uid**
    : Eine lange ganze Zahl, die Kennung des Benutzers, dem der virtuelle Pfad gehört.

    **gid**
    : Eine lange ganze Zahl, die Kennung der Benutzergruppe, zu der der virtuelle Pfad gehört.

    **size**
    : Eine lange ganze Zahl, die wirkliche Größe des virtuellen Pfads in Bytes.

    **atime**
    : Eine lange ganze Zahl, der Zeitpunkt des letzten Zugriffs auf den Pfad, in Sekunden seit der Epoche. Der Befehl **clock format** macht daraus ein lesbares Datum.

    **mtime**
    : Eine lange ganze Zahl, der Zeitpunkt der letzten Änderung des Pfads, in Sekunden seit der Epoche. Der Befehl **clock format** macht daraus ein lesbares Datum.

    **ctime**
    : Eine lange ganze Zahl, der Zeitpunkt, zu dem der Pfad angelegt wurde, in Sekunden seit der Epoche. Der Befehl **clock format** macht daraus ein lesbares Datum.

    **type**
    : Eine Zeichenkette, entweder **directory** oder **file**, die den Typ des Pfads beschreibt.


**vfshandler** **utime** *root* *relative* *actualpath* *actime* *mtime*
: Setzt Zugriffs- und Änderungszeit der angegebenen Datei. Gelesen werden sie mit **stat**.


# Handler-Umgebung

Die Umsetzung eines Dateisystem-Handlers kann sich auf die folgenden Hilfsbefehle stützen:

**vfs::accessMode** *mode*
: Dieser Befehl wandelt einen Zugriffsmodus *mode* als ganze Zahl in eine Zeichenkette um, eine von **F**, **X**, **W**, **XW**, **R**, **RX** und **RW**.

**vfs::matchDirectories** *types*
: Prüft, ob die Glob-Typangabe Verzeichnisse einschließen will. Das Ergebnis ist boolesch. **true** kommt zurück, wenn types Verzeichnisse verlangt, sonst **false**.

**vfs::matchFiles** *types*
: Prüft, ob die Glob-Typangabe Dateien einschließen will. Das Ergebnis ist boolesch. **true** kommt zurück, wenn types Dateien verlangt, sonst **false**.

**vfs::matchCorrectTypes** *types* *filelist* ?*inDir*?
: Gibt den Teil der *filelist* zurück, der zu den angegebenen *types* passt. Die Elemente von *filelist* sind absolute Pfade oder Namen von Dateien im Verzeichnis *indir*. Die zweite Lesart gilt genau dann, wenn das Argument *indir* angegeben ist.


# Fehlersuche im Dateisystem

Zum Untersuchen eines Problems in der Umsetzung eines Dateisystems dient der Code unten. Er trägt den Befehl **report** als Fehlerbehandler des Dateisystems ein. Der gibt den Fehlerstapel aus, den Tcl liefert.

```
vfs::filesystem internalerror report

proc report {} {
    puts stderr $::errorInfo
}
```

# Copyright

```
Copyright (c) 2001-2003 Vince Darley <vincentdarley@users.sourceforge.net>
Copyright (c) 2003 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
