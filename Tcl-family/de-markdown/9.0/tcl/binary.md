---
CommandName: binary
title: binary
ManualSection: n
Version: 8.0
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - encoding(n)
 - format(n)
 - scan(n)
 - string(n)
 - tcl_platform(n)
Keywords:
 - binary
 - format
 - scan
Copyright:
 - Copyright (c) 1997 Sun Microsystems, Inc.
 - Copyright (c) 2008 Donal K. Fellows
---

# Name

binary - Felder in Binärzeichenketten einfügen und extrahieren

# Übersicht

::: {.synopsis} :::
[binary]{.cmd} [decode]{.sub} [format]{.arg} [-option value]{.optdot} [data]{.arg}
[binary]{.cmd} [encode]{.sub} [format]{.arg} [-option value]{.optdot} [data]{.arg}
[binary]{.cmd} [format]{.sub} [formatString]{.arg} [arg arg]{.optdot}
[binary]{.cmd} [scan]{.sub} [string]{.arg} [formatString]{.arg} [varName varName]{.optdot}
:::

# Beschreibung

Dieser Befehl stellt Hilfsmittel zur Verarbeitung binärer Daten bereit. Der Unterbefehl **binary format** erzeugt aus normalen Tcl-Werten eine Binärzeichenkette. Aus den Werten 16 und 22 könnte er auf einer 32-Bit-Architektur zum Beispiel eine 8 Byte lange Binärzeichenkette erzeugen, die aus zwei 4-Byte-Ganzzahlen besteht, je eine für jede der beiden Zahlen. Der Unterbefehl **binary scan** macht das Gegenteil: Er extrahiert Daten aus einer Binärzeichenkette und gibt sie als gewöhnliche Tcl-Zeichenkettenwerte zurück. Die Unterbefehle **binary encode** und **binary decode** wandeln binäre Daten in Zeichenkettenkodierungen wie base64 um (base64 wird zum Beispiel in MIME-Nachrichten verwendet) oder aus ihnen zurück.

Beachten Sie, dass andere Operationen auf binären Daten von anderen Tcl-Befehlen erledigt werden, etwa das Bilden einer Teilfolge, das Ermitteln der Länge oder die Neuinterpretation der Daten als Zeichenkette in einer bestimmten Kodierung (in den genannten Beispielfällen sind das [string range][string], [string length][string] und [encoding convertfrom][encoding]). Eine Binärzeichenkette ist in Tcl lediglich eine Zeichenkette, deren Zeichen alle im Bereich \\u0000-\\u00FF liegen.

# Kodierung und Dekodierung

Um binäre Daten als lesbare Zeichenkette zu kodieren, übergeben Sie die binären Ausgangsdaten an den Befehl **binary encode**, zusammen mit dem Namen der zu verwendenden Kodierung und allen gewünschten kodierungsspezifischen Optionen. Kodierte Daten lassen sich mit **binary decode** wieder in die binäre Form zurückwandeln. Der Befehl **binary encode** löst einen Fehler aus, wenn das Argument *data* keine binären Daten sind. Folgende Formate und Optionen werden unterstützt.

[base64]{.cmd}
: Die Binärkodierung **base64** wird häufig in E-Mail-Nachrichten und XML-Dokumenten verwendet und besteht überwiegend aus Groß- und Kleinbuchstaben sowie Ziffern. Sie zeichnet sich dadurch aus, dass sie beliebig neu umbrochen werden kann, ohne dass dabei Information verloren geht.

    Beim Kodieren werden folgende Optionen unterstützt:

    [-maxlen]{.lit} [length]{.arg}
    : Gibt an, dass die Ausgabe in Zeilen von höchstens *length* Zeichen aufgeteilt werden soll. Standardmäßig werden die Zeilen nicht aufgeteilt.

    [-wrapchar]{.lit} [character]{.arg}
    : Gibt an, dass *character* die Zeilen trennen soll, wenn sie wegen der Option **-maxlen** aufgeteilt werden. Standardmäßig ist das ein Zeilenumbruchzeichen, „\\n“.


    Beim Dekodieren werden folgende Optionen unterstützt:

    [-strict]{.lit}
    : Weist den Dekodierer an, einen Fehler auszulösen, wenn er auf Zeichen trifft, die nicht im strengen Sinne zur Kodierung selbst gehören. Andernfalls ignoriert er sie. RFC 2045 verlangt, dass base64-Dekodierer nicht strikt arbeiten.


**hex**
: Die Binärkodierung **hex** wandelt jedes Byte in ein Paar hexadezimaler Ziffern um, die den Byte-Wert als hexadezimale Ganzzahl darstellen. Beim Kodieren werden Kleinbuchstaben verwendet. Beim Dekodieren werden Groß- und Kleinbuchstaben akzeptiert.

    Beim Kodieren werden keine Optionen unterstützt. Beim Dekodieren werden folgende Optionen unterstützt:

    [-strict]{.lit}
    : Weist den Dekodierer an, einen Fehler auszulösen, wenn er auf Leerraumzeichen trifft. Andernfalls ignoriert er sie.


