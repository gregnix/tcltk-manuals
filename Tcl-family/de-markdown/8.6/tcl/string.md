---
CommandName: string
title: string
ManualSection: n
Version: 8.1
TclPart: Tcl
TclDescription: Tcl Built-In Commands
Links:
 - expr(n)
 - list(n)
Keywords:
 - case conversion
 - compare
 - index
 - integer value
 - match
 - pattern
 - string
 - word
 - equal
 - ctype
 - character
 - reverse
Copyright:
 - Copyright (c) 1993 The Regents of the University of California.
 - Copyright (c) 1994-1996 Sun Microsystems, Inc.
---

# Name

string - Zeichenketten bearbeiten

# Übersicht

::: {.synopsis} :::
[string]{.cmd} [option]{.arg} [arg]{.arg} [arg]{.optdot}
:::

# Beschreibung

Führt je nach *option* eine von mehreren Zeichenkettenoperationen aus. Erlaubte *option*s (Abkürzungen möglich) sind:

[string]{.cmd} [cat]{.sub} [string1]{.optarg} [string2...]{.optarg}
: [Verkettet die *string*s wie direktes Nebeneinanderstellen und gibt die zusammengesetzte Zeichenkette zurück. Ohne Argumente: leerer String.]{version="8.6.2"}

    Gelegentlich handlicher als reine Juxtaposition bei gemischten Anführungszeichen oder wenn das Ergebnis einer Verkettung ohne [return] **-level 0** zurückgegeben werden soll; effizienter als Liste bauen und [join] mit leerem Trennzeichen.

[string]{.cmd} [compare]{.sub} [-nocase]{.optlit} [[-length]{.lit} [length]{.arg}]{.optarg} [string1]{.arg} [string2]{.arg}
: Zeichenweiser Vergleich von *string1* und *string2*. Rückgabe -1, 0 oder 1 (lexikographisch kleiner, gleich, größer). Mit **-length** nur die ersten *length* Zeichen; negative Länge wird ignoriert. **-nocase**: ohne Berücksichtigung der Groß-/Kleinschreibung.

[string]{.cmd} [equal]{.sub} [-nocase]{.optlit} [[-length]{.lit} [length]{.arg}]{.optarg} [string1]{.arg} [string2]{.arg}
: Zeichenweiser Vergleich; 1 bei Identität, sonst 0. **-length** und **-nocase** wie bei **compare**.

[string]{.cmd} [first]{.sub} [needleString]{.arg} [haystackString]{.arg} [startIndex]{.optarg}
: Sucht in *haystackString* die erste exakte Übereinstimmung mit *needleString*; Rückgabe Index des ersten Zeichens oder -1. Mit *startIndex* (Formen siehe [String-Indizes]) beginnt die Suche ab diesem Index. Beispiel:

    ```
    string first a 0a23456789abcdef 5
    ```

    liefert **10**,

    ```
    string first a 0123456789abcdef 11
    ```

    liefert **-1**.

[string]{.cmd} [index]{.sub} [string]{.arg} [charIndex]{.arg}
: Gibt das *charIndex*-te Zeichen von *string* zurück (0 = erstes Zeichen). *charIndex* wie in [String-Indizes].

    Liegt *charIndex* außerhalb [0, Länge), leerer String.

[string]{.cmd} [is]{.sub} [class]{.arg} [-strict]{.optlit} [[-failindex]{.lit} [varname]{.arg}]{.optarg} [string]{.arg}
: 1, wenn *string* zur Zeichenklasse gehört, sonst 0. **-strict**: leerer String → 0; sonst leerer String → 1 für jede Klasse. **-failindex**: bei 0 Index der ersten ungültigen Stelle in *varname* (bei 1 nicht gesetzt). Klassen (abkürzbar):

    **alnum**
    : Jedes Unicode-Alphabet- oder Ziffernzeichen.

    **alpha**
    : Jedes Unicode-Alphabetzeichen.

    **ascii**
    : Zeichenwert &lt; \u0080 (7-Bit-ASCII).

    **boolean**
    : Formen wie für [Tcl\_GetBoolean][GetInt].

    **control**
    : Jedes Unicode-Steuerzeichen.

    **digit**
    : Jedes Unicode-Ziffernzeichen (nicht nur \[0-9\]).

    **double**
    : Formen wie für [Tcl\_GetDoubleFromObj][DoubleObj].

    **entier**
    : [Jede gültige Zeichenkettenform eines Ganzzahlwerts beliebiger Größe in Tcl, optional mit umgebendem Leerraum. Erlaubt sind genau die Formen, die die C-Routine [Tcl\_GetBignumFromObj][IntObj] akzeptiert.]{version="8.6"}

    **false**
    : [Tcl\_GetBoolean][GetInt]-Formen mit Wert false.

    **graph**
    : Druckbares Unicode-Zeichen außer Leerzeichen.

    **integer**
    : Jede gültige Zeichenkettenform eines 32-Bit-Ganzzahlwerts in Tcl, optional mit umgebendem Leerraum. Bei Überlauf wird 0 geliefert und *varname* enthält -1.

    [list]
    : Gültige Listenstruktur, optional Leerraum. Bei Fehler: 0, *varname* = Index des fehlerhaften „Elements“ oder -1.

    **lower**
    : Unicode-Kleinbuchstabe.

    **print**
    : Druckbares Unicode-Zeichen inkl. Leerzeichen.

    **punct**
    : Unicode-Interpunktion.

    **space**
    : Unicode-Whitespace, mongolisches Vokaltrennzeichen (U+180e), zero width space (U+200b), word joiner (U+2060), zero width no-break space (U+feff, BOM).

    **true**
    : [Tcl\_GetBoolean][GetInt] mit Wert true.

    **upper**
    : Unicode-Großbuchstabe.

    **wideinteger**
    : Gültige Wide-Integer-Form; bei Überlauf 0, *varname* = -1.

    **wordchar**
    : Unicode-Wortzeichen (alphanumerisch und Verbinder-Interpunktion, z. B. Unterstrich).

    **xdigit**
    : Hexadezimalziffer (\[0-9A-Fa-f\]).


    Bei **boolean**, **true**, **false**: bei 0 wird *varname* stets auf 0 gesetzt.

