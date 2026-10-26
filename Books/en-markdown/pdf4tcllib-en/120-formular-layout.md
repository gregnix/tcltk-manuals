# Form Layout

## Introduction

In pdf4tcl, a fillable form consists of fields that are placed at a
position with `addForm`. Labels, spacing, sections and the arithmetic
of where the next field goes are left to the caller. The namespace
[form]{.index} in pdf4tcllib takes over this layout: a label on the
left, the field on the right, the next one a line further down.

How fields themselves work (types, values, calculation, JavaScript) is
explained in the book *pdf4tcl*. This chapter shows the structure and
the places where a form from pdf4tcllib looks different than expected.

---

## The Building Blocks

The procedures [form::section]{.index}, [form::labelField]{.index},
[form::row]{.index}, `form::separator`, [form::orderTable]{.index} and
[form::sumLine]{.index} all take `pdf`, `ctx` and the **name** of the y variable and
move it further down:

| Procedure | draws |
|---|---|
| form::section `pdf ctx yVar titel` | a gray bar with a bold title |
| form::labelField `pdf ctx yVar beschriftung typ ?option ...?` | label and field on one line |
| form::row `pdf ctx yVar felder` | several pairs side by side |
| `form::separator pdf ctx yVar` | a thin line |
| form::orderTable `pdf ctx yVar köpfe breiten ?zeilen? ?option ...?` | an item table |
| form::sumLine `pdf ctx yVar breiten text wert ?option ...?` | the total line below it |

The types are those of `addForm`: `text`, `password`, `checkbox`,
`combobox`, `listbox`, `radiobutton`, `pushbutton`, `signature`. The
x position comes from `SX` in the context, the width from `SW`.

---

## An Order Form

```tcl
# 120-formular.tcl -- ein ausfuellbares Bestellformular
package require pdf4tcl
package require pdf4tcllib

pdf4tcllib::fonts::init -cid 1
# Formularfelder brauchen eine Schrift mit cp1252: dieselbe
# TrueType-Datei ein zweites Mal angemeldet, fuer form:: eingestellt
pdf4tcl::createFont _Pdf4tcl_Base_Regular FormSans     cp1252
pdf4tcl::createFont _Pdf4tcl_Base_Bold    FormSansBold cp1252
pdf4tcllib::form::configure -fontFamily FormSans \
    -fontFamilyBold FormSansBold
set ctx [pdf4tcllib::page::context a4 -margin 20]
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set y [expr {[dict get $ctx top] + 10}]
# Rahmen und Hintergrund gibt jedes Feld selbst an
set rahmen {-bordercolor {0.6 0.6 0.6} -borderwidth 1
            -bgcolor {0.97 0.97 0.97}}

pdf4tcllib::form::section    $pdf $ctx y "Kunde"
pdf4tcllib::form::labelField $pdf $ctx y "Name:" text -id f_name \
    -init "Müller GmbH" {*}$rahmen
pdf4tcllib::form::labelField $pdf $ctx y "E-Mail:" text -id f_mail \
    {*}$rahmen
# row nimmt dieselben Angaben als Schluessel ohne Bindestrich
set r [dict create bordercolor {0.6 0.6 0.6} borderwidth 1 \
    bgcolor {0.97 0.97 0.97} labelw 40 type text]
pdf4tcllib::form::row $pdf $ctx y [list \
    [dict merge $r {label "PLZ:" width 120 id f_plz}] \
    [dict merge $r {label "Ort:" width 260 id f_ort}]]
pdf4tcllib::form::labelField $pdf $ctx y "Versand:" combobox \
    -id f_versand -options {Paket Spedition "Abholung Lager Süd"} \
    -init Paket -fieldw 150 {*}$rahmen
# Das Kaestchen bekommt seinen Rahmen als Grafik (siehe Text)
set labelW [dict get [pdf4tcllib::form::configure] labelW]
set xk [expr {[dict get $ctx SX] + $labelW + 4}]
$pdf setStrokeColor 0.6 0.6 0.6
$pdf rectangle $xk $y 12 12
$pdf setStrokeColor 0 0 0
pdf4tcllib::form::labelField $pdf $ctx y "Eilig:" checkbox \
    -id f_eilig -fieldw 12 -fieldh 12
pdf4tcllib::form::separator  $pdf $ctx y

pdf4tcllib::form::section    $pdf $ctx y "Bestellung"
set breiten {40 230 60 90}
set zahl {number decimals 2 sep de}
pdf4tcllib::form::orderTable $pdf $ctx y \
    {Pos Artikel Menge Betrag} $breiten \
    {{1 "Schraube M8" 100 "12.50"}} -emptyRows 3 -cellForm f_pos \
    -cellOpts [list 3 [list -align right -format $zahl]]
# Die Summe rechnet der Betrachter: aus den Feldern der Spalte Betrag
set betraege [lmap r {0 1 2 3} { string cat f_pos_ $r _3 }]
pdf4tcllib::form::sumLine $pdf $ctx y $breiten "Summe:" "" \
    -id f_summe -init "12.50" -calculate [list sum $betraege] \
    -format $zahl
pdf4tcllib::form::labelField $pdf $ctx y "Bemerkung:" text -id f_bem \
    -multiline 1 -fieldh 40 {*}$rahmen

$pdf endPage
$pdf write -file 120-formular.pdf
$pdf destroy
puts "y am Ende: [format %.1f $y]"
```