**uuencode**
: Die Binärkodierung **uuencode** war früher für die Übertragung von Daten zwischen Unix-Systemen und im USENET verbreitet. Heute ist sie weniger gebräuchlich, da sie weitgehend von der Binärkodierung **base64** abgelöst wurde.

    Beim Kodieren werden folgende Optionen unterstützt (ihre Änderung kann allerdings Dateien erzeugen, die andere Dekodierer-Implementierungen nicht verarbeiten können):

    [-maxlen]{.lit} [length]{.arg}
    : Gibt die maximale Anzahl an Zeichen an, die für jede kodierte Zeile erzeugt werden. Der gültige Bereich ist 5 bis 85. Zeilenlängen außerhalb dieses Bereichs kann das Kodierungsformat nicht abbilden. Der Standardwert ist 61.

    [-wrapchar]{.lit} [character]{.arg}
    : Gibt das Zeichen oder die Zeichen an, die das Ende jeder kodierten Zeile markieren. Zulässig ist eine Folge von null oder mehr Zeichen aus der Menge { \\x09 (TAB), \\x0B (VT), \\x0C (FF), \\x0D (CR) }, gefolgt von null oder einem Zeilenumbruch \\x0A (LF). Alle anderen Werte werden abgelehnt, weil sie kodierten Text erzeugen würden, der sich nicht dekodieren ließe. Der Standardwert ist ein einzelner Zeilenumbruch.


    Beim Dekodieren werden folgende Optionen unterstützt:

    [-strict]{.lit}
    : Weist den Dekodierer an, einen Fehler auszulösen, wenn er auf etwas außerhalb des Standard-Kodierungsformats trifft. Ohne diese Option toleriert der Dekodierer einige Abweichungen, vor allem damit Zeilen, die zwischen Kodierer und Dekodierer neu umbrochen wurden, keinen Fehler verursachen.


    Beachten Sie, dass weder der Kodierer noch der Dekodierer Kopf- und Fußzeile des uuencode-Formats verarbeiten.


# Binärformat

Der Befehl **binary format** erzeugt eine Binärzeichenkette, deren Aufbau durch *formatString* festgelegt ist und deren Inhalt aus den weiteren Argumenten stammt. Der Befehl gibt den resultierenden Binärwert zurück.

*formatString* besteht aus einer Folge von null oder mehr Feldspezifizierern, die durch null oder mehr Leerzeichen getrennt sind. Jeder Feldspezifizierer besteht aus einem einzelnen Typzeichen, gefolgt von einem optionalen Flag-Zeichen und einer optionalen numerischen Anzahl *count*. Die meisten Feldspezifizierer verbrauchen ein Argument, aus dem sie den zu formatierenden Wert beziehen. Das Typzeichen legt fest, wie der Wert formatiert wird. *count* gibt in der Regel an, wie viele Elemente des angegebenen Typs aus dem Wert entnommen werden. Falls vorhanden, ist *count* eine nicht-negative dezimale Ganzzahl oder „**\***“; Letzteres bedeutet normalerweise, dass alle Elemente des Werts verwendet werden. Stimmt die Anzahl der Argumente nicht mit der Anzahl der Felder in der Formatzeichenkette überein, die Argumente verbrauchen, wird ein Fehler erzeugt. Das Flag-Zeichen wird von **binary format** ignoriert.

Ein kleines Beispiel soll den Zusammenhang zwischen den Feldspezifizierern und den Argumenten verdeutlichen:

```
binary format d3d {1.0 2.0 3.0 4.0} 0.1
```

Das erste Argument ist eine Liste mit vier Zahlen. Da der zugehörige Feldspezifizierer jedoch die Anzahl 3 hat, werden nur die ersten drei Zahlen verwendet. Das zweite Argument gehört zum zweiten Feldspezifizierer. Die resultierende Binärzeichenkette enthält die vier Zahlen 1.0, 2.0, 3.0 und 0.1.

Jedes Paar aus Typ und Anzahl bewegt einen gedachten Cursor durch die Binärdaten: Es speichert Bytes an der aktuellen Position und setzt den Cursor unmittelbar hinter das zuletzt gespeicherte Byte. Anfangs steht der Cursor auf Position 0 am Anfang der Daten. Der Typ kann eines der folgenden Zeichen sein:

**a**
: Speichert eine Byte-Zeichenkette der Länge *count* in der Ausgabezeichenkette. Jedes Zeichen wird modulo 256 genommen (d. h., das niederwertige Byte jedes Zeichens wird verwendet und das höherwertige verworfen). Wenn Sie Zeichenketten speichern, die sich nicht vollständig mit den Zeichen \\u0000-\\u00ff darstellen lassen, sollten Sie daher zuerst mit dem Befehl [encoding convertto][encoding] die Zeichenkette in eine externe Darstellung umwandeln, falls diese Kürzung nicht erwünscht ist (d. h., wenn die Zeichen nicht zum Zeichensatz ISO 8859-1 gehören). Hat *arg* weniger als *count* Bytes, wird das Feld mit zusätzlichen Null-Bytes aufgefüllt. Ist *arg* länger als die angegebene Länge, werden die überzähligen Zeichen ignoriert. Ist *count* „**\***“, werden alle Bytes von *arg* formatiert. Fehlt *count*, wird ein Zeichen formatiert. Zum Beispiel gibt der Befehl:

    ```
    binary format a7a*a alpha bravo charlie
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    alpha\000\000bravoc
    ```

    der Befehl:

    ```
    binary format a* [encoding convertto utf-8 \u20ac]
    ```

    gibt eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \342\202\254
    ```

    (das ist die UTF-8-Bytefolge für das Euro-Währungszeichen), und der Befehl:

    ```
    binary format a* [encoding convertto iso8859-15 \u20ac]
    ```

    gibt eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \244
    ```

    (das ist die ISO-8859-15-Bytefolge für das Euro-Währungszeichen). Vergleichen Sie diese beiden letzten Beispiele mit:

    ```
    binary format a* \u20ac
    ```

    das eine Binärzeichenkette zurückgibt, die äquivalent ist zu:

    ```
    \254
    ```

    (d. h. **\\xAC**), weil die höherwertigen Bits des Zeichens abgeschnitten werden. Das ist vermutlich nicht erwünscht.

