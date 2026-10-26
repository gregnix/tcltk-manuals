# Error Messages

Common messages and their usual cause.

---

## no font set

`addForm` for `combobox`, `listbox`, `pushbutton` or `signature`
before `setFont`. Text fields and check boxes may come earlier.
Since 0.9.4.63; formerly `can't read "FontsAttrs(,specialencoding)"`.

## unknown color: "1" -- expected a name like "red", "#rrggbb", …

The color is not a 0..1 triple, not hex, not a table name. `1` alone
is invalid. Since 0.9.4.63 the message includes an example.

## unknown color / invalid … component

A component outside 0.0 .. 1.0 (since 0.9.4.39). Replace `255 0 0`
with `1 0 0` or `#ff0000`.

## createFontSpecCID: base font '…' not loaded

`loadBaseTrueTypeFont` is missing or the base name differs.

## invalid TTF file checksum

A damaged or incomplete TrueType file. CID subsets before 0.9.4.68
carried a table checksum of 0 and failed here when loaded again.

## fillForms: no such field(s)

The name is not in the form. Since 0.9.4.64 the full chain:
`person.city`, not `city`. Do not ignore typos — otherwise the form
stays empty without explanation.

## fillForms: "…" is not an option of "…"

The choice value is neither an export value nor a label. An empty
value is allowed. Since 0.9.4.65.

## unknown form type …

The type is not in `text checkbutton combobox listbox password
radiobutton pushbutton signature`. Alias: `checkbox` for
`checkbutton`.

## unknown metadata option "…"

Only `-author -creator -keywords -producer -subject -title
-creationdate -moddate`.

## papersize "…" is unknown

Neither an ISO name nor a two-element list `{breite höhe}` (width,
height).

## rotation … not a multiple of 90

`-rotate` accepts only multiples of 90.

## endLayer without beginLayer / layer still open

Layer calls are not paired. `endPage` with an open layer is an error
(0.9.4.63, ISO 32000-1 14.6).

## Adobe: Blank Page, No Message

No throw. `q` inside `BT` (before 0.9.4.62), a CID subset without a
cmap (before 0.9.4.68) or tagged `Tj` outside `BT`/`ET`
(before 0.9.4.69). Often full in Poppler. See
[gsave and Text](160-gsave-und-text.md) and
[CID Subset and CMap](170-cid-subset-cmap.md).

## qpdf: inflate: incorrect header check

An encrypted PDF with CID from 0.9.4.66 or earlier. Rebuild with
0.9.4.67+. See [Encryption](110-verschluesselung.md).

## PDF/A: the standard font Helvetica has no embeddable font program

A warning in `::pdf4tcl::warnings`, no abort. veraPDF fails.
Load a TrueType font.

## pdf4tcl: linkAdd target(s) never defined with destinationAdd: …

A warning on stderr when writing, no abort. A `linkAdd` names a name
that no `destinationAdd` created; the link has no effect. Make the
names match. See [Annotations](100-annotationen.md).

## destination "…" already defined

The same name passed twice to `destinationAdd`. Names are unique per
document.

## invalid destination name "…": must match [A-Za-z0-9._-]+

A space, umlaut or special character in the name of a destination or
link.

---

*End of the appendices. Start: [Understanding pdf4tcl](010-pdf4tcl-verstehen.md)*
