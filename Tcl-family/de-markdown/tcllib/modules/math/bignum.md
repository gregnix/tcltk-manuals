---
CommandName: math::bignum
title: math::bignum
ManualSection: n
Version: 3.1.2
TclPart: tcllib
TclDescription: Tcl Math Library
Keywords:
 - bignums
 - math
 - multiprecision
 - tcl
Copyright:
 - Copyright (c) 2004 Salvatore Sanfilippo <antirez at invece dot org>
 - Copyright (c) 2004 Arjen Markus <arjenmarkus at users dot sourceforge dot net>
---

# Name

math::bignum – Ganzzahlen mit beliebiger Genauigkeit

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5 9]{.optlit}
[package]{.cmd} [require]{.sub} [math::bignum]{.lit} [3.1.2]{.optlit}
[::math::bignum::fromstr]{.cmd} [string]{.arg} [radix]{.optarg}
[::math::bignum::tostr]{.cmd} [bignum]{.arg} [radix]{.optarg}
[::math::bignum::sign]{.cmd} [bignum]{.arg}
[::math::bignum::abs]{.cmd} [bignum]{.arg}
[::math::bignum::cmp]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::iszero]{.cmd} [bignum]{.arg}
[::math::bignum::lt]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::le]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::gt]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::ge]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::eq]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::ne]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::isodd]{.cmd} [bignum]{.arg}
[::math::bignum::iseven]{.cmd} [bignum]{.arg}
[::math::bignum::add]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::sub]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::mul]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::divqr]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::div]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::rem]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::mod]{.cmd} [n]{.arg} [m]{.arg}
[::math::bignum::pow]{.cmd} [base]{.arg} [exp]{.arg}
[::math::bignum::powm]{.cmd} [base]{.arg} [exp]{.arg} [m]{.arg}
[::math::bignum::sqrt]{.cmd} [bignum]{.arg}
[::math::bignum::rand]{.cmd} [bits]{.arg}
[::math::bignum::lshift]{.cmd} [bignum]{.arg} [bits]{.arg}
[::math::bignum::rshift]{.cmd} [bignum]{.arg} [bits]{.arg}
[::math::bignum::bitand]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::bitor]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::bitxor]{.cmd} [a]{.arg} [b]{.arg}
[::math::bignum::setbit]{.cmd} [bignumVar]{.arg} [bit]{.arg}
[::math::bignum::clearbit]{.cmd} [bignumVar]{.arg} [bit]{.arg}
[::math::bignum::testbit]{.cmd} [bignum]{.arg} [bit]{.arg}
[::math::bignum::bits]{.cmd} [bignum]{.arg}
:::

# Beschreibung

Das Paket „bignum“ erweitert die Programmiersprache Tcl um Funktionen für die Ganzzahlberechnung mit beliebiger Genauigkeit (auch als „Big Numbers“ bezeichnet). „Big Numbers“ werden intern als Tcl-Listen dargestellt: Dieses Paket bietet eine Reihe von Prozeduren, die auf diese interne Darstellung zugreifen, um:

- mathematische Operationen durchführen

- Bignums von der internen Darstellung in eine Zeichenkette mit der gewünschten Basis umwandeln und umgekehrt.


Die beiden Konstanten „0“ und „1“ werden jedoch automatisch in die interne Darstellung umgewandelt, um den Vergleich einer Zahl mit Null oder die Inkrementierung einer großen Zahl zu vereinfachen.

Die Bignum-Schnittstelle ist undurchsichtig, sodass Operationen mit Bignums, die nicht von Prozeduren dieses Pakets zurückgegeben (sondern manuell erstellt) werden, zu nicht spezifiziertem Verhalten führen können. Es ist unbedenklich, Bignums als reine Werte zu behandeln; daher besteht keine Notwendigkeit, ein Bignum freizugeben oder es über eine spezielle Operation zu duplizieren.

# Beispiele

In diesem Abschnitt werden einige einfache Beispiele vorgestellt. Da diese Bibliothek lediglich dazu dient, mathematische Operationen durchzuführen, sind Beispiele möglicherweise der einfachste Weg, um den Umgang damit zu erlernen. Informationen zu den einzelnen Prozeduren finden Sie im Abschnitt „API“ dieser Manpage.

