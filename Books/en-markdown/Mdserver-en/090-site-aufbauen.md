# Building a Site

## Introduction

From an empty folder to a readable site. Keep content and server
apart: the root contains only what may be served.

---

## Minimal Tree from the Repositories

```
arbeit/
  mdserver/
    mdserver.tcl
    mdctl.tcl
    mkcert.tcl
    lib/mdserver-0.5.tm
    lib/mdserver/...
    styles/
  mdstack/
    lib/mdstack/...
  docir/
    lib/tm/...
  meinprojekt/
    docs/
      index.md
      einleitung.md
      api/
        index.md
```

`docs/` is `--root`. `mdserver/` is the service. Without mdstack and
docir it does not start; as neighbouring folders the launcher finds
both by itself (chapter *Starting*). For an installation without the
repositories the modules go into `lib/` next to `mdserver.tcl` — the
exact list is there as well.

---

## Start

```bash
cd arbeit/mdserver
tclsh mdserver.tcl --root ../meinprojekt/docs --port 8080 \
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
/opt/mdstack/  /opt/docir/        Nachbarn, findet der Launcher selbst
/etc/mdserver/                    außerhalb von --root
  mdserver.conf                   Einstellungen (--config)
  zugriff.txt                     Rechte (--access)
  benutzer.txt                    Benutzer (--users)
  server.crt
  server.key
```

(The comments in the tree are German: start page, from nroff2md,
searchable with tclutils, service, neighbours the launcher finds by
itself, outside `--root`, settings, rights, users.)

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

**Keys and access.** `server.crt`, `server.key`, `zugriff.txt` and
`benutzer.txt` lie outside `--root`, for example in `/etc/mdserver/`
next to `mdserver.conf`. Never in `/srv/md/`: there mdserver serves
every file. For `zugriff.txt` and `benutzer.txt` the server refuses to
start, for the keys it does not. Behind nginx without a login of its
own, mdserver needs no key at all.

**As a service.** A complete example of exactly this layout is in the
mdserver repository under `beispiel/server/`: mdserver in an
unprivileged LXC container with an address of its own in the home
network, documents and program mounted read-only, service user
`mdserver`, settings file, access control and HTTPS. The guide is
`README.md` there (in German); `install.sh` does the steps inside the
container. Under Proxmox, creating the container by hand is not needed;
the rest is the same.

---

## Demo

`demo/` in the mdserver repository holds `start.tcl` and sample
documents in `docs/`, among them a book. For looking at the service,
not as a production root.

```bash
cd mdserver
tclsh mdserver.tcl --root demo/docs --port 8080
```

---

## Summary

- Root = content. Script tree = service. Keys, settings and access
  elsewhere.
- Complete example as a service in an LXC container: `beispiel/server/`
  in the mdserver repository.
- mdstack and docir belong to the service, most simply as neighbours.
- `index.md` in the root is the start page.
- Books need no webindex run; bookkit folders into `buecher/`.
- Manual in a subfolder: `nroff2md --linkmode file`.
- PDFs in the root are searchable page by page with tclutils.

---

*Next chapter: [Pitfalls](800-anhang-fallen.md)*
