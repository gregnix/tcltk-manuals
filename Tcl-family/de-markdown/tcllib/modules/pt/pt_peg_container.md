---
CommandName: pt::peg::container
ManualSection: n
Version: 1.1
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

pt::peg::container – PEG-Speicher

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [snit]{.lit} 
[package]{.cmd} [require]{.sub} [pt::peg::container]{.lit} [1]{.optlit} 
[::pt::peg]{.cmd} [objectName]{.arg} [=|:=|<--|as|deserialize src]{.optarg} 
[objectName]{.ins} [destroy]{.sub} 
[objectName]{.ins} [clear]{.sub} 
[objectName]{.ins} [importer]{.sub} 
[objectName]{.ins} [importer]{.sub} [object]{.arg} 
[objectName]{.ins} [exporter]{.sub} 
[objectName]{.ins} [exporter]{.sub} [object]{.arg} 
[objectName]{.ins} [=]{.sub} [source]{.arg} 
[objectName]{.ins} [-->]{.sub} [destination]{.arg} 
[objectName]{.ins} [serialize]{.sub} [format]{.optarg} 
[objectName]{.ins} [deserialize]{.sub} [=]{.lit} [data]{.arg} [format]{.optarg} 
[objectName]{.ins} [deserialize]{.sub} [+=]{.lit} [data]{.arg} [format]{.optarg} 
[objectName]{.ins} [start]{.sub} 
[objectName]{.ins} [start]{.sub} [pe]{.arg} 
[objectName]{.ins} [nonterminals]{.sub} 
[objectName]{.ins} [modes]{.sub} 
[objectName]{.ins} [modes]{.sub} [dict]{.arg} 
[objectName]{.ins} [rules]{.sub} 
[objectName]{.ins} [rules]{.sub} [dict]{.arg} 
[objectName]{.ins} [add]{.sub} [nt]{.optdot} 
[objectName]{.ins} [remove]{.sub} [nt]{.optdot} 
[objectName]{.ins} [exists]{.sub} [nt]{.arg} 
[objectName]{.ins} [rename]{.sub} [ntold]{.arg} [ntnew]{.arg} 
[objectName]{.ins} [mode]{.sub} [nt]{.arg} 
[objectName]{.ins} [mode]{.sub} [nt]{.arg} [mode]{.arg} 
[objectName]{.ins} [rule]{.sub} [nt]{.arg} 
[objectName]{.ins} [rule]{.sub} [nt]{.arg} [pe]{.arg} 
:::

# BESCHREIBUNG

Sind Sie ratlos? Haben Sie Schwierigkeiten, dieses Dokument zu verstehen? Dann lesen Sie bitte die Übersicht in der *Introduction to Parser Tools*. Dieses Dokument ist der Einstiegspunkt in das Gesamtsystem, zu dem das aktuelle Paket gehört.

Dieses Paket stellt eine Containerklasse für Parsing Expression Grammars bereit. Jede Instanz speichert eine einzelne Grammatik und erlaubt es, ihre Definition zu bearbeiten und abzufragen.

Es befindet sich im Abschnitt „Speicher“ der Kernschicht der Parser-Tools und ist eine der drei Säulen, auf denen die Verwaltung von Parsing Expression Grammars beruht.

IMAGE: arch_core_container

Die beiden anderen Säulen sind, wie oben dargestellt,

**\[1\]**
: *PEG-Import* sowie

**\[2\]**
: *PEG-Export*. Die folgenden Pakete stehen damit in Zusammenhang:


**pt::rde**
: Dieses Paket enthält eine Implementierung von PARAM, einer virtuellen Maschine zum Parsen eines Kanals, die speziell auf die Anforderungen bei der Verarbeitung von PEGs zugeschnitten ist.

**pt::peg::interp**
: Dieses Paket implementiert einen Interpreter für PEGs auf Basis der von **pt::peg::rde** bereitgestellten virtuellen Maschine.


## API für Klassen

Das Paket exportiert die hier beschriebene API.