**A**
: Diese Form entspricht **a**, außer dass zum Auffüllen Leerzeichen statt Null-Bytes verwendet werden. Zum Beispiel gibt

    ```
    binary format A6A*A alpha bravo charlie
    ```

    Folgendes zurück:

    ```
    alpha bravoc
    ```

**b**
: Speichert eine Zeichenkette aus *count* Binärziffern in der Ausgabe-Binärzeichenkette, und zwar innerhalb jedes Bytes in der Reihenfolge vom niederwertigen zum höherwertigen Bit. *Arg* muss eine Folge von Zeichen **1** und **0** enthalten. Die resultierenden Bytes werden vom ersten bis zum letzten ausgegeben, wobei die Bits innerhalb jedes Bytes vom niederwertigen zum höherwertigen formatiert werden. Hat *arg* weniger als *count* Ziffern, werden für die restlichen Bits Nullen verwendet. Hat *arg* mehr als die angegebene Anzahl Ziffern, werden die überzähligen Ziffern ignoriert. Ist *count* „**\***“, werden alle Ziffern von *arg* formatiert. Fehlt *count*, wird eine Ziffer formatiert. Endet die Anzahl der formatierten Bits nicht an einer Byte-Grenze, sind die restlichen Bits des letzten Bytes Nullen. Zum Beispiel gibt

    ```
    binary format b5b* 11100 111000011010
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \x07\x87\x05
    ```

**B**
: Diese Form entspricht **b**, außer dass die Bits innerhalb jedes Bytes vom höherwertigen zum niederwertigen gespeichert werden. Zum Beispiel gibt

    ```
    binary format B5B* 11100 111000011010
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \xE0\xE1\xA0
    ```

**H**
: Speichert eine Zeichenkette aus *count* hexadezimalen Ziffern in der Ausgabe-Binärzeichenkette, und zwar innerhalb jedes Bytes vom höherwertigen zum niederwertigen Halbbyte. *Arg* muss eine Folge von Zeichen aus der Menge „0123456789abcdefABCDEF“ enthalten. Die resultierenden Bytes werden vom ersten bis zum letzten ausgegeben, wobei die Hex-Ziffern innerhalb jedes Bytes vom höherwertigen zum niederwertigen formatiert werden. Hat *arg* weniger als *count* Ziffern, werden für die restlichen Ziffern Nullen verwendet. Hat *arg* mehr als die angegebene Anzahl Ziffern, werden die überzähligen Ziffern ignoriert. Ist *count* „**\***“, werden alle Ziffern von *arg* formatiert. Fehlt *count*, wird eine Ziffer formatiert. Endet die Anzahl der formatierten Ziffern nicht an einer Byte-Grenze, sind die restlichen Bits des letzten Bytes Nullen. Zum Beispiel gibt

    ```
    binary format H3H*H2 ab DEF 987
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \xAB\x00\xDE\xF0\x98
    ```

**h**
: Diese Form entspricht **H**, außer dass die Ziffern innerhalb jedes Bytes vom niederwertigen zum höherwertigen gespeichert werden. Das wird selten benötigt. Zum Beispiel gibt

    ```
    binary format h3h*h2 AB def 987
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \xBA\x00\xED\x0F\x89
    ```

**c**
: Speichert einen oder mehrere 8-Bit-Ganzzahlwerte in der Ausgabezeichenkette. Ist kein *count* angegeben, muss *arg* aus einem Ganzzahlwert bestehen. Ist *count* angegeben, muss *arg* aus einer Liste mit mindestens so vielen Ganzzahlen bestehen. Die niederwertigen 8 Bits jeder Ganzzahl werden als Ein-Byte-Wert an der Cursorposition gespeichert. Ist *count* „**\***“, werden alle Ganzzahlen der Liste formatiert. Enthält die Liste mehr Elemente als *count*, werden die überzähligen Elemente ignoriert. Zum Beispiel gibt

    ```
    binary format c3cc* {3 -3 128 1} 260 {2 5}
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \x03\xFD\x80\x04\x02\x05
    ```

    während

    ```
    binary format c {2 5}
    ```

    einen Fehler erzeugt.

**s**
: Diese Form entspricht **c**, außer dass sie eine oder mehrere 16-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge in der Ausgabezeichenkette speichert. Die niederwertigen 16 Bits jeder Ganzzahl werden als Zwei-Byte-Wert an der Cursorposition gespeichert, das niederwertigste Byte zuerst. Zum Beispiel gibt

    ```
    binary format s3 {3 -3 258 1}
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \x03\x00\xFD\xFF\x02\x01
    ```

**S**
: Diese Form entspricht **s**, außer dass sie eine oder mehrere 16-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge in der Ausgabezeichenkette speichert. Zum Beispiel gibt

    ```
    binary format S3 {3 -3 258 1}
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \x00\x03\xFF\xFD\x01\x02
    ```

**t**
: Diese Form (als Eselsbrücke *tiny*) entspricht **s** und **S**, außer dass sie die 16-Bit-Ganzzahlen in der nativen Byte-Reihenfolge des Rechners, auf dem das Tcl-Skript läuft, in der Ausgabezeichenkette speichert. Welche Byte-Reihenfolge der Rechner nativ verwendet, entnehmen Sie dem Element **byteOrder** des Arrays [tcl\_platform][tclvars].

