---
CommandName: struct::list
title: struct::list
ManualSection: n
Version: 1.9
TclPart: tcllib
TclDescription: Tcl Data Structures
Keywords:
 - Fisher-Yates
 - assign
 - common
 - comparison
 - diff
 - differential
 - equal
 - equality
 - filter
 - first permutation
 - flatten
 - folding
 - full outer join
 - generate permutations
 - inner join
 - join
 - left outer join
 - list
 - longest common subsequence
 - map
 - next permutation
 - outer join
 - permutation
 - reduce
 - repeating
 - repetition
 - reshuffle
 - reverse
 - right outer join
 - shuffle
 - subsequence
 - swapping
Copyright:
 - Copyright (c) 2003-2005 by Kevin B. Kenny. All rights reserved
 - Copyright (c) 2003-2012 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# Name

struct::list – Prozeduren zur Bearbeitung von Listen

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [struct::list]{.lit} [1.9]{.optlit}
[::struct::list]{.cmd} [longestCommonSubsequence]{.lit} [sequence1]{.arg} [sequence2]{.arg} [maxOccurs]{.optarg}
[::struct::list]{.cmd} [longestCommonSubsequence2]{.lit} [sequence1]{.arg} [sequence2]{.arg} [maxOccurs]{.optarg}
[::struct::list]{.cmd} [lcsInvert]{.lit} [lcsData]{.arg} [len1]{.arg} [len2]{.arg}
[::struct::list]{.cmd} [lcsInvert2]{.lit} [lcs1]{.arg} [lcs2]{.arg} [len1]{.arg} [len2]{.arg}
[::struct::list]{.cmd} [lcsInvertMerge]{.lit} [lcsData]{.arg} [len1]{.arg} [len2]{.arg}
[::struct::list]{.cmd} [lcsInvertMerge2]{.lit} [lcs1]{.arg} [lcs2]{.arg} [len1]{.arg} [len2]{.arg}
[::struct::list]{.cmd} [reverse]{.lit} [sequence]{.arg}
[::struct::list]{.cmd} [shuffle]{.lit} [list]{.arg}
[::struct::list]{.cmd} [assign]{.lit} [sequence]{.arg} [varname]{.arg} [varname?...]{.optarg}
[::struct::list]{.cmd} [flatten]{.lit} [-full]{.optlit} [--]{.optlit} [sequence]{.arg}
[::struct::list]{.cmd} [map]{.lit} [sequence]{.arg} [cmdprefix]{.arg}
[::struct::list]{.cmd} [mapfor]{.lit} [var]{.arg} [sequence]{.arg} [script]{.arg}
[::struct::list]{.cmd} [filter]{.lit} [sequence]{.arg} [cmdprefix]{.arg}
[::struct::list]{.cmd} [filterfor]{.lit} [var]{.arg} [sequence]{.arg} [expr]{.arg}
[::struct::list]{.cmd} [split]{.lit} [sequence]{.arg} [cmdprefix]{.arg} [passVar failVar]{.optarg}
[::struct::list]{.cmd} [fold]{.lit} [sequence]{.arg} [initialvalue]{.arg} [cmdprefix]{.arg}
[::struct::list]{.cmd} [shift]{.lit} [listvar]{.arg}
[::struct::list]{.cmd} [iota]{.lit} [n]{.arg}
[::struct::list]{.cmd} [equal]{.lit} [-simple]{.optlit} [--]{.optlit} [a]{.arg} [b]{.arg}
[::struct::list]{.cmd} [repeat]{.lit} [size]{.arg} [element1]{.arg} [element2 element3...]{.optarg}
[::struct::list]{.cmd} [repeatn]{.lit} [value]{.arg} [size...]{.arg}
[::struct::list]{.cmd} [dbJoin]{.lit} [-inner|-left|-right|-full]{.optlit} [[-keys]{.lit} [varname]{.arg}]{.optarg} {keycol table}...
[::struct::list]{.cmd} [dbJoinKeyed]{.lit} [-inner|-left|-right|-full]{.optlit} [[-keys]{.lit} [varname]{.arg}]{.optarg} [table...]{.arg}
[::struct::list]{.cmd} [swap]{.lit} [listvar]{.arg} [i]{.arg} [j]{.arg}
[::struct::list]{.cmd} [firstperm]{.lit} [list]{.arg}
[::struct::list]{.cmd} [nextperm]{.lit} [perm]{.arg}
[::struct::list]{.cmd} [permutations]{.lit} [list]{.arg}
[::struct::list]{.cmd} [foreachperm]{.lit} [var]{.arg} [list]{.arg} [body]{.arg}
:::

# Beschreibung

