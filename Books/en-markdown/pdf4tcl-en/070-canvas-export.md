# Canvas Export

## Introduction

The [`canvas`]{.index} method on the document draws a Tk widget onto the
page. Call `update` first so that layout and items are in place. Three
widget classes, three code paths.

Requires **wish** or a set `DISPLAY`.

---

## Classic Canvas

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

`-bbox` is the source area in the canvas. `-x` / `-y` / `-width` /
`-height` refer to the PDF page. `-sticky` controls the fit
(`nw` by default). Further options: `-bg`, `-fontmap`, `-textscale`.

Without `update`, `bbox` is often empty or stale. With an empty bbox
the method returns silently and the page stays blank.

---

## tkpath and tko::path

The same method: `$pdf canvas .path …`. For PathCanvas and TkoPath,
`-bbox` is **mandatory**.

The [matrix]{.index} form differs:

| Widget | Matrix |
|--------|--------|
| `tkpath` | nested |
| `tko::path` | flat `{a b c d tx ty}` |

Do not mix the forms. For tko, pdf4tcl expects the flat form.

window items are often skipped. Register a photo with `addImage`
beforehand if the export would otherwise not find the image.

---

## Font Mapping

Text outside Latin-1: load a TrueType font under the **Tk family name**
(since 0.9.4.60); then no `-fontmap` is needed:

```tcl
pdf4tcl::loadBaseTrueTypeFont Base tahoma.ttf
pdf4tcl::createFontSpecCID Base Tahoma
.c create text 20 30 -text "Grüße" -font {Tahoma 14}
$pdf canvas .c -bbox [.c bbox all]
puts [$pdf getSubstCount]
```

Where the name cannot be chosen freely, set `-fontmap`. The mapping
always wins over the family lookup.

The key is not the same:

- `tk::canvas`: the **whole** font specification — `{Helvetica 14}` is
  not found under `Helvetica`. A named font is the safer match.
- `tko::path`: only the **family**.

Wrong key: question marks, no error. Hence
`getSubstCount`.

---

## Text Baseline

PDF text sits on the **baseline**, canvas text at its `-anchor`. A
visible offset in Y is expected when `nw` anchors and uncorrected PDF
text are mixed. Inside `$pdf canvas`, pdf4tcl takes over the item
anchors.

---

## Summary

- `update`, then `bbox`, then `$pdf canvas`.
- Three classes: `canvas`, PathCanvas, TkoPath.
- tko: flat matrix. tkpath: nested.
- `-fontmap` or family name; check `getSubstCount`.

---

*Next chapter: [Creating Forms](080-formulare-erzeugen.md)*
