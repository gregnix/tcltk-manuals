---
CommandName: tm
title: tm
ManualSection: n
Version: 8.5
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - package(n)
 - "Tcl Improvement Proposal #189 \"Tcl Modules\" (online at https://core.tcl-lang.org/tips/doc/trunk/tip/189.md)"
 - "Tcl Improvement Proposal #190 \"Implementation Choices for Tcl Modules\" (online at https://core.tcl-lang.org/tips/doc/trunk/tip/190.md)"
Keywords:
 - modules
 - package
Copyright:
 - Copyright (c) 2004-2010 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

tm - Einrichtungen zum Auffinden und Laden von Tcl-Modulen

# Übersicht

::: {.synopsis} :::
[::tcl::tm::path]{.cmd} [add]{.sub} [path]{.optdot}
[::tcl::tm::path]{.cmd} [remove]{.sub} [path]{.optdot}
[::tcl::tm::path]{.cmd} [list]{.sub}
[::tcl::tm::roots]{.cmd} [paths]{.arg}
:::

# Beschreibung

Dieses Dokument beschreibt die Einrichtungen zum Auffinden und Laden von Tcl-Modulen (siehe [Moduldefinition] für die Definition eines Tcl-Moduls). Folgende Befehle werden unterstützt:

[::tcl::tm::path]{.cmd} [add]{.sub} [path]{.optdot}
: Die Pfade werden in der Reihenfolge ihres Auftretens am Kopf der Liste der Modulpfade eingefügt. Das bedeutet, dass das letzte Argument zum neuen Kopf der Liste wird.

    Der Befehl erzwingt die Einschränkung, dass kein Pfad ein Vorfahrenverzeichnis eines anderen Pfads in der Liste sein darf. Verletzt einer der neuen Pfade diese Einschränkung, wird ein Fehler ausgelöst, bevor Pfade hinzugefügt wurden. Mit anderen Worten: Verletzt nur ein Pfadargument die Einschränkung, wird keiner hinzugefügt.

    Ist ein Pfad bereits unverändert vorhanden, wird kein Fehler ausgelöst und keine Aktion ausgeführt.

    Pfade werden später in der Reihenfolge ihres Auftretens in der Liste durchsucht. Da sie am Anfang der Liste eingefügt werden, werden sie in umgekehrter Reihenfolge der Hinzufügung durchsucht. Mit anderen Worten: Zuletzt hinzugefügte Pfade werden zuerst betrachtet.

[::tcl::tm::path]{.cmd} [remove]{.sub} [path]{.optdot}
: Entfernt die Pfade aus der Liste der Modulpfade. Der Befehl ignoriert still alle Pfade, die nicht in der Liste stehen.

[::tcl::tm::path]{.cmd} [list]{.sub}
: Gibt eine Liste aller registrierten Modulpfade in der Reihenfolge zurück, in der nach Modulen gesucht wird.

