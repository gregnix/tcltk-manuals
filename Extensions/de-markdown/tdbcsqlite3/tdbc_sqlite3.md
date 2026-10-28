---
CommandName: tdbc::sqlite3
title: tdbc::sqlite3
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Database Connectivity
Links:
 - tdbc(n)
 - tdbc::connection(n)
 - tdbc::resultset(n)
 - tdbc::statement(n)
Keywords:
 - TDBC
 - SQL
 - SQLite3
 - database
 - connectivity
 - connection
Copyright:
 - Copyright (c) 2008 by Kevin B. Kenny.
---

# Name

tdbc::sqlite3 - TDBC-Treiber für die Datenbankverwaltung SQLite3

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc::sqlite3]{.lit} [1.0]{.lit}
[tdbc::sqlite3::connection]{.cmd} [create]{.sub} [db]{.arg} [fileName]{.arg} [-option value...]{.optarg}
:::

# Beschreibung

Der Treiber **tdbc::sqlite3** stellt eine Datenbankschnittstelle bereit, die Tcl DataBase Connectivity (TDBC) entspricht, und erlaubt einem Tcl-Skript, sich mit einer SQLite3-Datenbank zu verbinden. Er liegt außerdem als ausgearbeitetes Beispiel dafür vor, wie ein Datenbanktreiber in Tcl geschrieben wird, damit Autoren von Treibern einen Ausgangspunkt für die weitere Entwicklung haben.

Die Verbindung zu einer SQLite3-Datenbank entsteht durch den Aufruf von **tdbc::sqlite3::connection create**. Übergeben werden eine Zeichenkette, die als Verbindungshandle dienen soll, und danach der Dateiname der Datenbank. Die Nebenwirkung von **tdbc::sqlite3::connection create** ist, eine neue Datenbankverbindung zu erzeugen. Als Alternative darf **tdbc::sqlite::connection new** eine Datenbankverbindung mit automatisch vergebenem Namen erzeugen. Der Rückgabewert von **tdbc::sqlite::connection new** ist der Name, der für das Verbindungshandle gewählt wurde. **tdbc::connection(n)** beschreibt, wie die Verbindung zum Bearbeiten einer Datenbank verwendet wird.

# Konfigurationsoptionen

Die Standard-Konfigurationsoptionen **-encoding**, **-isolation**, **-readonly** und **-timeout** werden sämtlich erkannt, sowohl bei **tdbc::sqlite3::connection create** als auch bei der Methode **configure** der entstehenden Verbindung.

Da die Kodierung einer SQLite3-Datenbank stets bekannt ist, akzeptiert die Option **-encoding** nur **utf-8** als Kodierung und gibt für eine Kodierung stets **utf-8** zurück. Die tatsächliche Kodierung lässt sich beim Anlegen einer neuen Datenbank mit einer SQLite3-Anweisung **PRAGMA** setzen.

Umgesetzt sind nur die Isolationsstufen **readuncommitted** und **serializable**. Andere Isolationsstufen werden auf **serializable** angehoben.

Der Schalter **-readonly** ist nicht umgesetzt. Ein boolescher Wert **false** wird stillschweigend akzeptiert, jeder andere Wert meldet einen Fehler.

Der Schalter **-keepcase** ist besonders und steuert, wie Tabellen- und Spaltennamen in den verschiedenen Methoden gemeldet werden, die Metadaten der Datenbank abrufen. Vorgegeben ist der Schalter mit null, das heißt, Tabellen- und Spaltennamen werden durchgängig in Kleinbuchstaben gemeldet. Andernfalls werden Tabellen- und Spaltennamen so gemeldet, wie sie in der Datenbank definiert sind.

# Fehler

Ist ein Spaltenname unter den Spalten einer Ergebnismenge nicht eindeutig, fehlen in den Ergebnissen der Rückgaben von **-as dicts** alle bis auf die am weitesten rechts stehende der doppelten Spalten. Diese Einschränkung lässt sich umgehen, indem **SELECT**-Anweisungen passende **AS**-Klauseln erhalten, sodass alle zurückgegebenen Spaltennamen eindeutig sind. Geplant ist, diesen Fehler durch eine C-Umsetzung des Treibers zu beheben; das wird auch die Leistung deutlich verbessern.

# Copyright

Copyright (c) 2008 by Kevin B. Kenny.
