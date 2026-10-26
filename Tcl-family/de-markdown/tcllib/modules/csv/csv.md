---
CommandName: csv
ManualSection: n
Version: 0.8.1
TclPart: tcllib
TclDescription: CSV processing
Links:
 - matrix
 - queue
Keywords:
 - csv
 - matrix
 - package
 - queue
 - tcllib
Copyright:
 - Copyright (c) 2002-2015 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

csv – Prozeduren zur Verarbeitung von CSV-Daten.

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [csv]{.lit} [0.8.1]{.optlit} 
[::csv::iscomplete]{.cmd} [data]{.arg} 
[::csv::join]{.cmd} [values]{.arg} [sepChar]{.optarg} [delChar]{.optarg} [delMode]{.optarg} 
[::csv::joinlist]{.cmd} [values]{.arg} [sepChar]{.optarg} [delChar]{.optarg} [delMode]{.optarg} 
[::csv::joinmatrix]{.cmd} [matrix]{.arg} [sepChar]{.optarg} [delChar]{.optarg} [delMode]{.optarg} 
[::csv::read2matrix]{.cmd} [-alternate]{.optlit} [chan]{.arg} [m]{.arg} { [sepChar]{.arg} , } { [expand]{.arg} none } 
[::csv::read2queue]{.cmd} [-alternate]{.optlit} [chan]{.arg} [q]{.arg} { [sepChar]{.arg} , } 
[::csv::report]{.cmd} [cmd]{.arg} [matrix]{.arg} [chan]{.optarg} 
[::csv::split]{.cmd} [-alternate]{.optlit} [line]{.arg} [sepChar]{.optarg} [delChar]{.optarg} 
[::csv::split2matrix]{.cmd} [-alternate]{.optlit} [m]{.arg} [line]{.arg} { [sepChar]{.arg} , } { [expand]{.arg} none } 
[::csv::split2queue]{.cmd} [-alternate]{.optlit} [q]{.arg} [line]{.arg} { [sepChar]{.arg} , } 
[::csv::writematrix]{.cmd} [m]{.arg} [chan]{.arg} [sepChar]{.optarg} [delChar]{.optarg} 
[::csv::writequeue]{.cmd} [q]{.arg} [chan]{.arg} [sepChar]{.optarg} [delChar]{.optarg} 
:::

# BESCHREIBUNG

Das **csv**-Paket bietet Befehle zur Bearbeitung von Daten im CSV-**FORMAT** (CSV = Comma Separated Values).

# BEFEHLE

Folgende Befehle stehen zur Verfügung:

**::csv::iscomplete** *data*
: Ein Prädikat, das prüft, ob das Argument *data* ein vollständiger CSV-Datensatz ist. Das Ergebnis ist ein boolescher Wert, der die Vollständigkeit der Daten angibt. Das Ergebnis ist „true“, wenn die Daten vollständig sind.

**::csv::join** *values* ?*sepChar*? ?*delChar*? ?*delMode*?
: Nimmt eine Liste von Werten entgegen und gibt eine Zeichenkette im CSV-Format zurück, die diese Werte enthält. Das Trennzeichen kann vom Aufrufer festgelegt werden, dies ist jedoch optional. Der Standardwert ist „,“. Das Anführungszeichen bzw. das Begrenzungszeichen kann vom Aufrufer festgelegt werden, dies ist jedoch optional. Der Standardwert ist '"'. Standardmäßig ist der Anführungsmodus *delMode* auf „auto“ gesetzt, sodass Werte nur bei Bedarf mit *delChar* umschlossen werden. Bei der Einstellung „always“ werden die Werte stattdessen jedoch immer mit *delChar* umschlossen.

**::csv::joinlist** *values* ?*sepChar*? ?*delChar*? ?*delMode*?
: Nimmt eine Liste von Listen mit Werten entgegen und gibt eine Zeichenkette im CSV-Format zurück, die diese Werte enthält. Das Trennzeichen kann vom Aufrufer festgelegt werden, dies ist jedoch optional. Der Standardwert ist „,“. Das Anführungszeichen kann vom Aufrufer festgelegt werden, dies ist jedoch optional. Der Standardwert ist '"'. Standardmäßig ist der Anführungsmodus *delMode* auf „auto“ gesetzt, sodass Werte nur bei Bedarf mit *delChar* umschlossen werden. Bei der Einstellung „always“ werden die Werte stattdessen jedoch immer mit *delChar* umschlossen. Jedes Element der äußeren Liste wird als Datensatz betrachtet; diese werden im Ergebnis durch Zeilenumbrüche getrennt. Die Elemente jedes Datensatzes werden wie üblich formatiert (über **::csv::join**).

