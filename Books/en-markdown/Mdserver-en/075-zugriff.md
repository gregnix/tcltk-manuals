# Access

## Introduction

Without `--access` everything is open. With `--access` and `--users`,
people log in with name and password, and everyone sees only the
folders of their [groups]{.index}. Two files control this:

| File | Option | Content |
|---|---|---|
| `zugriff.txt` | `--access` | per path, the groups that see it |
| `benutzer.txt` | `--users` | per user, the groups and the password hash |

Both lie **outside** `--root`. If one of them is inside, the server does
not start; it would otherwise serve it.

```bash
tclsh mdserver.tcl --root /srv/md --bind '*' \
    --cert /etc/mdserver/server.crt --key /etc/mdserver/server.key \
    --access /etc/mdserver/zugriff.txt --users /etc/mdserver/benutzer.txt \
    --control 8099
```

Login works over HTTPS only (chapter *TLS*). A settings file is easier
than the long command line (chapter *Settings File and GUI*).

---

## zugriff.txt

One line per path: `path;groups`, groups separated by spaces. `#` at the
start of a line is a comment.

```
# pfad;gruppen
/;mitarbeiter
/oeffentlich/;gast
/fibu/;fibu management
/lohn/;lohn management
/technik/;technik
/__mdserver/;technik
```

The **longest** matching line wins. A path matches itself and
everything below it: `/lohn/` applies to `/lohn/januar.md` and
`/lohn/2026/februar.md`. A line can also name a single file
(`/fibu/kontenplan.md;office fibu`). Several groups in one line mean
"one of them is enough".

**A path without a matching line is open to nobody.** That is why a
[base rule]{.index} for `/` almost always belongs in the file. Without
it nobody sees anything, not even the start page; the log warns at
start.

Two groups everyone has without being given them:

- [gast]{.index} (guest) — everybody, even without logging in. A folder
  with `gast` is public.
- [mitarbeiter]{.index} (staff) — everybody who is logged in. It is
  never entered for anyone.

All other groups are given to users in `benutzer.txt`. A group that
appears in `zugriff.txt` but with no user is reported in the log at
start — usually a typo. A group such as `management` sees only where it
is listed; if it is to see everything, it belongs in every line.

`/__mdserver/` concerns the status over HTTP (`--statuspath`). Without a
line of its own, the line for `/` applies. The health endpoint always
stays open.

---

## benutzer.txt

```
# name;gruppen;hash
anna;office fibu;pbkdf2-sha256$5000$...
bernd;lohn;pbkdf2-sha256$5000$...
chef;management;pbkdf2-sha256$5000$...
```

A plain-text password is never in the file. The hash is written by
[mdctl.tcl passwd]{.index}:

```bash
tclsh mdctl.tcl passwd --users /etc/mdserver/benutzer.txt anna "office fibu"
tclsh mdctl.tcl passwd --users /etc/mdserver/benutzer.txt anna
```

The first line creates `anna`, the second sets a new password; the
groups stay when none are given. `mdctl.tcl` asks for the password
twice, at least 8 characters, without echo on Linux. Groups can also be
changed in an editor; deleting a user means deleting the line. Names are
lower-cased and must not contain `:`, `;` or white space.

After a change, the running server rereads both files:

```bash
tclsh mdctl.tcl --port 8099 reload
```

If a file is wrong, the old state stays, and the log names file and
line. At start, the same error stops the server.

---

## What "not seeing" means

What someone may not read does not exist for them:

- It is missing from header bar, sidebar, folder cards, *Alle
  Dokumente* (all documents), the chapter bars of books and the title
  suggestions of the search field.
- The search does not find it, not even in counts, "Meinten Sie" (did
  you mean) and examples; the JSON of the search does not name it.
- A direct request gives **404**, as for something that does not exist.
  The status code does not reveal whether the path exists.
- A symlink counts at both ends: `/oeffentlich/x.md` pointing to
  `/lohn/y.md` is seen only by someone allowed both folders.

Search (`/?q=`) and *Alle Dokumente* (`/?nav=index`) work without a
right on `/`; they show only what the reader may see. A guest finds the
public pages that way.

---

## Logging in

- Without login, a path not open to `gast` gives **401**; the browser
  asks for name and password. This holds for paths that do not exist,
  too.
- The header bar shows "Anmelden" (log in, `/__mdserver/login`) or the
  name of whoever is logged in.
- [HTTP Basic]{.index} has no logout: close the browser.
- **HTTPS only.** Over HTTP the password would cross the network
  readable. mdserver refuses every login there with **403** and names
  the HTTPS port; pages for `gast` keep working over HTTP.
  `--auth-http 1` lifts this, for a test on `127.0.0.1` only.
- **Five wrong passwords** from one address lock it for 10 minutes
  (**429**), for correct passwords too.

Without `--cert` and `--key`, therefore, nobody can log in. The start
banner says so:

```
  Zugriff: zugriff.txt (6 Regeln), 3 Benutzer
  Achtung: Anmeldung nur ueber HTTPS, und HTTPS ist nicht aktiv (--cert/--key)
```

With `--bind '*'` and without access control, the start banner warns
about an open port (chapter *Starting*). With `--access` it says instead
("reachable from other machines, with login"):

```
  Netz:  von anderen Rechnern erreichbar (--bind *), mit Anmeldung (--access)
```

---

## What the server computes

The password is checked with [PBKDF2]{.index}-HMAC-SHA256, 5000 rounds,
in pure Tcl. That takes about one second. Meanwhile the server keeps
serving the other requests; only the one logging in waits. Afterwards
the server remembers the checked login for 30 minutes after the last
request, as SHA-256, not the password. The number of rounds is part of
the hash (`pbkdf2-sha256$5000$…`) and holds per user.

With access control, every response carries `Cache-Control: private`
and `Vary: Authorization`, so that no cache hands a page to the wrong
person. The log shows the name before the address:

```
[09:12:04] anna@192.168.17.42 GET /fibu/buchung.md 200 16800 markdown
```

---

## Summary

- `zugriff.txt`: `path;groups`, the longest line wins; without a line
  for `/` nobody sees anything.
- `gast` = everybody, `mitarbeiter` = logged in; the other groups are in
  `benutzer.txt`.
- Hashes with `mdctl.tcl passwd`, reread with `mdctl.tcl reload`.
- What someone may not see is missing everywhere and gives 404.
- Login over HTTPS only; five failures lock for 10 minutes.
- Both files outside the root.

---

*Next chapter: [Behind the Proxy](080-hinter-proxy.md)*
