# Canvas-Export

## Einführung

Methode [`canvas`]{.index} am Dokument zeichnet ein Tk-Widget auf die
Seite. Vorher `update`, damit Layout und Items stehen. Drei
Widget-Klassen, drei Codepfade.

Braucht **wish** bzw. gesetztes `DISPLAY`.

---

## Klassisches Canvas

```tcl
package require Tk
package require pdf4tcl 0.9.4.69

wm withdraw .
canvas .c -width 400 -height 300 -background white
pack .c
.c create rectangle 10 10 120 80 -fill #cde -outline black
.c create text 65 45 -text "Probe" -anchor center
update idletasks

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set bb [.c bbox all]
$pdf canvas .c -bbox $bb -x 50 -y 50 -width 400 -height 300
$pdf endPage
$pdf write -file canvas.pdf
$pdf destroy
```

`-bbox` ist der Quellbereich im Canvas. `-x` / `-y` / `-width` /
`-height` liegen auf der PDF-Seite. `-sticky` steuert das Einpassen
(`nw` Default). Weitere Optionen: `-bg`, `-fontmap`, `-textscale`.

Ohne `update` ist `bbox` oft leer oder veraltet. Leere bbox: die
Methode kehrt still zurück, die Seite bleibt leer.

---

## tkpath und tko::path

Dieselbe Methode: `$pdf canvas .path …`. Bei PathCanvas und TkoPath
ist `-bbox` **Pflicht**.

Die [Matrix]{.index}-Form unterscheidet sich:

| Widget | Matrix |
|--------|--------|
| `tkpath` | verschachtelt |
| `tko::path` | flach `{a b c d tx ty}` |

Die Formen nicht mischen. pdf4tcl erwartet für tko die flache Form.

window-Items werden oft übersprungen. Photo vorher per `addImage`
anmelden, wenn der Export das Bild sonst nicht findet.

---

## Schriftabbildung

Text außerhalb Latin-1: TrueType unter dem **Tk-Familiennamen** laden
(seit 0.9.4.60), dann kein `-fontmap`:

```tcl
pdf4tcl::loadBaseTrueTypeFont Base tahoma.ttf
pdf4tcl::createFontSpecCID Base Tahoma
.c create text 20 30 -text "Grüße" -font {Tahoma 14}
$pdf canvas .c -bbox [.c bbox all]
puts [$pdf getSubstCount]
```

Wo der Name nicht frei wählbar ist, `-fontmap` setzen. Die Abbildung
gewinnt immer gegen die Familien-Suche.

Der Schlüssel ist nicht derselbe:

- `tk::canvas`: **ganze** Font-Spezifikation — `{Helvetica 14}` liegt
  nicht unter `Helvetica`. Ein benannter Font trifft sicherer.
- `tko::path`: nur die **Familie**.

Falscher Schlüssel: Fragezeichen, kein Fehler. Deshalb
`getSubstCount`.

---

## Text-Baseline

PDF-Text sitzt auf der **Baseline**, Canvas-Text am `-anchor`. Ein
sichtbarer Versatz in Y ist erwartet, wenn Anker `nw` und PDF-Text
ohne Korrektur gemischt werden. Innerhalb von `$pdf canvas` übernimmt
pdf4tcl die Item-Anker.

---

## Zusammenfassung

- `update`, dann `bbox`, dann `$pdf canvas`.
- Drei Klassen: `canvas`, PathCanvas, TkoPath.
- tko: flache Matrix. tkpath: verschachtelt.
- `-fontmap` oder Familienname; `getSubstCount` prüfen.

---

*Nächstes Kapitel: [Formulare erzeugen](080-formulare-erzeugen.md)*
