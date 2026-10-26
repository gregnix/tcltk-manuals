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

Dieser Befehl stellt Hilfsmittel zur Verarbeitung binärer Daten bereit. Der Unterbefehl **binary format** erzeugt aus normalen Tcl-Werten eine Binärzeichenkette. Gegeben beispielsweise die Werte 16 und 22, kann er auf einer 32-Bit-Architektur eine 8-Byte-Binärzeichenkette aus zwei 4-Byte-Ganzzahlen erzeugen — je eine für jede Zahl. Der Unterbefehl **binary scan** macht das Gegenteil: Er extrahiert Daten aus einer Binärzeichenkette und gibt sie als gewöhnliche Tcl-Zeichenkettenwerte zurück. Die Unterbefehle **binary encode** und **binary decode** wandeln binäre Daten in Zeichenkettenkodierungen um bzw. umgekehrt, z. B. base64 (wie in MIME-Nachrichten).

Andere Operationen auf binären Daten — etwa eine Teilfolge bilden, die Länge ermitteln oder die Daten mit einer bestimmten Kodierung als Zeichenkette interpretieren — erledigen andere Tcl-Befehle (in den genannten Fällen [string range][string], [string length][string] und [encoding convertfrom][encoding]). Eine Binärzeichenkette in Tcl ist schlicht eine Zeichenkette, deren Zeichen alle im Bereich \u0000-\u00FF liegen.

# Kodierung und Dekodierung

Zum Kodieren binärer Daten als lesbare Zeichenkette werden die Ausgangsdaten zusammen mit dem Namen der zu verwendenden Kodierung und gewünschten kodierungsspezifischen Optionen an **binary encode** übergeben. Kodierte Daten lassen sich mit **binary decode** wieder in binäre Form zurückwandeln. **binary encode** löst einen Fehler aus, wenn das Argument *data* keine Binärdaten sind. Folgende Formate und Optionen werden unterstützt.

[base64]{.cmd}
: Die Binärkodierung **base64** wird häufig in E-Mail-Nachrichten und XML-Dokumenten verwendet und nutzt vor allem Groß- und Kleinbuchstaben sowie Ziffern. Sie kann beliebig umbrochen werden, ohne Information zu verlieren.

    Beim Kodieren werden folgende Optionen unterstützt:

    [-maxlen]{.lit} [length]{.arg}
    : Die Ausgabe soll in Zeilen von höchstens *length* Zeichen aufgeteilt werden. Standardmäßig erfolgt kein Zeilenumbruch.

    [-wrapchar]{.lit} [character]{.arg}
    : Gibt an, welches Zeichen beim Umbrechen wegen **-maxlen** die Zeilen trennt. Standard ist das Zeilenumbruchzeichen „\n“.


    Beim Dekodieren werden folgende Optionen unterstützt:

    [-strict]{.lit}
    : Der Dekodierer soll einen Fehler auslösen, wenn Zeichen angetroffen werden, die nicht strikt Teil der Kodierung sind. Andernfalls werden sie ignoriert. RFC 2045 verlangt nicht-strikte base64-Dekodierer.


**hex**
: Die Binärkodierung **hex** wandelt jedes Byte in ein Paar hexadezimaler Ziffern um, die den Byte-Wert als hexadezimale Ganzzahl darstellen. Beim Kodieren werden Kleinbuchstaben verwendet. Beim Dekodieren werden Groß- und Kleinbuchstaben akzeptiert.

    Beim Kodieren werden keine Optionen unterstützt. Beim Dekodieren:

    [-strict]{.lit}
    : Der Dekodierer soll einen Fehler auslösen, wenn Leerzeichen angetroffen werden. Andernfalls werden sie ignoriert.


