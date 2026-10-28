# Pitfalls

## Introduction

Operating errors that look like "the server hangs".

---

## No `--bind` in the LAN

The port is open on all interfaces, without authentication. Behind
nginx, `127.0.0.1` belongs there.

---

## `echo stop | nc`

Runs into the timeout. Use `mdctl.tcl`.

---

## SIGTERM Instead of ExecStop

A large PDF is cut off. Control port in the unit.

---

## `?style=sidebar` Changes Nothing

CSS file not found. Check `--stylesdir`, files next to `lib/`
(`styles/sidebar.css`). The same holds for `site`: without
`styles/site.css` the layout stands unstyled, one part below the other.

---

## `?theme=solarized` or `?toc=0` Changes Nothing

The default style is `site`. There only `theme=dunkel` counts; theme
names, `toc`, `--navbg`, `--navfg`, `--navmax` apply to the older
styles. Remedy: `?style=plain&theme=solarized` or `--style plain`.

---

## The Pages Look Different After the Update

The default is `site`; it used to be `plain`. Whoever wants the old
look starts with `--style plain`.

---

## `can't find package docir::mdSource`

mdstack alone is not enough. `mdstack::html` 0.2 needs five docir
modules. From the repository: put `docir/` next to `mdstack/`. In an
installation: `docir-0.1.1.tm` and `docir/` into the `lib/` next to
`mdserver.tcl` (chapter *Starting*).

---

## Modules Flat in `lib/`

`html-0.2.tm` directly in `lib/` instead of in `lib/mdstack/` is not
found. The subfolder is part of the package name.

---

## `X-Forwarded-For` Without Trusted Proxy

Any client could set the logged address itself. That is why mdserver
reads the header only from peers listed in `--trusted-proxy`; without
the option the log shows the peer, so with nginx in front always
`127.0.0.1`.

---

## Root = Git Working Copy, `--dotfiles 1`

`/.git/config` goes out. The default is off — leave it that way.

---

## `server.key` Below `--root`

mdserver serves every file of the root whose name does not start with a
dot. `GET /server.key` hands out the key. Keep keys outside the root.

---

## Clean-URL Link to a File Without `.md`

404 if the file exists only as `.md` and the link has a different stem.
Make target and file name match.

---

## Tcl/Tk Manual in a Subfolder, Links Point Nowhere

Generated with `nroff2md --linkmode server`, the links point to `/dict`
— the root, not the subfolder. Regenerate with `--linkmode file` for a
subfolder.

---

## Search Does Not Find a File

The search reads `.md` and, with tclutils, `.pdf`. Dot folders stay
out (with `--dotfiles 0`), symlinks always — even those that stay
inside the root. Words shorter than two characters are ignored.

---

## Search Finds No PDF

Read the banner line `PDF:`.
`Suche aus: tclutils::tupdftext nicht gefunden` means tclutils is missing from the module path. Under systemd,
`Environment=TCLUTILS_TM=…` belongs in the unit; the shell environment
does not apply there. When the search is on, the worker reads the PDFs
one by one after the start; until then the results page says
`… PDFs werden noch gelesen` (still being read). A scanned PDF without a text
layer never gives a hit.

---

## Manual Pages Are All Called "NAME"

Only in `Alle Dokumente` (`/?nav=index`). Sidebar, cards, title and
search use `CommandName` or the NAME line (chapter *Page Layout and
Search*).

---

*Next chapter: [CLI](810-anhang-cli.md)*
