---
CommandName: tdbc::resultset
ManualSection: n
Version: 8.6
TclPart: Tcl
TclDescription: Tcl Database Connectivity
Links:
 - encoding(n)
 - tdbc(n)
 - tdbc::connection(n)
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
 - bound variable
 - stored procedure
 - call
Copyright:
 - Copyright (c) 2008 by Kevin B. Kenny.
---

# NAME

tdbc::resultset - TDBC-Objekt für eine Ergebnismenge

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [tdbc]{.lit} [1.0]{.lit} 
[package]{.cmd} [require]{.sub} [tdbc::driver]{.lit} [version]{.lit} 

[tdbc::driver::connection]{.cmd} [create]{.sub} [db]{.arg} [-option value]{.optdot} 

[set]{.cmd} [stmt]{.arg} [\[db]{.lit} [prepare]{.lit} [sql-code\]]{.arg} 
[set]{.cmd} [resultset]{.arg} [\[\$stmt]{.lit} [execute]{.lit} [args...?\]]{.optarg} 

[\$resultset]{.ins} [columns]{.sub} 
[\$resultset]{.ins} [rowcount]{.sub} 
[\$resultset]{.ins} [nextrow]{.sub} [-as lists|dicts]{.optarg} [--]{.optlit} [varname]{.arg} 
[\$resultset]{.ins} [nextlist]{.sub} [varname]{.arg} 
[\$resultset]{.ins} [nextdict]{.sub} [varname]{.arg} 
[\$resultset]{.ins} [nextresults]{.sub} 
[\$resultset]{.ins} [foreach]{.sub} [-as lists|dicts]{.optarg} [-columnsvariable name]{.optarg} [--]{.optlit} [varname]{.arg} [script]{.arg} 
[\$resultset]{.ins} [close]{.sub} 
:::

.in 14 *\$resultset* **allrows** ?**-as lists|dicts**? ?**-columnsvariable** *name*? ?**--**?

# BESCHREIBUNG

Jeder Datenbanktreiber für TDBC (Tcl DataBase Connectivity) setzt ein Objekt *Ergebnismenge* um, das die Ergebnisse darstellt, die das Ausführen einer SQL-Anweisung in einer Datenbank zurückgibt. Instanzen dieses Objekts entstehen, indem der Objektbefehl **execute** auf einem Anweisungsobjekt ausgeführt wird.

Der Objektbefehl **columns** gibt eine Liste der Namen der Spalten in der Ergebnismenge zurück. Die Spalten erscheinen in derselben Reihenfolge, in der sie in der SQL-Anweisung standen, die die Datenbankabfrage ausgeführt hat. Gibt die SQL-Anweisung keine Menge von Spalten zurück (zum Beispiel, wenn es eine Anweisung INSERT, UPDATE oder DELETE ist), gibt der Befehl **columns** eine leere Liste zurück.

Der Objektbefehl **rowcount** gibt die Anzahl der Zeilen in der Datenbank zurück, die das Ausführen einer Anweisung INSERT, UPDATE oder DELETE betroffen hat. Für eine Anweisung SELECT ist die Zeilenzahl unbestimmt.

Der Objektbefehl **nextlist** setzt die durch *varname* gegebene Variable im Geltungsbereich des Aufrufers auf die nächste Ergebniszeile, ausgedrückt als Liste von Spaltenwerten. NULL-Werte werden durch leere Zeichenketten ersetzt. Die Spalten der Ergebniszeile erscheinen in derselben Reihenfolge, in der sie in der Anweisung SELECT standen. Die Rückgabe von **nextlist** ist **1**, wenn die Operation gelungen ist, und **0**, wenn das Ende der Ergebnismenge erreicht wurde.

Der Objektbefehl **nextdict** setzt die durch *varname* gegebene Variable im Geltungsbereich des Aufrufers auf die nächste Ergebniszeile, ausgedrückt als Dictionary. Die Schlüssel des Dictionary sind Spaltennamen, die Werte sind die Werte dieser Spalten in der Zeile. Ist der Wert einer Spalte in der Zeile NULL, entfällt ihr Schlüssel im Dictionary. Die Schlüssel erscheinen im Dictionary in derselben Reihenfolge, in der die Spalten in der Anweisung SELECT standen. Die Rückgabe von **nextdict** ist **1**, wenn die Operation gelungen ist, und **0**, wenn das Ende der Ergebnismenge erreicht wurde.