**uuencode**
: Die Binärkodierung **uuencode** war früher beim Datentransfer zwischen Unix-Systemen und in USENET verbreitet, ist heute seltener und wurde weitgehend von **base64** abgelöst.

    Beim Kodieren werden folgende Optionen unterstützt (Änderungen können Dateien erzeugen, die andere Dekodierer nicht verarbeiten):

    [-maxlen]{.lit} [length]{.arg}
    : Maximale Zeichenanzahl pro kodierte Zeile. Gültiger Bereich: 5 bis 85. Außerhalb dieses Bereichs ist das Format nicht darstellbar. Standard: 61.

    [-wrapchar]{.lit} [character]{.arg}
    : Zeichen, die das Ende jeder kodierten Zeile markieren. Zulässig: eine Folge von null oder mehr Zeichen aus { \\x09 (TAB), \\x0B (VT), \\x0C (FF), \\x0D (CR) } gefolgt von null oder einem Zeilenumbruch \\x0A (LF). Andere Werte werden abgelehnt, weil die kodierte Ausgabe nicht dekodierbar wäre. Standard: ein einzelner Zeilenumbruch.


    Beim Dekodieren:

    [-strict]{.lit}
    : Der Dekodierer soll einen Fehler auslösen, wenn etwas außerhalb des Standardformats angetroffen wird. Ohne diese Option toleriert er einige Abweichungen, vor allem um Zeilenumbrüche zwischen Kodierer und Dekodierer zu verzeihen.


    Weder Kodierer noch Dekodierer verarbeiten Kopf- und Fußzeile des uuencode-Formats.


# Binärformat

**binary format** erzeugt eine Binärzeichenkette, deren Layout durch *formatString* festgelegt ist und deren Inhalt aus den weiteren Argumenten stammt. Rückgabe: die erzeugte Binärzeichenkette.

*formatString* besteht aus einer Folge von null oder mehr Feldspezifizierern, getrennt durch null oder mehr Leerzeichen. Jeder Feldspezifizierer ist ein Typzeichen, optional gefolgt von einem Flag-Zeichen und einer optionalen numerischen *count*. Die meisten Feldspezifizierer verbrauchen ein Argument für den zu formatierenden Wert. Das Typzeichen legt die Formatierung fest. *count* gibt in der Regel an, wie viele Elemente des Typs aus dem Wert übernommen werden. Ist *count* gesetzt, ist es eine nicht-negative Dezimalzahl oder „**\***“; letzteres bedeutet normalerweise, dass alle Elemente des Werts verwendet werden. Stimmt die Argumentanzahl nicht mit der Zahl der argumentverbrauchenden Felder in der Formatzeichenkette überein, entsteht ein Fehler. Das Flag-Zeichen wird bei **binary format** ignoriert.

Ein kleines Beispiel verdeutlicht den Zusammenhang zwischen Feldspezifizierern und Argumenten:

```
binary format d3d {1.0 2.0 3.0 4.0} 0.1
```

Das erste Argument ist eine Liste mit vier Zahlen; wegen *count* 3 beim zugehörigen Feldspezifizierer werden nur die ersten drei verwendet. Das zweite Argument gehört zum zweiten Feldspezifizierer. Die resultierende Binärzeichenkette enthält die vier Zahlen 1.0, 2.0, 3.0 und 0.1.

Jedes Paar Typ-*count* bewegt einen imaginären Cursor durch die Binärdaten, speichert Bytes an der aktuellen Position und setzt den Cursor unmittelbar hinter das zuletzt gespeicherte Byte. Anfangs steht der Cursor bei Position 0. Der Typ kann eines der folgenden Zeichen sein:

**a**
: Speichert eine Byte-Zeichenkette der Länge *count* in der Ausgabezeichenkette. Jedes Zeichen wird modulo 256 genommen (nur das niedrige Byte; das hohe Byte entfällt). Für Zeichenketten, die nicht vollständig mit \u0000-\u00ff darstellbar sind, sollte vorher [encoding convertto][encoding] die externe Darstellung erzeugen, wenn diese Kürzung unerwünscht ist (d. h. wenn die Zeichen nicht zu ISO 8859-1 gehören). Hat *arg* weniger als *count* Bytes, wird mit Null-Bytes aufgefüllt. Ist *arg* länger, werden überzählige Zeichen ignoriert. Bei *count* „**\***“ werden alle Bytes von *arg* formatiert. Fehlt *count*, wird ein Zeichen formatiert. Beispiel:

    ```
    binary format a7a*a alpha bravo charlie
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    alpha\000\000bravoc
    ```

    der Befehl:

    ```
    binary format a* [encoding convertto utf-8 \u20ac]
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \342\202\254
    ```

    (UTF-8-Bytefolge für das Euro-Zeichen), und:

    ```
    binary format a* [encoding convertto iso8859-15 \u20ac]
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \244
    ```

    (ISO 8859-15-Bytefolge für das Euro-Zeichen). Im Gegensatz dazu:

    ```
    binary format a* \u20ac
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \254
    ```

    (d. h. **\\xAC**) durch Abschneiden der hohen Bits — vermutlich nicht gewünscht.

