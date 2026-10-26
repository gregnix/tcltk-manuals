---
CommandName: bee
ManualSection: n
Version: 0.3
TclPart: tcllib
TclDescription: BitTorrent
Keywords:
 - BitTorrent
 - bee
 - bittorrent
 - serialization
 - torrent
Copyright:
 - Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
---

# NAME

bee – Encoder/Decoder für das BitTorrent-Serialisierungsformat

# ÜBERSICHT

::: {.synopsis} :::
[package]{.cmd} [require]{.sub} [Tcl]{.lit} [8.5]{.lit} [9]{.lit} 
[package]{.cmd} [require]{.sub} [bee]{.lit} [0.3]{.optlit} 
[::bee::encodeString]{.cmd} [string]{.arg} 
[::bee::encodeNumber]{.cmd} [integer]{.arg} 
[::bee::encodeListArgs]{.cmd} [beevalue]{.optdot} 
[::bee::encodeList]{.cmd} [listofbees]{.arg} 
[::bee::encodeDictArgs]{.cmd} [key beevalue]{.optdot} 
[::bee::encodeDict]{.cmd} [dictofbees]{.arg} 
[::bee::decode]{.cmd} [beestring]{.arg} [endVar]{.optarg} [start]{.optarg} 
[::bee::decodeIndices]{.cmd} [beestring]{.arg} [endVar]{.optarg} [start]{.optarg} 
[::bee::decodeChannel]{.cmd} [chan]{.arg} [-command]{.lit} [on_decode]{.arg} [-exact]{.optlit} [-prefix data]{.optarg} 
[on_decode]{.cmd} [value]{.sub} [handle]{.arg} [value]{.arg} 
[on_decode]{.cmd} [error]{.sub} [handle]{.arg} [message]{.arg} 
[on_decode]{.cmd} [eof]{.sub} [handle]{.arg} 
[::bee::decodeCancel]{.cmd} [handle]{.arg} 
[::bee::decodePush]{.cmd} [handle]{.arg} [string]{.arg} 
:::

# BESCHREIBUNG

Dieses Paket stellt Befehle zur Kodierung und Dekodierung von Daten im Bencode-Format (ausgesprochen „Bee-Encode“) bereit, dem Serialisierungsformat des BitTorrent-Protokolls, das für Daten und Nachrichten verwendet wird.

# API

## Encoder

Dieses Paket stellt für jeden Werttyp (Zeichenkette und Ganzzahl) einen Encoder-Befehl sowie für jeden Sammlungstyp (Liste und Dictionary) jeweils zwei Befehle bereit, von denen der eine eine vollständige Tcl-Sammlung zur Kodierung entgegennimmt und der andere dieselben Daten als Argumente entgegennimmt.

**::bee::encodeString** *string*
: Gibt die Bee-Kodierung der *string* zurück.

**::bee::encodeNumber** *integer*
: Gibt die Bee-Kodierung der Zahl *integer* zurück. Dieser Befehl löst einen Fehler aus, wenn *integer* keine ganze Zahl ist.

**::bee::encodeListArgs** ?*beevalue ...*?
: Gibt eine bee-kodierte Liste der angegebenen null oder mehr bee-kodierten *beevalue*s zurück.

**::bee::encodeList** *listofbees*
: Gibt eine bee-kodierte Liste der angegebenen Tcl-Liste *listofbees* mit bee-kodierten Werten zurück.

**::bee::encodeDictArgs** ?*key beevalue ...*?
: Gibt ein bee-kodiertes Dictionary zurück, das aus den angegebenen null oder mehr Paaren aus Tcl-Zeichenkettenschlüsseln und bee-kodierten *beevalue*s besteht. Dieser Befehl bee-kodiert jeden Zeichenkettenschlüssel selbst.

**::bee::encodeDict** *dictofbees*
: Gibt ein bee-kodiertes Dictionary des angegebenen Tcl-Dictionarys *dictofbees* zurück, dessen Schlüssel Tcl-Zeichenketten und dessen Werte bee-kodierte Werte sein müssen. Dieser Befehl bee-kodiert jeden Zeichenkettenschlüssel selbst.


## Decoder