Der Namespace **::struct::list** enthält mehrere nützliche Befehle zur Verarbeitung von Tcl-Listen. Im Allgemeinen implementieren diese Befehle Algorithmen, die komplexer oder spezialisierter sind als die von Tcl selbst bereitgestellten.

Er exportiert nur einen einzigen Befehl: **struct::list**. Alle hier bereitgestellten Funktionen sind über einen Unterbefehl dieses Befehls erreichbar.

# Befehle

**::struct::list** **longestCommonSubsequence** *sequence1* *sequence2* ?*maxOccurs*?
: Gibt eine Liste von Indizes in *sequence1* zurück und eine zugehörige Liste, in der jedes Element der Index des übereinstimmenden Werts in *sequence2* ist, nach dem Algorithmus der längsten gemeinsamen Teilfolge.  Wenn *maxOccurs* angegeben ist, beschränkt sich die gemeinsame Teilfolge auf Elemente, die in *sequence2* höchstens *maxOccurs* Mal vorkommen.

**::struct::list** **longestCommonSubsequence2** *sequence1 sequence2* ?*maxOccurs*?
: Gibt die längste gemeinsame Teilfolge der Elemente in den beiden Listen *sequence1* und *sequence2* zurück. Ist *maxOccurs* angegeben, ist das Ergebnis nur eine Näherung: Zunächst wird die längste gemeinsame Folge nur jener Elemente ermittelt, die in *sequence2* höchstens *maxOccurs* Mal vorkommen; mit diesem Ergebnis werden dann die beiden Listen aneinander ausgerichtet, und für die Teillisten zwischen den beiden Elementen werden die längsten gemeinsamen Teilfolgen bestimmt.

    Das Ergebnis entspricht dem von **longestCommonSubsequence**.

**::struct::list** **lcsInvert** *lcsData* *len1* *len2*
: Nimmt eine Beschreibung einer längsten gemeinsamen Teilfolge (*lcsData*) entgegen, invertiert sie und gibt das Ergebnis zurück. Invertieren heißt hier: Die Eingabe beschreibt, welche Teile der beiden Sequenzen identisch sind, die Ausgabe beschreibt stattdessen die Unterschiede.

    Damit das Ergebnis vollständig bestimmt ist, müssen die Längen der beiden Sequenzen bekannt sein; sie werden über *len1* und *len2* angegeben.

    Das Ergebnis ist eine Liste, in der jedes Element einen Block der Unterschiede zwischen den beiden Sequenzen beschreibt. Diese Beschreibung ist eine Liste aus drei Elementen: einem Typ und zwei Indexpaaren in *sequence1* bzw. *sequence2*, in dieser Reihenfolge. Der Typ kann einen von drei Werten annehmen:

    **added**
    : Beschreibt eine Ergänzung. Das heißt, Elemente, die in *sequence1* fehlen, sind in *sequence2* zu finden. Das Indexpaar in *sequence1* beschreibt, an welcher Stelle in *sequence1* der hinzugefügte Bereich erwartet worden wäre. Der erste Index bezieht sich auf das Element unmittelbar vor dem hinzugefügten Bereich, und der zweite Index bezieht sich auf das Element unmittelbar nach dem hinzugefügten Bereich. Das Indexpaar in *sequence2* beschreibt den Bereich der Elemente, der dort hinzugefügt wurde. Der erste Index bezieht sich auf das erste Element in diesem Bereich, und der zweite Index bezieht sich auf das letzte Element in diesem Bereich.

    **deleted**
    : Beschreibt eine Löschung. Das heißt, Elemente, die in *sequence1* enthalten sind, fehlen in *sequence2*. Das Indexpaar in *sequence1* beschreibt den Bereich der Elemente, der gelöscht wurde. Der erste Index bezieht sich auf das erste Element in diesem Bereich, und der zweite Index bezieht sich auf das letzte Element in diesem Bereich. Das Indexpaar in *sequence2* beschreibt, an welcher Stelle in *sequence2* der gelöschte Bereich erwartet worden wäre. Der erste Index bezieht sich auf das Element unmittelbar vor dem gelöschten Bereich, und der zweite Index bezieht sich auf das Element unmittelbar nach dem gelöschten Bereich.

    **changed**
    : Beschreibt eine allgemeine Änderung. Das heißt, ein Bereich von Elementen in *sequence1* wurde durch einen anderen Bereich von Elementen in *sequence2* ersetzt. Das Indexpaar in *sequence1* beschreibt den Bereich der Elemente, der ersetzt wurde. Der erste Index bezieht sich auf das erste Element des Bereichs, und der zweite Index bezieht sich auf das letzte Element des Bereichs. Das Indexpaar in *sequence2* beschreibt den Bereich der Elemente, der den ursprünglichen Bereich ersetzt. Auch hier bezieht sich der erste Index auf das erste Element des Bereichs, und der zweite Index bezieht sich auf das letzte Element des Bereichs.


    ```
        sequence 1 = {a b r a c a d a b r a}
        lcs 1      =   {1 2   4 5     8 9 10}
        lcs 2      =   {0 1   3 4     5 6 7}
        sequence 2 =   {b r i c a     b r a c}

        Inversion  = {{deleted  {0  0} {-1 0}}
                      {changed  {3  3}  {2 2}}
                      {deleted  {6  7}  {4 5}}
                      {added   {10 11}  {8 8}}}
    ```

    *Hinweise:*

    - Ein Index **-1** in einem *deleted*-Block bezieht sich auf die Stelle unmittelbar vor dem ersten Element der zweiten Sequenz.

    - Ebenso verweist ein Index in einem *added*-Block, der gleich der Länge der ersten Sequenz ist, auf die Stelle unmittelbar hinter dem Ende der Sequenz.


