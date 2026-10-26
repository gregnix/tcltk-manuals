---
CommandName: tdbc::connection
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Database Connectivity
Links:
 - encoding(n)
 - tdbc(n)
 - tdbc::resultset(n)
 - tdbc::statement(n)
 - tdbc::tokenize(n)
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

# NAME

tdbc::connection - TDBC-Objekt für eine Verbindung

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc]{.lit} [1.0]{.lit} 
[package]{.cmd} [require]{.sub} [tdbc::driver]{.lit} [version]{.lit} 

[tdbc::driver::connection]{.cmd} [create]{.sub} [db]{.arg} [-option value]{.optdot} 

[db]{.ins} [configure]{.sub} [-option value]{.optdot} 
[db]{.ins} [close]{.sub} 
[db]{.ins} [foreignkeys]{.sub} [-primary tableName]{.optarg} [-foreign tableName]{.optarg} 
[db]{.ins} [prepare]{.sub} [sql-code]{.arg} 
[db]{.ins} [preparecall]{.sub} [call]{.arg} 
[db]{.ins} [primarykeys]{.sub} [tableName]{.arg} 
[db]{.ins} [statements]{.sub} 
[db]{.ins} [resultsets]{.sub} 
[db]{.ins} [tables]{.sub} [pattern]{.optarg} 
[db]{.ins} [columns]{.sub} [table]{.arg} [pattern]{.optarg} 
[db]{.ins} [begintransaction]{.sub} 
[db]{.ins} [commit]{.sub} 
[db]{.ins} [rollback]{.sub} 
[db]{.ins} [transaction]{.sub} [script]{.arg} 
[db]{.ins} [foreach]{.sub} [-as lists|dicts]{.optarg} [-columnsvariable name]{.optarg} [--]{.optarg} [varName]{.arg} [sqlcode]{.arg} [dictionary]{.optarg} [script]{.arg} 
:::

.in 14 *db* **allrows** ?**-as lists**|**dicts**? ?**-columnsvariable** *name*? ?**--**? *sql-code* ?*dictionary*?

# BESCHREIBUNG

Jeder Datenbanktreiber für TDBC (Tcl DataBase Connectivity) setzt ein Objekt *Verbindung* um, das eine Verbindung zu einer Datenbank darstellt. Nach üblicher Vereinbarung entsteht dieses Objekt durch den Befehl **tdbc::**_driver_**::connection create**. Dieser Befehl nimmt den Namen eines Tcl-Befehls entgegen, der die Verbindung darstellen wird, und eine mögliche Menge von Optionen (siehe **KONFIGURATIONSOPTIONEN**). Er stellt eine Verbindung zur Datenbank her und gibt den Namen des neu erzeugten Tcl-Befehls zurück.

Der Objektbefehl **configure** auf einer Datenbankverbindung gibt, ohne Argumente aufgerufen, eine Liste abwechselnder Schlüsselwörter und Werte zurück, die die aktuelle Konfiguration der Verbindung darstellen. Mit einem einzelnen Argument *-option* gibt er den konfigurierten Wert der angegebenen Option zurück. Andernfalls muss er eine gerade Anzahl von Argumenten erhalten, abwechselnd Optionen und Werte. Die angegebenen Optionen erhalten die angegebenen Werte, und der Befehl gibt nichts zurück.

Der Objektbefehl **close** auf einer Datenbankverbindung schließt die Verbindung. Alle aktiven Anweisungen und Ergebnismengen auf der Verbindung werden geschlossen. Jede nicht festgeschriebene Transaktion wird zurückgesetzt. Der Objektbefehl wird gelöscht.

Der Objektbefehl **prepare** auf einer Datenbankverbindung bereitet eine SQL-Anweisung zur Ausführung vor. Das Argument *sql-code* muss eine einzelne SQL-Anweisung enthalten, die ausgeführt werden soll. Gebundene Variablen dürfen vorkommen. Der Rückgabewert ist ein neu erzeugter Tcl-Befehl, der die Anweisung darstellt. **tdbc::statement** erörtert ausführlicher das SQL, das der Objektbefehl **prepare** akzeptiert, und die Schnittstelle, die eine Anweisung akzeptiert.

