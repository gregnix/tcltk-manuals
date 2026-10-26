---
CommandName: pt::peg::interp
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

pt::peg::interp – Interpreter für Parsing Expression Grammars

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [pt::peg::interp]{.lit} [1.0.2]{.optlit} 
[package]{.cmd} [require]{.sub} [pt::rde]{.lit} [1]{.optlit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[::pt::peg::interp]{.cmd} [objectName]{.arg} [grammar]{.arg} 
[objectName]{.ins} [use]{.sub} [grammar]{.arg} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [parse]{.sub} [chan]{.arg} 
[objectName]{.ins} [parset]{.sub} [text]{.arg} 
:::

# BESCHREIBUNG

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket stellt eine Klasse bereit, deren Instanzen Packrat-Parser sind, die mithilfe einer Parsing Expression Grammar konfiguriert werden können. Die Grammatik wird direkt ausgeführt, d. h. interpretiert, wobei die zugrunde liegende Laufzeitumgebung vom Paket **pt::rde** bereitgestellt wird und sich alles auf PARAM stützt.

Wie die zugehörige Laufzeitumgebung befindet sich auch dieses Paket im Abschnitt „Ausführung“ der Kernschicht von Parser Tools.

Bild: arch_core_transform

Die interpretierte Grammatik wird aus einer Instanz von **pt::peg::container** kopiert oder aus einer beliebigen anderen Komponente, die dieselbe API bereitstellt, wie beispielsweise die von **pt::peg::to::container** erstellten Container-Klassen oder das zugehörige Export-Plugin **pt::peg::export::container**.

## API für Klassen

Das Paket exportiert die hier beschriebene API.

**::pt::peg::interp** *objectName* *grammar*
: Der Befehl erstellt ein neues Parser-Objekt und gibt den vollqualifizierten Namen des Objektbefehls als Ergebnis zurück. Die API dieses Objektbefehls wird im Abschnitt **Objekt-API** beschrieben. Er kann verwendet werden, um verschiedene Operationen auf dem Objekt auszuführen. Dieser neue Parser ist für die Ausführung eines leeren PEG konfiguriert. Zur Konfiguration für eine andere PEG dient die Methode **use** der **Objekt-API**.


## Objekt-API

Alle durch dieses Paket erstellten Objekte stellen die folgenden Methoden bereit.

*objectName* **use** *grammar*
: Diese Methode konfiguriert den Grammatik-Interpreter bzw. -Parser für die Ausführung der in *grammar* gespeicherten PEG, einem Objekt, das API-kompatibel mit Instanzen von **pt::peg::container** ist. Der Parser kopiert die relevanten Informationen der Grammatik und übernimmt das Objekt *nicht*. Die Informationen einer zuvor verwendeten Grammatik werden überschrieben. Das Ergebnis der Methode ist die leere Zeichenkette.

*objectName* **destroy**
: Diese Methode löscht die Parser-Instanz, gibt den gesamten belegten Speicher sowie alle anderen Ressourcen frei und löscht den Instanzbefehl. Das Ergebnis des Befehls ist die leere Zeichenkette.

*objectName* **parse** *chan*
: Bei dieser Methode wird der Parser mit dem Inhalt von *chan* als Eingabe ausgeführt (beginnend an der aktuellen Position im Kanal), bis eine weitere Analyse nicht mehr möglich ist – entweder, weil die Analyse abgeschlossen ist oder weil ein Syntaxfehler aufgetreten ist. Die Parser-Tools beruhen auf Tcl 8.5+. Mit anderen Worten: Das Kanalargument ist nicht auf Dateien, Sockets usw. beschränkt. Uns steht die volle Leistungsfähigkeit von *reflektierten Kanälen* zur Verfügung. Es sei außerdem darauf hingewiesen, dass der Parser die Zeichen bei Bedarf aus dem Eingabestrom abruft. Wenn ein durch dieses Paket erstellter Parser im Push-Modus, d. h. ereignisgesteuert betrieben werden muss, ist es erforderlich, auf Tcl 8.6+ umzusteigen und **coroutine::auto** zu verwenden, um ihn in eine Coroutine zu verpacken, wobei **read** entsprechend für den Push-Betrieb angepasst werden muss. Nach erfolgreicher Ausführung gibt der Befehl einen abstrakten Syntaxbaum (AST) als Ergebnis zurück. Dieser AST hat die im Abschnitt **AST-SERIALISIERUNGSFORMAT** angegebene Form. Als einfache, verschachtelte Tcl-Liste kann er anschließend mit beliebigen Tcl-Befehlen des Benutzers weiterverarbeitet werden, um Transformationen, semantische Prüfungen usw. durchzuführen. Um dies zu erleichtern, bietet das Paket **pt::ast** eine Reihe von Hilfsbefehlen zur Validierung der Grundstruktur des Baums, zu dessen Ausgabe für Debugging-Zwecke sowie zum Durchlaufen des Baums entweder von unten nach oben oder von oben nach unten. Wenn ein Syntaxfehler auftritt, löst der Befehl stattdessen einen Fehler aus. Dieser Fehler ist eine Tcl-Liste mit vier Elementen, die in der unten aufgeführten Reihenfolge Folgendes enthält:


**\[1\]**
: Die Zeichenfolge **pt::rde**, die darauf hinweist, dass es sich um einen Parser-Laufzeitfehler handelt.

**\[2\]**
: Die Position des Parsing-Fehlers, angegeben als Zeichenversatz vom Anfang der geparsten Eingabe.

**\[3\]**
: Die Position des Parsing-Fehlers, nun als Liste mit zwei Elementen, die die Zeilennummer und die Spalte innerhalb der Zeile enthalten.

**\[4\]**
: Eine Menge atomarer Parsing-Ausdrücke, welche die Zeichen und/oder Nichtterminale kodieren, die der Parser an der Fehlerstelle erwartet, aber nicht vorgefunden hat. Informationen zur Spezifikation atomarer Parsing-Ausdrücke finden Sie im Abschnitt **PE-SERIALISIERUNGSFORMAT**.


*objectName* **parset** *text*
: Diese Methode führt den Parser aus, wobei die Zeichenfolge in *text* als Eingabe verwendet wird. In allen anderen Punkten verhält sie sich wie die oben gezeigte Methode **parse**.


# AST-SERIALISIERUNGSFORMAT

An dieser Stelle legen wir das Format fest, das von den Parser-Tools verwendet wird, um abstrakte Syntaxbäume (ASTs) als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Jeder Knoten in einem AST repräsentiert ein nichtterminales Symbol einer Grammatik sowie den Bereich der Tokens/Zeichen in der Eingabe, den dieses Symbol abdeckt. ASTs enthalten keine terminalen Symbole, d. h. keine Tokens/Zeichen. Diese lassen sich anhand der Position eines Symbols aus der Eingabe rekonstruieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Ein Baum kann zwar mehr als eine reguläre Serialisierung aufweisen, doch ist genau eine davon *kanonisch*.

**Reguläre Serialisierung**
: 


**\[1\]**
: Die Serialisierung eines beliebigen AST entspricht der Serialisierung seines Wurzelknotens.

**\[2\]**
: Die Serialisierung eines beliebigen Knotens ist eine Tcl-Liste, die mindestens drei Elemente enthält.


**\[1\]**
: Das erste Element ist der Name des im Knoten gespeicherten nichtterminalen Symbols.

**\[2\]**
: Das zweite und dritte Element geben die Positionen des ersten und letzten Tokens in dem Token-Strom an, den der Knoten repräsentiert (abdeckt).


**\[1\]**
: Positionen werden als nicht-negative ganzzahlige Offsets vom Anfang des Token-Stroms angegeben, wobei das erste im Strom gefundene Token am Offset 0 (Null) liegt.

**\[2\]**
: Die Endposition muss mindestens so groß sein wie die Startposition.


**\[3\]**
: Alle Elemente nach den ersten drei sind die Kindknoten des Knotens, selbst wieder Knoten. Die Serialisierung eines Knotens ohne Kindknoten, also eines Blattknotens, hat daher genau drei Elemente. In der Liste steht der linke Kindknoten zuerst und der rechte zuletzt.


**Kanonische Serialisierung**
: Die kanonische Serialisierung eines abstrakten Syntaxbaums hat das im vorigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen dieses Baums eindeutig ist.


**\[1\]**
: Die Zeichenfolgendarstellung des Werts entspricht der kanonischen Darstellung einer reinen Tcl-Liste. Das heißt, sie enthält keine überflüssigen Leerzeichen.


## Beispiel

Unter der Annahme der folgenden Parsing Expression Grammar

```
PEG calculator (Expression)
    Digit      <- '0'/'1'/'2'/'3'/'4'/'5'/'6'/'7'/'8'/'9'       ;
    Sign       <- '-' / '+'                                     ;
    Number     <- Sign? Digit+                                  ;
    Expression <- Term (AddOp Term)*                            ;
    MulOp      <- '*' / '/'                                     ;
    Term       <- Factor (MulOp Factor)*                        ;
    AddOp      <- '+'/'-'                                       ;
    Factor     <- '(' Expression ')' / Number                   ;
END;
```

und der Eingabezeichenkette

```
 120+5
```

Dann sollte ein Parser den folgenden abstrakten Syntaxbaum liefern (mit Ausnahme von Leerzeichen)

```
set ast {Expression 0 4
    {Factor 0 4
        {Term 0 2
            {Number 0 2
                {Digit 0 0}
                {Digit 1 1}
                {Digit 2 2}
            }
        }
        {AddOp 3 3}
        {Term 4 4
            {Number 4 4
                {Digit 4 4}
            }
        }
    }
}
```

Oder, anschaulicher ausgedrückt

```
+- Digit 0 0 | 1
|            |
+- Term 0 2 --- Number 0 2 -+- Digit 1 1 | 2
|                           |            |
|                           +- Digit 2 2 | 0
|                                        |
Expression 0 4 --- Factor 0 4 -+----------------------------- AddOp 3 3 | +
|                                        |
+- Term 4 4 --- Number 4 4 --- Digit 4 4 | 5
```

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