[string]{.cmd} [last]{.sub} [needleString]{.arg} [haystackString]{.arg} [lastIndex]{.optarg}
: Letzte exakte Übereinstimmung mit *needleString* in *haystackString*; Index des ersten Zeichens dieser Übereinstimmung oder -1. Mit *lastIndex* nur Zeichen an oder vor diesem Index. Beispiel:

    ```
    string last a 0a23456789abcdef 15
    ```

    → **10**,

    ```
    string last a 0a23456789abcdef 9
    ```

    → **1**.

[string]{.cmd} [length]{.sub} [string]{.arg}
: Dezimalstring mit Zeichenanzahl (nicht zwingend Byteanzahl). Bei Byte-Array-Werten (z. B. binärer Kanal): tatsächliche Bytelänge.

[string]{.cmd} [map]{.sub} [-nocase]{.optlit} [mapping]{.arg} [string]{.arg}
: Ersetzt Teilstrings gemäß Schlüssel-Wert-Paaren in *mapping* (Liste *key value key value ...* wie [array get][array]). **-nocase**: ohne Groß-/Kleinschreibung. Schlüssel und Wert können mehrzeilig sein; Reihenfolge in *mapping* entscheidet; *string* wird nur einmal durchlaufen. Beispiel:

    ```
    string map {abc 1 ab 2 a 3 1 0} 1abcaababcabababc
    ```

    → **01321221**.

    Ist ein früherer *key* Präfix eines späteren, maskiert er diesen vollständig:

    ```
    string map {1 0 ab 2 a 3 abc 1} 1abcaababcabababc
    ```

    → **02c322c222c**.

[string]{.cmd} [match]{.sub} [-nocase]{.optlit} [pattern]{.arg} [string]{.arg}
: Prüft, ob *pattern* auf *string* passt; 1 oder 0. **-nocase**: case-insensitive. Sondersequenzen in *pattern*:

    **\***
    : Beliebige Zeichenfolge in *string*, auch leer.

    **?**
    : Genau ein Zeichen in *string*.

    **\[***chars***\]**
    : Ein Zeichen aus *chars*. Bereich *x***-***y* inklusive. Mit **-nocase** werden Bereichsgrenzen zuerst kleingeschrieben; {\[A-z\]} trifft bei case-sensitive „\_“ (zwischen „Z“ und „a“), mit **-nocase** eher wie {\[A-Za-z\]}.

    **\\***x*
    : Genau das Zeichen *x*; entzieht **\*?[]\\** die Sonderbedeutung.


[string]{.cmd} [range]{.sub} [string]{.arg} [first]{.arg} [last]{.arg}
: Aufeinanderfolgende Zeichen von Index *first* bis *last* ([String-Indizes]). **0** = erstes, **end** = letztes. *first* &lt; 0 → 0; *last* ≥ Länge → **end**. *first* &gt; *last* → leerer String.

[string]{.cmd} [repeat]{.sub} [string]{.arg} [count]{.arg}
: *string* *count*-mal verkettet; *count* 0 → leerer String.

[string]{.cmd} [replace]{.sub} [string]{.arg} [first]{.arg} [last]{.arg} [newstring]{.optarg}
: Entfernt Zeichen *first* bis *last*; optional *newstring* an dieser Stelle. Indizes wie **index**. *first* &gt; *last*, *first* ≥ Länge oder *last* &lt; 0: ursprünglicher String unverändert.

[string]{.cmd} [reverse]{.sub} [string]{.arg}
: Gleiche Länge, Zeichen in umgekehrter Reihenfolge.

[string]{.cmd} [tolower]{.sub} [string]{.arg} [first]{.optarg} [last]{.optarg}
: *string* mit Kleinbuchstaben statt Groß-/Titelfall; optional Bereich *first*..*last* ([String-Indizes]).