**::csv::joinmatrix** *matrix* ?*sepChar*? ?*delChar*? ?*delMode*?
: Nimmt ein *Matrix*-Objekt entgegen, das der für das Paket struct::matrix festgelegten API entspricht, und gibt eine Zeichenkette im CSV-Format zurück, die diese Werte enthält. Das Trennzeichen kann vom Aufrufer festgelegt werden, dies ist jedoch optional. Der Standardwert ist „,“. Das Anführungszeichen kann vom Aufrufer festgelegt werden, dies ist jedoch optional. Der Standardwert ist \\'"'. Standardmäßig ist der Anführungsmodus *delMode* auf „auto“ gesetzt, sodass Werte nur bei Bedarf mit *delChar* umschlossen werden. Wenn die Einstellung „always“ gewählt ist, werden die Werte jedoch stattdessen immer von *delChar* umschlossen. Jede Zeile der Matrix wird als Datensatz betrachtet; diese sind im Ergebnis durch Zeilenumbrüche voneinander getrennt. Die Elemente jedes Datensatzes werden wie gewohnt formatiert (über **::csv::join**).

**::csv::read2matrix** ?**-alternate**? *chan m* {*sepChar* ,} {*expand* none}
: Ein Wrapper um **::csv::split2matrix** (siehe unten), der Zeilen im CSV-Format aus dem angegebenen Kanal liest (bis zum EOF) und sie der angegebenen Matrix hinzufügt. Eine Erläuterung des Arguments *expand* finden Sie unter **::csv::split2matrix**.

**::csv::read2queue** ?**-alternate**? *chan q* {*sepChar* ,}
: Ein Wrapper um **::csv::split2queue** (siehe unten), der Zeilen im CSV-Format aus dem angegebenen Kanal liest (bis zum EOF) und sie der angegebenen Warteschlange hinzufügt.

**::csv::report** *cmd matrix* ?*chan*?
: Ein Befehl, der von den Matrixmethoden **format 2string** und **format 2chan** verwendet werden kann. Bei letzterer leitet dieser Befehl die Aufgabe an **::csv::writematrix** weiter. *cmd* muss entweder **printmatrix** oder **printmatrix2channel** lauten. Das Kanal-Argument *chan* muss bei letzterem vorhanden sein, bei ersterem darf es nicht vorhanden sein.

**::csv::split** ?**-alternate**? *line* ?*sepChar*? ?*delChar*?
: Wandelt eine *Zeile* im CSV-Format in eine Liste der in dieser Zeile enthaltenen Werte um. Das Zeichen, mit dem die Werte voneinander getrennt werden, kann vom Aufrufer über *sepChar* festgelegt werden; dies ist jedoch optional. Der Standardwert ist „,“. Das Anführungszeichen kann vom Aufrufer festgelegt werden; dies ist jedoch optional. Der Standardwert ist '"'. Wenn die Option **-alternate** festgelegt ist, wird zum Parsen der Eingabe eine leicht abweichende Syntax verwendet. Diese Syntax wird weiter unten im Abschnitt **FORMAT** erläutert.

**::csv::split2matrix** ?**-alternate**? *m Zeile* {*sepChar* ,} {*expand* none}
: Entspricht **::csv::split**, fügt jedoch die resultierende Liste mithilfe der Methode **add row** als neue Zeile an die Matrix *m* an. Der über *expand* angegebene Erweiterungsmodus legt fest, wie der Befehl mit einer Matrix umgeht, die weniger Spalten hat als in *line* enthalten sind. Die zulässigen Modi sind:


**none**
: Dies ist der Standardmodus. In diesem Modus muss der Aufrufer sicherstellen, dass die Matrix über genügend Spalten verfügt, um die gesamte Zeile aufzunehmen. Sind nicht genügend Spalten vorhanden, wird die Werteliste am Ende ohne Fehlermeldung gekürzt, damit sie in die Matrix passt.

