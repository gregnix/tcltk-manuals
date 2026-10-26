---
CommandName: struct::matrix
ManualSection: n
Version: 2.2
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - matrix
Copyright:
 - Copyright (c) 2002-2013,2019,2022 Andreas Kupries <andreas.kupries@gmail.com>
---

# NAME

struct::matrix – Matrixobjekte erzeugen und bearbeiten

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [struct::matrix]{.lit} [2.2]{.optlit} 
[::struct::matrix]{.cmd} [aMatrix]{.optarg} [=|:=|as|deserialize source]{.optarg} 
[aMatrix]{.cmd} [option]{.arg} [arg arg]{.optdot} 
[aMatrix]{.ins} [=]{.sub} [sourceMatrix]{.arg} 
[aMatrix]{.ins} [-->]{.sub} [destMatrix]{.arg} 
[aMatrix]{.ins} [add]{.sub} [column]{.lit} [values]{.optarg} 
[aMatrix]{.ins} [add]{.sub} [columns]{.lit} [n]{.arg} 
[aMatrix]{.ins} [add]{.sub} [row]{.lit} [values]{.optarg} 
[aMatrix]{.ins} [add]{.sub} [rows]{.lit} [n]{.arg} 
[aMatrix]{.ins} [cells]{.sub} 
[aMatrix]{.ins} [cellsize]{.sub} [column]{.arg} [row]{.arg} 
[aMatrix]{.ins} [columns]{.sub} 
[aMatrix]{.ins} [columnwidth]{.sub} [column]{.arg} 
[aMatrix]{.ins} [delete]{.sub} [column]{.lit} [column]{.arg} 
[aMatrix]{.ins} [delete]{.sub} [columns]{.lit} [n]{.arg} 
[aMatrix]{.ins} [delete]{.sub} [row]{.lit} [row]{.arg} 
[aMatrix]{.ins} [delete]{.sub} [rows]{.lit} [n]{.arg} 
[aMatrix]{.ins} [deserialize]{.sub} [serialization]{.arg} 
[aMatrix]{.ins} [destroy]{.sub} 
[aMatrix]{.ins} [format]{.sub} [2string]{.lit} [report]{.optarg} 
[aMatrix]{.ins} [format]{.sub} [2chan]{.lit} [?report]{.optarg} [channel?]{.arg} 
[aMatrix]{.ins} [get]{.sub} [cell]{.lit} [column]{.arg} [row]{.arg} 
[aMatrix]{.ins} [get]{.sub} [column]{.lit} [column]{.arg} 
[aMatrix]{.ins} [get]{.sub} [rect]{.lit} [column_tl]{.arg} [row_tl]{.arg} [column_br]{.arg} [row_br]{.arg} 
[aMatrix]{.ins} [get]{.sub} [row]{.lit} [row]{.arg} 
[aMatrix]{.ins} [insert]{.sub} [column]{.lit} [column]{.arg} [values]{.optarg} 
[aMatrix]{.ins} [insert]{.sub} [row]{.lit} [row]{.arg} [values]{.optarg} 
[aMatrix]{.ins} [link]{.sub} [-transpose]{.optarg} [arrayvar]{.arg} 
[aMatrix]{.ins} [links]{.sub} 
[aMatrix]{.ins} [rowheight]{.sub} [row]{.arg} 
[aMatrix]{.ins} [rows]{.sub} 
[aMatrix]{.ins} [search]{.sub} [-nocase]{.optarg} [-exact|-glob|-regexp]{.optarg} [all]{.lit} [pattern]{.arg} 
[aMatrix]{.ins} [search]{.sub} [-nocase]{.optarg} [-exact|-glob|-regexp]{.optarg} [column]{.lit} [column]{.arg} [pattern]{.arg} 
[aMatrix]{.ins} [search]{.sub} [-nocase]{.optarg} [-exact|-glob|-regexp]{.optarg} [row]{.lit} [row]{.arg} [pattern]{.arg} 
[aMatrix]{.ins} [search]{.sub} [-nocase]{.optarg} [-exact|-glob|-regexp]{.optarg} [rect]{.lit} [column_tl]{.arg} [row_tl]{.arg} [column_br]{.arg} [row_br]{.arg} [pattern]{.arg} 
[aMatrix]{.ins} [serialize]{.sub} [column_tl row_tl column_br row_br]{.optarg} 
[aMatrix]{.ins} [set]{.sub} [cell]{.lit} [column]{.arg} [row]{.arg} [value]{.arg} 
[aMatrix]{.ins} [set]{.sub} [column]{.lit} [column]{.arg} [values]{.arg} 
[aMatrix]{.ins} [set]{.sub} [rect]{.lit} [column]{.arg} [row]{.arg} [values]{.arg} 
[aMatrix]{.ins} [set]{.sub} [row]{.lit} [row]{.arg} [values]{.arg} 
[aMatrix]{.ins} [sort]{.sub} [columns]{.lit} [-increasing|-decreasing]{.optlit} [row]{.arg} 
[aMatrix]{.ins} [sort]{.sub} [rows]{.lit} [-increasing|-decreasing]{.optlit} [column]{.arg} 
[aMatrix]{.ins} [swap]{.sub} [columns]{.lit} [column_a]{.arg} [column_b]{.arg} 
[aMatrix]{.ins} [swap]{.sub} [rows]{.lit} [row_a]{.arg} [row_b]{.arg} 
[aMatrix]{.ins} [transpose]{.sub} 
[aMatrix]{.ins} [unlink]{.sub} [arrayvar]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt einen Befehl zum Erzeugen von Matrizen bereit und Unterbefehle, mit denen sich erzeugte Matrizen bearbeiten lassen.

