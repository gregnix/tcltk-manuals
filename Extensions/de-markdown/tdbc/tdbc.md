---
CommandName: tdbc
title: tdbc
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Database Connectivity
Links:
 - Tdbc_Init(3)
 - tdbc::connection(n)
 - tdbc::mapSqlState(n)
 - tdbc::resultset(n)
 - tdbc::statement(n)
 - tdbc::tokenize(n)
 - tdbc::mysql(n)
 - tdbc::odbc(n)
 - tdbc::postgres(n)
 - tdbc::sqlite3(n)
Keywords:
 - TDBC
 - SQL
 - database
 - connectivity
 - connection
 - resultset
 - statement
Copyright:
 - Copyright (c) 2008 by Kevin B. Kenny.
---

# Name

tdbc - Datenbankanbindung für Tcl

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc]{.lit} [1.0]{.lit}
[package]{.cmd} [require]{.sub} [tdbc::driver]{.lit} [version]{.lit}

[tdbc::driver::connection]{.cmd} [create]{.sub} [db]{.arg} [-option value...]{.optarg}
:::

# Beschreibung

Tcl Database Connectivity (TDBC) ist eine gemeinsame Schnittstelle, über die Tcl-Programme auf SQL-Datenbanken zugreifen. Umgesetzt wird sie durch eine Reihe von Datenbank-*Treibern*: getrennte Module, von denen jedes Tcl an die Schnittstelle eines bestimmten Datenbanksystems anpasst. Alle Treiber stellen eine gemeinsame Folge von Befehlen bereit, mit denen die Datenbank bearbeitet wird. Diese Befehle werden sämtlich dynamisch benannt, weil sie Objekte im Datenbanksystem darstellen. Dazu gehören **Verbindungen,** die Verbindungen zu einer Datenbank darstellen, **Anweisungen,** die SQL-Anweisungen darstellen, und **Ergebnismengen,** die die Mengen der Zeilen darstellen, die aus dem Ausführen von Anweisungen entstehen. Jede dieser Arten hat eine eigene Handbuchseite; aufgeführt sind sie unter **SIEHE AUCH**.

Daneben enthält TDBC selbst einige Dienstprozeduren, die vor allem für Autoren von Treibern von Bedeutung sind. **SIEHE AUCH** zählt auch sie auf.

# Copyright

Copyright (c) 2008 by Kevin B. Kenny.