**A**
: Wie **a**, aber Auffüllung mit Leerzeichen statt Nullen. Beispiel:

    ```
    binary format A6A*A alpha bravo charlie
    ```

    liefert

    ```
    alpha bravoc
    ```

**b**
: Speichert eine Folge von *count* Binärziffern in niedrig-nach-hoch-Reihenfolge innerhalb jedes Bytes. *Arg* muss **1** und **0** enthalten. Die Bytes werden in Reihenfolge erster bis letzter ausgegeben, die Bits niedrig-nach-hoch innerhalb jedes Bytes. Hat *arg* weniger als *count* Ziffern, werden die restlichen Bits mit Nullen aufgefüllt. Mehr Ziffern als *count* werden ignoriert. Bei *count* „**\***“ werden alle Ziffern von *arg* formatiert. Fehlt *count*, eine Ziffer. Endet die Bitanzahl nicht an einer Byte-Grenze, sind die restlichen Bits des letzten Bytes Null. Beispiel:

    ```
    binary format b5b* 11100 111000011010
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \x07\x87\x05
    ```

**B**
: Wie **b**, aber Bits in hoch-nach-niedrig-Reihenfolge innerhalb jedes Bytes. Beispiel:

    ```
    binary format B5B* 11100 111000011010
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \xE0\xE1\xA0
    ```

**H**
: Speichert *count* hexadezimale Ziffern in hoch-nach-niedrig-Reihenfolge innerhalb jedes Bytes. *Arg* muss Zeichen aus „0123456789abcdefABCDEF“ sein. Bytes erster bis letzter, Ziffern hoch-nach-niedrig pro Byte. Weniger als *count* Ziffern: Rest mit Nullen. Mehr Ziffern: ignoriert. *count* „**\***“: alle Ziffern von *arg*. Fehlt *count*: eine Ziffer. Endet die Ziffernanzahl nicht an einer Byte-Grenze, sind die restlichen Bits des letzten Bytes Null. Beispiel:

    ```
    binary format H3H*H2 ab DEF 987
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \xAB\x00\xDE\xF0\x98
    ```

**h**
: Wie **H**, aber Ziffern niedrig-nach-hoch innerhalb jedes Bytes. Selten benötigt. Beispiel:

    ```
    binary format h3h*h2 AB def 987
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \xBA\x00\xED\x0F\x89
    ```

**c**
: Speichert einen oder mehrere 8-Bit-Ganzzahlwerte. Ohne *count* muss *arg* eine Ganzzahl sein. Mit *count* eine Liste mit mindestens so vielen Ganzzahlen. Die unteren 8 Bits jeder Ganzzahl werden als ein Byte an der Cursorposition gespeichert. *count* „**\***“: alle Ganzzahlen der Liste. Mehr Listenelemente als *count*: überzählige ignoriert. Beispiel:

    ```
    binary format c3cc* {3 -3 128 1} 260 {2 5}
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \x03\xFD\x80\x04\x02\x05
    ```

    während:

    ```
    binary format c {2 5}
    ```

    einen Fehler erzeugt.

**s**
: Wie **c**, speichert aber einen oder mehrere 16-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge. Die unteren 16 Bits jeder Ganzzahl als Zwei-Byte-Wert, niederwertiges Byte zuerst. Beispiel:

    ```
    binary format s3 {3 -3 258 1}
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \x03\x00\xFD\xFF\x02\x01
    ```

