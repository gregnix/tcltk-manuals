# Table of Contents

## Introduction

A table of contents stands at the front, yet it lists page numbers that
are only known once everything after it has been set. And it shifts
those page numbers itself, by as many pages as it is long. It cannot be
done without two passes. The package [pdf4tcltoc]{.index} makes both
passes and also writes a bookmark for each heading.

---

## The Content as a Script

```tcl
package require pdf4tcltoc
set r [pdf4tcllib::toc::document pdf papier skript ?option wert ...?]
```

The content is not drawn directly but passed as a script, because
[toc::document]{.index} has to run it twice:

1. into a throwaway document; each heading records the page it lands
   on;
2. into the real document, after the table of contents has been
   written.

The script sees two variables: `pdf` (in the first pass, the throwaway
document) and `ctx`. The script starts and ends its pages itself. It
sets headings with [toc::heading]{.index}; only what is set this way
goes into the table of contents.

```tcl
# 110-inhaltsverzeichnis.tcl -- Verzeichnis mit echten Seitenzahlen
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcltoc

pdf4tcllib::fonts::init -cid 1

set kapitel {
    {1 "Einleitung"} {2 "Zweck des Berichts"} {2 "Datenquellen"}
    {1 "Bestand"}    {2 "Lager Nord"} {2 "Lager Süd"}
    {1 "Ausblick"}
}
set absatz "Der Bestand wurde am Monatsende gezählt und mit der\
    Buchung abgeglichen. Abweichungen unter zwei Stück sind\
    ausgebucht."

# Der Inhalt als Skript: es sieht die Variablen pdf und ctx,
# beginnt seine Seiten selbst und laeuft zweimal -- also keine
# Nebenwirkungen.
set inhalt {
    $pdf startPage
    set y [dict get $ctx top]
    foreach k $kapitel {
        lassign $k ebene titel
        if {$ebene == 1 && $y > [dict get $ctx top]} {
            $pdf endPage; $pdf startPage; set y [dict get $ctx top]
        }
        pdf4tcllib::toc::heading $pdf $ctx y $ebene $titel
        for {set i 0} {$i < 12} {incr i} {
            if {$y > [dict get $ctx bottom] - 40} {
                $pdf endPage; $pdf startPage; set y [dict get $ctx top]
            }
            set y [pdf4tcllib::text::writeParagraph $pdf $absatz \
                [dict get $ctx left] $y [dict get $ctx text_w] 11]
        }
    }
    $pdf endPage
}

set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
set r [pdf4tcllib::toc::document $pdf a4 $inhalt -title "Inhalt"]
puts "Verzeichnis: [dict get $r tocPages] Seite(n),\
    Inhalt: [dict get $r contentPages] Seiten"
foreach e [dict get $r entries] { puts "  $e" }
$pdf write -file 110-inhaltsverzeichnis.pdf
$pdf destroy
```

```text
Verzeichnis: 1 Seite(n), Inhalt: 5 Seiten
  1 Einleitung 2
  2 {Zweck des Berichts} 2
  2 Datenquellen 3
  1 Bestand 4
  2 {Lager Nord} 4
  2 {Lager Süd} 5
  1 Ausblick 6
```

The table of contents itself on page 1:

```text
Inhalt
Einleitung ............................................. 2
    Zweck des Berichts ................................. 2
    Datenquellen ....................................... 3
Bestand ................................................ 4
    Lager Nord ......................................... 4
    Lager Süd .......................................... 5
Ausblick ............................................... 6
```

The page numbers in the result are already shifted by the length of
the table of contents; they match the finished PDF.

### What the Script Must Not Do

Because it runs twice, the script must have **no side effects**: no
appending to a file, no incrementing a counter outside the script, no
reading from a channel that the first pass has already drained. Data is
loaded beforehand, like `kapitel` and `absatz` in the example.

### Which Context Applies