```
    package require math::bignum

    # Multiplication of two bignums
    set a [::math::bignum::fromstr 88888881111111]
    set b [::math::bignum::fromstr 22222220000000]
    set c [::math::bignum::mul $a $b]
    puts [::math::bignum::tostr $c] ; # => will output 1975308271604953086420000000
    set c [::math::bignum::sqrt $c]
    puts [::math::bignum::tostr $c] ; # => will output 44444440277777

    # From/To string conversion in different radix
    set a [::math::bignum::fromstr 1100010101010111001001111010111 2]
    puts [::math::bignum::tostr $a 16] ; # => will output 62ab93d7

    # Factorial example
    proc fact n {
        # fromstr is not needed for 0 and 1
        set z 1
        for {set i 2} {$i <= $n} {incr i} {
            set z [::math::bignum::mul $z [::math::bignum::fromstr $i]]
        }
        return $z
    }

    puts [::math::bignum::tostr [fact 100]]
```

# API

**::math::bignum::fromstr** *string* ?*radix*?
: Konvertiert *string* in eine Bignum-Zahl. Wird *radix* weggelassen oder ist es gleich Null, wird die Zeichenkette als Hexadezimalzahl interpretiert, wenn ihr *0x* vorangestellt ist, als Oktalzahl, wenn ihr *ox* vorangestellt ist, als Binärzahl, wenn ihr *bx* vorangestellt ist, und andernfalls als Zahl zur Basis 10. Wenn stattdessen das Argument *radix* im Bereich von 2 bis 36 festgelegt wird, wird die Zeichenkette *string* in der angegebenen Basis interpretiert. Beachten Sie, dass diese Konvertierung für zwei Konstanten nicht erforderlich ist: *0* und *1*. (siehe Beispiele)

**::math::bignum::tostr** *bignum* ?*radix*?
: Konvertiert *bignum* in eine Zeichenkette, die die Zahl in der angegebenen Basis darstellt. Wird *radix* weggelassen, gilt als Standardwert 10.

**::math::bignum::sign** *bignum*
: Gibt das Vorzeichen der Bignum-Zahl zurück. Die Prozedur gibt 0 zurück, wenn die Zahl positiv ist, und 1, wenn sie negativ ist.

**::math::bignum::abs** *bignum*
: Gibt den Betrag (Absolutwert) der Bignum-Zahl zurück.

**::math::bignum::cmp** *a* *b*
: Vergleicht die beiden Bignums a und b und gibt *0* zurück, wenn *a == b* gilt, *1*, wenn *a > b* gilt, und *-1*, wenn *a < b* gilt.

**::math::bignum::iszero** *bignum*
: Gibt „true“ zurück, wenn der Wert von *bignum* Null ist; andernfalls wird „false“ zurückgegeben.

**::math::bignum::lt** *a* *b*
: Gibt „true“ zurück, wenn *a < b* ist, andernfalls „false“.

**::math::bignum::le** *a* *b*
: Gibt „true“ zurück, wenn *a <= b* gilt, andernfalls „false“.

**::math::bignum::gt** *a* *b*
: Gibt „true“ zurück, wenn *a > b* ist, andernfalls „false“.

**::math::bignum::ge** *a* *b*
: Gibt „true“ zurück, wenn *a >= b* gilt, andernfalls „false“.

**::math::bignum::eq** *a* *b*
: Gibt „true“ zurück, wenn *a == b* gilt, andernfalls „false“.

**::math::bignum::ne** *a* *b*
: Gibt „true“ zurück, wenn *a != b* gilt, andernfalls „false“.

**::math::bignum::isodd** *bignum*
: Gibt „true“ zurück, wenn *bignum* ungerade ist.

**::math::bignum::iseven** *bignum*
: Gibt „true“ zurück, wenn *bignum* gerade ist.

**::math::bignum::add** *a* *b*
: Gibt die Summe der beiden Bignums *a* und *b* zurück.

**::math::bignum::sub** *a* *b*
: Gibt die Differenz der beiden Bignums *a* und *b* zurück.

**::math::bignum::mul** *a* *b*
: Gibt das Produkt der beiden Bignums *a* und *b* zurück. Die Implementierung verwendet die Karatsuba-Multiplikation, wenn beide Zahlen größer als ein vorgegebener Schwellenwert sind; andernfalls kommt der direkte Algorithmus zum Einsatz.

