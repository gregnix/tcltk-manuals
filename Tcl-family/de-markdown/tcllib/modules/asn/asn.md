---
CommandName: asn
title: asn
ManualSection: n
Version: 0.8
TclPart: tcllib
TclDescription: ASN.1 processing
Keywords:
 - asn
 - ber
 - cer
 - der
 - internet
 - protocol
 - x.208
 - x.209
Copyright:
 - Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
 - Copyright (c) 2004 Jochen Loewer <loewerj@web.de>
 - Copyright (c) 2004-2011 Michael Schlenker <mic42@users.sourceforge.net>
---

# Name

asn – ASN.1-BER-Kodierer/Dekodierer für die Kodierung und Dekodierung

# Übersicht

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit}
[package]{.cmd} [require]{.sub} [asn]{.lit} [0.8.5]{.optlit}
[::asn::asnSequence]{.cmd} [evalue]{.optdot}
[::asn::asnSequenceFromList]{.cmd} [elist]{.arg}
[::asn::asnSet]{.cmd} [evalue]{.optdot}
[::asn::asnSetFromList]{.cmd} [elist]{.arg}
[::asn::asnApplicationConstr]{.cmd} [appNumber]{.arg} [evalue]{.optdot}
[::asn::asnApplication]{.cmd} [appNumber]{.arg} [data]{.arg}
[::asn::asnChoice]{.cmd} [appNumber]{.arg} [evalue]{.optdot}
[::asn::asnChoiceConstr]{.cmd} [appNumber]{.arg} [evalue]{.optdot}
[::asn::asnInteger]{.cmd} [number]{.arg}
[::asn::asnEnumeration]{.cmd} [number]{.arg}
[::asn::asnBoolean]{.cmd} [bool]{.arg}
[::asn::asnContext]{.cmd} [context]{.arg} [data]{.arg}
[::asn::asnContextConstr]{.cmd} [context]{.arg} [evalue]{.optdot}
[::asn::asnObjectIdentifier]{.cmd} [idlist]{.arg}
[::asn::asnUTCTime]{.cmd} [utcstring]{.arg}
[::asn::asnNull]{.cmd}
[::asn::asnBitString]{.cmd} [string]{.arg}
[::asn::asnOctetString]{.cmd} [string]{.arg}
[::asn::asnNumericString]{.cmd} [string]{.arg}
[::asn::asnPrintableString]{.cmd} [string]{.arg}
[::asn::asnIA5String]{.cmd} [string]{.arg}
[::asn::asnBMPString]{.cmd} [string]{.arg}
[::asn::asnUTF8String]{.cmd} [string]{.arg}
[::asn::asnString]{.cmd} [string]{.arg}
[::asn::defaultStringType]{.cmd} [type]{.optarg}
[::asn::asnPeekByte]{.cmd} [dataVar]{.arg} [byteVar]{.arg}
[::asn::asnGetLength]{.cmd} [dataVar]{.arg} [lengthVar]{.arg}
[::asn::asnGetResponse]{.cmd} [chan]{.arg} [dataVar]{.arg}
[::asn::asnGetInteger]{.cmd} [dataVar]{.arg} [intVar]{.arg}
[::asn::asnGetEnumeration]{.cmd} [dataVar]{.arg} [enumVar]{.arg}
[::asn::asnGetOctetString]{.cmd} [dataVar]{.arg} [stringVar]{.arg}
[::asn::asnGetString]{.cmd} [dataVar]{.arg} [stringVar]{.arg} [typeVar]{.optarg}
[::asn::asnGetNumericString]{.cmd} [dataVar]{.arg} [stringVar]{.arg}
[::asn::asnGetPrintableString]{.cmd} [dataVar]{.arg} [stringVar]{.arg}
[::asn::asnGetIA5String]{.cmd} [dataVar]{.arg} [stringVar]{.arg}
[::asn::asnGetBMPString]{.cmd} [dataVar]{.arg} [stringVar]{.arg}
[::asn::asnGetUTF8String]{.cmd} [dataVar]{.arg} [stringVar]{.arg}
[::asn::asnGetUTCTime]{.cmd} [dataVar]{.arg} [utcVar]{.arg}
[::asn::asnGetBitString]{.cmd} [dataVar]{.arg} [bitsVar]{.arg}
[::asn::asnGetObjectIdentifier]{.cmd} [dataVar]{.arg} [oidVar]{.arg}
[::asn::asnGetBoolean]{.cmd} [dataVar]{.arg} [boolVar]{.arg}
[::asn::asnGetNull]{.cmd} [dataVar]{.arg}
[::asn::asnGetSequence]{.cmd} [dataVar]{.arg} [sequenceVar]{.arg}
[::asn::asnGetSet]{.cmd} [dataVar]{.arg} [setVar]{.arg}
[::asn::asnGetApplication]{.cmd} [dataVar]{.arg} [appNumberVar]{.arg} [contentVar]{.optarg} [encodingTypeVar]{.optarg}
[::asn::asnGetContext]{.cmd} [dataVar]{.arg} [contextNumberVar]{.arg} [contentVar]{.optarg} [encodingTypeVar]{.optarg}
[::asn::asnPeekTag]{.cmd} [dataVar]{.arg} [tagVar]{.arg} [tagtypeVar]{.arg} [constrVar]{.arg}
[::asn::asnTag]{.cmd} [tagnumber]{.arg} [class]{.optarg} [tagstyle]{.optarg}
[::asn::asnRetag]{.cmd} [dataVar]{.arg} [newTag]{.arg}
:::

