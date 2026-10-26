# Glossary

**256-character mode** (256-Zeichen-Modus) — default of `fonts::init`:
ASCII, Latin-1 and 32 selected characters in a simple encoding.

**Accessor procedure** (Zugriffsprozedur) — `fonts::fontSans` and
related procedures; they return the name under which `fonts::init`
registered a font.

**Alternate text** (Ersatztext) — description of a figure for readers
who cannot see it; `-alt`.

**Appearance** (Erscheinung) — what a form field shows on the page as
long as nobody clicks into it. With `/NeedAppearances` the viewer
rebuilds it.

**Artifact** (Artefakt) — content without meaning for the text (rules,
header, page number); a screen reader skips it. `tag::artifact`.

**Baseline** (Grundlinie) — the line the letters stand on; `y` in
`$pdf text` refers to it.

**Bookmark** (Lesezeichen) — entry in the outline at the side of the
viewer; `toc::heading` creates one per heading.

**CID mode** (CID-Modus) — font with Identity-H encoding; every
character of the TrueType file is available. Turn it on with
`fonts::init -cid 1`.

**Frame (image)** (Rahmen) — the area into which `image::place` fits an
image; `contain` leaves space free, `cover` crops.

**Page context** (Seitenkontext) — the dict from `page::context` with
all measurements of the page.

**Point** (Punkt) — unit of measurement of PDF and pdf4tcl, 1/72 inch,
about 0.353 mm.

**Structure tree** (Strukturbaum) — the outline of an accessible PDF in
headings, paragraphs, tables and figures; `$pdf tagged 1`.

**Type area** (Satzspiegel) — the area inside the margins where the
content goes; `left`, `top`, `text_w`, `text_h` in the page context.

---

*Next chapter: [Error Messages](830-anhang-fehlermeldungen.md)*
