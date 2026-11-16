# What mdserver Is

## Introduction

[mdserver]{.index} **0.5** is an HTTP service in pure Tcl (no Tk). It
serves Markdown files as HTML, rendered at request time. One coroutine
per connection, non-blocking I/O: a slow client does not block the
others. Everything runs in one thread; an expensive request holds up the
others until it is done (chapter *HTTP Behaviour*, section *Response
Times*).

mdserver is a repository of its own, `mdserver`; up to 0.4 it lived
under `mdstack/tools/mdserver/`. Start script: `mdserver.tcl`. Modules:
`lib/mdserver-0.5.tm`, and in `lib/mdserver/` the search
(`search-0.5.tm`), the office and CSV view (`view-0.5.tm`), access
control (`access-0.5.tm`) and the settings file (`conf-0.5.tm`).

This manual covers starting and options, navigation and themes, page
layout and search, HTTP behaviour, the control port, TLS, access and
login, running behind a proxy, the settings file with its GUI and
building a site. The appendices collect pitfalls, command lines, a
glossary and error messages. Changes from version to version are in the
package documentation in the mdserver repository (`doc/`); this book
describes the current state.

The pages mdserver generates are in German. This book quotes their
labels as they appear (`Start`, `Alle Dokumente`, `Auf dieser Seite`)
and gives the meaning on first use.

---

## What It Does

- HTTP always, HTTPS optional (`tls`)
- Page layout `site` as the default: header bar, sidebar, breadcrumbs,
  `Auf dieser Seite` (on this page), folders as cards, dark mode
- Full-text search over all `.md` files of the root: `/?q=words`; with
  tclutils also over PDFs (one hit per page), office and CSV files; with
  search tips and help when nothing is found
- Office and CSV files as a page instead of a download (with tclutils)
- Older styles `plain`, `sidebar`, `sticky`, `collapsible` with theme
  and TOC by option and by URL
- Navigation: start page, site index, sections from the top-level folders
- Range (206), conditional GET (304), control port
- Static files (PDF, images, CSS)
- Directory page when there is no `index.md`
- Book folders with `book.tcl`: chapter navigation, generated landing page
- Access control if wanted: login over HTTPS, rights per folder and group
- Settings file (`--config`) and a GUI for settings, users and rules

Dual: Tcl **8.6** and **9.0**.

## What It Does Not Do

No parser of its own — it renders through mdstack and docir. No reverse
proxy, no firewall, no login against foreign accounts (Microsoft 365,
for example); its own login is HTTP Basic over HTTPS (chapter *Access*).
Without `--bind`, mdserver listens on `127.0.0.1` only; that fits behind
a proxy that does the authentication. The LAN installation is covered in the books *Proxmox
LXC nginx* and *Dokumentenserver LAN*.

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
| `tclutils::tuodf`, `tudocx`, `tuxlsx` | 0.1 | 0.2, 0.1, 0.1 (tclutils 0.69.0) | office files in search and view only |
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

mdstack and docir are repositories of their own. How mdserver finds
them (neighbouring folders, `MDSTACK_LIB`, `DOCIR_TM`) and where the
modules have to be in an installation is shown in the chapter
*Starting*.

---

## Summary

- One service, one process, Markdown becomes HTML.
- 0.5 is the package version from `package provide mdserver`; since 0.5
  a repository of its own.
- mdstack alone is not enough: five docir modules belong to it.
- tclutils is optional and turns on PDF, office and CSV files in search
  and view.
- Search, office/CSV view, access control and settings file are modules
  of their own next to the server module.
- Bind to loopback when nginx sits in front.

---

*Next chapter: [Starting](020-starten.md)*
