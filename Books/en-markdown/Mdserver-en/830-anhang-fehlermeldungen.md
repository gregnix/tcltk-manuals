# Error Messages

## Introduction

Messages at the start and while running. `ERROR` and `WARNING` go to
stderr, the messages of the PDF worker into the log. Some messages of
mdserver are German; their meaning is given below.

---

## Start

```
ERROR: Cannot bind to HTTP port 8080: couldn't open socket: address already in use
ERROR: Cannot bind to HTTP port 8080 on 127.0.0.1: couldn't open socket: address already in use
```

Port in use; with `--bind` the address is included. Send `stop` through
the control port of the old instance, otherwise find the process. Do
not blindly use `fuser -k` if another service has 8080.

```
WARNING: tls not available -- HTTPS disabled: can't find package tls
```

No abort. `--cert` and `--key` are set, `tcl-tls` is missing. HTTP keeps
running, HTTPS does not.

```
ERROR: Certificate not found: server.crt
ERROR: Key not found: server.key
```

Wrong path for `--cert` or `--key`. Relative paths count from the
working directory.

```
ERROR: mdstack nicht gefunden: can't find package mdstack::parser 0.2
       Gesucht in:
         /opt/mdserver/lib
         /opt/mdstack/lib  (fehlt)
         /opt/docir/lib/tm  (fehlt)
         und auf dem Modulpfad
       mdstack neben mdserver legen (../mdstack/lib) oder MDSTACK_LIB setzen;
       docir ebenso (../docir/lib/tm oder DOCIR_TM).
```

"mdstack not found … searched in … (missing) … and on the module path;
put mdstack next to mdserver or set MDSTACK_LIB; docir likewise."
mdstack or docir is missing. The list names the folders the launcher
searched, in its order; `(fehlt)` means the folder does not exist.
Instead of `mdstack::parser` the message may name `docir::mdSource`,
`docir::html`, `docir::diag` or `docir::diagram`: then mdstack is
there, docir is not. The message names the required minimum version
0.2; any newer 0.x fits.

```
ERROR: mdserver 0.5 nicht gefunden: can't find package mdserver 0.5
       mdserver-0.5.tm muss in lib/ liegen.
```

"Not found … must be in lib/": the launcher does not find its own
module. Check `lib/mdserver-0.5.tm` next to `mdserver.tcl`.

```
ERROR: mdserver::search 0.5 not found (can't find package mdserver::search 0.5).
       lib/mdserver/search-0.5.tm muss neben lib/mdserver-0.5.tm liegen.
```

("… must lie next to …".) Search, view and access control are modules
of their own. Put the folder `lib/mdserver/` next to `mdserver-0.5.tm`.
The same message exists for `mdserver::view` and `mdserver::access`.

---

## Settings File

```
ERROR: mdserver.conf Zeile 4: unbekannte Option "portx"
ERROR: mdserver.conf Zeile 2: port: keine Zahl: abc
ERROR: mdserver.conf Zeile 7: style: einer von site, plain, sidebar, sticky, collapsible, nicht kacheln
ERROR: mdserver.conf Zeile 9: port steht schon in Zeile 2
ERROR: mdserver.conf Zeile 5: no-log ist ein Schalter (ohne Wert, oder 0/1)
```

"Line 4: unknown option", "not a number", "one of … not …", "already in
line 2", "is a switch (without value, or 0/1)". The server does not
start. File and line come first. Write options without `--`; a switch
has no value.

---

## Access

```
ERROR: --access /srv/md/zugriff.txt liegt in der Dokumentenwurzel und wuerde ausgeliefert -- ausserhalb ablegen
ERROR: --users /etc/mdserver/benutzer.txt ist nicht lesbar
```

"Lies in the document root and would be served — put it outside";
"is not readable". The server does not start. `zugriff.txt` and
`benutzer.txt` belong outside `--root` and must be readable for the
service.

```
ERROR: zugriff.txt Zeile 3: erwartet pfad;gruppen: /fibu/
ERROR: zugriff.txt Zeile 4: der Pfad beginnt mit /: fibu/;fibu
ERROR: benutzer.txt Zeile 2: erwartet name;gruppen;hash
ERROR: benutzer.txt Zeile 3: kein Hash (mdctl.tcl passwd)
ERROR: benutzer.txt Zeile 4: anna steht zweimal
```

"Expected path;groups", "the path starts with /", "expected
name;groups;hash", "no hash", "anna appears twice". At start, the server
does not start. On `reload` the same line appears in the log
(`Zugriff: neu laden fehlgeschlagen, es gilt der alte Stand: …`, reload
failed, the old state holds), and the old state stays.

In the log at start, no abort:

```
Zugriff: Gruppe "fibu" (zugriff.txt Zeile 3) hat niemand
Zugriff: keine Zeile fuer "/" -- was keine Zeile hat, ist fuer niemanden offen
```

