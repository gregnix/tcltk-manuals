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

Führt je nach *option* eine von mehreren Zeichenkettenoperationen aus. Die zulässigen *option*en (sie dürfen abgekürzt werden) sind:

[string]{.cmd} [cat]{.sub} [string1]{.optarg} [string2...]{.optarg}
: [Verkettet die angegebenen *string*-Argumente so, als stünden sie direkt nebeneinander, und gibt die entstandene zusammengesetzte Zeichenkette zurück. Ist kein *string*-Argument angegeben, ist das Ergebnis eine leere Zeichenkette.]{version="8.6.2"}

    Dieser elementare Befehl ist gelegentlich handlicher als das bloße Aneinanderreihen von Zeichenketten, wenn gemischte Quotierung gewünscht ist oder wenn das Ergebnis einer Verkettung zurückgegeben werden soll, ohne auf [return] **-level 0** zurückzugreifen. Außerdem ist er effizienter, als eine Liste von Argumenten aufzubauen und [join] mit einer leeren Verbindungszeichenkette zu verwenden.

[string]{.cmd} [compare]{.sub} [-nocase]{.optlit} [[-length]{.lit} [length]{.arg}]{.optarg} [string1]{.arg} [string2]{.arg}
: Vergleicht die Zeichenketten *string1* und *string2* Zeichen für Zeichen. Gibt -1, 0 oder 1 zurück, je nachdem, ob *string1* lexikographisch kleiner als, gleich oder größer als *string2* ist. Wenn **-length** angegeben ist, werden nur die ersten *length* Zeichen für den Vergleich verwendet. Ist **-length** negativ, wird die Option ignoriert. Wenn **-nocase** angegeben ist, werden die Zeichenketten ohne Berücksichtigung der Groß-/Kleinschreibung verglichen.

[string]{.cmd} [equal]{.sub} [-nocase]{.optlit} [[-length]{.lit} [length]{.arg}]{.optarg} [string1]{.arg} [string2]{.arg}
: Vergleicht die Zeichenketten *string1* und *string2* Zeichen für Zeichen. Gibt 1 zurück, wenn *string1* und *string2* identisch sind, andernfalls 0. Wenn **-length** angegeben ist, werden nur die ersten *length* Zeichen für den Vergleich verwendet. Ist **-length** negativ, wird die Option ignoriert. Wenn **-nocase** angegeben ist, werden die Zeichenketten ohne Berücksichtigung der Groß-/Kleinschreibung verglichen.

[string]{.cmd} [first]{.sub} [needleString]{.arg} [haystackString]{.arg} [startIndex]{.optarg}
: Durchsucht *haystackString* nach einer Zeichenfolge, die genau mit den Zeichen in *needleString* übereinstimmt. Wird sie gefunden, gibt der Befehl den Index des ersten Zeichens der ersten solchen Übereinstimmung in *haystackString* zurück. Wird sie nicht gefunden, gibt er -1 zurück. Wenn *startIndex* angegeben ist (in einer der unter [String-Indizes] beschriebenen Formen), beginnt die Suche erst bei dem Zeichen in *haystackString*, das dieser Index bezeichnet. Zum Beispiel gibt

    ```
    string first a 0a23456789abcdef 5
    ```

    **10** zurück, aber

    ```
    string first a 0123456789abcdef 11
    ```

    gibt **-1** zurück.

[string]{.cmd} [index]{.sub} [string]{.arg} [charIndex]{.arg}
: Gibt das *charIndex*-te Zeichen des Arguments *string* zurück. Ein *charIndex* von 0 entspricht dem ersten Zeichen der Zeichenkette. *charIndex* kann wie im Abschnitt [String-Indizes] beschrieben angegeben werden.

    Ist *charIndex* kleiner als 0 oder größer oder gleich der Länge der Zeichenkette, gibt der Befehl eine leere Zeichenkette zurück.

