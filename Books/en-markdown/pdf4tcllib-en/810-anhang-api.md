# API per Module

Quick reference for pdf4tcllib 0.6.7 and the add-on packages. The call
forms are read from the procedures themselves (`info args`); arguments
in `?…?` have a default. Many argument names are German, for example
`datei` (file), `breite` (width), `zeilen` (rows), `spalten` (columns),
`wert` (value), `farbe` (color). The options are a selection. Complete
and in English: `docs/en/reference/` in the pdf4tcllib source tree.

All names live in the namespace `pdf4tcllib::`, which is left out here:
`fonts::init` written out in full is `pdf4tcllib::fonts::init`.

---

## Packages

| Package | Version | Namespace | Chapter |
|---|---|---|---|
| `pdf4tcllib` | 0.6.7 | `fonts unicode text math page tag state measure layout table drawing image units form` | 2 to 20 |
| `pdf4tclchart` | 0.1.2 | `chart` | 10 |
| `pdf4tclflow` | 0.1 | `flow` | 7 |
| `pdf4tcltoc` | 0.1.1 | `toc` | 11 |
| `pdf4tcllabels` | 0.3 | `labels` | 13 |
| `pdf4tclforms` | 0.2.3 | `forms` | – |
| `pdf4tclcanvas` | 0.1 | `canvas` | – |
| `pdf4tcltable` | 0.3.2 | `tablelist` | – |
| `pdf4tcltext` | 0.3 | `textwidget` | – |
| `pdf4tcltreeview` | 0.1.1 | `treeview` | 17 |

"–": no chapter of its own in the book, only the calls here.

```tcl
package require pdf4tcl
package require pdf4tcllib
puts [pdf4tcllib::version]          ;# 0.6.7
```

---

## Fonts: fonts

```tcl
fonts::init ?-cid 0|1? ?-fontdir dir? ?-family name? ?-force 0|1?
fonts::ready
fonts::hasTtf
fonts::hasTtfItalic
fonts::isCidMode
fonts::fontSans
fonts::fontSansBold
fonts::fontSansItalic
fonts::fontSansBoldItalic
fonts::fontMono
fonts::setFont pdf size ?family? ?style?
fonts::isMonospace fontName
fonts::widthFactor fontName
fonts::subset
fonts::inSubset codepoint
```

`init` once per process; CID mode applies from the first call on.
`style` for `setFont`: `Bold`, `Italic`, `BoldItalic`.

---

## Characters: unicode

```tcl
unicode::sanitize text ?-mono 0|1? ?-tabwidth n?
unicode::safeText pdf text ?-x x -y y -align a …?
unicode::readFile datei
unicode::preprocessBytes bytes
unicode::substCount
unicode::substReport                 ;# dict: count, chars
unicode::resetSubst
```

---

## Setting Text: text

```tcl
text::width text size font ?pdf?
text::wrap text maxW size font ?code? ?pdf? ?hardBreak? ?trenner?
text::truncate text maxW size font ?pdf?
text::fits text maxW size font ?pdf?
text::fitSize text maxW wunschgroesse font ?-min n? ?-pdf pdf?
text::writeParagraph pdf text x y breite ?size? ?align? ?tag?
text::expandTabs zeile ?tabbreite?
text::detectFont zeile
text::superscript pdf text x y size font
text::subscript pdf text x y size font
text::mathSymbol name
text::mathSymbolNames
```

`writeParagraph` returns the y below the paragraph. `trenner`
(separators) for `wrap`: default `{- /}`.

---

## Formulas: math

```tcl
math::renderFormula pdf x y formel ?-size n? ?-font f?
math::analyseFormula formel
math::renderLatex pdf x y latex ?-size n? ?-font f?
math::measureLatex pdf latex ?-size n?
              ?-font f?   ;# {breite oben unten}
math::pdfBackend pdf
math::canvasBackend canvas ?-family f? ?-fill farbe? ?-tags t?
math::renderLatexOn backend x y latex ?-size n? ?-font f?
math::measureLatexOn backend latex ?-size n? ?-font f?
```

