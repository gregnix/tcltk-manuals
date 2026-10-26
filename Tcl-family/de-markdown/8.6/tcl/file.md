---
CommandName: file
ManualSection: n
Version: 8.3
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - filename(n)
 - open(n)
 - close(n)
 - eof(n)
 - gets(n)
 - tell(n)
 - seek(n)
 - fblocked(n)
 - flush(n)
Keywords:
 - attributes
 - copy files
 - delete files
 - directory
 - file
 - move files
 - name
 - rename files
 - stat
 - user
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# NAME

file - Manipuliert Dateinamen und Dateiattribute

# ÜBERSICHT

::: {.synopsis} :::
[file]{.cmd} [option]{.arg} [name]{.arg} [arg arg]{.optdot} 
:::

# BESCHREIBUNG

Dieser Befehl stellt mehrere Operationen am Namen oder den Attributen einer Datei bereit. *Name* ist der Name einer Datei; beginnt er mit einer Tilde, wird vor Ausführung des Befehls eine Tilden-Substitution durchgeführt (Details in der Manpage **filename**). *Option* gibt an, was mit dem Dateinamen geschehen soll. Jede eindeutige Abkürzung für *option* ist zulässig. Die gültigen Optionen sind:

**file atime** *name* ?*time*?
: Gibt eine Dezimalzeichenkette zurück, die den Zeitpunkt angibt, zu dem auf die Datei *name* zuletzt zugegriffen wurde. Ist *time* angegeben, handelt es sich um eine Zugriffszeit, die für die Datei gesetzt werden soll. Die Zeit wird in der üblichen POSIX-Weise als Sekunden seit einem festen Startzeitpunkt (oft der 1. Januar 1970) gemessen. Existiert die Datei nicht oder kann ihre Zugriffszeit weder abgefragt noch gesetzt werden, wird ein Fehler erzeugt. Unter Windows unterstützen FAT-Dateisysteme keine Zugriffszeit.

**file attributes** *name*
: ...siehe nächstes...

**file attributes** *name* ?*option*?
: ...siehe nächstes...

**file attributes** *name* ?*option value option value...*?
: Dieser Unterbefehl gibt plattformspezifische Werte zurück, die mit einer Datei verknüpft sind, oder setzt sie. Die erste Form gibt eine Liste der plattformspezifischen Optionen und ihrer Werte zurück. Die zweite Form gibt den Wert für die angegebene Option zurück. Die dritte Form setzt einen oder mehrere der Werte. Die Werte sind wie folgt:
    Unter Unix liest oder setzt **-group** den Gruppennamen der Datei. Dem Befehl kann eine Gruppen-ID übergeben werden; zurückgegeben wird jedoch ein Gruppenname. **-owner** liest oder setzt den Benutzernamen des Dateibesitzers. Der Befehl gibt den Besitzernamen zurück; beim Setzen des Besitzers kann die numerische ID übergeben werden. **-permissions** liest oder setzt die Zugriffsrechte einer Datei, standardmäßig in Oktalnotation. Diese Option unterstützt außerdem eingeschränkt das Setzen von Rechten mit der vom Befehl **chmod** akzeptierten symbolischen Notation gemäß der Form [**ugo**]?[[**+-=**][**rwxst**]**,**[...]]. Mehrere Rechtsspezifikationen können durch Kommas getrennt angegeben werden. Z. B. würde **u+s,go-rw** das setuid-Bit für den Besitzer der Datei setzen sowie Lese- und Schreibrechte für Gruppe und andere entfernen. Eine **ls**-artige Zeichenkette der Form **rwxrwxrwx** wird ebenfalls akzeptiert, muss aber immer 9 Zeichen lang sein. Z. B. ist **rwxr-xr-t** äquivalent zu **01755**. Auf Unix-Versionen mit Dateiflags gibt **-readonly** den Wert des schreibgeschützten Attributs einer Datei zurück oder setzt bzw. löscht es, d. h. das Benutzer-Immutable-Flag (**uchg**) des Befehls **chflags**.
    Unter Windows liefert **-archive** den Wert oder setzt bzw. löscht das Archiv-Attribut der Datei. **-hidden** liefert den Wert oder setzt bzw. löscht das versteckte Attribut der Datei. **-longname** erweitert jedes Pfadelement auf seine Langversion. Dieses Attribut kann nicht gesetzt werden. **-readonly** liefert den Wert oder setzt bzw. löscht das schreibgeschützte Attribut der Datei. **-shortname** liefert eine Zeichenkette, in der jedes Pfadelement nach Möglichkeit durch seine kurze (8.3-)Version des Namens ersetzt wird. Pfadelemente, die keiner Kurzform zugeordnet werden können, behalten den langen Namen. Dieses Attribut kann nicht gesetzt werden. **-system** liefert den Wert oder setzt bzw. löscht das System-Attribut der Datei.
    Unter macOS und Darwin liefert oder setzt **-creator** den Finder-Erstellertyp der Datei. **-hidden** liefert den Wert oder setzt bzw. löscht das versteckte Attribut der Datei. **-readonly** liefert den Wert oder setzt bzw. löscht das schreibgeschützte Attribut der Datei. **-rsrclength** gibt die Länge des Resource Fork der Datei an; dieses Attribut kann nur auf den Wert 0 gesetzt werden, wodurch der Resource Fork von der Datei entfernt wird.

