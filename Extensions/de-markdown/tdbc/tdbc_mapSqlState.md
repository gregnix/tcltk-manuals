---
CommandName: tdbc::mapSqlState
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

# NAME

tdbc::mapSqlState - SQLSTATE einer Fehlerklasse zuordnen

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc]{.lit} [1.0]{.lit} 

[tdbc::mapSqlState]{.cmd} [sqlstate]{.arg} 
:::

# BESCHREIBUNG

Der Befehl **tdbc::mapSqlState** nimmt eine Zeichenkette entgegen, die ein fünf Zeichen langes „SQL State“ sein soll, wie es eine SQL-Datenbank bei einem Fehler zurückgibt. Er prüft die ersten beiden Zeichen der Zeichenkette und gibt eine Fehlerklasse als für Mensch und Maschine lesbaren Namen zurück (zum Beispiel **FEATURE_NOT_SUPPORTED**, **DATA_EXCEPTION** oder **INVALID_CURSOR_STATE**).

Die TDBC-Spezifikation verlangt, dass Datenbanktreiber bei einem Fehler eine Beschreibung des Fehlers im Fehlercode zurückgeben. Die Beschreibung ist eine Zeichenkette mit mindestens vier Elementen: „**TDBC** *errorClass* *sqlstate* *driverName* *details...*“. Der Befehl **tdbc::mapSqlState** gibt einem TDBC-Treiber einen bequemen Weg, das Element *errorClass* aus dem von der Datenbank zurückgegebenen SQL State zu bilden.

# COPYRIGHT

Copyright (c) 2009 by Kevin B. Kenny.