Eine Matrix ist eine rechteckige Anordnung von Zellen in Zeilen und Spalten. Jede Zelle enthält einen einzelnen Wert beliebiger Art. Jede Zelle lässt sich über ein Paar bei **0** beginnender ganzer Zahlen ansprechen, in der Form {column, row}.

Der besondere nichtnumerische Index **end** spricht je nach Zusammenhang die letzte Zeile oder die letzte Spalte einer Matrix an. Indizes der Form **end**-**number** werden vom Ende der Zeile oder Spalte gezählt, genau wie bei gewöhnlichen Tcl-Listen.

Ein Index außerhalb des gültigen Bereichs löst einen Fehler aus.

Vorgabe ist, dass jede Matrix leer erzeugt wird. Neue Zeilen und Spalten lassen sich nach Bedarf hinzufügen.

Eine Matrix kann eine Array-Sicht auf ihren Inhalt bereitstellen. Damit kann zum Beispiel *tkTable* die Matrix in die Anzeige einbinden.

Der Hauptbefehl dieses Pakets ist:

**::struct::matrix** ?*aMatrix*? ?**=**|**:=**|**as**|**deserialize** *source*?
: Dieser Befehl erzeugt ein neues Matrixobjekt mit einem zugehörigen globalen Tcl-Befehl, dessen Name *aMatrix* ist. Mit diesem Befehl lassen sich verschiedene Operationen auf der Matrix ausführen. Er hat die folgende allgemeine Form:


**aMatrix** *option* ?*arg arg ...*?
: *option* und die *arg*s legen fest, was der Befehl tut.


Ist *aMatrix* nicht angegeben, erzeugt das Paket selbst einen eindeutigen Namen. Ist eine *source* angegeben, wird die neue Matrix daraus initialisiert. Bei den Operatoren **=**, **:=** und **as** gilt das Argument *source* als Name eines anderen Matrixobjekts, und der Zuweisungsoperator **=** wird ausgeführt. Bei **deserialize** ist *source* ein serialisiertes Matrixobjekt, und **deserialize** wird ausgeführt.

