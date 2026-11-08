# Tablelist

## Einführung

Dieser Teil handelt von Tk-Programmen, die ihre Daten schon in einem
Widget zeigen: in einer `tablelist`, einem `text`, einem `canvas` oder
einem `ttk::treeview`. Der Wunsch „das als PDF“ heißt dann: genau das,
was im Fenster steht, in der Reihenfolge, in der es dort steht. Für jedes
der vier Widgets gibt es ein Paket, und alle vier sind **Adapter**: Sie
lesen das Widget aus und überlassen das Zeichnen einem Teil von
pdf4tcllib, der ohne Tk auskommt. Alle vier brauchen Tk und damit eine
Anzeige.

Das erste ist [pdf4tcltable]{.index} für die `tablelist` von Csaba
Nemethi. Es liest Spalten, Werte, Farben, Schriften und die Baumtiefe aus
dem Widget und gibt sie an `table::draw` weiter (Kapitel
[Tabellen mit Seitenumbruch](080-tabellen.md)). Wer die Daten schon als
Tcl-Listen hat und kein Widget, ruft `table::draw` direkt auf.

---

## Eine Bestellung

```tcl
# 172-tablelist.tcl -- eine tablelist als PDF: Farben, Format, Fusszeile
package require Tk
package require tablelist_tile
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcltable

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]

# Eine Zahl so zeigen, wie sie im Fenster stehen soll
proc euro {wert} {
    if {![string is double -strict $wert]} { return $wert }
    return [string map {. ,} [format "%.2f €" $wert]]
}

tablelist::tablelist .tbl -stripebackground "#eef3fb" \
    -columns {6 "Pos" right  28 "Artikel" left  8 "Menge" right
              12 "Preis" right  12 "Summe" right}
.tbl columnconfigure 3 -formatcommand euro
.tbl columnconfigure 4 -formatcommand euro
pack .tbl -fill both -expand 1

set gesamt 0.0
foreach {artikel menge preis} {
    "Tontopf, natur, 12 cm"   40  1.20
    "Tontopf, natur, 18 cm"   25  2.90
    "Untersetzer 18 cm"       25  0.80
    "Blumenerde, 20 l"        12  4.50
    "Rankhilfe, Bambus"       30  0.65
} {
    set summe [expr {$menge * $preis}]
    set gesamt [expr {$gesamt + $summe}]
    .tbl insert end [list [expr {[.tbl size] + 1}] $artikel $menge $preis $summe]
}
update idletasks
# Hervorheben wie auf dem Bildschirm: eine Zeile, eine Zelle
.tbl rowconfigure 3 -background "#fff2cc"
.tbl cellconfigure 1,4 -foreground "#b00000" -font {Helvetica 9 bold}

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set x [dict get $ctx left]
set y [dict get $ctx top]
pdf4tcllib::tablelist::render $pdf .tbl $x $y \
    -maxwidth [dict get $ctx text_w] -ctx $ctx -yvar y \
    -footer [list "" "Gesamt" "" "" [euro $gesamt]]
puts "Tabelle endet bei y = [format %.1f $y]"
puts "Bericht: [pdf4tcllib::tablelist::report]"

# Dieselbe Tabelle ohne Formatierung: die Rohwerte
pdf4tcllib::tablelist::render $pdf .tbl $x [expr {$y + 20}] \
    -maxwidth [dict get $ctx text_w] -formatted 0 -zebra 0 -yvar y
puts "Rohwerte enden bei y = [format %.1f $y]"

# Eine umbrechende Spalte: im Fenster mehrzeilig, im PDF nicht
.tbl columnconfigure 1 -wrap 1 -width 12
update idletasks
pdf4tcllib::tablelist::renderRange $pdf .tbl $x [expr {$y + 20}] \
    -maxwidth 300 -firstrow 0 -lastrow 1 -yvar y
puts "Bericht: [pdf4tcllib::tablelist::report]"
$pdf endPage

$pdf write -file 172-tablelist.pdf
$pdf destroy
exit                        ;# sonst wartet Tk auf Ereignisse
```

```text
Tabelle endet bei y = 168.7
Bericht: images 0 cells {} wrapped 0 windows 0
Rohwerte enden bei y = 284.7
Bericht: images 0 cells {0,1 1,1} wrapped 2 windows 0
```

