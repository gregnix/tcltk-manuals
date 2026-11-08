# Forms from a Dict

## Introduction

The chapter [Form Layout](120-formular-layout.md) builds a form command
by command: section, field, row, table. The package
[pdf4tclforms]{.index} describes the same as **data**: a dict with
sections, holding fields, a table and sum lines. One command draws it.
That way a form can be kept in a file or a database and used by several
programs.

On top of that comes the way back: **reading** a filled form and
**filling** one, without a PDF viewer, with the field names as keys.

Drawing uses the same building blocks from `form::`; what that chapter
says about fonts, borders and settings applies here too.

---

## A Return

The example script is the same as in the German edition; comments and
sample data are German.

```tcl
# 125-formular-schema.tcl -- ein Formular aus einem Dict, gefuellt, gelesen
package require pdf4tcl
package require pdf4tcllib
package require pdf4tclforms

pdf4tcllib::fonts::init -cid 1
# Formularfelder brauchen eine Schrift mit cp1252 (Kapitel Formular-Layout)
pdf4tcl::createFont _Pdf4tcl_Base_Regular FormSans     cp1252
pdf4tcl::createFont _Pdf4tcl_Base_Bold    FormSansBold cp1252
pdf4tcllib::form::configure -fontFamily FormSans -fontFamilyBold FormSansBold
set ctx [pdf4tcllib::page::context a4 -margin 20]

# Das Formular als Daten: Abschnitte mit Feldern, Tabelle und Summe
set breiten {30 260 60 100}
set schema [dict create \
    title "Rücksendung" \
    sections [dict create \
        kunde [dict create title "Kunde" fields {
            {id f_name type text label "Name:" required 1 borderwidth 1}
            {row {
                {id f_plz type text label "PLZ:" width 120}
                {id f_ort type text label "Ort:"  width 330}
            }}
            {id f_grund type combobox label "Grund:"
             options {"Beschädigt" "Falsch geliefert" "Gefällt nicht"}
             init "Beschädigt" borderwidth 1}
            {id f_ersatz type checkbox label "Ersatz statt Gutschrift"}
        }] \
        waren [dict create title "Waren" \
            table [dict create headers {Pos Artikel Menge Betrag} \
                widths $breiten emptyRows 3 editable 1 idPrefix f_pos \
                columns {3 {align right}}] \
            sums [list [dict create widths $breiten label "Summe:" \
                over {f_pos 3 3} init 0]]]]]

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
set y [dict get $ctx top]
pdf4tcllib::forms::renderSchema $pdf $ctx $schema -yvar y
$pdf endPage
$pdf write -file 125-leer.pdf
$pdf destroy
puts "Formular endet bei y = [format %.1f $y]"

# Ausfuellen ohne Betrachter: Werte nach Feldname
set werte [dict create f_name "Erika Müller" f_plz 12345 f_ort Grünfeld \
    f_grund "Falsch geliefert" f_ersatz 1 \
    f_pos_0_0 1 f_pos_0_1 "Tontopf 18 cm" f_pos_0_2 2 f_pos_0_3 5.80]
puts "gefüllt: [pdf4tcllib::forms::write 125-leer.pdf 125-gefuellt.pdf $werte]"

# Zuruecklesen: ein Ankreuzfeld kommt als 1 oder 0
set daten [pdf4tcllib::forms::read 125-gefuellt.pdf]
foreach id {f_name f_ort f_grund f_ersatz f_pos_0_1 f_pos_1_1} {
    puts [format "%-10s %s" $id [dict get $daten $id]]
}
puts "Felder: [dict size $daten]"
```

```text
Formular endet bei y = 321.7
gefüllt: 9
f_name     Erika Müller
f_ort      Grünfeld
f_grund    Falsch geliefert
f_ersatz   1
f_pos_0_1  Tontopf 18 cm
f_pos_1_1  
Felder: 18
```

`125-leer.pdf` is the empty form, `125-gefuellt.pdf` the same with the
values. Nine fields were filled; all 18 are read back, including the
empty table cells and the sum field.

---

## The Structure

```tcl
set y [pdf4tcllib::forms::renderSchema pdf ctx schema ?-yvar name? ?-pagebreak 0|1?]
```

[forms::renderSchema]{.index} draws the whole dict from `y` on and
returns the y position afterwards. `-yvar` names the caller's variable
that moves down with it. With `-pagebreak 1` a new page begins when a
field or a table would cross the bottom margin; without it the form runs
past the margin.

| Level | Keys |
|---|---|
| form | `title` (once at the top, large), `sections` (required) |
| section | `title` (grey bar), `fields`, `table`, `sums` |

Sections come in the order of the dict. Within a section the order is
fixed: title, fields, table, sums, whatever their order in the dict.

**`fields` is a list**, not a dict. Each entry is a field or one of four
special entries:

| Entry | draws |
|---|---|
| `{id … type … label …}` | a field with label |
| `{row {field field …}}` | fields side by side; `width` is the width of the pair of label and field |
| `{separator n}` | a line and `n` points of space |
| `{table {…}}`, `{sums {…}}` | table, sum lines in the middle of the list |

### Fields

| Type | Particulars |
|---|---|
| `text`, `password` | `multiline 1` puts the label above, `fieldh` sets the height |
| `combobox`, `listbox` | `options {…}`, `init` is the preselection |
| `checkbox` | box on the left, label on the right |
| `radio` | `group`, `options {{value "Text"} …}` |
| `buttons` | `items` with `{id caption action submit|reset|url}` |
| `signature` | signature field, `placeholder` |

A field dict mixes two kinds of keys. `label`, `labelw`, `fieldh`,
`fieldw`, `width` and `gap` belong to the layout and are drawn as text.
`id`, `init`, `options`, `readonly`, `multiline`, `required`, `tooltip`,
`tabindex` and the appearance (`align`, `color`, `borderwidth`,
`bordercolor`, `bgcolor`, `format`, `calculate`, `js`) go to `addForm`.
Nothing else is passed on.

`required 1` puts a red asterisk after the label. A field without
`borderwidth` has no border; in the example "Name" and "Grund" have one,
PLZ and Ort in the row get it from `form::row`.

### The Table

| Key | Meaning |
|---|---|
| `headers`, `widths` | column headers, widths in points |
| `rows`, `emptyRows` | fixed rows, empty rows after them |
| `editable` | `1`: every cell is a field |
| `idPrefix` | names of the cells: `prefix_row_column` |
| `columns` | appearance per column, e.g. `{3 {align right}}` |
| `rowh`, `headerBg` | row height, header colour |

The cells in the example are named `f_pos_0_0` to `f_pos_2_3`, rows and
columns from 0. Each table needs its own `idPrefix`: two fields with the
same name are one field in the PDF.

### Sum Lines

A sum line with `value` is fixed text. With `over {f_pos 3 3}` it
becomes a field that adds column 3 of the three rows of `f_pos`, with
`calculate {sum {…}}` or `id` freely chosen fields. `init` stands in the
field until something is calculated.

**Calculation happens in the viewer**, with JavaScript. `forms::write`
does not calculate: in the filled example the sum field shows 0 until a
viewer with JavaScript opens the form and recalculates. Whoever needs
the sum in the PDF computes it in Tcl and writes it too.

---

## Templates

[forms::template]{.index} returns a ready schema without drawing:

| Name | Content | Options |
|---|---|---|
| `callnote` | phone call note | `-title` |
| `inventory` | PC inventory in three sections | `-title` |
| `checklist` | list with fillable cells | `-title -headers -widths -emptyRows` |
| `order` | order with positions | `-title -emptyRows` |

```tcl
set spec [pdf4tcllib::forms::template callnote -title "Call back"]
pdf4tcllib::forms::renderSchema $pdf $ctx $spec -yvar y
```

The schema is an ordinary dict; it can be changed before drawing. The
templates are labelled in German, without umlauts.

---

## Filling and Reading

```tcl
set n    [pdf4tcllib::forms::write in.pdf out.pdf values ?-strict 0|1?]
set data [pdf4tcllib::forms::read file ?-schema fields? ?-strict 0|1? ?-raw 0|1?]
```

[forms::write]{.index} writes the values of a dict `fieldname value`
into a copy of the form and returns the number of fields filled. A
checkbox gets `1` or `0`; what the state is called in the PDF (`/Yes`,
`/Off`) is the package's business. A field the form does not have is
skipped and reported in `::pdf4tcl::warnings`; with `-strict 1` it is an
error. pdf4tcl redraws the field's appearance, so a print without form
support shows the value too; only password and choice fields get
`/NeedAppearances` instead.

[forms::read]{.index} returns all fields as a dict: text as text,
checkboxes as `1` or `0`, others as pdf4tcl delivers them. `-raw 1`
returns the raw data of `pdf4tcl::getForms` (`type /Btn value /Yes …`).
Any form can be read, not only one from pdf4tclforms.

`-schema` takes a flat list of field dicts with `id`. Then the result
follows their order, and missing or extra fields are reported. Fields in
a `row` entry go into that list one by one.

---

## Worth Knowing

- Form fields need a font with cp1252, set with `form::configure`, as in
  the chapter [Form Layout](120-formular-layout.md). Characters outside
  cp1252 do not work in fields.
- Context and document with `-orient true`.
- `sections` is required, even for a single section.
- The commands also exist as `pdf4tclforms::renderSchema` and so on; the
  building blocks from `form::` are created there as well.

---

## Summary

- `forms::renderSchema` draws a form from a dict: sections, fields,
  table, sums.
- `fields` is a list; `row`, `separator`, `table`, `sums` are special
  entries.
- Table cells are named `prefix_row_column`.
- `forms::write` fills, `forms::read` reads, with field names as keys;
  calculation happens only in the viewer.

---

*Next chapter: [Label Sheets](130-etikettenboegen.md)*