Dieses Paket stellt Befehle zur Dekodierung von „bee“-kodierten Zeichenfolgen sowie von über einen Kanal empfangenen „bee“-kodierten Daten bereit.

Die Befehle zum Dekodieren einer „bee“-kodierten Zeichenkette setzen voraus, dass die Zeichenkette einen oder mehrere vollständige „bee“-kodierte Werte enthält (die ihrerseits verschachtelte „bee“-kodierte Listen und Wörterbücher enthalten können).

Der Befehl zur inkrementellen Dekodierung von Bee-Werten, die über einen Kanal eingehen, arbeitet asynchron und stellt die vollständig dekodierten Werte über eine Rückruffunktion bereit.

**::bee::decode** *beestring* ?*endVar*? ?*start*?
: Gibt einen aus dem *beestring* dekodierten Wert zurück, beginnend bei der Indexposition *start*, sofern angegeben – andernfalls bei der Standardposition **0** – und setzt *endVar*, sofern angegeben. Wenn der „bee“-kodierte Wert eine Zeichenkette oder eine Ganzzahl ist, gibt es die entsprechende Tcl-Zeichenkette bzw. Ganzzahl zurück. Wenn der „bee“-kodierte Wert eine Sammlung (eine „bee“-Liste oder ein „bee“-Dict) ist, gibt es die entsprechende Tcl-Liste bzw. ein Tcl-Dict zurück. In beiden Fällen werden alle enthaltenen Werte (einschließlich verschachtelter Bee-Listen und Bee-Dictionarys) vollständig bee-dekodiert, sodass das Ergebnis eine Tcl-Liste oder ein Tcl-Dictionary ist, in der bzw. dem alle verschachtelten Werte entsprechend vollständig in Tcl-Listen, Tcl-Dictionarys, Zeichenketten oder Ganzzahlen bee-dekodiert sind. Wenn die Option *endVar* angegeben wird, handelt es sich dabei um den Namen einer Variablen, in der die Indexposition des ersten Zeichens in *beestring* gespeichert wird, das auf den gerade dekodierten Wert *folgt*, d. h. die Startposition des nächsten zu dekodierenden Werts. Dies ist nützlich, wenn der *beestring* zwei oder mehr miteinander verkettete „bee“-kodierte Werte enthält (im Gegensatz zu einer einzelnen „bee“-kodierten Liste von „bee“-kodierten Werten). Siehe das letzte Beispiel im Abschnitt **BEISPIELE**. Der optionale Parameter *start* ist die Indexposition, ab der der nächste „bee“-kodierte Wert gelesen und dekodiert wird.

**::bee::decodeIndices** *beestring* ?*endVar*? ?*start*?
: Gibt eine Liste zurück, die auf dem „bee“-dekodierten Wert aus *beestring* basiert, beginnend bei der Indexposition *start*, sofern angegeben – andernfalls bei der Standardposition **0** – und setzt *endVar*, sofern angegeben. Die Bedeutung und Verwendung von *endVar* und *start* entsprechen genau denen von **::bee::decode**. Die Elemente der zurückgegebenen Liste hängen vom Typ des „bee“-dekodierten Werts ab. In allen Fällen ist das erste Element jedoch ein Typname (einer der folgenden: **string**, **integer**, **list**, **dict**), während das zweite und dritte Element die Start- und End-Index-Positionen im *beestring* für den „bee“-kodierten Wert darstellen. Bei Bee-Listen und Bee-Dictionarys gibt es ein viertes Element, das Details zu den darin enthaltenen „bee“-Werten liefert. Formal lauten die Ergebnislisten für die verschiedenen Typen von „bee“-Werten wie folgt:


**string**
: Eine Liste mit drei Elementen:


**•**
: Eine konstante Zeichenfolge, die den Typ des Werts angibt; bei Zeichenfolgen lautet sie **string**.

**•**
: Die Indexposition (*>= 0*) des ersten Zeichens des „bee“-Werts im angegebenen *beestring*.

**•**
: Die Indexposition (*>= 0*) des letzten Zeichens des „bee“-Werts im angegebenen *beestring*.


*Jede Ergebnisliste beginnt bei jedem Bee-Wert mit diesen drei Elementen.*