**file channels** ?*pattern*?
: Ist *pattern* nicht angegeben, gibt der Befehl eine Liste der Namen aller in diesem Interpreter registrierten offenen Kanäle zurück. Ist *pattern* angegeben, werden nur Namen zurückgegeben, die zu *pattern* passen. Die Übereinstimmung erfolgt nach denselben Regeln wie bei **string match**.

**file copy** ?**-force**? ?**-\|-**? *source* *target*
: ...siehe nächstes...

**file copy** ?**-force**? ?**-\|-**? *source* ?*source* ...? *targetDir*
: Die erste Form erstellt eine Kopie der Datei oder des Verzeichnisses *source* unter dem Pfadnamen *target*. Ist *target* ein vorhandenes Verzeichnis, wird die zweite Form verwendet. Die zweite Form kopiert jede aufgeführte *source*-Datei in *targetDir*. Wird ein Verzeichnis als *source* angegeben, werden dessen Inhalte rekursiv nach *targetDir* kopiert. Vorhandene Dateien werden nicht überschrieben, sofern die Option **-force** nicht angegeben ist (dann versucht Tcl außerdem, die Berechtigungen der Zieldatei oder des Zielverzeichnisses anzupassen, falls das zum Fortsetzen der Kopie nötig ist). Beim Kopieren innerhalb eines einzelnen Dateisystems kopiert *file copy* symbolische Links (d. h. die Links selbst, nicht die Ziele). Der Versuch, ein nicht leeres Verzeichnis zu überschreiben, ein Verzeichnis mit einer Datei zu überschreiben oder eine Datei mit einem Verzeichnis zu überschreiben, führt auch bei **-force** zu Fehlern. Die Argumente werden in der angegebenen Reihenfolge verarbeitet und beim ersten Fehler abgebrochen. Ein **-\|-** markiert das Ende der Schalter; das Argument nach **-\|-** wird als *source* behandelt, auch wenn es mit **-** beginnt.

**file delete** ?**-force**? ?**-\|-**? ?*pathname* ... ?
: Entfernt die Datei oder das Verzeichnis, das von jedem Argument *pathname* angegeben wird. Nicht leere Verzeichnisse werden nur entfernt, wenn die Option **-force** angegeben ist. Bei symbolischen Links werden die Links selbst gelöscht, nicht die Ziele. Das Löschen einer nicht existierenden Datei gilt nicht als Fehler. Beim Löschen einer schreibgeschützten Datei wird die Datei gelöscht, auch wenn **-force** nicht angegeben ist. Ist **-force** für ein Verzeichnis angegeben, versucht Tcl sowohl, die Berechtigungen zu ändern, als auch das aktuelle Arbeitsverzeichnis „pwd“ aus dem angegebenen Pfad herauszubewegen, falls das zum Löschen nötig ist. Die Argumente werden in der angegebenen Reihenfolge verarbeitet und beim ersten Fehler abgebrochen. Ein **-\|-** markiert das Ende der Schalter; das Argument nach **-\|-** wird als *pathname* behandelt, auch wenn es mit **-** beginnt.

