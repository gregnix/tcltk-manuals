# Text-Widget

## Einführung

Ein Tk-`text` mit Tags ist ein kleiner Satzspiegel: Überschrift, fette
Wörter, Code, Links, eingerückte Absätze. Das Paket
[pdf4tcltext]{.index} liest das Widget mit `$t dump -all` aus, Zeichen
für Zeichen mit den Tags, die dort gelten, und setzt den Text mit diesen
Eigenschaften ins PDF. Es bricht die Zeilen selbst um, an Wortgrenzen und
in der Breite `-maxwidth`.

---

## Ein Pflegehinweis

```tcl
# 174-text-widget.tcl -- ein Tk-Text mit Tags als PDF
package require Tk
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcltext

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]

# Die TrueType-Schrift aus fonts::init ein zweites Mal anmelden, unter
# dem Tk-Familiennamen des Widgets: so findet das Paket sie, statt auf
# Helvetica auszuweichen
pdf4tcl::createFontSpecCID _Pdf4tcl_Base_Regular "DejaVu Sans"
pdf4tcl::createFontSpecCID _Pdf4tcl_Base_Bold    "DejaVu Sans-Bold"

# Schriften mit Leerzeichen im Namen: als benannte Schrift
font create normal -family "DejaVu Sans" -size 11
font create titel  -family "DejaVu Sans" -size 16 -weight bold
font create fett   -family "DejaVu Sans" -size 11 -weight bold
font create klein  -family "DejaVu Sans" -size 8

text .t -width 70 -height 20 -wrap word -font normal
.t tag configure h1     -font titel -foreground "#1a2f5a" \
    -spacing1 8 -spacing3 6 -justify center
.t tag configure fett   -font fett
.t tag configure code   -font {Courier 10} -background "#eeeeee"
.t tag configure link   -foreground "#0044aa" -underline 1
.t tag configure alt    -overstrike 1 -foreground "#888888"
.t tag configure hoch   -font klein -offset 4
.t tag configure zitat  -lmargin1 30 -lmargin2 30 -foreground "#555555"
.t tag configure intern -elide 1

.t insert end "Pflegehinweis Tontöpfe\n" h1
.t insert end "Neue Töpfe vor dem Bepflanzen "
.t insert end "zwei Stunden" fett
.t insert end " wässern. Der Preis sinkt von "
.t insert end "2,90 €" alt
.t insert end " auf 2,50 €. Fläche des Bodens: 113 cm"
.t insert end "2" hoch
.t insert end ". Datenblatt: "
.t insert end "pflege.pdf" link
.t insert end ", Artikelnummer "
.t insert end "TT-18" code
.t insert end ".\n"
.t insert end "Ton atmet; im Winter frostfrei lagern, sonst platzt die\
 Glasur. Das gilt auch für Untersetzer.\n" zitat
.t insert end "Nur für den Laden: Einkauf 1,10 €\n" intern
pack .t
update idletasks

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set x [dict get $ctx left]
set y [pdf4tcllib::textwidget::render $pdf .t $x [dict get $ctx top] \
    -maxwidth 300]
puts "Text endet bei y = [format %.1f $y]"
# Mit dem ausgeblendeten Text
set y [pdf4tcllib::textwidget::render $pdf .t $x [expr {$y + 30}] \
    -maxwidth 300 -skipelided 0]
puts "mit -skipelided 0 bis y = [format %.1f $y]"
$pdf endPage

$pdf write -file 174-text-widget.pdf
$pdf destroy
exit                        ;# sonst wartet Tk auf Ereignisse
```

```text
Text endet bei y = 180.8
mit -skipelided 0 bis y = 352.5
```

Der erste Durchgang als Text:

```text
        Pflegehinweis Tontöpfe
Neue Töpfe vor dem Bepflanzen zwei Stunden wässern.
Der Preis sinkt von 2,90 € auf 2,50 €. Fläche des Bodens:
113 cm2. Datenblatt: pflege.pdf, Artikelnummer TT-18.
    Ton atmet; im Winter frostfrei lagern, sonst platzt die
    Glasur. Das gilt auch für Untersetzer.
```

Im PDF ist die Überschrift blau und zentriert, „zwei Stunden“ fett, der
alte Preis grau und durchgestrichen, die „2“ hochgestellt, der Link blau
und unterstrichen, die Artikelnummer in Courier auf grauem Grund und der
letzte Absatz eingerückt. Die Zeile „Nur für den Laden“ fehlt, weil ihr
Tag `-elide 1` hat; der zweite Durchgang mit `-skipelided 0` zeigt sie.

`textwidget::render` gibt die y-Position nach der letzten Zeile zurück.
Das Paket legt dazu `pdf4tcltext::render` als gleichwertigen Namen an.

---

## Die Schriften

Hier liegt die einzige Stelle, an der man nachdenken muss.

**Jede Tk-Schrift wird gesucht.** Für den Text ohne Schrift-Tag ist das
die `-font` des Widgets, für einen Tag mit `-font` dessen Schrift. Das
Paket liest Familie, Größe, fett und kursiv daraus und sucht eine
PDF-Schrift:

1. eine Schrift, die unter genau diesem Familiennamen angemeldet ist,
   für fett mit `-Bold`, für kursiv mit `-Italic` oder `-Oblique`
   dahinter (`DejaVu Sans-Bold`);
2. sonst eine der 14 Standardschriften: Courier für Courier und alles
   mit „Mono“, Times für Times, Georgia und `serif`, sonst Helvetica.