**i**
: Diese Form entspricht **c**, außer dass sie eine oder mehrere 32-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge in der Ausgabezeichenkette speichert. Die niederwertigen 32 Bits jeder Ganzzahl werden als Vier-Byte-Wert an der Cursorposition gespeichert, das niederwertigste Byte zuerst. Zum Beispiel gibt

    ```
    binary format i3 {3 -3 65536 1}
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \x03\x00\x00\x00\xFD\xFF\xFF\xFF\x00\x00\x01\x00
    ```

**I**
: Diese Form entspricht **i**, außer dass sie eine oder mehrere 32-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge in der Ausgabezeichenkette speichert. Zum Beispiel gibt

    ```
    binary format I3 {3 -3 65536 1}
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \x00\x00\x00\x03\xFF\xFF\xFF\xFD\x00\x01\x00\x00
    ```

**n**
: Diese Form (als Eselsbrücke *number* oder *normal*) entspricht **i** und **I**, außer dass sie die 32-Bit-Ganzzahlen in der nativen Byte-Reihenfolge des Rechners, auf dem das Tcl-Skript läuft, in der Ausgabezeichenkette speichert. Welche Byte-Reihenfolge der Rechner nativ verwendet, entnehmen Sie dem Element **byteOrder** des Arrays [tcl\_platform][tclvars].

**w**
: Diese Form entspricht **c**, außer dass sie eine oder mehrere 64-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge in der Ausgabezeichenkette speichert. Die niederwertigen 64 Bits jeder Ganzzahl werden als Acht-Byte-Wert an der Cursorposition gespeichert, das niederwertigste Byte zuerst. Zum Beispiel gibt

    ```
    binary format w 7810179016327718216
    ```

    die Binärzeichenkette **HelloTcl** zurück.

**W**
: Diese Form entspricht **w**, außer dass sie eine oder mehrere 64-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge in der Ausgabezeichenkette speichert. Zum Beispiel gibt

    ```
    binary format Wc 4785469626960341345 110
    ```

    die Binärzeichenkette **BigEndian** zurück.

**m**
: Diese Form (als Eselsbrücke das Spiegelbild von **w**) entspricht **w** und **W**, außer dass sie die 64-Bit-Ganzzahlen in der nativen Byte-Reihenfolge des Rechners, auf dem das Tcl-Skript läuft, in der Ausgabezeichenkette speichert. Welche Byte-Reihenfolge der Rechner nativ verwendet, entnehmen Sie dem Element **byteOrder** des Arrays [tcl\_platform][tclvars].

**f**
: Diese Form entspricht **c**, außer dass sie eine oder mehrere Gleitkommazahlen einfacher Genauigkeit in der nativen Darstellung des Rechners in der Ausgabezeichenkette speichert. Diese Darstellung ist nicht zwischen Architekturen portierbar und sollte daher nicht verwendet werden, um Gleitkommazahlen über das Netzwerk zu übertragen. Die Größe einer Gleitkommazahl kann je nach Architektur unterschiedlich sein, sodass auch die Anzahl der erzeugten Bytes variieren kann. Läuft der Wert über die native Darstellung des Rechners hinaus, wird stattdessen der vom System definierte Wert FLT\_MAX verwendet. Da Tcl intern Gleitkommazahlen doppelter Genauigkeit verwendet, kann bei der Umwandlung in einfache Genauigkeit etwas Genauigkeit verloren gehen. Auf einem Windows-System mit Intel-Pentium-Prozessor gibt zum Beispiel

    ```
    binary format f2 {1.6 3.4}
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \xCD\xCC\xCC\x3F\x9A\x99\x59\x40
    ```

**r**
: Diese Form (als Eselsbrücke *real*) entspricht **f**, außer dass sie die Gleitkommazahlen einfacher Genauigkeit in Little-Endian-Reihenfolge speichert. Diese Umwandlung liefert nur auf Rechnern eine sinnvolle Ausgabe, die die IEEE-Gleitkommadarstellung verwenden (sehr verbreitet, aber nicht universell).

**R**
: Diese Form entspricht **r**, außer dass sie die Gleitkommazahlen einfacher Genauigkeit in Big-Endian-Reihenfolge speichert.

**d**
: Diese Form entspricht **f**, außer dass sie eine oder mehrere Gleitkommazahlen doppelter Genauigkeit in der nativen Darstellung des Rechners in der Ausgabezeichenkette speichert. Auf einem Windows-System mit Intel-Pentium-Prozessor gibt zum Beispiel

    ```
    binary format d1 {1.6}
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    \x9A\x99\x99\x99\x99\x99\xF9\x3F
    ```

**q**
: Diese Form (als Eselsbrücke das Spiegelbild von **d**) entspricht **d**, außer dass sie die Gleitkommazahlen doppelter Genauigkeit in Little-Endian-Reihenfolge speichert. Diese Umwandlung liefert nur auf Rechnern eine sinnvolle Ausgabe, die die IEEE-Gleitkommadarstellung verwenden (sehr verbreitet, aber nicht universell).

**Q**
: Diese Form entspricht **q**, außer dass sie die Gleitkommazahlen doppelter Genauigkeit in Big-Endian-Reihenfolge speichert.

**x**
: Speichert *count* Null-Bytes in der Ausgabezeichenkette. Ist *count* nicht angegeben, wird ein Null-Byte gespeichert. Ist *count* „**\***“, wird ein Fehler erzeugt. Dieser Typ verbraucht kein Argument. Zum Beispiel gibt

    ```
    binary format a3xa3x2a3 abc def ghi
    ```

    eine Binärzeichenkette zurück, die äquivalent ist zu:

    ```
    abc\000def\000\000ghi
    ```