**::struct::list** **lcsInvert2** *lcs1* *lcs2* *len1* *len2*
: Ähnlich wie **lcsInvert**. Anstatt das Ergebnis eines Aufrufs von **longestCommonSubsequence** direkt zu übernehmen, erwartet dieser Unterbefehl die Indizes der beiden Sequenzen in zwei separaten Listen.

**::struct::list** **lcsInvertMerge** *lcsData* *len1* *len2*
: Ähnlich wie **lcsInvert**. Gibt im Wesentlichen dieselbe Struktur wie dieser Befehl zurück, nur dass sie auch Blöcke vom Typ **unchanged** enthalten kann.

    Diese neuen Blöcke beschreiben die Teile, die zwischen den beiden Sequenzen unverändert geblieben sind. Das bedeutet, dass das Ergebnis dieses Befehls sowohl die geänderten als auch die unveränderten Teile der beiden Sequenzen in einer Struktur beschreibt.

    ```
        sequence 1 = {a b r a c a d a b r a}
        lcs 1      =   {1 2   4 5     8 9 10}
        lcs 2      =   {0 1   3 4     5 6 7}
        sequence 2 =   {b r i c a     b r a c}

        Inversion/Merge  = {{deleted   {0  0} {-1 0}}
                            {unchanged {1  2}  {0 1}}
                            {changed   {3  3}  {2 2}}
                            {unchanged {4  5}  {3 4}}
                            {deleted   {6  7}  {4 5}}
                            {unchanged {8 10}  {5 7}}
                            {added    {10 11}  {8 8}}}
    ```

**::struct::list** **lcsInvertMerge2** *lcs1* *lcs2* *len1* *len2*
: Ähnlich wie **lcsInvertMerge**. Anstatt das Ergebnis eines Aufrufs von **longestCommonSubsequence** direkt zu übernehmen, erwartet dieser Unterbefehl die Indizes für die beiden Sequenzen in zwei separaten Listen.

**::struct::list** **reverse** *sequence*
: Der Unterbefehl nimmt eine einzelne *sequence* als Argument entgegen und gibt eine neue Sequenz zurück, die die Elemente der Eingabesequenz in umgekehrter Reihenfolge enthält.

**::struct::list** **shuffle** *list*
: Der Unterbefehl nimmt eine *list* entgegen und gibt eine Kopie dieser Liste zurück, deren Elemente in zufälliger Reihenfolge angeordnet sind. Jede mögliche Reihenfolge der Elemente wird mit gleicher Wahrscheinlichkeit erzeugt. Intern wird der Fisher-Yates-Mischalgorithmus verwendet.

**::struct::list** **assign** *sequence* *varname* ?*varname*?...
: Der Unterbefehl weist die ersten **n** Elemente der Eingabe *sequence* der Variablen oder den Variablen zu, deren Namen nach der Sequenz aufgeführt sind; **n** ist die Anzahl der angegebenen Variablen.

    Sind mehr Variablen angegeben, als *sequence* Elemente hat, erhalten die überzähligen Variablen die leere Zeichenkette.

    Enthält *sequence* mehr Elemente, als Variablennamen angegeben sind, gibt der Unterbefehl eine Liste der nicht zugewiesenen Elemente zurück. Andernfalls wird eine leere Liste zurückgegeben.

    ```
        tclsh> ::struct::list assign {a b c d e} foo bar
        c d e
        tclsh> set foo
        a
        tclsh> set bar
        b
    ```