**integer**
: Eine Liste, die die konstante Zeichenkette **integer** sowie – genau wie bei Zeichenketten – die Start- und End-Index-Positionen des „bee“-Werts im *beestring* enthält.

**list**
: Eine Liste, die die konstante Zeichenkette **list** sowie – genau wie bei Zeichenketten – die Start- und End-Index-Positionen des „bee“-Werts im *beestring* enthält. Darüber hinaus verfügt die Liste über ein viertes Element, das seinerseits die hier beschriebenen Index-Daten für alle Elemente der „bee“-Liste enthält.

**dictionary**
: Eine Liste, die die konstante Zeichenkette **dict** sowie – genau wie bei Zeichenketten – die Start- und End-Index-Positionen des Bee-Werts im *beestring* enthält. Darüber hinaus hat das Dictionary ein viertes Element. Dieses Element ist ein Dictionary, das von jedem Zeichenkettenschlüssel des Bee-Dictionarys auf eine Liste aus zwei Elementen verweist, wobei jedes dieser Elemente wiederum eine Liste aus zwei Elementen enthält. Die Liste des ersten Elements enthält die Indexpositionen für den Schlüssel, und die Liste des zweiten Elements enthält die Indexpositionen für den Wert, auf den der Schlüssel verweist. Diese Struktur ist die einzige, die nicht nur Indexpositionen, sondern auch tatsächliche Werte aus dem *beestring* enthält. Die Indexpositionen jedes Schlüssels sind zwar eindeutig, d. h. als Schlüssel verwendbar, doch ist die Navigation darin nicht einfach, wenn ein bestimmtes Element gesucht wird. Die Verwendung der tatsächlichen Schlüssel erleichtert die Navigation erheblich, weshalb sie bereitgestellt werden.


**::bee::decodeChannel** *chan* **-command** *on_decode* ?**-exact**? ?**-prefix** *data*?
: Dieser Befehl erstellt einen Decoder für eine Reihe von Bee-Werten, die über den Kanal *chan* eingehen, und gibt ein Decoder-Handle zurück. Jedes Dekodierungsereignis wird an den erforderlichen Rückrufbefehl *on_decode* gemeldet. Das zurückgegebene Handle kann verwendet werden, um Daten in den Decoder zu schieben oder den Decoder abzubrechen. Der Versuch, einen weiteren Bee-Decoder auf dem Kanal *chan* zu erstellen, während ein bestehender Bee-Decoder noch aktiv ist, löst einen Fehler aus.


**-command**
: Der durch die *erforderliche* Option **-command** festgelegte Befehl *on_decode* dient dazu, dekodierte Werte, Fehler und das EOF des Kanals zu melden. Die Rückruffunktion wird auf globaler Ebene des Interpreters mit zwei oder drei Argumenten ausgeführt. Die möglichen Signaturen der Rückruffunktion lauten:


**on_decode** **value** *handle* *value*
: Der Decoder hat einen Bee-Wert empfangen und erfolgreich dekodiert. Das Format des entsprechenden Tcl-*value* entspricht dem von **::bee::decode** zurückgegebenen Format. Der Kanal ist weiterhin geöffnet und das Decoder-Handle ist gültig. Die Rückruffunktion kann daher Daten in den Decoder schieben oder den Decoder abbrechen.

**on_decode** **error** *handle* *message*
: Der Decoder hat einen Fehler festgestellt, bei dem es sich nicht um EOF handelt. Beispielsweise einen ungültigen Bee-Wert. Die *message* liefert Einzelheiten zum Fehler. Das Decoder-Handle befindet sich im gleichen Zustand wie bei EOF, d. h. es ist ungültig und kann nicht verwendet werden. Der Kanal bleibt jedoch offen.

**on_decode** **eof** *handle*
: Der Decoder hat am Kanal *chan* das EOF erreicht. Danach erfolgen keine weiteren Aufrufe der Rückruffunktion. Der Kanal war zum Zeitpunkt des Aufrufs bereits geschlossen, und das *handle* ist ungültig und kann nicht verwendet werden.