Bei einer Datenbankverbindung, deren zugrunde liegende Datenbank und deren Treiber gespeicherte Prozeduren unterstützen, bereitet der Objektbefehl **preparecall** einen Aufruf einer gespeicherten Prozedur zur Ausführung vor. Die Syntax des Aufrufs der gespeicherten Prozedur ist:

```
?resultvar =? procname(?arg ?, arg...?)
```

Der Rückgabewert ist ein neu erzeugter Tcl-Befehl, der die Anweisung darstellt. **tdbc::statement** beschreibt die Schnittstelle, die eine Anweisung akzeptiert.

Der Objektbefehl **statements** gibt eine Liste der Anweisungen zurück, die durch Anweisungen **prepare** und **preparecall** gegen die gegebene Verbindung erzeugt wurden und noch nicht geschlossen sind.

Der Objektbefehl **resultsets** gibt eine Liste der Ergebnismengen zurück, die durch Ausführen von Anweisungen entstanden sind, die über die gegebene Verbindung vorbereitet wurden, und die noch nicht geschlossen sind.

Der Objektbefehl **tables** erlaubt dem Programm, die Verbindung nach den Namen der Tabellen zu fragen, die in der Datenbank vorhanden sind. Der optionale Parameter *pattern* ist ein Muster, auf das der Name einer Tabelle passen soll. Er darf die SQL-Platzhalterzeichen „**%**“ und „**\_**“ enthalten. Der Rückgabewert ist ein Dictionary, dessen Schlüssel Tabellennamen und dessen Werte untergeordnete Dictionarys sind. Die Deutung der Werte steht in der Dokumentation des einzelnen Datenbanktreibers.

Der Objektbefehl **columns** erlaubt dem Programm, die Verbindung nach den Namen der Spalten zu fragen, die in einer gegebenen Tabelle vorhanden sind. Der optionale Parameter **pattern** ist ein Muster, auf das der Name einer Spalte passen soll. Er darf die SQL-Platzhalterzeichen „**%**“ und „**\_**“ enthalten. Der Rückgabewert ist ein Dictionary, dessen Schlüssel Spaltennamen und dessen Werte Dictionarys sind. Jedes der untergeordneten Dictionarys enthält mindestens die folgenden Schlüssel und Werte (und darf weitere enthalten, deren Verwendung ein bestimmter Datenbanktreiber festlegt).

**type**
: Enthält den Datentyp der Spalte und wird im Allgemeinen aus der Menge **bigint**, **binary**, **bit**, **char**, **date**, **decimal**, **double**, **float**, **integer**, **longvarbinary**, **longvarchar**, **numeric**, **real**, **time**, **timestamp**, **smallint**, **tinyint**, **varbinary** und **varchar** gewählt. (Hat die Spalte einen Typ, der sich nicht als einer der genannten darstellen lässt, enthält **type** eine treiberabhängige Beschreibung des Typs.)

**precision**
: Enthält die Präzision der Spalte in Bit, Dezimalziffern oder die Breite in Zeichen, je nach Typ.

**scale**
: Enthält die Skala der Spalte (die Anzahl der Ziffern nach dem Radixpunkt) für Typen, die dieses Konzept kennen.

**nullable**
: Enthält 1, wenn die Spalte NULL-Werte enthalten kann, und andernfalls 0. Der Objektbefehl **primarykeys** erlaubt dem Programm, die Verbindung nach den Primärschlüsseln zu fragen, die zu einer gegebenen Tabelle gehören. Der Parameter *tableName* bezeichnet die abgefragte Tabelle. Das Ergebnis ist eine Liste von Dictionarys, die die Schlüssel aufzählen (in einem ähnlichen Format wie die Liste, die *\$connection* **allrows -as dicts** zurückgibt). Die Schlüssel des Dictionary dürfen mindestens die folgenden umfassen. Werte, die NULL sind oder in einer gegebenen Datenbank ohne Bedeutung sind, werden weggelassen.

