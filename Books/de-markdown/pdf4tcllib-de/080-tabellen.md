# Tabellen mit Seitenumbruch

## Einführung

Eine Tabelle ist in pdf4tcl eine Reihe von Rechtecken, Linien und
Texten, die man selbst ausrechnet. Bei einer Seite geht das, bei einer
Liste unbekannter Länge nicht mehr: Irgendwo ist die Seite zu Ende, die
Kopfzeile muss auf der nächsten wiederholt werden, und die Summe gehört
ans Ende. [table::draw]{.index} erledigt das aus einfachen Daten: einer
Liste von Spalten und einer Liste von Zeilen.

pdf4tcllib hat daneben ältere Tabellenprozeduren (`table::render`,
`table::simpleTable`). Dieses Buch benutzt nur `table::draw`; es ist die
Prozedur, auf der auch der Export von `tablelist`-Widgets aufbaut.

---

## Spalten und Zeilen

```tcl
set y [pdf4tcllib::table::draw pdf x y spalten zeilen \
    ?option wert ...?]
```

**Spalten** sind eine Liste, je Spalte eine Optionsliste:

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-header` | – | Text der Kopfzelle |
| `-width` | `auto` | Breite in Punkt oder `auto` (nach dem breitesten Inhalt) |
| `-align` | `left` | `left`, `center`, `right` |
| `-font` | `reg` | `reg`, `bold`, `italic`, `bolditalic`, `mono` |
| `-notruncate` | `0` | `1`: Text dieser Spalte nie kürzen (siehe unten) |

**Zeilen** sind eine Liste von Listen mit reinem Text. Formatierung steht
nicht in den Daten, sondern in eigenen Optionen, die Zeile und Spalte
nach Nummer ansprechen (ab 0, ohne Kopfzeile).

`table::draw` gibt die y-Position unter der Tabelle zurück.

---

## Eine Liste über zwei Seiten

```tcl
# 080-tabelle.tcl -- eine Artikelliste ueber mehrere Seiten
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Daten: 70 Artikel, jede Zeile eine Liste von Texten
set data {}
for {set i 1} {$i <= 70} {incr i} {
    set preis [expr {($i * 37 % 500) + 0.5}]
    set text "Schraube M$i, verzinkt, Packung zu 100 Stück"
    lappend data [list [format "A-%04d" $i] $text \
        [expr {$i * 3 % 40}] [format %.2f $preis]]
}
set summe 0.0
foreach z $data { set summe [expr {$summe + [lindex $z 3]}] }

set cols {
    {-header "Nr."         -width auto}
    {-header "Bezeichnung" -width auto}
    {-header "Bestand"     -width 50 -align right}
    {-header "Preis €"     -width 60 -align right}
}

# Seitenwechsel: laeuft im globalen Bereich und muss die neue
# y-Position liefern
proc tabellenUmbruch {} {
    global pdf ctx
    pdf4tcllib::page::footer $pdf $ctx "Artikelliste" \
        [$pdf currentPage]
    $pdf endPage
    $pdf startPage
    pdf4tcllib::page::header $pdf $ctx "Artikelliste (Fortsetzung)"
    return [dict get $ctx top]
}

$pdf startPage
$pdf setFont 16 [pdf4tcllib::fonts::fontSansBold]
pdf4tcllib::unicode::safeText $pdf "Artikelliste" \
    -x [dict get $ctx left] -y [expr {[dict get $ctx top] + 16}]

set y [pdf4tcllib::table::draw $pdf [dict get $ctx left] \
    [expr {[dict get $ctx top] + 30}] $cols $data \
    -ctx $ctx -zebra 1 -fontsize 9 \
    -pagebreakcmd tabellenUmbruch \
    -cellstyles {4,2 {-fg {0.8 0 0} -font bold}} \
    -footer [list "" "Summe" "" [format %.2f $summe]]]

