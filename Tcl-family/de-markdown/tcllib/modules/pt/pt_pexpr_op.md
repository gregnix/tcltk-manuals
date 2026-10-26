---
CommandName: pt::pe::op
title: pt::pe::op
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

# Name

pt::pe::op – Hilfsbefehle für Parsing-Ausdrücke

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [pt::pe::op]{.lit} [1.0.2]{.optlit}
[package]{.cmd} [require]{.sub} [pt::pe]{.lit} [1]{.optlit}
[package]{.cmd} [require]{.sub} [struct::set]{.lit}
[::pt::pe::op]{.cmd} [drop]{.lit} [dropset]{.arg} [pe]{.arg}
[::pt::pe::op]{.cmd} [rename]{.lit} [nt]{.arg} [ntnew]{.arg} [pe]{.arg}
[::pt::pe::op]{.cmd} [called]{.lit} [pe]{.arg}
[::pt::pe::op]{.cmd} [flatten]{.lit} [pe]{.arg}
[::pt::pe::op]{.cmd} [fusechars]{.lit} [pe]{.arg}
:::

# Beschreibung

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket stellt zusätzliche Befehle zur Verfügung, um mit den Serialisierungen von Parsing-Ausdrücken zu arbeiten, die vom PEG und den zugehörigen Paketen verwaltet und im Abschnitt [PE-Serialisierungsformat] beschrieben werden.

Es handelt sich hierbei um ein internes Paket, das für übergeordnete Pakete bestimmt ist, welche sich mit PEGs befassen, deren Konvertierung in und aus verschiedenen anderen Formaten durchführen oder für andere Zwecke nutzen.

# API

**::pt::pe::op** **drop** *dropset* *pe*
: Dieser Befehl entfernt alle Vorkommen der Nichtterminalsymbole aus der Menge *dropset* aus dem Parsing-Ausdruck *pe* und vereinfacht diesen. Dies kann dazu führen, dass der Ausdruck zu „epsilon“ wird, d. h. dass er auf nichts mehr passt.

**::pt::pe::op** **rename** *nt* *ntnew* *pe*
: Dieser Befehl benennt alle Vorkommen des Nichtterminals *nt* im Parsing-Ausdruck *pe* in *ntnew* um.

**::pt::pe::op** **called** *pe*
: Dieser Befehl extrahiert die Menge aller nichtterminalen Symbole, die im Parsing-Ausdruck *pe* verwendet, d. h. „aufgerufen“, werden.

**::pt::pe::op** **flatten** *pe*
: Dieser Befehl führt eine Transformation des Parsing-Ausdrucks durch, indem er in Sequenzen verschachtelte Sequenzen sowie in Auswahlmöglichkeiten verschachtelte Auswahlmöglichkeiten entfernt und die Kindknoten des verschachtelten Ausdrucks in den Elternknoten hebt. Zudem werden alle Sequenzen und Auswahlen mit nur einem Kindknoten entfernt, da diese überflüssig sind.

    Der resultierende Parsing-Ausdruck wird als Ergebnis des Befehls zurückgegeben.

**::pt::pe::op** **fusechars** *pe*
: Dieser Befehl transformiert den Parsing-Ausdruck, indem er benachbarte Terminale in Sequenzen sowie benachbarte Terminale und Bereiche in Auswahlmöglichkeiten zusammenführt; und setzt dabei höherstufige *strings* und *character classes* wieder zusammen.

    Der entstehende Pseudo-Parsing-Ausdruck ist das Ergebnis des Befehls und kann die Pseudo-Operatoren **str** für Zeichenfolgen, also strings, und **cl** für Zeichenauswahlen, also character classes, enthalten.

    Das Ergebnis wird als *Pseudo-Parsing-Ausdruck* bezeichnet, da es sich nicht mehr um einen echten Parsing-Ausdruck handelt und eine Überprüfung mit [::pt::peg verify][pt_peg_container] fehlschlägt, wenn die neuen Pseudo-Operatoren im Ergebnis vorhanden sind; ansonsten weist es jedoch eine für einen Parsing-Ausdruck korrekte Struktur auf. Insbesondere werden die Befehle [::pt::peg bottomup][pt_peg_container] und [::pt::peg topdown][pt_peg_container] diese ohne Probleme verarbeiten.


# PE-Serialisierungsformat

Hier legen wir das Format fest, das von den Parser-Tools verwendet wird, um Parsing-Ausdrücke als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Auch wenn ein Parsing-Ausdruck mehr als eine reguläre Serialisierung aufweisen kann, ist jeweils genau eine davon *kanonisch*.