```text
y am Ende: 388.7
```

The PDF contains 24 fields: Name, E-Mail, PLZ (postal code), Ort
(city), Versand (shipping), Eilig (urgent), sixteen cells of the item
table (`f_pos_0_0` to `f_pos_3_3`), the total and the Bemerkung
(remark).

### labelField

Everything `labelField` does not know itself is passed to `addForm`:
`-id`, `-init`, `-options`, `-multiline`, the border colors. Three
options belong to `labelField`:

| Option | Default | Meaning |
|---|---|---|
| `-labelw` | `90` | width of the label |
| `-fieldw` | rest of the line | width of the field |
| `-fieldh` | `16` | height of the field |

`-fieldw` applies to every type. A checkbox without `-fieldw` is
therefore as wide as the whole line; that is why the example has
`-fieldw 12 -fieldh 12`.

### row

`row` takes a list of dicts with the keys `label`, `type`, `width`
(label and field together), `id`, `init`, `options`, `labelw`,
`fieldh` and the appearance keys `bordercolor`, `borderwidth`,
`bgcolor`, `align`, `calculate`, `format`. Without `labelw`, the label
is as wide as its text.

### orderTable and sumLine

`orderTable` draws a header row (white on dark blue), the rows from
`zeilen` and `-emptyRows` empty rows in addition. Without `-cellForm`
the cells are printed text; with `-cellForm präfix` they are text
fields with the ID `präfix_zeile_spalte` (prefix, row, column).
`-cellOpts {spalte {optionen}}` gives the fields of one column further
options for `addForm`, in the example right-aligned and numeric.

`sumLine` sets the text right-aligned in front of the last column and
the value into the last one. With `-id` the value becomes a field, and
with `-calculate` the viewer does the arithmetic:

```tcl
-calculate {sum {f_pos_0_3 f_pos_1_3 f_pos_2_3 f_pos_3_3}}
-format    {number decimals 2 sep de}
```

Instead of `sum`, `product`, `average`, `min` and `max` also work.
`sep de` shows the number with a decimal comma. The calculation only
happens in viewers with form JavaScript, such as Acrobat Reader; in
Evince or Okular the value from `-init` stays.

---

## Fonts in Forms

A form field has two fonts: the one in which the page shows the value
(the appearance), and the one in which the viewer redraws the value
when someone types. The viewer must be able to encode the second one
itself. With the fonts from `fonts::init` this goes wrong:

- **With `-cid 1`**, a drop-down list shows boxes instead of letters
  (`□□□N□H□` instead of `Paket`) as soon as the viewer redraws it.
  `addForm` cannot handle CID fonts.
- **Without `-cid`**, pdf4tcllib encodes the font with a character
  table of its own. The appearance is correct, but the stored value
  uses the same table: when the form data is exported, `Müller` becomes
  `MÜller`, and `ß` becomes `¿`.

