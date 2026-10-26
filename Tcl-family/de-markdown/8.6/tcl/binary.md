---
CommandName: binary
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

# NAME

binary - Felder in Binärzeichenketten einfügen und extrahieren

# ÜBERSICHT

::: {.synopsis} :::
[binary]{.cmd} [decode]{.sub} [format]{.arg} [-option value]{.optdot} [data]{.arg} 
[binary]{.cmd} [encode]{.sub} [format]{.arg} [-option value]{.optdot} [data]{.arg} 
[binary]{.cmd} [format]{.sub} [formatString]{.arg} [arg arg]{.optdot} 
[binary]{.cmd} [scan]{.sub} [string]{.arg} [formatString]{.arg} [varName varName]{.optdot} 
:::

# BESCHREIBUNG

Dieser Befehl stellt Hilfsmittel zur Manipulation binärer Daten bereit. Der Unterbefehl **binary format** erzeugt aus normalen Tcl-Werten eine Binärzeichenkette. Gegeben beispielsweise die Werte 16 und 22, könnte er auf einer 32-Bit-Architektur eine 8-Byte-Binärzeichenkette erzeugen, die aus zwei 4-Byte-Ganzzahlen besteht, je eine für jede Zahl. Der Unterbefehl **binary scan** macht das Gegenteil: Er extrahiert Daten aus einer Binärzeichenkette und gibt sie als gewöhnliche Tcl-Zeichenkettenwerte zurück.

::: {.info -version="8.6"}
Die Unterbefehle **binary encode** und **binary decode** wandeln binäre Daten in Zeichenketten-Kodierungen um oder umgekehrt, etwa base64 (wie in MIME-Nachrichten).
:::

Andere Operationen auf binären Daten — etwa eine Teilfolge bilden, die Länge ermitteln oder die Daten mit einer bestimmten Kodierung als Zeichenkette interpretieren — erledigen andere Tcl-Befehle (in den genannten Fällen **string range**, **string length** und **encoding convertfrom**). Eine Binärzeichenkette in Tcl ist schlicht eine Zeichenkette, deren Zeichen alle im Bereich \u0000-\u00FF liegen.

# BINARY ENCODE UND DECODE


::: {.info -version="8.6"}
Wenn binäre Daten als lesbare Zeichenkette kodiert werden, werden die Ausgangsdaten zusammen mit dem Namen der zu verwendenden Kodierung und gewünschten kodierungsspezifischen Optionen an den Befehl **binary encode** übergeben. Kodierte Daten lassen sich mit **binary decode** wieder in binäre Form zurückwandeln. Folgende Formate und Optionen werden unterstützt.
:::


**base64**
: Die Binärkodierung **base64** wird häufig in E-Mail-Nachrichten und XML-Dokumenten verwendet und nutzt überwiegend Groß- und Kleinbuchstaben sowie Ziffern. Sie kann beliebig umbrochen werden, ohne Information zu verlieren.

::: {.info -version="8.6"}
Beim Kodieren werden folgende Optionen unterstützt:
:::

**-maxlen** *length*
: Die Ausgabe soll in Zeilen von höchstens *length* Zeichen aufgeteilt werden. Standardmäßig erfolgt kein Zeilenumbruch.

**-wrapchar** *character*
: Gibt an, welches Zeichen beim Umbrechen wegen der Option **-maxlen** Zeilen trennen soll. Standardmäßig ist das ein Zeilenumbruch, „\n“.

    Beim Dekodieren werden folgende Optionen unterstützt:

**-strict**
: Der Dekodierer soll einen Fehler auslösen, wenn Zeichen angetroffen werden, die nicht strikt Teil der Kodierung sind. Andernfalls werden sie ignoriert. RFC 2045 verlangt nicht-strikte base64-Dekodierer.


**hex**
: Die Binärkodierung **hex** wandelt jedes Byte in ein Paar hexadezimaler Ziffern um, die den Byte-Wert als hexadezimale Ganzzahl darstellen. Beim Kodieren werden Kleinbuchstaben verwendet. Beim Dekodieren werden Groß- und Kleinbuchstaben akzeptiert.

::: {.info -version="8.6"}
Beim Kodieren werden keine Optionen unterstützt. Beim Dekodieren wird folgende Option unterstützt:
:::

**-strict**
: Der Dekodierer soll einen Fehler auslösen, wenn Leerzeichen angetroffen werden. Andernfalls werden sie ignoriert.


**uuencode**
: Die Binärkodierung **uuencode** war früher üblich für den Datentransfer zwischen Unix-Systemen und in USENET, ist heute seltener und wurde weitgehend von **base64** abgelöst.

