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

Führt Dateinamen-„Globbing“ ähnlich wie in csh oder bash aus. Gibt eine Liste der Dateien zurück, deren Namen einem der *pattern*-Argumente entsprechen. Die Reihenfolge ist nicht garantiert; für eine sortierte Liste [lsort] verwenden.

## Optionen

Beginnen die ersten Argumente von **glob** mit **-**, gelten sie als Schalter. Unterstützt werden:

[-directory]{.lit} [directory]{.arg}
: Suche nach passenden Mustern ab dem angegebenen *directory*. Ermöglicht das Durchsuchen von Verzeichnissen, deren Name Glob-Sonderzeichen enthält, ohne diese explizit zu quoten. Nicht zusammen mit **-path** (Suche nach vollständigen Pfaden mit Glob-Sonderzeichen im Namen).

[-join]{.lit}
: Die verbleibenden Musterargumente nach der Optionenverarbeitung werden als ein einziges Muster behandelt, das durch Verkettung mit Verzeichnistrennzeichen entsteht.

[-nocomplain]{.lit}
: Erlaubt die Rückgabe einer leeren Liste ohne Fehler. In Tcl 9.0 ist das Standardverhalten; der Schalter hat daher keine Wirkung mehr.

[-path]{.lit} [pathPrefix]{.arg}
: Suche nach Dateien mit dem angegebenen *pathPrefix*, deren Rest dem Muster entspricht. Ermöglicht Suche nach Dateien mit Namen ähnlich einer gegebenen Datei (nicht nur einem Verzeichnis), auch wenn der Name Glob-Sonderzeichen enthält. Nicht zusammen mit **-directory**. Beispiel: alle Dateien mit gleichem Stamm wie $path, aber anderer Endung: „**glob -path \[file rootname $path\] .\***“ — funktioniert auch bei vielen Glob-Sonderzeichen in **$path**.

[-tails]{.lit}
: Nur der Teil jedes Treffers, der auf das zuletzt in einer **-directory**- oder **-path**-Angabe genannte Verzeichnis folgt. „**glob -tails -directory $dir \***“ entspricht „**set pwd \[pwd\]; cd $dir; glob \*; cd $pwd**“. Bei **-path** enthält der Rückgabename das letzte Pfadsegment, z. B. „**glob -tails -path \[file rootname /home/fred/foo.tex\] .\***“ → **foo.aux foo.bib foo.tex** usw.

[-types]{.lit} [typeList]{.arg}
: Nur Dateien oder Verzeichnisse listen, die *typeList* entsprechen. Die Listeneinträge haben zwei Formen. Erste Form wie die -type-Option von Unix find: *b* (Blockgerät), *c* (Zeichengerät), *d* (Verzeichnis), *f* (normale Datei), *l* (symbolischer Link), *p* (Named Pipe), *s* (Socket); mehrere Typen möglich. **Glob** liefert alle Dateien, die mindestens einem Typ entsprechen. Symbolische Links werden zurückgegeben, wenn **-types l** gesetzt ist oder das Linkziel den gewünschten Typ hat (Link auf Verzeichnis bei **-types d**).

    Zweite Form: alle angegebenen Typen müssen zutreffen — *r*, *w*, *x* als Dateirechte sowie *readonly*, *hidden*. Auf dem Macintosh werden macOS-Typen und -Erzeuger unterstützt; vier Zeichen lang = macOS-Typ (z. B. **TEXT**). *{macintosh type XXXX}* bzw. *{macintosh creator XXXX}* matchen Typ bzw. Erzeuger. Unbekannte Typen oder mehrere macOS-Typen/Erzeuger in einer Spezifikation: Fehler.

    Beide Formen sind mischbar; **-types {d f r w}** findet normale Dateien ODER Verzeichnisse mit Lese- UND Schreibrecht. Äquivalent:

    ```
    glob -type d *
    glob */
    ```

    außer dass der erste Fall kein abschließendes „/“ liefert und plattformunabhängiger ist.

[--]{.lit}
: Ende der Schalter; das folgende Argument gilt als *pattern*, auch wenn es mit **-** beginnt.


## Glob-Muster

Die *pattern*-Argumente können folgende Sonderzeichen enthalten (Obermenge von [string match][string]):

**?**
: Ein beliebiges Zeichen.

**\***
: Null oder mehr beliebige Zeichen.

**\[***chars***\]**
: Ein Zeichen aus *chars*. Enthält *chars* *a***-***b*, jedes Zeichen von *a* bis *b* (einschließlich).

**\\***x*
: Das Zeichen *x*.

**{***a***,***b***,***...***}**
: Eines der Teilmuster *a*, *b*, …


Unter Unix muss wie bei csh ein „.“ am Anfang des Dateinamens oder direkt nach „/“ explizit oder mit {} getroffen werden, außer **-types hidden** ist gesetzt („.“ = versteckt). Auf anderen Plattformen keine Sonderbehandlung, außer „.“ und „..“ müssen explizit getroffen werden (verhindert Rekursion nach oben bei „glob -join \* \* \* \*“). Alle „/“ müssen explizit gematcht werden.

**glob** unterscheidet sich vom csh-Globbing: keine Sortierung der Ergebnisliste ([lsort] bei Bedarf); **glob** liefert nur Namen existierender Dateien — csh prüft die Existenz nur bei ?, \*, \[\] im Muster.

# Portabilität unter Windows

Bei Windows-UNC-Namen dürfen Server- und Freigabename keine ?, \*, \[\] enthalten.

Da Backslash für glob speziell ist, brauchen Windows-Pfadmuster Sorgfalt. „*C:\\\\foo\\\\\**“ wird als „*C:\\foo\\\**“ gelesen, „*\\f*“ matcht ein „*f*“, „*\\\**“ ein „*\**“, nicht als Wildcard. Lösung: Unix-Schrägstrich als Trenner; Windows-Pfade mit „[file join][file] **$path**“ oder „[file normalize][file] **$path**“ umwandeln.

# Beispiele

Alle Tcl-Dateien im aktuellen Verzeichnis:

```
glob *.tcl
```

Alle Tcl-Dateien im Home-Verzeichnis des Benutzers, unabhängig vom aktuellen Verzeichnis:

```
glob -directory [file home] *.tcl
```

Alle Unterverzeichnisse des aktuellen Verzeichnisses:

```
glob -type d *
```

Alle Dateien, deren Name „a“, „b“ oder die Sequenz „cde“ enthält:

```
glob -type f *{a,b,cde}*
```


[file]: file.md
[lsort]: lsort.md
[string]: string.md
