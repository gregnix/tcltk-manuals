# Pitfalls

## Introduction

Operating errors that look like "the server hangs".

---

## Not Reachable in the LAN After the Update

Since November 2026 mdserver listens on `127.0.0.1` only without
`--bind`. Whoever started it without `--bind` for the whole network so
far now needs `--bind '*'` (with quotes) or the address of the
interface. Behind nginx it stays `127.0.0.1`.

---

## `--bind '*'` Without Authentication

The port is open on all interfaces, without authentication. The start
banner warns ("Achtung: von anderen Rechnern erreichbar", reachable from
other machines). Only in a trusted network, otherwise a proxy with
authentication in front or mdserver's own access control (`--access`,
chapter *Access*).

---

## With Access Control Nobody Sees Anything

`zugriff.txt` has no line for `/`. What has no matching line is open to
nobody, the start page included. The log says so at start (`keine Zeile
fuer "/"`, no line for "/"). Almost always `/;mitarbeiter` or `/;gast`
belongs in the file; the GUI offers "Regel / anlegen…" (create rule
for /).

---

## Nobody Can Log In

Login works over HTTPS only. Without `--cert` and `--key` there is no
HTTPS, and every login over HTTP gets 403. The start banner warns
("Anmeldung nur ueber HTTPS, und HTTPS ist nicht aktiv", login over
HTTPS only, and HTTPS is not active). Without `--users` there is nobody
who could log in; then only `gast` applies.

---

## After Five Attempts the Right Password Fails Too

Five wrong passwords lock the address for 10 minutes (429). That holds
for the right one as well. Wait; restarting the server lifts the lock.
The lock applies to the peer of the connection, not to
`X-Forwarded-For`: behind a proxy that is the proxy for everyone, and
one person locks everyone out.

---

## `zugriff.txt` in the Root

The server does not start: `--access … liegt in der Dokumentenwurzel
und wuerde ausgeliefert` (lies in the document root and would be
served). The same for `benutzer.txt`. Put both next to the settings
file, outside `--root`. A settings file without `root` has the root
`.`, its own folder — then the files next to it do lie "in the root".

---

## A Change in `mdserver.conf` Has No Effect

`reload` reads only `zugriff.txt` and `benutzer.txt`. All other
settings, a new control port included, take effect after a restart. A
`mdctl.tcl reload` to a port the running server does not know yet ends
with `connection refused`.

---

## Older State: User Names with "s"

Up to the state of 16 November 2026, mdserver checked user names with
the glob pattern `*[:;\s]*`. There `\s` does not mean white space but
"`\` or `s`": `hans`, `klaus` and every other name with an `s` counted
as invalid. The server did not start with such a name in
`benutzer.txt`; `mdctl.tcl passwd` and the GUI refused it. Fixed (tests
`access-10`, `gui-18`).

---

## 503 Behind the Proxy With Many Users

`--maxperaddr` (32) counts per client address. Behind a proxy that is
always the same one. The proxy's address belongs in `--trusted-proxy`;
then only `--maxconn` counts.

---

## Search Finds Too Little After the Start

The search index is built in the background after the start, a while
for large collections. Until then the result page says how many files
are still missing. Search again later.

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
modules. From the repositories: put `docir/` next to `mdserver/` or set
`DOCIR_TM`. In an installation: `docir-0.1.1.tm` and `docir/` into the
`lib/` next to `mdserver.tcl` (chapter *Starting*).

---

## After the Move: mdstack Not Found

Up to 0.4, mdserver lay in `mdstack/tools/mdserver/` and found mdstack
through `../../lib`. Since 0.5 it is a repository of its own and looks
for mdstack as a neighbour (`../mdstack/lib`) or in `MDSTACK_LIB`.
Whoever only copied the old folder `tools/mdserver/` somewhere gets
`mdstack nicht gefunden` (mdstack not found) with the list of folders
searched. Under systemd, `MDSTACK_LIB` and `DOCIR_TM` go into the unit
as `Environment=` when the repositories do not lie side by side.

---

## `lib/mdserver/` Missing

Whoever copied only `mdserver-0.5.tm` after the update gets
`mdserver::search 0.5 not found` or the same message for `view` or
`access` at the start. The folder `lib/mdserver/` with `search-0.5.tm`,
`view-0.5.tm`, `access-0.5.tm` and `conf-0.5.tm` belongs to it.

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

The search reads `.md` and, with tclutils, `.pdf`, office files and
`.csv` (banner lines `PDF:`, `Office:`, `CSV:`). Dot folders stay
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

## `or` Finds Nothing Any More

`a or b` searches three words, `or` among them. Only `OR`, `ODER` and
`|` join two words into "either of the two".

---

## A CSV or Office File Cannot Be Downloaded

A link to a `.csv` or an office file opens the table or text page, in
every style. The file itself comes from `?raw=1` (link at the top of the
page), for all files `--csv-view 0` or `--office-view 0`.

---

## A Date From an XLSX Is a Number

Excel stores a date as its serial number. The search finds "46325",
not "30.10.2026".

---

## Manual Pages Are All Called "NAME"

Only in `Alle Dokumente` (`/?nav=index`). Sidebar, cards, title and
search use `CommandName` or the NAME line (chapter *Page Layout and
Search*).

---

## Older State: Commands via the URL

Up to the state of 30.10.2026 the URL path went through `subst`. A
request for `/[exec id]` ran `id` as the server user, also behind a
proxy. Update every older installation; the new state only decodes
`%XX` (test `url-1`), a broken `%` in the path is 400.

---

## File Names With Umlauts: 404

Under systemd `LANG` is not set, and Tcl then reads file names as
iso8859-1. The start banner warns with `Achtung: Systemkodierung`. Set
`Environment=LANG=C.UTF-8` in the unit (it is in
`mdserver.service.beispiel`).

---

*Next chapter: [CLI](810-anhang-cli.md)*
