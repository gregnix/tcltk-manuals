# Fallstudie: Lagerbericht

## Einführung

Ein Bericht über die Lagerbewegungen eines Monats, von den Rohdaten bis
zum fertigen PDF: Zwischensummen und Kreuztabelle, ein Diagramm, eine
Tabelle über mehrere Seiten mit Kopf- und Fußzeilen, ein
Inhaltsverzeichnis mit echten Seitenzahlen und ein Strukturbaum. Jeder
Teil stammt aus einem früheren Kapitel; hier laufen sie in einem Skript
zusammen, und an den Nahtstellen zeigt sich, worauf es ankommt.

| Teil | Kapitel |
|---|---|
| `table::group`, `table::pivot` | [Gruppensummen und Kreuztabellen](090-gruppen-und-kreuztabellen.md) |
| `chart::bar` | [Diagramme](100-diagramme.md) |
| `table::draw` mit `-ctx` und `-pagebreakcmd` | [Tabellen mit Seitenumbruch](080-tabellen.md) |
| `page::header`, `page::footer` | [Kopf- und Fußzeilen](060-kopf-fuss-seitenzahlen.md) |
| `toc::document`, `toc::heading` | [Inhaltsverzeichnis](110-inhaltsverzeichnis.md) |
| `tagged`, `metadata` | [Barrierefreie PDFs](180-barrierefreie-pdfs.md) |

---

## Das Skript

```tcl
# 210-fallstudie.tcl -- Lagerbericht: Tabellen, Diagramm, Verzeichnis
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclchart
package require pdf4tcltoc

pdf4tcllib::fonts::init -cid 1

# --- 1. Daten: vor dem Inhalt laden, er laeuft zweimal
# Bewegungen {Lager Gruppe Artikel Menge Wert}, nach Lager sortiert
set bewegungen {}
set nr 0
foreach lager {Nord Süd West} {
    incr nr
    for {set i 1} {$i <= 22} {incr i} {
        set gruppe [lindex {Schrauben Dübel Werkzeug} [expr {$i % 3}]]
        set menge  [expr {($i * 7 + $nr * 11) % 40 - 8}]
        set wert   [format %.2f [expr {$menge * (1.5 + $i % 5)}]]
        lappend bewegungen [list $lager $gruppe \
            [format "%s-%03d" [string index $lager 0] $i] $menge $wert]
    }
}
set g [pdf4tcllib::table::group $bewegungen -by 0 -sum {3 4} \
    -label "Summe %s" -totallabel "Gesamt" -blank 1]
set p [pdf4tcllib::table::pivot $bewegungen -row 0 -col 1 -value 4 \
    -rowlabel Lager -colorder {Schrauben Dübel Werkzeug}]

# Wert je Lager fuer das Diagramm: die Zeile "Gesamt" der Kreuztabelle
# hat die Spaltensummen, die letzte Spalte jeder Zeile die Zeilensumme
set balken {}
foreach z [lrange [dict get $p rows] 0 end-1] {
    lappend balken [lindex $z 0] [lindex $z end]
}

set stile {}
foreach i [dict get $g subtotals] { lappend stile $i {-font bold} }
lappend stile [dict get $g total] {-font bold -bg {0.85 0.85 0.85}}

proc betrag {v} {
    if {[string is double -strict $v]} { return [format %.2f $v] }
    return $v
}

# --- 2. Seitenwechsel: Fuss auf die alte, Kopf auf die neue Seite
# Laeuft im globalen Bereich; dort ist pdf im ersten Durchlauf das
# Wegwerf-Dokument, im zweiten das echte.
proc seitenwechsel {} {
    global pdf ctx
    pdf4tcllib::page::footer $pdf $ctx "Lagerbericht Oktober" \
        [$pdf currentPage]
    $pdf endPage
    $pdf startPage
    pdf4tcllib::page::header $pdf $ctx "Lagerbericht Oktober"
    return [expr {[dict get $ctx top] + 10}]
}

# --- 3. Der Inhalt als Skript
set inhalt {
    set x [dict get $ctx left]
    set w [dict get $ctx text_w]

    $pdf startPage
    set y [dict get $ctx top]
    pdf4tcllib::toc::heading $pdf $ctx y 1 "Überblick"
    set y [pdf4tcllib::text::writeParagraph $pdf "Bewegungen der drei\
        Lager im Oktober, bewertet zum Einstandspreis. Negative Mengen\
        sind Abgänge." $x $y $w 11]
    set y [pdf4tcllib::chart::bar $pdf $x [expr {$y + 10}] $w 160 \
        $balken -title "Wert je Lager (€)" -values 1 -format %.0f \
        -alt "Balkendiagramm: Wert der Bewegungen je Lager"]

    set y [expr {$y + 16}]
    pdf4tcllib::toc::heading $pdf $ctx y 2 "Lager und Warengruppe"
    set kopf [lmap h [dict get $p header] {
        set a right
        if {$h eq "Lager"} { set a left }
        list -header $h -width 90 -align $a
    }]
    set y [pdf4tcllib::table::draw $pdf $x $y $kopf \
        [lmap z [dict get $p rows] { lmap v $z { betrag $v } }] \
        -rowstyles [list [dict get $p total] {-font bold}] \
        -summary "Wert je Lager und Warengruppe"]
    pdf4tcllib::page::footer $pdf $ctx "Lagerbericht Oktober" \
        [$pdf currentPage]
    $pdf endPage

    $pdf startPage
    pdf4tcllib::page::header $pdf $ctx "Lagerbericht Oktober"
    set y [expr {[dict get $ctx top] + 10}]
    pdf4tcllib::toc::heading $pdf $ctx y 1 "Bewegungen"
    set y [pdf4tcllib::table::draw $pdf $x $y {
        {-header Lager   -width 50}
        {-header Gruppe  -width 80}
        {-header Artikel -width 60}
        {-header Menge   -width 50 -align right}
        {-header Wert    -width 70 -align right}
    } [lmap z [dict get $g rows] {
        lset z end [betrag [lindex $z end]]
    }] \
        -ctx $ctx -zebra 1 -rowstyles $stile \
        -pagebreakcmd seitenwechsel -summary "Bewegungen je Lager"]
    pdf4tcllib::page::footer $pdf $ctx "Lagerbericht Oktober" \
        [$pdf currentPage]
    $pdf endPage
}

# --- 4. Dokument: Strukturbaum, Verzeichnis, zwei Durchlaeufe
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf tagged 1 -lang de-DE
$pdf metadata -title "Lagerbericht Oktober" -author "Lagerverwaltung"
$pdf viewerPreferences -displaydoctitle 1
set ::pdf4tcl::warnings {}
set r [pdf4tcllib::toc::document $pdf a4 $inhalt -title "Inhalt"]

puts "Verzeichnis: [dict get $r tocPages] Seite(n),\
    Inhalt: [dict get $r contentPages] Seiten"
foreach e [dict get $r entries] { puts "  $e" }
puts "ohne Element: [$pdf getUntaggedCount]"
$pdf write -file 210-fallstudie.pdf
$pdf destroy
foreach m $::pdf4tcl::warnings { puts "Warnung: $m" }
```