# Beschreibung

Das Paket **asn** stellt *teilweise* Dekodier- und Kodierbefehle für BER-kodierte ASN.1-Daten bereit. Es kann auch zur Dekodierung von DER verwendet werden, bei dem es sich um eine eingeschränkte Teilmenge von BER handelt.

ASN.1 ist ein Standard für die *Abstract Syntax Notation*, und BER sind die dazugehörigen *Basic Kodierungen*.

Weitere Informationen zu dieser Norm finden Sie unter <http://asn1.elibel.tm.fr/en/standards/index.htm>.

Siehe auch <http://luca.ntop.org/Teaching/Appunti/asn1.html> für *A Layman’s Guide to a Subset of ASN.1, BER, and DER*, einen technischen Hinweis der RSA Laboratories von Burton S. Kaliski Jr. (Überarbeitet am 1. November 1993). Eine Textversion dieses Hinweises ist Teil der Modulquellen und sollte von jedem Implementierer gelesen werden.

# API

## Encoder

**::asn::asnSequence** ?*evalue ...*?
: Nimmt null oder mehrere kodierte Werte entgegen, packt diese zu einer ASN-Sequenz und gibt deren kodierte binäre Form zurück.

**::asn::asnSequenceFromList** *elist*
: Nimmt eine Liste kodierter Werte entgegen, packt diese zu einer ASN-Sequenz und gibt deren kodierte Binärform zurück.

**::asn::asnSet** ?*evalue ...*?
: Nimmt null oder mehrere kodierte Werte entgegen, packt sie zu einem ASN-Set zusammen und gibt dessen kodierte binäre Form zurück.

**::asn::asnSetFromList** *elist*
: Nimmt eine Liste kodierter Werte entgegen, packt diese zu einem ASN-Set zusammen und gibt dessen kodierte binäre Form zurück.

**::asn::asnApplicationConstr** *appNumber* ?*evalue ...*?
: Nimmt null oder mehrere kodierte Werte entgegen, packt diese in ein ASN-Anwendungskonstrukt und gibt dessen kodierte Binärform zurück.

**::asn::asnApplication** *appNumber* *data*
: Nimmt einen einzelnen kodierten Wert *data*, packt ihn in ein ASN-Anwendungskonstrukt und gibt dessen kodierte binäre Form zurück.

**::asn::asnChoice** *appNumber* ?*evalue ...*?
: Nimmt null oder mehrere kodierte Werte entgegen, packt diese in ein ASN-Choice-Konstrukt und gibt dessen kodierte binäre Form zurück.

**::asn::asnChoiceConstr** *appNumber* ?*evalue ...*?
: Nimmt null oder mehrere kodierte Werte entgegen, packt diese in ein ASN-Choice-Konstrukt und gibt dessen kodierte binäre Form zurück.

**::asn::asnInteger** *number*
: Gibt die kodierte Form der angegebenen Ganzzahl *number* zurück.

**::asn::asnEnumeration** *number*
: Gibt die kodierte Form der angegebenen Enumerations-ID *number* zurück.

**::asn::asnBoolean** *bool*
: Gibt die kodierte Form des angegebenen booleschen Werts *bool* zurück.

