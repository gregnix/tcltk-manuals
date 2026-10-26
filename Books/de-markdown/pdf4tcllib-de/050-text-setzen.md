# Text setzen

## Einführung

pdf4tcl setzt eine Zeile dorthin, wo man sie hinschreibt. Ist sie zu
lang, läuft sie über den Rand. Für alles darüber hinaus gibt es im
Namensraum [text]{.index} vier Werkzeuge: Breite messen, umbrechen,
kürzen, verkleinern. Dazu kommt `writeParagraph` für einen ganzen Absatz
in einem Zug.

Dieses Kapitel zeigt die vier Werkzeuge und baut daraus eine kleine
Prozedur, die Text über beliebig viele Seiten setzt.

---

## Breite messen

```tcl
pdf4tcllib::text::width text size font ?pdf?
```

Mit dem pdf4tcl-Objekt als letztem Argument fragt `width` pdf4tcl nach
den echten Maßen der Schrift. Ohne Objekt schätzt es über
Zeichenklassen: schmale Buchstaben wie `i` und `l` zählen weniger, `m`
und `W` mehr.

```tcl
# 050-messen-und-umbrechen.tcl -- messen, umbrechen, kuerzen
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set font [pdf4tcllib::fonts::fontSans]
set pdf  [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Breite: geschaetzt (ohne pdf) und gemessen (mit pdf)
set t "Lieferung Mo 17.08. Spedition Nord"
puts [format "geschaetzt %.1f pt, gemessen %.1f pt" \
    [pdf4tcllib::text::width $t 10 $font] \
    [pdf4tcllib::text::width $t 10 $font $pdf]]

# Umbrechen: am Leerzeichen und nach einem Bindestrich
set lang "Die Muster-Beispiel-Stadt liegt an der Bundesstrasse."
foreach z [pdf4tcllib::text::wrap $lang 90 10 $font 0 $pdf] {
    puts "  |$z|"
}

# Ein Wort, das allein zu breit ist: gekuerzt oder zerlegt
set name "pdf4tcllib::unicode::substReport"
set ohne [pdf4tcllib::text::wrap $name 80 10 $font 0 $pdf]
set mit  [pdf4tcllib::text::wrap $name 80 10 $font 0 $pdf 1]
puts "ohne hardBreak: $ohne"
puts "mit hardBreak:  $mit"

# Kuerzen mit "..." oder kleiner setzen
set k "Tour Sped1 Nord"
puts "truncate: [pdf4tcllib::text::truncate $k 60 10 $font $pdf]"
puts "fitSize:  [pdf4tcllib::text::fitSize $k 60 10 $font -pdf $pdf]"
puts "fits:     [pdf4tcllib::text::fits $k 60 7 $font $pdf]"
$pdf destroy
```

```text
geschaetzt 156.0 pt, gemessen 159.7 pt
  |Die Muster-Beispiel-|
  |Stadt liegt an der|
  |Bundesstrasse.|
ohne hardBreak: pdf4tcllib::unic...
mit hardBreak:  pdf4tcllib::unicod e::substReport
truncate: Tour Sped1...
fitSize:  8
fits:     1
```

Bei diesem Satz liegt die Schätzung 2 % daneben, bei anderen Texten mit
DejaVu bis etwa 6 %. Das reicht, um eine Zeile umzubrechen, die gepasst
hätte, oder eine passen zu lassen, die übersteht. Darum hängen alle
Aufrufe in diesem Buch das Objekt `$pdf` an. Die Schätzung ist nur für
den Fall da, dass noch kein Dokument existiert.

`width` braucht kein `setFont` vorher: Schrift und Größe stehen im
Aufruf.

---

## Umbrechen

```tcl
pdf4tcllib::text::wrap line maxW size font \
    ?code? ?pdf? ?hardBreak? ?trenner?
```

`wrap` gibt eine Liste von Zeilen zurück, die jede höchstens `maxW` breit
sind. Gezeichnet wird nichts. Die Reihenfolge der Argumente ist
ungewohnt: `pdf` steht an sechster Stelle, nach `code`.