**empty**
: In diesem Modus erweitert der Befehl eine leere Matrix so, dass sie alle Spalten der angegebenen Zeile enthält, geht jedoch nicht darüber hinaus. Insgesamt hat dies zur Folge, dass die erste einer Reihe von Zeilen die Anzahl der Spalten in der Matrix bestimmt und alle folgenden Zeilen auf diese Größe gekürzt werden, als wäre der Modus **none** eingestellt.

**auto**
: In diesem Modus erweitert der Befehl die Matrix nach Bedarf, um alle in *line* enthaltenen Spalten aufzunehmen. Das hat insgesamt zur Folge, dass die Matrix nach dem Hinzufügen einer Reihe von Zeilen über genügend Spalten verfügt, um alle Spalten der bisher längsten Zeile aufzunehmen.


**::csv::split2queue** ?**-alternate**? *q line* {*sepChar* ,}
: Genau wie bei **::csv::split**, jedoch wird die resultierende Liste mithilfe der Methode **put** als einzelnes Element an die Warteschlange *q* angehängt.

**::csv::writematrix** *m chan* ?*sepChar*? ?*delChar*?
: Ein Wrapper um **::csv::join**, der alle Zeilen der Matrix *m* übernimmt und sie im CSV-Format in den Kanal *chan* schreibt.

**::csv::writequeue** *q chan* ?*sepChar*? ?*delChar*?
: Ein Wrapper um **::csv::join**, der alle Elemente der Warteschlange *q* (vorausgesetzt, es handelt sich um Listen) übernimmt und sie im CSV-Format in den Kanal *chan* schreibt.


# FORMAT

Das Format regulärer CSV-Dateien wird wie folgt festgelegt:

**\[1\]**
: Jeder Datensatz einer CSV-Datei (Comma-Separated Values, wie sie z. B. von Excel exportiert werden) besteht aus einer Reihe von ASCII-Werten, die durch „,“ getrennt sind. In anderen Sprachen kann das Trennzeichen jedoch auch „;“ sein; dies spielt in diesem Fall jedoch keine Rolle, da die hier bereitgestellten Funktionen jedes beliebige Trennzeichen zulassen.

**\[2\]**
: Genau dann, wenn ein Wert das Trennzeichen „,“ enthält, muss er (der Wert) in Anführungszeichen „“ gesetzt werden. Enthält der Wert das Trennzeichen nicht, ist die Verwendung von Anführungszeichen optional.

**\[3\]**
: Wenn ein Wert das Zeichen ", enthält, wird dieses Zeichen durch "" dargestellt.

**\[4\]**
: Die Ausgabekette "" steht für den Wert ". Mit anderen Worten: Es wird davon ausgegangen, dass sie ausschließlich durch Regel 3 erzeugt wurde, d. h., dass der Wert nicht in Anführungszeichen gesetzt wurde. Eine alternative Formatdefinition, die vor allem von MS-Produkten verwendet wird, legt fest, dass die Ausgabekette "" eine Darstellung der leeren Zeichenkette ist. Mit anderen Worten: Es wird davon ausgegangen, dass die Ausgabe durch Einfügen von Anführungszeichen in die leere Zeichenkette (d. h. Regel 2) und nicht durch Regel 3 erzeugt wurde. Dies ist der einzige Unterschied zwischen dem regulären und dem alternativen Format. Das alternative Format wird durch die Angabe der Option **-alternate** bei den verschiedenen Split-Befehlen aktiviert.


# BEISPIEL

Bei Verwendung des regulären Formats wird der Datensatz

```
123,"123,521.2","Mary says ""Hello, I am Mary""",""
```

wird in die einzelnen Elemente zerlegt

```
a) 123
b) 123,521.2
c) Mary says "Hello, I am Mary"
d) "
```

Bei Verwendung des alternativen Formats lautet das Ergebnis

```
a) 123
b) 123,521.2
c) Mary says "Hello, I am Mary"
d) (the empty string)
```

stattdessen. Wie Sie sehen, unterscheidet sich nur Punkt (d): Anstelle eines „.“ steht nun die leere Zeichenfolge.

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *csv* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Textverarbeitung

# COPYRIGHT

```
Copyright (c) 2002-2015 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