**X**
: Bewegt den Cursor in der Ausgabezeichenkette um *count* Bytes zurück. Ist *count* „**\***“ oder größer als die aktuelle Cursorposition, wird der Cursor auf Position 0 gesetzt, sodass das nächste gespeicherte Byte das erste Byte der Ergebniszeichenkette ist. Fehlt *count*, wird der Cursor um ein Byte zurückbewegt. Dieser Typ verbraucht kein Argument. Zum Beispiel gibt

    ```
    binary format a3X*a3X2a3 abc def ghi
    ```

    **dghi** zurück.

**@**
: Bewegt den Cursor an die durch *count* angegebene absolute Position in der Ausgabezeichenkette. Position 0 bezeichnet das erste Byte der Ausgabezeichenkette. Bezeichnet *count* eine Position hinter dem bisher zuletzt gespeicherten Byte, werden an den nicht initialisierten Stellen Null-Bytes eingefügt, und der Cursor wird auf die angegebene Position gesetzt. Ist *count* „**\***“, wird der Cursor an das aktuelle Ende der Ausgabezeichenkette bewegt. Fehlt *count*, wird ein Fehler erzeugt. Dieser Typ verbraucht kein Argument. Zum Beispiel gibt

    ```
    binary format a5@2a1@*a3@10a1 abcde f ghi j
    ```

    Folgendes zurück:

    ```
    abfdeghi\000\000j
    ```


# Binärscan

Der Befehl **binary scan** liest Felder aus einer Binärzeichenkette aus und gibt die Anzahl der durchgeführten Umwandlungen zurück. *String* enthält die zu verarbeitenden Eingabebytes, und *formatString* gibt an, wie sie verarbeitet werden. Ist *string* etwas anderes als ein gültiger binärer Datenwert, wird ein Fehler ausgelöst. Jedes *varName* gibt den Namen einer Variablen an. Wird ein Feld aus *string* gelesen, wird das Ergebnis der zugehörigen Variablen zugewiesen.

Wie bei **binary format** besteht *formatString* aus einer Folge von null oder mehr Feldspezifizierern, die durch null oder mehr Leerzeichen getrennt sind. Jeder Feldspezifizierer besteht aus einem einzelnen Typzeichen, gefolgt von einem optionalen Flag-Zeichen und einer optionalen numerischen Anzahl *count*. Die meisten Feldspezifizierer verbrauchen ein Argument, das die Variable angibt, in der die gelesenen Werte abgelegt werden. Das Typzeichen legt fest, wie die Binärdaten interpretiert werden. *count* gibt in der Regel an, wie viele Elemente des angegebenen Typs aus den Daten entnommen werden. Falls vorhanden, ist *count* eine nicht-negative dezimale Ganzzahl oder „**\***“; Letzteres bedeutet normalerweise, dass alle verbleibenden Elemente der Daten verwendet werden. Reichen die Bytes hinter der aktuellen Cursorposition nicht für den aktuellen Feldspezifizierer aus, bleibt die zugehörige Variable unverändert, und **binary scan** kehrt sofort mit der Anzahl der bereits gesetzten Variablen zurück. Gibt es nicht genug Argumente für alle Felder der Formatzeichenkette, die Argumente verbrauchen, wird ein Fehler erzeugt. Mit dem Flag-Zeichen „u“ können Sie bewirken, dass einige Typen als vorzeichenlose Werte gelesen werden. Das Flag wird für alle Feldtypen akzeptiert, bei Feldern, die keine Ganzzahlen sind, aber ignoriert.

Ein ähnliches Beispiel wie bei **binary format** soll den Zusammenhang zwischen Feldspezifizierern und Argumenten beim Unterbefehl binary scan erläutern:

```
binary scan $bytes s3s first second
```

Dieser Befehl weist (sofern die Binärzeichenkette in der Variablen *bytes* lang genug ist) der Variablen *first* eine Liste aus drei Ganzzahlen und der Variablen *second* einen einzelnen Wert zu. Enthält *bytes* weniger als 8 Bytes (d. h. vier 2-Byte-Ganzzahlen), wird *second* nichts zugewiesen. Enthält *bytes* weniger als 6 Bytes (d. h. drei 2-Byte-Ganzzahlen), wird auch *first* nichts zugewiesen. Daher gibt

```
puts [binary scan abcdefg s3s first second]
puts $first
puts $second
```

Folgendes aus (vorausgesetzt, keine der beiden Variablen war vorher gesetzt):

```
1
25185 25699 26213
can't read "second": no such variable
```

Es ist *wichtig* zu beachten, dass die Typen **c**, **s** und **S** (sowie **i** und **I** auf 64-Bit-Systemen) in Werte der Datengröße long eingelesen werden. Dabei werden Werte, deren höchstes Bit gesetzt ist (0x80 bei chars, 0x8000 bei shorts, 0x80000000 bei ints), vorzeichenerweitert. Daher geschieht Folgendes:

```
set signShort [binary format s1 0x8000]
binary scan $signShort s1 val; # val == 0xFFFF8000
```

Wenn Sie vorzeichenlose Werte benötigen, können Sie nach dem Feldtyp das Flag-Zeichen „u“ angeben. Um zum Beispiel einen vorzeichenlosen short-Wert zu lesen:

```
set signShort [binary format s1 0x8000]
binary scan $signShort su1 val; # val == 0x00008000
```

Jedes Paar aus Typ und Anzahl bewegt einen gedachten Cursor durch die Binärdaten und liest Bytes ab der aktuellen Position. Anfangs steht der Cursor auf Position 0 am Anfang der Daten. Der Typ kann eines der folgenden Zeichen sein:

**a**
: Die Daten sind eine Byte-Zeichenkette der Länge *count*. Ist *count* „**\***“, werden alle verbleibenden Bytes von *string* in die Variable gelesen. Fehlt *count*, wird ein Byte gelesen. Alle gelesenen Bytes werden als Zeichen im Bereich \\u0000-\\u00ff interpretiert. Ist die Zeichenkette keine Binärzeichenkette und nicht in ISO 8859-1 kodiert, wird daher der Befehl [encoding convertfrom][encoding] benötigt. Zum Beispiel gibt

    ```
    binary scan abcde\000fghi a6a10 var1 var2
    ```

    **1** zurück, wobei eine Zeichenkette äquivalent zu **abcde\\000** in *var1* gespeichert wird und *var2* unverändert bleibt, und

    ```
    binary scan \342\202\254 a* var1
    set var2 [encoding convertfrom utf-8 $var1]
    ```

    speichert ein Euro-Währungszeichen in *var2*.

**A**
: Diese Form entspricht **a**, außer dass nachgestellte Leerzeichen und Null-Bytes aus dem gelesenen Wert entfernt werden, bevor er in der Variablen gespeichert wird. Zum Beispiel gibt

    ```
    binary scan "abc efghi  \000" A* var1
    ```

    **1** zurück, wobei **abc efghi** in *var1* gespeichert wird.

**b**
: Die Daten werden in eine Zeichenkette aus *count* Binärziffern umgewandelt, und zwar in der Reihenfolge vom niederwertigen zum höherwertigen Bit, dargestellt als Folge der Zeichen „1“ und „0“. Die Datenbytes werden vom ersten bis zum letzten gelesen, wobei die Bits innerhalb jedes Bytes vom niederwertigen zum höherwertigen entnommen werden. Überzählige Bits im letzten Byte werden ignoriert. Ist *count* „**\***“, werden alle verbleibenden Bits von *string* gelesen. Fehlt *count*, wird ein Bit gelesen. Zum Beispiel gibt

    ```
    binary scan \x07\x87\x05 b5b* var1 var2
    ```

    **2** zurück, wobei **11100** in *var1* und **1110000110100000** in *var2* gespeichert wird.

**B**
: Diese Form entspricht **b**, außer dass die Bits innerhalb jedes Bytes vom höherwertigen zum niederwertigen entnommen werden. Zum Beispiel gibt

    ```
    binary scan \x70\x87\x05 B5B* var1 var2
    ```

    **2** zurück, wobei **01110** in *var1* und **1000011100000101** in *var2* gespeichert wird.

**C**
: Diese Form ähnelt **A**, außer dass sie die Daten vom Anfang an liest und beim ersten Null-Byte endet (Semantik von C-Zeichenketten). Zum Beispiel gibt

    ```
    binary scan "abc\000efghi" C* var1
    ```

    **1** zurück, wobei **abc** in *var1* gespeichert wird.

**H**
: Die Daten werden in eine Zeichenkette aus *count* hexadezimalen Ziffern umgewandelt, und zwar vom höherwertigen zum niederwertigen Halbbyte, dargestellt als Folge von Zeichen aus der Menge „0123456789abcdef“. Die Datenbytes werden vom ersten bis zum letzten gelesen, wobei die Hex-Ziffern innerhalb jedes Bytes vom höherwertigen zum niederwertigen entnommen werden. Überzählige Bits im letzten Byte werden ignoriert. Ist *count* „**\***“, werden alle verbleibenden Hex-Ziffern von *string* gelesen. Fehlt *count*, wird eine Hex-Ziffer gelesen. Zum Beispiel gibt

    ```
    binary scan \x07\xC6\x05\x1F\x34 H3H* var1 var2
    ```

    **2** zurück, wobei **07c** in *var1* und **051f34** in *var2* gespeichert wird.

**h**
: Diese Form entspricht **H**, außer dass die Ziffern innerhalb jedes Bytes in umgekehrter Reihenfolge (vom niederwertigen zum höherwertigen Halbbyte) entnommen werden. Zum Beispiel gibt

    ```
    binary scan \x07\x86\x05\x12\x34 h3h* var1 var2
    ```

    **2** zurück, wobei **706** in *var1* und **502143** in *var2* gespeichert wird.

    Beachten Sie, dass Code, der die hexadezimalen Ziffern mehrerer Bytes der Reihe nach auslesen will, in den meisten Fällen das Format **H** verwenden sollte.

**c**
: Die Daten werden in *count* vorzeichenbehaftete 8-Bit-Ganzzahlen umgewandelt und als Liste in der zugehörigen Variablen gespeichert, oder als vorzeichenlose Ganzzahlen, wenn unmittelbar nach dem **c** ein **u** steht. Ist *count* „**\***“, werden alle verbleibenden Bytes von *string* gelesen. Fehlt *count*, wird eine 8-Bit-Ganzzahl gelesen. Zum Beispiel gibt

    ```
    binary scan \x07\x86\x05 c2c* var1 var2
    ```

    **2** zurück, wobei **7 -122** in *var1* und **5** in *var2* gespeichert wird. Beachten Sie, dass die zurückgegebenen Ganzzahlen vorzeichenbehaftet sind, sofern nicht **cu** anstelle von **c** verwendet wird.

**s**
: Die Daten werden als *count* vorzeichenbehaftete 16-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge interpretiert, oder als vorzeichenlose, wenn unmittelbar nach dem **s** ein **u** steht. Die Ganzzahlen werden als Liste in der zugehörigen Variablen gespeichert. Ist *count* „**\***“, werden alle verbleibenden Bytes von *string* gelesen. Fehlt *count*, wird eine 16-Bit-Ganzzahl gelesen. Zum Beispiel gibt

    ```
    binary scan \x05\x00\x07\x00\xF0\xFF s2s* var1 var2
    ```

    **2** zurück, wobei **5 7** in *var1* und **-16** in *var2* gespeichert wird. Beachten Sie, dass die zurückgegebenen Ganzzahlen vorzeichenbehaftet sind, sofern nicht **su** anstelle von **s** verwendet wird.

