# Error Messages

The messages of pdf4tcllib 0.6.7 and the add-on packages, by module,
with the usual cause. The texts are shown exactly as Tcl prints them;
`…` stands for the inserted value.

There are three kinds:

- **Errors** abort the call (`catch` catches them).
- **Warnings** end up in `::pdf4tcl::warnings`, a list that nobody
  empties automatically. Run `set ::pdf4tcl::warnings {}` before the
  document and read the list afterwards.
- **Notes on stderr** are written by pdf4tcllib itself, usually only
  once per process.

---

## For All Building Blocks

### …: unknown option -… (allowed: …) / (known: …)

A typo, or an option that does not exist in this version. The message
names the allowed ones. Since 0.6.7 this also applies to `table::draw`;
before that, any option passed there silently.

### …: expected an even number of option/value words

### …: expected option/value pairs

An option is missing its value, often because a list is not braced:
`-colors $a $b` instead of `-colors [list $a $b]`.

---

## Page and Fonts

### unknown paper size: … (known: …)

`page::context` does not know the paper. Upper and lower case do not
matter; the list in the message names the known names.

### pdf4tcllib::page::footer: unknown option …

In `footer` the size is the fifth argument, the options come after it:
`page::footer $pdf $ctx "Text" $seite 9 -pagelabel "Seite %s"`.

### pdf4tcllib::fonts: No TTF fonts found, falling back to Helvetica

Note on stderr, followed by the folders searched. From here on the
256-character mode with Helvetica applies; umlauts work, →, ✓ and
typographic quotation marks do not. On Debian, `fonts-dejavu-extra` is
usually missing ([Setup and Fonts](020-einrichten-und-schriften.md)).

### pdf4tcllib::fonts: TTF error: … / Fallback on Helvetica

The font file was found but could not be loaded: damaged, not a
TrueType file, or locked by another program.

### pdf4tcllib::unicode: sanitize: at least one character is missing from the font and was replaced with '?' (first: U+…). …

Note on stderr, once per process: characters were missing from the
font and became `?`. `unicode::substReport` says which. For Greek and
formula symbols, use `fonts::init -cid 1`
([Safe Unicode Output](030-unicode-sicher-ausgeben.md)).

### pdf4tcllib::math: unknown symbol '\…' rendered as literal text

`math::renderLatex` does not know the command and sets it as text.
`text::mathSymbolNames` lists the known names.

---

## Text, Measuring, Stacking

### text::fitSize: unknown option …

`fitSize` takes `-min` and `-pdf`; here `pdf` is not at a fixed
position as in `text::wrap`.

### layout::stack: an entry needs a script (or must be {gap <n>})

A block in the list has neither `script` nor the form `{gap n}`.
Common cause: the blocks were passed as one script instead of a list of
dicts.

### measure::block: unknown option …

Allowed: `-paper -orient -margin -landscape -y`.

---

## Tables

### table::draw: -orient 0 is not supported. …

The document was created with `-orient 0` (y pointing up).
`table::draw` only draws with y pointing down. Create the pdf4tcl
object with `-orient 1`, the default
([Units and Page Context](040-einheiten-und-seitenkontext.md)).

### table::draw: rows … to … are joined by rowspan and need … pt, more than a page holds (… pt)

A block of rows joined by `rowspan` is never split. Here it does not
fit on any page. Reduce `rowspan` or split the group into several
blocks.

### table::group: -by … is outside the row (0..…)

The group column does not exist; counting starts at 0.

### table::group: the rows are not sorted by column …; a group falls into several blocks and each gets its own subtotal

Warning in `::pdf4tcl::warnings`, an error with `-strict 1`. Sort the
data by the group column beforehand, for example with
`lsort -index 0`. `group` deliberately does not sort.

### table::pivot: -agg must be sum, count, avg, min or max, not "…"

### orderTable: column widths total … pt, the text width is only … pt -- the table would be drawn past the edge of the page

`form::orderTable` does not fit into the type area. Reduce the widths
or use a smaller margin in the context.

### orderTable: … header(s) but only … column width(s)

One width per header.

### tablelist::render: … could not be reproduced (…). …

Warning from `pdf4tcltable`: images, embedded windows or wrapped cells
of the widget do not make it into the PDF. `tablelist::report` says
what exactly.

---

## Charts

### chart::…: no data

### chart::…: data must be label/value pairs or a list of {label value}, got … element(s)

An odd-length list: `{Jan 120 Feb}`. Empty values must be written as
a pair, e.g. `{Feb 0}`.

### chart::bar: value for "…" is not a number: "…"