[string]{.cmd} [is]{.sub} [class]{.arg} [-strict]{.optlit} [[-failindex]{.lit} [varname]{.arg}]{.optarg} [string]{.arg}
: Gibt 1 zurück, wenn *string* ein gültiges Element der angegebenen Zeichenklasse ist, andernfalls 0. Wenn **-strict** angegeben ist, ergibt eine leere Zeichenkette 0; andernfalls ergibt eine leere Zeichenkette bei jeder Klasse 1. Wenn **-failindex** angegeben ist und der Befehl 0 zurückgibt, wird der Index in der Zeichenkette, ab dem die Klasse nicht mehr zutraf, in der Variablen namens *varname* gespeichert. Gibt **string is** 1 zurück, wird *varname* nicht gesetzt. Die folgenden Zeichenklassen werden erkannt (der Klassenname darf abgekürzt werden):

    **alnum**
    : Jeder Unicode-Buchstabe und jede Unicode-Ziffer.

    **alpha**
    : Jeder Unicode-Buchstabe.

    **ascii**
    : Jedes Zeichen mit einem Wert kleiner als \\u0080 (also die Zeichen im 7-Bit-ASCII-Bereich).

    **boolean**
    : Jede der Formen, die [Tcl\_GetBoolean][GetInt] akzeptiert.

    **control**
    : Jedes Unicode-Steuerzeichen.

    **digit**
    : Jede Unicode-Ziffer. Beachten Sie, dass dazu auch Zeichen außerhalb des Bereichs \[0-9\] gehören.

    **double**
    : Jede der Formen, die [Tcl\_GetDoubleFromObj][DoubleObj] akzeptiert.

    **entier**
    : [Jede gültige Zeichenkettenform eines Ganzzahlwerts beliebiger Größe in Tcl, optional mit umgebendem Leerraum. Erlaubt sind genau die Formen, die die C-Routine [Tcl\_GetBignumFromObj][IntObj] akzeptiert.]{version="8.6"}

    **false**
    : Jede der Formen, die [Tcl\_GetBoolean][GetInt] akzeptiert und bei denen der Wert falsch ist.

    **graph**
    : Jedes druckbare Unicode-Zeichen außer dem Leerzeichen.

    **integer**
    : Jede der gültigen Zeichenkettenformen für einen 32-Bit-Ganzzahlwert in Tcl, optional mit umgebendem Leerraum. Bei einem Überlauf des Werts wird 0 zurückgegeben, und *varname* enthält -1.

    [list]
    : Jede korrekte Listenstruktur, optional mit umgebendem Leerraum. Bei einer fehlerhaften Listenstruktur wird 0 zurückgegeben, und *varname* enthält den Index des „Elements“, an dem die Analyse der Liste scheitert, oder -1, wenn sich dieser nicht bestimmen lässt.

    **lower**
    : Jeder Unicode-Kleinbuchstabe.

    **print**
    : Jedes druckbare Unicode-Zeichen einschließlich des Leerzeichens.

    **punct**
    : Jedes Unicode-Satzzeichen.

    **space**
    : Jedes Unicode-Leerraumzeichen, das mongolische Vokaltrennzeichen (U+180e), das Leerzeichen ohne Breite (U+200b), der Wortverbinder (U+2060) oder das geschützte Leerzeichen ohne Breite (U+feff) (=BOM).

    **true**
    : Jede der Formen, die [Tcl\_GetBoolean][GetInt] akzeptiert und bei denen der Wert wahr ist.

    **upper**
    : Jeder Großbuchstabe des Unicode-Zeichensatzes.

    **wideinteger**
    : Jede der gültigen Formen für eine breite Ganzzahl (Wide Integer) in Tcl, optional mit umgebendem Leerraum. Bei einem Überlauf des Werts wird 0 zurückgegeben, und *varname* enthält -1.

    **wordchar**
    : Jedes Unicode-Wortzeichen, also jedes alphanumerische Zeichen und jedes Unicode-Verbindungssatzzeichen (z. B. der Unterstrich).

    **xdigit**
    : Jede Hexadezimalziffer (\[0-9A-Fa-f\]).


    Bei **boolean**, **true** und **false** wird *varname* immer auf 0 gesetzt, wenn der Befehl 0 zurückgibt, weil ein gültiger boolescher Wert sehr verschiedene Formen haben kann.

