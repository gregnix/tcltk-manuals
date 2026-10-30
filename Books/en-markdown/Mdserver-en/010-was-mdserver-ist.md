# What mdserver Is

## Introduction

[mdserver]{.index} **0.4** is an HTTP service in pure Tcl (no Tk). It
serves Markdown files as HTML, rendered at request time. One coroutine
per connection, non-blocking I/O: a slow client does not block the
others.

Module: `mdstack/tools/mdserver/lib/mdserver-0.4.tm`. Start script:
`mdstack/tools/mdserver/mdserver.tcl`.

This manual covers starting and options, navigation and themes, page
layout and search, HTTP behaviour, the control port, TLS, running
behind a proxy and building a site. The appendices collect pitfalls,
command lines, a glossary and error messages. Changes from version to
version are in the package documentation under
`mdstack/tools/mdserver/`; this book describes the current state.

The pages mdserver generates are in German. This book quotes their
labels as they appear (`Start`, `Alle Dokumente`, `Auf dieser Seite`)
and gives the meaning on first use.

---

## What It Does

- HTTP always, HTTPS optional (`tls`)
- Page layout `site` as the default: header bar, sidebar, breadcrumbs,
  `Auf dieser Seite` (on this page), folders as cards, dark mode
- Full-text search over all `.md` files of the root: `/?q=words`; with
  tclutils also over PDFs, one hit per page
- Older styles `plain`, `sidebar`, `sticky`, `collapsible` with theme
  and TOC by option and by URL
- Navigation: start page, site index, sections from the top-level folders
- Range (206), conditional GET (304), control port
- Static files (PDF, images, CSS)
- Directory page when there is no `index.md`
- Book folders with `book.tcl`: chapter navigation, generated landing page

Dual: Tcl **8.6** and **9.0**.

## What It Does Not Do

No parser of its own — it renders through mdstack and docir. No reverse
proxy, no authentication, no firewall. Behind a proxy that does the
authentication, use `--bind 127.0.0.1`. The LAN installation is covered
in the books *Proxmox LXC nginx* and *Dokumentenserver LAN*.

---

## Dependencies

| Package | required | tested with | needed |
|---|---|---|---|
| Tcl | 8.6 or 9 | 8.6.14, 9.0.4 | yes |
| `mdstack::parser` | 0.2 or newer | 0.9.2 | yes |
| `mdstack::html` | 0.1 or newer | 0.2 | yes |
| `docir` | 0.1 | 0.1.1 | yes (for `docir::html`) |
| `docir::mdSource` | — | 0.2 | yes (for `mdstack::html`) |
| `docir::html` | — | 0.2 | yes (for `mdstack::html`) |
| `docir::diag` | — | 0.1 | yes (for `docir::html`) |
| `docir::diagram` | — | 0.1 | yes (for `docir::html`) |
| `mdstack::theme` | 0.1 | 0.1 | recommended |
| `tclutils::tupdftext` | 0.1 | 0.1 (tclutils 0.68.0) | PDF search only |
| `tclutils::tutask` | 0.2 | 0.2 (tclutils 0.68.0) | PDF worker only |
| `tclutils::tuodf`, `tudocx`, `tuxlsx` | 0.1 | 0.2, 0.1, 0.1 (tclutils 0.69.0) | office files in the search only |
| `tclutils::tucsv` | 0.2 | 0.2 (tclutils 0.69.0) | CSV as a table only |
| `tclutils::tujson` | 0.1 | 0.1 (tclutils 0.69.0) | search as JSON only |
| `tclutils::common` | 0.3 | 0.3 (tclutils 0.69.0) | no; PDF cache through `replaceFile`, else the same by hand |
| `tls` | — | — | HTTPS only |

The [docir modules]{.index} are not optional. `mdstack::html` 0.2 loads
`docir::mdSource` and `docir::html`, and `docir::html` loads
`docir::diag` and `docir::diagram`. If one is missing, the start ends
with `can't find package docir::…` (chapter *Error Messages*).

Without `mdstack::theme` the server runs, but `--theme` has no effect.
The start then prints a warning.

All tclutils modules are optional; if one is missing, only its
function is left out (chapter *Page Layout and Search*). `tupdftext`
(tclutils 0.67.0 or later) reads the text of PDFs for the search,
`tutask` starts a second `tclsh` for it. `tuodf`, `tudocx` and `tuxlsx`
read office files, `tucsv` shows CSV as a table, `tujson` returns the
search as JSON (all three from tclutils 0.69.0). Without tclutils
mdserver searches Markdown only.

HTTPS needs the package `tls`; on Debian:

```bash
apt install tcl-tls
```

Where the modules have to be is shown in the chapter *Starting*.

---

## Summary

- One service, one process, Markdown becomes HTML.
- 0.4 is the package version from `package provide mdserver`.
- mdstack alone is not enough: five docir modules belong to it.
- tclutils is optional and turns on the PDF search.
- Bind to loopback when nginx sits in front.

---

*Next chapter: [Starting](020-starten.md)*
