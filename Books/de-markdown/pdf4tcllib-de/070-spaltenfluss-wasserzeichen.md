# Spaltenfluss und Wasserzeichen

## Einführung

Ein Rundschreiben in zwei Spalten, ein Protokoll mit „ENTWURF“ quer über
jeder Seite: Beides lässt sich mit der Schleife aus dem Kapitel
[Text setzen](050-text-setzen.md) bauen, aber das Paket
[pdf4tclflow]{.index} nimmt einem die Spaltenrechnung ab. Es füllt
Spalte um Spalte und Seite um Seite, bis der Text aufgebraucht ist. Das
Wasserzeichen liegt im Kern von pdf4tcllib.

---

## Text in Spalten

```tcl
package require pdf4tclflow
set r [pdf4tcllib::flow::columns pdf ctx text ?option wert ...?]
```

Der Text wird an Leerzeilen in Absätze geteilt; Zeilenumbrüche und
mehrfache Leerzeichen innerhalb eines Absatzes werden zu einem
Leerzeichen. Zwischen zwei Absätzen bleibt eine Leerzeile, außer oben in
einer Spalte.

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-columns` | `2` | Zahl der Spalten |
| `-gap` | `18` | Abstand zwischen den Spalten in Punkt |
| `-size` | `10` | Schriftgröße |
| `-font` | aus `fonts::init` | Schrift |
| `-top`, `-bottom` | aus dem Kontext | wo jede Spalte beginnt und endet |
| `-firsty` | `-top` | Anfang der ersten Spalte, etwa unter einer Überschrift |
| `-newpage` | – | Skript für den Seitenwechsel |
| `-tag` | `P` | Strukturtyp für barrierefreie PDFs, `""` für keinen |

Die Spalten sind gleich breit und füllen den Satzspiegel; bei zwei
Spalten auf A4 mit 20 mm Rand sind das je 232 Punkt (82 mm).
[flow::boxes]{.index} liefert die Lage jeder Spalte als `{x breite}`,
für ein Bild in Spalte zwei oder eine Linie zwischen den Spalten.

```tcl
# 070-spalten.tcl -- zwei Spalten ueber mehrere Seiten, Wasserzeichen
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclflow

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Ein langer Text; Absaetze durch eine Leerzeile getrennt
set absatz "Die Inventur beginnt am ersten Werktag des Monats. Jedes\
    Regal wird gezählt, die Zahl mit der Buchung verglichen und die\
    Abweichung notiert. Kleine Abweichungen werden sofort ausgebucht,\
    größere gehen an die Lagerleitung."
set text [join [lrepeat 30 $absatz] "\n\n"]

# erste Grundlinie, im Satzspiegel
set oben [expr {[dict get $ctx top] + 10}]

$pdf startPage
pdf4tcllib::drawing::watermark $pdf $ctx "ENTWURF" -size 110
$pdf setFont 16 [pdf4tcllib::fonts::fontSansBold]
pdf4tcllib::unicode::safeText $pdf "Inventur im Lager Nord" \
    -x [dict get $ctx left] -y [expr {$oben + 6}]

set r [pdf4tcllib::flow::columns $pdf $ctx $text -columns 2 -size 10 \
    -top $oben -firsty [expr {$oben + 36}] -newpage {
        pdf4tcllib::page::number $pdf $ctx [$pdf currentPage]
        $pdf endPage
        $pdf startPage
        pdf4tcllib::drawing::watermark $pdf $ctx "ENTWURF" -size 110
        pdf4tcllib::page::header $pdf $ctx "Inventur im Lager Nord"
    }]
pdf4tcllib::page::number $pdf $ctx [$pdf currentPage]
$pdf endPage
puts "Ergebnis: $r"

# Ohne -newpage: was nicht passt, kommt in "rest" zurueck
$pdf startPage
set r2 [pdf4tcllib::flow::columns $pdf $ctx $text \
    -columns 3 -top $oben]
$pdf endPage
puts "ohne -newpage: [dict get $r2 lines] Zeilen gesetzt,\
    [llength [split [dict get $r2 rest] \n]] Zeilen in rest"