[string]{.cmd} [last]{.sub} [needleString]{.arg} [haystackString]{.arg} [lastIndex]{.optarg}
: Durchsucht *haystackString* nach einer Zeichenfolge, die genau mit den Zeichen in *needleString* übereinstimmt. Wird sie gefunden, gibt der Befehl den Index des ersten Zeichens der letzten solchen Übereinstimmung in *haystackString* zurück. Gibt es keine Übereinstimmung, gibt er -1 zurück. Wenn *lastIndex* angegeben ist (in einer der unter [String-Indizes] beschriebenen Formen), berücksichtigt die Suche nur die Zeichen in *haystackString* am oder vor dem angegebenen *lastIndex*. Zum Beispiel gibt

    ```
    string last a 0a23456789abcdef 15
    ```

    **10** zurück, aber

    ```
    string last a 0a23456789abcdef 9
    ```

    gibt **1** zurück.

[string]{.cmd} [length]{.sub} [string]{.arg}
: Gibt eine dezimale Zeichenkette mit der Anzahl der Zeichen in *string* zurück. Beachten Sie, dass dies nicht unbedingt der Anzahl der Bytes entspricht, die zum Speichern der Zeichenkette verwendet werden. Ist der Wert ein Byte-Array-Wert (etwa ein Wert, der beim Lesen aus einem binär kodierten Kanal zurückgegeben wird), gibt der Befehl die tatsächliche Bytelänge des Werts zurück.

[string]{.cmd} [map]{.sub} [-nocase]{.optlit} [mapping]{.arg} [string]{.arg}
: Ersetzt Teilzeichenketten in *string* anhand der Schlüssel-Wert-Paare in *mapping*. *mapping* ist eine Liste der Form *key value key value ...*, wie sie [array get][array] zurückgibt. Jedes Vorkommen eines Schlüssels in der Zeichenkette wird durch den zugehörigen Wert ersetzt. Wenn **-nocase** angegeben ist, wird beim Vergleich die Groß-/Kleinschreibung nicht berücksichtigt. Sowohl *key* als auch *value* können aus mehreren Zeichen bestehen. Die Ersetzung erfolgt in geordneter Weise: Der Schlüssel, der in der Liste zuerst steht, wird zuerst geprüft, und so weiter. *string* wird nur einmal durchlaufen, daher wirken sich frühere Schlüsselersetzungen nicht auf spätere Schlüsseltreffer aus. Zum Beispiel gibt

    ```
    string map {abc 1 ab 2 a 3 1 0} 1abcaababcabababc
    ```

    die Zeichenkette **01321221** zurück.

    Beachten Sie: Ist ein früherer *key* ein Präfix eines späteren, verdeckt er den späteren vollständig. Wird das vorige Beispiel also so umgestellt,

    ```
    string map {1 0 ab 2 a 3 abc 1} 1abcaababcabababc
    ```

    gibt es die Zeichenkette **02c322c222c** zurück.

[string]{.cmd} [match]{.sub} [-nocase]{.optlit} [pattern]{.arg} [string]{.arg}
: Prüft, ob *pattern* auf *string* passt; gibt 1 zurück, wenn dies der Fall ist, und 0, wenn nicht. Wenn **-nocase** angegeben ist, versucht das Muster, ohne Berücksichtigung der Groß-/Kleinschreibung auf die Zeichenkette zu passen. Damit die beiden Zeichenketten übereinstimmen, muss ihr Inhalt identisch sein, außer dass in *pattern* die folgenden Sondersequenzen vorkommen dürfen:

    **\***
    : Passt auf jede beliebige Zeichenfolge in *string*, auch auf eine leere Zeichenkette.

    **?**
    : Passt auf jedes einzelne Zeichen in *string*.

    **\[***chars***\]**
    : Passt auf jedes Zeichen aus der durch *chars* gegebenen Menge. Kommt in *chars* eine Folge der Form *x***-***y* vor, passt jedes Zeichen zwischen *x* und *y* einschließlich der Grenzen. Zusammen mit **-nocase** werden die Endpunkte des Bereichs zuerst in Kleinbuchstaben umgewandelt. Während {\[A-z\]} bei Beachtung der Groß-/Kleinschreibung auf „\_“ passt (da „\_“ zwischen „Z“ und „a“ liegt), wird es mit **-nocase** wie {\[A-Za-z\]} behandelt (was vermutlich ohnehin gemeint war).

    **\\***x*
    : Passt auf genau das Zeichen *x*. Damit lässt sich die Sonderbedeutung der Zeichen **\*?\[\]\\** in *pattern* umgehen.