**::struct::list** **flatten** ?**-full**? ?**--**? *sequence*
: Der Unterbefehl nimmt eine einzelne *sequence* entgegen und gibt eine neue Sequenz zurück, in der eine Verschachtelungsebene der Eingabesequenz entfernt ist. Mit anderen Worten: Die Unterlisten in der Eingabesequenz werden durch ihre Elemente ersetzt.

    Ist die Option **-full** angegeben, entfernt der Unterbefehl jede Verschachtelung, die er findet.

    ```
        tclsh> ::struct::list flatten {1 2 3 {4 5} {6 7} {{8 9}} 10}
        1 2 3 4 5 6 7 {8 9} 10
        tclsh> ::struct::list flatten -full {1 2 3 {4 5} {6 7} {{8 9}} 10}
        1 2 3 4 5 6 7 8 9 10
    ```

**::struct::list** **map** *sequence* *cmdprefix*
: Der Unterbefehl nimmt eine zu bearbeitende *sequence* sowie ein Befehlspräfix (*cmdprefix*) entgegen, das eine Operation angibt, wendet das Befehlspräfix auf jedes Element der Sequenz an und gibt die Sequenz der Ergebnisse zurück.

    Das Befehlspräfix wird mit einem einzelnen angehängten Wort ausgewertet. Die Auswertung erfolgt im Kontext des Aufrufers des Unterbefehls.

    ```
        tclsh> # squaring all elements in a list

        tclsh> proc sqr {x} {expr {$x*$x}}
        tclsh> ::struct::list map {1 2 3 4 5} sqr
        1 4 9 16 25

        tclsh> # Retrieving the second column from a matrix
        tclsh> # given as list of lists.

        tclsh> proc projection {n list} {::lindex $list $n}
        tclsh> ::struct::list map {{a b c} {1 2 3} {d f g}} {projection 1}
        b 2 f
    ```

**::struct::list** **mapfor** *var* *sequence* *script*
: Der Unterbefehl nimmt eine zu bearbeitende *sequence* sowie ein Tcl-*script* entgegen, wendet das Skript auf jedes Element der Sequenz an und gibt eine Sequenz zurück, die aus den Ergebnissen dieser Anwendung besteht.

    Das Skript wird unverändert ausgewertet und hat über die angegebene Iterationsvariable *var* Zugriff auf das aktuelle Listenelement. Die Auswertung erfolgt im Kontext des Aufrufers des Unterbefehls.

    ```
        tclsh> # squaring all elements in a list

        tclsh> ::struct::list mapfor x {1 2 3 4 5} {
    	expr {$x * $x}
        }
        1 4 9 16 25

        tclsh> # Retrieving the second column from a matrix
        tclsh> # given as list of lists.

        tclsh> ::struct::list mapfor x {{a b c} {1 2 3} {d f g}} {
    	lindex $x 1
        }
        b 2 f
    ```

**::struct::list** **filter** *sequence* *cmdprefix*
: Der Unterbefehl nimmt eine zu bearbeitende *sequence* sowie ein Befehlspräfix (*cmdprefix*) entgegen, das eine Operation angibt. Er wendet das Befehlspräfix auf jedes Element der Sequenz an und gibt eine Sequenz aus allen Elementen von *sequence* zurück, für die das Befehlspräfix **true** geliefert hat. Mit anderen Worten: Dieser Befehl filtert alle Elemente der Eingabe *sequence* heraus, die den durch *cmdprefix* dargestellten Test nicht bestehen, und gibt die übrigen Elemente zurück.

    Das Befehlspräfix wird mit einem einzelnen angehängten Wort ausgewertet. Die Auswertung erfolgt im Kontext des Aufrufers des Unterbefehls.

    ```
        tclsh> # removing all odd numbers from the input

        tclsh> proc even {x} {expr {($x % 2) == 0}}
        tclsh> ::struct::list filter {1 2 3 4 5} even
        2 4
    ```

    *Hinweis:* **filter** ist eine spezielle Anwendung von **fold**, bei der das Ergebnis je nach Testergebnis um das aktuelle Element erweitert wird oder nicht.

**::struct::list** **filterfor** *var* *sequence* *expr*
: Der Unterbefehl nimmt eine zu bearbeitende *sequence* sowie einen Tcl-Ausdruck (*expr*) entgegen, der eine Bedingung angibt. Er wendet die Bedingung auf jedes Element der Sequenz an und gibt eine Sequenz aus allen Elementen von *sequence* zurück, für die der Ausdruck **true** geliefert hat. Mit anderen Worten: Dieser Befehl filtert alle Elemente der Eingabesequenz *sequence* heraus, die die durch die Bedingung *expr* dargestellte Prüfung nicht bestehen, und gibt die verbleibenden Elemente zurück.

    Der Ausdruck wird unverändert ausgewertet und hat über die angegebene Iterationsvariable *var* Zugriff auf das aktuelle Listenelement. Die Auswertung erfolgt im Kontext des Aufrufers des Unterbefehls.

    ```
        tclsh> # removing all odd numbers from the input

        tclsh> ::struct::list filterfor x {1 2 3 4 5} {($x % 2) == 0}
        2 4
    ```

