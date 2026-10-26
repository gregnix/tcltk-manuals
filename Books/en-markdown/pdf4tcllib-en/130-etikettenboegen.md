# Label Sheets

## Introduction

Address labels, shelf tags, shipping stickers: a sheet with 24 labels is
a page with 24 rectangles whose position has to be accurate to a tenth
of a millimeter. The package [pdf4tcllabels]{.index} knows the
dimensions of common sheets, distributes the records over the positions
and starts new sheets. What goes on a label is written once by the
caller, as a script.

---

## The Sheets

| Name | Grid | per sheet | Label (mm) | Margin l/t (mm) |
|---|---|---|---|---|
| `3427` | 2 × 2 | 4 | 105.0 × 148.0 | 0 / 0 |
| `3474` | 3 × 8 | 24 | 70.0 × 37.0 | 0 / 0 |
| `3475` | 3 × 7 | 21 | 70.0 × 42.3 | 0 / 0.45 |
| `3483` | 3 × 5 | 15 | 70.0 × 50.8 | 0 / 21.5 |
| `4737` | 3 × 9 | 27 | 63.5 × 29.6 | 7.25 / 13.0 |

All on A4. 3427 is an A6 shipping label; 4737 is the only sheet with gaps
between the labels.

[labels::sheet]{.index} returns the dimensions of a sheet as a dict, in
points for calculation and in millimeters for comparison with the
package:

```tcl
set geo [pdf4tcllib::labels::sheet 3474]
dict get $geo cols            ;# 3
dict get $geo w               ;# 198.425... (Punkt)
dict get $geo wmm             ;# 70.0
```

A sheet of one's own is added with `labels::define`, in millimeters:

```tcl
pdf4tcllib::labels::define regal {
    w 48.5 h 25.4 cols 4 rows 10 left 8.0 top 21.5
    pitchx 50.0 pitchy 25.4 desc "Regalschilder aus dem Schrank"
}
```

`pitchx` and `pitchy` are the distance from label to label, not the gap.
On sheets without gaps they equal the label size.

---

## Addresses on Two Sheets

Thirty addresses, and the sheet has already been used: the first two
labels are missing.

```tcl
# 130-etiketten.tcl -- Adressetiketten auf Bogen 3474 (3 x 8)
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcllabels

pdf4tcllib::fonts::init -cid 1

set adressen {}
set lang "Gebrüder Hoffmann-Schwarzenbach Metallbau GmbH & Co. KG"
for {set i 1} {$i <= 30} {incr i} {
    lappend adressen [dict create \
        name    [expr {$i == 5 ? $lang : "Firma Beispiel $i"}] \
        strasse "Industriestraße $i" \
        ort     "[expr {10000 + $i}] Musterstadt"]
}

set geo [pdf4tcllib::labels::sheet 3474]
puts "Bogen 3474: [dict get $geo cols] x [dict get $geo rows],\
    [dict get $geo wmm] x [dict get $geo hmm] mm"

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
set bogen [pdf4tcllib::labels::render $pdf 3474 $adressen {x y w h a} {
    set font [pdf4tcllib::fonts::fontSans]
    set fett [pdf4tcllib::fonts::fontSansBold]
    set breit [expr {$w - 16}]
    set name [dict get $a name]
    # Name: kleiner setzen, bis 8 pt; reicht das nicht, zwei Zeilen
    set g [pdf4tcllib::labels::fitSize $pdf $fett $name $breit 11 8]
    $pdf setFont $g $fett
    if {[$pdf getStringWidth $name] <= $breit} {
        set zeilen [list $name]
    } else {
        set zeilen [pdf4tcllib::labels::wrap $pdf $name $breit]
        set zeilen [lrange $zeilen 0 1]
    }
    set ty [expr {$y + 26 - 5 * ([llength $zeilen] - 1)}]
    foreach z $zeilen {
        $pdf text $z -x [expr {$x + 8}] -y $ty
        set ty [expr {$ty + $g + 1}]
    }
    $pdf setFont 10 $font
    set tx [expr {$x + 8}]
    $pdf text [dict get $a strasse] -x $tx -y [expr {$y + 46}]
    $pdf text [dict get $a ort]     -x $tx -y [expr {$y + 60}]
} -start 2 -clip 1 -frame layer]
puts "Bögen: $bogen"
$pdf write -file 130-etiketten.pdf
$pdf destroy
```