**::asn::asnContext** *context* *data*
: Nimmt einen kodierten Wert entgegen und packt ihn zu einem konstruierten Wert mit dem Anwendungs-Tag, der *context*-Nummer.

**::asn::asnContextConstr** *context* ?*evalue ...*?
: Nimmt null oder mehrere kodierte Werte entgegen und packt diese zu einem zusammengesetzten Wert mit einem Anwendungs-Tag, der *context*-Nummer, zusammen.

**::asn::asnObjectIdentifier** *idlist*
: Nimmt eine Liste mit mindestens zwei Ganzzahlen entgegen, die einen Objektkennungswert (OID) beschreiben, und gibt den kodierten Wert zurück.

**::asn::asnUTCTime** *utcstring*
: Gibt die kodierte Form der angegebenen UTC-Zeitangabe zurück.

**::asn::asnNull**
: Gibt die NULL-Kodierung zurück.

**::asn::asnBitString** *string*
: Gibt die kodierte Form der angegebenen *string* zurück.

**::asn::asnOctetString** *string*
: Gibt die kodierte Form der angegebenen *string* zurück.

**::asn::asnNumericString** *string*
: Gibt den als ASN.1-NumericString kodierten *string* zurück. Löst einen Fehler aus, wenn der *string* andere Zeichen als Dezimalziffern und Leerzeichen enthält.

**::asn::asnPrintableString** *string*
: Gibt die Kodierung von *string* als ASN.1-PrintableString zurück. Löst einen Fehler aus, wenn *string* Zeichen enthält, die für den Datentyp „Printable String“ nicht zulässig sind. Die zulässigen Zeichen sind A–Z, a–z, 0–9, Leerzeichen, Apostroph, Doppelpunkt, Klammern, Pluszeichen, Minuszeichen, Komma, Punkt, Schrägstrich, Fragezeichen und das Gleichheitszeichen.

**::asn::asnIA5String** *string*
: Gibt den als ASN.1 IA5String kodierten *string* zurück. Löst einen Fehler aus, wenn der *string* Zeichen enthält, die außerhalb des US-ASCII-Zeichenbereichs liegen.

**::asn::asnBMPString** *string*
: Gibt die als ASN.1-Zeichenkette der Basic Multilingual Plane durchführte Kodierung der *string* zurück (die im Wesentlichen Big-Endian-UCS2 entspricht).

**::asn::asnUTF8String** *string*
: Gibt die als UTF-8-Kodierung kodierte *string* zurück. Es gibt Hinweise darauf, dass einige ältere Anwendungen, wie beispielsweise die Windows CryptoAPI, mit UTF-8-Zeichenketten möglicherweise nicht korrekt funktionieren. Am sichersten ist es daher, BMPStrings zu verwenden.

**::asn::asnString** *string*
: Gibt eine kodierte Form von *string* zurück, wobei der möglichst restriktivste ASN.1-Zeichenkettentyp ausgewählt wird. Wenn die Zeichenkette Nicht-ASCII-Zeichen enthält, stehen mehrere Zeichenkettentypen zur Auswahl. Siehe **::asn::defaultStringType**.

**::asn::defaultStringType** ?*type*?
: Wählt den Zeichenkettentyp aus, der für die Kodierung von Nicht-ASCII-Zeichenketten verwendet werden soll. Gibt den aktuellen Standardwert zurück, wenn die Funktion ohne Argument aufgerufen wird. Wird das Argument *type* übergeben, sollte es entweder **UTF8** oder **BMP** lauten, um jeweils UTF8String oder BMPString auszuwählen.


## Decoder

Allgemeine Hinweise:

1. Nahezu alle Getter-Befehle (Decoder) nehmen zwei Argumente entgegen. Bei diesen Argumenten handelt es sich um Namen von Variablen, *mit Ausnahme* von **::asn::asnGetResponse**. Die Variable *dataVar* enthält die zu dekodierenden, kodierten ASN-Werte. Wenn ein Wert-Getter (Dekoder) aufgerufen wird, wird der Wert in der zweiten Variablen gespeichert, und die verbleibende Eingabe wird wieder in der ersten Variable *dataVar* gespeichert.

2. Beim Abrufen (Dekodieren) wird zunächst die Variable *dataVar* geändert, bevor der dekodierte Wert in der zweiten Variablen gespeichert wird. Das bedeutet: Wenn sich beide Argumente auf dieselbe Variable beziehen, enthält diese nach dem Aufruf stets den dekodierten Wert und nicht den Rest der Eingabe.