**::struct::list** **split** *sequence* *cmdprefix* ?*passVar* *failVar*?
: Dies ist eine Variante der Methode **filter**, siehe oben. Statt nur die Elemente zurückzugeben, die den Test bestehen, liefert er Listen sowohl der Elemente, die den Test bestehen, als auch derer, die ihn nicht bestehen.

    Sind keine Variablennamen angegeben, ist das Ergebnis des Befehls eine Liste aus der Liste der bestehenden und der Liste der nicht bestehenden Elemente, in dieser Reihenfolge. Andernfalls werden die Listen der Elemente, die den Test bestanden haben, und der Elemente, die den Test nicht bestanden haben, in den beiden angegebenen Variablen gespeichert, und das Ergebnis ist eine Liste, die zwei Zahlen enthält: die Anzahl der Elemente, die den Test bestanden haben, und die Anzahl der Elemente, die den Test nicht bestanden haben, in dieser Reihenfolge.

    Die Schnittstelle zum Test entspricht der von **filter** verwendeten.

**::struct::list** **fold** *sequence* *initialvalue* *cmdprefix*
: Der Unterbefehl nimmt eine zu bearbeitende *sequence*, eine beliebige Zeichenkette *initial value* sowie ein Befehlspräfix (*cmdprefix*) entgegen, das eine Operation angibt.

    Das Befehlspräfix wird mit zwei angehängten Wörtern ausgewertet. Das zweite dieser Wörter ist stets ein Element der Sequenz. Die Auswertung erfolgt im Kontext des Aufrufers des Unterbefehls.

    Anschließend wird die Sequenz durch wiederholte Anwendung des Befehlspräfixes auf einen einzigen Wert reduziert, und dieser Wert wird zurückgegeben. Diese Reduktion erfolgt durch

    **1**
    : Anwendung des Befehls auf den Anfangswert und das erste Element der Liste.

    **2**
    : Anwendung des Befehls auf das Ergebnis des letzten Aufrufs und das zweite Element der Liste.

    **...**
    : siehe unten ...

    **i**
    : Anwendung des Befehls auf das Ergebnis des letzten Aufrufs und das Element mit der Nummer **i** in der Liste.

    **...**
    : siehe unten ...

    **end**
    : Anwendung des Befehls auf das Ergebnis des letzten Aufrufs und das letzte Element der Liste. Das Ergebnis dieses Aufrufs wird als Ergebnis des Unterbefehls zurückgegeben.


    ```
        tclsh> # summing the elements in a list.
        tclsh> proc + {a b} {expr {$a + $b}}
        tclsh> ::struct::list fold {1 2 3 4 5} 0 +
        15
    ```

**::struct::list** **shift** *listvar*
: Der Unterbefehl nimmt die in der durch *listvar* benannten Variablen enthaltene Liste und verschiebt sie um ein Element nach unten. Nach dem Aufruf enthält *listvar* eine Liste mit dem zweiten bis letzten Element der Eingabeliste. Das erste Element der Liste wird als Ergebnis des Befehls zurückgegeben. Bei einer leeren Liste geschieht nichts.

**::struct::list** **iota** *n*
: Der Unterbefehl gibt eine Liste zurück, die die ganzzahligen Werte im Bereich **\[0,n)** enthält. Das Element am Index **i** der Liste enthält die Zahl **i**.

    Für „*n* == **0**“ wird eine leere Liste zurückgegeben.

**::struct::list** **equal** ?**-simple**? ?**--**? *a* *b*
: Der Unterbefehl vergleicht die beiden Listen *a* und *b* auf Gleichheit. Mit anderen Worten: Sie müssen dieselbe Länge aufweisen und dieselben Elemente in derselben Reihenfolge enthalten.

    Standardmäßig werden Gleichheitsprüfungen rekursiv auf Elemente von Listen angewendet, die selbst Listen sind. Dieses Verhalten wird deaktiviert, wenn die Option **-simple** festgelegt wird.

    Die Option **--** beendet die Optionsverarbeitung, auch wenn das folgende Argument wie eine Option aussieht.

    Als Ergebnis des Befehls wird ein boolescher Wert zurückgegeben. Dieser Wert lautet **true**, wenn die beiden Listen gleich sind, und andernfalls **false**.