**::pt::peg** *objectName* ?**=**|**:=**|**<--**|**as**|**deserialize** *src*?
: Der Befehl erstellt ein neues Containerobjekt für eine Parsing Expression Grammar und gibt den vollqualifizierten Namen des Objektbefehls als Ergebnis zurück. Die API dieses Objektbefehls wird im Abschnitt **Objekt-API** beschrieben. Sie kann verwendet werden, um verschiedene Operationen auf dem Objekt auszuführen. Der neue Container ist leer, wenn kein *src* angegeben wird. Andernfalls enthält er eine Kopie der in *src* enthaltenen Grammatik. Alle Operatoren mit Ausnahme von **deserialize** interpretieren *src* als Container-Objektbefehl. Der Operator **deserialize** interpretiert *src* stattdessen als die Serialisierung einer Parsing Expression Grammar, wie im Abschnitt **PEG-SERIALISIERUNGSFORMAT** festgelegt. Eine leere Grammatik enthält keine nichtterminalen Symbole, und der Startausdruck ist der leere Ausdruck, d. h. Epsilon. Sie ist *gültig*, aber nicht *sinnvoll*.


## Objekt-API

Alle von diesem Paket erstellten Objekte stellen die folgenden Methoden zur Bearbeitung und Abfrage ihres Inhalts bereit:

*objectName* **destroy**
: Diese Methode zerstört das Objekt, gibt den gesamten belegten Speicher frei und löscht den zugehörigen Objektbefehl.

*objectName* **clear**
: Diese Methode setzt das Objekt so zurück, dass es die leere Grammatik enthält. Das Objekt selbst wird dabei *nicht* gelöscht.

*objectName* **importer**
: Diese Methode gibt das derzeit mit dem Container verknüpfte Import-Manager-Objekt zurück, sofern vorhanden.

*objectName* **importer** *object*
: Diese Methode fügt das *object* als Importmanager dem Container hinzu und gibt es als Ergebnis des Befehls zurück. Beachten Sie, dass das *object* *nicht* in den Besitz des Containers übergeht. Das heißt, die Löschung des Containers führt *nicht* zur Löschung des *object*. Es wird erwartet, dass *object* eine Methode namens **import text** bereitstellt, die einen Text und einen Formatnamen entgegennimmt und die kanonische Serialisierung des im Text enthaltenen Inhaltsverzeichnisses unter der Annahme des angegebenen Formats zurückgibt.

*objectName* **exporter**
: Diese Methode gibt das derzeit mit dem Container verknüpfte Exportmanager-Objekt zurück, sofern vorhanden.

*objectName* **exporter** *object*
: Diese Methode fügt das *object* als Exportmanager dem Container hinzu und gibt es als Ergebnis des Befehls zurück. Beachten Sie, dass das *object* *nicht* in den Besitz des Containers übergeht. Das heißt, die Löschung des Containers führt *nicht* zur Löschung des *object*. Es wird erwartet, dass das *object* eine Methode namens **export object** bereitstellt, die den Container und einen Formatnamen entgegennimmt und ein im Container gespeichertes, als Text kodiertes Inhaltsverzeichnis im angegebenen Format zurückgibt. Es wird ferner erwartet, dass das *object* die Methode **serialize** des Containers verwendet, um die Serialisierung des Inhaltsverzeichnisses zu holen, aus der der Text erzeugt werden soll.

*objectName* **=** *source*
: Diese Methode weist uns den Inhalt des PEG-Objekts *source* zu und überschreibt dabei die bestehenden Definitionen. Dies ist der Zuweisungsoperator für Grammatiken. Diese Operation entspricht im Grunde genommen


```
    objectName deserialize = [source serialize]
```

*objectName* **-->** *destination*
: Diese Methode weist dem PEG-Objekt *destination* unsere Inhalte zu und überschreibt dabei die bestehenden Definitionen. Dies ist der umgekehrte Zuweisungsoperator für Grammatiken. Diese Operation entspricht im Grunde genommen


```
    destination deserialize = [objectName serialize]
```

*objectName* **serialize** ?*format*?
: Diese Methode gibt unsere Grammatik in einer textuellen Form zurück, die für die Übertragung, die dauerhafte Speicherung usw. geeignet ist. Wenn kein *format* angegeben wird, entspricht das zurückgegebene Ergebnis der kanonischen Serialisierung der Grammatik, wie im Abschnitt **PEG-SERIALISIERUNGSFORMAT** beschrieben. Andernfalls verwendet das Objekt den angehängten Export-Manager, um die Daten in das angegebene Format zu konvertieren. In diesem Fall schlägt die Methode mit einer Fehlermeldung fehl, wenn dem Container kein Export-Manager angehängt ist.