Reguläre Serialisierung
: siehe unten ...

    **Atomare Parsing-Ausdrücke**
    : 1. Die Zeichenfolge **epsilon** ist ein atomarer Parsing-Ausdruck. Sie passt auf die leere Zeichenfolge.

        2. Die Zeichenfolge **dot** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Zeichen.

        3. Die Zeichenfolge **alnum** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes alphabetische Unicode-Zeichen und jede Unicode-Ziffer. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        4. Die Zeichenfolge **alpha** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes alphabetische Unicode-Zeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        5. Die Zeichenfolge **ascii** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Zeichen unterhalb von U0080. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        6. Die Zeichenfolge **control** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Steuerzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        7. Die Zeichenfolge **digit** ist ein atomarer Parsing-Ausdruck. Sie passt auf jede Unicode-Ziffer. Das schließt auch Zeichen außerhalb des Bereichs \[0..9\] ein. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        8. Die Zeichenfolge **graph** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes druckbare Unicode-Zeichen außer dem Leerzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        9. Die Zeichenfolge **lower** ist ein atomarer Parsing-Ausdruck. Sie passt auf jeden Unicode-Kleinbuchstaben. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        10. Die Zeichenfolge **print** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes druckbare Unicode-Zeichen einschließlich des Leerzeichens. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        11. Die Zeichenfolge **punct** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Satzzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        12. Die Zeichenfolge **space** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Leerraumzeichen. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        13. Die Zeichenfolge **upper** ist ein atomarer Parsing-Ausdruck. Sie passt auf jeden Unicode-Großbuchstaben. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        14. Die Zeichenfolge **wordchar** ist ein atomarer Parsing-Ausdruck. Sie passt auf jedes Unicode-Wortzeichen. Das ist jedes alphanumerische Zeichen (siehe alnum) und jedes Verbindungssatzzeichen (zum Beispiel der Unterstrich). Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        15. Die Zeichenfolge **xdigit** ist ein atomarer Parsing-Ausdruck. Sie passt auf jede Hexadezimalziffer. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **string is**.

        16. Die Zeichenfolge **ddigit** ist ein atomarer Parsing-Ausdruck. Sie passt auf jede Dezimalziffer. Das ist eine eigene Erweiterung der Parsing-Ausdrücke auf der Grundlage des eingebauten Tcl-Befehls **regexp**.

        17. Der Ausdruck \[list t **x**\] ist ein atomarer Parsing-Ausdruck. Er passt auf die Terminalzeichenkette **x**.

        18. Der Ausdruck \[list n **A**\] ist ein atomarer Parsing-Ausdruck. Er passt auf das Nichtterminal **A**.


    **Zusammengesetzte Parsing-Ausdrücke**
    : 1. Für die Parsing-Ausdrücke **e1**, **e2**, … ist das Ergebnis von \[list / **e1** **e2** … \] ebenfalls ein Parsing-Ausdruck. Das ist die *geordnete Auswahl*, auch *priorisierte Auswahl* genannt.

        2. Für die Parsing-Ausdrücke **e1**, **e2**, … ist das Ergebnis von \[list x **e1** **e2** … \] ebenfalls ein Parsing-Ausdruck. Dies ist die *Sequenz*.

        3. Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list \* **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist der *Kleene-Abschluss*, der null oder mehr Wiederholungen beschreibt.

        4. Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list + **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist der *positive Kleene-Abschluss*, der eine oder mehrere Wiederholungen beschreibt.

        5. Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list & **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist das *And-Lookahead-Prädikat*.

        6. Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list ! **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist das *Not-Lookahead-Prädikat*.

        7. Für einen Parsing-Ausdruck **e** ist das Ergebnis von \[list ? **e**\] ebenfalls ein Parsing-Ausdruck. Dies ist die *optionale Eingabe*.



Kanonische Serialisierung
: Die kanonische Serialisierung eines Parsing-Ausdrucks hat das im vorherigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen dieses Parsing-Ausdrucks eindeutig ist.

    1. Die Zeichenfolgendarstellung des Werts entspricht der kanonischen Darstellung einer reinen Tcl-Liste. Das heißt, sie enthält keine überflüssigen Leerzeichen.

    2. Terminale werden *nicht* als Bereiche kodiert (bei denen Anfang und Ende des Bereichs identisch sind).



## Beispiel

Unter der Annahme, dass der auf der rechten Seite der Regel dargestellte Parsing-Ausdruck gilt

```
    Expression <- Term (AddOp Term)*
```

dann lautet seine kanonische Serialisierung (mit Ausnahme von Leerzeichen)

```
    {x {n Term} {* {x {n AddOp} {n Term}}}}
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *pt* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Parser und Grammatiken

# Copyright

```
Copyright (c) 2009 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```


[pt_peg_container]: pt_peg_container.md