**::struct::list** **repeat** *size* *element1* ?*element2* *element3*...?
: Der Unterbefehl erstellt eine Liste der Länge „*size* \* *Anzahl der Elemente*“, indem er die Folge der Elemente *element1* *element2* *...* *size*-mal wiederholt. *size* muss eine positive ganze Zahl sein, *element*__n__ kann ein beliebiger Tcl-Wert sein. Beachten Sie, dass **repeat 1 arg ...** dasselbe ist wie **list arg ...**, nur dass bei **repeat** das *arg* erforderlich ist.

    *Beispiele:*

    ```
        tclsh> ::struct::list repeat 3 a
        a a a
        tclsh> ::struct::list repeat 3 [::struct::list repeat 3 0]
        {0 0 0} {0 0 0} {0 0 0}
        tclsh> ::struct::list repeat 3 a b c
        a b c a b c a b c
        tclsh> ::struct::list repeat 3 [::struct::list repeat 2 a] b c
        {a a} b c {a a} b c {a a} b c
    ```

**::struct::list** **repeatn** *value* *size*...
: Der Unterbefehl erzeugt eine (verschachtelte) Liste, die an allen Positionen *value* enthält. Die genaue Größe und die Verschachtelungstiefe werden durch die *size*-Argumente bestimmt, die alle ganze Zahlen größer oder gleich null sein müssen.

    Ein einzelnes *size*-Argument, das eine Liste aus mehr als einem Element ist, wird so behandelt, als wären mehrere *size*-Argumente angegeben.

    Ist nur ein *size*-Argument vorhanden, ist die zurückgegebene Liste nicht verschachtelt, hat die Länge *size* und enthält an allen Positionen *value*. Sind mehrere *size*-Argumente vorhanden, ist die zurückgegebene Liste verschachtelt und hat die Länge, die durch das zuletzt angegebene *size*-Argument festgelegt wird. Die Elemente dieser Liste werden als Ergebnis von **Repeat** für dieselben Argumente definiert, jedoch ohne den letzten *size*-Wert.

    Ist kein *size*-Argument vorhanden, wird eine leere Liste zurückgegeben.

    ```
        tclsh> ::struct::list repeatn  0 3 4
        {0 0 0} {0 0 0} {0 0 0} {0 0 0}
        tclsh> ::struct::list repeatn  0 {3 4}
        {0 0 0} {0 0 0} {0 0 0} {0 0 0}
        tclsh> ::struct::list repeatn  0 {3 4 5}
        {{0 0 0} {0 0 0} {0 0 0} {0 0 0}} {{0 0 0} {0 0 0} {0 0 0} {0 0 0}} {{0 0 0} {0 0 0} {0 0 0} {0 0 0}} {{0 0 0} {0 0 0} {0 0 0} {0 0 0}} {{0 0 0} {0 0 0} {0 0 0} {0 0 0}}
    ```

**::struct::list** **dbJoin** ?**-inner**|**-left**|**-right**|**-full**? ?**-keys** *varname*? {*keycol* *table*}...
: Die Methode führt eine Verknüpfung von Tabellen gemäß der relationalen Algebra durch. Die Ausführung einer der möglichen Outer-Join-Operationen wird durch das Vorhandensein einer der Optionen **-left**, **-right** oder **-full** ausgelöst. Ist keine dieser Optionen vorhanden, wird ein regulärer Inner Join durchgeführt. Dies kann auch durch die Angabe von **-inner** ausgelöst werden. Die verschiedenen möglichen Verknüpfungsoperationen werden im Abschnitt [Tabellenverknüpfung] ausführlich erläutert.

    Wenn die Option **-keys** vorhanden ist, ist ihr Argument der Name einer Variablen, in der die vollständige Liste der gefundenen Schlüssel gespeichert wird. Je nach der genauen Beschaffenheit der Eingabetabelle und dem Verknüpfungsmodus enthält die Ausgabetabelle standardmäßig möglicherweise nicht alle Schlüssel. In einem solchen Fall kann der Aufrufer eine Variable für diese Informationen deklarieren und diese dann selbst in die Ausgabetabelle einfügen, da er über mehr Informationen zur Platzierung verfügt als dieser Befehl.

    Nun bleibt noch das Format der Argumente zu erläutern.

    Die *keycol*-Argumente sind die Indizes der Spalten in den Tabellen, die die für die Verknüpfung zu verwendenden Schlüsselwerte enthalten. Jedes Argument bezieht sich auf die unmittelbar darauf folgende Tabelle. Die Spalten werden ab **0** gezählt, wobei diese Nummer die erste Spalte bezeichnet. Die Tabelle, zu der der Spaltenindex gehört, muss mindestens *keycol*+1 Spalten aufweisen. Bei einer geringeren Anzahl wird ein Fehler ausgelöst.

    Die *table*-Argumente stellen eine Tabelle oder Matrix aus Zeilen und Spalten mit Werten dar. Wir verwenden dieselbe Darstellung, wie sie von den Methoden **get rect** und **set rect** von **matrix**-Objekten generiert und verarbeitet wird. Mit anderen Worten: Jedes Argument ist eine Liste, die die gesamte Matrix darstellt. Ihre Elemente sind ebenfalls Listen, von denen jede eine einzelne Zeile der Matrix darstellt. Die Elemente der Zeilenlisten sind die Werte der Spalten.

    Die aus der Verknüpfungsoperation resultierende Tabelle wird als Ergebnis des Befehls zurückgegeben. Wir verwenden dieselbe Darstellung wie oben für die Eingabe-*table*s beschrieben.