**file dirname** *name*
: Gibt einen Namen zurück, der aus allen Pfadkomponenten in *name* ohne das letzte Element besteht. Ist *name* ein relativer Dateiname und enthält nur ein Pfadelement, wird „**.**“ zurückgegeben. Verweist *name* auf ein Stammverzeichnis, wird das Stammverzeichnis zurückgegeben. Beispiel:

    ```
    file dirname c:/
    ```
    gibt **c:/** zurück.
    Beachten Sie, dass eine Tilden-Substitution nur durchgeführt wird, wenn sie zum Vervollständigen des Befehls nötig ist. Beispiel:

    ```
    file dirname ~/src/foo.c
    ```
    gibt **~/src** zurück, wohingegen

    ```
    file dirname ~
    ```
    **/home** (oder etwas Ähnliches) zurückgibt.

**file executable** *name*
: Gibt **1** zurück, wenn die Datei *name* für den aktuellen Benutzer ausführbar ist, sonst **0**. Unter Windows, wo es kein Ausführbarkeitsattribut gibt, behandelt der Befehl alle Verzeichnisse und Dateien mit den Erweiterungen **exe**, **com**, **cmd** oder **bat** als ausführbar.

**file exists** *name*
: Gibt **1** zurück, wenn die Datei *name* existiert und der aktuelle Benutzer Suchrechte für die führenden Verzeichnisse hat, sonst **0**.

**file extension** *name*
: Gibt alle Zeichen in *name* nach und einschließlich des letzten Punkts im letzten Element von *name* zurück. Enthält das letzte Element von *name* keinen Punkt, wird die leere Zeichenkette zurückgegeben.

**file isdirectory** *name*
: Gibt **1** zurück, wenn *name* ein Verzeichnis ist, sonst **0**.

**file isfile** *name*
: Gibt **1** zurück, wenn *name* eine reguläre Datei ist, sonst **0**.