::: {.info -version="8.6"}
Beim Kodieren werden folgende Optionen unterstützt (Änderungen können Dateien erzeugen, die andere Decoder-Implementierungen nicht verarbeiten können):
:::

**-maxlen** *length*
: Legt die maximale Zeichenanzahl pro kodierter Zeile fest. Der gültige Bereich ist 5 bis 85. Zeilenlängen außerhalb dieses Bereichs sind im Kodierungsformat nicht vorgesehen. Der Standardwert ist 61.

**-wrapchar** *character*
: Legt die Zeichen fest, die das Ende jeder kodierten Zeile markieren. Zulässig ist eine Folge von null oder mehr Zeichen aus der Menge { \\x09 (TAB), \\x0B (VT), \\x0C (FF), \\x0D (CR) } gefolgt von null oder einem Zeilenumbruch \\x0A (LF). Andere Werte werden abgelehnt, weil sie kodierten Text erzeugen würden, der nicht dekodierbar ist. Der Standardwert ist ein einzelner Zeilenumbruch.

    Beim Dekodieren wird folgende Option unterstützt:

**-strict**
: Veranlasst den Decoder, einen Fehler auszulösen, wenn etwas außerhalb des Standard-Kodierungsformats angetroffen wird. Ohne diese Option toleriert der Decoder einige Abweichungen, vor allem um Zeilenumbrüche zwischen Encoder und Decoder zu verzeihen.

    Weder Encoder noch Decoder verarbeiten Kopf- und Fußzeile des uuencode-Formats.


# BINARY FORMAT

**binary format** erzeugt eine Binärzeichenkette, deren Layout durch *formatString* festgelegt ist und deren Inhalt aus den weiteren Argumenten stammt. Rückgabe: die erzeugte Binärzeichenkette.

*formatString* besteht aus einer Folge von null oder mehr Feldspezifizierern, getrennt durch null oder mehr Leerzeichen. Jeder Feldspezifizierer ist ein einzelnes Typzeichen, optional gefolgt von einem Flag-Zeichen und optional einer numerischen *count*. Die meisten Feldspezifizierer verbrauchen ein Argument, um den zu formatierenden Wert zu erhalten. Das Typzeichen legt fest, wie der Wert formatiert wird. *count* gibt typischerweise an, wie viele Elemente des angegebenen Typs aus dem Wert genommen werden. Ist *count* vorhanden, ist es eine nicht-negative Dezimalganzzahl oder **\***, was normalerweise bedeutet, dass alle Elemente im Wert verwendet werden. Stimmt die Anzahl der Argumente nicht mit der Anzahl der Felder in der Formatzeichenkette überein, die Argumente verbrauchen, wird ein Fehler erzeugt. Das Flag-Zeichen wird bei **binary format** ignoriert.

Ein kleines Beispiel verdeutlicht den Zusammenhang zwischen Feldspezifizierern und Argumenten:

```
binary format d3d {1.0 2.0 3.0 4.0} 0.1
```

Das erste Argument ist eine Liste mit vier Zahlen; wegen *count* 3 beim zugehörigen Feldspezifizierer werden nur die ersten drei verwendet. Das zweite Argument gehört zum zweiten Feldspezifizierer. Die resultierende Binärzeichenkette enthält die vier Zahlen 1.0, 2.0, 3.0 und 0.1.

Jedes Paar Typ-*count* bewegt einen imaginären Cursor durch die Binärdaten, speichert Bytes an der aktuellen Position und setzt den Cursor unmittelbar hinter das zuletzt gespeicherte Byte. Anfangs steht der Cursor bei Position 0. Der Typ kann eines der folgenden Zeichen sein:

**a**
: Speichert eine Byte-Zeichenkette der Länge *count* in der Ausgabezeichenkette. Jedes Zeichen wird modulo 256 genommen (d. h. das niedrige Byte jedes Zeichens wird verwendet, das hohe verworfen). Sollen Zeichenketten gespeichert werden, die nicht vollständig mit Zeichen aus \u0000-\u00ff darstellbar sind, sollte zuerst **encoding convertto** verwendet werden, um die Zeichenkette in eine externe Darstellung zu bringen, wenn diese Abschneidung unerwünscht ist (d. h. wenn die Zeichen nicht zum Zeichensatz ISO 8859-1 gehören). Hat *arg* weniger als *count* Bytes, werden Null-Bytes zum Auffüllen verwendet. Ist *arg* länger als die angegebene Länge, werden überzählige Zeichen ignoriert. Ist *count* **\***, werden alle Bytes in *arg* formatiert. Fehlt *count*, wird ein Zeichen formatiert. Beispiel:

    ```
    binary format a7a*a alpha bravo charlie
    ```
    liefert eine Zeichenkette äquivalent zu **alpha\000\000bravoc**,

    ```
    binary format a* [encoding convertto utf-8 \u20ac]
    ```
    liefert eine Zeichenkette äquivalent zu **\342\202\254** (der UTF-8-Bytefolge für das Euro-Zeichen) und

    ```
    binary format a* [encoding convertto iso8859-15 \u20ac]
    ```
    liefert eine Zeichenkette äquivalent zu **\244** (der ISO-8859-15-Bytefolge für das Euro-Zeichen). Im Gegensatz dazu:

    ```
    binary format a* \u20ac
    ```
    liefert eine Zeichenkette äquivalent zu **\254** (d. h. **\xac**) durch Abschneiden der hohen Bits des Zeichens — vermutlich nicht gewünscht.