**::struct::list** **dbJoinKeyed** ?**-inner**|**-left**|**-right**|**-full**? ?**-keys** *varname*? *table*...
: Die mit dieser Methode durchgeführten Vorgänge entsprechen den oben für **dbJoin** beschriebenen. Der einzige Unterschied besteht in der Angabe der zu verwendenden Schlüssel. Anstatt hier von der Tabelle getrennte Spaltenindizes zu verwenden, werden die Schlüssel innerhalb der Tabelle selbst bereitgestellt. Die Zeilenelemente in jeder *table* sind keine Listen von Spaltenwerten, sondern eine Liste mit zwei Elementen, wobei das zweite Element die reguläre Liste der Spaltenwerte und das erste Element der zu verwendende Schlüssel ist.

**::struct::list** **swap** *listvar* *i* *j*
: Der Unterbefehl tauscht die Elemente an den Indizes *i* und *j* in der Liste aus, die in der durch *listvar* bezeichneten Variablen gespeichert ist. Die Liste wird an Ort und Stelle geändert und zudem als Ergebnis des Unterbefehls zurückgegeben.

**::struct::list** **firstperm** *list*
: Dieser Unterbefehl gibt die lexikografisch erste Permutation der Eingabeliste *list* zurück.

**::struct::list** **nextperm** *perm*
: Dieser Unterbefehl akzeptiert eine Permutation einer Menge von Elementen (die durch *perm* bereitgestellt wird) und gibt die nächste Permutation in lexikografischer Reihenfolge zurück.

    Der hier verwendete Algorithmus stammt von Donal E. Knuth; Einzelheiten finden Sie im Abschnitt [Literatur].

**::struct::list** **permutations** *list*
: Dieser Unterbefehl gibt eine Liste zurück, die alle Permutationen der Eingabeliste *list* in lexikografischer Reihenfolge enthält.

**::struct::list** **foreachperm** *var* *list* *body*
: Dieser Unterbefehl führt das Skript *body* einmal für jede Permutation der angegebenen *list* aus. Die Permutationen werden in lexikografischer Reihenfolge durchlaufen, und die Variable *var* wird auf die Permutation gesetzt, für die *body* gerade ausgeführt wird. Das Ergebnis des Schleifenbefehls ist die leere Zeichenkette.


# Längste gemeinsame Teilfolge und Dateivergleich

Der Unterbefehl **longestCommonSubsequence** bildet den Kern eines flexiblen Systems zur Durchführung von Differenzvergleichen von Dateien, ähnlich der Funktionalität, die der Unix-Befehl **diff** bietet. Zwar ist diese Prozedur für viele Aufgaben des Dateivergleichs recht schnell, doch verschlechtert sich ihre Leistung erheblich, wenn *sequence2* viele gleiche Elemente enthält (wie beispielsweise bei der Verwendung dieser Prozedur zum Vergleich zweier Dateien, bei denen ein Viertel der Zeilen leer ist). Dieser Nachteil ist dem verwendeten Algorithmus inhärent (Einzelheiten finden Sie in der Literatur).

Ein Ansatz zur Bewältigung des Leistungsproblems, der sich in der Praxis mitunter als wirksam erweist, besteht darin, Elemente, die häufiger als eine bestimmte Anzahl von Malen vorkommen, willkürlich auszuschließen. Diese Anzahl wird als Parameter *maxOccurs* angegeben.  Wenn häufig vorkommende Zeilen auf diese Weise ausgeschlossen werden, erscheinen sie nicht in der berechneten gemeinsamen Teilfolge; das Ergebnis ist dann die längste gemeinsame Teilfolge aus selten vorkommenden Elementen. Die Prozedur **longestCommonSubsequence2** implementiert diese Heuristik. Sie fungiert als Wrapper um **longestCommonSubsequence**; sie berechnet die längste gemeinsame Teilfolge aus selten vorkommenden Elementen und unterteilt anschließend die Teilfolgen, die zwischen den Übereinstimmungen liegen, um die tatsächliche längste gemeinsame Teilfolge anzunähern.