**tableCatalog**
: Name des Katalogs, in dem die Tabelle erscheint.

**tableSchema**
: Name des Schemas, in dem die Tabelle erscheint.

**tableName**
: Name der Tabelle, der der Primärschlüssel gehört.

**constraintCatalog**
: Name des Katalogs, in dem das Primärschlüssel-Constraint erscheint. In manchen Datenbanksystemen muss das nicht derselbe Katalog sein wie der der Tabelle.

**constraintSchema**
: Name des Schemas, in dem das Primärschlüssel-Constraint erscheint. In manchen Datenbanksystemen muss das nicht dasselbe Schema sein wie das der Tabelle.

**constraintName**
: Name des Primärschlüssel-Constraints,

**columnName**
: Name einer Spalte, die Teil des Primärschlüssels ist.

**ordinalPosition**
: Ordnungsposition der Spalte innerhalb des Primärschlüssels. Diesen Spalten dürfen weitere hinzugefügt werden, die für ein bestimmtes Datenbanksystem spezifisch sind. Der Objektbefehl **foreignkeys** erlaubt dem Programm, die Verbindung nach Fremdschlüsselbeziehungen zu fragen, die für eine bestimmte Tabelle gelten. Die Beziehungen lassen sich auf die Schlüssel einschränken, die in einer bestimmten Tabelle erscheinen (**-foreign** *tableName*), auf die Schlüssel, die auf eine bestimmte Tabelle verweisen (**-primary** *tableName*), oder auf beides. Mindestens eines von **-primary** und **-foreign** sollte angegeben werden, obwohl manche Treiber alle Fremdschlüssel im aktuellen Katalog aufzählen, wenn beide Optionen entfallen. Das Ergebnis des Objektbefehls **foreignkeys** ist eine Liste von Dictionarys mit einem Listenelement je Schlüssel (in einem ähnlichen Format wie die Liste, die *\$connection* **allrows -as dicts** zurückgibt). Die Schlüssel des Dictionary dürfen mindestens die folgenden umfassen. Werte, die NULL sind oder in einer gegebenen Datenbank ohne Bedeutung sind, werden weggelassen.

**foreignConstraintCatalog**
: Katalog, in dem das Fremdschlüssel-Constraint erscheint.

**foreignConstraintSchema**
: Schema, in dem das Fremdschlüssel-Constraint erscheint.

**foreignConstraintName**
: Name des Fremdschlüssel-Constraints.

**primaryConstraintCatalog**
: Katalog, der das Primärschlüssel-Constraint (oder das Constraint eines eindeutigen Schlüssels) auf der Spalte hält, auf die der Fremdschlüssel verweist.

**primaryConstraintSchema**
: Schema, das das Primärschlüssel-Constraint (oder das Constraint eines eindeutigen Schlüssels) auf der Spalte hält, auf die der Fremdschlüssel verweist.

**primaryConstraintName**
: Name des Primärschlüssel-Constraints (oder des Constraints eines eindeutigen Schlüssels) auf der Spalte, auf die der Fremdschlüssel verweist.

**updateAction**
: Aktion, die auszuführen ist, wenn eine Anweisung UPDATE das Constraint ungültig macht. Der Wert ist **CASCADE**, **SET DEFAULT**, **SET NULL**, **RESTRICT** oder **NO ACTION**.

**deleteAction**
: Aktion, die auszuführen ist, wenn eine Anweisung DELETE das Constraint ungültig macht. Der Wert ist **CASCADE**, **SET DEFAULT**, **SET NULL**, **RESTRICT** oder **NO ACTION**.

**primaryCatalog**
: Name des Katalogs, in dem die Primärtabelle erscheint (diejenige, auf die der Fremdschlüssel verweist).

**primarySchema**
: Name des Schemas, in dem die Primärtabelle erscheint (diejenige, auf die der Fremdschlüssel verweist).