**S**
: Diese Form entspricht **s**, außer dass die Daten als *count* 16-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge interpretiert werden. Zum Beispiel gibt

    ```
    binary scan \x00\x05\x00\x07\xFF\xF0 S2S* var1 var2
    ```

    **2** zurück, wobei **5 7** in *var1* und **-16** in *var2* gespeichert wird.

**t**
: Die Daten werden als *count* vorzeichenbehaftete 16-Bit-Ganzzahlen in der nativen Byte-Reihenfolge des Rechners interpretiert, auf dem das Tcl-Skript läuft, oder als vorzeichenlose, wenn unmittelbar nach dem **t** ein **u** steht. Ansonsten entspricht diese Form **s** und **S**. Welche Byte-Reihenfolge der Rechner nativ verwendet, entnehmen Sie dem Element **byteOrder** des Arrays [tcl\_platform][tclvars].

**i**
: Die Daten werden als *count* vorzeichenbehaftete 32-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge interpretiert, oder als vorzeichenlose, wenn unmittelbar nach dem **i** ein **u** steht. Die Ganzzahlen werden als Liste in der zugehörigen Variablen gespeichert. Ist *count* „**\***“, werden alle verbleibenden Bytes von *string* gelesen. Fehlt *count*, wird eine 32-Bit-Ganzzahl gelesen. Zum Beispiel gibt

    ```
    set str \x05\x00\x00\x00\x07\x00\x00\x00\xF0\xFF\xFF\xFF
    binary scan $str i2i* var1 var2
    ```

    **2** zurück, wobei **5 7** in *var1* und **-16** in *var2* gespeichert wird. Beachten Sie, dass die zurückgegebenen Ganzzahlen vorzeichenbehaftet sind, sofern nicht **iu** anstelle von **i** verwendet wird.

**I**
: Diese Form entspricht **i**, außer dass die Daten als *count* vorzeichenbehaftete 32-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge interpretiert werden, oder als vorzeichenlose, wenn unmittelbar nach dem **I** ein **u** steht. Zum Beispiel gibt

    ```
    set str \x00\x00\x00\x05\x00\x00\x00\x07\xFF\xFF\xFF\xF0
    binary scan $str I2I* var1 var2
    ```

    **2** zurück, wobei **5 7** in *var1* und **-16** in *var2* gespeichert wird.

**n**
: Die Daten werden als *count* vorzeichenbehaftete 32-Bit-Ganzzahlen in der nativen Byte-Reihenfolge des Rechners interpretiert, auf dem das Tcl-Skript läuft, oder als vorzeichenlose, wenn unmittelbar nach dem **n** ein **u** steht. Ansonsten entspricht diese Form **i** und **I**. Welche Byte-Reihenfolge der Rechner nativ verwendet, entnehmen Sie dem Element **byteOrder** des Arrays [tcl\_platform][tclvars].

**w**
: Die Daten werden als *count* vorzeichenbehaftete 64-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge interpretiert, oder als vorzeichenlose, wenn unmittelbar nach dem **w** ein **u** steht. Die Ganzzahlen werden als Liste in der zugehörigen Variablen gespeichert. Ist *count* „**\***“, werden alle verbleibenden Bytes von *string* gelesen. Fehlt *count*, wird eine 64-Bit-Ganzzahl gelesen. Zum Beispiel gibt

    ```
    set str \x05\x00\x00\x00\x07\x00\x00\x00\xF0\xFF\xFF\xFF
    binary scan $str wi* var1 var2
    ```

    **2** zurück, wobei **30064771077** in *var1* und **-16** in *var2* gespeichert wird.

**W**
: Diese Form entspricht **w**, außer dass die Daten als *count* vorzeichenbehaftete 64-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge interpretiert werden, oder als vorzeichenlose, wenn unmittelbar nach dem **W** ein **u** steht. Zum Beispiel gibt

    ```
    set str \x00\x00\x00\x05\x00\x00\x00\x07\xFF\xFF\xFF\xF0
    binary scan $str WI* var1 var2
    ```

    **2** zurück, wobei **21474836487** in *var1* und **-16** in *var2* gespeichert wird.

**m**
: Die Daten werden als *count* vorzeichenbehaftete 64-Bit-Ganzzahlen in der nativen Byte-Reihenfolge des Rechners interpretiert, auf dem das Tcl-Skript läuft, oder als vorzeichenlose, wenn unmittelbar nach dem **m** ein **u** steht. Ansonsten entspricht diese Form **w** und **W**. Welche Byte-Reihenfolge der Rechner nativ verwendet, entnehmen Sie dem Element **byteOrder** des Arrays [tcl\_platform][tclvars].

**f**
: Die Daten werden als *count* Gleitkommazahlen einfacher Genauigkeit in der nativen Darstellung des Rechners interpretiert. Die Gleitkommazahlen werden als Liste in der zugehörigen Variablen gespeichert. Ist *count* „**\***“, werden alle verbleibenden Bytes von *string* gelesen. Fehlt *count*, wird eine Gleitkommazahl einfacher Genauigkeit gelesen. Die Größe einer Gleitkommazahl kann je nach Architektur unterschiedlich sein, sodass auch die Anzahl der gelesenen Bytes variieren kann. Stellen die Daten keine gültige Gleitkommazahl dar, ist der resultierende Wert undefiniert und vom Compiler abhängig. Auf einem MS-Windows-System mit x86/x64-Prozessor gibt zum Beispiel

    ```
    binary scan \xCD\xCC\xCC\x3F f var1
    ```

    **1** zurück, wobei **1.6000000238418579** in *var1* gespeichert wird.

