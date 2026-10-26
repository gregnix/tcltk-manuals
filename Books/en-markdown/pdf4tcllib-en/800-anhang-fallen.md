# Pitfalls

Short list, by topic. The reasons are in the chapter named.

---

## Setup

- `package require pdf4tcllib` does not load pdf4tcl; write both lines
  ([Setup](020-einrichten-und-schriften.md)).
- Tcl 8.6 reads scripts in the system encoding. Without a UTF-8 locale,
  umlauts in the source turn into "Ã¼" in the PDF.
- Without a matching TrueType file everything carries on with
  Helvetica; only stderr says so. Check `fonts::hasTtf`.
- The default family `DejaVuSansCondensed` is in `fonts-dejavu-extra` on
  Debian, not in `fonts-dejavu-core`.
- File names follow the pattern `<familie>.ttf`, `<familie>-Bold.ttf`;
  Liberation fonts do not match.
- CID mode is fixed by the first `fonts::init`. A later
  `fonts::init -cid 1` (even with `-force 1`) reloads nothing, but
  `fonts::isCidMode` then reports 1.

## Text and Characters

- `unicode::sanitize` follows `fonts::init`, not `setFont`. Helvetica
  after `fonts::init` loses →, ✓ and box-drawing lines without a message
  ([Unicode](030-unicode-sicher-ausgeben.md)).
- `safeText` always turns „…“ into "…", even in CID mode; so do the
  headers and footers from `page::`.
- `text::writeParagraph` does not call `sanitize`. Missing characters
  are then counted by pdf4tcl (`$pdf getSubstCount`), not by
  pdf4tcllib.
- `unicode::substCount` counts across the whole process; call
  `resetSubst` before each document.
- 256-character mode has no German quotation marks.

## Setting Text

- `text::width`, `wrap`, `truncate`, `fits` without `$pdf` only estimate
  the width ([Setting Text](050-text-setzen.md)).
- `text::wrap` shortens a word that is too wide on its own to "...";
  `hardBreak 1` splits it instead.
- In `text::wrap`, `pdf` is the sixth argument, after `code`; in
  `fitSize` it is called `-pdf`.
- `text::writeParagraph` always sets the regular font and does not break
  across pages.
- After a footer or header, its font is set; call `setFont` again before
  the next text.

## Pages and Columns

- "Page X of Y" needs two passes; the content must not have side effects
  ([Page Numbers](060-kopf-fuss-seitenzahlen.md)).
- `-pagelabel` is a `format` string: write `%` as `%%`.
- `flow::columns` without `-newpage` returns the remainder in `rest`
  instead of breaking ([Column Flow](070-spaltenfluss-wasserzeichen.md)).
- `flow::columns` puts the first baseline at `-top`; without it the first
  line reaches into the margin.
- `-firsty` applies only to the first column; `-align` has no effect.
- Draw `drawing::watermark` before everything else; with `-orient 0` it
  lands outside the page.

## Tables and Charts

- `table::draw` without `-ctx` does not break; without `-pagebreakcmd`
  there is no header or footer on the continuation pages
  ([Tables](080-tabellen.md)).
- `-pagebreakcmd` runs in the global scope and must return the new
  y position.
- Cells are single-line and truncated with "...", the header row
  included; `-notruncate 1` for values that will be typed in by hand.
- A block of rows joined by `rowspan` is not split; if it is taller
  than a page, `table::draw` aborts with an error.
- `table::group` does not sort; unsorted data yields several subtotals
  per group ([Groups](090-gruppen-und-kreuztabellen.md)).
- Totals from `group` and `pivot` are raw Tcl numbers; format them
  before drawing.
- `table::pivot` sorts the columns alphabetically; use `-colorder` for
  months and quarters.
- `chart::line` does not show the series names; draw the legend
  yourself ([Charts](100-diagramme.md)).
- The `-format` of the charts knows no decimal comma.

## Documents

- The script for `toc::document` runs twice; no side effects.
  `toc::document` builds its own context and overwrites `ctx`
  ([Table of Contents](110-inhaltsverzeichnis.md)).
