# Treeview

## Einführung

Viele Tk-Programme zeigen ihre Daten in einem `ttk::treeview`: Lager mit
Artikeln, Projekte mit Aufgaben, Ordner mit Dateien. Der Wunsch „das als
PDF“ heißt dann: genau das, was im Fenster steht. Das Paket
[pdf4tcltreeview]{.index} liest das Widget aus und zeichnet es, entweder
als Tabelle mit eingerückter Baumspalte oder als Gliederung.

Es ist eine dünne Schicht über `table::draw` (Kapitel
[Tabellen mit Seitenumbruch](080-tabellen.md)). Es braucht Tk, denn es
liest ein Widget.

---

## Tabelle oder Gliederung

Ein Treeview ist zugleich Tabelle und Baum. Im PDF muss man sich
entscheiden, und darum gibt es zwei Prozeduren statt einer Option,
[treeview::render]{.index} und [treeview::outline]{.index}:

| Prozedur | zeichnet | im barrierefreien PDF |
|---|---|---|
| treeview::render | Tabelle, die Baumspalte eingerückt | `Table`, `TR`, `TD` |
| treeview::outline | nur die Baumspalte, als Liste | `L`, `LI`, `LBody` |

Beide geben die y-Position nach dem Letzten zurück.

---

## Ein Lagerbestand

```tcl
# 170-treeview.tcl -- ein ttk::treeview als Tabelle und als Gliederung
package require Tk
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcltreeview

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]

# Das Widget: Baumspalte #0 plus zwei Wertespalten
ttk::treeview .tv -columns {menge wert} -show {tree headings}
.tv heading #0    -text "Lager / Artikel"
.tv heading menge -text "Menge"
.tv heading wert  -text "Wert €"
.tv column #0    -width 260
.tv column menge -width 80 -anchor e
.tv column wert  -width 100 -anchor e

foreach {lager offen artikel} {
    "Lager Nord" 1 {{"Schraube M6" 600 29.40} {"Schraube M8" 400 31.20}
                    {"Mutter M8" 900 18.00}}
    "Lager Süd"  1 {{"Dübel 8 mm" 1200 42.00}
                    {"Winkel 40 mm" 150 67.50}}
    "Außenlager" 0 {{"Palette leer" 34 0.00}}
} {
    set summe 0.0
    foreach a $artikel { set summe [expr {$summe + [lindex $a 2]}] }
    set k [.tv insert {} end -text $lager -open $offen \
        -values [list "" [format %.2f $summe]]]
    foreach a $artikel {
        lassign $a name menge wert
        .tv insert $k end -text $name \
            -values [list $menge [format %.2f $wert]]
    }
}
pack .tv
update idletasks

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Seite 1: wie auf dem Bildschirm -- das Aussenlager ist zugeklappt
$pdf startPage
set x [dict get $ctx left]
set y [pdf4tcllib::treeview::render $pdf .tv $x [dict get $ctx top] \
    -maxwidth 300 -ctx $ctx]
puts "Tabelle wie angezeigt endet bei y = [format %.1f $y]"
# Dasselbe mit allen Zweigen
set y [pdf4tcllib::treeview::render $pdf .tv $x [expr {$y + 30}] \
    -maxwidth 300 -ctx $ctx -all 1]
puts "Tabelle mit -all 1 endet bei y = [format %.1f $y]"
$pdf endPage

# Seite 2: nur die Baumspalte als eingerueckte Liste, mit einem
# Lesezeichen je Knoten
$pdf startPage
set y [pdf4tcllib::treeview::outline $pdf .tv $x [dict get $ctx top] \
    -all 1]
puts "Gliederung endet bei y = [format %.1f $y]"
$pdf endPage

$pdf write -file 170-treeview.pdf
$pdf destroy
exit                        ;# sonst wartet Tk auf Ereignisse
```

```text
Tabelle wie angezeigt endet bei y = 200.7
Tabelle mit -all 1 endet bei y = 390.7
Gliederung endet bei y = 182.7
```

Seite 1 als Text:

```text
Lager / Artikel   Menge   Wert €
Lager Nord                 78.60
  Schraube M6       600    29.40
  Schraube M8       400    31.20
  Mutter M8         900    18.00
Lager Süd                 109.50
  Dübel 8 mm       1200    42.00
  Winkel 40 mm      150    67.50
Außenlager                  0.00
```

Die zweite Tabelle hat darunter noch „Palette leer“.

### Das Skript braucht ein exit

Mit `package require Tk` wartet `tclsh` nach dem letzten Befehl auf
Ereignisse, statt sich zu beenden. Das `exit` am Ende gehört darum dazu.
Das Fenster muss nicht zu sehen sein, aber Tk braucht eine Anzeige. Auf
einem Server ohne Bildschirm läuft das Skript mit
`xvfb-run tclsh 170-treeview.tcl`.