[::tcl::tm::roots]{.cmd} [paths]{.arg}
: Ähnlich wie **path add** und darauf aufbauend. Dieser Befehl nimmt ein einzelnes Argument mit einer Liste von Pfaden, erweitert jeden um „**tcl***X***/site-tcl**“ und „**tcl***X***/***X***.***y*“ für die Hauptversion *X* des Tcl-Interpreters und die Nebenversion *y* kleiner oder gleich der Nebenversion des Interpreters und fügt die resultierende Menge von Pfaden der Suchliste hinzu.

    Dieser Befehl wird intern vom System verwendet, um die systemspezifischen Standardpfade einzurichten.

    Der Befehl wurde exponiert, damit ein Build-System zusätzliche Wurzelpfade über die in diesem Dokument beschriebenen hinaus definieren kann.


# Moduldefinition

Ein Tcl-Modul ist ein Tcl-Paket in einer einzigen Datei, ohne weitere von ihm benötigte Dateien. Diese Datei muss [source]-bar sein. Mit anderen Worten wird ein Tcl-Modul immer so importiert:

```
source module_file
```

Der Befehl [load] wird nicht direkt verwendet. Diese Einschränkung ist keine tatsächliche Begrenzung, wie manche glauben mögen. Seit 8.4 liest der Tcl-Befehl [source] nur bis zum ersten ^Z-Zeichen. So können ein beliebiges Tcl-Skript und beliebige Binärdaten in einer Datei kombiniert werden, wobei das Skript die angehängten Daten nach Belieben verarbeitet, um das Paket vollständig zu importieren und zu aktivieren.

Der Name einer Moduldatei muss dem regulären Ausdruck entsprechen:

```
([_[:alpha:]][:_[:alnum:]]*)-([[:digit:]].*)\.tm
```

Die erste erfassende Klammer liefert den Paketnamen, die zweite seine Version. Zusätzlich zum Muster muss die extrahierte Versionsnummer keinen Fehler erzeugen, wenn sie im Befehl verwendet wird:

```
package vcompare $version 0
```

# Modulsuche

Der Verzeichnisbaum zum Speichern von Tcl-Modulen ist vom übrigen Dateisystem getrennt und unabhängig von [auto\_path][tclvars].

Tcl-Module werden in allen Verzeichnissen gesucht, die in der Rückgabe von **::tcl::tm::path list** aufgeführt sind. Dies wird der *Modulpfad* genannt. Weder [auto\_path][tclvars] noch die Variable [tcl\_pkgPath][tclvars] werden verwendet. Alle Verzeichnisse auf dem Modulpfad müssen eine Einschränkung einhalten:

Für je zwei Verzeichnisse ist keines ein Vorfahrenverzeichnis des anderen.

Das ist nötig, um Mehrdeutigkeiten bei Paketnamen zu vermeiden. Wären beispielsweise die beiden Verzeichnisse „*foo/*“ und „*foo/cool*“ auf dem Pfad, könnte ein Paket **cool::ice** über die Namen **cool::ice** oder **ice** gefunden werden; letzteres könnte ein unqualifiziertes Paket **ice** verdecken.

Vor Beginn der Suche wird der Name des angeforderten Pakets mit folgendem Algorithmus in einen Teilpfad übersetzt:

Alle Vorkommen von „**::**“ im Paketnamen werden durch das passende Verzeichnistrennzeichen der Plattform ersetzt. Unter Unix ist das beispielsweise „**/**“.

Beispiel:

Das angeforderte Paket ist **encoding::base64**. Der erzeugte Teilpfad ist „*encoding/base64*“.

Danach wird das Paket in allen Modulpfaden gesucht, indem sie nacheinander, vom ersten zum letzten, mit dem Teilpfad zu einem vollständigen Suchmuster kombiniert werden. Der Suchalgorithmus verwirft alle Dateien, deren Dateiname nicht dem regulären Ausdruck im Abschnitt [Moduldefinition] entspricht. Für die übrigen Dateien werden *provide scripts* erzeugt und der Paket-ifneeded-Datenbank hinzugefügt.

Der Algorithmus fällt auf den vorherigen unknown-Handler zurück, wenn keine gefundene Moduldatei die Anfrage erfüllt. Wurde die Anfrage erfüllt, wird der Fallback ignoriert.

Beachten Sie, dass Pakete in Modulform *keine* Kontrolle über die in die Paketdatenbank eingetragenen *index*- und *provide script*s haben. Für eine Moduldatei **MF** ist das *index script* immer:

```
package ifneeded PNAME PVERSION [list source MF]
```

und das darin eingebettete *provide script* ist:

```
source MF
```

Sowohl Paketname **PNAME** als auch Paketversion **PVERSION** werden aus dem Dateinamen **MF** wie folgt extrahiert:

```
MF = /module_path/PNAME'-PVERSION.tm
```

Dabei ist **PNAME'** der Teilpfad des Moduls wie im Abschnitt [Modulsuche] definiert und wird in **PNAME** übersetzt, indem alle Verzeichnistrennzeichen durch „**::**“ ersetzt werden; **module\_path** ist der Pfad (aus der Suchliste), unter dem die Moduldatei gefunden wurde.

Beachten Sie außerdem, dass hier eine Verbindung zwischen Paketnamen und Pfaden entsteht. Tcl vergleicht Paketnamen case-sensitiv, es gibt jedoch Dateisysteme, die das nicht tun, wie NTFS. Glücklicherweise speichern diese Dateisysteme die Groß-/Kleinschreibung des Namens, obwohl sie die Information beim Vergleichen nicht nutzen.

Daraus erlauben wir gemischte Schreibweise für Paketnamen in Tcl-Modulen, verlangen aber, dass es keine Kollisionen gibt, wenn Namen case-insensitiv verglichen werden. Ist ein Paket **Foo** als Tcl-Modul bereitgestellt, sind Pakete wie **foo**, **fOo** usw. nicht mehr erlaubt.

