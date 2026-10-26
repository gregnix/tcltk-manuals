---
CommandName: tdbc::postgres
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
 - Postgres
 - database
 - connectivity
 - connection
Copyright:
 - Copyright (c) 2009 by Slawomir Cygan
---

# NAME

tdbc::postgres - TDBC-POSTGRES-Brücke

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc::postgres]{.lit} [1.0]{.lit} 
[tdbc::postgres::connection]{.cmd} [create]{.sub} [db]{.arg} [-option value]{.optdot} 
[tdbc::postgres::connection]{.cmd} [new]{.sub} [-option value]{.optdot} 
:::

# BESCHREIBUNG

Der Treiber **tdbc::postgres** stellt eine Datenbankschnittstelle bereit, die Tcl DataBase Connectivity (TDBC) entspricht, und erlaubt einem Tcl-Skript, sich mit einer Postgres-Datenbank zu verbinden.

Die Verbindung zu einer POSTGRES-Datenbank entsteht durch den Aufruf von **tdbc::postgres::connection create**. Übergeben werden der Name, der dem Datenbankhandle gegeben werden soll, und eine Menge von Paaren *-option-value*. Die verfügbaren Optionen sind unter **VERBINDUNGSOPTIONEN** weiter unten aufgezählt. Als Alternative darf **tdbc::postgres::connection new** eine Datenbankverbindung mit automatisch vergebenem Namen erzeugen. Der Rückgabewert von **tdbc::postgres::connection new** ist der Name, der für das Verbindungshandle gewählt wurde.

Die Nebenwirkung von **tdbc::postgres::connection create** ist, eine neue Datenbankverbindung zu erzeugen. **tdbc::connection(n)** beschreibt, wie die Verbindung zum Bearbeiten einer Datenbank verwendet wird.

# VERBINDUNGSOPTIONEN

Der Objektbefehl **tdbc::postgres::connection create** unterstützt die Optionen **-encoding**, **-isolation**, **-readonly** und **-timeout**, die allen TDBC-Treibern gemeinsam sind. Die Option **-timeout** wirkt sich nur auf den Verbindungsvorgang aus; einmal verbunden, wird dieser Wert ignoriert und lässt sich nach dem Verbinden nicht mehr ändern.

Zusätzlich werden die folgenden Optionen erkannt (diese Optionen müssen beim ersten Erzeugen der Verbindung gesetzt werden; nach dem Verbinden lassen sie sich nicht mehr ändern):

**-host** *hostname*
: Verbindet mit dem durch *hostname* angegebenen Host. Vorgegeben ist die Verbindung über einen lokalen Unix-Domain-Socket.

**-hostaddr** *address*
: Verbindet mit dem Host, den die gegebene IP-Adresse *address* angibt. Sind sowohl **-host** als auch **-hostaddr** angegeben, wird der Wert von **-host** ignoriert. Vorgegeben ist die Verbindung über einen lokalen Unix-Domain-Socket.

**-port** *number*
: Verbindet mit einem Postgres-Server, der auf dem durch *number* angegebenen Port lauscht. Die Option wird nur verwendet, wenn *host* oder *hostaddr* angegeben ist.

**-user** *name*
: Legt *name* dem Postgres-Server als Benutzernamen vor. Vorgegeben ist die aktuelle Benutzerkennung.

**-passwd** *password*
: ...siehe nächstes...

**-password** *password*
: Diese beiden Optionen sind gleichbedeutend. Sie legen das gegebene *password* dem Postgres-Server als Passwort des Benutzers vor. Vorgegeben ist, kein Passwort vorzulegen.

**-database** *name*
: ...siehe nächstes...

**-db** *name*
: Diese beiden Optionen sind gleichbedeutend. Sie legen den gegebenen *name* als Namen der voreingestellten Datenbank vor, die in Postgres-Abfragen verwendet wird. Ist nichts angegeben, wird die voreingestellte Datenbank des aktuellen Benutzers verwendet.

**-options** *opts*
: Setzt *opts* als zusätzliche Kommandozeilenoptionen, die an den Server gesendet werden.

**-tty** *file*
: Diese Option wird auf neueren Servern ignoriert. Früher legte sie fest, wohin die Debug-Ausgabe gesendet wird. Die Option bleibt aus Kompatibilität mit älteren Servern erhalten.

**-sslmode** *mode*
: Diese Option legt fest, ob und mit welcher Priorität eine SSL-Verbindung mit dem Server ausgehandelt wird. Es gibt vier *modes*: **disable** versucht nur eine unverschlüsselte SSL-Verbindung; **allow** handelt aus und versucht zuerst eine Verbindung ohne SSL, danach, wenn das scheitert, eine SSL-Verbindung; **prefer** (die Vorgabe) handelt aus und versucht zuerst eine SSL-Verbindung, danach, wenn das scheitert, eine gewöhnliche Verbindung ohne SSL; **require** versucht nur eine SSL-Verbindung. Ist PostgreSQL ohne SSL-Unterstützung übersetzt, verursacht die Option **require** einen Fehler, und die Optionen **allow** und **prefer** werden geduldet, der Treiber kann aber keine SSL-Verbindung aushandeln.

**-requiressl** *flag*
: Diese Option ist zugunsten der Einstellung **-sslmode** veraltet. Der Wert *flag* muss ein boolescher Wert sein. Ist er **true** (oder ein gleichwertiger Wert), verweigert der Treiber die Verbindung, wenn der Server keine SSL-Verbindung annimmt. Der voreingestellte Wert ist **false** (oder ein gleichwertiger Wert) und wirkt wie **-sslmode** **preffered**

**-service** *name*
: Legt fest, welcher Dienstname *name* in der Datei pg_service.conf gilt. Die Datei enthält weitere Verbindungsparameter. Dadurch können Anwendungen nur einen Dienstnamen angeben, sodass die Verbindungsparameter zentral gepflegt werden können. Einzelheiten stehen in der PostgreSQL-Dokumentation oder in der Datei PREFIX/share/pg_service.conf.sample.


# BEISPIELE

```
tdbc::postgres::connection -user joe -passwd sesame -db joes_database
```

Verbindet mit dem Postgres-Server auf dem lokalen Host über die voreingestellte Verbindungsmethode, legt die Benutzerkennung „joe“ und das Passwort „sesame“ vor. Verwendet „joes_database“ als voreingestellten Datenbanknamen.

# COPYRIGHT

Copyright (c) 2009 by Slawomir Cygan
