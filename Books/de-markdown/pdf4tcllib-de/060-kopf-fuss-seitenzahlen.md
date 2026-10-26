# Kopf- und Fußzeilen, Seitenzahlen

## Einführung

Kopf- und Fußzeilen stehen auf jeder Seite, und sie werden in dem
Moment geschrieben, in dem eine Seite beginnt oder endet. pdf4tcllib
liefert die drei Bausteine dafür (Kapitel
[Einheiten und Seitenkontext](040-einheiten-und-seitenkontext.md)); wann
sie aufgerufen werden, entscheidet der eigene Code. Dieses Kapitel legt
diese Stelle fest und löst die Frage, die jeder Bericht irgendwann
stellt: „Seite 2 von wie vielen?“

---

## Eine Stelle für den Seitenwechsel

Alles, was auf jede Seite gehört, steht in einer Prozedur, die die alte
Seite abschließt und die neue beginnt: im vorigen Kapitel `neueSeite`.
Wer Kopf und Fuß an mehreren Stellen schreibt, vergisst sie an einer.

| Was | Wann | Prozedur |
|---|---|---|
| Fußzeile, Seitenzahl | bevor die Seite endet | `page::footer`, `page::number` |
| Kopfzeile, Wasserzeichen | nachdem die neue Seite beginnt | `page::header`, `drawing::watermark` |
| y auf den Anfang | nach der Kopfzeile | `dict get $ctx top` |

Die Fußzeile gehört an das Ende einer Seite, nicht an ihren Anfang: Erst
dann ist sicher, dass die Seite Inhalt hat und dass ihre Nummer
stimmt.

Die drei Bausteine schreiben in den Rand, nicht in den Satzspiegel:

| Baustein | Lage (y nach unten) |
|---|---|
| `page::header` | Text bei halbem Rand von oben, Linie 2 pt über `top` |
| `page::footer` | Linie 2 pt unter `bottom`, Text bei halbem Rand von unten |
| `page::number` | wie der Text der Fußzeile, in der Mitte |

Bei 20 mm Rand steht der Text der Kopf- und Fußzeile 10 mm von der
Papierkante. Mit kleinerem Rand rückt er näher heran; bei 10 mm Rand sind
es 5 mm, und das kann für einen Drucker zu knapp sein.

---

## Seite 2 von 3

Wie viele Seiten ein Dokument hat, steht erst fest, wenn es fertig ist.
Die Fußzeile der ersten Seite ist dann aber längst geschrieben. Die
übliche Lösung: das Dokument zweimal setzen. Der erste Durchlauf geht in
ein Dokument, das nur gezählt und dann verworfen wird; der zweite weiß
die Zahl.

```tcl
# 060-seite-x-von-y.tcl -- "Seite 2 von 3": zwei Durchlaeufe
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]

# Der ganze Bericht als Prozedur: sie bekommt das Dokument und die
# Gesamtzahl der Seiten ("" im ersten Durchlauf) und hat keine
# Nebenwirkungen -- sie laeuft zweimal.
proc bericht {pdf gesamt} {
    global ctx
    set font [pdf4tcllib::fonts::fontSans]
    set lh   [pdf4tcllib::page::lineheight 11]
    set seite 0
    set y 0
    set neu {
        if {$seite > 0} { rand $pdf $seite $gesamt; $pdf endPage }
        $pdf startPage
        incr seite
        if {$seite > 1} {
            pdf4tcllib::page::header $pdf $ctx "Lagerbericht Oktober"
        }
        set y [dict get $ctx top]
    }
    eval $neu
    for {set i 1} {$i <= 120} {incr i} {
        if {$y + $lh > [dict get $ctx bottom]} { eval $neu }
        set y [expr {$y + $lh}]
        $pdf setFont 11 $font
        pdf4tcllib::unicode::safeText $pdf "Position $i: geprüft" \
            -x [dict get $ctx left] -y $y
    }
    rand $pdf $seite $gesamt
    $pdf endPage
}

proc rand {pdf seite gesamt} {
    global ctx
    set label "Seite %s"
    if {$gesamt ne ""} { append label " von $gesamt" }
    pdf4tcllib::page::footer $pdf $ctx "Vertraulich" $seite 9 \
        -pagelabel $label
}

# Durchlauf 1: in ein Wegwerf-Dokument, nur um die Seiten zu zaehlen
set probe [pdf4tcl::new %AUTO% -paper a4 -orient true]
bericht $probe ""
set gesamt [$probe pageCount]
$probe destroy

# Durchlauf 2: das echte Dokument
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
bericht $pdf $gesamt
$pdf write -file 060-seite-x-von-y.pdf
$pdf destroy
puts "Seiten: $gesamt"
```