**S**
: Wie **s**, aber 16-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge. Beispiel:

    ```
    binary format S3 {3 -3 258 1}
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \x00\x03\xFF\xFD\x01\x02
    ```

**t**
: (mnemonisch *tiny*) Wie **s** und **S**, speichert 16-Bit-Ganzzahlen in der nativen Byte-Reihenfolge des Rechners, auf dem das Tcl-Skript läuft. Die native Byte-Reihenfolge steht im Element **byteOrder** des Arrays [tcl\_platform][tclvars].

**i**
: Wie **c**, speichert aber einen oder mehrere 32-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge. Die unteren 32 Bits jeder Ganzzahl als Vier-Byte-Wert, niederwertiges Byte zuerst. Beispiel:

    ```
    binary format i3 {3 -3 65536 1}
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \x03\x00\x00\x00\xFD\xFF\xFF\xFF\x00\x00\x01\x00
    ```

**I**
: Wie **i**, speichert aber einen oder mehrere 32-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge. Beispiel:

    ```
    binary format I3 {3 -3 65536 1}
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \x00\x00\x00\x03\xFF\xFF\xFF\xFD\x00\x01\x00\x00
    ```

**n**
: (mnemonisch *number* oder *normal*) Wie **i** und **I**, speichert 32-Bit-Ganzzahlen in der nativen Byte-Reihenfolge des Rechners. Siehe **byteOrder** in [tcl\_platform][tclvars].

**w**
: Wie **c**, speichert aber einen oder mehrere 64-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge. Die unteren 64 Bits jeder Ganzzahl als Acht-Byte-Wert, niederwertiges Byte zuerst. Beispiel:

    ```
    binary format w 7810179016327718216
    ```

    liefert die Binärzeichenkette **HelloTcl**.

**W**
: Wie **w**, speichert aber einen oder mehrere 64-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge. Beispiel:

    ```
    binary format Wc 4785469626960341345 110
    ```

    liefert die Binärzeichenkette **BigEndian**

**m**
: (mnemonisch Spiegel von **w**) Wie **w** und **W**, speichert 64-Bit-Ganzzahlen in der nativen Byte-Reihenfolge. Siehe **byteOrder** in [tcl\_platform][tclvars].

**f**
: Wie **c**, speichert aber einen oder mehrere Gleitkommazahlen einfacher Genauigkeit in der nativen Darstellung des Rechners. Diese Darstellung ist architekturabhängig und sollte nicht zum Netzwerktransport von Gleitkommazahlen dienen. Die Byteanzahl kann variieren. Bei Überlauf wird FLT\_MAX des Systems verwendet. Tcl arbeitet intern mit doppelter Genauigkeit; beim Umwandeln in einfache Genauigkeit kann Genauigkeit verloren gehen. Beispiel auf Windows mit Intel Pentium:

    ```
    binary format f2 {1.6 3.4}
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \xCD\xCC\xCC\x3F\x9A\x99\x59\x40
    ```

**r**
: (mnemonisch *real*) Wie **f**, speichert Gleitkommazahlen einfacher Genauigkeit in Little-Endian-Reihenfolge. Sinnvolle Ausgabe nur auf Rechnern mit IEEE-Gleitkommadarstellung (sehr verbreitet, nicht universell).

**R**
: Wie **r**, aber Big-Endian-Reihenfolge.

**d**
: Wie **f**, speichert aber einen oder mehrere Gleitkommazahlen doppelter Genauigkeit in der nativen Darstellung. Beispiel auf Windows mit Intel Pentium:

    ```
    binary format d1 {1.6}
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    \x9A\x99\x99\x99\x99\x99\xF9\x3F
    ```

**q**
: (mnemonisch Spiegel von **d**) Wie **d**, speichert Gleitkommazahlen doppelter Genauigkeit in Little-Endian-Reihenfolge. Sinnvolle Ausgabe nur bei IEEE-Gleitkommadarstellung.

**Q**
: Wie **q**, aber Big-Endian-Reihenfolge.