**::asn::asnPeekByte** *dataVar* *byteVar*
: Gibt eine Kopie des ersten Bytes der Daten zurück, ohne *dataVar* zu verändern. Dies kann verwendet werden, um auf implizite Tags zu prüfen.

**::asn::asnGetLength** *dataVar* *lengthVar*
: Dekodiert die Längenangaben für einen Block von BER-Daten. Der Tag muss zuvor aus den Daten entfernt worden sein.

**::asn::asnGetResponse** *chan* *dataVar*
: Liest eine kodierte ASN-*Sequenz* aus dem Kanal *chan* ein und speichert sie in der Variable *dataVar*.

**::asn::asnGetInteger** *dataVar* *intVar*
: Dekodiert den ganzzahligen Wert, der am Anfang der in der Variable *dataVar* gespeicherten Daten kodiert ist. Die Ganzzahl wird in der Variable *intVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für den nächsten zu dekodierenden Wert bereit sind. Wenn der Wert am Anfang keine kodierte Ganzzahl ist, wird ein Fehler ausgelöst.

**::asn::asnGetEnumeration** *dataVar* *enumVar*
: Dekodiert den Wert der Enumerations-ID, der am Anfang der in der Variable *dataVar* gespeicherten Daten kodiert ist. Die Enumerations-ID wird in der Variable *enumVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für die Dekodierung des nächsten Werts bereit sind. Wenn der Wert am Anfang keine kodierte Enumerations-ID ist, wird ein Fehler ausgelöst.

**::asn::asnGetOctetString** *dataVar* *stringVar*
: Dekodiert den Wert der Zeichenfolge, der am Anfang der in der Variable *dataVar* gespeicherten Daten durch Kodierung kodiert ist. Die Zeichenfolge wird in der Variable *stringVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für den nächsten zu dekodierenden Wert bereit sind. Wenn der Wert am Anfang keine kodierte Zeichenkette ist, wird ein Fehler ausgelöst.

**::asn::asnGetString** *dataVar* *stringVar* ?*typeVar*?
: Dekodiert den lesbaren Zeichenfolgenwert, der am Anfang der in der Variable *dataVar* gespeicherten Daten durch Kodierung kodiert ist. Die Zeichenfolge wird in der Variable *stringVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für die Dekodierung des nächsten Werts bereit sind. Wenn der Wert am Anfang keine kodierte Zeichenkette ist, wird ein Fehler ausgelöst.

    Hierbei handelt es sich um eine Komfortfunktion, die in der Lage ist, alle unterstützten ASN.1-Zeichenkettentypen automatisch zu unterscheiden und den Eingabewert entsprechend zu konvertieren.

    Die typspezifischen Konvertierungsbefehle finden Sie weiter unten unter **::asn::asnGetPrintableString**, **::asnGetIA5String** usw.

    Wenn das optionale dritte Argument *typeVar* angegeben wird, wird der Typ der eingehenden Zeichenkette in der damit benannten Variable gespeichert.

    Die Funktion löst den Fehler „Ungültiger Name des Befehls asnGetSome**UnsupportedString**“ aus, wenn auf den nicht unterstützten Zeichenfolgen-Typ **Unsupported** gestoßen wird. Wenn es nötig ist, können Sie die entsprechende Funktion „asn::asnGetSome**UnsupportedString**“ in Ihrer Anwendung erstellen.

**::asn::asnGetNumericString** *dataVar* *stringVar*
: Dekodiert den numerischen Zeichenfolgenwert, der am Anfang der in der Variable *dataVar* gespeicherten Daten durch Kodierung kodiert ist. Die numerische Zeichenfolge wird in der Variable *stringVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für den nächsten zu dekodierenden Wert bereit sind. Wenn der Wert am Anfang keine kodierte numerische Zeichenkette ist, wird ein Fehler ausgelöst.

**::asn::asnGetPrintableString** *dataVar* *stringVar*
: Dekodiert den druckbaren Zeichenfolgenwert, der am Anfang der in der Variable *dataVar* gespeicherten Daten kodiert ist. Die druckbare Zeichenfolge wird in der Variable *stringVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für den nächsten zu dekodierenden Wert bereit sind. Wenn der Wert am Anfang keine kodierte druckbare Zeichenkette ist, wird ein Fehler ausgelöst.