pdf4tcllib::page::footer $pdf $ctx "Artikelliste" [$pdf currentPage]
$pdf endPage
puts "Seiten: [$pdf pageCount], Tabelle endet bei y = [format %.1f $y]"
$pdf write -file 080-tabelle.pdf
$pdf destroy
```

```text
Seiten: 2, Tabelle endet bei y = 542.7
```

Die Kopfzeile steht auf beiden Seiten, die Summe am Ende, die Zeile
`A-0005` hat einen roten, fetten Bestand.

### Was der Umbruch braucht

- **`-ctx`** schaltet den Umbruch ein. Ohne Kontext zeichnet
  `table::draw` alle Zeilen auf die aktuelle Seite, auch über den Rand
  hinaus.
- **`-pagebreakcmd`** ist der eigene Seitenwechsel: Fußzeile der alten
  Seite, neue Seite, Kopfzeile. Die Prozedur muss die y-Position
  zurückgeben, an der die Tabelle weitergeht.

Zwei Dinge sind anders als bei `-newpage` von `flow::columns`:

- Der Befehl läuft im **globalen** Bereich, nicht im Bereich des
  Aufrufers. Lokale Variablen der aufrufenden Prozedur sieht er nicht;
  darum steht im Beispiel `global pdf ctx`.
- Er muss die neue y-Position **zurückgeben**. Gibt er nichts zurück,
  nimmt `table::draw` `top` aus dem Kontext.

Ohne `-pagebreakcmd` bricht `table::draw` selbst um: Es schreibt unten
rechts `- 1 -` auf die alte Seite und beginnt eine neue, ohne Kopf- und
Fußzeile. Die letzte Seite bekommt keine Nummer. Für einen Bericht ist
das selten richtig; `-pagebreakcmd` ist der Normalfall.

---

## Aussehen

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-fontsize` | `9` | Schriftgröße |
| `-rowheight` | `0` | Zeilenhöhe; `0` heißt 1,8 × Schriftgröße |
| `-pad` | `4` | Innenabstand der Zellen |
| `-border` | `1` | Linien zeichnen |
| `-header` | `1` | Kopfzeile zeichnen |
| `-headerbg`, `-headerfg` | hellblau, schwarz | Farben der Kopfzeile |
| `-zebra` | `0` | jede zweite Zeile hinterlegen; `-zebracolor` |
| `-maxwidth` | `text_w` aus `-ctx`, sonst 480 | größte Breite der Tabelle |
| `-footer` | – | Summenzeile, je Spalte ein Wert, fett |

`-width auto` misst den breitesten Inhalt der Spalte samt Kopf. Feste
Breiten gelten wie angegeben. Sind alle Breiten zusammen größer als
`-maxwidth`, werden sie im selben Verhältnis verkleinert. Breiter als
nötig wird eine Tabelle nie; eine über den ganzen Satzspiegel braucht
feste Breiten, die zusammen `text_w` ergeben.

### Einzelne Zeilen und Zellen

```tcl
-rowstyles  {3 {-bg {1 0.95 0.8} -font bold}}
-cellstyles {4,2 {-fg {0.8 0 0} -font bold} 7,1 {-align right}}
-rowindent  {1 14 2 14}
```

`-rowstyles` nimmt `-bg`, `-fg` und `-font`, `-cellstyles` zusätzlich
`-align` und `-notruncate`. Die Zelle schlägt die Zeile, die Zeile das
Zebramuster. `-rowindent` rückt die erste Spalte einer Zeile ein, etwa
für Unterpositionen unter einer fetten Gruppenzeile.

---

## Eine Zeile, ein Wert: kürzen

Eine Zeile in `table::draw` ist **eine** Textzeile hoch. Was breiter ist
als die Spalte, wird gekürzt und endet auf „...“, auch in der Kopfzeile.
Es gibt keinen Umbruch innerhalb einer Zelle.