Mit anderen Worten

```
    ::struct::matrix mymatrix = b
```

entspricht

```
    ::struct::matrix mymatrix
    mymatrix = b
```

und

```
    ::struct::matrix mymatrix deserialize $b
```

entspricht

```
    ::struct::matrix mymatrix
    mymatrix deserialize $b
```

Matrixobjekte stellen die folgenden Befehle bereit:

*aMatrix* **=** *sourceMatrix*
: Der Operator **=** ist der *Zuweisungs*operator für Matrixobjekte. (Dieser Operator lässt sich als **=**, **:=** oder **as** schreiben.) Er kopiert die Matrix aus dem Matrixobjekt *sourceMatrix* über die Matrixdaten in *aMatrix*. Der bisherige Inhalt von *aMatrix* wird bei dieser Operation gelöscht. Die Operation entspricht praktisch


```
    aMatrix deserialize [sourceMatrix serialize]
```

*aMatrix* **-->** *destMatrix*
: Der Operator **-->** ist der Operator der *umgekehrten Zuweisung* für Matrixobjekte. Er kopiert die Matrix aus dem Matrixobjekt *aMatrix* über die Matrixdaten im Objekt *destMatrix*. Der bisherige Inhalt von *destMatrix* wird bei dieser Operation gelöscht. Die Operation entspricht praktisch


```
    destMatrix deserialize [aMatrix serialize]
```

*aMatrix* **add column** ?*values*?
: Erweitert die Matrix um eine Spalte hinter der letzten Spalte. Ist kein *values* angegeben, werden die neuen Zellen auf die leere Zeichenkette gesetzt. Sind *values* *angegeben*, wendet diese Methode praktisch **set column** (siehe unten) auf die neu hinzugefügte Spalte an.

*aMatrix* **add columns** *n*
: Erweitert die Matrix um *n* Spalten hinter der letzten Spalte und setzt alle neuen Zellen auf die leere Zeichenkette. Ist *n* *<= 0*, wird ein Fehler ausgelöst.

*aMatrix* **add row** ?*values*?
: Erweitert die Matrix um eine Zeile hinter der letzten Zeile. Ist kein *values* angegeben, werden die neuen Zellen auf die leere Zeichenkette gesetzt. Sind *values* *angegeben*, wendet diese Methode praktisch **set row** (siehe unten) auf die neu hinzugefügte Zeile an.

*aMatrix* **add rows** *n*
: Erweitert die Matrix um *n* Zeilen hinter der letzten Zeile und setzt alle neuen Zellen auf die leere Zeichenkette. Ist *n* *<= 0*, wird ein Fehler ausgelöst.

*aMatrix* **cells**
: Gibt die Zahl der Zellen zurück, die die Matrix derzeit verwaltet. Das ist das Produkt aus **rows** und **columns**.

*aMatrix* **cellsize** *column row*
: Gibt die Länge der Zeichenkettendarstellung des Werts zurück, den die angesprochene Zelle derzeit enthält.

*aMatrix* **columns**
: Gibt die Zahl der Spalten zurück, die die Matrix derzeit verwaltet.

*aMatrix* **columnwidth** *column*
: Gibt die Länge der längsten Zeichenkettendarstellung aller Werte zurück, die die Zellen der angesprochenen Spalte derzeit enthalten, sofern diese alle nur eine Zeile umfassen. Bei Zellwerten über mehrere Zeilen geht die Länge ihrer längsten Zeile in die Berechnung ein. *Hinweis:* Der Befehl erkennt ANSI-Farbsteuersequenzen und nimmt sie aus der Breite einer Zeile heraus, weil sie logisch die Breite null haben. *Hinweis:* Der Befehl erkennt asiatische Zeichen doppelter Breite und berücksichtigt sie. *Mit anderen Worten* ist die zurückgegebene Länge die Zahl der Terminalspalten, die die Zeichenkette belegt, und nicht die Zahl der Zeichen.