**A**
: Wie **a**, aber Leerzeichen statt Nullen zum Auffüllen. Beispiel:

    ```
    binary format A6A*A alpha bravo charlie
    ```
    liefert **alpha bravoc**.

**b**
: Speichert eine Zeichenkette aus *count* Binärziffern in niedrig-nach-hoch-Reihenfolge innerhalb jedes Bytes in der Ausgabezeichenkette. *Arg* muss eine Folge aus **1** und **0** sein. Die Bytes werden in Reihenfolge erster bis letzter ausgegeben, die Bits niedrig-nach-hoch innerhalb jedes Bytes. Hat *arg* weniger als *count* Ziffern, werden Nullen für die restlichen Bits verwendet. Hat *arg* mehr Ziffern als angegeben, werden überzählige ignoriert. Ist *count* **\***, werden alle Ziffern in *arg* formatiert. Fehlt *count*, wird eine Ziffer formatiert. Endet die Anzahl formatierter Bits nicht an einer Byte-Grenze, sind die restlichen Bits des letzten Bytes Null. Beispiel:

    ```
    binary format b5b* 11100 111000011010
    ```
    liefert eine Zeichenkette äquivalent zu **\x07\x87\x05**.

**B**
: Wie **b**, aber Bits in hoch-nach-niedrig-Reihenfolge innerhalb jedes Bytes. Beispiel:

    ```
    binary format B5B* 11100 111000011010
    ```
    liefert eine Zeichenkette äquivalent zu **\xe0\xe1\xa0**.

**H**
: Speichert eine Zeichenkette aus *count* hexadezimalen Ziffern hoch-nach-niedrig innerhalb jedes Bytes in der Ausgabezeichenkette. *Arg* muss Zeichen aus „0123456789abcdefABCDEF“ enthalten. Die Bytes werden in Reihenfolge erster bis letzter ausgegeben, die Hex-Ziffern hoch-nach-niedrig innerhalb jedes Bytes. Hat *arg* weniger als *count* Ziffern, werden Nullen für die restlichen verwendet. Hat *arg* mehr Ziffern als angegeben, werden überzählige ignoriert. Ist *count* **\***, werden alle Ziffern in *arg* formatiert. Fehlt *count*, wird eine Ziffer formatiert. Endet die Anzahl formatierter Ziffern nicht an einer Byte-Grenze, sind die restlichen Bits des letzten Bytes Null. Beispiel:

    ```
    binary format H3H*H2 ab DEF 987
    ```
    liefert eine Zeichenkette äquivalent zu **\xab\x00\xde\xf0\x98**.

**h**
: Wie **H**, aber die Ziffern werden niedrig-nach-hoch innerhalb jedes Bytes gespeichert. Selten benötigt. Beispiel:

    ```
    binary format h3h*h2 AB def 987
    ```
    liefert eine Zeichenkette äquivalent zu **\xba\x00\xed\x0f\x89**.

**c**
: Speichert einen oder mehrere 8-Bit-Ganzzahlwerte in der Ausgabezeichenkette. Ist kein *count* angegeben, muss *arg* ein Ganzzahlwert sein. Ist *count* angegeben, muss *arg* eine Liste mit mindestens so vielen Ganzzahlen sein. Die niederwertigen 8 Bits jeder Ganzzahl werden als Ein-Byte-Wert an der Cursor-Position gespeichert. Ist *count* **\***, werden alle Ganzzahlen in der Liste formatiert. Enthält die Liste mehr Elemente als *count*, werden die überzähligen ignoriert. Beispiel:

    ```
    binary format c3cc* {3 -3 128 1} 260 {2 5}
    ```
    liefert eine Zeichenkette äquivalent zu **\x03\xfd\x80\x04\x02\x05**, während

    ```
    binary format c {2 5}
    ```
    einen Fehler erzeugt.