**file join** *name* ?*name ...*?
: Nimmt einen oder mehrere Dateinamen und verbindet sie mit dem für die aktuelle Plattform korrekten Pfadtrennzeichen. Ist ein bestimmter *name* relativ, wird er an das vorherige Dateinamenargument angehängt. Andernfalls werden frühere Argumente verworfen, und die Verknüpfung setzt beim aktuellen Argument fort. Beispiel:

    ```
    file join a b /foo bar
    ```
    gibt **/foo/bar** zurück.
    Beachten Sie, dass die Namen Trennzeichen enthalten können und das Ergebnis für die aktuelle Plattform stets kanonisch ist: **/** unter Unix und Windows.

**file link** ?*-linktype*? *linkName* ?*target*?
: Wird nur ein Argument übergeben, wird dieses als *linkName* angenommen, und der Befehl gibt den Wert des Links *linkName* zurück (d. h. den Namen der Datei, auf die er verweist). Ist *linkName* kein Link oder kann sein Wert nicht gelesen werden (wie z. B. bei Hardlinks, die wie normale Dateien aussehen), wird ein Fehler zurückgegeben.
    Werden zwei Argumente übergeben, werden diese als *linkName* und *target* angenommen. Existiert *linkName* bereits oder existiert *target* nicht, wird ein Fehler zurückgegeben. Andernfalls erstellt Tcl einen neuen Link *linkName*, der auf das vorhandene Dateisystemobjekt bei *target* verweist (dies ist auch der Rückgabewert); der Linktyp ist plattformspezifisch (unter Unix standardmäßig ein symbolischer Link). Das ist nützlich, wenn der Benutzer einen Link plattformübergreifend anlegen will, ohne den konkreten Linktyp zu kennen.
    Soll nur ein Link eines bestimmten Typs erstellt werden (mit Fehler, falls das nicht möglich ist), ist das optionale Argument *-linktype* anzugeben. Zulässige Werte für *-linktype* sind „**-symbolic**“ und „**-hard**“.
    Unter Unix können symbolische Links auf relative Pfade zeigen; diese Pfade müssen relativ zum tatsächlichen Speicherort von *linkName* sein (nicht zum aktuellen Arbeitsverzeichnis). Auf allen anderen Plattformen ohne Unterstützung relativer Links werden Zielpfade vor dem Anlegen des Links stets in absolute, normalisierte Form umgewandelt (relative Pfade beziehen sich also auf das aktuelle Arbeitsverzeichnis). Außerdem werden „~user“-Pfade stets in absolute Form erweitert. Beim Anlegen von Links auf Dateisystemen, die keine Links oder nicht den angeforderten Typ unterstützen, wird eine Fehlermeldung zurückgegeben. Die meisten Unix-Plattformen unterstützen symbolische und Hardlinks (letztere nur für Dateien). Windows unterstützt symbolische Verzeichnislinks und Hardlinks für Dateien auf NTFS-Laufwerken.

**file lstat** *name varName*
: Entspricht der Option **stat** (siehe unten), verwendet jedoch den Kernel-Aufruf *lstat* statt *stat*. Verweist *name* auf einen symbolischen Link, beziehen sich die in *varName* zurückgegebenen Informationen auf den Link, nicht auf die Zieldatei. Auf Systemen ohne symbolische Links verhält sich diese Option genau wie **stat**.

**file mkdir** ?*dir* ...?
: Erstellt jedes angegebene Verzeichnis. Für jeden angegebenen Pfadnamen *dir* legt der Befehl alle nicht vorhandenen übergeordneten Verzeichnisse sowie *dir* selbst an. Ist ein vorhandenes Verzeichnis angegeben, erfolgt keine Aktion und kein Fehler. Der Versuch, eine vorhandene Datei mit einem Verzeichnis zu überschreiben, führt zu einem Fehler. Die Argumente werden in der angegebenen Reihenfolge verarbeitet und beim ersten Fehler abgebrochen.

**file mtime** *name* ?*time*?
: Gibt eine Dezimalzeichenkette zurück, die den Zeitpunkt der letzten Änderung der Datei *name* angibt. Ist *time* angegeben, handelt es sich um eine Änderungszeit, die für die Datei gesetzt werden soll (entspricht Unix **touch**). Die Zeit wird in der üblichen POSIX-Weise als Sekunden seit einem festen Startzeitpunkt (oft der 1. Januar 1970) gemessen. Existiert die Datei nicht oder kann ihre Änderungszeit weder abgefragt noch gesetzt werden, wird ein Fehler erzeugt.

**file nativename** *name*
: Gibt den plattformspezifischen Namen der Datei zurück. Das ist nützlich, wenn der Dateiname an einen plattformspezifischen Aufruf übergeben werden muss, z. B. an einen Unterprozess über **exec** unter Windows (siehe **BEISPIELE** unten).

**file normalize** *name*
: Gibt eine eindeutige normalisierte Pfaddarstellung für das Dateisystemobjekt (Datei, Verzeichnis, Link usw.) zurück, deren Zeichenkettenwert als eindeutiger Bezeichner verwendet werden kann. Ein normalisierter Pfad ist ein absoluter Pfad ohne „../“ und „./“. Außerdem liegt er im „Standard“-Format der nativen Plattform. Unter Unix bedeutet das, dass die Segmente bis zum Pfad frei von symbolischen Links/Aliasen sein müssen (das letzte Pfadelement darf ein symbolischer Link sein); unter Windows wird außerdem die lange Form mit deren groß-/kleinschreibungsabhängiger Darstellung gewünscht (eindeutiger, fallabhängiger Pfad). Die Ausnahme für das letzte Link-Element im Pfad ist nötig, weil Tcl oder der Benutzer auf den symbolischen Link selbst operieren können (z. B. sind **file delete**, **file rename** und **file copy** für symbolische Links definiert, nicht für deren Ziele).

**file owned** *name*
: Gibt **1** zurück, wenn die Datei *name* dem aktuellen Benutzer gehört, sonst **0**.

**file pathtype** *name*
: Gibt einen der Werte **absolute**, **relative**, **volumerelative** zurück. Verweist *name* auf eine bestimmte Datei auf einem bestimmten Volume, ist der Pfadtyp **absolute**. Verweist *name* relativ zum aktuellen Arbeitsverzeichnis, ist der Typ **relative**. Verweist *name* relativ zum aktuellen Arbeitsverzeichnis auf einem angegebenen Volume oder auf eine bestimmte Datei auf dem aktuellen Arbeits-Volume, ist der Typ **volumerelative**.

**file readable** *name*
: Gibt **1** zurück, wenn die Datei *name* für den aktuellen Benutzer lesbar ist, sonst **0**.

**file readlink** *name*
: Gibt den Wert des symbolischen Links *name* zurück (d. h. den Namen der Zieldatei). Ist *name* kein symbolischer Link oder kann sein Wert nicht gelesen werden, wird ein Fehler zurückgegeben. Auf Systemen ohne symbolische Links ist diese Option nicht definiert.

**file rename** ?**-force**? ?**-\|-**? *source* *target*
: ...siehe nächstes...

**file rename** ?**-force**? ?**-\|-**? *source* ?*source* ...? *targetDir*
: Die erste Form benennt die Datei oder das Verzeichnis *source* in *target* um und verschiebt sie, wenn *target* einen Namen in einem anderen Verzeichnis angibt. Ist *target* ein vorhandenes Verzeichnis, wird die zweite Form verwendet. Die zweite Form verschiebt jede *source*-Datei oder jedes *source*-Verzeichnis in *targetDir*. Vorhandene Dateien werden nicht überschrieben, sofern **-force** nicht angegeben ist. Innerhalb eines einzelnen Dateisystems benennt Tcl symbolische Links um, nicht deren Ziele. Der Versuch, ein nicht leeres Verzeichnis zu überschreiben, ein Verzeichnis mit einer Datei zu überschreiben oder eine Datei mit einem Verzeichnis zu überschreiben, führt zu Fehlern. Die Argumente werden in der angegebenen Reihenfolge verarbeitet und beim ersten Fehler abgebrochen. Ein **-\|-** markiert das Ende der Schalter; das Argument nach **-\|-** wird als *source* behandelt, auch wenn es mit **-** beginnt.

**file rootname** *name*
: Gibt alle Zeichen in *name* bis, aber ohne das letzte „.“-Zeichen im letzten Komponenten von *name* zurück. Enthält die letzte Komponente von *name* keinen Punkt, wird *name* zurückgegeben.

**file separator** ?*name*?
: Ohne Argument gibt der Befehl das Zeichen zurück, das Pfadsegmente nativer Dateien auf dieser Plattform trennt. Ist ein Pfad angegeben, wird das zuständige Dateisystem nach seinem Trennzeichen befragt. Akzeptiert kein Dateisystem *name*, wird ein Fehler erzeugt.

**file size** *name*
: Gibt eine Dezimalzeichenkette mit der Größe der Datei *name* in Byte zurück. Existiert die Datei nicht oder kann ihre Größe nicht abgefragt werden, wird ein Fehler erzeugt.

**file split** *name*
: Gibt eine Liste zurück, deren Elemente die Pfadkomponenten in *name* sind. Das erste Element hat denselben Pfadtyp wie *name*. Alle weiteren Elemente sind relativ. Pfadtrennzeichen werden verworfen, sofern sie nicht nötig sind, um ein Element eindeutig relativ zu machen. Beispiel unter Unix:

    ```
    file split /foo/~bar/baz
    ```
    gibt „**/\0\0foo\0\0./~bar\0\0baz**“ zurück, damit spätere Befehle mit der dritten Komponente keine Tilden-Substitution versuchen.

