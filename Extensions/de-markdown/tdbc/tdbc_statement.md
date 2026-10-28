---
CommandName: tdbc::statement
title: tdbc::statement
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Database Connectivity
Links:
 - encoding(n)
 - tdbc(n)
 - tdbc::connection(n)
 - tdbc::resultset(n)
 - tdbc::tokenize(n)
Keywords:
 - TDBC
 - SQL
 - database
 - connectivity
 - connection
 - resultset
 - statement
 - bound variable
 - stored procedure
 - call
Copyright:
 - Copyright (c) 2008 by Kevin B. Kenny.
---

# Name

tdbc::statement - TDBC-Objekt für eine Anweisung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc]{.lit} [1.0]{.lit}
[package]{.cmd} [require]{.sub} [tdbc::driver]{.lit} [version]{.lit}

[tdbc::driver::connection]{.cmd} [create]{.sub} [db]{.arg} [-option value...]{.optarg}

[set]{.cmd} [stmt]{.arg} [\[db]{.lit} [prepare]{.lit} [sql-code\]]{.arg}
[set]{.cmd} [stmt]{.arg} [\[db]{.lit} [preparecall]{.lit} [call\]]{.arg}

[$stmt]{.ins} [params]{.sub}
[$stmt]{.ins} [paramtype]{.sub} [direction]{.optarg} [type]{.arg} [precision]{.optarg} [scale]{.optarg}
[$stmt]{.ins} [execute]{.sub} [dict]{.optarg}
[$stmt]{.ins} [resultsets]{.sub}
[$stmt]{.ins} [allrows]{.sub} [-as lists|dicts]{.optlit} [[-columnsvariable]{.lit} [name]{.arg}]{.optarg} [--]{.optlit} [dict]{.optarg}
[$stmt]{.ins} [foreach]{.sub} [-as lists|dicts]{.optlit} [[-columnsvariable]{.lit} [name]{.arg}]{.optarg} [--]{.optlit} [varName]{.arg} [dict]{.optarg} [script]{.arg}
[$stmt]{.ins} [close]{.sub}
:::

# Beschreibung

Jeder Datenbanktreiber für TDBC (Tcl DataBase Connectivity) setzt ein Objekt *Anweisung* um, das eine SQL-Anweisung in einer Datenbank darstellt. Instanzen dieses Objekts entstehen, indem der Objektbefehl **prepare** oder **preparecall** auf einer Datenbankverbindung ausgeführt wird.

Der Objektbefehl **prepare** auf der Verbindung nimmt beliebigen SQL-Code entgegen, der gegen die Datenbank ausgeführt werden soll. Der SQL-Code darf *gebundene Variablen* enthalten. Das sind Zeichenketten aus alphanumerischen Zeichen oder Unterstrichen (das erste Zeichen der Zeichenkette darf nicht numerisch sein), denen ein Doppelpunkt (**:**) vorangestellt ist. Erscheint eine gebundene Variable in der SQL-Anweisung und steht sie weder in einer durch einfache oder doppelte Anführungszeichen abgesetzten Zeichenkette noch in einem mit **--** eingeleiteten Kommentar, wird sie zu einem Wert, der beim Ausführen der Anweisung eingesetzt wird. Eine gebundene Variable wird in der entstehenden Anweisung zu einem einzelnen Wert (Zeichenkette oder numerisch). *Die Treiber haben dafür zu sorgen, dass der Mechanismus zum Binden von Variablen SQL-Injection verhindert.*

Der Objektbefehl **preparecall** auf der Verbindung nimmt eine stilisierte Anweisung in der Form entgegen:

```
procname (?:varname? ?,:varname...?)
```

oder

```
varname = procname (?:varname? ?,:varname...?)
```

Diese Anweisung stellt einen Aufruf einer gespeicherten Prozedur *procname* in der Datenbank dar. Der Variablenname links vom Gleichheitszeichen (falls vorhanden) und alle Variablennamen, die Parameter innerhalb der Klammern sind, werden zu gebundenen Variablen.

Die Methode **params** auf einem Anweisungsobjekt zählt die gebundenen Variablen auf, die in der Anweisung vorkommen. Das von der Methode **params** zurückgegebene Ergebnis ist ein Dictionary, dessen Schlüssel die Namen der gebundenen Variablen sind (aufgeführt in der Reihenfolge, in der die Variablen zuerst in der Anweisung erscheinen) und dessen Werte Dictionarys sind. Die untergeordneten Dictionarys enthalten mindestens die folgenden Schlüssel (Datenbanktreiber dürfen weitere Schlüssel hinzufügen, die nicht in dieser Liste stehen).