**x**
: Speichert *count* Null-Bytes. Fehlt *count*, ein Null-Byte. Bei *count* „**\***“: Fehler. Verbraucht kein Argument. Beispiel:

    ```
    binary format a3xa3x2a3 abc def ghi
    ```

    liefert eine Binärzeichenkette äquivalent zu:

    ```
    abc\000def\000\000ghi
    ```

**X**
: Setzt den Cursor *count* Bytes in der Ausgabezeichenkette zurück. Bei *count* „**\***“ oder größer als die aktuelle Cursorposition: Position 0, das nächste Byte ist das erste der Ergebniszeichenkette. Fehlt *count*, ein Byte zurück. Verbraucht kein Argument. Beispiel:

    ```
    binary format a3X*a3X2a3 abc def ghi
    ```

    liefert **dghi**.

**@**
: Setzt den Cursor auf die absolute Position *count* in der Ausgabezeichenkette. Position 0 ist das erste Byte. Liegt *count* hinter dem bisher letzten gespeicherten Byte, werden Zwischenpositionen mit Null-Bytes gefüllt. Bei *count* „**\***“: Cursor ans Ende der bisherigen Ausgabe. Fehlt *count*: Fehler. Verbraucht kein Argument. Beispiel:

    ```
    binary format a5@2a1@*a3@10a1 abcde f ghi j
    ```

    liefert

    ```
    abfdeghi\000\000j
    ```


# Binärscan

**binary scan** parst Felder aus einer Binärzeichenkette und gibt die Anzahl der durchgeführten Konvertierungen zurück. *String* liefert die einzulesenden Bytes, *formatString* legt das Parsen fest. Ist *string* keine gültige Binärdaten-Zeichenkette, entsteht ein Fehler. Jedes *varName* ist ein Variablenname; gescannte Werte werden der zugehörigen Variablen zugewiesen.

Wie bei **binary format** besteht *formatString* aus Feldspezifizierern (Typzeichen, optionales Flag, optionale *count*), getrennt durch Leerzeichen. Die meisten Feldspezifizierer verbrauchen ein Argument: die Variable für die gescannten Werte. Das Typzeichen legt die Interpretation fest. *count* gibt in der Regel an, wie viele Elemente des Typs aus den Daten genommen werden. Ist *count* gesetzt, Dezimalzahl oder „**\***“ (normalerweise alle verbleibenden Elemente). Reichen die Bytes ab der Cursorposition nicht für den aktuellen Feldspezifizierer, bleibt die Variable unverändert und **binary scan** kehrt sofort mit der Anzahl bereits gesetzter Variablen zurück. Fehlen Argumente für alle argumentverbrauchenden Felder, entsteht ein Fehler. Das Flag „u“ kann einige Typen als vorzeichenlos lesen lassen; es wird für alle Feldtypen akzeptiert, bei Nicht-Ganzzahltypen ignoriert.

Analoges Beispiel zu **binary format** für den Zusammenhang von Feldspezifizierern und Argumenten:

```
binary scan $bytes s3s first second
```

Dieser Befehl (sofern die Binärzeichenkette in *bytes* lang genug ist) weist *first* eine Liste aus drei Ganzzahlen und *second* einen einzelnen Wert zu. Enthält *bytes* weniger als 8 Bytes (vier 2-Byte-Ganzzahlen), erfolgt keine Zuweisung an *second*; bei weniger als 6 Bytes (drei 2-Byte-Ganzzahlen) keine an *first*. Daher:

```
puts [binary scan abcdefg s3s first second]
puts $first
puts $second
```

gibt aus (wenn die Variablen vorher nicht gesetzt waren):

```
1
25185 25699 26213
can't read "second": no such variable
```

**Wichtig:** **c**, **s** und **S** (sowie **i** und **I** auf 64-Bit-Systemen) werden in Werte der Größe *long* gescannt. Werte mit gesetztem Hochbit (0x80 für Zeichen, 0x8000 für shorts, 0x80000000 für ints) werden vorzeichenerweitert. Beispiel:

```
set signShort [binary format s1 0x8000]
binary scan $signShort s1 val; # val == 0xFFFF8000
```