---

## Page: page, units

```tcl
page::context papier ?-margin mm? ?-orient 0|1? ?-landscape 0|1?
page::lineheight size ?faktor?
page::header pdf ctx text ?size?
page::footer pdf ctx text seite ?size? ?-pagelabel format?
page::number pdf ctx seite ?gesamt? ?size?
page::centerText pdf ctx text y ?size? ?font?
page::grid pdf ctx spalten spalte
page::debugGrid pdf ctx ?abstand?
page::orientationLegend pdf ctx

units::mm wert      units::to_mm pt
units::cm wert      units::to_cm pt
units::inch wert    units::to_inch pt
```

Keys of the context: `page_w page_h left top bottom text_w text_h
margin`, plus the short forms `PW PH SX SY SW SH`. Default for
`pageLabelFormat`: `Seite %s`.

---

## Structure Tree: tag

```tcl
tag::begin pdf typ ?-alt t? ?-scope s? ?-colspan n? ?-rowspan n?
              ?-summary t?
tag::end pdf
tag::artifact pdf ?-type Layout|Pagination|Page?
tag::artifactEnd pdf
tag::isActive pdf
tag::depth pdf
tag::forget pdf
```

Without `$pdf tagged 1`, none of them does anything.

---

## State, Measuring, Stacking: state, measure, layout

```tcl
state::save pdf ?size? ?font? ?fill? ?stroke?
state::restore pdf zustand
state::with pdf {size font} {r g b} skript

measure::block varName skript ?-paper p? ?-orient 0|1? ?-margin mm?
              ?-landscape 0|1? ?-y y?
measure::height varName skript ?option …?
measure::fits platz varName skript ?option …?

layout::stack pdf x y breite bloecke ?-ctx ctx? ?-gap n?
              ?-font {size name}? ?-fill {r g b}? ?-pagecmd cmd?
              ?-paper p?
```

`measure::block` returns a dict: `height pages value overflow sheet`.
Blocks for `layout::stack`: `{script {…} ?keep 1?}` or `{gap n}`; in
the script `$bpdf $bx $by $bw`.

---

## Tables: table

```tcl
table::draw pdf x y spalten zeilen ?option …?
table::simpleTable pdf x y breiten zeilen ?-zebra 0|1? ?-pad n?
              ?-header_bg {r g b}? ?-row_height n? ?-font_size n?
table::render pdf daten x0 yVar maxW yTop yBot pageNoVar
              pageW pageH margin size lineH ?debug? ?pageBreakCmd?
table::group zeilen ?-by n? ?-sum {…}? ?-label fmt? ?-total 0|1?
              ?-totallabel t? ?-header 0|1? ?-blank 0|1? ?-strict 0|1?
table::pivot zeilen ?-row n? ?-col n? ?-value n?
              ?-agg sum|count|avg|min|max? ?-empty t? ?-total 0|1?
              ?-rowlabel t? ?-totallabel t? ?-colorder {…}?
table::widths spalten zeilen ?-pdf pdf? ?-fontsize n? ?-pad n?
table::breakPoints zeilen ?-fontsize n? ?-rowheight n? ?-header 0|1?
              ?-groups {…}?
table::fitRows platz zeilen ?option …?
```

Options of `draw`: `-ctx -maxwidth -header -headerbg -headerfg -zebra
-zebracolor -zebrastart -fontsize -pad -border -rowheight -cellstyles
-rowstyles -rowindent -footer -footerbg -footerbold -yvar -pagevar
-orient -pagebreakcmd -fontreg -fontbold -summary`. Since 0.6.7 any
other option is an error.

Per column: `-header -width (number or auto) -align -font -notruncate`.
A cell may be a dict `{text … colspan n rowspan n}`.

---

## Drawing: drawing