**s**
: Wie **c**, speichert aber einen oder mehrere 16-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge in der Ausgabezeichenkette. Die niederwertigen 16 Bits jeder Ganzzahl werden als Zwei-Byte-Wert an der Cursor-Position gespeichert, das niederwertigste Byte zuerst. Beispiel:

    ```
    binary format s3 {3 -3 258 1}
    ```
    liefert eine Zeichenkette äquivalent zu **\x03\x00\xfd\xff\x02\x01**.

**S**
: Wie **s**, speichert aber einen oder mehrere 16-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge in der Ausgabezeichenkette. Beispiel:

    ```
    binary format S3 {3 -3 258 1}
    ```
    liefert eine Zeichenkette äquivalent zu **\x00\x03\xff\xfd\x01\x02**.

**t**
: Diese Form (mnemonisch *tiny*) entspricht **s** und **S**, speichert die 16-Bit-Ganzzahlen aber in der nativen Byte-Reihenfolge der Maschine, auf der das Tcl-Skript läuft. Die native Byte-Reihenfolge steht im Element **byteOrder** des Arrays **tcl_platform**.

**i**
: Wie **c**, speichert aber einen oder mehrere 32-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge in der Ausgabezeichenkette. Die niederwertigen 32 Bits jeder Ganzzahl werden als Vier-Byte-Wert an der Cursor-Position gespeichert, das niederwertigste Byte zuerst. Beispiel:

    ```
    binary format i3 {3 -3 65536 1}
    ```
    liefert eine Zeichenkette äquivalent zu **\x03\x00\x00\x00\xfd\xff\xff\xff\x00\x00\x01\x00**

**I**
: Wie **i**, speichert aber einen oder mehrere 32-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge in der Ausgabezeichenkette. Beispiel:

    ```
    binary format I3 {3 -3 65536 1}
    ```
    liefert eine Zeichenkette äquivalent zu **\x00\x00\x00\x03\xff\xff\xff\xfd\x00\x01\x00\x00**

**n**
: Diese Form (mnemonisch *number* oder *normal*) entspricht **i** und **I**, speichert die 32-Bit-Ganzzahlen aber in der nativen Byte-Reihenfolge der Maschine, auf der das Tcl-Skript läuft. Die native Byte-Reihenfolge steht im Element **byteOrder** des Arrays **tcl_platform**.

**w**
: Wie **c**, speichert aber einen oder mehrere 64-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge in der Ausgabezeichenkette. Die niederwertigen 64 Bits jeder Ganzzahl werden als Acht-Byte-Wert an der Cursor-Position gespeichert, das niederwertigste Byte zuerst. Beispiel:

    ```
    binary format w 7810179016327718216
    ```
    liefert die Zeichenkette **HelloTcl**

**W**
: Wie **w**, speichert aber einen oder mehrere 64-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge in der Ausgabezeichenkette. Beispiel:

    ```
    binary format Wc 4785469626960341345 110
    ```
    liefert die Zeichenkette **BigEndian**

**m**
: Diese Form (mnemonisch Spiegel von **w**) entspricht **w** und **W**, speichert die 64-Bit-Ganzzahlen aber in der nativen Byte-Reihenfolge der Maschine, auf der das Tcl-Skript läuft. Die native Byte-Reihenfolge steht im Element **byteOrder** des Arrays **tcl_platform**.

**f**
: Wie **c**, speichert aber einen oder mehrere Gleitkommazahlen einfacher Genauigkeit in der nativen Darstellung der Maschine in der Ausgabezeichenkette. Diese Darstellung ist architekturabhängig und sollte nicht zum Austausch von Gleitkommazahlen über das Netz verwendet werden. Die Größe einer Gleitkommazahl kann architekturabhängig variieren, daher kann die Anzahl erzeugter Bytes variieren. Überläuft der Wert die native Darstellung, wird stattdessen FLT_MAX des Systems verwendet. Da Tcl intern Gleitkommazahlen doppelter Genauigkeit nutzt, kann bei der Umwandlung in einfache Genauigkeit Genauigkeit verloren gehen. Beispiel auf Windows mit Intel Pentium:

    ```
    binary format f2 {1.6 3.4}
    ```
    liefert eine Zeichenkette äquivalent zu **\xcd\xcc\xcc\x3f\x9a\x99\x59\x40**.

**r**
: Diese Form (mnemonisch *real*) entspricht **f**, speichert die Gleitkommazahlen einfacher Genauigkeit aber in Little-Endian-Reihenfolge. Sinnvolle Ausgabe nur auf Maschinen mit IEEE-Gleitkommadarstellung (sehr verbreitet, nicht universell).