Für Bemerkungen und Artikelnamen ist das in Ordnung. Für Werte, die
jemand abtippt (Kennwörter, Seriennummern, Kontonummern), ist es
gefährlich: Das Blatt sieht vollständig aus. Für solche Spalten
`-notruncate 1`, für einzelne Zellen dasselbe in `-cellstyles`. Dann
steht der ganze Wert da, notfalls über den Spaltenrand hinaus. Die
Spalte muss also breit genug sein; `table::widths` sagt vorher, wie breit
(Abschnitt [Wie breit wird die Tabelle?](#wie-breit-wird-die-tabelle)).

```text
Text                          Betrag
Kennwort: Xk9-7Rt-22pQ-...      1.00      ohne -notruncate
Kennwort: Xk9-7Rt-22pQ-88aZ     1.00      mit -notruncate
```

---

## Verbundene Zellen

Eine Zelle darf statt eines Textes ein Dict mit `text` und `colspan`
oder `rowspan` sein:

```tcl
set zeilen [list \
    [list [dict create text Nord rowspan 2] Q1 120] \
    [list Q2 90] \
    [list [dict create text Summe colspan 2] 210]]
```

```text
R       Q     W
        Q1   120
Nord
        Q2    90
Summe        210
```

Mit `colspan` reicht die Zelle über mehrere Spalten, und die Zeile hat
entsprechend weniger Elemente. Mit `rowspan` hält sie ihre Spalte in den
folgenden Zeilen; dort fehlt sie wie in HTML einfach: `Q2` ist das
erste Element seiner Zeile und steht doch in der zweiten Spalte. Das
nächste Kapitel benutzt `colspan` für Zwischensummen.

Was `table::draw` dabei tut:

- Durch eine verbundene Zelle läuft keine Linie, und eine Zelle mit
  `rowspan` hat den Hintergrund der Zeile, in der sie beginnt, über ihre
  ganze Höhe. Ihr Text steht in der Mitte des Blocks.
- Zeilen, die `rowspan` verbindet, werden nicht über zwei Seiten
  getrennt; der ganze Block rückt auf die nächste Seite. Ist er höher als
  eine Seite, bricht `table::draw` mit einem Fehler ab.
- Im barrierefreien PDF trägt die Zelle `/ColSpan` bzw. `/RowSpan`.

Bis pdf4tcllib 0.6.6 kannte `table::draw` kein `rowspan` (die folgende
Zeile rutschte um eine Spalte nach links) und zog die Linien auch durch
eine verbundene Zelle („Summe No|rd“).

---

## Wie breit wird die Tabelle?

Wer vor dem Zeichnen wissen will, wie breit eine Tabelle wird oder ob
sie neben ein Bild passt, fragt [table::widths]{.index}:

```tcl
set b [pdf4tcllib::table::widths $cols $data -fontsize 9 -pdf $pdf]
dict get $b natural       ;# je Spalte: so breit, dass nichts fehlt
dict get $b min           ;# je Spalte: das längste Wort
dict get $b naturalTotal  ;# Summe
```

Und wie viele Zeilen auf einen Rest der Seite passen,
[table::fitRows]{.index}:

```tcl
set platz [expr {[dict get $ctx bottom] - $y}]
set n [pdf4tcllib::table::fitRows $platz $data -fontsize 9]
```

Damit lässt sich eine Tabelle selbst aufteilen, etwa um nach den ersten
`n` Zeilen eine Bemerkung einzuschieben.

---

## Was man wissen sollte

- **Unbekannte Optionen sind ein Fehler.** `-zebar 1` statt `-zebra 1`
  bricht mit „unknown option -zebar“ und der Liste der erlaubten
  Optionen ab. Bis pdf4tcllib 0.6.6 ging der Tippfehler still durch:
  keine Streifen, keine Meldung.
- **`-orient 0` geht nicht.** `table::draw` liest die Richtung aus dem
  Dokument und bricht bei y nach oben mit einem Fehler ab.
- **Zahlen formatiert der Aufrufer.** `table::draw` schreibt den Text so,
  wie er in den Daten steht; `format %.2f` gehört davor.
- **Text geht durch `sanitize`.** Die Anführungszeichen „“ werden gerade
  (Kapitel [Unicode sicher ausgeben](030-unicode-sicher-ausgeben.md)).

---

## Zusammenfassung

- `table::draw` mit Spalten und reinen Textzeilen; Formatierung über
  `-rowstyles` und `-cellstyles`.
- Für mehrere Seiten `-ctx` und `-pagebreakcmd`; der Befehl läuft global
  und gibt die neue y-Position zurück.
- Zellen sind einzeilig und werden gekürzt; `-notruncate` für Werte, die
  abgetippt werden.
- Verbundene Zellen mit `colspan` und `rowspan`; ein `rowspan`-Block
  bleibt auf einer Seite.

---

*Nächstes Kapitel: [Gruppensummen und Kreuztabellen](090-gruppen-und-kreuztabellen.md)*
