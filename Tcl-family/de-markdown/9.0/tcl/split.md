---
CommandName: split
title: split
ManualSection: n
Version: unknown
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - join(n)
 - list(n)
 - string(n)
Keywords:
 - list
 - split
 - string
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

split - Teilt eine Zeichenkette in eine gültige Tcl-Liste

# Übersicht

::: {.synopsis} :::
[split]{.cmd} [string]{.arg} [splitChars]{.optarg}
:::

# Beschreibung

Gibt eine Liste zurück, die entsteht, wenn *string* an jedem Zeichen aus *splitChars* geteilt wird. Jedes Listenelement besteht aus den Zeichen von *string* zwischen solchen Trennzeichen. Leere Elemente entstehen bei benachbarten Trennzeichen oder wenn *string* mit einem Trennzeichen beginnt oder endet. Ist *splitChars* leer, wird jedes Zeichen von *string* ein eigenes Element. Standard: übliche Leerraumzeichen.

# Beispiele

USENET-Gruppenname in Hierarchieebenen:

```
split "comp.lang.tcl" .
      → comp lang tcl
```

**split** trennt an jedem Zeichen in *splitChars* — bei unpassender Wahl Informationsverlust:

```
split "alpha beta gamma" "temp"
      → al {ha b} {} {a ga} {} a
```

Wörter aus einer nicht wohlgeformten Liste:

```
split "Example with {unbalanced brace character"
      → Example with \{unbalanced brace character
```

Zeichenkette in Einzelzeichen:

```
split "Hello world" {}
      → H e l l o { } w o r l d
```

## Zeilenorientierte Dateien parsen

Unix-/etc/passwd (Zeilen mit Doppelpunkt-Feldern):

```
## Datei lesen
set fid [open /etc/passwd]
set content [read $fid]
close $fid

## Records an Zeilenumbrüchen
set records [split $content "\n"]

## Über Records
foreach rec $records {

    ## Felder an Doppelpunkten
    set fields [split $rec ":"]

    ## Variablen zuweisen und ausgeben...
    lassign $fields \
            userName password uid grp longName homeDir shell
    puts "$longName uses [file tail $shell] for a login shell"
}
```