Der Objektbefehl **nextrow** ist genau gleichwertig zum Objektbefehl **nextdict** oder **nextlist**, je nachdem, ob **-as dicts** (die Vorgabe) oder **-as lists** angegeben ist.

Manche Datenbanken kennen die Vorstellung einer einzelnen Anweisung, die mehrere Ergebnismengen zurückgibt. Der Objektbefehl **nextresults** wird ausgeführt, gewöhnlich nachdem der Objektbefehl **nextlist** oder **nextdict** **0** zurückgegeben hat, um zur nächsten Ergebnismenge vorzurücken. Er gibt **1** zurück, wenn eine weitere Ergebnismenge zu verarbeiten ist, und **0**, wenn die gerade verarbeitete Ergebnismenge die letzte war. Nach dem Aufruf von **nextresults** mit dem Rückgabewert **1** darf der Aufrufer erneut **columns** aufrufen, um die Spaltenbeschreibungen der nächsten Ergebnismenge zu erhalten, und danach wieder **nextdict** oder **nextlist** aufrufen, um die Zeilen der nächsten Ergebnismenge zu verarbeiten. Es ist ein Fehler, **columns**, **nextdict**, **nextlist** oder **nextrow** aufzurufen, nachdem **nextresults** **0** zurückgegeben hat.

Der Objektbefehl **allrows** setzt die durch die Option **-columnsvariable** bezeichnete Variable (falls vorhanden) auf das Ergebnis des Objektbefehls **columns**. Danach führt er den Objektbefehl **nextrow** wiederholt aus, bis das Ende der Ergebnismenge erreicht ist. Gibt **nextresults** einen von null verschiedenen Wert zurück, führt er die beiden genannten Schritte aus (**columns**, gefolgt von wiederholten Aufrufen von **nextrow**), solange weitere Ergebnisse vorliegen. Die von **nextrow** zurückgegebenen Zeilen werden zu einer Tcl-Liste zusammengesetzt und werden der Rückgabewert des Befehls **allrows**; der letzte von **columns** zurückgegebene Wert ist das, was die Anwendung in **-columnsvariable** sieht.

Der Objektbefehl **foreach** setzt die durch die Option **-columnsvariable** bezeichnete Variable (falls vorhanden) auf das Ergebnis des Objektbefehls **columns**. Danach führt er den Objektbefehl **nextrow** wiederholt aus, bis das Ende der Ergebnismenge erreicht ist, und speichert die aufeinanderfolgenden Zeilen in der durch *varName* bezeichneten Variable. Für jede Zeile führt er das gegebene *script* aus. Endet das Skript mit einem Fehler, meldet der Befehl **foreach** den Fehler, und die Wiederholung endet. Führt das Skript eine Operation **break** aus, endet die Wiederholung vorzeitig. Führt das Skript eine Operation **continue** aus, setzt die Wiederholung mit der nächsten Zeile fort. Führt das Skript ein **return** aus, sind die Ergebnisse dieselben, als hätte ein Skript außerhalb der Steuerung von **foreach** zurückgegeben. Jeder andere ungewöhnliche Rückgabecode beendet die Wiederholung und wird von **foreach** gemeldet.

Sobald **nextrow** **0** zurückgibt, versucht der Objektbefehl **foreach**, mit **nextresults** zur nächsten Ergebnismenge vorzurücken. Gibt **nextresults** **1** zurück, werden die genannten Schritte (**columns** und **nextrow**, mit Aufruf des Skripts) wiederholt, solange weitere Ergebnismengen bleiben. Das *script* sieht die richtige Beschreibung der Spalten der aktuellen Ergebnismenge stets in der durch **-columnsvariable** bezeichneten Variable. Am Ende des Aufrufs enthält die durch **-columnsvariable** bezeichnete Variable die Beschreibung der Spalten der letzten Ergebnismenge.

Der Objektbefehl **close** löscht die Ergebnismenge und gibt alle zugehörigen Systemressourcen frei.

# COPYRIGHT

Copyright (c) 2008 by Kevin B. Kenny.
