---
CommandName: pkg::create
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
 - All rights reserved.
---

# NAME

pkg::create - Passenden Befehl package ifneeded zu einer Paketangabe erzeugen

# ÜBERSICHT

::: {.synopsis} :::
[::pkg::create]{.cmd} [-name]{.sub} [packageName]{.arg} [-version]{.lit} [packageVersion]{.arg} [-load filespec]{.optarg} ... [-source filespec]{.optarg} ... 
:::

# BESCHREIBUNG

**::pkg::create** ist eine Hilfsprozedur der Tcl-Standardbibliothek. Sie erzeugt zu einer Paketangabe den passenden Befehl **package ifneeded**. Damit lässt sich eine Datei **pkgIndex.tcl** für den **package**-Mechanismus bauen.

# OPTIONEN

Unterstützt werden diese Parameter:

**-name** *packageName*
: Legt den Namen des Pakets fest. Erforderlich.

**-version** *packageVersion*
: Legt die Version des Pakets fest. Erforderlich.

**-load** *filespec*
: Legt eine binäre Bibliothek fest, die mit **load** geladen werden muss. *filespec* ist eine Liste mit zwei Elementen. Das erste ist der Name der zu ladenden Datei. Das zweite, optionale Element ist eine Liste der Befehle, die das Laden dieser Datei bereitstellt. Ist die Prozedurliste leer oder fehlt sie, richtet **::pkg::create** die Bibliothek zum direkten Laden ein (siehe **pkg_mkIndex**). Beliebig viele Parameter **-load** sind zulässig.

**-source** *filespec*
: Wie **-load**, gibt aber eine Tcl-Bibliothek an, die mit **source** geladen werden muss. Beliebig viele Parameter **-source** sind zulässig. Mindestens ein **-load** oder **-source** muss angegeben sein.