*aMatrix* **delete column** *column*
: Löscht die angegebene Spalte aus der Matrix und rückt alle Spalten mit höherem Index um einen Index nach unten.

*aMatrix* **delete columns** *n*
: Löscht *n* Spalten von rechts aus der Matrix. Der Wert von *n* muss die Bedingung "0 < *n* < \[**aMatrix** **columns**\]" erfüllen.

*aMatrix* **delete row** *row*
: Löscht die angegebene Zeile aus der Matrix und rückt alle Zeilen mit höherem Index um einen Index nach unten.

*aMatrix* **delete rows** *n*
: Löscht *n* Zeilen von unten aus der Matrix. Der Wert von *n* muss die Bedingung "0 < *n* < \[**aMatrix** **rows**\]" erfüllen.

*aMatrix* **deserialize** *serialization*
: Das ist das Gegenstück zu **serialize**. Sie ersetzt die Matrixdaten in *aMatrix* durch die Matrix, die der Wert *serialization* beschreibt. Der bisherige Inhalt von *aMatrix* wird bei dieser Operation gelöscht.

*aMatrix* **destroy**
: Zerstört die Matrix, einschließlich ihres Speichers und des zugehörigen Befehls.

*aMatrix* **format 2string** ?*report*?
: Formatiert die Matrix mit dem angegebenen Berichtsobjekt und gibt die Zeichenkette mit dem Ergebnis dieser Operation zurück. Der Bericht muss die Methode **printmatrix** unterstützen. Ist kein *report* angegeben, verwendet das System eine interne Berichtsdefinition, um die Matrix zu formatieren.

*aMatrix* **format 2chan** ??*report*? *channel*?
: Formatiert die Matrix mit dem angegebenen Berichtsobjekt und schreibt die Zeichenkette mit dem Ergebnis dieser Operation in den Kanal. Der Bericht muss die Methode **printmatrix2channel** unterstützen. Ist kein *report* angegeben, verwendet das System eine interne Berichtsdefinition, um die Matrix zu formatieren. Ist kein *channel* angegeben, verwendet das System **stdout**.

*aMatrix* **get cell** *column row*
: Gibt den Wert zurück, den die durch Zeilen- und Spaltenindex bestimmte Zelle derzeit enthält.

*aMatrix* **get column** *column*
: Gibt eine Liste mit den Werten aus allen Zellen der durch den Index bestimmten Spalte zurück. Der Inhalt der Zelle in Zeile 0 steht als erstes Element dieser Liste.

*aMatrix* **get rect** *column_tl row_tl column_br row_br*
: Gibt eine Liste von Listen mit Zellwerten zurück. Die im Ergebnis gespeicherten Werte stammen aus der Teilmatrix, deren Zellen links oben und rechts unten durch *column_tl, row_tl* bzw. *column_br, row_br* bestimmt sind. Dabei müssen die folgenden Gleichungen gelten: "*column_tl* <= *column_br*" und "*row_tl* <= *row_br*". Das Ergebnis ist so aufgebaut: Die äußere Liste ist die Liste der Zeilen, ihre Elemente sind Listen, die eine einzelne Zeile darstellen. Die Zeile mit dem kleinsten Index ist das erste Element der äußeren Liste. Die Elemente der Zeilenlisten stellen die ausgewählten Zellwerte dar. Die Zelle mit dem kleinsten Index ist das erste Element jeder Zeilenliste.

*aMatrix* **get row** *row*
: Gibt eine Liste mit den Werten aus allen Zellen der durch den Index bestimmten Zeile zurück. Der Inhalt der Zelle in Spalte 0 steht als erstes Element dieser Liste.