**r**
: Diese Form entspricht **f**, außer dass die Daten als *count* Gleitkommazahlen einfacher Genauigkeit in Little-Endian-Reihenfolge interpretiert werden. Diese Umwandlung ist nicht auf die Minderheit der Systeme portierbar, die keine IEEE-Gleitkommadarstellung verwenden.

**R**
: Diese Form entspricht **f**, außer dass die Daten als *count* Gleitkommazahlen einfacher Genauigkeit in Big-Endian-Reihenfolge interpretiert werden. Diese Umwandlung ist nicht auf die Minderheit der Systeme portierbar, die keine IEEE-Gleitkommadarstellung verwenden.

**d**
: Diese Form entspricht **f**, außer dass die Daten als *count* Gleitkommazahlen doppelter Genauigkeit in der nativen Darstellung des Rechners interpretiert werden. Auf einem Windows-System mit Intel-Pentium-Prozessor gibt zum Beispiel

    ```
    binary scan \x9A\x99\x99\x99\x99\x99\xF9\x3F d var1
    ```

    **1** zurück, wobei **1.6000000000000001** in *var1* gespeichert wird.

**q**
: Diese Form entspricht **d**, außer dass die Daten als *count* Gleitkommazahlen doppelter Genauigkeit in Little-Endian-Reihenfolge interpretiert werden. Diese Umwandlung ist nicht auf die Minderheit der Systeme portierbar, die keine IEEE-Gleitkommadarstellung verwenden.

**Q**
: Diese Form entspricht **d**, außer dass die Daten als *count* Gleitkommazahlen doppelter Genauigkeit in Big-Endian-Reihenfolge interpretiert werden. Diese Umwandlung ist nicht auf die Minderheit der Systeme portierbar, die keine IEEE-Gleitkommadarstellung verwenden.

**x**
: Bewegt den Cursor in *string* um *count* Bytes vorwärts. Ist *count* „**\***“ oder größer als die Anzahl der Bytes hinter der aktuellen Cursorposition, wird der Cursor hinter das letzte Byte von *string* gesetzt. Fehlt *count*, wird der Cursor um ein Byte vorwärtsbewegt. Beachten Sie, dass dieser Typ kein Argument verbraucht. Zum Beispiel gibt

    ```
    binary scan \x01\x02\x03\x04 x2H* var1
    ```

    **1** zurück, wobei **0304** in *var1* gespeichert wird.

**X**
: Bewegt den Cursor in *string* um *count* Bytes zurück. Ist *count* „**\***“ oder größer als die aktuelle Cursorposition, wird der Cursor auf Position 0 gesetzt, sodass das nächste gelesene Byte das erste Byte von *string* ist. Fehlt *count*, wird der Cursor um ein Byte zurückbewegt. Beachten Sie, dass dieser Typ kein Argument verbraucht. Zum Beispiel gibt

    ```
    binary scan \x01\x02\x03\x04 c2XH* var1 var2
    ```

    **2** zurück, wobei **1 2** in *var1* und **020304** in *var2* gespeichert wird.

**@**
: Bewegt den Cursor an die durch *count* angegebene absolute Position in der Datenzeichenkette. Beachten Sie, dass Position 0 das erste Byte von *string* bezeichnet. Bezeichnet *count* eine Position hinter dem Ende von *string*, wird der Cursor hinter das letzte Byte gesetzt. Fehlt *count*, wird ein Fehler erzeugt. Zum Beispiel gibt

    ```
    binary scan \x01\x02\x03\x04 c2@1H* var1 var2
    ```

    **2** zurück, wobei **1 2** in *var1* und **020304** in *var2* gespeichert wird.


# Portabilitätsfragen

Die Umwandlungen **r**, **R**, **q** und **Q** funktionieren nur dann zuverlässig für die Übertragung von Daten zwischen Rechnern, wenn alle beteiligten Rechner die IEEE-Gleitkommadarstellung verwenden. Das ist sehr verbreitet, aber nicht universell. Um Gleitkommazahlen portierbar zwischen allen Architekturen zu übertragen, verwenden Sie stattdessen ihre Textdarstellung (wie sie [format] erzeugt).

# Beispiele

Diese Prozedur schreibt eine Tcl-Zeichenkette als UTF-8-Daten, denen ein Längenwort vorangestellt ist, auf einen binär kodierten Kanal:

```
proc writeString {channel string} {
    set data [encoding convertto utf-8 $string]
    puts -nonewline [binary format Ia* \
            [string length $data] $data]
}
```

Diese Prozedur liest eine Zeichenkette von einem Kanal, die mit der zuvor gezeigten Prozedur *writeString* geschrieben wurde:

```
proc readString {channel} {
    if {![binary scan [read $channel 4] I length]} {
        error "missing length"
    }
    set data [read $channel $length]
    return [encoding convertfrom utf-8 $data]
}
```

Dieses Beispiel wandelt den Inhalt einer Datei (deren Name in der Variablen *filename* steht) in base64 um und gibt ihn aus:

```
set f [open $filename rb]
set data [read $f]
close $f
puts [binary encode base64 -maxlen 64 $data]
```


[encoding]: encoding.md
[format]: format.md
[string]: string.md
[tclvars]: tclvars.md