**primaryTable**
: Tabellenname der Primärtabelle (derjenigen, auf die der Fremdschlüssel verweist).

**primaryColumn**
: Name der Spalte, auf die der Fremdschlüssel verweist.

**foreignCatalog**
: Name des Katalogs, in dem die Tabelle erscheint, die den Fremdschlüssel enthält.

**foreignSchema**
: Name des Schemas, in dem die Tabelle erscheint, die den Fremdschlüssel enthält.

**foreignTable**
: Name der Tabelle, die den Fremdschlüssel enthält.

**foreignColumn**
: Name der Spalte, die im Fremdschlüssel erscheint.

**ordinalPosition**
: Position der Spalte im Fremdschlüssel, wenn der Schlüssel ein zusammengesetzter Schlüssel ist. Der Objektbefehl **begintransaction** auf einer Datenbankverbindung beginnt eine Transaktion auf der Datenbank. Unterstützt die zugrunde liegende Datenbank keine atomaren, konsistenten, isolierten und dauerhaften Transaktionen, gibt der Objektbefehl **begintransaction** einen Fehler zurück, der diesen Umstand meldet. Ebenso wird ein Fehler zurückgegeben, wenn mehrere Befehle **begintransaction** ohne einen dazwischenliegenden Befehl **commit** oder **rollback** ausgeführt werden, es sei denn, die zugrunde liegende Datenbank unterstützt verschachtelte Transaktionen. Der Objektbefehl **commit** auf einer Datenbankverbindung beendet die jüngste durch **begintransaction** begonnene Transaktion und schreibt die Änderungen in der Datenbank fest. Der Objektbefehl **rollback** auf einer Datenbankverbindung setzt die jüngste durch **begintransaction** begonnene Transaktion zurück. Der Zustand der Datenbank ist so, als wäre während der Transaktion nichts geschehen. Der Objektbefehl **transaction** auf einer Datenbankverbindung bietet einen einfachen Weg, eine Datenbanktransaktion zusammenzufassen. Er beginnt eine Transaktion und wertet das übergebene Argument *script* als Tcl-Skript im Geltungsbereich des Aufrufers aus. Endet *script* normal oder durch **break**, **continue** oder **return**, wird die Transaktion festgeschrieben (und jede von **break**, **continue** oder **return** verlangte Aktion findet statt). Schlägt das Festschreiben aus irgendeinem Grund fehl, wird der Fehler beim Festschreiben als Fehler im *script* behandelt. Bei einem Fehler in *script* oder beim Festschreiben wird die Transaktion zurückgesetzt und der Fehler erneut gemeldet. Jeder abweichende Rückgabecode des Skripts setzt die Transaktion zurück und wird danach erneut gemeldet. Der Objektbefehl **allrows** bereitet eine SQL-Anweisung vor (gegeben durch den Parameter *sql-code*), die gegen die Datenbank ausgeführt werden soll. Danach führt er sie aus (Einzelheiten bei **tdbc::statement**), wobei der optionale Parameter *dictionary* gebundene Variablen angibt. Anschließend verwendet er den Objektbefehl *allrows* auf der Ergebnismenge (siehe **tdbc::resultset**), um eine Liste der Ergebnisse aufzubauen. Anschließend werden Ergebnismenge und Anweisung geschlossen. Der Rückgabewert ist die Liste der Ergebnisse. Der Objektbefehl **foreach** bereitet eine SQL-Anweisung vor (gegeben durch den Parameter *sql-code*), die gegen die Datenbank ausgeführt werden soll. Danach führt er sie aus (Einzelheiten bei **tdbc::statement**), wobei der optionale Parameter *dictionary* gebundene Variablen angibt. Anschließend verwendet er den Objektbefehl *foreach* auf der Ergebnismenge (siehe **tdbc::resultset**), um das gegebene *script* für jede Ergebniszeile auszuwerten. Anschließend werden Ergebnismenge und Anweisung geschlossen, auch wenn das gegebene *script* ein **return**, einen Fehler oder einen ungewöhnlichen Rückgabecode ergibt.