*aMatrix* **insert column** *column* ?*values*?
: Erweitert die Matrix um eine Spalte und verhält sich dann wie **set column** (siehe unten) auf dieser neuen Spalte, falls *values* angegeben wurden. Ohne *values* werden die neuen Zellen auf die leere Zeichenkette gesetzt. Die neue Spalte wird unmittelbar vor der Spalte mit dem angegebenen Index eingefügt. Das heißt: Ist *column* kleiner oder gleich null, wird die neue Spalte am Anfang der Matrix eingefügt, vor der ersten Spalte. Hat *column* den Wert **end**, oder ist er größer oder gleich der Zahl der Spalten in der Matrix, wird die neue Spalte an die Matrix angehängt, hinter die letzte Spalte. Die alte Spalte am gewählten Index und alle Spalten mit höherem Index rücken um einen Index nach oben.

*aMatrix* **insert row** *row* ?*values*?
: Erweitert die Matrix um eine Zeile und verhält sich dann wie **set row** (siehe unten) auf dieser neuen Zeile, falls *values* angegeben wurden. Ohne *values* werden die neuen Zellen auf die leere Zeichenkette gesetzt. Die neue Zeile wird unmittelbar vor der Zeile mit dem angegebenen Index eingefügt. Das heißt: Ist *row* kleiner oder gleich null, wird die neue Zeile am Anfang der Matrix eingefügt, vor der ersten Zeile. Hat *row* den Wert **end**, oder ist er größer oder gleich der Zahl der Zeilen in der Matrix, wird die neue Zeile an die Matrix angehängt, hinter die letzte Zeile. Die alte Zeile an diesem Index und alle Zeilen mit höherem Index rücken um einen Index nach oben.

*aMatrix* **link** ?-transpose? *arrayvar*
: Verknüpft die Matrix mit der angegebenen Array-Variable. Der Inhalt aller Zellen der Matrix liegt damit auch im Array, und alle Änderungen an der Matrix werden ebenfalls dorthin übertragen. Der Inhalt der Zelle *(column,row)* wird im Array unter dem Schlüssel *column,row* gespeichert. Ist die Option **-transpose** angegeben, wird stattdessen der Schlüssel *row,column* verwendet. Die Matrix lässt sich mit mehr als einem Array verknüpfen. Die Verknüpfung geht in beide Richtungen, Änderungen am Array werden also auch in der Matrix gespiegelt.

*aMatrix* **links**
: Gibt eine Liste mit den Namen aller Array-Variablen zurück, mit denen die Matrix durch einen Aufruf der Methode **link** verknüpft wurde.

*aMatrix* **rowheight** *row*
: Gibt die Höhe der angegebenen Zeile in Textzeilen zurück. Das ist die größte Zahl von Textzeilen, die eine Zelle unter allen Zellen der Zeile einnimmt.

*aMatrix* **rows**
: Gibt die Zahl der Zeilen zurück, die die Matrix derzeit verwaltet.

*aMatrix* **search** ?-nocase? ?-exact|-glob|-regexp? **all** *pattern*
: Durchsucht die ganze Matrix nach Zellen, die auf das *pattern* passen, und gibt eine Liste aller Treffer zurück. Jeder Eintrag dieser Liste ist selbst eine Liste und enthält den Spalten- und den Zeilenindex der passenden Zelle, in dieser Reihenfolge. Die Ergebnisse sind zuerst nach der Spalte und dann nach der Zeile geordnet, beides aufsteigend. Treffer links und oben in der Matrix stehen damit vor Treffern rechts und unten. Die Art des Musters (Zeichenkette, Glob, regulärer Ausdruck) bestimmt die Option nach dem Schlüsselwort **search**. Fehlt die Option, gilt **-exact**. Ist die Option **-nocase** angegeben, unterscheidet die Suche nicht zwischen Groß- und Kleinschreibung.

*aMatrix* **search** ?-nocase? ?-exact|-glob|-regexp? **column** *column pattern*
: Wie **search all**, die Suche ist aber auf die angegebene Spalte beschränkt.

