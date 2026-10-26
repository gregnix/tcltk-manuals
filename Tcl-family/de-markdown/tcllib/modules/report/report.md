---
CommandName: report
title: report
ManualSection: n
Version: 0.5
TclPart: tcllib
TclDescription: Matrix reports
Keywords:
 - matrix
 - report
 - table
Copyright:
 - Copyright (c) 2002-2014,2022 Andreas Kupries <andreas.kupries@gmail.com>
---

# Name

report – Berichtsobjekte erstellen und bearbeiten

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [report]{.lit} [0.5]{.optlit}
[::report::report]{.cmd} [reportName]{.arg} [columns]{.arg} [[style]{.lit} [style]{.arg} arg...]{.optarg}
[reportName]{.cmd} [option]{.arg} [arg arg]{.optdot}
[::report::defstyle]{.cmd} [styleName]{.arg} [arguments]{.arg} [script]{.arg}
[::report::rmstyle]{.cmd} [styleName]{.arg}
[::report::stylearguments]{.cmd} [styleName]{.arg}
[::report::stylebody]{.cmd} [styleName]{.arg}
[::report::styles]{.cmd}
[reportName]{.ins} [destroy]{.sub}
[reportName]{.ins} [templatecode]{.sub} [disable|enable]{.lit}
[reportName]{.ins} [templatecode]{.sub} [enabled]{.lit}
[reportName]{.ins} [templatecode]{.sub} [get]{.lit}
[reportName]{.ins} [templatecode]{.sub} [set]{.lit} [templatedata]{.arg}
[reportName]{.ins} [tcaption]{.sub} [size]{.optarg}
[reportName]{.ins} [bcaption]{.sub} [size]{.arg}
[reportName]{.ins} [size]{.sub} [column]{.arg} [number|dyn]{.optarg}
[reportName]{.ins} [sizes]{.sub} [size-list]{.optarg}
[reportName]{.ins} [pad]{.sub} [column]{.arg} [[left|right|both]{.lit} [padstring]{.optarg}]{.optarg}
[reportName]{.ins} [justify]{.sub} [column]{.arg} [left|right|center]{.optlit}
[reportName]{.ins} [printmatrix]{.sub} [matrix]{.arg}
[reportName]{.ins} [printmatrix2channel]{.sub} [matrix]{.arg} [chan]{.arg}
[reportName]{.ins} [columns]{.sub}
:::

# Beschreibung

Dieses Paket stellt Berichtsobjekte bereit, die von den Formatierungsmethoden der Matrixobjekte verwendet werden können, um tabellarische Berichte der Matrix in verschiedenen Formen zu erstellen. Die hier definierten Berichtsobjekte unterteilen jeden Bericht in drei [Regionen] und zehn Klassen von *Zeilen* (verschiedene Trenn- und Datenzeilen). Ausführlichere Erläuterungen finden Sie im folgenden Abschnitt.

**::report::report** *reportName* *columns* ?**style** *style arg...*?
: Erstellt ein neues Berichtsobjekt für einen Bericht mit *columns* Spalten, dem ein globaler Tcl-Befehl mit dem Namen *reportName* zugeordnet ist. Mit diesem Befehl lassen sich verschiedene Vorgänge der Konfiguration für den Bericht ausführen. Er hat die folgende allgemeine Form:

    **reportName** *option* ?*arg arg ...*?
    : Die *Option* und die *arg* bestimmen das genaue Verhalten des Befehls. Weitere Erläuterungen finden Sie im Abschnitt [Berichtsmethoden]. Wenn kein **style** festgelegt wird, verwendet der Bericht den integrierten Stil **plain** als Standard-Konfiguration.


**::report::defstyle** *styleName arguments script*
: Definiert den neuen Stil *styleName*. Weitere Informationen finden Sie im Abschnitt [Styles].

**::report::rmstyle** *styleName*
: Löscht den Stil *styleName*. Der Versuch, einen unbekannten oder integrierten Stil zu löschen, führt zu einer Fehlermeldung. Beachten Sie, dass dieser Befehl nicht überprüft, ob andere Stile von dem zu löschenden Stil abhängig sind. Das Löschen eines Stils, der noch von einem anderen Stil FOO verwendet wird, führt zu einem Laufzeitfehler, wenn FOO auf einen neu instanziierten Bericht angewendet wird.

