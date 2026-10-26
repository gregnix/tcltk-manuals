# Treeview

## Introduction

Many Tk programs show their data in a `ttk::treeview`: warehouses with
items, projects with tasks, folders with files. The request "that as a
PDF" then means: exactly what is in the window. The package
[pdf4tcltreeview]{.index} reads out the widget and draws it, either as
a table with an indented tree column or as an outline.

It is a thin layer over `table::draw` (chapter
[Tables with Page Breaks](080-tabellen.md)). It needs Tk, because it
reads a widget.

---

## Table or Outline

A treeview is a table and a tree at the same time. In the PDF, one has
to choose, and that is why there are two procedures instead of one
option, [treeview::render]{.index} and [treeview::outline]{.index}:

| Procedure | draws | in the accessible PDF |
|---|---|---|
| treeview::render | a table, tree column indented | `Table`, `TR`, `TD` |
| treeview::outline | only the tree column, as a list | `L`, `LI`, `LBody` |

Both return the y position after the last entry.

---

## A Stock List

```tcl
# 170-treeview.tcl -- ein ttk::treeview als Tabelle und als Gliederung
package require Tk
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcltreeview

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]

# Das Widget: Baumspalte #0 plus zwei Wertespalten
ttk::treeview .tv -columns {menge wert} -show {tree headings}
.tv heading #0    -text "Lager / Artikel"
.tv heading menge -text "Menge"
.tv heading wert  -text "Wert €"
.tv column #0    -width 260
.tv column menge -width 80 -anchor e
.tv column wert  -width 100 -anchor e

foreach {lager offen artikel} {
    "Lager Nord" 1 {{"Schraube M6" 600 29.40} {"Schraube M8" 400 31.20}
                    {"Mutter M8" 900 18.00}}
    "Lager Süd"  1 {{"Dübel 8 mm" 1200 42.00}
                    {"Winkel 40 mm" 150 67.50}}
    "Außenlager" 0 {{"Palette leer" 34 0.00}}
} {
    set summe 0.0
    foreach a $artikel { set summe [expr {$summe + [lindex $a 2]}] }
    set k [.tv insert {} end -text $lager -open $offen \
        -values [list "" [format %.2f $summe]]]
    foreach a $artikel {
        lassign $a name menge wert
        .tv insert $k end -text $name \
            -values [list $menge [format %.2f $wert]]
    }
}
pack .tv
update idletasks

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]

# Seite 1: wie auf dem Bildschirm -- das Aussenlager ist zugeklappt
$pdf startPage
set x [dict get $ctx left]
set y [pdf4tcllib::treeview::render $pdf .tv $x [dict get $ctx top] \
    -maxwidth 300 -ctx $ctx]
puts "Tabelle wie angezeigt endet bei y = [format %.1f $y]"
# Dasselbe mit allen Zweigen
set y [pdf4tcllib::treeview::render $pdf .tv $x [expr {$y + 30}] \
    -maxwidth 300 -ctx $ctx -all 1]
puts "Tabelle mit -all 1 endet bei y = [format %.1f $y]"
$pdf endPage

# Seite 2: nur die Baumspalte als eingerueckte Liste, mit einem
# Lesezeichen je Knoten
$pdf startPage
set y [pdf4tcllib::treeview::outline $pdf .tv $x [dict get $ctx top] \
    -all 1]
puts "Gliederung endet bei y = [format %.1f $y]"
$pdf endPage

$pdf write -file 170-treeview.pdf
$pdf destroy
exit                        ;# sonst wartet Tk auf Ereignisse
```

```text
Tabelle wie angezeigt endet bei y = 200.7
Tabelle mit -all 1 endet bei y = 390.7
Gliederung endet bei y = 182.7
```

Page 1 as text:

```text
Lager / Artikel   Menge   Wert €
Lager Nord                 78.60
  Schraube M6       600    29.40
  Schraube M8       400    31.20
  Mutter M8         900    18.00
Lager Süd                 109.50
  Dübel 8 mm       1200    42.00
  Winkel 40 mm      150    67.50
Außenlager                  0.00
```