- `toc::heading` does not set bold and does not wrap.
- `-gap` and `-bookmarks` of `toc::document` apply only to that call;
  on the manual route `toc::configure` counts.
- A cover page before the table of contents is only possible via
  `collect`, `pageCount`, `render`.
- Form fields with the fonts from `fonts::init`: boxes in choice lists
  in CID mode, wrongly stored umlauts otherwise. Register a `cp1252`
  font and set it with `form::configure`
  ([Form Layout](120-formular-layout.md)).
- Without `form::configure`, `orderTable` and `sumLine` always use
  Helvetica-Bold.
- A checkbox in a form with `-calculate` or `-format` is invisible in
  Poppler viewers; draw the frame.
- `labelField ... checkbox` without `-fieldw` is as wide as the row.
- `labels::render` starts the pages itself; no `startPage` before it
  ([Label Sheets](130-etikettenboegen.md)).
- `labels::fitSize` stops at `min` even if the text does not fit;
  measure again. Arguments differ from `text::fitSize`.
- Print at actual size, not "fit to page".
- A JPEG loaded before the first `startPage` starts a page
  ([Images](140-bilder.md)).
- `image::gallery -caption` knows only `unten` and `keine`; other values
  silently turn the captions off.
- `roundedRect -clip 1` clips with square corners
  ([Arrows and Callouts](150-pfeile-und-callouts.md)).
- Without `fonts::init -cid 1`, formula symbols turn into `?`
  ([Formulas](160-formeln.md)).
- `renderLatex` puts no space around `=`; insert `\,`. Set the font
  again afterwards.
- A script with Tk needs `exit` at the end and a display
  ([Treeview](170-treeview.md)).
- A CID font set with `setFont` but never used ends up in the file in
  full: about 330 KB for DejaVu Sans Bold.

## Accessibility and Structure

- `tagged 1 -ua 1` does not set `DisplayDocTitle`; PDF/UA requires it:
  `viewerPreferences -displaydoctitle 1`
  ([Accessible PDFs](180-barrierefreie-pdfs.md)).
- `writeParagraph` sets `P` when no type is given; for headings, pass
  `H1` etc. as the eighth argument. It always sets the regular font.
- To a screen reader, a chart is only its alternate text. Give important
  figures as a table as well. (Up to pdf4tclchart 0.1.1 the `Figure`
  stayed without content, and pdf4tcl warned.)
- Put anything drawn by hand inside `tag::begin`/`end` or mark it as an
  artifact; otherwise `getUntaggedCount` is not 0.
- Building blocks leave their font and color behind; `state::with`
  ([Graphics State](190-grafikzustand.md)).
- `state::with` restores what is passed, not what was set.
- `gsave`/`grestore` across a page break yields unbalanced streams,
  without a message.
- `measure::block`: `pages` stays 1 if the block does not break by
  itself; read `overflow` ([Measuring and Stacking](200-messen-und-stapeln.md)).
- In scripts for `layout::stack`, `$bpdf` instead of `$pdf`.
- `layout::stack` checks only blocks with `keep 1`.
- `page::header` draws its rule 2 pt below `top`; content starting at
  `top` gets struck through.

## Page

- pdf4tcl object without `-unit mm`: pdf4tcllib calculates in points,
  otherwise text lands outside the page
  ([Page Context](040-einheiten-und-seitenkontext.md)).
- The pdf4tcl option `-margin` together with `page::context` yields
  double the margin.
- `-orient` in the context and in the pdf4tcl object must match.
- `page::context a4 20 0`: the second word is the orientation, not
  landscape.
- y is the baseline: text at `y = top` reaches into the margin.
- `page::footer` writes "Seite N", even in an English document; set
  `pageLabelFormat`.
- `page::grid` is a helper grid for development, not a column grid.
- `page::centerText` without a font argument sets Helvetica, even after
  `fonts::init`; pass the font.

---

*Next chapter: [API per Module](810-anhang-api.md)*