**::asn::asnGetIA5String** *dataVar* *stringVar*
: Dekodiert den IA5-Zeichenfolgenwert (US-ASCII), der am Anfang der in der Variable *dataVar* gespeicherten Daten kodiert ist. Die IA5-Zeichenkette wird in der Variable *stringVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für die Dekodierung des nächsten Werts bereit sind. Wenn der Wert am Anfang keine kodierte IA5-Zeichenkette ist, wird ein Fehler ausgelöst.

**::asn::asnGetBMPString** *dataVar* *stringVar*
: Dekodiert den BMP-Zeichenfolgenwert (Zwei-Byte-Unicode – UCS2), der am Anfang der in der Variable *dataVar* gespeicherten Daten kodiert ist. Die BMP-Zeichenkette wird in eine korrekte Tcl-Zeichenkette umgewandelt, die anschließend in der Variable *stringVar* gespeichert wird; die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für die Dekodierung des nächsten Werts bereit sind. Wenn der Wert am Anfang keine kodierte BMP-Zeichenkette ist, wird ein Fehler ausgelöst.

**::asn::asnGetUTF8String** *dataVar* *stringVar*
: Dekodiert den UTF-8-Zeichenfolgenwert, der am Anfang der in der Variablen *dataVar* gespeicherten Daten durch Kodierung erzeugt wurde. Die UTF-8-Zeichenkette wird in eine korrekte Tcl-Zeichenkette umgewandelt, die anschließend in der Variable *stringVar* gespeichert wird; die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für die Dekodierung des nächsten Werts bereit ist. Wenn der Wert am Anfang keine kodierte UTF-8-Zeichenkette ist, wird ein Fehler ausgelöst.

**::asn::asnGetUTCTime** *dataVar* *utcVar*
: Dekodiert den am Anfang der in der Variable *dataVar* gespeicherten Daten durchführenden Prozess der Kodierung des UTC-Zeitwerts. Der UTC-Zeitwert wird in der Variable *utcVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für die Dekodierung des nächsten Werts bereit sind. Der in *utcVar* gespeicherte Wert ist eine Zeichenkette; um einen tatsächlichen Zeitwert zu erhalten, verwenden Sie den Befehl **clock scan**. Wenn der Wert am Anfang kein kodierter UTC-Zeitwert ist, wird ein Fehler ausgelöst.

**::asn::asnGetBitString** *dataVar* *bitsVar*
: Dekodiert den Wert der Bitzeichenfolge, der am Anfang der in der Variable *dataVar* gespeicherten Daten kodiert ist. Die Bitzeichenfolge wird in der Variable *bitsVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für den nächsten zu dekodierenden Wert bereit sind. Der in *bitsVar* gespeicherte Wert ist eine Zeichenkette, die ausschließlich die Zeichen **"0"** und **"1"** enthält. Wenn der Wert am Anfang keine kodierte Bitfolge ist, wird ein Fehler ausgelöst.

**::asn::asnGetObjectIdentifier** *dataVar* *oidVar*
: Dekodiert den Wert des Objektidentifikators (OID), der am Anfang der in der Variablen *dataVar* gespeicherten Daten kodiert ist. Die OID wird in der Variablen *oidVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für die Dekodierung des nächsten Werts bereit sind. Der in *oidVar* gespeicherte Wert ist eine Liste von Ganzzahlen. Wenn der Wert am Anfang kein kodierter OID ist, wird ein Fehler ausgelöst.

**::asn::asnGetBoolean** *dataVar* *boolVar*
: Dekodiert den am Anfang der in der Variablen *dataVar* gespeicherten Daten durchgeführten Booleschen Wert. Der Boolesche Wert wird in der Variablen *boolVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für die Dekodierung des nächsten Werts bereit sind. Der in *boolVar* gespeicherte Wert lautet entweder **0** oder **1**. Wenn der Wert am Anfang kein kodierter Boolescher Wert ist, wird ein Fehler ausgelöst.

**::asn::asnGetNull** *dataVar*
: Dekodiert den am Anfang der in der Variable *dataVar* gespeicherten Daten kodierten NULL-Wert und entfernt die dekodierten Bytes vom Anfang der Daten in *dataVar*, sodass diese für die Dekodierung des nächsten Werts bereit sind. Wenn der Wert am Anfang kein kodierter NULL-Wert ist, wird ein Fehler ausgelöst.