*objectName* **deserialize =** *data* ?*format*?
: Dies ist die ergänzende Methode zu **serialize**. Sie ersetzt die aktuelle Definition durch die in *data* enthaltene Grammatik. Wurde kein *format* angegeben, wird davon ausgegangen, dass es sich um die reguläre Serialisierung einer Grammatik handelt, wie im Abschnitt **PEG-SERIALISIERUNGSFORMAT** beschrieben. Andernfalls verwendet das Objekt den angehängten Import-Manager, um die Daten aus dem angegebenen Format in eine für das Objekt verarbeitbare Serialisierung zu konvertieren. In diesem Fall schlägt die Methode mit einer Fehlermeldung fehl, wenn dem Container kein Importmanager zugeordnet ist. Das Ergebnis der Methode ist die leere Zeichenkette.

*objectName* **deserialize +=** *data* ?*format*?
: Diese Methode verhält sich im Wesentlichen wie **deserialize =**, mit dem Unterschied, dass sie die Grammatik in *data* mit deren Inhalt zusammenführt, anstatt sie zu ersetzen. Die Methode bricht mit einer Fehlermeldung ab und lässt die Grammatik unverändert, wenn eine Zusammenführung nicht möglich ist, d. h. wenn dadurch eine ungültige Grammatik entstehen würde. Das Ergebnis der Methode ist die leere Zeichenkette.

*objectName* **start**
: Diese Methode gibt den aktuellen Startausdruck der Grammatik zurück.

*objectName* **start** *pe*
: Diese Methode definiert den *Startausdruck* der Grammatik. Sie ersetzt den aktuellen Startausdruck durch den Parsing-Ausdruck *pe* und gibt den neuen Startausdruck zurück. Die Methode bricht mit einer Fehlermeldung ab und lässt die Grammatik unverändert, falls *pe* keinen gültigen Parsing-Ausdruck enthält, wie im Abschnitt **PE-SERIALISIERUNGSFORMAT** festgelegt.

*objectName* **nonterminals**
: Diese Methode gibt die Menge aller der Grammatik bekannten nichtterminalen Symbole zurück.

*objectName* **modes**
: Diese Methode gibt ein Dictionary zurück, das die Menge aller der Grammatik bekannten nichtterminalen Symbole ihren semantischen Modi zuordnet.

*objectName* **modes** *dict*
: Diese Methode nimmt ein Dictionary entgegen, das eine Menge von der Grammatik bekannter nichtterminaler Symbole ihren semantischen Modi zuordnet, und gibt das neue vollständige Dictionary der nichtterminalen Symbole zu semantischen Modi zurück. Die Methode schlägt mit einem Fehler fehl, wenn eines der nichtterminalen Symbole im Dictionary der Grammatik unbekannt ist oder die leere Zeichenkette darstellt, d. h. ein ungültiges nichtterminales Symbol ist, oder wenn einer der gewählten *mode* nicht zu den zulässigen Werten gehört.

*objectName* **rules**
: Diese Methode gibt ein Dictionary zurück, das die Menge aller der Grammatik bekannten nichtterminalen Symbole ihren Parsing-Ausdrücken (Rechtsseiten) zuordnet.

*objectName* **rules** *dict*
: Diese Methode nimmt ein Dictionary entgegen, das eine Menge der der Grammatik bekannter nichtterminaler Symbole ihren Parsing-Ausdrücken (Rechtsseiten) zuordnet, und gibt das neue vollständige Dictionary der nichtterminalen Symbole zu Parsing-Ausdrücken zurück. Die Methode schlägt mit einer Fehlermeldung fehl, wenn eines der nichtterminalen Symbole im Dictionary der Grammatik nicht bekannt ist, wenn die leere Zeichenkette – d. h. ein ungültiges nichtterminales Symbol – enthalten ist oder wenn einer der ausgewählten Parsing-Ausdrücke kein gültiger Parsing-Ausdruck im Sinne des Abschnitts **PE-SERIALISIERUNGSFORMAT** ist.

*objectName* **add** ?*nt*...?
: Diese Methode fügt die nichtterminalen Symbole *nt* usw. zur Grammatik hinzu und definiert dafür den standardmäßigen semantischen Modus sowie den Ausdruck (**value** bzw. **epsilon**). Die Methode gibt als Ergebnis die leere Zeichenkette zurück. Die Methode schlägt mit einer Fehlermeldung fehl und lässt die Grammatik unverändert, wenn eines der nichtterminalen Symbole entweder bereits in unserer Grammatik definiert ist oder der leeren Zeichenkette entspricht (ein ungültiges nichtterminales Symbol). Die Methode führt keine Aktion aus, wenn kein Symbol als Argument festgelegt wurde.