# Tabellenverknüpfung

Dies ist eine Operation aus der relationalen Algebra für relationale Datenbanken.

Am einfachsten lässt sich der reguläre Inner Join so verstehen, dass zunächst das kartesische Produkt aller beteiligten Tabellen gebildet wird und anschließend in der resultierenden Tabelle nur jene Zeilen beibehalten werden, bei denen die Werte in den festgelegten Schlüsselspalten miteinander übereinstimmen.

Eine naive Umsetzung dieser Beschreibung, d. h. wie oben beschrieben, führt zu einem *riesigen* Zwischenergebnis. Um dies zu vermeiden, werden das kartesische Produkt und die Filterung der Zeilen gleichzeitig durchgeführt. Erforderlich ist eine schnelle Methode, um festzustellen, ob ein Schlüssel in einer Tabelle vorhanden ist. In einer echten Datenbank erfolgt dies über Indizes. Hier verwenden wir intern Arrays.

Ein *Outer*-Join ist eine Erweiterung des Inner-Joins für zwei Tabellen. Es gibt drei Varianten von Outer-Joins, die als *Left*-, *Right*- und *Full*-Outer-Joins bezeichnet werden. Ihr Ergebnis enthält stets alle Zeilen eines Inner-Joins sowie einige zusätzliche Zeilen.

1. Beim „Left Outer Join“ handelt es sich bei den zusätzlichen Zeilen um alle Zeilen der linken Tabelle, für die es in der rechten Tabelle keinen Schlüssel gibt. Diese werden mit einer leeren Zeile der rechten Tabelle verknüpft, um sie in das Ergebnis einzubinden.

2. Beim „Right Outer Join“ sind die zusätzlichen Zeilen alle Zeilen aus der rechten Tabelle, für die es in der linken Tabelle keinen Schlüssel gibt. Sie werden mit einer leeren Zeile der linken Tabelle verknüpft, um sie in das Ergebnis einzufügen.

3. Der „Full Outer Join“ vereint sowohl den „Left Outer Join“ als auch den „Right Outer Join“. Mit anderen Worten: Die zusätzlichen Zeilen entsprechen der Kombination der für den „Left Outer Join“ und den „Right Outer Join“ definierten Zeilen.


Wir erweitern alle Verknüpfungen von zwei auf **n** Tabellen (**n** > 2), indem wir folgenden Befehl ausführen:

```
    (...((table1 join table2) join table3) ...) join tableN
```

Beispiele für alle Verknüpfungen:

```
    Inner Join

    {0 foo}              {0 bagel}    {0 foo   0 bagel}
    {1 snarf} inner join {1 snatz}  = {1 snarf 1 snatz}
    {2 blue}             {3 driver}

    Left Outer Join

    {0 foo}                   {0 bagel}    {0 foo   0 bagel}
    {1 snarf} left outer join {1 snatz}  = {1 snarf 1 snatz}
    {2 blue}                  {3 driver}   {2 blue  {} {}}

    Right Outer Join

    {0 foo}                    {0 bagel}    {0 foo   0 bagel}
    {1 snarf} right outer join {1 snatz}  = {1 snarf 1 snatz}
    {2 blue}                   {3 driver}   {{} {}   3 driver}

    Full Outer Join

    {0 foo}                   {0 bagel}    {0 foo   0 bagel}
    {1 snarf} full outer join {1 snatz}  = {1 snarf 1 snatz}
    {2 blue}                  {3 driver}   {2 blue  {} {}}
                                           {{} {}   3 driver}
```

# Literatur

1. J. W. Hunt und M. D. McIlroy, „An algorithm for differential file comparison“, Comp. Sci. Tech. Rep. #41, Bell Telephone Laboratories (1976). Verfügbar im Internet auf der persönlichen Website des zweiten Autors: <http://www.cs.dartmouth.edu/~doug/>

2. Donald E. Knuth, „Fascicle 2b of ‚The Art of Computer Programming‘ volume 4“. Im Internet verfügbar auf der persönlichen Website des Autors: <http://www-cs-faculty.stanford.edu/~knuth/fasc2b.ps.gz>.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *struct :: list* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Datenstrukturen

# Copyright

```
Copyright (c) 2003-2005 by Kevin B. Kenny. All rights reserved
Copyright (c) 2003-2012 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