Die erste Tabelle als Text:

```text
Pos Artikel                 Menge   Preis    Summe
  1 Tontopf, natur, 12 cm      40   1,20 €   48,00 €
  2 Tontopf, natur, 18 cm      25   2,90 €   72,50 €
  3 Untersetzer 18 cm          25   0,80 €   20,00 €
  4 Blumenerde, 20 l           12   4,50 €   54,00 €
  5 Rankhilfe, Bambus          30   0,65 €   19,50 €
    Gesamt                                  214,00 €
```

Die Namen der Befehle stehen im Namensraum `pdf4tcllib::tablelist`; das
Paket legt dazu `pdf4tcltable::render` und `pdf4tcltable::renderRange`
als gleichwertige Namen an.

### Das Skript braucht eine Anzeige

Wie jedes Skript in diesem Teil endet es mit `exit`, sonst wartet Tk nach
dem letzten Befehl auf Ereignisse. Auf einem Server ohne Bildschirm läuft
es mit `xvfb-run tclsh 172-tablelist.tcl`. Farbnamen wie `lightblue`
übersetzt Tk mit `winfo rgb`, und das braucht ein Fenster, das nicht
versteckt ist; Hex-Farben wie `#fff2cc` gehen immer.

`update idletasks` steht vor dem ersten `cellconfigure`: Die tablelist
legt ihre Zellen erst dann an, vorher meldet `cellconfigure` einen
Fehler über einen unbekannten Tag.

---

## Was aus dem Widget kommt

| Im Widget | Im PDF |
|---|---|
| `-columns`, `-title`, `-align` | Kopfzeile, Ausrichtung |
| `-width` der Spalte (Zeichen) | Anteil an `-maxwidth` |
| `-hide 1` | Spalte fehlt |
| `-formatcommand` | der formatierte Wert |
| `-stripebackground` | Zebrastreifen |
| `rowconfigure`, `cellconfigure` (`-background`, `-foreground`, `-font`) | Farbe und Schrift der Zeile, der Zelle |
| `insertchild`, Baumtiefe | Einrückung um `-indentW` je Ebene |

**Die Breiten sind Verhältnisse.** Die tablelist gibt Breiten in
Zeichen an. Das Paket rechnet sie auf `-maxwidth` um: Im Beispiel sind es
6 + 28 + 8 + 12 + 12 = 66 Zeichen, die Spalte „Artikel“ bekommt 28/66 der
Breite. `-width 0` (automatisch) zählt als 5 Zeichen.

**Zelle vor Zeile vor Zebra.** Hat eine Zelle eine eigene Farbe, gewinnt
sie; sonst die der Zeile, sonst der Streifen. Im Beispiel ist Zeile 3
gelb und die Summe in Zeile 1 rot und fett.

**Schriften.** Mit `fonts::init` stehen die TrueType-Schriften bereit,
und Zellen, Kopf und Fuß nehmen sie: Das Euro-Zeichen kommt an. Eine
Tk-Schrift in einer Zelle (`{Helvetica 9 bold}`) wird auf den passenden
Schnitt abgebildet, normal, fett, kursiv oder dicktengleich. `-font` und
`-boldfont` setzen die beiden Schnitte für einen Aufruf.

### -formatcommand

Die Spalten „Preis“ und „Summe“ haben ein `-formatcommand`. Die tablelist
ruft es mit **einem** Argument auf, dem Wert der Zelle; eine Prozedur mit
zwei Parametern führt zu `wrong # args`. Wer mehr braucht, gibt ein
Präfix mit: `-formatcommand {format_mit EUR}`.

Mit `-formatted 1`, der Vorgabe, kommt der formatierte Wert ins PDF, mit
`-formatted 0` der gespeicherte. Die zweite Tabelle im Beispiel zeigt
`48.0` statt `48,00 €`.

### Die Fußzeile

`-footer` nimmt eine Liste von Werten, eine je Spalte, oder ein zweites
tablelist-Widget, aus dessen Zeile 0 die Werte kommen. Die Fußzeile steht
fett unter einer stärkeren Linie.

Eine Liste geht **nicht** durch `-formatcommand`. Im Beispiel steht
darum `[euro $gesamt]` in der Liste; mit `$gesamt` allein stünde
`214.0` unter einer Spalte aus Euro-Beträgen.

---