The second table additionally has "Palette leer" (empty pallet) below.

### The Script Needs an exit

With `package require Tk`, `tclsh` waits for events after the last
command instead of terminating. The `exit` at the end is therefore
required. The window does not have to be visible, but Tk needs a
display. On a server without a screen, the script runs with
`xvfb-run tclsh 170-treeview.tcl`.

The package documentation recommends the `update idletasks` before the
export. In the example it changes nothing, because all columns have a
fixed width; for columns whose width Tk only computes when they are
displayed, it is the safe way.

---

## render

```tcl
set y [pdf4tcllib::treeview::render pdf tv x y ?option wert ...?]
```

| Option | Default | Meaning |
|---|---|---|
| `-maxwidth` | `480` | width of the table |
| `-fontsize` | `9` | font size |
| `-all` | `0` | `1`: collapsed branches as well |
| `-tree` | `1` | `0`: do not indent the tree column |
| `-indentW` | `12` | indentation per level |
| `-zebra`, `-border` | `1`, `1` | stripes, lines |
| `-ctx` | – | page context; switches on page breaking |
| `-font`, `-boldfont` | – | fonts instead of those from `fonts::init` |
| `-summary` | – | summary of the table (accessibility) |

**What is collapsed stays collapsed.** The PDF shows what is visible in
the window; in the example, the first table lacks the contents of the
"Außenlager" (outdoor storage). `-all 1` takes everything.

The column widths come from the widget in pixels and are scaled to
`-maxwidth`; the proportions are kept. The alignment comes from the
column's `-anchor`: `e` becomes right-aligned.

What `render` does not read: colors and fonts of individual entries
(`-tags` with `tag configure`), images. The nodes "Lager Nord" etc.
appear in the same font as the items. `render` does not pass
`-rowstyles` through to `table::draw`; to get bold group rows, read out
the widget yourself and call `table::draw` directly.

### Page Breaks

With `-ctx`, the table breaks at the bottom margin, but with the
built-in page break of `table::draw`: `- 1 -` at the bottom right, no
header or footer on the following page. `render` has no
`-pagebreakcmd`; passing it gives an error with the list of known
options.

---

## outline

```tcl
set y [pdf4tcllib::treeview::outline pdf tv x y ?option wert ...?]
```

| Option | Default | Meaning |
|---|---|---|
| `-fontsize` | `10` | font size |
| `-indentW` | `14` | indentation per level |
| `-lineH` | `0` | line spacing; `0` means 1.4 × size |
| `-all` | `0` | collapsed branches as well |
| `-bookmarks` | `1` | one bookmark per node |
| `-font` | – | font |

A node without text takes the first value.

### Bookmarks

`-bookmarks 1` creates a bookmark for each node, at the depth in the
tree: "Schraube M6" sits below "Lager Nord". In the example this is the
default. Up to pdf4tcltreeview 0.1, none were created: `outline` called
`bookmarkAdd` in a form that pdf4tcl does not understand and silently
caught the error. With 0.1, create them yourself:

```tcl
proc lesezeichen {tv knoten ebene} {
    global pdf
    foreach k [$tv children $knoten] {
        $pdf bookmarkAdd -title [$tv item $k -text] -level $ebene
        lesezeichen $tv $k [expr {$ebene + 1}]
    }
}
lesezeichen .tv {} 0
```

The bookmarks point to the top of the page on which they are created;
`bookmarkAdd` knows no position within the page.

---

## Both in One Document

Table and outline describe the same data. A screen reader reads both
aloud if both are present. If both are needed (overview at the front,
table at the back), put them on separate pages and say in a heading
what follows.

---

## Summary

- `treeview::render` for the table, `treeview::outline` for the
  outline; both need Tk.
- The script ends with `exit`; without a screen, use `xvfb-run`.
- Collapsed branches are missing, except with `-all 1`.
- `outline` creates one bookmark per node (since 0.1.1).
- Page breaking only the built-in way, without a header.

---

*Next chapter: [Accessible PDFs](180-barrierefreie-pdfs.md)*
