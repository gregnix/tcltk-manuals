# Creating Forms

## Introduction

`addForm` places AcroForm fields on the current page. The
[appearance stream]{.index} is created along with the field. A document
built with its values in a single pass does not need `fillForms`.

Field text is in practice Base-14 / Latin-1. CID in AcroForm is hard;
put umlauts in labels on the page as ordinary `text`.

---

## Text Field and Buttons

```tcl
set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient 1 -margin 50]
$pdf startPage
$pdf setFont 12 Helvetica
$pdf text "Name:" -x 0 -y 40
$pdf addForm text 60 28 200 16 -id f_name

$pdf addForm pushbutton 0 70 90 20 -id f_reset \
        -caption "Reset" -action reset
$pdf addForm pushbutton 100 70 90 20 -id f_go \
        -caption "Submit" -action submit \
        -url "mailto:bestellung@example.com"
$pdf endPage
$pdf write -file formular.pdf
$pdf destroy
```

Types: `text`, `password`, `checkbutton` (alias `checkbox`),
`radiobutton`, `combobox`, `listbox`, `pushbutton`, `signature`.

`-id` takes word characters only, no dot. Nested names occur in the
field tree of foreign files, not when creating fields here.

---

## Options

| Option | Effect |
|--------|---------|
| `-init` | initial value, visible everywhere |
| `-align` | `left` / `center` / `right` |
| `-multiline` | multiple lines |
| `-maxlen` / `-comb` | comb field, cells = width / MaxLen |
| `-options` | choice list as labels (no export/label pair) |
| `-tooltip` | tooltip |
| `-readonly` / `-required` | flags |
| `-color` `-bgcolor` `-bordercolor` `-borderwidth` | appearance |
| `-layer` | `/OC` on the annotation |
| `-format date` | formatting in the viewer |
| `-calculate` | sum over field IDs, needs JS in the viewer |

`-comb 1` requires `-maxlen`, excludes `-multiline` and honors
`-align`. Since 0.9.4.63.

`text`, `password`, `checkbutton` and `radiobutton` work before
`setFont`. `combobox`, `listbox`, `pushbutton` and `signature`
require a font to be set (message since 0.9.4.63: `no font set`).

Since 0.9.4.63 an empty text field carries an appearance stream
(length 0), so that `fillForms` has something to overwrite.

Since 0.9.4.66 an empty field with `-bordercolor` and `-borderwidth`
draws the border instead of an empty stream. Without a border the
stream stays empty.

---

## Sum (JS in the Viewer)

```tcl
$pdf addForm text 400 200 90 16 -id b1 -align right -init 120
$pdf addForm text 400 220 90 16 -id b2 -align right -init 80
$pdf addForm text 400 250 90 16 -id f_sum -align right \
        -calculate {sum {b1 b2}} -init 200 \
        -borderwidth 1 -bgcolor {0.95 0.95 0.85}
```

`-init` shows the value everywhere. `-calculate` updates in Acrobat,
Firefox, Chromium and Foxit.

---

## PDF/A and Check Marks

A check mark as a ZapfDingbats glyph cannot be embedded. Since
0.9.4.55 pdf4tcl draws the check mark as a vector as soon as `-pdfa`
or PDF/UA is set. Without a conformance claim the glyph remains.
`-markstyle font` / `vector` / `auto` (default `auto`).

---

## Layers and Fields

`beginLayer` does not reach annotations — they lie outside the
content stream. `-layer` on `addForm` writes `/OC` into the
annotation dictionary.

---

## Summary

- `addForm TYP x y b h -id name` (type, x, y, width, height).
- The appearance is created along with the field.
- Comb needs `-maxlen`. Whether a font is required depends on the type.
- PDF/A: check mark as a vector (`-markstyle auto`).

---

*Next chapter: [fillForms](090-fillforms.md)*