*objectName* **remove** ?*nt*...?
: Diese Methode entfernt die genannten nichtterminalen Symbole *nt* usw. aus der Menge der unserer Grammatik bekannten nichtterminalen Symbole. Die Methode gibt als Ergebnis die leere Zeichenkette zurück. Die Methode schlägt mit einer Fehlermeldung fehl und lässt die Grammatik unverändert, wenn eines der nichtterminalen Symbole der Grammatik nicht bekannt ist oder es sich um die leere Zeichenkette handelt, d. h. um ein ungültiges nichtterminales Symbol.

*objectName* **exists** *nt*
: Diese Methode prüft, ob das nichtterminale Symbol *nt* in unserer Grammatik bekannt ist oder nicht. Der Wert ist boolesch. Er wird auf **true** gesetzt, wenn *nt* bekannt ist, andernfalls auf **false**. Die Methode schlägt mit einer Fehlermeldung fehl, wenn *nt* die leere Zeichenkette ist, d. h. ein ungültiges nichtterminales Symbol.

*objectName* **rename** *ntold* *ntnew*
: Diese Methode benennt das nichtterminale Symbol *ntold* in *ntnew* um. Die Methode gibt als Ergebnis die leere Zeichenkette zurück. Die Methode schlägt mit einer Fehlermeldung fehl und lässt die Grammatik unverändert, wenn entweder *ntold* der Grammatik nicht bekannt ist, *ntnew* bereits bekannt ist oder eines der beiden Symbole die leere Zeichenkette ist, d. h. ein ungültiges nichtterminales Symbol.

*objectName* **mode** *nt*
: Diese Methode gibt den aktuellen semantischen Modus für das nichtterminale Symbol *nt* zurück. Die Methode schlägt mit einer Fehlermeldung fehl, wenn *nt* in der Grammatik nicht bekannt ist oder es sich um die leere Zeichenkette handelt, d. h. um ein ungültiges nichtterminales Symbol.

*objectName* **mode** *nt* *mode*
: Diese Methode setzt den semantischen Modus für das nichtterminale Symbol *nt* fest und gibt den neuen Modus zurück. Die Methode schlägt mit einer Fehlermeldung fehl, wenn *nt* der Grammatik nicht bekannt ist, es sich um die leere Zeichenkette handelt – d. h. um ein ungültiges nichtterminales Symbol – oder der gewählte *mode* nicht zu den zulässigen Werten gehört. Die folgenden Modi sind zulässig:


**value**
: Der semantische Wert des nichtterminalen Symbols ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminale selbst besteht, dessen Kindknoten die ASTs der rechten Seite des Symbols sind.

**leaf**
: Der semantische Wert des Nichtterminalsymbols ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminal besteht, der keine Kindknoten hat. Alle durch die rechte Seite des Symbols erzeugten ASTs werden verworfen.

**void**
: Das Nichtterminal hat keinen semantischen Wert. Alle ASTs, die durch die rechte Seite des Symbols erzeugt werden, werden (ebenfalls) verworfen.


*objectName* **rule** *nt*
: Diese Methode gibt den aktuellen Parsing-Ausdruck (rechte Seite) für das nichtterminale Symbol *nt* zurück. Die Methode schlägt mit einer Fehlermeldung fehl, wenn *nt* der Grammatik nicht bekannt ist oder es sich um die leere Zeichenkette handelt, d. h. um ein ungültiges nichtterminales Symbol.

*objectName* **rule** *nt* *pe*
: Diese Methode setzt den Parsing-Ausdruck (rechte Seite) des Nichtterminals *nt* auf *pe* und gibt den neuen Parsing-Ausdruck zurück. Die Methode schlägt mit einer Fehlermeldung fehl, wenn *nt* der Grammatik nicht bekannt ist oder es sich um die leere Zeichenkette handelt, d. h. um ein ungültiges nichtterminales Symbol, oder wenn *pe* keinen gültigen Parsing-Ausdruck enthält, wie im Abschnitt **PE-SERIALISIERUNGSFORMAT** festgelegt.


# PEG-SERIALISIERUNGSFORMAT

Hier legen wir das Format fest, das von den Parser-Tools verwendet wird, um Parsing Expression Grammars als unveränderliche Werte für die Übertragung, den Vergleich usw. zu serialisieren.

Wir unterscheiden zwischen *regulären* und *kanonischen* Serialisierungen. Auch wenn ein PEG mehr als eine reguläre Serialisierung haben kann, ist jeweils genau eine davon *kanonisch*.

**Reguläre Serialisierung**
: 


**\[1\]**
: Die Serialisierung eines beliebigen PEG ist ein verschachteltes Tcl-Dictionary.

