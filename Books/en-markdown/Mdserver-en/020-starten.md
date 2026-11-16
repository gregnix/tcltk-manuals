# Starting

## Introduction

Working directory: the repository `mdserver/` or any path from which
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

`--bind 127.0.0.1` is the [default]{.index}; it is spelled out here so
the line does the same with an older version. Without `--bind`, mdserver
listens on this machine only. Other machines reach the port only with
`--bind '*'` (all interfaces) or an address. Then it is open without
authentication, and the start banner says so:

```
  HTTP:  0.0.0.0:8080 (alle Schnittstellen)
         http://localhost:8080/
  Achtung: von anderen Rechnern erreichbar (--bind *); ohne Anmeldung davor nur im vertrauten Netz
```

("all interfaces"; "Warning: reachable from other machines; without
authentication in front only in a trusted network".)

Until early November 2026 a missing `--bind` meant all interfaces.
Whoever relied on that now needs `--bind '*'`.

Without `--style`, `site` applies: the full page layout. The earlier
look is `--style plain`.

---

## Locally for Reading

```bash
tclsh mdserver.tcl --root ../meinprojekt/docs --port 8080
```

Then `http://127.0.0.1:8080/`. Start page: `index.md` in the root. If
there is none, `site` shows the folders and documents as cards.

In a home network, without a proxy, for trusted machines:

```bash
tclsh mdserver.tcl --root ../meinprojekt/docs --port 8080 --bind '*'
```

The shell needs the quotes; otherwise it replaces `*` with the file
names of the folder. Whoever needs `--bind '*'` without showing everything
to everybody on the network turns on access control (chapter *Access*).

---

## Finding the Modules

mdserver needs `mdstack::parser` and `mdstack::html` from mdstack
(`mdstack::theme` optionally), and `mdstack::html` needs docir. All
three are repositories of their own. Before `package require`, the
[launcher]{.index} `mdserver.tcl` adds these folders to the
[module path]{.index}, only if they exist (`lib/modulpfad.tcl`):

| Order | Folder | Contents |
|---|---|---|
| 1 | `lib` next to the script | the mdserver modules; in an installation, all modules |
| 2 | `MDSTACK_LIB`, `DOCIR_TM` | the `lib/` of mdstack and the `lib/tm` of docir, when set |
| 3 | `../mdstack/lib`, `../docir/lib/tm` | mdstack and docir as neighbours of the repository |
| 4 | the usual module path | installed packages |

With the three repositories side by side, the server runs without any
setting:

```
arbeit/
  mdserver/
    mdserver.tcl
    lib/mdserver-0.5.tm
  mdstack/
    lib/mdstack/...
  docir/
    lib/tm/docir-0.1.1.tm
    lib/tm/docir/...
```

When they lie elsewhere, two environment variables point there:

```bash
MDSTACK_LIB=/opt/mdstack/lib DOCIR_TM=/opt/docir/lib/tm \
    tclsh mdserver.tcl --root /srv/md
```

If mdstack or docir is missing, the message names every folder searched
(appendix *Error Messages*).

For an installation without the repositories, everything goes into the
`lib/` next to the script. Exactly these files, not a whole mdstack:

```
mdserver/
  mdserver.tcl
  mdctl.tcl
  mdserver-gui.tcl
  mkcert.tcl
  styles/
    site.css
    sidebar.css
    sticky-top.css
    collapsible.css
  lib/
    modulpfad.tcl
    mdserver-0.5.tm
    mdserver/
      search-0.5.tm
      view-0.5.tm
      access-0.5.tm
      conf-0.5.tm
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

The subfolders `mdserver/`, `mdstack/` and `docir/` are part of the
package name: for `docir::html` Tcl looks for the file
`docir/html-0.2.tm`, for `mdserver::view` the file
`mdserver/view-0.5.tm`. Laid out flat side by side, `package require`
does not find them.

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
- Without `--bind`, this machine only; `--bind '*'` opens to the network
  on purpose, and the start banner warns.
- mdstack and docir: neighbouring folders, `MDSTACK_LIB`/`DOCIR_TM`, or
  all modules in `lib/` next to the script, with the subfolders
  `mdserver/`, `mdstack/` and `docir/`.
- PDF search: tclutils in `lib/` or through `TCLUTILS_TM`.

---

*Next chapter: [Options](030-optionen.md)*
