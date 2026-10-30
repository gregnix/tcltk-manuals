# Starting

## Introduction

Working directory: `mdstack/tools/mdserver/` or any path from which
`mdserver.tcl` can be found. The [document root]{.index} is `--root`,
not the script directory.

---

## Canonical Start (LAN Behind a Proxy)

```bash
tclsh mdserver.tcl \
    --root /srv/md \
    --port 8080 \
    --bind 127.0.0.1 \
    --trusted-proxy 127.0.0.1 \
    --control 8099 \
    --title Dokumente
```

Without `--bind` the process listens on **all** interfaces. The port is
then reachable without authentication. The start banner says so:
`0.0.0.0:8080 (alle Schnittstellen)` ("all interfaces").

Without `--style`, `site` applies: the full page layout. The earlier
look is `--style plain`.

---

## Locally for Reading

```bash
tclsh mdserver.tcl --root ../../docs --port 8080
```

Then `http://127.0.0.1:8080/`. Start page: `index.md` in the root. If
there is none, `site` shows the folders and documents as cards.

---

## Finding the Modules

Before `package require mdserver 0.4`, the [launcher]{.index}
`mdserver.tcl` adds these folders to the module path, relative to the
script and only if they exist:

| Path | Contents |
|---|---|
| `lib` | `mdserver-0.4.tm` and `pdftext-worker.tcl`; in an installation, all modules |
| `../lib` | alternative for a location of your own |
| `../../lib` | the `lib/` of mdstack (`mdstack::parser`, `::html`, `::theme`) |
| `../../../docir/lib/tm` | a docir repository next to mdstack |

Run from the repository, the server therefore needs no `TCLLIBPATH`
when `docir/` lies next to `mdstack/`:

```
arbeit/
  mdstack/
    lib/mdstack/...
    tools/mdserver/mdserver.tcl
  docir/
    lib/tm/docir-0.1.1.tm
    lib/tm/docir/...
```

For an installation outside the repository, everything goes into the
`lib/` next to the script. Exactly these files, not a whole mdstack:

```
mdserver/
  mdserver.tcl
  mdctl.tcl
  mkcert.tcl
  styles/
    site.css
    sidebar.css
    sticky-top.css
    collapsible.css
  lib/
    mdserver-0.4.tm
    pdftext-worker.tcl
    mdstack/
      parser-0.9.2.tm
      html-0.2.tm
      theme-0.1.tm
    docir-0.1.1.tm
    docir/
      mdSource-0.2.tm
      html-0.2.tm
      diag-0.1.tm
      diagram-0.1.tm
```

The subfolders `mdstack/` and `docir/` are part of the package name:
for `docir::html` Tcl looks for the file `docir/html-0.2.tm`. Laid out
flat side by side, `package require` does not find them.

The PDF search needs tclutils as well. The launcher does not look for
it: either `tclutils/common-0.3.tm`, `tclutils/tupdftext-0.1.tm` and
`tclutils/tutask-0.2.tm` also go into `lib/` (`tupdftext` and `tutask`
load `common`), for office files, CSV and JSON also `tuzip`, `tuodf`,
`tudocx`, `tuxlsx`, `tucsv` and `tujson`, or the environment variable
`TCLUTILS_TM` points to the
module directory of a tclutils installation (the directory that holds
the folder `tclutils/`):

```bash
TCLUTILS_TM=/opt/tclutils/lib/tm tclsh mdserver.tcl --root /srv/md
```

---

## Health

Default path `/__mdserver/health`. For a probe behind nginx or in a
unit. Answer `200 ok`, or `503 root unreadable` when `--root` is no
longer a readable directory.

---

## Summary

- `--root` is the document tree.
- Behind a proxy: loopback, trusted proxy, control port.
- Leaving `--bind` empty is a deliberate opening, not a default for the
  LAN.
- Installation: all modules in `lib/` next to the script, with the
  subfolders `mdstack/` and `docir/`.
- PDF search: tclutils in `lib/` or through `TCLUTILS_TM`.

---

*Next chapter: [Options](030-optionen.md)*
