# Page Layout and Search

## Introduction

`site` is the default style. It builds every page the same way, with a
single stylesheet (`styles/site.css`) and no JavaScript. On top comes a
[full-text search]{.index} over all Markdown files of the root, on
request also over PDFs.

Why a style of its own: the older ones turned `<body>` into a grid. A
long sidebar then pushed the text below a gap of its height.

---

## Layout of a Page

```
+--------------------------------------------------------------+
| [=] Titel  Start  Alle Dokumente  Bereich …        [Suchen]  |
+--------------+--------------------------------+--------------+
| Seitenleiste | Start > Ordner > Seite         | Auf dieser   |
|  Buch:       |                                | Seite        |
|  Übersicht   | # Überschrift                  |  - h2        |
|  Kapitel 1   | Text …                         |    - h3      |
|  Kapitel 2   |                                |  - h2        |
|              | [← Zurück]          [Weiter →] |              |
+--------------+--------------------------------+--------------+
```

| Part | Contents |
|---|---|
| header bar | site title, Start, Alle Dokumente, sections, search field |
| sidebar | in a book: title, PDF/HTML, Übersicht (overview) and chapters; otherwise subfolders and documents of the folder |
| breadcrumbs | Start › folder title › page title |
| middle | the rendered content |
| Zurück/Weiter | two cards (back/next), only in book chapters |
| `Auf dieser Seite` | h2 and h3 of the page, from three entries on |

The [breadcrumbs]{.index} use the folder title as label: book title
from `book.tcl`, else the H1 of the `index.md`, else the H1 of the
`README.md`, else the folder name. If a bookkit folder `book-xyz/` and
its book `Xyz-de/` have the same title, it appears only once.

The column `Auf dieser Seite` is missing with fewer than three h2/h3
headings. The sidebar is missing when the folder has nothing to show.

---

## Manual Pages

A [manual page]{.index} converted to Markdown starts with `# NAME`
(German also `# BEZEICHNUNG`) and has further H1 such as `# SYNOPSIS`
and `# DESCRIPTION`. mdserver recognises such pages by their first H1
and treats them like this in style `site`:

| Place | Value |
|---|---|
| title, breadcrumbs, sidebar, card, search hit | `CommandName` from the YAML head (TIP 700 form), else the part of the NAME line before the dash (`grab - Eingaben umlenken` becomes `grab`) |
| `Auf dieser Seite` | h1 and h2 instead of h2 and h3 as soon as the page has more than one H1 |

Without a YAML head and without a NAME line the title stays `NAME`. The
list `Alle Dokumente` (`/?nav=index`) still takes the first H1; there
such pages are called `NAME`.

---

## Folders Without index.md

If a folder has neither `index.md` nor `book.tcl`, `site` shows its
contents as cards. A [card]{.index} shows a title and a short text. At
the top the folder title, below it the first paragraph of the
`README.md`, if there is one. Then up to four groups:

| Group | What goes in | Card shows |
|---|---|---|
| Bücher (books) | folders with `book.tcl`, or a folder that holds books directly | badge "Buch", title, subtitle, languages |
| Bereiche (sections) | other folders, if a `.md` or `.pdf` lies below them | title, first paragraph of `index.md` or `README.md` |
| Dokumente (documents) | `.md` files except `index.md`, plus `.pdf` | H1 and first paragraph; for a PDF the file name, "PDF" and size |
| Dateien (files) | everything else except `.md`, `.pdf`, `.tcl`, `.tsv`, `.css` | name, type, size in KB |

A folder that holds only PDFs counts as a folder of documents. It
appears in the header bar, in the sidebar and among the cards. The
sidebar of a folder lists its PDFs after the Markdown documents, marked
"PDF".

A bookkit folder `book-xyz/` with exactly one book in it leads straight
into the book. With several editions (`Xyz-de/`, `Xyz-en/`) the card
leads into the folder, and the languages are shown on the card.

Dot folders and dot files never appear. An empty folder shows `Keine Dokumente
gefunden.` (no documents found).

The older styles show a plain list instead, rendered through mdstack.

---

## Dark Mode, Phone, Print

**Dark.** [Dark mode]{.index} follows the system setting
(`prefers-color-scheme`). `?theme=dunkel` or `--theme dunkel` force it.

**Narrow screens.** Below 1180 px width the column `Auf dieser Seite`
disappears. Below 820 px the sidebar and the links of the header bar
disappear; on the left of the header bar the menu button appears (three
bars, `[=]` in the picture). It opens the sidebar together with the
header links. It is a checkbox with CSS, no JavaScript.

**Print.** Header bar, both side columns, breadcrumbs and the
Zurück/Weiter cards are left out. The text is printed.

---

## Missing Page

An unknown URL gives **404** with a page in the same layout: `Nicht gefunden`
(not found), plus links to the start page and to *Alle
Dokumente*. The older styles send a plain 404 page.

---

## Search

The header bar holds a search field. It sends `/?q=words`. The address
also works by hand:

```
http://127.0.0.1:8080/?q=control+port
```

Rules:

- All words must occur (AND). Words shorter than two characters are
  dropped.
- Case does not matter.
- [Umlaut folding]{.index}: `ae`, `oe`, `ue`, `ss` match `ä`, `ö`, `ü`,
  `ß` — and the other way round. `groesse` finds "Größe".