| Argument | Vorgabe | Bedeutung |
|---|---|---|
| `code` | `0` | `1`: jede umbrochene Zeile außer der letzten endet auf ` \`, wie eine fortgesetzte Tcl-Zeile |
| `pdf` | – | Objekt für genaue Breiten |
| `hardBreak` | `0` | was mit einem Wort geschieht, das allein zu breit ist (siehe unten) |
| `trenner` | `{- /}` | Zeichen, an denen auch innerhalb eines Worts umbrochen werden darf |

Umbrochen wird am Leerzeichen und nach einem Bindestrich oder
Schrägstrich zwischen zwei Buchstaben oder Ziffern. Der Trenner bleibt
am Ende der Zeile stehen („Muster-Beispiel-“), so sieht der Leser, dass
es weitergeht. Ein Strich am Wortanfang trennt nicht: „-5 Euro“ bleibt
zusammen. pdf4tcl bricht in `drawTextBox` nach denselben Regeln um.

### Ein Wort, das nicht passt

Was mit einem Wort geschieht, das allein breiter ist als die Zeile,
entscheidet `hardBreak`:

- `0` (Vorgabe): Das Wort wird **gekürzt** und endet auf „...“. Der Rest
  ist weg.
- `1`: Das Wort wird zeichenweise zerlegt, nichts geht verloren.

Die Vorgabe ist für Fließtext gedacht, in dem ein solches Wort selten
ist. In Tabellenzellen mit Pfaden, Paketnamen oder Artikelnummern ist
sie falsch: Aus `pdf4tcllib::unicode::substReport` wird
`pdf4tcllib::unic...`. Dort `hardBreak 1` setzen.

---

## Kürzen oder verkleinern

```tcl
pdf4tcllib::text::truncate text maxW size font ?pdf?
pdf4tcllib::text::fitSize  text maxW size font ?-min n? ?-pdf obj?
pdf4tcllib::text::fits     text maxW size font ?pdf?
```

[text::truncate]{.index} schneidet ab und hängt drei Punkte an.
[text::fitSize]{.index} sucht stattdessen die größte Schriftgröße, bei
der der Text ganz passt, in Schritten von 1 Punkt nach unten bis `-min`
(Vorgabe 6). Passt er auch dort nicht, kommt `-min` zurück, und der
Aufrufer entscheidet.

Was besser ist, hängt am Inhalt. „Tour Sped1 Nord“ gekürzt ist „Tour
Sped1...“: Ob es „Nord“ oder „Süd“ war, steht nicht mehr da. Bei
Namen, Touren, Beträgen und Kennungen ist eine kleinere Schrift
besser als ein abgeschnittenes Ende. Bei einer Bemerkung, die
ohnehin nur ein Hinweis ist, darf gekürzt werden.

Bei `fitSize` heißt das Objekt `-pdf`, bei den anderen ist es das letzte
Argument ohne Namen.

---

## Einen Absatz in einem Zug

```tcl
set y [pdf4tcllib::text::writeParagraph pdf text x y width \
    ?size? ?align? ?tag?]
```

[text::writeParagraph]{.index} bricht um und zeichnet in einem Schritt,
über `drawTextBox` von pdf4tcl. Es gibt die y-Position unter der letzten
Zeile zurück. `align` ist `left`, `right`, `center` oder `justify`.

Drei Dinge sollte man wissen:

- Die Schrift ist immer die normale aus `fonts::init` (ohne TrueType
  Helvetica). Fett oder kursiv geht damit nicht.
- Es gibt keinen Seitenumbruch. Ein Absatz, der unten nicht mehr
  passt, läuft über den Rand hinaus.
- Der Text geht nicht durch `sanitize` (Kapitel
  [Unicode sicher ausgeben](030-unicode-sicher-ausgeben.md)).

Für einen kurzen Absatz an bekannter Stelle ist `writeParagraph` richtig.
Für Text, dessen Länge man nicht kennt, braucht es einen Umbruch über
Seiten.

---

## Text über Seiten

Die folgende Prozedur `absatz` bricht einen Absatz mit `wrap` um und
setzt ihn Zeile für Zeile. Passt die nächste Zeile nicht mehr über
`bottom`, beginnt `neueSeite` eine neue Seite mit Fußzeile. Schrift und
Größe sind frei wählbar, auch fett.

```tcl
# 050-text-ueber-seiten.tcl -- Fliesstext mit eigenem Seitenumbruch
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Der Zustand der Seite: wo die naechste Zeile steht
set y 0

