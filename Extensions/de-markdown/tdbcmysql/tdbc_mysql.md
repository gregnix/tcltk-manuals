---
CommandName: tdbc::mysql
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
 - MySQL
 - database
 - connectivity
 - connection
Copyright:
 - Copyright (c) 2008 by Kevin B. Kenny.
---

# NAME

tdbc::mysql - TDBC-MYSQL-Brücke

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc::mysql]{.lit} [1.0]{.lit} 
[tdbc::mysql::connection]{.cmd} [create]{.sub} [db]{.arg} [-option value]{.optdot} 
[tdbc::mysql::connection]{.cmd} [new]{.sub} [-option value]{.optdot} 
[tdbc::mysql::datasources]{.cmd} [-system|-user]{.optlit} 
[tdbc::mysql::drivers]{.cmd} 
[tdbc::mysql::datasource]{.cmd} [command]{.arg} [driverName]{.arg} [keyword-value?]{.optdot} 
:::

# BESCHREIBUNG

Der Treiber **tdbc::mysql** stellt eine Datenbankschnittstelle bereit, die Tcl DataBase Connectivity (TDBC) entspricht, und erlaubt einem Tcl-Skript, sich mit einer MySQL-Datenbank zu verbinden.

Die Verbindung zu einer MYSQL-Datenbank entsteht durch den Aufruf von **tdbc::mysql::connection create**. Übergeben werden der Name, der dem Datenbankhandle gegeben werden soll, und eine Menge von Paaren *-option-value*. Die verfügbaren Optionen sind unter **VERBINDUNGSOPTIONEN** weiter unten aufgezählt. Als Alternative darf **tdbc::mysql::connection new** eine Datenbankverbindung mit automatisch vergebenem Namen erzeugen. Der Rückgabewert von **tdbc::mysql::connection new** ist der Name, der für das Verbindungshandle gewählt wurde.

Die Nebenwirkung von **tdbc::mysql::connection create** ist, eine neue Datenbankverbindung zu erzeugen. **tdbc::connection(n)** beschreibt, wie die Verbindung zum Bearbeiten einer Datenbank verwendet wird.

# VERBINDUNGSOPTIONEN

Der Objektbefehl **tdbc::mysql::connection create** unterstützt die Optionen **-encoding**, **-isolation**, **-readonly** und **-timeout**, die allen TDBC-Treibern gemeinsam sind. Die Option **-encoding** schlägt stets fehl, es sei denn, die Kodierung ist **utf-8**; die Datenbankverbindung verwendet stets die Kodierung UTF-8, um beliebige Unicode-Zeichen übertragen zu können. Die Option **-readonly** muss **0** sein, weil MySQL keine nur lesenden Verbindungen anbietet.

Zusätzlich werden die folgenden Optionen erkannt:

**-host** *hostname*
: Verbindet mit dem durch *hostname* angegebenen Host. Diese Option muss beim ersten Erzeugen der Verbindung gesetzt werden; nach dem Verbinden lässt sie sich nicht mehr ändern. Vorgegeben ist die Verbindung zum lokalen Host.

**-port** *number*
: Verbindet mit einem MySQL-Server, der auf dem durch *number* angegebenen Port lauscht. Diese Option lässt sich nach dem Verbinden nicht mehr ändern. Sie wird nur verwendet, wenn *host* angegeben ist und nicht **localhost** ist.

**-socket** *path*
: Verbindet mit einem MySQL-Server, der auf dem Unix-Socket oder der benannten Pipe lauscht, die *path* angibt. Diese Option lässt sich nach dem Verbinden nicht mehr ändern. Sie wird nur verwendet, wenn *-host* nicht angegeben ist oder **localhost** ist.

**-user** *name*
: Legt *name* dem MySQL-Server als Benutzernamen vor. Vorgegeben ist die aktuelle Benutzerkennung.

**-passwd** *password*
: ...siehe nächstes...

**-password** *password*
: Diese beiden Optionen sind gleichbedeutend. Sie legen das gegebene *password* dem MySQL-Server als Passwort des Benutzers vor. Vorgegeben ist, kein Passwort vorzulegen.

**-database** *name*
: ...siehe nächstes...

**-db** *name*
: Diese beiden Optionen sind gleichbedeutend. Sie legen den gegebenen *name* als Namen der voreingestellten Datenbank vor, die in MySQL-Abfragen verwendet wird. Ist nichts angegeben, wird die voreingestellte Datenbank des aktuellen Benutzers verwendet.

**-interactive** *flag*
: Der Wert *flag* muss ein boolescher Wert sein. Ist er **true** (oder ein gleichwertiger Wert), wird das voreingestellte Zeitlimit für einen interaktiven Benutzer gesetzt, andernfalls das voreingestellte Zeitlimit für einen Benutzer im Stapelbetrieb. Diese Option ist nur bei der ersten Verbindung von Bedeutung. Wird die Methode **configure** auf einer MySQL-Verbindung verwendet, setzt die Option **-timeout** das gewünschte Zeitlimit.

**-ssl_ca** *string*
: ...siehe nächstes...

**-ssl_capath** *string*
: ...siehe nächstes...

**-ssl_cert** *string*
: ...siehe nächstes...

**-ssl_cipher** *string*
: ...siehe nächstes...

**-ssl_key** *string*
: Diese fünf Optionen setzen die Zertifizierungsstelle, den Suchpfad der Zertifizierungsstelle, das SSL-Zertifikat, die Übertragungschiffre und den SSL-Schlüssel auf die gegebenen Argumente *string*. Diese Optionen dürfen nur bei der ersten Verbindung zu einer Datenbank angegeben werden, nicht in der Methode **configure** einer bestehenden Verbindung. Vorgegeben ist, SSL nicht zu verwenden.


# BEISPIELE

```
tdbc::mysql::connection -user joe -passwd sesame -db joes_database
```

Verbindet mit dem MySQL-Server auf dem lokalen Host über die voreingestellte Verbindungsmethode, legt die Benutzerkennung „joe“ und das Passwort „sesame“ vor. Verwendet „joes_database“ als voreingestellten Datenbanknamen.

# WEITERE VERBINDUNGSMETHODEN

Zusätzlich zu den üblichen Methoden des Objekts tdbc::connection(n) unterstützen Verbindungen zu einer MySQL-Datenbank eine weitere Methode:

*\$connection* **evaldirect** *sqlStatement*
: Diese Methode nimmt die gegebene *sqlStatement* entgegen, deutet sie als MySQL-eigenen SQL-Code und wertet sie aus, ohne sie vorzubereiten. Die Anweisung darf keine Variablenersetzungen enthalten. Die Ergebnismenge wird als Liste von Listen zurückgegeben; jede Unterliste ist die Liste der Spalten einer Ergebniszeile, formatiert als Zeichenketten. Die Formatierung der Zeichenketten übernimmt MySQL und nicht Tcl, sodass Einzelheiten wie das Aussehen von Gleitkommazahlen abweichen können. *Dieser Befehl ist nicht zu empfehlen* für alles, bei dem die üblichen Methoden *prepare* oder *preparecall* richtig arbeiten. Er liegt vor, damit Anweisungen der Datenverwaltungssprache ausgeführt werden können, die in der API für vorbereitete Anweisungen von MySQL nicht umgesetzt sind, etwa **CREATE DATABASE** oder **CREATE PROCEDURE**.


# COPYRIGHT

Copyright (c) 2009 by Kevin B. Kenny.
