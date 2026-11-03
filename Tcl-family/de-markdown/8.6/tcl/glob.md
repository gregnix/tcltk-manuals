---
CommandName: glob
title: glob
ManualSection: n
Version: 8.3
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - file(n)
Keywords:
 - exist
 - file
 - glob
 - pattern
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

glob - Dateinamen zurückgeben, die Mustern entsprechen

# Übersicht

::: {.synopsis} :::
[glob]{.cmd} [switches]{.optarg} [pattern]{.optdot}
:::

# Beschreibung

Dieser Befehl führt ein „Globbing“ von Dateinamen durch, ähnlich wie die Shells csh oder bash. Er gibt eine Liste der Dateien zurück, deren Namen zu einem der *pattern*-Argumente passen. Eine bestimmte Reihenfolge der Liste ist nicht garantiert; wenn eine sortierte Liste benötigt wird, sollte der Aufrufer daher [lsort] verwenden.

## Optionen

Beginnen die ersten Argumente von **glob** mit **-**, werden sie als Schalter behandelt. Derzeit werden folgende Schalter unterstützt:

**-directory** *directory*
: Sucht ab dem angegebenen Verzeichnis *directory* nach Dateien, die zu den angegebenen Mustern passen. So lassen sich Verzeichnisse durchsuchen, deren Name für Glob bedeutsame Zeichen enthält, ohne dass diese Zeichen ausdrücklich maskiert werden müssen. Diese Option kann nicht zusammen mit **-path** verwendet werden; **-path** dient dazu, nach vollständigen Dateipfaden zu suchen, deren Namen für Glob bedeutsame Zeichen enthalten können.

**-join**
: Die nach der Verarbeitung der Optionen verbleibenden Musterargumente werden als ein einziges Muster behandelt, das entsteht, indem die Argumente mit Verzeichnistrennzeichen verbunden werden.

**-nocomplain**
: Erlaubt die Rückgabe einer leeren Liste ohne Fehler; ohne diesen Schalter wird ein Fehler zurückgegeben, wenn die Ergebnisliste leer wäre.

**-path** *pathPrefix*
: Sucht nach Dateien mit dem angegebenen *pathPrefix*, bei denen der Rest des Namens zu den angegebenen Mustern passt. So lässt sich nach Dateien suchen, deren Namen einer gegebenen Datei (im Gegensatz zu einem Verzeichnis) ähneln, auch wenn die Namen für Glob bedeutsame Zeichen enthalten. Diese Option kann nicht zusammen mit **-directory** verwendet werden. Um zum Beispiel alle Dateien zu finden, die denselben Stammnamen wie $path, aber andere Endungen haben, sollten Sie „**glob -path \[file rootname $path\] .\***“ verwenden; das funktioniert auch dann, wenn **$path** zahlreiche für Glob bedeutsame Zeichen enthält.

**-tails**
: Gibt von jeder gefundenen Datei nur den Teil zurück, der auf das letzte Verzeichnis folgt, das in einer Pfadangabe mit **-directory** oder **-path** genannt ist. Daher ist „**glob -tails -directory $dir \***“ gleichwertig mit „**set pwd \[pwd\]; cd $dir; glob \*; cd $pwd**“. Bei Angaben mit **-path** enthalten die zurückgegebenen Namen das letzte Pfadsegment. So gibt „**glob -tails -path \[file rootname ~/foo.tex\] .\***“ Pfade wie **foo.aux foo.bib foo.tex** usw. zurück.

**-types** *typeList*
: Listet nur Dateien oder Verzeichnisse auf, die zu *typeList* passen; die Elemente dieser Liste können zwei Formen haben. Die erste Form entspricht der Option -type des Unix-Befehls find: *b* (blockorientierte Gerätedatei), *c* (zeichenorientierte Gerätedatei), *d* (Verzeichnis), *f* (normale Datei), *l* (symbolischer Link), *p* (Named Pipe) oder *s* (Socket); in der Liste können mehrere Typen angegeben werden. **Glob** gibt alle Dateien zurück, die zu mindestens einem der angegebenen Typen passen. Beachten Sie, dass symbolische Links sowohl dann zurückgegeben werden, wenn **-types l** angegeben ist, als auch dann, wenn das Ziel eines Links dem gewünschten Typ entspricht. Ein Link auf ein Verzeichnis wird also zurückgegeben, wenn **-types d** angegeben wurde.

    Die zweite Form gibt Typen an, die alle zutreffen müssen. Das sind *r*, *w*, *x* als Dateirechte sowie *readonly* und *hidden* als besondere Fälle von Rechten. Auf dem Macintosh werden außerdem macOS-Typen und -Erzeuger unterstützt; dabei wird jedes Element, das vier Zeichen lang ist, als macOS-Typ angesehen (z. B. **TEXT**). Elemente der Form *{macintosh type XXXX}* oder *{macintosh creator XXXX}* passen auf Typen bzw. Erzeuger. Nicht erkannte Typen oder die Angabe mehrerer macOS-Typen bzw. -Erzeuger lösen einen Fehler aus.

    Die beiden Formen können gemischt werden; **-types {d f r w}** findet also alle normalen Dateien ODER Verzeichnisse, die Lese- UND Schreibrechte haben. Folgende Aufrufe sind gleichwertig:

    ```
    glob -type d *
    glob */
    ```

    mit dem Unterschied, dass der erste Fall kein abschließendes „/“ zurückgibt und plattformunabhängiger ist.