```tcl
drawing::frame pdf x y w h ?linienbreite?
drawing::separator pdf x y w ?farbe? ?linienbreite?
drawing::roundedRect pdf x y w h r ?stroke? ?fill? ?-clip 1?
drawing::polygon pdf cx cy radius ecken ?stroke? ?fill?
drawing::star pdf cx cy radius ?zacken? ?verhaeltnis? ?stroke? ?fill?
drawing::gradient_v pdf x y w h farbe1 farbe2 ?schritte?
drawing::gradient_h pdf x y w h farbe1 farbe2 ?schritte?
drawing::interpolate farbe1 farbe2 t
drawing::arrow pdf x1 y1 x2 y2 ?-at end|start|both? ?-length n?
              ?-width n?
              ?-filled 0|1?
drawing::arrowHead pdf x y winkel ?-length n? ?-width n? ?-filled 0|1?
drawing::callout pdf x y w h zielX zielY text
              ?-radius -fill -stroke -tail
              -pad -fontsize -font -alt?
drawing::watermark pdf ctx text ?-angle grad? ?-size n?
              ?-color {r g b}?
              ?-layer 1|id?
drawing::textRotated pdf text x y winkel size ?font?
drawing::textScaled pdf text x y sx sy size ?font?
drawing::textSkewed pdf text x y skewX skewY size ?font?
```

`arrowHead` takes the angle in radians.

---

## Images: image

```tcl
image::place pdf id x y w h ?-fit contain|cover|stretch? ?-anchor a?
              ?-dpi n? ?-alt t?
image::gallery pdf bilder x y w h ?-cols n? ?-rows n? ?-gap n?
              ?-caption unten|keine? ?-captionH n? ?-fontsize n?
              ?-font f?
              ?-fit …? ?-anchor …? ?-dpi n? ?-pagecmd cmd?
image::insert pdf tkBild x yVar maxW yTop yBot pageNoVar
              pageW pageH margin size ?debug?
image::insertAt pdf tkBild xPos yVar maxW yTop yBot pageNoVar
              pageW pageH margin size ?debug?
```

`place` returns the occupied area `{x y w h}`, `gallery` the number of
pages. `insert` and `insertAt` need Tk.

---

## Form Layout: form

```tcl
form::configure ?-option wert …?
form::fieldHeight
form::rowHeight
form::section pdf ctx yVar titel
form::labelField pdf ctx yVar label typ ?-labelw n? ?-fieldw n?
              ?-fieldh n?
              ?addForm-Optionen …?
form::row pdf ctx yVar felder
form::separator pdf ctx yVar ?abstand?
form::orderTable pdf ctx yVar koepfe breiten ?daten? ?-emptyRows n?
              ?-rowh n? ?-headerBg {r g b}? ?-cellForm präfix?
              ?-cellOpts {…}?
form::sumLine pdf ctx yVar breiten label wert ?-id id?
              ?-calculate {op {felder}}?
              ?-init wert?
```

All of them advance `yVar`. A field in `form::row`: a dict with `label
type width` and optionally `id init options labelw fieldh readonly
multiline`. Background and border of the fields come from `fieldBg`,
`fieldBorder` and `fieldBorderW` of `form::configure` when the call
does not give its own.

---

## Charts: chart (pdf4tclchart)

```tcl
chart::bar pdf x y w h daten ?option …?
chart::line pdf x y w h reihen ?option …?
chart::pie pdf x y w h daten ?option …?
chart::legend pdf x y paare optionen
chart::niceScale min max ?teilungen?        ;# {min max schritt}
chart::configure ?-option wert …?
```

Options: `-title -titlesize -labelsize -valuesize -values -format
-color -colors -grid -gridcolor -axiscolor -min -max -legend -alt`.
Data: `{name wert name wert …}` or `{{name wert} …}`; series for
`line`: `{{name {paare}} …}`. Returns the y below the chart.

---

## Column Flow: flow (pdf4tclflow)

```tcl
flow::columns pdf ctx text ?-columns n? ?-gap n? ?-size n? ?-font f?
              ?-tag typ? ?-top y? ?-bottom y? ?-firstx x? ?-firsty y?
              ?-newpage skript?
flow::boxes ctx ?option …?
flow::measure pdf text breite size font
flow::configure ?-option wert …?
```