**R**
: Wie **r**, speichert die Gleitkommazahlen einfacher Genauigkeit aber in Big-Endian-Reihenfolge.

**d**
: Wie **f**, speichert aber einen oder mehrere Gleitkommazahlen doppelter Genauigkeit in der nativen Darstellung der Maschine in der Ausgabezeichenkette. Beispiel auf Windows mit Intel Pentium:

    ```
    binary format d1 {1.6}
    ```
    liefert eine Zeichenkette äquivalent zu **\x9a\x99\x99\x99\x99\x99\xf9\x3f**.

**q**
: Diese Form (mnemonisch Spiegel von **d**) entspricht **d**, speichert die Gleitkommazahlen doppelter Genauigkeit aber in Little-Endian-Reihenfolge. Sinnvolle Ausgabe nur auf Maschinen mit IEEE-Gleitkommadarstellung (sehr verbreitet, nicht universell).

**Q**
: Wie **q**, speichert die Gleitkommazahlen doppelter Genauigkeit aber in Big-Endian-Reihenfolge.

**x**
: Speichert *count* Null-Bytes in der Ausgabezeichenkette. Ist *count* nicht angegeben, ein Null-Byte. Ist *count* **\***, wird ein Fehler erzeugt. Dieser Typ verbraucht kein Argument. Beispiel:

    ```
    binary format a3xa3x2a3 abc def ghi
    ```
    liefert eine Zeichenkette äquivalent zu **abc\000def\000\000ghi**.

**X**
: Setzt den Cursor in der Ausgabezeichenkette um *count* Bytes zurück. Ist *count* **\*** oder größer als die aktuelle Cursor-Position, steht der Cursor bei 0, sodass das nächste gespeicherte Byte das erste der Ergebniszeichenkette ist. Fehlt *count*, wird der Cursor um ein Byte zurückgesetzt. Dieser Typ verbraucht kein Argument. Beispiel:

    ```
    binary format a3X*a3X2a3 abc def ghi
    ```
    liefert **dghi**.

**@**
: Setzt den Cursor auf die absolute Position *count* in der Ausgabezeichenkette. Position 0 ist das erste Byte der Ausgabezeichenkette. Verweist *count* hinter das zuletzt gespeicherte Byte, werden Null-Bytes in die uninitialisierten Positionen geschrieben und der Cursor an die angegebene Stelle gesetzt. Ist *count* **\***, wird der Cursor ans Ende der Ausgabezeichenkette gesetzt. Fehlt *count*, wird ein Fehler erzeugt. Dieser Typ verbraucht kein Argument. Beispiel:

    ```
    binary format a5@2a1@*a3@10a1 abcde f ghi j
    ```
    liefert **abfdeghi\000\000j**.


# BINARY SCAN

Der Befehl **binary scan** parst Felder aus einer Binärzeichenkette und gibt die Anzahl durchgeführter Umwandlungen zurück. *String* liefert die zu parsenden Eingabe-Bytes (ein Byte pro Zeichen; Zeichen, die nicht als Byte darstellbar sind, verlieren die hohen Bits) und *formatString* legt fest, wie geparst wird. Jedes *varName* ist der Name einer Variable; wird ein Feld aus *string* gescannt, wird das Ergebnis der entsprechenden Variable zugewiesen.

Wie bei **binary format** besteht *formatString* aus null oder mehr Feldspezifizierern, getrennt durch null oder mehr Leerzeichen. Jeder Feldspezifizierer ist ein Typzeichen, optional ein Flag-Zeichen und optional *count*. Die meisten Feldspezifizierer verbrauchen ein Argument für die Variable, in die die gescannten Werte geschrieben werden. Das Typzeichen legt die Interpretation der Binärdaten fest. *count* gibt typischerweise an, wie viele Elemente des Typs aus den Daten genommen werden. Ist *count* vorhanden, ist es eine nicht-negative Dezimalganzzahl oder **\***, was normalerweise bedeutet, dass alle verbleibenden Elemente in den Daten verwendet werden. Reichen nach der aktuellen Cursor-Position nicht genug Bytes für den aktuellen Feldspezifizierer, bleibt die entsprechende Variable unverändert und **binary scan** kehrt sofort mit der Anzahl gesetzter Variablen zurück. Reichen die Argumente nicht für alle felderverbrauchenden Felder in der Formatzeichenkette, wird ein Fehler erzeugt. Das Flag-Zeichen „u“ kann angegeben werden, damit einige Typen als vorzeichenlose Werte gelesen werden. Das Flag wird für alle Feldtypen akzeptiert, bei Nicht-Ganzzahl-Feldern aber ignoriert.