[string]{.cmd} [range]{.sub} [string]{.arg} [first]{.arg} [last]{.arg}
: Gibt einen Bereich aufeinanderfolgender Zeichen aus *string* zurück, beginnend mit dem Zeichen mit dem Index *first* und endend mit dem Zeichen mit dem Index *last* (in den unter [String-Indizes] beschriebenen Formen). Der Index **0** bezeichnet das erste Zeichen der Zeichenkette, der Index **end** das letzte Zeichen. *first* und *last* können wie beim Unterbefehl **index** angegeben werden. Ist *first* kleiner als null, wird es wie null behandelt; ist *last* größer oder gleich der Länge der Zeichenkette, wird es wie **end** behandelt. Ist *first* größer als *last*, wird eine leere Zeichenkette zurückgegeben.

[string]{.cmd} [repeat]{.sub} [string]{.arg} [count]{.arg}
: Gibt eine Zeichenkette zurück, die aus *string* besteht, *count*-mal mit sich selbst verkettet. Ist *count* 0, wird die leere Zeichenkette zurückgegeben.

[string]{.cmd} [replace]{.sub} [string]{.arg} [first]{.arg} [last]{.arg} [newstring]{.optarg}
: Entfernt einen Bereich aufeinanderfolgender Zeichen aus *string*, beginnend mit dem Zeichen mit dem Index *first* und endend mit dem Zeichen mit dem Index *last* (in den unter [String-Indizes] beschriebenen Formen). Der Index 0 bezeichnet das erste Zeichen der Zeichenkette. *First* und *last* können wie beim Unterbefehl **index** angegeben werden. Wenn *newstring* angegeben ist, wird es an die Stelle des entfernten Zeichenbereichs gesetzt. Ist *first* kleiner als null, wird es wie null behandelt; ist *last* größer oder gleich der Länge der Zeichenkette, wird es wie **end** behandelt. Die ursprüngliche Zeichenkette wird unverändert zurückgegeben, wenn *first* größer als *last* ist, wenn *first* größer oder gleich der Länge der ursprünglichen Zeichenkette ist oder wenn *last* kleiner als 0 ist.

[string]{.cmd} [reverse]{.sub} [string]{.arg}
: Gibt eine Zeichenkette zurück, die genauso lang ist wie *string*, deren Zeichen aber in umgekehrter Reihenfolge stehen.

[string]{.cmd} [tolower]{.sub} [string]{.arg} [first]{.optarg} [last]{.optarg}
: Gibt einen Wert zurück, der *string* entspricht, nur dass alle Groß- (oder Titel-)Buchstaben in Kleinbuchstaben umgewandelt sind. Wenn *first* angegeben ist, bezeichnet es den Zeichenindex in der Zeichenkette, ab dem die Änderung beginnt. Ist *last* nicht angegeben, wird nur das Zeichen an der Position *first* umgewandelt; andernfalls bezeichnet *last* den Zeichenindex in der Zeichenkette, an dem die Änderung endet (einschließlich). *first* und *last* können in den unter [String-Indizes] beschriebenen Formen angegeben werden.