*aMatrix* **search** ?-nocase? ?-exact|-glob|-regexp? **row** *row pattern*
: Wie **search all**, die Suche ist aber auf die angegebene Zeile beschränkt.

*aMatrix* **search** ?-nocase? ?-exact|-glob|-regexp? **rect** *column_tl row_tl column_br row_br pattern*
: Wie **search all**, die Suche ist aber auf den angegebenen rechteckigen Bereich der Matrix beschränkt.

*aMatrix* **serialize** ?*column_tl row_tl column_br row_br*?
: Diese Methode serialisiert die Teilmatrix, die die Rechteckangabe aufspannt. Sie gibt also einen Tcl-*Wert* zurück, der diese Matrix vollständig beschreibt. Ist kein Rechteck angegeben, wird die ganze Matrix serialisiert. So lassen sich Matrixobjekte (oder Teile davon) zum Beispiel über beliebige Kanäle übertragen, dauerhaft ablegen und so weiter. Diese Methode ist auch die Grundlage für den Kopierkonstruktor und den Zuweisungsoperator. Das Ergebnis dieser Methode muss über alle Implementierungen der Matrixschnittstelle semantisch gleich sein. Erst dadurch lassen sich Matrixdaten zwischen verschiedenen Implementierungen derselben Schnittstelle kopieren. Das Ergebnis ist eine Liste mit genau drei Elementen. Die ersten beiden Elemente der Liste geben die Zahl der Zeilen und der Spalten der Matrix an, in dieser Reihenfolge. Die Werte sind ganze Zahlen größer oder gleich null. Das letzte Element der Liste enthält die Werte der serialisierten Matrixzellen, in der Form eines Wertes, wie ihn **get rect** zurückgibt. Leere Zellen rechts und unten in der Matrix dürfen in diesem Wert jedoch fehlen, weil die Größenangabe in der Serialisierung dem Empfänger erlaubt, trotz der fehlenden Werte eine Matrix der richtigen Größe zu erzeugen.


```
    # A possible serialization for the matrix structure
    #
    # | a b d g |
    # | c e     |
    # | f       |
    #
    # is
    #
    # 3 4 {{a b d g} {c e} {f}}
```

*aMatrix* **set cell** *column row value*
: Setzt den Wert in der durch Zeilen- und Spaltenindex bestimmten Zelle auf die Daten im dritten Argument.

*aMatrix* **set column** *column values*
: Setzt die Werte in den durch den Spaltenindex bestimmten Zellen auf die Elemente der Liste, die als drittes Argument übergeben wird. Jedes Element der Liste wird einer Zelle zugewiesen, das erste Element der Zelle in Zeile 0 und dann nach oben. Enthält die Liste weniger Werte, als Zeilen vorhanden sind, werden die übrigen Zeilen auf die leere Zeichenkette gesetzt. Enthält die Liste mehr Werte, als Zeilen vorhanden sind, werden die überzähligen Elemente ignoriert. Die Matrix wird durch diese Operation nicht erweitert.

*aMatrix* **set rect** *column row values*
: Nimmt eine Liste von Listen mit Zellwerten und schreibt sie in die Teilmatrix, deren Zelle links oben durch die beiden Indizes bestimmt ist. Sind die Teillisten der äußeren Liste nicht gleich lang, werden die kürzeren Teillisten mit leeren Zeichenketten auf die Länge der längsten Teilliste aufgefüllt. Reicht die durch die Zelle links oben und die Zahl der Zeilen und Spalten in *values* bestimmte Teilmatrix über die Matrix hinaus, die geändert wird, werden die überstehenden Teile der Werte ignoriert, also praktisch abgeschnitten. Dieser Unterbefehl erwartet seine Eingabe in dem Format, das **get rect** zurückgibt.