Ein ähnliches Beispiel wie bei **binary format** verdeutlicht den Zusammenhang zwischen Feldspezifizierern und Argumenten bei **binary scan**:

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

Jedes Paar Typ-*count* bewegt einen imaginären Cursor durch die Binärdaten und liest Bytes ab der aktuellen Position. Anfangs steht der Cursor bei 0. Der Typ kann eines der folgenden Zeichen sein:

**a**
: Die Daten sind eine Byte-Zeichenkette der Länge *count*. Ist *count* **\***, werden alle verbleibenden Bytes in *string* in die Variable gescannt. Fehlt *count*, wird ein Byte gescannt. Alle gescannten Bytes gelten als Zeichen im Bereich \u0000-\u00ff; ist die Zeichenkette keine Binärzeichenkette oder keine ISO-8859-1-kodierte Zeichenkette, ist **encoding convertfrom** nötig. Beispiel:

    ```
    binary scan abcde\000fghi a6a10 var1 var2
    ```
    gibt **1** zurück, die Zeichenkette äquivalent zu **abcde\000** steht in *var1*, *var2* bleibt unverändert, und

    ```
    binary scan \342\202\254 a* var1
    set var2 [encoding convertfrom utf-8 $var1]
    ```
    speichert ein Euro-Zeichen in *var2*.

**A**
: Wie **a**, aber nachgestellte Leer- und Nullzeichen werden vor dem Speichern in der Variable entfernt. Beispiel:

    ```
    binary scan "abc efghi  \000" A* var1
    ```
    gibt **1** zurück, **abc efghi** steht in *var1*.

**b**
: Die Daten werden in eine Zeichenkette aus *count* Binärziffern in niedrig-nach-hoch-Reihenfolge als Folge aus „1“ und „0“ umgewandelt. Die Bytes werden in Reihenfolge erster bis letzter gescannt, die Bits niedrig-nach-hoch innerhalb jedes Bytes. Überzählige Bits im letzten Byte werden ignoriert. Ist *count* **\***, werden alle verbleibenden Bits in *string* gescannt. Fehlt *count*, wird ein Bit gescannt. Beispiel:

    ```
    binary scan \x07\x87\x05 b5b* var1 var2
    ```
    gibt **2** zurück, **11100** in *var1*, **1110000110100000** in *var2*.

**B**
: Wie **b**, aber die Bits werden hoch-nach-niedrig innerhalb jedes Bytes genommen. Beispiel:

    ```
    binary scan \x70\x87\x05 B5B* var1 var2
    ```
    gibt **2** zurück, **01110** in *var1*, **1000011100000101** in *var2*.

**H**
: Die Daten werden in eine Zeichenkette aus *count* hexadezimalen Ziffern in hoch-nach-niedrig-Reihenfolge als Folge aus „0123456789abcdef“ umgewandelt. Die Bytes werden in Reihenfolge erster bis letzter gescannt, die Hex-Ziffern hoch-nach-niedrig innerhalb jedes Bytes. Überzählige Bits im letzten Byte werden ignoriert. Ist *count* **\***, werden alle verbleibenden Hex-Ziffern in *string* gescannt. Fehlt *count*, wird eine Hex-Ziffer gescannt. Beispiel:

    ```
    binary scan \x07\xC6\x05\x1f\x34 H3H* var1 var2
    ```
    gibt **2** zurück, **07c** in *var1*, **051f34** in *var2*.

**h**
: Wie **H**, aber die Ziffern werden innerhalb jedes Bytes in umgekehrter (niedrig-nach-hoch) Reihenfolge genommen. Beispiel:

    ```
    binary scan \x07\x86\x05\x12\x34 h3h* var1 var2
    ```
    gibt **2** zurück, **706** in *var1*, **502143** in *var2*.
    Code, der hexadezimale Ziffern aus mehreren Bytes der Reihe nach parsen soll, sollte meist das Format **H** verwenden.

**c**
: Die Daten werden in *count* vorzeichenbehaftete 8-Bit-Ganzzahlen umgewandelt und als Liste in der entsprechenden Variable gespeichert. Ist *count* **\***, werden alle verbleibenden Bytes in *string* gescannt. Fehlt *count*, wird eine 8-Bit-Ganzzahl gescannt. Beispiel:

    ```
    binary scan \x07\x86\x05 c2c* var1 var2
    ```
    gibt **2** zurück, **7 -122** in *var1*, **5** in *var2*. Die zurückgegebenen Ganzzahlen sind vorzeichenbehaftet; vorzeichenlose 8-Bit-Werte erhält man z. B. mit:

    ```
    set num [expr { $num & 0xFF }]
    ```