**\[2\]**
: Dieses Dictionary enthält einen einzigen Schlüssel, **pt::grammar::peg**, sowie dessen Wert. Dieser Wert enthält den Inhalt der Grammatik.

**\[3\]**
: Der Inhalt der Grammatik besteht aus einem Tcl-Dictionary, das die Menge der nichtterminalen Symbole und den Startausdruck enthält. Die relevanten Schlüssel und ihre Werte lauten


**rules**
: Der Wert ist ein Tcl-Dictionary, dessen Schlüssel die Namen der in der Grammatik bekannten nichtterminalen Symbole sind.


**\[1\]**
: Jedes nichtterminale Symbol darf nur einmal vorkommen.

**\[2\]**
: Die leere Zeichenkette ist kein zulässiges nichtterminales Symbol.

**\[3\]**
: Der Wert für jedes Symbol ist selbst ein Tcl-Dictionary. Die entsprechenden Schlüssel und ihre Werte in diesem Dictionary lauten


**is**
: Der Wert entspricht der Serialisierung des Parsing-Ausdrucks, der die Satzstruktur des Symbols beschreibt, wie im Abschnitt **PE-SERIALISIERUNGSFORMAT** festgelegt.

**mode**
: Der Wert kann einer von drei Werten sein, die festlegen, wie ein Parser mit dem durch das Symbol erzeugten semantischen Wert umgehen soll.


**value**
: Der semantische Wert des nichtterminalen Symbols ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminale selbst besteht, dessen Kindknoten die ASTs der rechten Seite des Symbols sind.

**leaf**
: Der semantische Wert des Nichtterminalsymbols ist ein abstrakter Syntaxbaum, der aus einem einzigen Knoten für das Nichtterminal besteht, der keine Kindknoten hat. Alle durch die rechte Seite des Symbols erzeugten ASTs werden verworfen.

**void**
: Das Nichtterminal hat keinen semantischen Wert. Alle ASTs, die durch die rechte Seite des Symbols erzeugt werden, werden (ebenfalls) verworfen.


**start**
: Der Wert entspricht der Serialisierung des Start-Parsing-Ausdrucks der Grammatik, wie im Abschnitt **PE-SERIALISIERUNGSFORMAT** beschrieben.


**\[4\]**
: Die Terminalsymbole der Grammatik werden implizit als die Menge aller Terminalsymbole festgelegt, die im Startausdruck und auf der rechten Seite der Grammatikregeln verwendet werden.


**Kanonische Serialisierung**
: Die kanonische Serialisierung einer Grammatik hat das im vorherigen Punkt festgelegte Format und erfüllt darüber hinaus die nachstehenden Einschränkungen, wodurch sie unter allen möglichen Serialisierungen dieser Grammatik eindeutig ist.


**\[1\]**
: Die Schlüssel in allen verschachtelten Tcl-Dictionaries sind in aufsteigender Wörterbuchreihenfolge sortiert, wie sie der eingebaute Tcl-Befehl **lsort -increasing -dict** erzeugt.

**\[2\]**
: Die Zeichenfolgendarstellung des Werts entspricht der kanonischen Darstellung eines Tcl-Dictionaries. Das heißt, sie enthält keine überflüssigen Leerzeichen.


## Beispiel

Unter der Annahme der folgenden PEG für einfache mathematische Ausdrücke

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

dann lautet seine kanonische Serialisierung (mit Ausnahme von Leerzeichen)

```
pt::grammar::peg {
    rules {
        AddOp      {is {/ {t -} {t +}}                                                                mode value}
        Digit      {is {/ {t 0} {t 1} {t 2} {t 3} {t 4} {t 5} {t 6} {t 7} {t 8} {t 9}}                mode value}
        Expression {is {x {n Term} {* {x {n AddOp} {n Term}}}}                                        mode value}
        Factor     {is {/ {x {t (} {n Expression} {t )}} {n Number}}                                  mode value}
        MulOp      {is {/ {t *} {t /}}                                                                mode value}
        Number     {is {x {? {n Sign}} {+ {n Digit}}}                                                 mode value}
        Sign       {is {/ {t -} {t +}}                                                                mode value}
        Term       {is {x {n Factor} {* {x {n MulOp} {n Factor}}}}                                    mode value}
    }
    start {n Expression}
}
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
: Für die Parsing-Ausdrücke **e1**, **e2**, … ist das Ergebnis von \[list / **e1** **e2** … \] ebenfalls ein Parsing-Ausdruck. Hierbei handelt es sich um die *geordnete Auswahl*, auch bekannt als *priorisierte Auswahl*.

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
