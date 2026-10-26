---
CommandName: pt::pe
ManualSection: n
Version: 1.0.2
TclPart: tcllib
TclDescription: Parser Tools
Keywords:
 - EBNF
 - LL(k)
 - PEG
 - TDPL
 - context-free languages
 - expression
 - grammar
 - matching
 - parser
 - parsing expression
 - parsing expression grammar
 - push down automaton
 - recursive descent
 - state
 - top-down parsing languages
 - transducer
Copyright:
 - Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

pt::pe – Serialisierung von Parsing-Ausdrücken

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pt::pe]{.lit} [1.0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [char]{.lit} 
[::pt::pe]{.cmd} [verify]{.sub} [serial]{.arg} [canonvar]{.optarg} 
[::pt::pe]{.cmd} [verify-as-canonical]{.sub} [serial]{.arg} 
[::pt::pe]{.cmd} [canonicalize]{.sub} [serial]{.arg} 
[::pt::pe]{.cmd} [print]{.sub} [serial]{.arg} 
[::pt::pe]{.cmd} [bottomup]{.sub} [cmdprefix]{.arg} [pe]{.arg} 
[cmdprefix]{.cmd} [pe]{.arg} [op]{.arg} [arguments]{.arg} 
[::pt::pe]{.cmd} [topdown]{.sub} [cmdprefix]{.arg} [pe]{.arg} 
[::pt::pe]{.cmd} [equal]{.sub} [seriala]{.arg} [serialb]{.arg} 
[::pt::pe]{.cmd} [epsilon]{.sub} 
[::pt::pe]{.cmd} [dot]{.sub} 
[::pt::pe]{.cmd} [alnum]{.sub} 
[::pt::pe]{.cmd} [alpha]{.sub} 
[::pt::pe]{.cmd} [ascii]{.sub} 
[::pt::pe]{.cmd} [control]{.sub} 
[::pt::pe]{.cmd} [digit]{.sub} 
[::pt::pe]{.cmd} [graph]{.sub} 
[::pt::pe]{.cmd} [lower]{.sub} 
[::pt::pe]{.cmd} [print]{.sub} 
[::pt::pe]{.cmd} [punct]{.sub} 
[::pt::pe]{.cmd} [space]{.sub} 
[::pt::pe]{.cmd} [upper]{.sub} 
[::pt::pe]{.cmd} [wordchar]{.sub} 
[::pt::pe]{.cmd} [xdigit]{.sub} 
[::pt::pe]{.cmd} [ddigit]{.sub} 
[::pt::pe]{.cmd} [terminal]{.sub} [t]{.arg} 
[::pt::pe]{.cmd} [range]{.sub} [ta]{.arg} [tb]{.arg} 
[::pt::pe]{.cmd} [nonterminal]{.sub} [nt]{.arg} 
[::pt::pe]{.cmd} [choice]{.sub} [pe...]{.arg} 
[::pt::pe]{.cmd} [sequence]{.sub} [pe...]{.arg} 
[::pt::pe]{.cmd} [repeat0]{.sub} [pe]{.arg} 
[::pt::pe]{.cmd} [repeat1]{.sub} [pe]{.arg} 
[::pt::pe]{.cmd} [optional]{.sub} [pe]{.arg} 
[::pt::pe]{.cmd} [ahead]{.sub} [pe]{.arg} 
[::pt::pe]{.cmd} [notahead]{.sub} [pe]{.arg} 
:::

# BESCHREIBUNG

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket stellt Befehle zur Verfügung, mit denen Sie die von den Parser-Tools verwalteten und im Abschnitt **PE-SERIALISIERUNGSFORMAT** beschriebenen Serialisierungen von Parsing-Ausdrücken bearbeiten können.

Dies ist ein unterstützendes Paket in der Kernschicht der Parser-Tools.

Bild: arch_core_support

# API

**::pt::pe** **verify** *serial* ?*canonvar*?
: Dieser Befehl überprüft, ob der Inhalt von *serial* eine gültige Serialisierung eines Parsing-Ausdrucks ist, und löst einen Fehler aus, wenn dies nicht der Fall ist. Das Ergebnis des Befehls ist die leere Zeichenkette. Wenn das Argument *canonvar* festgelegt wird, wird es als Name einer Variablen im aufrufenden Kontext interpretiert. In diese Variable wird genau dann geschrieben, wenn *serial* eine gültige reguläre Serialisierung ist. Ihr Wert ist ein Boolescher Wert, wobei **True** angibt, dass die Serialisierung nicht nur gültig, sondern auch *kanonisch* ist. Bei einer gültigen, aber nicht kanonischen Serialisierung wird **False** geschrieben. Informationen zur Spezifikation von Serialisierungen finden Sie im Abschnitt **PE-SERIALISIERUNGSFORMAT**.

**::pt::pe** **verify-as-canonical** *serial*
: Dieser Befehl überprüft, ob der Inhalt von *serial* eine gültige *kanonische* Serialisierung eines Parsing-Ausdrucks ist, und löst einen Fehler aus, falls dies nicht der Fall ist. Das Ergebnis des Befehls ist die leere Zeichenkette. Informationen zur Spezifikation kanonischer Serialisierungen finden Sie im Abschnitt **PE-SERIALISIERUNGSFORMAT**.

**::pt::pe** **canonicalize** *serial*
: Dieser Befehl geht davon aus, dass der Inhalt von *serial* eine gültige *reguläre* Serialisierung eines Parsing-Ausdrucks ist, und löst einen Fehler aus, falls dies nicht der Fall ist. Anschließend wandelt er die Eingabe in die *kanonische* Serialisierung dieses Parsing-Ausdrucks um und gibt diese als Ergebnis zurück. Wenn die Eingabe bereits kanonisch ist, wird sie unverändert zurückgegeben. Informationen zur Spezifikation regulärer und kanonischer Serialisierungen finden Sie im Abschnitt **PE-SERIALISIERUNGSFORMAT**.

**::pt::pe** **print** *serial*
: Dieser Befehl geht davon aus, dass das Argument *serial* eine gültige Serialisierung eines Parsing-Ausdrucks enthält, und gibt eine Zeichenkette zurück, die diesen PE in einer für Menschen lesbaren Form enthält. Das genaue Format dieser Darstellung ist nicht spezifiziert und darf nicht für das Parsen oder andere maschinengestützte Vorgänge herangezogen werden. Informationen zur Spezifikation von Serialisierungen finden Sie im Abschnitt **PE-SERIALISIERUNGSFORMAT**.

**::pt::pe** **bottomup** *cmdprefix* *pe*
: Dieser Befehl durchläuft den Parsing-Ausdruck *pe* von unten nach oben bis zur Wurzel und ruft dabei für jeden Teilausdruck das Befehlspräfix *cmdprefix* auf. Dies bedeutet, dass die Kindknoten eines Parsing-Ausdrucks PE vor PE verarbeitet werden. Das Befehlspräfix hat die Signatur


**cmdprefix** *pe* *op* *arguments*
: Das heißt, er wird mit dem Parsing-Ausdruck *pe*, an dem sich der Durchlauf gerade befindet, dem Operator *op* in diesem *pe* sowie den *arguments* des Operators aufgerufen. Das vom Befehlspräfix zurückgegebene Ergebnis ersetzt *pe* in dem Parsing-Ausdruck, dessen Kindknoten er war, wodurch Transformationen des Ausdrucksbaums ermöglicht werden. Dies bedeutet auch, dass für alle inneren Parsing-Ausdrücke der Inhalt von *arguments* den Ergebnissen des Befehlspräfixes entspricht, das für die Kindknoten dieses inneren Parsing-Ausdrucks aufgerufen wurde.


**::pt::pe** **topdown** *cmdprefix* *pe*
: Dieser Befehl durchläuft den Parsing-Ausdruck *pe* von der Wurzel bis zu den Blättern und ruft dabei für jeden Teilausdruck das Befehlspräfix *cmdprefix* auf. Dies bedeutet, dass die Kindknoten eines Parsing-Ausdrucks PE nach PE verarbeitet werden. Das Befehlspräfix hat dieselbe Signatur wie bei **bottomup** (siehe oben). Das vom Befehlspräfix zurückgegebene Ergebnis wird *ignoriert*.

**::pt::pe** **equal** *seriala* *serialb*
: Dieser Befehl prüft die beiden Parsing-Ausdrücke *seriala* und *serialb* auf strukturelle Übereinstimmung. Das Ergebnis des Befehls ist ein boolescher Wert. Er wird auf **true** gesetzt, wenn die Ausdrücke identisch sind, andernfalls auf **false**. Die Zeichenfolgenübereinstimmung ist nur dann anwendbar, wenn davon ausgegangen werden kann, dass es sich bei den beiden Parsing-Ausdrücken um reine Tcl-Listen handelt.

**::pt::pe** **epsilon**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für Epsilon.

**::pt::pe** **dot**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für dot.

**::pt::pe** **alnum**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für alnum.

**::pt::pe** **alpha**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für alpha.

**::pt::pe** **ascii**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für ascii.

**::pt::pe** **control**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für control.

**::pt::pe** **digit**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für digit.

**::pt::pe** **graph**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für graph.

**::pt::pe** **lower**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für lower.

**::pt::pe** **print**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für print.

**::pt::pe** **punct**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für punct.

**::pt::pe** **space**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für space.

**::pt::pe** **upper**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für upper.

**::pt::pe** **wordchar**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für wordchar.

**::pt::pe** **xdigit**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für xdigit.

**::pt::pe** **ddigit**
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für ddigit.

**::pt::pe** **terminal** *t*
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für das Terminalsymbol *t*.

**::pt::pe** **range** *ta* *tb*
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für den Bereich der Terminalsymbole *ta* … *tb*.

**::pt::pe** **nonterminal** *nt*
: Dieser Befehl erstellt den atomaren Parsing-Ausdruck für das nichtterminale Symbol *nt*.

**::pt::pe** **choice** *pe*...
: Dieser Befehl erstellt den Parsing-Ausdruck für die geordnete, priorisierte Auswahl zwischen den Parsing-Ausdrücken der Argumente. Das erste Argument hat die höchste Priorität.

**::pt::pe** **sequence** *pe*...
: Dieser Befehl erstellt den Parsing-Ausdruck für die Sequenz der Parsing-Ausdrücke in den Argumenten. Das erste Argument ist das erste Element der Sequenz.

**::pt::pe** **repeat0** *pe*
: Dieser Befehl erstellt den Parsing-Ausdruck für die Wiederholung des Parsing-Ausdrucks *pe*, null Mal oder öfter, auch Kleene-Abschluss genannt.

**::pt::pe** **repeat1** *pe*
: Dieser Befehl erstellt den Parsing-Ausdruck für die Wiederholung des Parsing-Ausdrucks *pe*, ein Mal oder öfter, auch positiver Kleene-Abschluss genannt.

**::pt::pe** **optional** *pe*
: Dieser Befehl erstellt den Parsing-Ausdruck für die Optionalität des Parsing-Ausdrucks *pe*.

**::pt::pe** **ahead** *pe*
: Dieser Befehl erstellt den Parsing-Ausdruck für die positive Vorausschau des Parsing-Ausdrucks *pe*.

**::pt::pe** **notahead** *pe*
: Dieser Befehl erstellt den Parsing-Ausdruck für die negative Vorausschau des Parsing-Ausdrucks *pe*.


# PE-SERIALISIERUNGSFORMAT

Hier legen wir das Format fest, das von den Parser-Tools verwendet wird, um Parsing-Ausdrücke als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Auch wenn ein Parsing-Ausdruck mehr als eine reguläre Serialisierung aufweisen kann, ist jeweils genau eine davon *kanonisch*.

**Reguläre Serialisierung**
: 


**Atomare Parsing-Ausdrücke**
: 


**\[1\]**
: Die Zeichenfolge **epsilon** ist ein atomarer Parsing-Ausdruck. Sie passt auf die leere Zeichenfolge.

**\[2\]**
: Die Zeichenfolge **dot** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Zeichen.

**\[3\]**
: Die Zeichenfolge **alnum** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes alphabetische Unicode-Zeichen und jede Unicode-Ziffer. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[4\]**
: Die Zeichenfolge **alpha** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes alphabetische Unicode-Zeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[5\]**
: Die Zeichenfolge **ascii** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Zeichen unterhalb von U0080. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[6\]**
: Die Zeichenfolge **control** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Steuerzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[7\]**
: Die Zeichenfolge **digit** ist ein atomarer Parsing-Ausdruck. Sie passt auf jede Unicode-Ziffer. Das schließt auch Zeichen außerhalb des Bereichs \[0..9\] ein. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[8\]**
: Die Zeichenfolge **graph** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes druckbare Unicode-Zeichen außer dem Leerzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[9\]**
: Die Zeichenfolge **lower** ist ein atomarer Parsing-Ausdruck. Sie passt auf jeden Unicode-Kleinbuchstaben. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[10\]**
: Die Zeichenfolge **print** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes druckbare Unicode-Zeichen einschließlich des Leerzeichens. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[11\]**
: Die Zeichenfolge **punct** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Satzzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[12\]**
: Die Zeichenfolge **space** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Leerraumzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[13\]**
: Die Zeichenfolge **upper** ist ein atomarer Parsing-Ausdruck. Sie passt auf jeden Unicode-Großbuchstaben. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[14\]**
: Die Zeichenfolge **wordchar** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Wortzeichen. Das ist jedes alphanumerische Zeichen (siehe alnum) und jedes Verbindungssatzzeichen (zum Beispiel der Unterstrich). Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[15\]**
: Die Zeichenfolge **xdigit** ist ein atomarer Parsing-Ausdruck. Sie passt auf jede Hexadezimalziffer. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

**\[16\]**
: Die Zeichenfolge **ddigit** ist ein atomarer Parsing-Ausdruck. Sie passt auf jede Dezimalziffer. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **regexp**.

**\[17\]**
: Der Ausdruck \[list t **x**\] ist ein atomarer Parsing-Ausdruck. Er passt auf die Terminalzeichenkette **x**.

**\[18\]**
: Der Ausdruck \[list n **A**\] ist ein atomarer Parsing-Ausdruck. Er passt auf das Nichtterminal **A**.


**Zusammengesetzte Parsing-Ausdrücke**
: 


**\[1\]**
: Für die Parsing-Ausdrücke **e1**, **e2**, … ist das Ergebnis von \[list / **e1** **e2** … \] ebenfalls ein Parsing-Ausdruck. Das ist die *geordnete Auswahl*, auch *priorisierte Auswahl* genannt.

**\[2\]**
: Für die Parsing-Ausdrücke **e1**, **e2**, … ist das Ergebnis von \[list x **e1** **e2** … \] ebenfalls ein Parsing-Ausdruck. Dies ist die *Sequenz*.

**\[3\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list \* **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist der *Kleene-Abschluss*, der null oder mehr Wiederholungen beschreibt.

**\[4\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list + **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist der *positive Kleene-Abschluss*, der eine oder mehrere Wiederholungen beschreibt.

**\[5\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list & **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist das *And-Lookahead-Prädikat*.

**\[6\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list ! **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist das *Not-Lookahead-Prädikat*.

**\[7\]**
: Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list ? **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist die *optionale Eingabe*.


**Kanonische Serialisierung**
: Die kanonische Serialisierung eines Parsing-Ausdrucks hat das im vorherigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen dieses Parsing-Ausdrucks eindeutig ist.


**\[1\]**
: Die Zeichenfolgendarstellung des Werts entspricht der kanonischen Darstellung einer reinen Tcl-Liste. Das heißt, sie enthält keine überflüssigen Leerzeichen.

**\[2\]**
: Terminale werden *nicht* als Bereiche kodiert (bei denen Anfang und Ende des Bereichs identisch sind).


## Beispiel

Unter der Annahme, dass der auf der rechten Seite der Regel dargestellte Parsing-Ausdruck gilt

```
    Expression <- Term (AddOp Term)*
```

dann lautet seine kanonische Serialisierung (mit Ausnahme von Leerzeichen)

```
    {x {n Term} {* {x {n AddOp} {n Term}}}}
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pt* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Parser und Grammatiken

# COPYRIGHT

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