**::report::stylearguments** *styleName*
: Dieser Befehl gibt die Liste der Argumente zurück, die dem Stil *styleName* zugeordnet sind.

**::report::stylebody** *styleName*
: Dieser Introspektionsbefehl gibt das Skript zurück, das dem Stil *styleName* zugeordnet ist.

**::report::styles**
: Dieser Introspektionsbefehl gibt eine Liste zurück, die die Namen aller Stile enthält, die dem Paket zum Zeitpunkt des Aufrufs bekannt sind. Die Reihenfolge der Namen in der Liste entspricht der Reihenfolge, in der die Styles erstellt wurden. Mit anderen Worten: Das erste Element ist der vordefinierte Stil „**plain**“, gefolgt vom ersten vom Benutzer definierten Stil und so weiter.


# Regionen

Die drei Bereiche sind die *obere Beschriftung*, der *Datenbereich* und die *untere Beschriftung*. Dabei handelt es sich, grob gesagt, um den Titel, die zu darstellenden Werte und eine Beschriftung am unteren Rand. Die Größe der Beschriftungsbereiche kann vom Benutzer als Anzahl der Zeilen festgelegt werden, die sie in der zu formatierenden Matrix einnehmen. Die Größe des Datenbereichs wird implizit festgelegt.

# Zeilen

[Vorlagen] sind den zehn Linienklassen zugeordnet und legen die Formatierung für die jeweilige Linienart fest. Der Benutzer kann die Trennlinien nach Belieben aktivieren und deaktivieren, nicht jedoch die Datenzeilen. Ihre Verwendung richtet sich ausschließlich nach der Anzahl der Zeilen, die in den drei Bereichen enthalten sind. Datenzeilen und alle aktivierten Trennlinien müssen einer Vorlage zugeordnet sein.

Hinweis: Die Datenzeilen in einem Bericht und die Zeilen in der Matrix, aus der der Bericht erstellt wurde, weisen *keine* 1:1-Beziehung auf, wenn eine beliebige Zeile in der Matrix eine Höhe von mehr als eins aufweist.

Die verschiedenen Arten von Zeilen und die Codes, die von den Berichtsmethoden zur Kennzeichnung dieser Zeilen verwendet werden, sind:

**top**
: Die oberste Zeile eines Berichts. Sie trennt den Bericht von allem, was davor steht. Der Benutzer kann die Verwendung dieser Zeile nach Belieben aktivieren.

**topdatasep**
: Diese Zeile dient dazu, die Datenzeilen im oberen Beschriftungsbereich voneinander zu trennen, wenn dieser mehr als eine Zeile enthält und der Benutzer die Verwendung dieser Zeile aktiviert hat.

**topcapsep**
: Diese Zeile dient dazu, den oberen Beschriftungsbereich und den Datenbereich voneinander zu trennen, wenn der obere Beschriftungsbereich nicht leer ist und der Benutzer die Verwendung dieser Funktion aktiviert hat.

**datasep**
: Diese Zeile dient dazu, die Datenzeilen im Datenbereich voneinander zu trennen, wenn dieser mehr als eine Zeile enthält und der Benutzer diese Funktion aktiviert hat.

**botcapsep**
: Diese Zeile dient dazu, den Datenbereich und den Bereich für die untere Beschriftung voneinander zu trennen, wenn die untere Beschriftung nicht leer ist und der Benutzer deren Verwendung aktiviert hat.

**botdatasep**
: Diese Zeile dient dazu, die Datenzeilen im unteren Beschriftungsbereich voneinander zu trennen, wenn dieser mehr als eine Zeile enthält und der Benutzer die Verwendung dieser Zeile aktiviert hat.

**bottom**
: Die unterste Zeile eines Berichts. Sie trennt den Bericht von allem, was danach folgt. Der Benutzer kann die Verwendung dieser Zeile nach Belieben aktivieren.

**topdata**
: Diese Zeile legt das Format der Datenzeilen im oberen Kopfbereich des Berichts fest.

**data**
: Diese Zeile legt das Format der Datenzeilen im Datenbereich des Berichts fest.