- The search runs over the text without Markdown characters and without
  link targets.
- Hits in the title (first H1) count more than hits in the text.
- At most 50 hits, best first.

Each hit shows the title as a link, below it the folder path
(`Bücher › Beispiel`, folder titles as in the breadcrumbs; empty for a
file in the root) and a snippet of about 220 characters. It starts
shortly before the first hit in the text, even if that is far down. The
search words are marked in it, also in mixed spellings: `groesse` marks
"Grösse", "Größe" and "GROESSE".

**What is searched.** All `.md` below `--root`. Each text is read once
and kept with its mtime; a new search rereads only changed files. Dot
folders stay out (except with `--dotfiles 1`), symlinks always — as
when serving.

**PDFs.** If [`tclutils::tupdftext`]{.index} loads (tclutils 0.67.0 or
later, on the module path or through `TCLUTILS_TM`), `?q=` also searches
every `.pdf` below the root, page by page. That is the default
`--pdf-search auto`; `--pdf-search 1` warns at the start when the
package is missing, `0` turns it off. A hit is called `handbuch, S. 17`
("S." for page) and links to `handbuch.pdf#page=17`. Firefox (pdf.js)
and Chrome jump to that page; other viewers open the file at the start.

`tupdftext` reads the text in pure Tcl. It goes into `--pdf-cache`
(default `$HOME/.cache/mdserver-pdf`, never inside the root), one file
per PDF, valid while mtime and size match. A PDF without text (scan,
encrypted) gives no hit. If `tupdftext` cannot read a file (damaged,
not a PDF), it is also cached as empty, and the log says why:

```
[10:29:26] pdf worker: /srv/md/pdfs/kaputt.pdf has no text, reader failed: not a PDF (no %PDF- header): /srv/md/pdfs/kaputt.pdf
```

The reading happens in a `tclsh` of its own per PDF, the PDF worker
(`lib/pdftext-worker.tcl`, `--pdf-worker 1`, the default). mdserver
starts it with `tclutils::tutask`, which comes with `tupdftext` anyway:

```tcl
await [pipe [list $tclsh pdftext-worker.tcl $pdf ...] -encoding utf-8] \
    -timeout 600000
```

`await` only suspends the task that works through the PDFs one after
the other; the event loop keeps running. The cache fills right after
the start and then for every new or changed PDF. mdserver does not wait
for it: a search returns what is in the cache and adds
`3 PDFs werden noch gelesen; ihre Seiten fehlen in dieser Liste` (3
PDFs are still being read; their pages are missing from this list). Pages and all
other requests are answered at once.

With `--pdf-worker 0` mdserver reads the PDFs in its own process.
mdserver has a single event loop, and while `tupdftext` runs, it stands
still for everyone. Measured with 16 PDFs (1804 pages), empty cache:

| | first search | page requested at the same time |
|---|---:|---:|
| in the server process (`--pdf-worker 0`) | 36.4 s | 36.3 s |
| with worker | 0.03 s | 0.04 s |

The worker took 35.9 s for the 16 PDFs, as long as the server process:
one `tclsh` per PDF costs no measurable time; afterwards a search over
all pages takes 0.03 s. After a restart with a filled cache, 0.3 s for
the first search, because the cache files are read in.

When there is no worker or it fails:

- Without `tclutils::tutask`, without `pdftext-worker.tcl`, or when
  mdserver runs as a starpack (`info nameofexecutable` then starts the
  application, not a `tclsh`), mdserver reads itself, as with
  `--pdf-worker 0`.
- If the worker fails on a PDF (crash, exit code, more than 10
  minutes), the log says so and the next search tries again. The second
  time the PDF stays out until it changes (empty entry in the cache).
- When mdserver stops through the control port (`mdctl.tcl … stop`),
  `tutask` cancels the running worker. If mdserver dies hard, the worker
  finishes its one PDF and then ends.

Whether the PDF search is on is shown in the start banner:

```
  PDF:   Suche an (tclutils::tupdftext 0.1, Cache /var/cache/mdserver-pdf)
  PDF:   Suche aus (--pdf-search 0)
  PDF:   Suche aus: tclutils::tupdftext nicht gefunden (TCLUTILS_TM setzen oder tclutils/lib/tm auf den Modulpfad)
```

"Suche an" means search on, "Suche aus" search off; the last line says
that tclutils was not found. The first line belongs to a start with
`--pdf-cache /var/cache/mdserver-pdf`.

Apart from the banner, `auto` says nothing. Under systemd,
`TCLUTILS_TM` therefore belongs in the unit
(`Environment=TCLUTILS_TM=…`).

**Older styles.** `?q=` works there too. The answer is a plain list
"Suche: …" with title and folder path, without snippet. There is no
search field.

---

## Summary

- `site` is a whole layout, without JavaScript, with one stylesheet.
- Folders without `index.md` become cards: books, sections, documents,
  files.
- Dark following the system or `theme=dunkel`; menu button below
  820 px.
- Manual pages with `# NAME` are named after the command.
- `/?q=` searches with AND, ignoring case, with umlaut folding.
- With tclutils (0.67.0 or later) also in PDFs, one hit per page
  (`file.pdf#page=N`); the text is cached outside the root.

---

*Next chapter: [HTTP Behaviour](050-http-verhalten.md)*