## Was nicht ankommt

Drei Dinge kann der Export nicht übertragen:

| Im Widget | Im PDF |
|---|---|
| `cellconfigure -image` | nichts |
| `cellconfigure -window` | nichts; der Wert der Zelle als Text |
| `columnconfigure -wrap 1` | eine Zeile, gekürzt mit `...` |

Am meisten kostet die letzte Zeile. Im Fenster steht der Artikel nach
`-wrap 1` auf zwei Zeilen, im PDF steht „Tontopf, natur...“.

Damit das nicht still passiert, zählt das Paket mit.
[tablelist::report]{.index} gibt zurück, was beim **letzten** Aufruf
fehlte: Bilder, Fenster, gekürzte Zellen und die Zellen als `zeile,spalte`.
Eine Zeile geht zusätzlich an `::pdf4tcl::warnings`. Eine umbrechende
Spalte allein zählt nicht; gezählt wird ein Wert, der länger ist als die
Spalte.

Ein eingebettetes Widget, etwa ein Checkbutton, erscheint als sein Wert:
`0` oder `1`.

---

## Über mehrere Seiten

Mit `-ctx` bricht `render` am unteren Rand um, mit dem eingebauten
Umbruch von `table::draw`: Die Kopfzeile der Tabelle steht auf jeder
Seite, unten rechts `- 1 -`, aber keine Kopf- und Fußzeile der Seite. `-pagebreakcmd` reicht `render` nicht durch.
`-pagevar` nimmt die Seitenzahl entgegen und gibt sie zurück.

Wer den Umbruch selbst steuern will, etwa für eine eigene Kopfzeile je
Seite, nimmt [tablelist::renderRange]{.index} mit `-firstrow` und
`-lastrow` und zählt die Zeilen je Seite selbst. `renderRange` zeichnet
je Aufruf eine Kopfzeile, aber keine Fußzeile und bricht nicht um.

```tcl
set rh [expr {int(9 * 1.8)}]          ;# Zeilenhöhe bei -fontsize 9
set proSeite [expr {int(([dict get $ctx bottom] - $y) / $rh) - 1}]
for {set von 0} {$von < [.tbl size]} {incr von $proSeite} {
    if {$von > 0} { $pdf endPage; $pdf startPage; set y [dict get $ctx top] }
    pdf4tcllib::tablelist::renderRange $pdf .tbl $x $y -yvar y \
        -firstrow $von -lastrow [expr {$von + $proSeite - 1}]
}
```

---

## Optionen

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-maxwidth` | `480` | Breite der Tabelle |
| `-fontsize` | `9` | Schriftgröße |
| `-rowheight` | `0` | Zeilenhöhe; `0` heißt 1,8 × Größe |
| `-zebra`, `-border` | `1`, `1` | Streifen, Linien |
| `-tree`, `-indentW` | `1`, `12` | Baum einrücken, je Ebene |
| `-formatted` | `1` | Werte durch `-formatcommand` |
| `-headerbg`, `-headerfg` | aus dem Widget | Farben der Kopfzeile, `{r g b}` |
| `-footer` | – | Werte oder Widget (nur `render`) |
| `-footerbg`, `-footerbold` | hellgrau, `1` | Fußzeile |
| `-ctx` | – | Seitenkontext; schaltet den Umbruch ein (nur `render`) |
| `-yvar`, `-pagevar` | – | Variablen für y und Seitenzahl |
| `-font`, `-boldfont` | aus `fonts::init` | Schriften für diesen Aufruf |
| `-firstrow`, `-lastrow` | `0`, `-1` | nur `renderRange` |

Eine unbekannte Option meldet einen Fehler mit der Liste der bekannten.

---

## Zusammenfassung

- `tablelist::render` zeichnet die tablelist, wie sie im Fenster steht,
  über `table::draw`.
- Breiten werden Verhältnisse, Farben gelten Zelle vor Zeile vor Zebra.
- `-formatcommand` hat ein Argument; eine Fußzeile als Liste wird nicht
  formatiert.
- Bilder, Fenster und umbrochene Zellen kommen nicht an;
  `tablelist::report` sagt, was fehlte.
- `-ctx` für den eingebauten Umbruch, `renderRange` für den eigenen.

---

*Nächstes Kapitel: [Text-Widget](174-text-widget.md)*