Applies equally to `line` and `pie`. An empty field is not zero
([Charts](100-diagramme.md)).

### chart::bar: box too small -- … x … pt leaves no room for axis and labels

The box is smaller than axis and labels together. Increase the height
or make `-labelsize` smaller.

### chart::pie: negative value for "…" -- a slice of a whole cannot be negative

### chart::pie: the values add up to 0

---

## Column Flow and Table of Contents

### flow::…: -columns must be at least 1

### flow::boxes: … columns with a gap of … pt leave no width in … pt

Too many columns or too large a `-gap` for the width.

### toc::heading: level must be 1..6, got "…"

### toc::document: the contents was calculated as … page(s) and written as … -- every page number in it would be off by …

`pageCount` and `render` ran with different options, or
`toc::configure` was changed in between. The table of contents would be
numbered wrongly, so `document` aborts
([Table of Contents](110-inhaltsverzeichnis.md)).

---

## Images and Drawing

### image::place: -fit must be contain, cover or stretch, not "…"

### image::place: width and height must be positive

### image::place: image … has no size

The id does not come from `$pdf addImage`, or the image is empty.

### image::place: … at … dpi (…x… pixels on …x… points), below …

Warning with `-dpi`: the image resolution is too coarse for the area.

### image::gallery: -cols and -rows must be at least 1

### image::gallery: the frame is too small for …x… cells

The frame is not large enough for the grid, usually because of `-gap`
or `-captionH`. Up to 0.6.6 the result was `invalid command name "2"`
instead: building the message ran the column count as a command.

### pdf4tcllib::image needs Tk: …

`image::insert` and `insertAt` work with Tk images. For files without
Tk: `$pdf addImage` and `image::place`.

### drawing::arrow: -at must be end, start or both, not "…"

### drawing::callout: width and height must be positive

### drawing::watermark: no text

### canvas::place: no such widget: …

### canvas::place: no room left for the drawing after the caption

`-captionH` is as large as the box.

### canvas::fitPage: the context leaves no height

---

## Labels

### unknown label sheet "…"; known: …

The sheet is not registered. Define custom sheets with `labels::define`
([Label Sheets](130-etikettenboegen.md)).

### label format …: missing "…"

`labels::define` without one of the required keys.

### label format …: paper "roll" means one label per page, so cols and rows must both be 1

### argSpec must name five variables: {x y w h record}

The fourth argument of `labels::render`.

### -start must be between 0 and … for sheet …

### -only: "…" is not a position on sheet … (0..…)

### -only names … position(s) for … record(s)

One position per record.

### -frame: 0, 1 or layer, not "…"

### -frame layer needs pdf4tcl 0.9.4.70 or newer: … ignores -print 0, the grid would print

### -frame layer under -pdfa …: PDF/A forbids /AS, so -print 0 has no effect and the grid would print; use -frame 1 on a separate proof sheet

The helper grid sits on a layer that is not meant to be printed.
Older pdf4tcl versions and PDF/A cannot do that; the grid would end up
on the label.

---

## Fillable Forms

### forms::read: cannot read "…" / forms::write: cannot read "…"

The file is missing or is not a PDF with a form.

### forms::write: … has no field(s): …

Warning, an error with `-strict 1`: these names do not exist in the
form. Often the full name with a dot is missing (`person.city`, not
`city`).

### forms::write: nothing to fill in

The dict with the values is empty, or none of the names occurs in the
form.

### pdf4tclforms::renderSchema: spec needs 'sections' key

### pdf4tclforms::renderSchema: 'sections' must be a dict (name -> section), not a list of sections

### pdf4tclforms: field entry must be a dict, got: …

### pdf4tclforms::template: unknown template '…' (callnote inventory checklist order)

---

## Tk Widgets

### treeview::render: no such widget: … / treeview::outline: no such widget: …

The path is wrong, or the widget has already been destroyed.

---

## From pdf4tcl

Two warnings from pdf4tcl itself that are common with pdf4tcllib:

### tagged: the … element is empty -- no content, no child element and no annotation. …

A structure element without content. Up to pdf4tclchart 0.1.1 every
chart triggered it (`Figure`); since 0.1.2 it no longer does. If it
remains, there is a custom `tag::begin`/`tag::end` pair with nothing
drawn in between.

### … must contain at least one …

Error when closing an element, for example `Table` without `TR`.
Occurs with hand-built tables, not with `table::draw`
([Accessible PDFs](180-barrierefreie-pdfs.md)).

---

*Back to the [beginning](010-was-pdf4tcllib-ergaenzt.md)*