**-exact**
: Standardmäßig geht der Decoder davon aus, dass alle Daten des Kanals aus „bee“-Werten bestehen, und liest pro Ereignis so viel wie möglich ein, ohne dabei die Grenzen zwischen den „bee“-Werten zu berücksichtigen. Das bedeutet: Wenn der Kanal nach einer Reihe von „bee“-Werten Nicht-„bee“-Daten enthält, kann der Anfang dieser Nicht-„bee“-Daten verloren gehen, da er bereits vom Decoder gelesen, aber noch nicht verarbeitet wurde. In solchen Fällen wird die Option **-exact** verwendet. Wenn diese Option festgelegt wird, liest der Decoder keine Zeichen mehr, die über den aktuell verarbeiteten „bee“-Wert hinausgehen, sodass alle Nicht-„bee“-Daten im Kanal verbleiben und nach dem Schließen des Decoders weiterverarbeitet werden können.

**-prefix**
: Wenn diese Option festgelegt wird, wird ihr Wert als Anfang eines Bee-Werts angesehen und zur Initialisierung des internen Puffers des Decoders verwendet. Diese Funktion ist erforderlich, wenn der Ersteller des Decoders Daten aus dem Kanal gelesen hat, um zu entscheiden, ob der Decoder erstellt werden soll oder nicht. Ohne diese Option gingen diese Anfangsdaten bei der Dekodierung verloren.


**::bee::decodeCancel** *handle*
: Dieser Befehl bricht den durch **::bee::decodeChannel** eingerichteten und durch das Handle *handle* repräsentierten Decoder ab.

**::bee::decodePush** *handle* *string*
: Dieser Befehl hängt die *string* an den internen Puffer des Decoders an. Er ist das Laufzeitäquivalent der Option **-prefix** des Befehls **::bee::decodeChannel**. Mit diesem Befehl lassen sich Daten in den Decoder zurückschieben, wenn die Rückruffunktion **on_decode value** Daten aus dem Kanal verwendet hat, um zu bestimmen, ob ein weiterer Bee-Wert dekodiert werden soll oder nicht.


# FORMATDEFINITION

Daten im Bencode-Serialisierungsformat setzen sich aus zwei Grundformen und zwei Sammlungsformen zusammen. Die Grundformen sind Zeichenketten und Ganzzahlen, die Sammlungen sind Listen und Dictionarys.

Zeichenkette *S*
: Eine Zeichenkette *S* der Länge *L* wird durch die Zeichenkette "*L*__:__*S*" kodiert, wobei die Länge in Textform angegeben wird. So würde beispielsweise die Zeichenkette **"Bencode format"** als **"14:Bencode format"** kodiert.

Ganzzahl *N*
: Eine Ganzzahl *N* wird durch die Zeichenfolge "**i**_N_**e**" kodiert. Beispielsweise würde die Ganzzahl **-482** als **"i-482e"** kodiert.

Liste *v1* ... *vn*
: Eine Liste der Werte *v1* bis *vn* wird durch die Zeichenfolge "**l**_BV1_...*BVn*__e__" kodiert, wobei "BV**i**" die Bee-Kodierung des Werts "v**i**" ist.

Dict *k1* -> *v1* ...
: Ein Dictionary, das den Zeichenkettenschlüssel *k*__i__ dem Wert *v*__i__ zuordnet, für **i** in **1** ... **n**, wird durch die Zeichenfolge "**d**_BK_**i**_BV_**i**...**e**" kodiert, für i in **1** ... **n**, wobei "BK**i**" die Bee-Kodierung der Schlüsselzeichenfolge "k**i**" ist und "BV**i**" die Bee-Kodierung des Werts "v**i**" ist. *Hinweis*: Die Bee-Kodierung behält die Reihenfolge der Schlüssel in der Eingabe nicht bei, sondern speichert sie in schlüsselsortierter Reihenfolge. Der Typ jedes kodierten Elements lässt sich unmittelbar am ersten Zeichen seiner Kodierung erkennen:

**i**
: Ganzzahl.

**l**
: Liste.

**d**
: Dictionary.

**\[0-9\]**
: Zeichenkette. Indem Ganzzahlen **i** vorangestellt wird, stellt das Format sicher, dass sie sich von Zeichenketten unterscheiden, die alle mit einer Ziffer beginnen.


# BEISPIELE

Dieses Beispiel zeigt, wie einzelne Zeichenketten und Ganzzahlen bee-kodiert und bee-dekodiert werden.