**file stat**  *name varName*
: Ruft den Kernel-Aufruf **stat** für *name* auf und verwendet die Variable *varName*, um die vom Kernel zurückgegebenen Informationen zu halten. *VarName* wird als Array-Variable behandelt; folgende Elemente werden gesetzt: **atime**, **ctime**, **dev**, **gid**, **ino**, **mode**, **mtime**, **nlink**, **size**, **type**, **uid**. Jedes Element außer **type** ist eine Dezimalzeichenkette mit dem Wert des entsprechenden Felds aus der **stat**-Rückgabestruktur; Details zu den Bedeutungen stehen in der Manpage **stat**. Das Element **type** gibt den Dateityp in derselben Form zurück wie der Befehl **file type**. Der Befehl gibt die leere Zeichenkette zurück.

**file system** *name*
: Gibt eine Liste mit einem oder zwei Elementen zurück: das erste ist der Name des für die Datei zu verwendenden Dateisystems, das zweite (falls vorhanden) eine beliebige Zeichenkette für die dateisystemspezifische Art oder den Typ des Speicherorts innerhalb dieses Dateisystems. Unterstützt ein Dateisystem nur einen Dateityp, fehlt das zweite Element möglicherweise. Native Dateien haben z. B. als erstes Element „native“ und als zweites (falls vorhanden) einen plattformspezifischen Typnamen (z. B. „NTFS“, „FAT“ unter Windows). Ein generisches virtuelles Dateisystem könnte „vfs ftp“ zurückgeben für eine Datei auf einer per Erweiterung „vfs“ eingehängten FTP-Site. Gehört die Datei keinem Dateisystem an, wird ein Fehler erzeugt.