The remedy is the same TrueType file, registered a second time, this
time with the encoding `cp1252`, and `form` configured to use this
font:

```tcl
pdf4tcl::createFont _Pdf4tcl_Base_Regular FormSans     cp1252
pdf4tcl::createFont _Pdf4tcl_Base_Bold    FormSansBold cp1252
pdf4tcllib::form::configure -fontFamily FormSans \
    -fontFamilyBold FormSansBold
```

`_Pdf4tcl_Base_Regular` and `_Pdf4tcl_Base_Bold` are the names under
which `fonts::init` loads the files. The rest of the text on the page
stays in the CID font. With `cp1252`, German umlauts, `ß` and `€` work;
characters outside it do not belong in a form field.

Incidentally, without `form::configure` the header row of `orderTable`
and the text of `sumLine` always use **Helvetica-Bold**, even after
`fonts::init`. This font is not embedded; a form for PDF/A or PDF/UA
fails with it.

The cells of `orderTable` appear bold: with `-cellForm` the fields take
over the font of the header row. There is no option against it.

---

## Border and Background

Every field created by `labelField`, `row`, `orderTable -cellForm` and
`sumLine -id` gets its background and border from `form::configure`:
`fieldBg`, `fieldBorder` and `fieldBorderW` become `-bgcolor`,
`-bordercolor` and `-borderwidth`. If the call gives one of these
options itself, its value applies. In the example every field gets a
slightly darker border:

```tcl
set rahmen {-bordercolor {0.6 0.6 0.6} -borderwidth 1
            -bgcolor {0.97 0.97 0.97}}
```

`fieldBg {}` leaves out the background, `fieldBorderW 0` the border. Up
to pdf4tcllib 0.6.6 the settings did not reach any field; without an
explicit value a field had no border, and on screen there was no way to
tell where to click.

For a checkbox this is not enough. As soon as one field of the document
calculates or formats (`-calculate`, `-format`, `-js`), the PDF asks the
viewer to redraw all fields (`/NeedAppearances`). For text fields the
viewer then takes border and background from the settings above. For a
checkbox, however, pdf4tcl writes the border only into its own
appearance, which then no longer applies, and the box is invisible. The
example therefore draws its border as a rectangle on the page, at the
same position as the field.

---

## Settings

`form::configure` without arguments returns all settings; with pairs it
sets them. Unknown names are an error.

| Name | Default | Meaning |
|---|---|---|
| `fontFamily`, `fontFamilyBold` | `Helvetica`, `Helvetica-Bold` | fonts (see above) |
| `fontSize`, `fontSizeLabel`, `fontSizeSection` | `9`, `9`, `10` | sizes |
| `fieldH` | `16` | field height and row height of the table |
| `labelW`, `labelGap` | `90`, `4` | width of the label, gap to the field |
| `rowGap`, `sectionGap` | `6`, `10` | space after a row and a section |
| `sectionBg`, `lineColor` | gray | section bar, separator line |
| `fieldBg`, `fieldBorder` | light gray, gray | background and border of the fields |
| `fieldBorderW` | `1` | border width of the fields; `0` = none |

The names are stored without a hyphen but set with one:
`form::configure -labelW 110`.

---

## Worth Knowing

- **No page break.** The procedures move `y` forward but do not start a
  new page. A form that spans more than one page has to be split by
  hand.
- **The label sits at the bottom.** It sits on the baseline of the
  field; with a tall field (`-fieldh 40`), "Bemerkung:" therefore
  stands next to the lower edge.
- **Accessibility.** Label and field lie together in a `Form` element,
  with the label as alternate text; in the item table it is the column
  header.

---

## Summary

- `section`, `labelField`, `row`, `orderTable`, `sumLine` build a form
  line by line; they move `y` forward.
- Register a `cp1252` font for the fields and set it with
  `form::configure`; otherwise wrong values or boxes appear.
- Give the border on each field explicitly; a checkbox in a calculating
  form needs a drawn border.
- `sumLine -calculate` calculates in the viewer, not in Tcl.

---

*Next chapter: [Label Sheets](130-etikettenboegen.md)*