**botdata**
: Diese Zeile legt das Format der Datenzeilen im unteren Beschriftungsbereich des Berichts fest.


# Vorlagen

Jede Vorlage ist eine Liste von Zeichenfolgen, die zur Formatierung der Zeile verwendet werden, der sie zugeordnet ist. Bei einem Bericht, der die Spalten „**n**“ enthält, muss eine Vorlage für eine Datenzeile „**n**+1“ Elemente und eine Vorlage für eine Trennzeile „2\***n**+1“ Elemente enthalten.

Die Elemente in einer Datenvorlage legen die Zeichenfolgen fest, die zur Trennung der Informationen über die Spalten verwendet werden. Zusammen mit den entsprechenden Elementen in den Trennzeichenvorlagen bilden sie die vertikalen Linien im Bericht.

*Hinweis*: Die entsprechenden Einträge in allen definierten Vorlagen müssen dieselbe Länge aufweisen. Dies wird vom Berichtsobjekt überprüft. Der erste Eintrag definiert die linke vertikale Linie und der letzte Eintrag die rechte vertikale Linie. Der Eintrag am Index **k** („1“, …, „**n**-2“) trennt die Informationen in den Spalten „**k**-1“ und „**k**“.

Die Einträge in einer Trennzeichenvorlage mit einem geraden Index („0“, „2“, …) legen die Trennzeichen für die Spalten fest. Der Eintrag am Index „2\***k**“ („0“, „2“, …, „2\***n**“) entspricht den Einträgen am Index „**k**“ in den Datenvorlagen.

Die Einträge in einer Trennzeichenvorlage mit ungeraden Indizes („1“, „3“, …) legen die Zeichenfolgen fest, aus denen die horizontalen Linien in den Trennzeilen gebildet werden. Das Element am Index „2\***k**+1“ („1“, „3“, …, „2\***n**+1“) entspricht der Spalte „**k**“. Bei der Erzeugung der horizontalen Linien werden die Elemente so lange dupliziert, bis sie mindestens die Länge ihrer Spalten erreichen, und anschließend auf die exakte Größe zugeschnitten.

# Styles

Mithilfe von Styles kann der Benutzer dieses Pakets allgemeine Konfigurationen für Berichtsobjekte festlegen und diese später bei der eigentlichen Instanziierung der Berichtsobjekte verwenden. Sie werden als TCL-Skripte definiert, die bei ihrer Ausführung das Berichtsobjekt entsprechend der gewünschten Konfiguration einrichten.

Der Befehl zum Definieren von Stilen lautet **::report::defstyle**. Sein letztes Argument ist der TCL-Befehl **script**, der die eigentliche Neukonfiguration des Berichtsobjekts durchführt, um den gewünschten Stil zu erzielen.

In diesem Skript stehen die Namen aller zuvor definierten Stile als Befehle zur Verfügung, ebenso wie alle Befehle, die in einem sicheren Interpreter zu finden sind, sowie die Methoden der Konfiguration von Berichtsobjekten. Letztere wirken implizit auf das Objekt, das das Stilskript gerade ausführt. Die hier deklarierten **arguments** stehen im **script** als Variablen zur Verfügung. Beim Aufruf des Befehls eines zuvor deklarierten Stils müssen alle von diesem erwarteten Argumente im Aufruf definiert werden.

# Berichtsmethoden

Für Berichtsobjekte sind folgende Befehle möglich:

*reportName* **destroy**
: Löscht den Bericht einschließlich seines Speicherplatzes und des zugehörigen Befehls.

*reportName* *templatecode* **disable**|**enable**
: Aktiviert oder deaktiviert die Verwendung der Vorlage, auf die der *templatecode* verweist. Hier sind ausschließlich Codes für Trennlinien zulässig. Es ist nicht möglich, Datenzeilen zu aktivieren oder zu deaktivieren.

    Durch die Aktivierung einer Vorlage überprüft der Bericht alle verwendeten Vorlagen auf Inkonsistenzen in den Definitionen der vertikalen Linien (siehe Abschnitt [Vorlagen]).