proc neueSeite {} {
    global pdf ctx y
    if {[$pdf currentPage] > 0} {
        set n [$pdf currentPage]
        pdf4tcllib::page::footer $pdf $ctx "Lagerbericht" $n
        $pdf endPage
    }
    $pdf startPage
    set y [dict get $ctx top]
}

# Einen Absatz setzen: umbrechen, Zeile fuer Zeile, bei Bedarf eine
# neue Seite
proc absatz {text {size 11} {font ""}} {
    global pdf ctx y
    if {$font eq ""} { set font [pdf4tcllib::fonts::fontSans] }
    set lh [pdf4tcllib::page::lineheight $size]
    set breite [dict get $ctx text_w]
    foreach zeile [pdf4tcllib::text::wrap $text $breite \
            $size $font 0 $pdf 1] {
        if {$y + $lh > [dict get $ctx bottom]} { neueSeite }
        set y [expr {$y + $lh}]
        $pdf setFont $size $font
        pdf4tcllib::unicode::safeText $pdf $zeile \
            -x [dict get $ctx left] -y $y
    }
    set y [expr {$y + $lh / 2}]
}

neueSeite
absatz "Bestand am Monatsende" 16 [pdf4tcllib::fonts::fontSansBold]
for {set i 1} {$i <= 40} {incr i} {
    absatz "Regal $i: Der Bestand wurde gezählt und mit der Buchung\
        abgeglichen. Abweichungen unter zwei Stück sind ausgebucht,\
        größere gehen an die Lagerleitung zur Klärung."
}
pdf4tcllib::page::footer $pdf $ctx "Lagerbericht" [$pdf currentPage]
$pdf endPage
puts "Seiten: [$pdf pageCount]"
$pdf write -file 050-text-ueber-seiten.pdf
$pdf destroy
```

```text
Seiten: 3
```

Was die Prozedur richtig macht:

- Sie prüft **vor** jeder Zeile, ob sie noch passt, nicht danach. Die
  letzte Zeile einer Seite steht dann noch im Satzspiegel.
- Sie schiebt y **vor** dem Schreiben weiter, eine Zeilenhöhe unter
  `top`. So ragt die erste Zeile einer Seite nicht in den Rand
  (Kapitel [Einheiten und Seitenkontext](040-einheiten-und-seitenkontext.md)).
- Sie setzt die Schrift vor jeder Zeile neu. `neueSeite` setzt in der
  Fußzeile eine andere Schrift, und ohne das neue `setFont` liefe der
  Absatz auf der neuen Seite in der Schrift der Fußzeile weiter.
- Sie nimmt `hardBreak 1`, damit kein Wort gekürzt wird.

Die Seitenzahl kommt aus `$pdf currentPage`; nach dem letzten `endPage`
sagt `$pdf pageCount`, wie viele Seiten es geworden sind.

Was die Prozedur nicht macht: Sie verhindert keine einzelne Zeile oben
auf einer Seite und keine Überschrift unten. Dafür muss man vor dem
Setzen wissen, wie hoch ein Block wird; das zeigt das Kapitel zu
`measure` und `layout`.

---

## Zusammenfassung

- `text::width`, `text::wrap`, `text::truncate`, `text::fits` immer mit
  dem pdf4tcl-Objekt aufrufen, sonst wird geschätzt.
- `wrap` kürzt ein zu breites Wort; `hardBreak 1`, wo nichts verloren
  gehen darf.
- `fitSize` statt `truncate` bei Namen, Kennungen und Beträgen.
- `writeParagraph` für einen kurzen Absatz in normaler Schrift; für
  längeren Text eine eigene Schleife mit Seitenumbruch.

---

*Nächstes Kapitel: [Kopf- und Fußzeilen, Seitenzahlen](060-kopf-fuss-seitenzahlen.md)*
