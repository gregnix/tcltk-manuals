---
CommandName: tdbc::mapSqlState
title: tdbc::mapSqlState
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Database Connectivity
Links:
 - tdbc(n)
 - tdbc::tokenize
 - tdbc::connection(n)
 - tdbc::statement(n)
 - tdbc::resultset(n)
Keywords:
 - TDBC
 - SQL
 - database
 - state
Copyright:
 - Copyright (c) 2009 by Kevin B. Kenny.
---

# Name

tdbc::mapSqlState - SQLSTATE einer Fehlerklasse zuordnen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc]{.lit} [1.0]{.lit}

[tdbc::mapSqlState]{.cmd} [sqlstate]{.arg}
:::

# Beschreibung

Der Befehl **tdbc::mapSqlState** nimmt eine Zeichenkette entgegen, die ein fünf Zeichen langes „SQL State“ sein soll, wie es eine SQL-Datenbank bei einem Fehler zurückgibt. Er prüft die ersten beiden Zeichen der Zeichenkette und gibt eine Fehlerklasse als für Mensch und Maschine lesbaren Namen zurück (zum Beispiel **FEATURE\_NOT\_SUPPORTED**, **DATA\_EXCEPTION** oder **INVALID\_CURSOR\_STATE**).

Die TDBC-Spezifikation verlangt, dass Datenbanktreiber bei einem Fehler eine Beschreibung des Fehlers im Fehlercode zurückgeben. Die Beschreibung ist eine Zeichenkette mit mindestens vier Elementen: „**TDBC** *errorClass* *sqlstate* *driverName* *details...*“. Der Befehl **tdbc::mapSqlState** gibt einem TDBC-Treiber einen bequemen Weg, das Element *errorClass* aus dem von der Datenbank zurückgegebenen SQL State zu bilden.

# Copyright

Copyright (c) 2009 by Kevin B. Kenny.