**s**
: Die Daten werden als *count* vorzeichenbehaftete 16-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge interpretiert und als Liste in der Variable gespeichert. Ist *count* **\***, werden alle verbleibenden Bytes in *string* gescannt. Fehlt *count*, wird eine 16-Bit-Ganzzahl gescannt. Beispiel:

    ```
    binary scan \x05\x00\x07\x00\xf0\xff s2s* var1 var2
    ```
    gibt **2** zurück, **5 7** in *var1*, **-16** in *var2*. Die Ganzzahlen sind vorzeichenbehaftet; vorzeichenlose 16-Bit-Werte z. B. mit:

    ```
    set num [expr { $num & 0xFFFF }]
    ```

**S**
: Wie **s**, aber die Daten werden als *count* vorzeichenbehaftete 16-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge interpretiert. Beispiel:

    ```
    binary scan \x00\x05\x00\x07\xff\xf0 S2S* var1 var2
    ```
    gibt **2** zurück, **5 7** in *var1*, **-16** in *var2*.

**t**
: Die Daten werden als *count* vorzeichenbehaftete 16-Bit-Ganzzahlen in der nativen Byte-Reihenfolge der Maschine interpretiert, auf der das Tcl-Skript läuft. Ansonsten identisch zu **s** und **S**. Die native Byte-Reihenfolge steht im Element **byteOrder** des Arrays **tcl_platform**.

**i**
: Die Daten werden als *count* vorzeichenbehaftete 32-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge interpretiert und als Liste gespeichert. Ist *count* **\***, werden alle verbleibenden Bytes in *string* gescannt. Fehlt *count*, wird eine 32-Bit-Ganzzahl gescannt. Beispiel:

    ```
    set str \x05\x00\x00\x00\x07\x00\x00\x00\xf0\xff\xff\xff
    binary scan $str i2i* var1 var2
    ```
    gibt **2** zurück, **5 7** in *var1*, **-16** in *var2*. Die Ganzzahlen sind vorzeichenbehaftet; vorzeichenlose 32-Bit-Werte z. B. mit:

    ```
    set num [expr { $num & 0xFFFFFFFF }]
    ```

**I**
: Wie **i**, aber die Daten werden als *count* vorzeichenbehaftete 32-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge interpretiert. Beispiel:

    ```
    set str \x00\x00\x00\x05\x00\x00\x00\x07\xff\xff\xff\xf0
    binary scan $str I2I* var1 var2
    ```
    gibt **2** zurück, **5 7** in *var1*, **-16** in *var2*.

**n**
: Die Daten werden als *count* vorzeichenbehaftete 32-Bit-Ganzzahlen in der nativen Byte-Reihenfolge der Maschine interpretiert. Ansonsten identisch zu **i** und **I**. Die native Byte-Reihenfolge steht im Element **byteOrder** des Arrays **tcl_platform**.

**w**
: Die Daten werden als *count* vorzeichenbehaftete 64-Bit-Ganzzahlen in Little-Endian-Byte-Reihenfolge interpretiert und als Liste gespeichert. Ist *count* **\***, werden alle verbleibenden Bytes in *string* gescannt. Fehlt *count*, wird eine 64-Bit-Ganzzahl gescannt. Beispiel:

    ```
    set str \x05\x00\x00\x00\x07\x00\x00\x00\xf0\xff\xff\xff
    binary scan $str wi* var1 var2
    ```
    gibt **2** zurück, **30064771077** in *var1*, **-16** in *var2*. Die zurückgegebenen Ganzzahlen sind vorzeichenbehaftet und können von Tcl nicht als vorzeichenlose Werte dargestellt werden.

**W**
: Wie **w**, aber die Daten werden als *count* vorzeichenbehaftete 64-Bit-Ganzzahlen in Big-Endian-Byte-Reihenfolge interpretiert. Beispiel:

    ```
    set str \x00\x00\x00\x05\x00\x00\x00\x07\xff\xff\xff\xf0
    binary scan $str WI* var1 var2
    ```
    gibt **2** zurück, **21474836487** in *var1*, **-16** in *var2*.

**m**
: Die Daten werden als *count* vorzeichenbehaftete 64-Bit-Ganzzahlen in der nativen Byte-Reihenfolge der Maschine interpretiert. Ansonsten identisch zu **w** und **W**. Die native Byte-Reihenfolge steht im Element **byteOrder** des Arrays **tcl_platform**.