[string]{.cmd} [totitle]{.sub} [string]{.arg} [first]{.optarg} [last]{.optarg}
: Erstes Zeichen in Unicode-Titelfall (oder Großbuchstabe), Rest klein; optional Bereich.

[string]{.cmd} [toupper]{.sub} [string]{.arg} [first]{.optarg} [last]{.optarg}
: Klein-/Titelfall → Großbuchstaben; optional Bereich.

[string]{.cmd} [trim]{.sub} [string]{.arg} [chars]{.optarg}
: *string* ohne führende/nachfolgende Zeichen aus *chars*; Standard: Leerzeichen (**string is space** = 1) und „\0“.

[string]{.cmd} [trimleft]{.sub} [string]{.arg} [chars]{.optarg}
: Nur führende Zeichen aus *chars* entfernen; Standard wie **trim**.

[string]{.cmd} [trimright]{.sub} [string]{.arg} [chars]{.optarg}
: Nur nachfolgende Zeichen entfernen; Standard wie **trim**.


## Veraltete Unterbefehle

Unterstützt, voraussichtlich entfernt (selten genutzt oder irreführend):

[string]{.cmd} [bytelength]{.sub} [string]{.arg}
: Dezimalstring mit der Byteanzahl der Darstellung von *string* im Speicher in Tcls internem modifiziertem UTF-8. Tcl kann für *string* auch andere Kodierungen verwenden und garantiert nicht, nur eine Kodierung zu benutzen. Weil UTF-8 für Unicode-Zeichen eine variable Byteanzahl nutzt, ist die Bytelänge im Allgemeinen nicht die Zeichenlänge. Skripte, denen die Bytelänge wichtig ist, sind selten.

    In fast allen Fällen sollte **string length** verwendet werden (auch für die Länge eines Tcl-Bytearrays). Einzelheiten zur UTF-8-Darstellung stehen in der Handbuchseite [Tcl\_NumUtfChars][Utf].

    Formal liefert **string bytelength** das Feld *length* der Struktur [Tcl\_Obj][Object], nachdem [Tcl\_GetString][StringObj] das Feld *bytes* gefüllt hat. Für Tcl-Skripte ist das kaum nützlich: Tcls interne Kodierung ist kein striktes UTF-8, sondern ein modifiziertes CESU-8 mit denormalisiertem NUL (wie an mehreren Stellen in Javas Serialisierung), damit C-Funktionen ohne Unicode-Kenntnis arbeiten können. Diese Darstellung ist der Tcl-Implementierung vorbehalten; die Byteanzahl hat außerhalb von C-Erweiterungen (Speicherverwaltung) kaum Wert.

    *Kompatibilitätshinweis:* Dieser Unterbefehl wird voraussichtlich in einer künftigen Tcl-Version entfernt. Besser ist es, mit [encoding convertto][encoding] in eine bekannte Kodierung umzuwandeln und darauf **string length** anzuwenden.

    ```
    string length [encoding convertto utf-8 $theString]
    ```

[string]{.cmd} [wordend]{.sub} [string]{.arg} [charIndex]{.arg}
: Index des Zeichens unmittelbar nach dem letzten des Worts um *charIndex* ([String-Indizes]). Wort: zusammenhängende alphanumerische Unicode-Zeichen oder Unterstrich (Verbinder-Interpunktion), sonst ein einzelnes anderes Zeichen.

[string]{.cmd} [wordstart]{.sub} [string]{.arg} [charIndex]{.arg}
: Index des ersten Zeichens des Worts um *charIndex*; Wortdefinition wie oben.


# String-Indizes

Indizes in Zeichenketten (z. B. **string index**, **string range**):

*integer*
: Jeder Index, der **string is integer -strict** besteht (z. B. **2** → „c“ in „abcd“).

**end**
: Letztes Zeichen („d“ in „abcd“).

**end-***N*
: Letztes Zeichen minus *N* (**end-1** → „c“).

**end+***N*
: Letztes Zeichen plus *N* (**end+-1** → „c“).

*M***+***N*
: Zeichen an Index *M*+*N* (**1+1** → „c“).

*M***-***N*
: Zeichen an Index *M*-*N* (**2-1** → „b“).


*M* hat keinen nachgestellten Leerraum, *N* keinen führenden.

# Beispiele

Prüfen, ob *string* ein echtes, nicht leeres Präfix von **foobar** ist:

```
set length [string length $string]
if {$length == 0} {
    set isPrefix 0
} else {
    set isPrefix [string equal -length $length $string "foobar"]
}
```


[array]: array.md
[DoubleObj]: ../tcl-c/DoubleObj.md
[encoding]: encoding.md
[GetInt]: ../tcl-c/GetInt.md
[IntObj]: ../tcl-c/IntObj.md
[join]: join.md
[list]: list.md
[Object]: ../tcl-c/Object.md
[return]: return.md
[StringObj]: ../tcl-c/StringObj.md
[Utf]: ../tcl-c/Utf.md