# Standardpfade

Die Standardliste der Pfade auf dem Modulpfad wird von einer [tclsh] wie folgt berechnet, wobei *X* die Hauptversion des Tcl-Interpreters und *y* kleiner oder gleich der Nebenversion des Tcl-Interpreters ist.

Alle Standardpfade werden dem Modulpfad hinzugefügt, auch nicht existierende. Nicht existierende Pfade werden bei tatsächlichen Suchen herausgefiltert. So kann ein Benutzer einen der durchsuchten Pfade bei Bedarf anlegen, und alle laufenden Anwendungen übernehmen automatisch dort abgelegte Module.

Die Pfade werden in der unten aufgeführten Reihenfolge hinzugefügt; bei Listen aus Umgebungsvariablen in der Reihenfolge, in der sie in der Variable vorkommen.

## Systemspezifische Pfade

**file normalize \[info library\]/../tcl***X***/***X***.***y*
: Mit anderen Worten sucht der Interpreter in einem Verzeichnis, das durch seine Hauptversion festgelegt ist und dessen Nebenversionen kleiner oder gleich der Nebenversion des Interpreters sind.

    Für Tcl 8.4 werden beispielsweise folgende Pfade durchsucht:

    ```
    [info library]/../tcl8/8.4
    [info library]/../tcl8/8.3
    [info library]/../tcl8/8.2
    [info library]/../tcl8/8.1
    [info library]/../tcl8/8.0
    ```

    Diese Definition setzt voraus, dass ein für Tcl *X***.***y* definiertes Paket auch von allen Interpretern mit derselben Hauptnummer *X* und einer Nebennummer größer als *y* genutzt werden kann.

**file normalize EXEC/tcl***X***/***X***.***y*
: Dabei ist **EXEC** **file normalize \[info nameofexecutable\]/../lib** oder **file normalize \[::tcl::pkgconfig get libdir,runtime\]**

    Diese Pfadmenge wird wie die vorherige behandelt, außer dass sie in **EXEC\_PREFIX** verankert ist. Bei einem Build mit **PREFIX** = **EXEC\_PREFIX** sind beide Mengen identisch.


## Site-spezifische Pfade

**file normalize \[info library\]/../tcl***X***/site-tcl**
: Beachten Sie, dass dies immer ein einzelner Eintrag ist, weil *X* stets ein konkreter Wert ist (die aktuelle Hauptversion von Tcl).


## Benutzerspezifische Pfade

**$::env(TCL***X***\_***y***\_TM\_PATH)**
: Eine Liste von Pfaden, getrennt durch **:** (Unix) oder **;** (Windows). Das ist benutzer- und site-spezifisch, da diese Umgebungsvariable nicht nur im Benutzerprofil, sondern auch durch Systemkonfigurationsskripte gesetzt werden kann.

**$::env(TCL***X***.***y***\_TM\_PATH)**
: Gleiche Bedeutung und gleicher Inhalt wie die vorherige Variable. Die Verwendung von Punkt ‚.‘ zur Trennung von Haupt- und Nebenversion macht den Namen jedoch weniger bis nicht portabel; die Verwendung wird abgeraten. Die Unterstützung wurde nur aus Kompatibilität mit der ursprünglichen Spezifikation beibehalten, d. h. TIP 189.


Diese Pfade werden von allen Tcl-Shells im **$::env(PATH)** des Benutzers gesehen und damit geteilt.

Beachten Sie, dass *X* und *y* den oben genannten allgemeinen Regeln folgen. Tcl 9.1 betrachtet beispielsweise diese 4 Umgebungsvariablen:

```
$::env(TCL9.1_TM_PATH)  $::env(TCL9_1_TM_PATH)
$::env(TCL9.0_TM_PATH)  $::env(TCL9_0_TM_PATH)
```

Pfade aus Umgebungsvariablen unterliegen Tilde-Ersetzung (siehe [filename]). Jeder Pfad, bei dem die Tilde-Ersetzung fehlschlägt, weil der Benutzer unbekannt ist, wird von den Suchpfaden weggelassen.


[filename]: filename.md
[load]: load.md
[source]: source.md
[tclsh]: tclsh.md
[tclvars]: tclvars.md