[string]{.cmd} [totitle]{.sub} [string]{.arg} [first]{.optarg} [last]{.optarg}
: Gibt einen Wert zurück, der *string* entspricht, nur dass das erste Zeichen in *string* in seine Unicode-Titelschreibweise umgewandelt ist (oder in einen Großbuchstaben, wenn es keine Titelschreibweise gibt) und der Rest der Zeichenkette in Kleinbuchstaben. Wenn *first* angegeben ist, bezeichnet es den Zeichenindex in der Zeichenkette, ab dem die Änderung beginnt. Ist *last* nicht angegeben, wird nur das Zeichen an der Position *first* umgewandelt; andernfalls bezeichnet *last* den Zeichenindex in der Zeichenkette, an dem die Änderung endet (einschließlich). *first* und *last* können in den unter [String-Indizes] beschriebenen Formen angegeben werden.

[string]{.cmd} [toupper]{.sub} [string]{.arg} [first]{.optarg} [last]{.optarg}
: Gibt einen Wert zurück, der *string* entspricht, nur dass alle Klein- (oder Titel-)Buchstaben in Großbuchstaben umgewandelt sind. Wenn *first* angegeben ist, bezeichnet es den Zeichenindex in der Zeichenkette, ab dem die Änderung beginnt. Ist *last* nicht angegeben, wird nur das Zeichen an der Position *first* umgewandelt; andernfalls bezeichnet *last* den Zeichenindex in der Zeichenkette, an dem die Änderung endet (einschließlich). *first* und *last* können in den unter [String-Indizes] beschriebenen Formen angegeben werden.

[string]{.cmd} [trim]{.sub} [string]{.arg} [chars]{.optarg}
: Gibt einen Wert zurück, der *string* entspricht, nur dass alle führenden und nachfolgenden Zeichen entfernt sind, die in der durch *chars* gegebenen Zeichenkette vorkommen. Ist *chars* nicht angegeben, wird Leerraum entfernt (jedes Zeichen, für das **string is space** 1 zurückgibt, sowie „\\0“).

[string]{.cmd} [trimleft]{.sub} [string]{.arg} [chars]{.optarg}
: Gibt einen Wert zurück, der *string* entspricht, nur dass alle führenden Zeichen entfernt sind, die in der durch *chars* gegebenen Zeichenkette vorkommen. Ist *chars* nicht angegeben, wird Leerraum entfernt (jedes Zeichen, für das **string is space** 1 zurückgibt, sowie „\\0“).

[string]{.cmd} [trimright]{.sub} [string]{.arg} [chars]{.optarg}
: Gibt einen Wert zurück, der *string* entspricht, nur dass alle nachfolgenden Zeichen entfernt sind, die in der durch *chars* gegebenen Zeichenkette vorkommen. Ist *chars* nicht angegeben, wird Leerraum entfernt (jedes Zeichen, für das **string is space** 1 zurückgibt, sowie „\\0“).


## Veraltete Unterbefehle

Diese Unterbefehle werden derzeit unterstützt, werden aber voraussichtlich in einer künftigen Version wegfallen, weil ihre Funktion entweder praktisch nie genutzt wird oder stark irreführend ist.

[string]{.cmd} [bytelength]{.sub} [string]{.arg}
: Gibt eine dezimale Zeichenkette mit der Anzahl der Bytes zurück, mit der *string* im Speicher dargestellt wird, wenn die Zeichenkette in Tcls internem modifiziertem UTF-8 kodiert ist. Tcl kann für *string* auch andere Kodierungen verwenden und garantiert nicht, für eine bestimmte *string* nur eine einzige Kodierung zu verwenden. Da UTF-8 eine variable Anzahl von Bytes zur Darstellung von Unicode-Zeichen verwendet, ist die Bytelänge im Allgemeinen nicht gleich der Zeichenlänge. Die Fälle, in denen es für ein Skript auf die Bytelänge ankommt, sind selten.

    In fast allen Fällen sollten Sie die Operation **string length** verwenden (auch, um die Länge eines Tcl-Byte-Array-Werts zu bestimmen). Weitere Einzelheiten zur UTF-8-Darstellung finden Sie in der Handbuchseite [Tcl\_NumUtfChars][Utf].

    Formal gibt die Operation **string bytelength** den Inhalt des Feldes *length* der Struktur [Tcl\_Obj][Object] zurück, nachdem [Tcl\_GetString][StringObj] aufgerufen wurde, um sicherzustellen, dass das Feld *bytes* gefüllt ist. Für Tcl-Skripte ist das höchst wahrscheinlich nicht nützlich, da Tcls interne Kodierung kein striktes UTF-8 ist, sondern ein modifiziertes CESU-8 mit einem denormalisierten NUL (identisch mit dem, das Javas Serialisierungsmechanismus an mehreren Stellen verwendet). Dadurch ist eine grundlegende Verarbeitung mit C-Funktionen möglich, die Unicode nicht kennen. Da diese Darstellung immer nur von der Implementierung von Tcl verwendet werden sollte, hat die Anzahl der Bytes, die zum Speichern der Darstellung verwendet werden, sehr geringen Wert (außer für Code von C-Erweiterungen, der zum Zweck der Speicherverwaltung usw. direkten Zugriff hat).

    *Kompatibilitätshinweis:* Dieser Unterbefehl wird wahrscheinlich in einer künftigen Version von Tcl zurückgezogen. Es ist besser, die Zeichenkette mit dem Befehl [encoding convertto][encoding] in eine bekannte Kodierung umzuwandeln und dann **string length** darauf anzuwenden.

    ```
    string length [encoding convertto utf-8 $theString]
    ```