"Group fibu … nobody has": usually a typo. A second `;` instead of a
space (`/lohn/;lohn;management`) turns both names into one group
`lohn;management`, which nobody has either. "No line for /": without a
base rule nobody sees anything (appendix *Pitfalls*).

In the start banner, no abort:

```
  Achtung: Anmeldung nur ueber HTTPS, und HTTPS ist nicht aktiv (--cert/--key)
  Achtung: --auth-http 1 -- Passwoerter auch unverschluesselt ueber HTTP
```

"Login over HTTPS only, and HTTPS is not active"; "passwords also
unencrypted over HTTP".

```
WARNING: mdstack::theme 0.1 not found -- themes disabled: …
```

No abort. `--theme` then has no effect.

```
WARNING: control port 8099 not bound: …
```

No abort, but `mdctl.tcl` does not reach the service. Port in use.

```
WARNING: --pdf-search: tclutils::tupdftext not found (TCLUTILS_TM or module path) -- PDFs are not searched: can't find package tclutils::tupdftext 0.1
```

No abort. Only with `--pdf-search 1`; with `auto` it appears only in
the banner (`PDF:   Suche aus: …`). Put tclutils into `lib/` or set
`TCLUTILS_TM` (chapter *Starting*).

```
WARNING: --office-search: not found: tclutils::tudocx, tclutils::tuxlsx
WARNING: --csv-view: tclutils::tucsv 0.2 not found -- CSV files are sent as they are: …
```

No abort. Only with `--office-search 1` or `--csv-view 1`; with `auto`
the formats appear only in the banner (`Office:`, `CSV:`). The first line
means: ODF is searched, Word and Excel are not, because tclutils is older
than 0.69.0.

---

## PDF Worker

These lines are in the log (stdout, preceded by the time), not on
stderr. With `--no-log` they are missing.

```
pdf worker: starpack -- reading in the server
pdf worker: lib/pdftext-worker.tcl missing -- reading in the server
pdf worker: tclutils::tutask not found -- reading in the server
```

No worker; mdserver reads the PDFs in its own process, as with
`--pdf-worker 0`. Appears at the start when the PDF search is on.

```
pdf worker: /srv/md/a.pdf has no text, reader failed: …
```

`tupdftext` could not read the file (damaged, not a PDF). It is cached
as empty until it changes.

```
pdf worker failed on /srv/md/a.pdf (…) -- the next search tries again
pdf worker failed again on /srv/md/a.pdf (…) -- skipped until it changes
```

The worker crashed, ended with an error code or took longer than 10
minutes. The second time the PDF stays out until it changes.

---

## mdctl

```
mdctl: 127.0.0.1:8099 nicht erreichbar: couldn't open socket: connection refused
```

"Not reachable": no mdserver with `--control 8099` is running, or it
runs on another port. After a new `control` in the settings file: the
running server knows the port only after a restart.

```
mdctl: keine Antwort von 127.0.0.1:8099
```

"No answer": the connection was made, but no answer came within
`--timeout` (default 10 s). Exit code 1.

```
mdctl: anna ist neu -- Gruppen angeben, z. B. "office fibu"
mdctl: mindestens 8 Zeichen
mdctl: die beiden Eingaben sind verschieden
mdctl: Name ohne : ; und Leerzeichen
mdctl: Gruppen durch Leerzeichen trennen, nicht durch ;
```

Messages of `mdctl.tcl passwd` ("anna is new — give groups", "at least
8 characters", "the two entries differ", "name without : ; and spaces",
"separate groups by spaces, not by ;"); the file stays unchanged.

---

## HTTP Status

| Status | Meaning |
|---|---|
| 301 | directory without trailing slash |
| 303 | after logging in through `/__mdserver/login`, back to the page |
| 304 | unchanged |
| 400 | in the path a `%` without two hex digits, `%00` or NUL |
| 401 | with access control: login needed (path not open to `gast`, even if it does not exist) |
| 403 | path outside the root (also a symlink leading out), dot file with `--dotfiles 0`; with access control: login over HTTP |
| 404 | not found; with access control also: logged in, but without the right |
| 405 | method not GET/HEAD |
| 414 | request line longer than `--maxline` |
| 416 | range not satisfiable (start beyond the end of the file); an unreadable Range header gives 200 |
| 429 | with access control: five wrong passwords from this address within 10 minutes |
| 431 | one header line longer than `--maxline`, or all headers longer than `--maxheader` |
| 501 | `?format=json` without `tclutils::tujson`: `format=json needs tclutils::tujson` |
| 503 | health: root not readable; too many open connections (`--maxconn`, `--maxperaddr`), with `Retry-After: 1` |

---

## Certificate

```
GUELTIG, ABER OHNE subjectAltName
```

"Valid, but without subjectAltName": browsers reject it. Regenerate it
with a SAN. `--check` ends with exit code 1.