# KONFIGURATIONSOPTIONEN

Die Konfigurationsoptionen, die beim Erzeugen der Verbindung und beim Objektbefehl **configure** der Verbindung akzeptiert werden, umfassen die folgenden und dürfen weitere umfassen, die für einen Datenbanktreiber spezifisch sind.

**-encoding** *name*
: Legt die Kodierung fest, die für die Verbindung zur Datenbank verwendet wird. *name* soll einer der Namen sein, die der Befehl **encoding** akzeptiert. Diese Option ist gewöhnlich unnötig; die meisten Datenbanktreiber ermitteln die verwendete Kodierung selbst.

**-isolation** *level*
: Legt die Isolationsstufe fest, die Transaktionen auf der Datenbank brauchen. Die zulässigen Werte für *level* stehen unter **ISOLATIONSSTUFEN VON TRANSAKTIONEN**.

**-timeout** *ms*
: Legt die Höchstdauer fest, die auf eine Operation der Datenbank-Engine gewartet wird, bevor dem Aufrufer ein Fehler gemeldet wird. Das Argument *ms* gibt die Höchstdauer in Millisekunden an. Der Wert null (die Vorgabe) legt fest, dass der aufrufende Prozess unbegrenzt auf Datenbankoperationen wartet.

**-readonly** *flag*
: Legt fest, dass die Verbindung die Datenbank nicht verändert (wenn der boolesche Parameter *flag* wahr ist) oder dass sie die Datenbank verändern darf (wenn *flag* falsch ist). Ist *flag* wahr, kann diese Option bewirken, dass die Isolationsstufe auf *readonly* angehoben wird.


## ISOLATIONSSTUFEN VON TRANSAKTIONEN

Die zulässigen Werte für die Konfigurationsoption **-isolation** sind:

**readuncommitted**
: Erlaubt der Transaktion, „dirty“, also unbestätigte Daten zu lesen. Diese Isolationsstufe kann die Datenintegrität gefährden, garantiert nicht, dass Fremdschlüssel oder Eindeutigkeitsbedingungen erfüllt sind, und garantiert allgemein keine Datenkonsistenz.

**readcommitted**
: Verbietet der Transaktion, „dirty“-Daten zu lesen, garantiert aber keine wiederholbaren Lesevorgänge. Liest eine Transaktion zu einem Zeitpunkt eine Zeile der Datenbank, gibt es keine Garantie, dass dieselbe Zeile später in derselben Transaktion noch verfügbar ist.

**repeatableread**
: Garantiert, dass jede einmal gelesene Zeile der Datenbank für die Dauer einer Transaktion dieselben Werte behält. „Phantom-Reads“ bleiben zulässig (neu hinzugekommene Zeilen, die erscheinen, wenn eine Tabelle ein zweites Mal abgefragt wird).

**serializable**
: Die strengste (und teuerste) Isolationsstufe. Jede Abfrage an die Datenbank liefert, wird sie wiederholt, für die Dauer der Transaktion genau dieselben Ergebnisse, so als wäre die Transaktion der einzige Benutzer der Datenbank.

**readonly**
: Verhält sich wie **serializable**, insofern der Transaktion nur Ergebnisse sichtbar sind, die vor dem Beginn der Transaktion festgeschrieben wurden, verbietet der Transaktion aber, die Datenbank zu verändern. Eine Datenbank, die eine dieser Isolationsstufen nicht umsetzt, verwendet stattdessen die nächststrengere Isolationsstufe. Lässt sich die angegebene Isolationsstufe nicht erreichen, meldet die Datenbankschnittstelle einen Fehler, der diesen Umstand nennt. Die voreingestellte Isolationsstufe ist **readcommitted**. Ein Skript soll die Isolationsstufe nicht ändern, während eine Transaktion läuft.


# COPYRIGHT

Copyright (c) 2008 by Kevin B. Kenny.
