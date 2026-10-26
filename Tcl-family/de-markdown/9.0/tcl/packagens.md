---
CommandName: pkg::create
title: pkg::create
ManualSection: n
Version: 8.3
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - package(n)
Keywords:
 - auto-load
 - index
 - package
 - version
Copyright:
 - Copyright (c) 1998-2000 Scriptics Corporation.
---

# Name

pkg::create - Passenden Befehl package ifneeded zu einer Paketangabe erzeugen

# Übersicht

::: {.synopsis} :::
[::pkg::create]{.cmd} [-name]{.lit} [packageName]{.arg} [-version]{.lit} [packageVersion]{.arg} [[-load]{.lit} [filespec]{.arg}]{.optarg} ... [[-source]{.lit} [filespec]{.arg}]{.optarg} ...
:::

# Beschreibung

**::pkg::create** ist eine Hilfsprozedur der Tcl-Standardbibliothek. Sie erzeugt zu einer Paketangabe den passenden Befehl [package ifneeded][package]. Damit lässt sich eine Datei **pkgIndex.tcl** für den [package]-Mechanismus bauen.

# Optionen

Unterstützt werden diese Parameter:

[-name]{.lit} [packageName]{.arg}
: Legt den Namen des Pakets fest. Erforderlich.

[-version]{.lit} [packageVersion]{.arg}
: Legt die Version des Pakets fest. Erforderlich.

[-load]{.lit} [filespec]{.arg}
: Legt eine Bibliothek fest, die mit [load] geladen werden muss. *filespec* ist eine Liste mit zwei Elementen. Das erste ist der Name der zu ladenden Datei. Das zweite, optionale Element ist eine Liste der Befehle, die das Laden dieser Datei bereitstellt. Ist die Prozedurliste leer oder fehlt sie, richtet **::pkg::create** die Bibliothek zum direkten Laden ein (siehe [pkg\_mkIndex][pkgMkIndex]). Beliebig viele Parameter **-load** sind zulässig.

[-source]{.lit} [filespec]{.arg}
: Wie **-load**, gibt aber eine Tcl-Bibliothek an, die mit [source] geladen werden muss. Beliebig viele Parameter **-source** sind zulässig.


Mindestens ein **-load** oder **-source** muss angegeben sein.


[load]: load.md
[package]: package.md
[pkgMkIndex]: pkgMkIndex.md
[source]: source.md