*reportName* *templatecode* **enabled**
: Gibt zurück, ob die durch *templatecode* angegebene Vorlage derzeit aktiviert ist oder nicht.

*reportName* *templatecode* **get**
: Gibt die Vorlage zurück, die derzeit dem durch den *templatecode* angegebenen Zeilentyp zugeordnet ist. Hier sind alle bekannten templatecodes zulässig.

*reportName* *templatecode* **set** *templatedata*
: Legt die Vorlage fest, die mit der durch den *templatecode* bezeichneten Zeilenart verknüpft ist, und setzt sie auf den neuen Wert in *templatedata*. Informationen zu den Constraints hinsichtlich der Länge von Vorlagen finden Sie im Abschnitt [Vorlagen].

*reportName* **tcaption** ?*size*?
: Legt die *size* des oberen Beschriftungsbereichs als die Anzahl der Zeilen fest, die er in der zu formatierenden Matrix einnimmt. Es sind nur Zahlen größer oder gleich Null zulässig. Wird keine *size* angegeben, gibt der Befehl stattdessen die aktuelle Größe zurück.

    Wird die Größe der oberen Beschriftung auf einen Wert größer als Null gesetzt, wird die entsprechende Datenvorlage aktiviert und der Bericht überprüft alle verwendeten Vorlagen auf Inkonsistenzen in den Definitionen der vertikalen Linien (siehe Abschnitt [Vorlagen]).

*reportName* **bcaption** *size*
: Legt die *size* des unteren Beschriftungsbereichs als die Anzahl der Zeilen fest, die er in der zu formatierenden Matrix einnimmt. Es sind nur Zahlen größer oder gleich Null zulässig. Wird keine *size* angegeben, gibt der Befehl stattdessen die aktuelle Größe zurück.

    Wird die Größe der unteren Beschriftung auf einen Wert größer als Null gesetzt, wird die entsprechende Datenvorlage aktiviert und der Bericht überprüft alle verwendeten Vorlagen auf Inkonsistenzen in den Definitionen der vertikalen Linien (siehe Abschnitt [Vorlagen]).

*reportName* **size** *column* ?*number*|**dyn**?
: Legt die Breite der *column* in der Ausgabe fest. Der Wert **dyn** bedeutet, dass die von der zu formatierenden Matrix für die angegebene Spalte zurückgegebene Spaltenbreite verwendet werden soll. Die Formatierung der Spalte erfolgt dynamisch. Wird anstelle von **dyn** eine feste *number* verwendet, bedeutet dies, dass die Spalte eine Breite von genau dieser Anzahl an Zeichen hat (ohne Innenabstand). Hier sind nur Zahlen größer als Null zulässig.

    Wird keine Größenangabe gemacht, gibt der Befehl stattdessen die aktuelle Größe der *column* zurück.

*reportName* **sizes** ?*size-list*?
: Mit dieser Methode kann der Benutzer die Breiten aller Spalten in einem einzigen Aufruf festlegen. Als Argument dient eine Liste, die die den Spalten zuzuordnenden Breiten enthält. Das erste Element wird der Spalte 0 zugeordnet, das nächste der Spalte 1 und so weiter.

    Wird keine *Breitenliste* angegeben, gibt der Befehl stattdessen eine Liste zurück, die die aktuell eingestellten Breiten enthält.

*reportName* **pad** *column* ?**left**|**right**|**both** ?*padstring*??
: Mit dieser Methode kann der Benutzer einen Innenabstand auf der linken, rechten oder beiden Seiten einer *column* festlegen. Wenn das *padstring* nicht angegeben wird, wird standardmäßig ein einzelnes Leerzeichen verwendet. *Hinweis*: Eine alternative Möglichkeit, den Innenabstand festzulegen, besteht darin, in den Vorlagen vertikale Trennzeichen zu verwenden, die länger als ein Zeichen sind (siehe Abschnitt [Vorlagen]).

    Wenn überhaupt keine Ausrichtungsangabe gemacht wird, gibt der Befehl stattdessen den aktuellen Zustand des Innenabstands der Spalten zurück. Dabei handelt es sich um eine Liste mit zwei Elementen, wobei das erste Element die linke Ausrichtung und das zweite die rechte Ausrichtung beschreibt.

