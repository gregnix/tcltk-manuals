# Understanding tclutils

## Introduction

[tclutils]{.index} is a collection of small pure-Tcl modules without Tk:
text filters, data formats, providers, HTTPS policy, settings,
background tasks (`tutask`) and a test runner. The core needs only
Tcl itself (`zlib` for ZIP is part of Tcl). The modules require
`package require Tcl 8.6-` and thus run under Tcl **8.6** and
**9.x**.

This manual describes tclutils **0.68.0**. It is meant for
server, CLI and CI programs without Tk and for applications that use the
engines beneath tkutils and ctrlutils.

---

## Dependencies

Some optional modules need more, and only when called:

| Module | needs |
|---|---|
| `tufetch` | `tls` or a `curl`/`wget` binary |
| `tuhttps`, `tudav`, `tupostgrest` | `tls` for HTTPS |
| `tuprovider::ftp` | tcllib package `ftp` (only on `open ftp …`) |
| `tuprovider::sftp` | OpenSSH `sftp`, its own `package require` |
| `tusqlite` / `tutdbc` | an sqlite3 or TDBC handle opened by the caller |
| `tutask` (`pool` only) | package `Thread` (only on the first `pool`) |

`package require tclutils` loads even without tls and Thread.
`tuprovider::ftp` requires tcllib `ftp` only on `open ftp …`, not when
the umbrella is loaded.

---

## Role

| Part | Role |
|---|---|
| Prefix | `tu*` / namespace `tclutils::…` |
| Layer | Model — logic without GUI |
| Siblings | tkutils (View), ctrlutils (Controller) |
| Loading | `package require tclutils` or a single module |

```
tclutils = Model · tkutils = View · ctrlutils = Controller
```

The GUI layer and the controllers are described in the books *tkutils* and
*Utils-Stack*. This book covers engines, paths, providers,
settings, tasks and tests.

---

## Scope

- Not a copy of all `docs/*.md`; the detailed API is there, in the
  tclutils tree.
- Not a replacement for *Packages and Modules* (`.tm` mechanics in general).
- Not a file manager: file view and explorer are described in *Utils-Stack*.

---

## Structure

Chapters 2 and 3 cover installation and modules. They are followed by text
and files, characters and paths, data formats, TDBC and MaxMind,
encoding and hashing,
notes and calendars, PDF text, ODF and PDF structure, diagrams,
providers, network and HTTPS,
settings, `tutask`, the tests and the limits. The
appendices contain pitfalls (A), the module list (B), the glossary (C),
error messages (D), the API catalog (E) and practice examples (F).

---

## In short

- Pure Tcl, no Tk, version 0.68.0.
- Core without third-party packages; tls, tcllib `ftp`, curl/wget, Thread only for
  optional modules or the `tutask` pool.
- Pairing according to the CHANGELOG of tkutils 0.48.0: tclutils 0.68.0
  + tkutils 0.48.0 + ctrlutils 0.4. tkutils 0.48.0 needs at least
  tclutils 0.64.0.

---

*Next chapter: [Installation](020-installation.md)*