**direction**
: Enthält eines der Schlüsselwörter **in**, **out** oder **inout**, je nachdem, ob die Variable eine Eingabe für die Anweisung oder eine Ausgabe aus ihr ist. Nur Aufrufe gespeicherter Prozeduren haben Parameter **out** oder **inout**.

**type**
: Enthält den Datentyp der Spalte und wird im Allgemeinen aus der Menge **bigint**, **binary**, **bit**, **char**, **date**, **decimal**, **double**, **float**, **integer**, **longvarbinary**, **longvarchar**, **numeric**, **real**, **time**, **timestamp**, **smallint**, **tinyint**, **varbinary** und **varchar** gewählt. (Hat die Variable einen Typ, der sich nicht als einer der genannten darstellen lässt, enthält **type** eine treiberabhängige Beschreibung des Typs.)

**precision**
: Enthält die Präzision der Spalte in Bit, Dezimalziffern oder die Breite in Zeichen, je nach Typ.

**scale**
: Enthält die Skala der Spalte (die Anzahl der Ziffern nach dem Radixpunkt) für Typen, die dieses Konzept kennen.

**nullable**
: Enthält 1, wenn die Spalte NULL-Werte enthalten kann, und andernfalls 0.


Der Objektbefehl **paramtype** erlaubt dem Skript, Typ und Richtung der Parameterübertragung einer Variable in einer Anweisung festzulegen. (Manche Datenbanken bieten keine Methode, diese Information automatisch zu ermitteln, und legen die Last dafür auf den Aufrufer.) Die Argumente *direction*, *type*, *precision*, *scale* und *nullable* haben dieselbe Bedeutung wie die entsprechenden Dictionary-Werte im Objektbefehl **params**.

Der Objektbefehl **execute** führt die Anweisung aus. Vor dem Ausführen der Anweisung werden Werte für die gebundenen Variablen bereitgestellt, die in ihr vorkommen. Ist der Parameter *dict* angegeben, wird darin nach einem Schlüssel gesucht, dessen Name zum Namen der gebundenen Variable passt. Ist der Schlüssel vorhanden, wird sein Wert zur eingesetzten Variable. Andernfalls wird der Wert der eingesetzten Variable ein SQL-NULL. Ist der Parameter *dict* *nicht* angegeben, sucht der Objektbefehl **execute** im Geltungsbereich des Aufrufers nach einer Variable, deren Name zum Namen der gebundenen Variable passt. Wird eine gefunden, wird ihr Wert zum Wert der gebundenen Variable. Wird keine gefunden, erhält die gebundene Variable ein SQL-NULL als Wert. Sobald die Ersetzung abgeschlossen ist, wird die entstehende Anweisung ausgeführt. Der Rückgabewert ist ein Ergebnismengenobjekt (Einzelheiten stehen bei **tdbc::resultset**).

Die Methode **resultsets** gibt eine Liste aller Ergebnismengen zurück, die das Ausführen der Anweisung geliefert hat und die noch nicht geschlossen wurden.

Der Objektbefehl **allrows** führt die Anweisung wie der Objektbefehl **execute** aus und nimmt einen optionalen Parameter *dict* entgegen, der gebundene Variablen angibt. Nach dem Ausführen der Anweisung verwendet er den Objektbefehl *allrows* auf der Ergebnismenge (siehe **tdbc::resultset**), um eine Liste der Ergebnisse aufzubauen. Anschließend wird die Ergebnismenge geschlossen. Der Rückgabewert ist die Liste der Ergebnisse.

Der Objektbefehl **foreach** führt die Anweisung wie der Objektbefehl **execute** aus und nimmt einen optionalen Parameter *dict* entgegen, der gebundene Variablen angibt. Nach dem Ausführen der Anweisung verwendet er den Objektbefehl *foreach* auf der Ergebnismenge (siehe **tdbc::resultset**), um das gegebene *script* für jede Ergebniszeile auszuwerten. Anschließend wird die Ergebnismenge geschlossen, auch wenn das gegebene *script* ein **return**, einen Fehler oder einen ungewöhnlichen Rückgabecode ergibt.

Der Objektbefehl **close** entfernt eine Anweisung und alle Ergebnismengen, die sie erzeugt hat. Alle den Objekten zugeordneten Systemressourcen werden freigegeben.

# Beispiele

Der folgende Code schlägt eine Telefonnummer in einem Verzeichnis nach, ein passendes SQL-Schema vorausgesetzt:

```
package require tdbc::sqlite3
tdbc::sqlite3::connection create db phonebook.sqlite3
set statement [db prepare {
    select phone_num from directory
    where first_name = :firstname and last_name = :lastname
}]
set firstname Fred
set lastname Flintstone
$statement foreach row {
    puts [dict get $row phone_num]
}
$statement close
db close
```

# Copyright

Copyright (c) 2008 by Kevin B. Kenny.
