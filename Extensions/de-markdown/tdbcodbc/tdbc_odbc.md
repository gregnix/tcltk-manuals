---
CommandName: tdbc::odbc
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
 - ODBC
 - database
 - connectivity
 - connection
Copyright:
 - Copyright (c) 2008 by Kevin B. Kenny.
---

# NAME

tdbc::odbc - TDBC-ODBC-Brücke

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc::odbc]{.lit} [1.0]{.lit} 
[tdbc::odbc::connection]{.cmd} [create]{.sub} [db]{.arg} [connectionString]{.arg} [-option value]{.optdot} 
[tdbc::odbc::connection]{.cmd} [new]{.sub} [connectionString]{.arg} [-option value]{.optdot} 
[tdbc::odbc::datasources]{.cmd} [-system|-user]{.optlit} 
[tdbc::odbc::drivers]{.cmd} 
[tdbc::odbc::datasource]{.cmd} [command]{.arg} [driverName]{.arg} [keyword-value?]{.optdot} 
:::

# BESCHREIBUNG

Der Treiber **tdbc::odbc** stellt eine Datenbankschnittstelle bereit, die Tcl DataBase Connectivity (TDBC) entspricht, und erlaubt einem Tcl-Skript, sich mit jeder SQL-Datenbank zu verbinden, die eine ODBC-Schnittstelle anbietet. Er liegt außerdem als ausgearbeitetes Beispiel dafür vor, wie ein Datenbanktreiber in C geschrieben wird, damit Autoren von Treibern einen Ausgangspunkt für die weitere Entwicklung haben.

Die Verbindung zu einer ODBC-Datenbank entsteht durch den Aufruf von **tdbc::odbc::connection create**. Übergeben werden der Name, der als Verbindungshandle dienen soll, und danach eine übliche ODBC-Verbindungszeichenkette. Als Alternative darf **tdbc::odbc::connection new** eine Datenbankverbindung mit automatisch vergebenem Namen erzeugen. Der Rückgabewert von **tdbc::odbc::connection new** ist der Name, der für das Verbindungshandle gewählt wurde.

Die Verbindungszeichenkette enthält mindestens ein Schlüsselwort **DRIVER** oder **DSN** und darf weitere enthalten, die ein bestimmter ODBC-Treiber festlegt. (Unterstützt das lokale ODBC-System eine grafische Benutzeroberfläche, kann die Option **-parent** (siehe unten) erlauben, **tdbc::odbc::connection create** mit einer leeren Verbindungszeichenkette aufzurufen.)

Die Nebenwirkung von **tdbc::odbc::connection create** ist, eine neue Datenbankverbindung zu erzeugen. **tdbc::connection(n)** beschreibt, wie die Verbindung zum Bearbeiten einer Datenbank verwendet wird.

Zusätzlich zu einer üblichen TDBC-Schnittstelle unterstützt **tdbc::odbc** drei weitere Befehle. Der erste davon, **tdbc::odbc::datasources**, gibt eine Tcl-Liste zurück, die die benannten Datenquellen aufzählt, die dem Programm zur Verfügung stehen (für die Verbindung mit dem Schlüsselwort **DSN** in der Verbindungszeichenkette). Das Ergebnis von **tdbc::odbc::datasources** lässt sich auf nur Systemdatenquellen oder nur Benutzerdatenquellen einschränken, indem die Optionen **-system** bzw. **-user** angegeben werden.

Der Befehl **tdbc::odbc::drivers** gibt ein Dictionary zurück, dessen Schlüssel die Namen der Treiber sind, die für das Schlüsselwort **DRIVER** in der Verbindungszeichenkette zur Verfügung stehen, und dessen Werte Beschreibungen der Treiber sind.

Der Befehl **tdbc::odbc::datasource** erlaubt das Konfigurieren benannter Datenquellen auf den Systemen, die die Programmierschnittstelle des ODBC-Installers unterstützen. Er nimmt ein *command* entgegen. Dieses *command* legt fest, welche Operation ausgeführt wird. Dazu kommen der Name eines *driver* für die betreffende Datenbank und eine Menge von Schlüsselwort-Wert-Paaren, die der gegebene Treiber deutet. *command* muss eines der Folgenden sein:

**add**
: Fügt eine Benutzerdatenquelle hinzu. Die Schlüsselwort-Wert-Paare müssen mindestens eine Option **DSN** enthalten, die die Datenquelle benennt.

**add_system**
: Fügt eine Systemdatenquelle hinzu. Die Schlüsselwort-Wert-Paare müssen mindestens eine Option **DSN** enthalten, die die Datenquelle benennt.

**configure**
: Konfiguriert eine Benutzerdatenquelle. Die Schlüsselwort-Wert-Paare enthalten gewöhnlich eine Option **DSN**, die die Datenquelle benennt. Manche Treiber unterstützen weitere Optionen, etwa die Option **CREATE_DB** des Microsoft-Access-Treibers unter Windows.

**configure_system**
: Konfiguriert eine Systemdatenquelle.

**remove**
: Entfernt eine Benutzerdatenquelle. Die Schlüsselwort-Wert-Paare müssen eine Option **DSN** enthalten, die die zu entfernende Datenquelle angibt.