```
const LABEL "Δ÷ “Utf-8” ♞ℤ"
set labelbeeEnc [::bee::encodeString $LABEL]
set labelbeeDec [::bee::decode $labelbeeEnc]
puts "labelbeeEnc='$labelbeeEnc' eq LABEL → [expr {$labelbeeDec eq $LABEL}]"
set xbeeEnc [::bee::encodeNumber 834]
set ybeeEnc [::bee::encodeNumber -172]
set ybeeDec [::bee::decode $ybeeEnc]
puts "ybeeEnc='$ybeeEnc' == -172 → [expr {$ybeeDec == -172}]"
=>
labelbeeEnc='13:Δ÷ “Utf-8” ♞ℤ' eq LABEL → 1
ybeeEnc='i-172e' == -172 → 1
```

Dieses Beispiel zeigt, wie sich Sammlungen bee-kodierter Werte bee-kodieren lassen.

```
set pointbeeEnc [::bee::encodeList [list $xbeeEnc $ybeeEnc]]
set placebeeEnc [::bee::encodeDictArgs label $labelbeeEnc point $pointbeeEnc]
puts "pointbeeEnc='$pointbeeEnc'"
puts "placebeeEnc='$placebeeEnc'"
=>
pointbeeEnc='li834ei-172ee'
placebeeEnc='d5:label13:Δ÷ “Utf-8” ♞ℤ5:pointli834ei-172eee'
```

Dieses Beispiel zeigt, wie sich Sammlungen bee-kodierter Werte bee-dekodieren lassen.

```
set placebeeDec [::bee::decode $placebeeEnc]
set label [dict get $placebeeDec label]
puts "label='$label' eq LABEL → [expr {$label eq $LABEL}]"
lassign [dict get $placebeeDec point] x y
puts "x=$x == 834 → [expr {$x == 834}] • y=$y == -172 → [expr {$y == -172}]"
=>
label='Δ÷ “Utf-8” ♞ℤ' eq LABEL → 1
x=834 == 834 → 1 • y=-172 == -172 → 1
```

Dieses Beispiel zeigt, wie mit dem Befehl **::bee::decodeIndices** bee-dekodiert wird.

```
set labelbeeDecInd [::bee::decodeIndices $labelbeeEnc]
lassign $labelbeeDecInd type i j
set label [::bee::decode [string range $labelbeeEnc $i $j]]
puts "labelbeeDecInd type=$type i=$i j=$j label='$label'"
=>
labelbeeDecInd type=string i=0 j=15 label='Δ÷ “Utf-8” ♞ℤ'
```

Dieses Beispiel zeigt, wie eine Folge von *einzelnen* bee-kodierten Werten zunächst bee-kodiert und anschließend wieder bee-dekodiert wird.

```
set stream [::bee::encodeString "€⅔•"][::bee::encodeNumber -91][::bee::encodeString "α-ω"][::bee::encodeNumber 68]
for {set i 0} {$i < [string length $stream]} {} {
    lappend items [::bee::decode $stream i $i]
}
puts "stream='$stream' items={$items} size=[llength $items]"
=>
stream='3:€⅔•i-91e3:α-ωi68e' items={€⅔• -91 α-ω 68} size=4
```

# FEHLER, IDEEN, RÜCKMELDUNGEN

Wenn Sie Fehler in diesem Dokument oder Fehler und Probleme im beschriebenen Paket finden oder Verbesserungen für die Dokumentation oder das Paket vorschlagen möchten, nutzen Sie bitte die [Tcllib-Tracker](http://core.tcl.tk/tcllib/reportlist) und geben Sie *bee* als Kategorie an.

Schlagen Sie Codeänderungen bitte als *Unified Diffs* vor, also als Ausgabe von **diff -u**.

*Anhänge* sind eingebetteten Patches ausdrücklich vorzuziehen. Anhänge lassen sich über das Formular **Edit** des Tickets direkt nach dem Anlegen hinzufügen, mit der Schaltfläche ganz links in der zweiten Navigationsleiste.

# KATEGORIE

Netzwerk

# COPYRIGHT

```
Copyright (c) 2004 Andreas Kupries <andreas_kupries@users.sourceforge.net>
```