```text
Verzeichnis: 1 Seite(n), Inhalt: 3 Seiten
  1 Überblick 2
  2 {Lager und Warengruppe} 2
  1 Bewegungen 3
ohne Element: 0
```

Das PDF hat vier Seiten:

| Seite | Inhalt |
|---|---|
| 1 | Verzeichnis „Inhalt“ mit drei Einträgen |
| 2 | „Überblick“: Absatz, Balkendiagramm, Kreuztabelle |
| 3 | „Bewegungen“: Kopfzeile, Tabelle bis zu „S-018“ |
| 4 | Kopfzeile, Fortsetzung der Tabelle mit wiederholter Spaltenzeile, „Summe West“ und „Gesamt“ |

Das Skript besteht aus vier Teilen, die Kommentare zählen sie.

---

## 1. Die Daten zuerst

`toc::document` führt den Inhalt zweimal aus
([Inhaltsverzeichnis](110-inhaltsverzeichnis.md)). Alles, was nur einmal
geschehen darf, steht darum davor: die Daten erzeugen, gruppieren,
umformen. Im Bericht eines echten Programms käme hier die Abfrage an die
Datenbank; ein zweites Lesen aus demselben Kanal fände ihn leer.

Aus einer Liste entstehen drei Darstellungen:

- `table::group` fügt je Lager eine Zwischensumme und am Ende die
  Gesamtsumme ein, für die lange Tabelle. Die Zeilen müssen nach Lager
  sortiert sein; `group` sortiert nicht.
- `table::pivot` macht daraus die Kreuztabelle Lager mal Warengruppe.
  `-colorder` legt die Spalten fest, sonst stünden sie alphabetisch.
- Das Diagramm braucht Paare aus Name und Wert. Die liefert die
  Kreuztabelle schon: Die letzte Spalte jeder Zeile ist die Zeilensumme,
  die letzte Zeile („Gesamt“) bleibt weg.

Die Summen aus `group` und `pivot` sind rohe Tcl-Zahlen. `betrag`
formatiert sie erst beim Zeichnen, damit die Daten selbst Zahlen
bleiben.

---

## 2. Der Seitenwechsel