**remove_system**
: Entfernt eine Systemdatenquelle. Die Schlüsselwort-Wert-Paare müssen eine Option **DSN** enthalten, die die zu entfernende Datenquelle angibt.


# VERBINDUNGSOPTIONEN

Der Objektbefehl **tdbc::odbc::connection create** unterstützt die Optionen **-encoding**, **-isolation**, **-readonly** und **-timeout**, die allen TDBC-Treibern gemeinsam sind. Die Option **-encoding** gelingt nur, wenn die verlangte Kodierung dieselbe ist wie die Systemkodierung; **tdbc::odbc** versucht nicht, einem ODBC-Treiber abweichende Kodierungen vorzugeben. (Manche Treiber akzeptieren Kodierungsangaben in der Verbindungszeichenkette.)

Ist zusätzlich Tk im anfordernden Interpreter vorhanden und unterstützt der ODBC-Treibermanager des lokalen Systems eine grafische Benutzeroberfläche, unterstützt der Objektbefehl **tdbc::odbc::connection create** eine Option **-parent**, deren Wert der Pfadname eines Tk-Fensters ist. Ist diese Option angegeben und nennt eine Verbindungszeichenkette nicht alle Angaben, die für die Verbindung zu einer Schnittstelle nötig sind, zeigt der ODBC-Treibermanager einen Dialog an, der die zusätzlich nötigen Angaben erfragt. Der anfordernde Interpreter blockiert, bis der Benutzer den Dialog schließt; dann wird die Verbindung hergestellt.

# BEISPIELE

Da ODBC-Verbindungszeichenketten vom Treiber abhängen, ist die Dokumentation, die zum Zusammensetzen nötig ist, oft schwer zu finden. Die folgenden Beispiele arbeiten auf den meisten Windows-Systemen und zeigen zumindest einige nützliche Dinge, die ein Programm tun kann.

```
tdbc::odbc::connection create db \
    "DSN={PAYROLL};UID={aladdin};PWD={Sesame}"
```

Verbindet mit einer benannten Datenquelle „PAYROLL“, gibt „aladdin“ als Benutzernamen und „Sesame“ als Passwort an. Verwendet **db** als Namen der Verbindung.

```
set connString {DRIVER={Microsoft Access Driver (*.mdb)};}
append connString {FIL={MS Access}\;}
append connString {DBQ=} \
    [file nativename [file normalize $fileName]]
tdbc::odbc::connection create db2 -readonly 1 $connString
```

Öffnet eine Verbindung zu einer Microsoft-Access-Datenbankdatei, deren Dateiname in *\$fileName* steht. Die Datenbank wird nur zum Lesen geöffnet. Die entstehende Verbindung heißt „db2“.

```
tdbc::odbc::connection create db3 \
    "DRIVER=SQLite3;DATABASE=$fileName"
```

Öffnet eine Verbindung zu einer SQLite3-Datenbank, deren Name in „\$fileName“ steht.

```
tdbc::odbc::datasource add \
    {Microsoft Access Driver (*.mdb)} \
    DSN=MyTestDatabase \
    DBQ=[file native [file normalize $fileName]]
```

Erzeugt eine neue Benutzerdatenquelle mit dem Namen „MyTestDatabase“, gebunden an eine Microsoft-Access-Datei, deren Pfadname in „\$fileName“ steht. Eine Verbindung zur Datenquelle entsteht erst, wenn das Programm **tdbc::odbc::connection create** aufruft.

```
tdbc::odbc::datasource configure \
    {Microsoft Access Driver (*.mdb)} \
    CREATE_DB=[file native [file normalize $fileName]] \
    General
```

Erzeugt eine neue, leere Microsoft-Access-Datenbank in der durch „\$fileName“ bezeichneten Datei. Eine Verbindung zur Datenbank entsteht erst, wenn das Programm **tdbc::odbc::connection create** aufruft.

# WEITERE VERBINDUNGSMETHODEN

Zusätzlich zu den üblichen Methoden des Objekts tdbc::connection(n) unterstützen Verbindungen zu einer ODBC-Datenbank eine weitere Methode:

*\$connection* **evaldirect** *sqlStatement*
: Diese Methode nimmt den gegebenen treibereigenen SQL-Code *sqlStatement* entgegen und wertet ihn aus, ohne ihn vorzubereiten. Die Anweisung wird nicht in Token zerlegt und darf keine Variablenersetzungen enthalten. Das Auswerten von *sqlStatement* erzeugt eine Ergebnismenge mit null oder mehr Zeilen. Das Ergebnis des Befehls ist eine Liste von Dictionarys mit einem Listenelement je Zeile in der Ergebnismenge (in einem ähnlichen Format wie die Liste, die *\$connection allrows -as dicts* zurückgibt). *Dieser Befehl ist nicht zu empfehlen* für alles, bei dem die üblichen Methoden *prepare* oder *preparecall* richtig arbeiten. Er liegt vor, damit Anweisungen der Datenverwaltungssprache ausgeführt werden können, die die API für vorbereitete Anweisungen des Treibers nicht umsetzt (etwa **CREATE DATABASE** oder **CREATE PROCEDURE**), oder die Zeichen enthalten, die der Tokenizer reserviert.


# COPYRIGHT

Copyright (c) 2008 by Kevin B. Kenny.