**file tail** *name*
: Gibt alle Zeichen der letzten Dateisystemkomponente von *name* zurück. Ein abschließender Verzeichnistrenner in *name* wird ignoriert. Enthält *name* keine Trennzeichen, wird *name* zurückgegeben. Also liefern **file tail a/b**, **file tail a/b/** und **file tail b** alle **b**.

**file tempfile** ?*nameVar*? ?*template*?
: Erstellt eine temporäre Datei und gibt einen Lese-Schreib-Kanal zurück, der auf dieser Datei geöffnet ist. Ist *nameVar* angegeben, wird der Name der temporären Datei in diese Variable geschrieben; fehlt sie, versucht Tcl, die temporäre Datei zu löschen, sobald sie nicht mehr benötigt wird. Ist *template* vorhanden, legt es Teile der Vorlage des Dateinamens fest (z. B. Verzeichnis, Basisname oder Erweiterung); einige Plattformen ignorieren Teile davon und verwenden einen eingebauten Standard.

::: {.info -version="8.6"}
Temporäre Dateien werden *nur* auf dem nativen Dateisystem erstellt. Sie eignen sich daher für Betriebssystem-APIs und externe Programme, die einen Dateinamen benötigen.
:::

**file type** *name*
: Gibt eine Zeichenkette mit dem Typ der Datei *name* zurück: **file**, **directory**, **characterSpecial**, **blockSpecial**, **fifo**, **link** oder **socket**.

**file volumes**
: Gibt die absoluten Pfade der im System eingehängten Volumes als ordentliche Tcl-Liste zurück. Ohne virtuelle Dateisysteme als Stamm-Volumes liefert der Befehl unter UNIX stets „/“, da alle Dateisysteme lokal eingehängt sind. Unter Windows liefert er eine Liste der verfügbaren lokalen Laufwerke (z. B. „a:/ c:/“). Hat ein virtuelles Dateisystem weitere Volumes eingehängt, erscheinen diese in der Liste.

**file writable** *name*
: Gibt **1** zurück, wenn die Datei *name* für den aktuellen Benutzer beschreibbar ist, sonst **0**.


# PORTABILITÄTSFRAGEN

**Unix**\0\0\0\0\0\0\0
: Diese Befehle arbeiten stets mit den realen Benutzer- und Gruppen-IDs, nicht mit den effektiven.

**Windows**\0\0\0\0
: Der Unterbefehl **file owned** verwendet die Benutzer-ID (SID) des Prozess-Tokens, nicht das Thread-Token, das möglicherweise einen anderen Benutzer impersoniert.


# BEISPIELE

Diese Prozedur zeigt, wie in einem Verzeichnis nach C-Dateien gesucht wird, zu denen im aktuellen Verzeichnis eine gleichnamige Objektdatei existiert:

```
proc findMatchingCFiles {dir} {
    set files {}
    switch $::tcl_platform(platform) {
        windows {
            set ext .obj
        }
        unix {
           set ext .o
        }
    }
    foreach file [glob \-nocomplain \-directory $dir *.c] {
        set objectFile [file tail [file rootname $file]]$ext
        if {[file exists $objectFile]} {
            lappend files $file
        }
    }
    return $files
}
```

Eine Datei umbenennen und einen symbolischen Link vom alten zum neuen Ort hinterlassen:

```
set oldName foobar.txt
set newName foo/bar.txt
# Sicherstellen, dass das Zielverzeichnis existiert...
if {![file isdirectory [file dirname $newName]]} {
    file mkdir [file dirname $newName]
}
file rename $oldName $newName
file link \-symbolic $oldName $newName
```

Unter Windows kann eine Datei leicht „gestartet“ werden (entspricht Doppelklick im Explorer), der an das Betriebssystem übergebene Name muss jedoch im nativen Format vorliegen:

```
exec {*}[auto_execok start] {} [file nativename ~/example.txt]
```