`-pagebreakcmd` läuft im globalen Bereich
([Tabellen mit Seitenumbruch](080-tabellen.md)). Die Prozedur
`seitenwechsel` holt sich `pdf` und `ctx` darum mit `global`. Das geht
hier gut, weil `toc::document` die Variable `pdf` im Bereich des
Aufrufers setzt: Im ersten Durchlauf steht darin das Wegwerf-Dokument,
im zweiten das echte. Eine Prozedur, die stattdessen das Dokument in
einer eigenen Variablen hielte, würde im ersten Durchlauf in das falsche
schreiben.

Die Seitennummer in der Fußzeile ist `[$pdf currentPage]`. Im ersten
Durchlauf fehlt die Verzeichnisseite, die Nummern sind dort um eins zu
klein. Das schadet nicht: Die Fußzeile verschiebt nichts, und gedruckt
wird nur der zweite Durchlauf. Dort zählt das Verzeichnis mit, und die
Fußzeile sagt „Seite 2“, wo das Verzeichnis „Überblick ... 2“ sagt.

---

## 3. Der Inhalt

Das Skript beginnt und beendet seine Seiten selbst. Die erste
Inhaltsseite hat keine Kopfzeile, nur die Fußzeile; ab der zweiten setzt
das Skript beide, und auf den Folgeseiten der Tabelle tut es
`seitenwechsel`.

Zwei Abstände sind von Hand gesetzt: 10 Punkt vor dem Diagramm und
16 Punkt danach. `chart::bar` gibt die Unterkante seines Kastens
zurück, `toc::heading` setzt die Überschrift genau dorthin. Ohne den
Abstand klebt „Lager und Warengruppe“ an der Achsenbeschriftung.

Die Zeile „Summe Nord“ beginnt mit einer verbundenen Zelle über drei
Spalten. Seit pdf4tcllib 0.6.7 zieht `table::draw` keine senkrechte
Linie mehr hindurch; vorher stand dort „Summe No|rd“.

---

## 4. Das Dokument

Drei Zeilen machen den Bericht barrierefrei:

- `tagged 1 -lang de-DE` schaltet den Strukturbaum ein und nennt die
  Sprache;
- `metadata -title` gibt den Titel;
- `viewerPreferences -displaydoctitle 1` lässt den Betrachter den Titel
  statt des Dateinamens zeigen.

Die Bausteine erledigen den Rest: `toc::heading` setzt `H1` und `H2`,
`text::writeParagraph` ein `P`, `table::draw` die Tabellen mit Kopfzellen,
`chart::bar` ein `Figure` mit Ersatztext, und Kopf- und Fußzeilen sind
Artefakte. `getUntaggedCount` meldet 0. Das Wegwerf-Dokument des ersten
Durchlaufs hat keinen Strukturbaum; dort tun die Bausteine nichts davon.

`::pdf4tcl::warnings` bleibt leer. Mit pdf4tclchart 0.1.1 stand hier
noch „the Figure element is empty“: Das Diagramm war ganz als Artefakt
markiert, und das `Figure` hatte keinen Inhalt.

---

## Was bewusst fehlt

- **„Seite X von Y“.** `toc::document` nennt die Gesamtzahl erst
  hinterher (`contentPages` plus `tocPages`), wenn die Fußzeilen schon
  gezeichnet sind. Der Weg von Hand aus
  [Inhaltsverzeichnis](110-inhaltsverzeichnis.md) kennt sie früher:
  Nach dem Probelauf mit `toc::collect` hat das Wegwerf-Dokument
  `pageCount` Seiten, dazu kommen die Seiten aus `toc::pageCount`.
- **Ein Deckblatt.** `toc::document` schreibt das Verzeichnis als erste
  Seite. Ein Deckblatt davor geht nur von Hand, mit `collect`,
  `pageCount` und `render`.
- **Mehrzeilige Zellen.** `table::draw` kürzt zu lange Texte; für
  Bemerkungen wäre `table::render` die Wahl.
- **Zahlen mit Dezimalkomma.** `format %.2f` schreibt einen Punkt. Für
  einen deutschen Bericht gehört ein `string map {. ,}` in `betrag`;
  im Diagramm geht das nicht, `-format` kennt kein Dezimalkomma.

---

## Zusammenfassung

- Daten vor `toc::document` laden und umformen; der Inhalt läuft zweimal.
- `group` für die lange Tabelle, `pivot` für die Übersicht, die
  Diagrammwerte aus der Kreuztabelle.
- `-pagebreakcmd` mit `global pdf`: im ersten Durchlauf das
  Wegwerf-Dokument, im zweiten das echte.
- Abstände um Diagramme von Hand; `chart::bar` endet an seiner
  Unterkante.
- `tagged`, `metadata -title`, `displaydoctitle`; den Rest machen die
  Bausteine.

---

*Nächstes Kapitel: [Fallen](800-anhang-fallen.md)*