[string]{.cmd} [wordend]{.sub} [string]{.arg} [charIndex]{.arg}
: Gibt den Index des Zeichens unmittelbar nach dem letzten Zeichen des Worts zurück, das das Zeichen *charIndex* von *string* enthält. *charIndex* kann in den unter [String-Indizes] beschriebenen Formen angegeben werden. Als Wort gilt jeder zusammenhängende Bereich aus alphanumerischen Zeichen (Unicode-Buchstaben oder Dezimalziffern) oder Unterstrichen (Unicode-Verbindungssatzzeichen) oder jedes einzelne andere Zeichen.

[string]{.cmd} [wordstart]{.sub} [string]{.arg} [charIndex]{.arg}
: Gibt den Index des ersten Zeichens des Worts zurück, das das Zeichen *charIndex* von *string* enthält. *charIndex* kann in den unter [String-Indizes] beschriebenen Formen angegeben werden. Als Wort gilt jeder zusammenhängende Bereich aus alphanumerischen Zeichen (Unicode-Buchstaben oder Dezimalziffern) oder Unterstrichen (Unicode-Verbindungssatzzeichen) oder jedes einzelne andere Zeichen.


# String-Indizes

Für Indizes in eine Zeichenkette (z. B. bei **string index** oder **string range**) werden die folgenden Formen unterstützt:

*integer*
: Bei jedem Indexwert, der **string is integer -strict** besteht, das Zeichen an diesem ganzzahligen Index (z. B. bezeichnet **2** das „c“ in „abcd“).

**end**
: Das letzte Zeichen der Zeichenkette (z. B. bezeichnet **end** das „d“ in „abcd“).

**end-***N*
: Das letzte Zeichen der Zeichenkette minus den angegebenen ganzzahligen Versatz *N* (z. B. bezeichnet „**end-1**“ das „c“ in „abcd“).

**end+***N*
: Das letzte Zeichen der Zeichenkette plus den angegebenen ganzzahligen Versatz *N* (z. B. bezeichnet „**end+-1**“ das „c“ in „abcd“).

*M***+***N*
: Das Zeichen an dem ganzzahligen Index, der die Summe der ganzzahligen Werte *M* und *N* ist (z. B. bezeichnet „**1+1**“ das „c“ in „abcd“).

*M***-***N*
: Das Zeichen an dem ganzzahligen Index, der die Differenz der ganzzahligen Werte *M* und *N* ist (z. B. bezeichnet „**2-1**“ das „b“ in „abcd“).


In den obigen Angaben enthält der ganzzahlige Wert *M* keinen nachgestellten Leerraum und der ganzzahlige Wert *N* keinen führenden Leerraum.

# Beispiele

Prüft, ob die Zeichenkette in der Variablen *string* ein echtes, nicht leeres Präfix der Zeichenkette **foobar** ist.

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