Without `-newpage`, `columns` returns the remainder instead of breaking;
`-newpage` is a script and runs in the caller's scope.

---

## Table of Contents: toc (pdf4tcltoc)

```tcl
toc::document pdf papier skript ?-title t? ?-titlesize n? ?-size n?
              ?-leader z? ?-indent n? ?-gap n? ?-bookmarks 0|1?
toc::heading pdf ctx yVar ebene text ?-size n? ?-gap n? ?-tag typ?
toc::collect skript ?versatz?
toc::pageCount ctx eintraege ?option …?
toc::render pdf ctx eintraege ?option …?
toc::entries
toc::configure ?-bookmarks 0|1? ?…?
```

`document` returns a dict: `entries tocPages contentPages`. An entry
is `{ebene titel seite}` (level, title, page).

---

## Labels: labels (pdf4tcllabels)

```tcl
labels::sheets
labels::sheet name
labels::define name spec
labels::place geometrie index               ;# {x y w h}
labels::render pdf name datensaetze {x y w h satz} skript
              ?-start n? ?-only {…}? ?-offsetx mm? ?-offsety mm?
              ?-frame 0|1|layer? ?-tag typ?
labels::fitSize pdf font text maxW size ?min?
labels::wrap pdf text maxW
labels::ellipsize pdf text maxW ?ende?
labels::calibration pdf name
```

`render` starts the pages itself. The fourth argument names the five
variables the script receives per label.

---

## Fillable Forms: forms (pdf4tclforms)

```tcl
forms::renderSchema pdf ctx spec ?-yvar name? ?-pagebreak 0|1?
forms::renderSection pdf ctx yVar abschnitt ?pagebreak?
forms::field pdf ctx yVar feld ?pagebreak?
forms::checkboxLine pdf ctx yVar feld ?pagebreak?
forms::radioGroup pdf ctx yVar feld ?pagebreak?
forms::buttonBar pdf ctx yVar feld ?pagebreak?
forms::signatureLine pdf ctx yVar feld ?pagebreak?
forms::entryTable pdf ctx yVar tabelle ?pagebreak?
forms::template name
              ?…?          ;# callnote inventory checklist order
forms::read datei ?-schema s? ?-strict 0|1? ?-raw 0|1?
forms::write ein aus werte ?-schema s? ?-strict 0|1?
```

---

## Tk Widgets: canvas, tablelist, textwidget, treeview

```tcl
canvas::place pdf canvas x y w h ?-fit contain|stretch? ?-anchor a?
              ?-alt t?
              ?-caption t? ?-captionH n? ?-fontsize n? ?-font f?
              ?-bbox {…}? ?-fontmap {…}? ?-textscale f? ?-border 0|1?
canvas::fitPage pdf canvas ctx ?option …?

tablelist::render pdf tbl x y ?-maxwidth -fontsize -rowheight -zebra
              -border -tree -indentW -formatted -headerbg -headerfg
              -footer -footerbg -footerbold -ctx -yvar -font
              -boldfont?
tablelist::renderRange pdf tbl x y ?-firstrow n? ?-lastrow n? ?…?
tablelist::report                    ;# was beim letzten render fehlte

textwidget::render pdf textwidget x y ?-maxwidth n? ?-fontsize n?
              ?-fontfamily f? ?-linespacing n? ?-skipelided 0|1?
              ?-skipinternal 0|1? ?-ctx ctx? ?-yvar name?

treeview::render pdf tv x y ?-maxwidth -fontsize -rowheight -tree -all
              -zebra -border -indentW -ctx -yvar -pagevar -font
              -boldfont
              -summary?
treeview::outline pdf tv x y
              ?-fontsize -indentW -lineH -all -bookmarks
              -font -yvar?
```

All four need Tk and a display.

---

## Miscellaneous

```tcl
pdf4tcllib::version
pdf4tcllib::validate_pdf datei     ;# dict: valid size error
```

---

*Next chapter: [Glossary](820-anhang-glossar.md)*