*reportName* **justify** *column* ?**left**|**right**|**center**?
: Legt fest, wie die Werte der Zellen für eine *column* in den Bericht eingefügt werden, unter Berücksichtigung der angegebenen Spaltenbreite im Bericht.

    Bei den Ausrichtungsarten **left** und **right** wird ein Wert, der kürzer als die Breite der Spalten ist, mit seiner benannten Kante an die entsprechende Kante der Spalten gebunden. Die andere Seite wird mit Leerzeichen aufgefüllt. Im Fall von **center** werden die Leerzeichen auf beiden Seiten des Wertes platziert, wobei die Anzahl der Leerzeichen auf der linken Seite höchstens um eins größer ist als die auf der rechten Seite.

    Bei einem Wert, der länger ist als die Breite der Spalte, wird der Wert an der benannten Kante abgeschnitten. Dies bedeutet bei der Ausrichtung **left**, dass der *Endteil* (d. h. der Teil **right**) des Werts in der Ausgabe sichtbar gemacht wird. Bei „**center**“ wird der Wert an beiden Seiten gekürzt, um in die Spalten zu passen, und die Anzahl der Zeichen, die auf der linken Seite des Werts gekürzt werden, ist höchstens um eins geringer als die Anzahl der Zeichen, die auf der rechten Seite gekürzt werden.

    Wurde keine Ausrichtung festgelegt, gibt der Befehl stattdessen die aktuelle Ausrichtung der Spalten zurück.

*reportName* **printmatrix** *matrix*
: Formatiert die *matrix* entsprechend der Konfiguration des Berichts und gibt die resultierende Zeichenfolge zurück. Die Matrix muss dieselbe Anzahl an Spalten wie der Bericht aufweisen. Die Matrix muss zudem über genügend Zeilen verfügen, damit sich die oberen und unteren Beschriftungsbereiche nicht überlappen. Der Datenbereich darf leer sein.

*reportName* **printmatrix2channel** *matrix chan*
: Formatiert die *matrix* entsprechend der Konfiguration des Berichts und schreibt das Ergebnis in den Kanal *chan*. Die Matrix muss dieselbe Anzahl an Spalten wie der Bericht aufweisen. Die Matrix muss zudem über genügend Zeilen verfügen, damit sich die oberen und unteren Beschriftungsbereiche nicht überlappen. Der Datenbereich darf leer sein.

*reportName* **columns**
: Gibt die Anzahl der Spalten im Bericht zurück.


Die Methoden **size**, **pad** und **justify** nehmen alle einen Index für eine Spalte als erstes Argument entgegen. Dieser Index darf alle Formen eines Indexes verwenden, die vom Befehl **lindex** akzeptiert werden. Der zulässige Bereich für Indizes lautet „0, ...,\[**reportName** Spalten\]-1“.

# Beispiele

Unsere Beispiele definieren einige allgemein nützliche Berichtsstyles.

Eine einfache Tabelle mit Rahmen um alle Informationen und vertikalen Trennlinien, jedoch ohne interne horizontale Trennlinien.

```
    ::report::defstyle simpletable {} {
	data	set [split "[string repeat "| "   [columns]]|"]
	top	set [split "[string repeat "+ - " [columns]]+"]
	bottom	set [top get]
	top	enable
	bottom	enable
    }
```

Eine Erweiterung des oben genannten **simpletable** mit einem Titelbereich.

```
    ::report::defstyle captionedtable {{n 1}} {
	simpletable
	topdata   set [data get]
	topcapsep set [top get]
	topcapsep enable
	tcaption $n
    }
```

Ausgehend von den obigen Definitionen folgt nun ein Beispiel, bei dem eine Matrix tatsächlich in einen tabellarischen Bericht umgewandelt wird. Dabei wird davon ausgegangen, dass die Matrix tatsächlich aussagekräftige Daten enthält.

```
    % ::struct::matrix m
    % # ... fill m with data, assume 5 columns
    % ::report::report r 5 style captionedtable 1
    % r printmatrix m
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
    % m format 2string r
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *report* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Datenstrukturen

# Copyright

```
Copyright (c) 2002-2014,2022 Andreas Kupries <andreas.kupries@gmail.com>
```