Das `update idletasks` vor dem Export empfiehlt die Dokumentation des
Pakets. Im Beispiel ändert es nichts, weil alle Spalten eine feste
Breite haben; bei Spalten, die Tk erst beim Anzeigen ausrechnet, ist es
der sichere Weg.

---

## render

```tcl
set y [pdf4tcllib::treeview::render pdf tv x y ?option wert ...?]
```

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-maxwidth` | `480` | Breite der Tabelle |
| `-fontsize` | `9` | Schriftgröße |
| `-all` | `0` | `1`: auch zugeklappte Zweige |
| `-tree` | `1` | `0`: Baumspalte nicht einrücken |
| `-indentW` | `12` | Einrückung je Ebene |
| `-zebra`, `-border` | `1`, `1` | Streifen, Linien |
| `-ctx` | – | Seitenkontext; schaltet den Umbruch ein |
| `-font`, `-boldfont` | – | Schriften statt der aus `fonts::init` |
| `-summary` | – | Zusammenfassung der Tabelle (barrierefrei) |

**Was zugeklappt ist, bleibt zugeklappt.** Das PDF zeigt, was im Fenster
zu sehen ist; im Beispiel fehlt in der ersten Tabelle der Inhalt des
Außenlagers. `-all 1` nimmt alles.

Die Spaltenbreiten kommen in Pixeln aus dem Widget und werden auf
`-maxwidth` umgerechnet; das Verhältnis bleibt. Die Ausrichtung kommt aus
`-anchor` der Spalte: `e` wird rechtsbündig.

Was `render` nicht liest: Farben und Schriften einzelner Einträge
(`-tags` mit `tag configure`), Bilder. Die Knoten „Lager Nord“ usw.
stehen in derselben Schrift wie die Artikel. `-rowstyles` von
`table::draw` reicht `render` nicht durch; wer Gruppenzeilen fett will,
liest das Widget selbst aus und ruft `table::draw` direkt auf.

### Seitenumbruch

Mit `-ctx` bricht die Tabelle am unteren Rand um, aber mit dem
eingebauten Umbruch von `table::draw`: `- 1 -` unten rechts, keine
Kopf- und Fußzeile auf der Folgeseite. `-pagebreakcmd` gibt es bei
`render` nicht; wer sie angibt, bekommt einen Fehler mit der Liste der
bekannten Optionen.

---

## outline

```tcl
set y [pdf4tcllib::treeview::outline pdf tv x y ?option wert ...?]
```

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-fontsize` | `10` | Schriftgröße |
| `-indentW` | `14` | Einrückung je Ebene |
| `-lineH` | `0` | Zeilenabstand; `0` heißt 1,4 × Größe |
| `-all` | `0` | auch zugeklappte Zweige |
| `-bookmarks` | `1` | ein Lesezeichen je Knoten |
| `-font` | – | Schrift |

Ein Knoten ohne Text nimmt den ersten Wert.

### Lesezeichen

`-bookmarks 1` legt für jeden Knoten ein Lesezeichen an, in der Tiefe
des Baums: „Schraube M6“ hängt unter „Lager Nord“. Im Beispiel ist das
die Vorgabe. Bis pdf4tcltreeview 0.1 entstand keines: `outline` rief
`bookmarkAdd` in einer Form auf, die pdf4tcl nicht versteht, und fing
den Fehler still ab. Wer noch mit 0.1 arbeitet, legt sie selbst an:

```tcl
proc lesezeichen {tv knoten ebene} {
    global pdf
    foreach k [$tv children $knoten] {
        $pdf bookmarkAdd -title [$tv item $k -text] -level $ebene
        lesezeichen $tv $k [expr {$ebene + 1}]
    }
}
lesezeichen .tv {} 0
```

Die Lesezeichen zeigen auf den Anfang der Seite, auf der sie angelegt
werden; eine Stelle auf der Seite kennt `bookmarkAdd` nicht.

---

## Beides in einem Dokument

Tabelle und Gliederung beschreiben dieselben Daten. Ein Vorleseprogramm
liest beide vor, wenn beide da sind. Wer beide braucht (Übersicht vorn,
Tabelle hinten), setzt sie auf getrennte Seiten und sagt in einer
Überschrift, was folgt.

---

## Zusammenfassung

- `treeview::render` für die Tabelle, `treeview::outline` für die
  Gliederung; beide brauchen Tk.
- Das Skript endet mit `exit`; ohne Bildschirm mit `xvfb-run`.
- Zugeklappte Zweige fehlen, außer mit `-all 1`.
- `outline` legt je Knoten ein Lesezeichen an (seit 0.1.1).
- Umbruch nur der eingebaute, ohne Kopfzeile.

---

*Nächstes Kapitel: [Barrierefreie PDFs](180-barrierefreie-pdfs.md)*