*aMatrix* **set row** *row values*
: Setzt die Werte in den durch den Zeilenindex bestimmten Zellen auf die Elemente der Liste, die als drittes Argument übergeben wird. Jedes Element der Liste wird einer Zelle zugewiesen, das erste Element der Zelle in Spalte 0 und dann nach oben. Enthält die Liste weniger Werte, als Spalten vorhanden sind, werden die übrigen Spalten auf die leere Zeichenkette gesetzt. Enthält die Liste mehr Werte, als Spalten vorhanden sind, werden die überzähligen Elemente ignoriert. Die Matrix wird durch diese Operation nicht erweitert.

*aMatrix* **sort columns** ?**-increasing**|**-decreasing**? *row*
: Sortiert die Spalten der Matrix und verwendet die Daten in der angegebenen *row* als Sortierschlüssel. Die Optionen **-increasing** und **-decreasing** haben dieselbe Bedeutung wie bei **lsort**. Fehlt die Option, wird **-increasing** angenommen.

*aMatrix* **sort rows** ?**-increasing**|**-decreasing**? *column*
: Sortiert die Zeilen der Matrix und verwendet die Daten in der angegebenen *column* als Sortierschlüssel. Die Optionen **-increasing** und **-decreasing** haben dieselbe Bedeutung wie bei **lsort**. Fehlt die Option, wird **-increasing** angenommen.

*aMatrix* **swap columns** *column_a column_b*
: Vertauscht den Inhalt der beiden angegebenen Spalten.

*aMatrix* **swap rows** *row_a row_b*
: Vertauscht den Inhalt der beiden angegebenen Zeilen.

*aMatrix* **transpose**
: Transponiert den Inhalt der Matrix, vertauscht also Zeilen gegen Spalten und umgekehrt.

*aMatrix* **unlink** *arrayvar*
: Hebt die Verknüpfung zwischen der Matrix und der angegebenen Array-Variable auf, falls eine besteht.


# BEISPIELE

Die Beispiele unten setzen eine Matrix M von 5x5 voraus, deren erste Zeile die Werte 1 bis 5 enthält, mit 1 in der Zelle links oben. Jede weitere Zeile enthält den Inhalt der Zeile darüber, um eine Zelle nach rechts gedreht.

```
 % M get rect 0 0 4 4
 {{1 2 3 4 5} {5 1 2 3 4} {4 5 1 2 3} {3 4 5 1 2} {2 3 4 5 1}}
```

```
 % M set rect 1 1 {{0 0 0} {0 0 0} {0 0 0}}
 % M get rect 0 0 4 4
 {{1 2 3 4 5} {5 0 0 0 4} {4 0 0 0 3} {3 0 0 0 2} {2 3 4 5 1}}
```

Sind die Stildefinitionen aus dem Beispielabschnitt der Manpage zum Paket **report** jetzt in den Interpreter geladen, folgt ein Beispiel, das eine Matrix als tabellarischen Bericht formatiert. Der Code, der die Matrix mit Daten füllt, ist nicht gezeigt. enthält nützliche Daten.

```
    % ::struct::matrix m
    % # ... fill m with data, assume 5 columns
    % ::report::report r 5 style captionedtable 1
    % m format 2string r
    +---+-------------------+-------+-------+--------+
    |000|VERSIONS:          |2:8.4a3|1:8.4a3|1:8.4a3%|
    +---+-------------------+-------+-------+--------+
    |001|CATCH return ok    |7      |13     |53.85   |
    |002|CATCH return error |68     |91     |74.73   |
    |003|CATCH no catch used|7      |14     |50.00   |
    |004|IF if true numeric |12     |33     |36.36   |
    |005|IF elseif          |15     |47     |31.91   |
    |   |true numeric       |       |       |        |
    +---+-------------------+-------+-------+--------+
    %
    % # alternate way of doing the above
    % r printmatrix m
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: matrix* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Datenstrukturen

# COPYRIGHT

```
Copyright (c) 2002-2013,2019,2022 Andreas Kupries <andreas.kupries@gmail.com>
```