`toc::document` builds its own context from the paper with
`page::context papier`, that is, with a 20 mm margin and y pointing
down. A `ctx` that the caller built beforehand is **not** used but
overwritten: after the call, `ctx` holds the context of
`toc::document`, and `pdf` holds the real document again. A different
margin requires the manual route (section
[A Cover Page in Front](#a-cover-page-in-front)).

---

## Headings

```tcl
pdf4tcllib::toc::heading pdf ctx yVar ebene text ?option wert ...?
```

The level (1 to 6) determines three things: the font size (18 minus 2
per level, at least 10), the indentation in the table of contents and,
in the accessible PDF, the element `H1` to `H6`. `yVar` is the name of
the y variable, as with the form procedures; afterwards it points below
the heading.

| Option | Meaning |
|---|---|
| `-size` | font size instead of the level's default |
| `-gap` | space below the heading (default 4) |
| `-tag` | structure element instead of `H<ebene>` |

Two things `heading` does not do:

- **Bold.** The heading goes through `text::writeParagraph` and is set
  in the regular font, only larger. A bold heading has to be drawn
  separately without calling `heading`, but then it is missing from the
  table of contents.
- **Breaking.** `heading` does not check whether there is still room
  below the heading. The example therefore starts every level-1 chapter
  on a new page and checks the bottom margin before each paragraph.

---

## Options of toc::document

| Option | Default | Meaning |
|---|---|---|
| `-title` | `Contents` | heading of the table of contents |
| `-titlesize` | `16` | its size |
| `-size` | `11` | size of the entries |
| `-leader` | `.` | leader character up to the page number; `""` for none |
| `-indent` | `14` | indentation per level in points |
| `-gap` | `4` | space below each heading |
| `-bookmarks` | `1` | one bookmark per heading |

The default for `-title` is English; a German document needs
`-title "Inhalt"`.

`-gap` and `-bookmarks` apply to the headings of this call; afterwards
the package configuration is back to what it was. For all following
documents in the same process:

```tcl
pdf4tcllib::toc::configure -bookmarks 0
```

Up to pdf4tcltoc 0.1 the two options had no effect on `toc::document`:
`heading` only read the configuration, and `-bookmarks 0` still wrote
bookmarks. On the manual route (below), `heading` is called without
`document`; there `toc::configure` still applies.

---

## A Cover Page in Front

`toc::document` writes the table of contents first into the document.
A cover page in front of it is not possible this way. The building
blocks that `document` consists of can, however, be called one by one:
[toc::collect]{.index}, `toc::pageCount` and `toc::render`.

| Procedure | does |
|---|---|
| toc::collect `skript ?versatz?` | runs the script and returns the entries |
| `toc::pageCount ctx einträge ?option ...?` | how many pages the table of contents needs |
| `toc::render pdf ctx einträge ?option ...?` | writes the table of contents, on pages of its own |

With these, any order can be built:

```tcl
# 110-mit-deckblatt.tcl -- Deckblatt vor dem Inhaltsverzeichnis
package require pdf4tcl
package require pdf4tcllib
package require pdf4tcltoc

pdf4tcllib::fonts::init -cid 1
set ctx [pdf4tcllib::page::context a4 -margin 20]

set inhalt {
    foreach titel {Einleitung Bestand Ausblick} {
        $pdf startPage
        set y [dict get $ctx top]
        pdf4tcllib::toc::heading $pdf $ctx y 1 $titel
        $pdf endPage
    }
}

# 1. Probelauf in ein Wegwerf-Dokument: wo stehen die Ueberschriften?
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
set eintraege [pdf4tcllib::toc::collect $inhalt]
$pdf destroy

# 2. Seitenzahlen verschieben: um das Deckblatt und das Verzeichnis
set vorne 1
set n [pdf4tcllib::toc::pageCount $ctx $eintraege -title "Inhalt"]
set eintraege [lmap e $eintraege {
    lset e 2 [expr {[lindex $e 2] + $vorne + $n}]
}]

# 3. Das echte Dokument: Deckblatt, Verzeichnis, Inhalt
set pdf [pdf4tcl::new %AUTO% -paper a4 -orient true]
$pdf startPage
pdf4tcllib::page::centerText $pdf $ctx "Bestandsbericht" 300 28 \
    [pdf4tcllib::fonts::fontSansBold]
$pdf endPage
pdf4tcllib::toc::render $pdf $ctx $eintraege -title "Inhalt"
eval $inhalt

puts "Einträge: $eintraege"
puts "Seiten: [$pdf pageCount]"
$pdf write -file 110-mit-deckblatt.pdf
$pdf destroy
```

```text
Einträge: {1 Einleitung 3} {1 Bestand 4} {1 Ausblick 5}
Seiten: 5
```

Here the script runs in the caller's own scope and therefore sees the
caller's own `ctx` with its own margin. `collect` sets no bookmarks;
they are only created in the second pass with `eval`. The shift is
computed by hand: pages before the table of contents plus the length of
the table of contents.

`pageCount` and `render` must receive the same options; otherwise the
number of table-of-contents pages is wrong. `toc::document` checks this
and raises an error; the manual route checks nothing.

---

## Summary

- `toc::document` with the content as a script without side effects; it
  runs twice.
- Headings with `toc::heading`; they are set in the regular font and do
  not break pages themselves.
- The context comes from the paper, not from the caller.
- Turn off bookmarks with `-bookmarks 0` on the call or
  `toc::configure -bookmarks 0` for all documents.
- Cover page in front: `collect`, `pageCount`, `render` by hand.

---

*Next chapter: [Form Layout](120-formular-layout.md)*