Benötigen Sie vorzeichenlose Werte, kann das Flag-Zeichen „u“ nach dem Feldtyp stehen. Beispiel für einen vorzeichenlosen short-Wert:

```
set signShort [binary format s1 0x8000]
binary scan $signShort su1 val; # val == 0x00008000
```

Jedes Paar Typ-*count* bewegt einen imaginären Cursor und liest ab der aktuellen Position. Anfangsposition: 0. Mögliche Typzeichen:

**a**
: Die Daten sind eine Byte-Zeichenkette der Länge *count*. Bei *count* „**\***“ alle verbleibenden Bytes von *string* in die Variable. Fehlt *count*, ein Byte. Alle Bytes gelten als Zeichen \u0000-\u00ff; für andere Kodierungen ist [encoding convertfrom][encoding] nötig. Beispiel:

    ```
    binary scan abcde\000fghi a6a10 var1 var2
    ```

    gibt **1** zurück, *var1* enthält die Zeichenkette äquivalent zu **abcde\\000**, *var2* unverändert, und

    ```
    binary scan \342\202\254 a* var1
    set var2 [encoding convertfrom utf-8 $var1]
    ```

    speichert ein Euro-Zeichen in *var2*.

**A**
: Wie **a**, entfernt aber nachgestellte Leerzeichen und Nullen vor dem Speichern. Beispiel:

    ```
    binary scan "abc efghi  \000" A* var1
    ```

    gibt **1** zurück, in *var1* steht **abc efghi**.

**b**
: Die Daten werden in eine Folge von *count* Binärziffern in niedrig-nach-hoch-Reihenfolge als „1“ und „0“ umgewandelt. Bytes erster bis letzter, Bits niedrig-nach-hoch pro Byte; überzählige Bits im letzten Byte werden ignoriert. *count* „**\***“: alle verbleibenden Bits. Fehlt *count*: ein Bit. Beispiel:

    ```
    binary scan \x07\x87\x05 b5b* var1 var2
    ```

    gibt **2** zurück, *var1* **11100**, *var2* **1110000110100000**.

**B**
: Wie **b**, Bits hoch-nach-niedrig pro Byte. Beispiel:

    ```
    binary scan \x70\x87\x05 B5B* var1 var2
    ```

    gibt **2** zurück, *var1* **01110**, *var2* **1000011100000101**.

**C**
: Ähnlich **A**, scannt von Anfang an und endet beim ersten Null-Byte (C-String-Semantik). Beispiel:

    ```
    binary scan "abc\000efghi" C* var1
    ```

    gibt **1** zurück, in *var1* steht **abc**.

**H**
: Die Daten werden in *count* hexadezimale Ziffern in hoch-nach-niedrig-Reihenfolge als Zeichen aus „0123456789abcdef“ umgewandelt. Bytes erster bis letzter, Ziffern hoch-nach-niedrig; überzählige Bits im letzten Byte ignoriert. *count* „**\***“: alle verbleibenden Hex-Ziffern. Fehlt *count*: eine Ziffer. Beispiel:

    ```
    binary scan \x07\xC6\x05\x1F\x34 H3H* var1 var2
    ```

    gibt **2** zurück, *var1* **07c**, *var2* **051f34**.

**h**
: Wie **H**, Ziffern in umgekehrter (niedrig-nach-hoch) Reihenfolge pro Byte. Beispiel:

    ```
    binary scan \x07\x86\x05\x12\x34 h3h* var1 var2
    ```

    gibt **2** zurück, *var1* **706**, *var2* **502143**.

    Code, der Hex-Ziffern mehrerer Bytes in Reihenfolge parsen soll, sollte meist **H** verwenden.

**c**
: Die Daten werden in *count* vorzeichenbehaftete 8-Bit-Ganzzahlen umgewandelt und als Liste in der Variable gespeichert, oder vorzeichenlos, wenn unmittelbar nach **c** **u** steht. *count* „**\***“: alle verbleibenden Bytes. Fehlt *count*: eine 8-Bit-Ganzzahl. Beispiel:

    ```
    binary scan \x07\x86\x05 c2c* var1 var2
    ```

    gibt **2** zurück, *var1* **7 -122**, *var2* **5**. Die Ganzzahlen sind vorzeichenbehaftet, außer bei **cu** statt **c**.