```text
Bogen 3474: 3 x 8, 70.0 x 37.0 mm
Bögen: 2
```

On the first sheet, positions 1 and 2 stay empty, addresses 1 to 22 fill
the rest, and the remaining eight are on the second sheet.

### render

```tcl
set boegen [pdf4tcllib::labels::render pdf bogen datensätze \
    {x y w h satz} skript ?option wert ...?]
```

[labels::render]{.index} opens and closes the pages itself; a
`startPage` before it is wrong. For each record, the script runs in the
caller's scope with the five variables from the list: top left corner,
width and height in points, and the record as it appears in the list.
The return value is the number of sheets.

| Option | Default | Meaning |
|---|---|---|
| `-start N` | `0` | leave the first N positions empty |
| `-only {i j ...}` | – | use exactly these positions, for reprints |
| `-offsetx`, `-offsety` | `0.0` | printer offset in millimeters |
| `-clip` | `0` | `1`: draw nothing beyond the edge of the label |
| `-frame` | `0` | `1`: print outlines permanently, `layer`: outlines as a layer that can be switched off |
| `-tag` | `Sect` | structure element per label in the accessible PDF |

Unknown options are an error.

`-start` applies to the first sheet only. How many labels are already
missing is known only to whoever holds the sheet; a program that asks
for it saves half a sheet per print run.

### Outlines for Checking

`-frame 1` draws the outline of each label into the page, below the
content. That is for a test print on paper, not for the labels
themselves. `-frame layer` puts the outlines into a layer "Label grid",
above the content; the viewer can switch it off, and it is not printed.
This way the screen shows whether everything lies within the label, and
the same file is printed. `-frame layer` requires pdf4tcl 0.9.4.70 or
newer and does not work with PDF/A.

---

## Text That Is Too Long

A label is narrow: at 11 points, 70 mm hold about 35 characters. A long
company name would otherwise run over the edge onto the neighboring
label. The package has three helpers, [labels::fitSize]{.index},
`labels::wrap` and `labels::ellipsize`, all with real width
measurement:

| Procedure | does |
|---|---|
| labels::fitSize `pdf schrift text maxB größe ?min?` | shrinks in steps of 0.5 pt, not below `min` (default 6) |
| `labels::wrap pdf text maxB` | wraps into lines at spaces, using the current font |
| `labels::ellipsize pdf text maxB ?ende?` | shortens and appends `…` |

The example works in two stages: first shrink down to 8 points; if the
name still does not fit, use two lines. Label 5 ("Gebrüder
Hoffmann-Schwarzenbach Metallbau GmbH & Co. KG") thus appears in two
lines at 8 points.

`fitSize` stops at `min`, even if the text still does not fit. The
result therefore has to be measured again, as the example does with
`getStringWidth`. `wrap` measures with the font that is currently set;
call `setFont` first.

`ellipsize` is meant for remarks and references. A shortened street is
not an address.

`text::fitSize` from the chapter [Setting Text](050-text-setzen.md) does
the same as `labels::fitSize`, but with a different argument order and
in whole points. Do not mix the two up.

### -clip as a Safeguard

`-clip 1` cuts off everything that reaches beyond the edge of the label.
That does not replace fitting, because the rest of the name is then
simply missing. But it prevents a forgotten case from writing on the
neighboring label.

---

## Calibrating the Printer

Hardly any printer places output accurate to the millimeter. An offset
of one or two millimeters is common, and on a sheet without margins
such as 3474 the first line then slides half off the label.

```tcl
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
pdf4tcllib::labels::calibration $pdf 3474
$pdf write -file kalibrierung.pdf
```

`calibration` writes a sheet with a millimeter scale along the edges and
the outlines of all labels. Print it, lay it on a real sheet, hold both
against the light, read off the offset. From then on, the two numbers
go to `render` as `-offsetx` and `-offsety`, once per printer.

Print at **actual size**. "Fit to page" shrinks by a few percent:
invisible in the first row, several millimeters in the last.

---

## Summary

- `labels::render` with a sheet name, records and a script per label;
  it creates the pages itself.
- `-start` for partly used sheets, `-only` for reprints.
- Fit long names with `fitSize` and `wrap`, `-clip 1` as a safeguard.
- Calibrate the printer once with `calibration` and pass the offset.

---

*Next chapter: [Images](140-bilder.md)*