**::math::bignum::divqr** *a* *b*
: Gibt eine Liste mit zwei Elementen zurück, deren erstes Element den Quotienten der Division der beiden Bignums *a* und *b* enthält und deren zweites Element den Rest dieser Division enthält.

**::math::bignum::div** *a* *b*
: Gibt den Quotienten der Division der beiden Bignums *a* und *b* zurück.

**::math::bignum::rem** *a* *b*
: Gibt den Rest der Division der beiden Bignums *a* und *b* zurück.

**::math::bignum::mod** *n* *m*
: Gibt *n* modulo *m* zurück. Diese Operation wird als modulare Reduktion bezeichnet.

**::math::bignum::pow** *base* *exp*
: Gibt *base* hoch *exp* zurück.

**::math::bignum::powm** *base* *exp* *m*
: Gibt *base* hoch *exp* modulo *m* zurück. Diese Funktion wird häufig im Bereich der Kryptografie verwendet.

**::math::bignum::sqrt** *bignum*
: Gibt den ganzzahligen Teil der Quadratwurzel von *bignum* zurück.

**::math::bignum::rand** *bits*
: Gibt eine Zufallszahl mit einer Länge von höchstens *bits* Bits zurück. Die zurückgegebene Zahl wird intern mithilfe der Tcl-Funktion *expr rand()* generiert und ist nicht geeignet, wenn eine nicht erratbare, kryptografisch sichere Zufallszahl benötigt wird.

**::math::bignum::lshift** *bignum* *bits*
: Gibt das Ergebnis der Linksverschiebung der binären Darstellung von *bignum* um *bits* Stellen nach links zurück. Dies entspricht einer Multiplikation mit 2^*bits*, ist jedoch wesentlich schneller.

**::math::bignum::rshift** *bignum* *bits*
: Gibt das Ergebnis einer Rechtsverschiebung der binären Darstellung von *bignum* um *bits* Stellen nach rechts zurück. Dies entspricht einer Division durch *2^bits*, ist jedoch wesentlich schneller.

**::math::bignum::bitand** *a* *b*
: Gibt das Ergebnis einer bitweisen UND-Operation mit a und b zurück. Die Operation ist auf positive Zahlen beschränkt, einschließlich Null. Werden negative Zahlen als Argumente übergeben, ist das Ergebnis undefiniert.

**::math::bignum::bitor** *a* *b*
: Gibt das Ergebnis einer bitweisen ODER-Operation zwischen a und b zurück. Die Operation ist auf positive Zahlen beschränkt, einschließlich Null. Werden negative Zahlen als Argumente übergeben, ist das Ergebnis undefiniert.

**::math::bignum::bitxor** *a* *b*
: Gibt das Ergebnis einer bitweisen XOR-Operation zwischen a und b zurück. Die Operation ist auf positive Zahlen, einschließlich Null, beschränkt. Werden negative Zahlen als Argumente übergeben, ist das Ergebnis undefiniert.

**::math::bignum::setbit** *bignumVar* *bit*
: Setzt das Bit an der Position *bit* in der in der Variablen *bignumVar* gespeicherten Bignum-Zahl auf 1. Bit 0 ist das niedrigstwertige Bit.

**::math::bignum::clearbit** *bignumVar* *bit*
: Setzt das Bit an der Position *bit* in der in der Variablen *bignumVar* gespeicherten Bignum-Zahl auf 0. Bit 0 ist das niedrigstwertige Bit.

**::math::bignum::testbit** *bignum* *bit*
: Gibt „true“ zurück, wenn das Bit an der Position *bit* von *bignum* gesetzt ist; andernfalls wird „false“ zurückgegeben. Liegt *bit* außerhalb des zulässigen Bereichs, wird es als auf Null gesetzt betrachtet.

**::math::bignum::bits** *bignum*
: Gibt die Anzahl der Bits zurück, die zur Darstellung von bignum zur Basis 2 erforderlich sind.


# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *math :: bignum* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Mathematik

# Copyright

```
Copyright (c) 2004 Salvatore Sanfilippo <antirez at invece dot org>
Copyright (c) 2004 Arjen Markus <arjenmarkus at users dot sourceforge dot net>
```