$pdf write -file 070-spalten.pdf
$pdf destroy
```

```text
Ergebnis: column 1 y 472.6929133858268 pages 1 lines 150 rest {}
ohne -newpage: 136 Zeilen gesetzt, 116 Zeilen in rest
```

Das Ergebnis ist ein Dict:

| Schlüssel | Bedeutung |
|---|---|
| `column` | Spalte, in der der Text endet (ab 0) |
| `y` | y unter der letzten Zeile |
| `pages` | Zahl der Seitenwechsel |
| `lines` | gesetzte Zeilen |
| `rest` | was nicht gesetzt wurde, leer wenn alles passte |

### Der Seitenwechsel gehört dem Aufrufer

Ist die letzte Spalte voll, ruft `columns` das Skript aus `-newpage` im
Bereich des Aufrufers auf. Es muss die alte Seite schließen und eine
neue öffnen, und alles hineinschreiben, was eine neue Seite braucht:
Seitenzahl, Kopfzeile, Wasserzeichen. Danach setzt `columns` Schrift und
Größe selbst wieder.

**Ohne `-newpage` hört `columns` auf**, wenn die Spalten der Seite voll
sind, und gibt den Rest in `rest` zurück. Im Beispiel passen in drei
Spalten 136 Zeilen auf die Seite; 116 Zeilen samt den Leerzeilen zwischen
den Absätzen stehen in `rest`. Wer `rest` nicht prüft, verliert den Rest
des Texts ohne Meldung.

### Die erste Grundlinie

`columns` setzt die erste Zeile jeder Spalte mit ihrer Grundlinie auf
`-top`. Ohne Angabe ist das `top` aus dem Kontext, und die Oberlängen
ragen in den Rand. Das Beispiel gibt `-top` darum 10 Punkt tiefer an.

`-firsty` gilt nur für die erste Spalte der ersten Seite. Die zweite
Spalte daneben beginnt wieder bei `-top`. Eine Überschrift über beide
Spalten braucht darum `-firsty` **und** genug Platz in der zweiten
Spalte; im Beispiel steht sie nur über der ersten.

### Was nicht geht

- `-align` steht in den Vorgaben (`flow::configure`), wirkt aber nicht:
  Jede Zeile wird linksbündig gesetzt.
- Schrift, Größe und Zeilenabstand gelten für den ganzen Text. Eine
  Zwischenüberschrift im Fluss geht nur, indem man den Text aufteilt und
  `columns` mehrmals aufruft, mit `-firsty` aus dem `y` des vorigen
  Aufrufs.
- Der Text geht durch `safeText`; typografische Anführungszeichen werden
  gerade (Kapitel [Unicode sicher ausgeben](030-unicode-sicher-ausgeben.md)).

Mehr Spalten sparen keine Seiten. Schmale Spalten brechen öfter um und
lassen am Zeilenende mehr frei. Spalten sind eine Frage der Lesbarkeit:
Eine Zeile mit 60 bis 80 Zeichen liest sich leichter als eine mit 130.

`flow::configure` ändert die Vorgaben für alle späteren Aufrufe im
Programm. Eine Bibliothek, die `columns` benutzt, gibt ihre Optionen
darum beim Aufruf mit, statt die Vorgaben ihres Aufrufers zu ändern.

---

## Wasserzeichen

```tcl
pdf4tcllib::drawing::watermark pdf ctx text ?-size pt? ?-angle grad? \
    ?-color {r g b}? ?-font name?
```

[drawing::watermark]{.index} schreibt einen Text in Grau schräg über die
Seitenmitte. Es gibt die verwendete Schriftgröße zurück.

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-size` | `0` | `0`: so groß, dass der Text die Diagonale weitgehend füllt |
| `-angle` | `45` | Winkel gegen den Uhrzeigersinn |
| `-color` | `{0.86 0.86 0.86}` | Grauton |
| `-font` | aus `fonts::init` | Schrift |

**Zuerst zeichnen.** pdf4tcl kennt keine Transparenz; das Wasserzeichen
ist deckendes Hellgrau. Was danach kommt, liegt darüber. Im Beispiel
steht es darum direkt nach `startPage`, auch im `-newpage`-Skript.

Mit `-size 0` wird „ENTWURF“ auf A4 etwa 180 Punkt groß und reicht von
der linken bis fast an die rechte Papierkante. Eine feste Größe um 110
Punkt lässt Rand und wirkt ruhiger.

Das Wasserzeichen ist für Seiten mit `-orient 1` gebaut. Mit `-orient 0`
landet es außerhalb der Seite.

`pdftotext` gibt gedrehten Text verwürfelt zurück. Ob das Wasserzeichen
richtig steht, sieht man nur in einem Betrachter.

---

## Zusammenfassung

- `flow::columns` setzt Text in Spalten über Seiten; den Seitenwechsel
  liefert der Aufrufer als `-newpage`-Skript.
- Ohne `-newpage` steht der Rest in `rest`; immer prüfen.
- `-top` eine Zeile unter `top`, sonst ragt die erste Zeile in den Rand.
- `-align` wirkt nicht; Spalten sparen keine Seiten.
- `drawing::watermark` zuerst auf jeder Seite, mit fester Größe um 110
  Punkt, nur mit `-orient 1`.

---

*Nächstes Kapitel: [Tabellen mit Seitenumbruch](080-tabellen.md)*