**s**
: Die Daten werden als *count* vorzeichenbehaftete 16-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge interpretiert, oder vorzeichenlos bei **u** unmittelbar nach **s**. Speicherung als Liste. *count* „**\***“: alle verbleibenden Bytes. Fehlt *count*: eine 16-Bit-Ganzzahl. Beispiel:

    ```
    binary scan \x05\x00\x07\x00\xF0\xFF s2s* var1 var2
    ```

    gibt **2** zurück, *var1* **5 7**, *var2* **-16**. Vorzeichenbehaftet, außer bei **su** statt **s**.

**S**
: Wie **s**, aber *count* 16-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge. Beispiel:

    ```
    binary scan \x00\x05\x00\x07\xFF\xF0 S2S* var1 var2
    ```

    gibt **2** zurück, *var1* **5 7**, *var2* **-16**.

**t**
: Die Daten werden als *count* vorzeichenbehaftete 16-Bit-Ganzzahlen in der nativen Byte-Reihenfolge des Tcl-Rechners interpretiert, oder vorzeichenlos bei **u** nach **t**. Ansonsten wie **s** und **S**. Siehe **byteOrder** in [tcl\_platform][tclvars].

**i**
: Die Daten werden als *count* vorzeichenbehaftete 32-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge interpretiert, oder vorzeichenlos bei **u** nach **i**. Speicherung als Liste. *count* „**\***“: alle verbleibenden Bytes. Fehlt *count*: eine 32-Bit-Ganzzahl. Beispiel:

    ```
    set str \x05\x00\x00\x00\x07\x00\x00\x00\xF0\xFF\xFF\xFF
    binary scan $str i2i* var1 var2
    ```

    gibt **2** zurück, *var1* **5 7**, *var2* **-16**. Vorzeichenbehaftet, außer bei **iu** statt **i**.

**I**
: Wie **i**, aber *count* 32-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge, oder vorzeichenlos bei **u** nach **I**. Beispiel:

    ```
    set str \x00\x00\x00\x05\x00\x00\x00\x07\xFF\xFF\xFF\xF0
    binary scan $str I2I* var1 var2
    ```

    gibt **2** zurück, *var1* **5 7**, *var2* **-16**.

**n**
: Die Daten werden als *count* vorzeichenbehaftete 32-Bit-Ganzzahlen in der nativen Byte-Reihenfolge interpretiert, oder vorzeichenlos bei **u** nach **n**. Ansonsten wie **i** und **I**. Siehe **byteOrder** in [tcl\_platform][tclvars].

**w**
: Die Daten werden als *count* vorzeichenbehaftete 64-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge interpretiert, oder vorzeichenlos bei **u** nach **w**. Speicherung als Liste. *count* „**\***“: alle verbleibenden Bytes. Fehlt *count*: eine 64-Bit-Ganzzahl. Beispiel:

    ```
    set str \x05\x00\x00\x00\x07\x00\x00\x00\xF0\xFF\xFF\xFF
    binary scan $str wi* var1 var2
    ```

    gibt **2** zurück, *var1* **30064771077**, *var2* **-16**.

**W**
: Wie **w**, aber Big-Endian-Byte-Reihenfolge, oder vorzeichenlos bei **u** nach **W**. Beispiel:

    ```
    set str \x00\x00\x00\x05\x00\x00\x00\x07\xFF\xFF\xFF\xF0
    binary scan $str WI* var1 var2
    ```

    gibt **2** zurück, *var1* **21474836487**, *var2* **-16**.

**m**
: Die Daten werden als *count* vorzeichenbehaftete 64-Bit-Ganzzahlen in der nativen Byte-Reihenfolge interpretiert, oder vorzeichenlos bei **u** nach **m**. Ansonsten wie **w** und **W**. Siehe **byteOrder** in [tcl\_platform][tclvars].