**f**
: Die Daten werden als *count* Gleitkommazahlen einfacher Genauigkeit in der nativen Darstellung der Maschine interpretiert und als Liste gespeichert. Ist *count* **\***, werden alle verbleibenden Bytes in *string* gescannt. Fehlt *count*, wird eine Gleitkommazahl einfacher Genauigkeit gescannt. Die Größe einer Gleitkommazahl kann architekturabhängig variieren, daher kann die Anzahl gescannter Bytes variieren. Repräsentieren die Daten keine gültige Gleitkommazahl, ist der resultierende Wert undefiniert und compilerabhängig. Beispiel auf Windows mit Intel Pentium:

    ```
    binary scan \x3f\xcc\xcc\xcd f var1
    ```
    gibt **1** zurück, **1.6000000238418579** in *var1*.

**r**
: Wie **f**, aber die Daten werden als *count* Gleitkommazahlen einfacher Genauigkeit in Little-Endian-Reihenfolge interpretiert. Diese Umwandlung ist nicht portabel auf Systeme ohne IEEE-Gleitkommadarstellung.

**R**
: Wie **f**, aber die Daten werden als *count* Gleitkommazahlen einfacher Genauigkeit in Big-Endian-Reihenfolge interpretiert. Diese Umwandlung ist nicht portabel auf Systeme ohne IEEE-Gleitkommadarstellung.

**d**
: Wie **f**, aber die Daten werden als *count* Gleitkommazahlen doppelter Genauigkeit in der nativen Darstellung der Maschine interpretiert. Beispiel auf Windows mit Intel Pentium:

    ```
    binary scan \x9a\x99\x99\x99\x99\x99\xf9\x3f d var1
    ```
    gibt **1** zurück, **1.6000000000000001** in *var1*.

**q**
: Wie **d**, aber die Daten werden als *count* Gleitkommazahlen doppelter Genauigkeit in Little-Endian-Reihenfolge interpretiert. Diese Umwandlung ist nicht portabel auf Systeme ohne IEEE-Gleitkommadarstellung.

**Q**
: Wie **d**, aber die Daten werden als *count* Gleitkommazahlen doppelter Genauigkeit in Big-Endian-Reihenfolge interpretiert. Diese Umwandlung ist nicht portabel auf Systeme ohne IEEE-Gleitkommadarstellung.

**x**
: Setzt den Cursor in *string* um *count* Bytes vor. Ist *count* **\*** oder größer als die Anzahl Bytes nach der aktuellen Cursor-Position, steht der Cursor hinter dem letzten Byte in *string*. Fehlt *count*, wird der Cursor um ein Byte vorwärts gesetzt. Dieser Typ verbraucht kein Argument. Beispiel:

    ```
    binary scan \x01\x02\x03\x04 x2H* var1
    ```
    gibt **1** zurück, **0304** in *var1*.

**X**
: Setzt den Cursor in *string* um *count* Bytes zurück. Ist *count* **\*** oder größer als die aktuelle Cursor-Position, steht der Cursor bei 0, sodass das nächste gescannte Byte das erste in *string* ist. Fehlt *count*, wird der Cursor um ein Byte zurückgesetzt. Dieser Typ verbraucht kein Argument. Beispiel:

    ```
    binary scan \x01\x02\x03\x04 c2XH* var1 var2
    ```
    gibt **2** zurück, **1 2** in *var1*, **020304** in *var2*.

**@**
: Setzt den Cursor auf die absolute Position *count* in der Datenzeichenkette. Position 0 ist das erste Byte in *string*. Verweist *count* hinter das Ende von *string*, steht der Cursor hinter dem letzten Byte. Fehlt *count*, wird ein Fehler erzeugt. Beispiel:

    ```
    binary scan \x01\x02\x03\x04 c2@1H* var1 var2
    ```
    gibt **2** zurück, **1 2** in *var1*, **020304** in *var2*.


# PORTABILITÄT

Die Konvertierungen **r**, **R**, **q** und **Q** funktionieren beim Datentransfer zwischen Rechnern zuverlässig nur, wenn alle IEEE-Gleitkommadarstellung verwenden — sehr verbreitet, aber nicht universell. Für portablen Gleitkommatransport zwischen allen Architekturen die Textdarstellung (wie von **format** erzeugt) verwenden.

# BEISPIELE

Prozedur zum Schreiben einer Tcl-Zeichenkette als UTF-8-Daten mit vorangestelltem Längenwort auf einen binär kodierten Kanal:

```
proc writeString {channel string} {
    set data [encoding convertto utf-8 $string]
    puts -nonewline [binary format Ia* \
            [string length $data] $data]
}
```

Diese Prozedur liest eine Zeichenkette von einem Kanal, der von der zuvor gezeigten Prozedur *writeString* beschrieben wurde:

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
puts [binary encode base64 \-maxlen 64 $data]
```