```text
Seiten: 3
```

Die Fußzeilen lauten „Seite 1 von 3“, „Seite 2 von 3“, „Seite 3 von 3“.
Die erste Seite hat keine Kopfzeile, die folgenden „Lagerbericht
Oktober“.

Was dafür nötig ist:

- **Der Inhalt steht in einer Prozedur**, die das Dokument als Argument
  bekommt. Sie läuft zweimal und darf darum nichts tun, was beim zweiten
  Mal anders ausgeht: nicht in eine Datei anhängen, keinen Zähler
  außerhalb hochzählen, nicht aus einem Kanal lesen, der danach leer ist.
  Daten, die aus einer Datenbank kommen, einmal vorher lesen und der
  Prozedur übergeben.
- **Die Seitenzahl darf den Umbruch nicht ändern.** „Seite 9 von 9“ und
  „Seite 9 von 10“ sind verschieden breit, aber beide stehen in der
  Fußzeile, außerhalb des Satzspiegels. Der Inhalt bricht in beiden
  Durchläufen gleich um. Wer die Gesamtzahl im Text verwendet („Dieser
  Bericht hat 3 Seiten“), kann die Zahl der Zeilen ändern; dann den
  zweiten Durchlauf gegen den ersten prüfen.
- **`-pagelabel` nimmt ein Format.** `page::footer` setzt die
  Seitenzahl mit `format` ein. „Seite %s von 3“ ergibt „Seite 2 von 3“.
  Ein Prozentzeichen im Text muss darum `%%` lauten.

Das Wegwerf-Dokument kostet nur Rechenzeit; geschrieben wird es nicht.
`$probe pageCount` zählt die abgeschlossenen Seiten, darum endet auch der
erste Durchlauf mit `endPage`.

Das Paket `pdf4tcltoc` arbeitet nach demselben Prinzip, um das
Inhaltsverzeichnis mit echten Seitenzahlen vor den Text zu setzen (Kapitel
Inhaltsverzeichnis).

---

## Seitenzahl ohne Wort

`page::number` schreibt `- 2 -` oder `- 2 / 3 -` in die Mitte, ohne
Sprache. Das passt, wenn es keine Fußzeile mit Text gibt:

```tcl
pdf4tcllib::page::number $pdf $ctx [$pdf currentPage] $gesamt
```

Mit `""` als Gesamtzahl erscheint nur die Nummer. Das ist im ersten
Durchlauf praktisch, in dem die Zahl noch nicht bekannt ist.

---

## Zusammenfassung

- Kopf, Fuß, Wasserzeichen und Seitenanfang gehören in eine Prozedur
  für den Seitenwechsel.
- Fußzeile vor `endPage`, Kopfzeile nach `startPage`.
- „Seite X von Y“: das Dokument zweimal setzen, die Gesamtzahl aus
  `$probe pageCount`; der Inhalt als Prozedur ohne Nebenwirkungen.
- `-pagelabel "Seite %s von $gesamt"`; ein `%` im Text als `%%`.

---

*Nächstes Kapitel: [Spaltenfluss und Wasserzeichen](070-spaltenfluss-wasserzeichen.md)*
