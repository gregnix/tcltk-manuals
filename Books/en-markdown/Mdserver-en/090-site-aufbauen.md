# Building a Site

## Introduction

From an empty folder to a readable site. Keep content and server
apart: the root contains only what may be served.

---

## Minimal Tree from the Repository

```
arbeit/
  mdstack/
    lib/
      mdstack/parser-0.9.2.tm
      mdstack/html-0.2.tm
      mdstack/theme-0.1.tm
    tools/
      mdserver/
        lib/mdserver-0.4.tm
        lib/pdftext-worker.tcl
        styles/
        mdserver.tcl
        mdctl.tcl
        mkcert.tcl
  docir/
    lib/tm/
      docir-0.1.1.tm
      docir/...
  meinprojekt/
    docs/
      index.md
      einleitung.md
      api/
        index.md
```

`docs/` is `--root`. `tools/mdserver/` is the service. Without the
mdstack `lib/` and without `docir/` next to it, it does not start. The
launcher finds both by itself (chapter *Starting*). For an installation
without the repository the modules go into `lib/` next to
`mdserver.tcl` — the exact list is there as well.

---

## Start

```bash
cd arbeit/mdstack/tools/mdserver
tclsh mdserver.tcl --root ../../../meinprojekt/docs --port 8080 \
    --title "Mein Projekt" --control 8099
```

`http://127.0.0.1:8080/`. Without `index.md` the cards appear.

Books need no preparation any more. If the `index.md` is missing,
mdserver generates the landing page from `book.tcl`.
`book-webindex.tcl` (bookkit) is optional — for a fixed `index.md` and
a `stichwortverzeichnis.md`. `mdstack::indexgen` writes `index.md` for
folders without `book.tcl` when needed; in style `site` the cards are
enough.

---

## Recommended Site

One root for the LAN, service and keys beside it:

```
/srv/md/                          --root
  index.md                        Startseite
  buecher/
    book-beispiel/
      README.md
      Beispiel-de/
        book.tcl
        010-einleitung.md
        ...
      Beispiel-de.pdf
      Beispiel-de.html
    book-zweites/
      ...
  tcltk/
    index.md                      aus nroff2md
    dict.md
    ...
  notizen/
    ...
  pdfs/
    handbuch.pdf                  mit tclutils durchsuchbar
/opt/mdserver/                    Dienst
  mdserver.tcl
  mdctl.tcl
  lib/
  styles/
/etc/mdserver/                    Schlüssel, außerhalb von --root
  server.crt
  server.key
```

(The comments in the tree are German: start page, from nroff2md,
searchable with tclutils, service, keys outside `--root`.)

**Books.** The bookkit folders `book-xyz/` go unchanged into
`buecher/`, together with the built `.pdf` and `.html` next to the book
folder. `/buecher/` shows them as book cards with subtitle and language.
Inside a book, PDF and HTML are above the chapter list and on the
landing page.

**Tcl/Tk manual.** `nroff2md` (from `mdstack/tools/`) converts the nroff
manual pages of the Tcl/Tk sources to Markdown. For a subfolder,
`--linkmode file` is needed:

```bash
tclsh nroff2md.tcl --batch tcltkdoc/ /srv/md/tcltk/ --linkmode file
```

`--linkmode server` writes links as `/dict` — absolute to the root.
That only fits when the manual itself is `--root`. In `/srv/md/tcltk/`,
`/dict` would point nowhere. `--linkmode file` writes `dict.md`,
relative and therefore right in every folder.

**Keys.** `server.crt` and `server.key` lie outside `--root`, for
example in `/etc/mdserver/`. Never in `/srv/md/`: there mdserver serves
them. Behind nginx mdserver needs no key at all.

---

## Demo

`tools/mdserver/demo/` holds `start.tcl` and sample documents in
`docs/`, among them a book. For looking at the service, not as a
production root.

```bash
cd tools/mdserver
tclsh mdserver.tcl --root demo/docs --port 8080
```

---

## Summary

- Root = content. Script tree = service. Keys elsewhere.
- The mdstack `lib/` and docir belong to the service.
- `index.md` in the root is the start page.
- Books need no webindex run; bookkit folders into `buecher/`.
- Manual in a subfolder: `nroff2md --linkmode file`.
- PDFs in the root are searchable page by page with tclutils.

---

*Next chapter: [Pitfalls](800-anhang-fallen.md)*