**--**
: Markiert das Ende der Schalter. Das darauf folgende Argument wird als *pattern* behandelt, auch wenn es mit **-** beginnt.


## Glob-Muster

Die *pattern*-Argumente können jedes der folgenden Sonderzeichen enthalten; sie bilden eine Obermenge der Zeichen, die [string match][string] unterstützt:

**?**
: Passt auf ein beliebiges einzelnes Zeichen.

**\***
: Passt auf eine beliebige Folge von null oder mehr Zeichen.

**\[***chars***\]**
: Passt auf ein beliebiges einzelnes Zeichen aus *chars*. Enthält *chars* eine Sequenz der Form *a***-***b*, passt jedes Zeichen zwischen *a* und *b* (einschließlich).

**\\***x*
: Passt auf das Zeichen *x*.

**{***a***,***b***,***...*}
: Passt auf jedes der Teilmuster *a*, *b* usw.


Unter Unix muss, wie bei csh, ein „.“ am Anfang eines Dateinamens oder direkt nach einem „/“ ausdrücklich oder mit einem {}-Konstrukt angegeben werden, sofern nicht der Schalter **-types hidden** angegeben ist (denn ein „.“ am Anfang eines Dateinamens zeigt an, dass die Datei versteckt ist). Auf anderen Plattformen werden Dateien, die mit einem „.“ beginnen, nicht anders behandelt als alle anderen, mit Ausnahme der besonderen Verzeichnisse „.“ und „..“, die ausdrücklich angegeben werden müssen (damit ein rekursives Muster wie „glob -join \* \* \* \*“ in der Verzeichnishierarchie nicht nur nach unten, sondern auch nach oben wandert). Außerdem müssen alle „/“-Zeichen ausdrücklich angegeben werden.

Ist das erste Zeichen eines *pattern* ein „~“, verweist es auf das Home-Verzeichnis des Benutzers, dessen Name auf das „~“ folgt. Folgt auf das „~“ unmittelbar ein „/“, wird der Wert der Umgebungsvariablen HOME verwendet.

Der Befehl **glob** unterscheidet sich in zwei Punkten vom Globbing der csh. Erstens sortiert er seine Ergebnisliste nicht (verwenden Sie den Befehl [lsort], wenn Sie die Liste sortiert haben möchten). Zweitens gibt **glob** nur die Namen von Dateien zurück, die tatsächlich existieren; in der csh wird die Existenz nur geprüft, wenn ein Muster ein ?-, \*- oder \[\]-Konstrukt enthält.

Wenn der Befehl **glob** relative Pfade zurückgibt, deren Dateinamen mit einer Tilde „~“ beginnen (zum Beispiel über **glob \*** oder **glob -tails**), wird die Tilde in der zurückgegebenen Liste nicht mit „./“ maskiert. Sollen diese Namen später mit [file join][file] verwendet werden, ist daher Vorsicht geboten, damit sie nicht als absolute Pfade interpretiert werden, die auf das Home-Verzeichnis eines bestimmten Benutzers verweisen.

# Portabilität unter Windows

Bei Windows-UNC-Namen dürfen die Bestandteile Servername und Freigabename des Pfads keine Konstrukte ?, \* oder \[\] enthalten. Hat *pattern* unter Windows NT die Form „**~***username***@***domain*“, verweist es auf das Home-Verzeichnis des Benutzers, dessen Kontoinformationen auf dem angegebenen NT-Domänenserver liegen. Andernfalls werden die Kontoinformationen des Benutzers vom lokalen Rechner bezogen.

Da der Backslash für den Befehl glob eine besondere Bedeutung hat, ist bei Glob-Mustern mit Pfadtrennzeichen im Windows-Stil besondere Vorsicht geboten. Das Muster „*C:\\\\foo\\\\\**“ wird als „*C:\\foo\\\**“ interpretiert, wobei „*\\f*“ auf das einzelne Zeichen „*f*“ passt und „*\\\**“ auf das einzelne Zeichen „*\**“ passt und nicht als Platzhalterzeichen interpretiert wird. Eine Lösung dieses Problems besteht darin, den Schrägstrich im Unix-Stil als Pfadtrennzeichen zu verwenden. Pfade im Windows-Stil lassen sich mit dem Befehl „[file join][file] **$path**“ oder „[file normalize][file] **$path**“ in Pfade im Unix-Stil umwandeln.

# Beispiele

Alle Tcl-Dateien im aktuellen Verzeichnis finden:

```
glob *.tcl
```

Alle Tcl-Dateien im Home-Verzeichnis des Benutzers finden, unabhängig davon, welches das aktuelle Verzeichnis ist:

```
glob -directory ~ *.tcl
```

Alle Unterverzeichnisse des aktuellen Verzeichnisses finden:

```
glob -type d *
```

Alle Dateien finden, deren Name ein „a“, ein „b“ oder die Sequenz „cde“ enthält:

```
glob -type f *{a,b,cde}*
```


[file]: file.md
[lsort]: lsort.md
[string]: string.md