Die Standardschriften kennen nur Latin-1. `fonts::init` meldet seine
Schriften unter eigenen Namen an (`Pdf4tclSans` und Verwandte, Kapitel
[Einrichten und Schriften](020-einrichten-und-schriften.md)), nicht
unter `DejaVu Sans`. Darum meldet das Beispiel die TrueType-Schrift aus
`fonts::init` mit `createFontSpecCID` ein zweites Mal an, unter den
Namen, die das Widget benutzt: `DejaVu Sans` und `DejaVu Sans-Bold`.
`_Pdf4tcl_Base_Regular` und `_Pdf4tcl_Base_Bold` sind die Namen, unter
denen `fonts::init` die Dateien geladen hat; derselbe Weg steht im
Kapitel [Formular-Layout](120-formular-layout.md) für cp1252. Dann steht
der ganze Text in der TrueType-Schrift, das Euro-Zeichen eingeschlossen.

**`-fontfamily` und `-fontsize`** legen die Schrift für den Text ohne
Schrift-Tag fest, statt sie aus dem Widget zu nehmen. `-fontfamily` darf
ein PDF-Schriftname sein (`Pdf4tclSans`) oder ein Tk-Familienname, der
wie oben gesucht wird. Die Größe des Widgets kommt in Punkt, so wie Tk
sie auflöst; eine Angabe in Pixeln wird umgerechnet.

**Familiennamen mit Leerzeichen** gehören in eine benannte Schrift
(`font create`) oder in die Optionsform `{-family "DejaVu Sans" -size 11}`.
In der Listenform `{DejaVu Sans 11 bold}` wird „Sans“ als Größe gelesen.

---

## Was aus den Tags kommt

| Tag-Option | Im PDF |
|---|---|
| `-font` | Schrift und Größe, wie oben |
| `-foreground`, `-background` | Textfarbe, Fläche dahinter |
| `-underline`, `-overstrike` | Linie in der Textfarbe |
| `-offset` | Grundlinie hoch (positiv) oder tief (negativ) |
| `-justify` | `center`, `right` innerhalb von `-maxwidth` |
| `-lmargin1` | Einzug, für alle Zeilen des Absatzes |
| `-spacing1`, `-spacing3` | Abstand vor und nach dem Absatz |
| `-elide` | Text fehlt, außer mit `-skipelided 0` |

**Pixel werden Punkte.** `-lmargin1`, `-spacing1`, `-spacing3` und
`-offset` sind im Widget Pixel. Das Paket rechnet mit 0,75 um, also
96 dpi: 30 Pixel Einzug werden 22,5 Punkt.

**Mehrere Tags auf einem Wort** werden zusammengeführt, nach der
Priorität des Widgets: Ein später angelegter Tag gewinnt, `tag raise`
und `tag lower` ändern das.

**Hochgestellt wird nicht kleiner.** `-offset` verschiebt nur die
Grundlinie. Die kleinere Schrift gibt das Beispiel dem Tag `hoch` selbst,
so wie es auch am Bildschirm nötig ist.

**`-justify` gilt je Zeile.** Das erste Stück einer Zeile entscheidet,
wie bei Tk.

**Farbnamen** wie `red` übersetzt Tk mit `winfo rgb`; das braucht ein
Fenster, das nicht versteckt ist. Hex-Farben gehen immer.

---

## Was nicht ankommt

| Im Widget | Im PDF |
|---|---|
| `-lmargin2`, `-rmargin`, `-spacing2` | nicht gelesen; `-linespacing` statt `-spacing2` |
| `-wrap none` oder `char` | es wird immer an Wortgrenzen umbrochen |
| eingebettetes Fenster | `[Widget]` |
| eingebettetes Bild | `[Bild: name]` |
| `-relief`, `-borderwidth`, Auswahl | nichts |

Ein Wort, das breiter ist als `-maxwidth`, wird nicht abgeschnitten,
sondern ragt hinaus.

**Kein Seitenumbruch.** `render` schreibt in einer Spalte nach unten,
auch über den unteren Rand. Wer mehr Text hat als eine Seite, teilt ihn
auf: in mehrere Widgets, je Abschnitt eines, oder er zeichnet längeren
Fließtext ohne Widget mit `text::writeParagraph` oder `flow::columns`
(Kapitel [Text setzen](050-text-setzen.md),
[Spaltenfluss](070-spaltenfluss-wasserzeichen.md)).

Im barrierefreien PDF wird jede Zeile ein `P` mit `Span` für die Stücke;
Flächen und Linien sind Artefakte.

---

## Optionen

| Option | Vorgabe | Bedeutung |
|---|---|---|
| `-maxwidth` | `480` | Breite; hier wird umbrochen |
| `-fontsize` | aus dem Widget | Größe für Text ohne Schrift-Tag |
| `-fontfamily` | aus dem Widget | Schrift für Text ohne Schrift-Tag: PDF-Schriftname oder Tk-Familie |
| `-linespacing` | `2` | zusätzlicher Zeilenabstand in Punkt |
| `-skipelided` | `1` | ausgeblendeten Text weglassen |
| `-skipinternal` | `1` | die Marken `sel` und `insert` übergehen |
| `-ctx` | – | Seitenkontext |
| `-yvar` | – | Variable für die y-Position |

---

## Zusammenfassung

- `textwidget::render` setzt einen Tk-Text mit seinen Tags und bricht in
  `-maxwidth` um.
- Die Schrift des Widgets und die der Tags werden unter ihrem
  Familiennamen gesucht, sonst unter den Standardschriften; für Unicode
  die TrueType-Schrift unter diesem Namen anmelden.
- `-fontfamily` und `-fontsize` legen die Schrift ohne Tag fest.
- Pixel × 0,75 = Punkt.
- Kein Seitenumbruch; längere Texte teilen.

---

*Nächstes Kapitel: [Canvas](176-canvas.md)*