**f**
: Die Daten werden als *count* Gleitkommazahlen einfacher Genauigkeit in der nativen Darstellung interpretiert und als Liste gespeichert. *count* „**\***“: alle verbleibenden Bytes. Fehlt *count*: eine Zahl einfacher Genauigkeit. Die Byteanzahl kann variieren. Ungültige Gleitkommadaten: Ergebnis undefiniert und compilerabhängig. Beispiel auf MS-Windows mit einem x86/x64-Prozessor:

    ```
    binary scan \xCD\xCC\xCC\x3F f var1
    ```

    gibt **1** zurück, in *var1* steht **1.6000000238418579**.

**r**
: Wie **f**, aber Gleitkommazahlen einfacher Genauigkeit in Little-Endian-Reihenfolge. Nicht portabel auf Systeme ohne IEEE-Gleitkomma.

**R**
: Wie **f**, aber Big-Endian-Reihenfolge. Nicht portabel ohne IEEE-Gleitkomma.

**d**
: Wie **f**, aber Gleitkommazahlen doppelter Genauigkeit in der nativen Darstellung. Beispiel auf Windows mit Intel Pentium:

    ```
    binary scan \x9A\x99\x99\x99\x99\x99\xF9\x3F d var1
    ```

    gibt **1** zurück, in *var1* steht **1.6000000000000001**.

**q**
: Wie **d**, aber doppelte Genauigkeit in Little-Endian-Reihenfolge. Nicht portabel ohne IEEE-Gleitkomma.

**Q**
: Wie **d**, aber Big-Endian-Reihenfolge. Nicht portabel ohne IEEE-Gleitkomma.

**x**
: Bewegt den Cursor *count* Bytes vorwärts in *string*. Bei *count* „**\***“ oder größer als die verbleibenden Bytes: Cursor hinter das letzte Byte. Fehlt *count*: ein Byte vor. Verbraucht kein Argument. Beispiel:

    ```
    binary scan \x01\x02\x03\x04 x2H* var1
    ```

    gibt **1** zurück, in *var1* steht **0304**.

**X**
: Setzt den Cursor *count* Bytes in *string* zurück. Bei *count* „**\***“ oder größer als die aktuelle Position: Position 0. Fehlt *count*: ein Byte zurück. Verbraucht kein Argument. Beispiel:

    ```
    binary scan \x01\x02\x03\x04 c2XH* var1 var2
    ```

    gibt **2** zurück, *var1* **1 2**, *var2* **020304**.

**@**
: Setzt den Cursor auf die absolute Position *count* in der Datenzeichenkette. Position 0 ist das erste Byte von *string*. Liegt *count* hinter dem Ende, steht der Cursor hinter dem letzten Byte. Fehlt *count*: Fehler. Beispiel:

    ```
    binary scan \x01\x02\x03\x04 c2@1H* var1 var2
    ```

    gibt **2** zurück, *var1* **1 2**, *var2* **020304**.


# Portabilitätsfragen

Die Konvertierungen **r**, **R**, **q** und **Q** funktionieren beim Datentransfer zwischen Rechnern zuverlässig nur, wenn alle IEEE-Gleitkommadarstellung verwenden — sehr verbreitet, aber nicht universell. Für portablen Gleitkommatransport zwischen allen Architekturen die Textdarstellung (wie von [format] erzeugt) verwenden.

# Beispiele

Prozedur zum Schreiben einer Tcl-Zeichenkette als UTF-8-Daten mit vorangestelltem Längenwort auf einen binär kodierten Kanal:

```
proc writeString {channel string} {
    set data [encoding convertto utf-8 $string]
    puts -nonewline [binary format Ia* \
            [string length $data] $data]
}
```

Prozedur zum Lesen einer Zeichenkette von einem Kanal, der von der obigen *writeString*-Prozedur geschrieben wurde:

```
proc readString {channel} {
    if {![binary scan [read $channel 4] I length]} {
        error "missing length"
    }
    set data [read $channel $length]
    return [encoding convertfrom utf-8 $data]
}
```

Wandelt den Inhalt einer Datei (Name in *filename*) in base64 um und gibt ihn aus:

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