**::asn::asnGetSequence** *dataVar* *sequenceVar*
: Dekodiert den am Anfang der in der Variable *dataVar* gespeicherten Daten durch Kodierung erzeugte ASN-Sequenzwert. Die ASN-Sequenz wird in der Variable *sequenceVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass der nächste Wert dekodiert werden kann. Wenn der Wert am Anfang keine kodierte ASN-Sequenz ist, wird ein Fehler ausgelöst.

    Der Wert in *sequenceVar* ist binär kodiert und muss gemäß den Definitionen der Sequenz mithilfe der anderen „asnGet…“-Befehle des Dekodierers weiter dekodiert werden.

**::asn::asnGetSet** *dataVar* *setVar*
: Dekodiert den am Anfang der in der Variable *dataVar* gespeicherten Daten durchführenden Prozess der Kodierung des ASN-Sets. Das ASN-Set wird in der Variable *setVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für die Dekodierung des nächsten Werts bereit sind. Wenn der Wert am Anfang kein kodierter ASN-Satz ist, wird ein Fehler ausgelöst.

    Der Wert in *setVar* ist binär kodiert und muss gemäß den Definitionen der Sequenz mithilfe der anderen „asnGet…“-Befehle des Dekodierers weiter dekodiert werden.

**::asn::asnGetApplication** *dataVar* *appNumberVar* ?*contentVar*? ?*encodingTypeVar*?
: Dekodiert den Wert des ASN-Anwendungskonstrukts, der am Anfang der in der Variablen *dataVar* gespeicherten Daten kodiert ist. Die ID des ASN-Anwendungskonstrukts wird in der Variablen *appNumberVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass der nächste Wert dekodiert werden kann. Wenn der Wert am Anfang kein kodiertes ASN-Anwendungskonstrukt ist, wird ein Fehler ausgelöst.

    Wenn eine *contentVar* festgelegt ist, place alle mit dem ASN-Anwendungskonstrukt verbundenen Daten in der genannten Variable in binärer Form, die mit den Dekodierbefehlen dieses Pakets verarbeitet werden kann.

    Wenn eine *encodingTypeVar* festgelegt wird, wird diese Variable auf **1** gesetzt, wenn es sich um eine konstruierte Kodierung handelt, und auf **0**, wenn es sich um eine primitive Kodierung handelt.

    Ohne die optionalen Argumente obliegt es dem Aufrufer, den Rest des ASN-Anwendungskonstrukts auf der Grundlage der von diesem Befehl abgerufenen ID mithilfe der Decodierbefehle des Pakets zu decodieren.

**::asn::asnGetContext** *dataVar* *contextNumberVar* ?*contentVar*? ?*encodingTypeVar*?
: Dekodiert das ASN-Kontext-Tag-Konstrukt, das am Anfang der in der Variable *dataVar* gespeicherten Daten durchgeführt wird. Die ID des ASN-Kontext-Tag-Konstrukts wird in der Variable *contextNumberVar* gespeichert, und die dekodierten Bytes werden vom Anfang der Daten in *dataVar* entfernt, sodass diese für die Dekodierung des nächsten Werts bereit sind. Wenn der Wert am Anfang kein kodiertes ASN-Kontext-Tag-Konstrukt ist, wird ein Fehler ausgelöst.

    Wenn eine *contentVar* festgelegt wird, so place alle mit dem ASN-Kontext-Tag-Konstrukt verbundenen Daten in der genannten Variable in binärer Form, die mit den Paketbefehlen verarbeitet werden kann.

    Wenn eine *encodingTypeVar* festgelegt wird, wird diese Variable auf **1** gesetzt, wenn es sich um eine konstruierte Kodierung handelt, und auf **0**, wenn es sich um eine primitive Kodierung handelt.

    Ohne die optionalen Argumente obliegt es dem Aufrufer, den Rest des ASN-Kontext-Tag-Konstrukts auf der Grundlage der von diesem Befehl abgerufenen ID mithilfe der Decoder-Befehle des Pakets zu dekodieren.


## Umgang mit Tags

Wenn Sie mit ASN.1 arbeiten, müssen Sie häufig getaggte Werte dekodieren, deren Tag sich vom universellen Tag eines Typs unterscheidet. In diesen Fällen müssen Sie, um den Wert zu dekodieren, das Tag durch das universelle Tag des Typs ersetzen. Um einen getaggten Wert zu dekodieren, verwenden Sie **::asn::asnRetag**, um das Tag in einen geeigneten Typ umzuwandeln, sodass Sie einen der Dekodierer für primitive Werte nutzen können. Zu diesem Zweck stellt das Paket drei Hilfsfunktionen bereit:

**::asn::asnPeekTag** *dataVar* *tagVar* *tagtypeVar* *constrVar*
: Mit dem Befehl **::asn::asnPeekTag** können Sie einen Blick auf die Daten werfen und den Wert des Tags entschlüsseln, ohne ihn aus den Daten zu entfernen. Die Variable *tagVar* wird auf die Tag-Nummer gesetzt. Die Variable *tagtypeVar* wird auf die Klasse des Tags gesetzt, die einer der folgenden Werte sein kann: **UNIVERSAL**, **CONTEXT**, **APPLICATION** oder **PRIVATE**. Die Variable *constrVar* wird auf 1 gesetzt, wenn das Tag für einen zusammengesetzten Wert steht, oder auf 0 für einen primitiven Wert. Der Befehl gibt die Länge des Tags zurück.

**::asn::asnTag** *tagnumber* ?*class*? ?*tagstyle*?
: Der Befehl **::asn::asnTag** dient zum Erstellen eines Tag-Werts. Die *tagnumber* legt die Nummer des Tags fest. Wenn angegeben, muss die *class* des Tags einer der folgenden Werte sein: **UNIVERSAL**, **CONTEXT**, **APPLICATION** oder **PRIVATE**; oder lediglich der erste Buchstabe als Abkürzung (**U**, **C**, **A** oder **P**). Die Standardklasse ist **UNIVERSAL**. Wenn angegeben, muss der *tagstyle* bei einer konstruierten Kodierung entweder **C** oder **1** lauten, bei einer primitiven Kodierung hingegen **P** oder **0**. Der Standardwert ist **P**. (Die Verwendung von **1** und **0** erleichtert die Nutzung dieses Befehls mit den von **::asn::asnPeekTag** gegebenen Werten.)

**::asn::asnRetag** *dataVar* *newTag*
: Ersetzt das Tag am Anfang der Daten in *dataVar* durch *newTag*. Das neue Tag kann mit dem Befehl **::asn::asnTag** erstellt werden.


# Beispiele

Beispiele für die Verwendung dieses Pakets finden Sie in der Implementierung des Pakets **ldap**.

Wenn Text kodiert wird, ist **::asn::asnUTF8String** am besten zu *vermeiden*, da es in seltenen Fällen möglicherweise nicht korrekt funktioniert. Für reines 7-Bit-ASCII ist die Kodierung mit **::asn::asnIA5String** am einfachsten. Außerhalb des 7-Bit-ASCII-Bereichs wandeln Sie Tcl-Zeichenketten in UCS2 (d. h. utf-16le) um und führen Sie die Kodierung mit **::asn::asnBMPString** durch. Verwenden Sie zum Dekodieren beliebiger Zeichenfolgen **::asn::asnGetString**; denken Sie jedoch daran, jede UCS2-Zeichenfolge anschließend wieder in eine Tcl-Zeichenfolge zurückzuwandeln.

```
# Encode
set eflag [::asn::asnBoolean 1]
set etotal [::asn::asnInteger 734]
set line [encoding convertto utf-16le "€2 ÷ 3 → €⅔ ✔"]
set eline [::asn::asnBMPString $line]
set enote [::asn::asnIA5String "7-bit ASCII ~^"]
set encoded [::asn::asnSequence $eflag $etotal $eline $enote]
# Decode
::asn::asnGetSequence encoded sequence
::asn::asnGetBoolean sequence flag
::asn::asnGetInteger sequence total
::asn::asnGetString sequence bmp_line
set line [encoding convertfrom utf-16le $bmp_line]
::asn::asnGetString sequence note
puts "flag=$flag total=$total line='$line' note='$note'"
=>
flag=1 total=734 line='€2 ÷ 3 → €⅔ ✔' note='7-bit ASCII ~^'
```

# Fehler, Ideen, Rückmeldungen

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *asn* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# Kategorie

Netzwerk

# Copyright

```
Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
Copyright (c) 2004 Jochen Loewer <loewerj@web.de>
Copyright (c) 2004-2011 Michael Schlenker <mic42@users.sourceforge.net>
```
