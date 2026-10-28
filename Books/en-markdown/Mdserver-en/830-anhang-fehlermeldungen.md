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
ERROR: mdserver 0.4 nicht gefunden: can't find package mdserver 0.4
       mdserver-0.4.tm muss in lib/ liegen.
```

"Not found … must be in lib/": the launcher does not find its own
module. Check `lib/mdserver-0.4.tm` next to `mdserver.tcl`.

```
ERROR: mdparser 0.2 not found: can't find package mdstack::parser 0.2
```

The mdstack `lib/` is missing. The launcher looks for it under
`../../lib` by itself; in an installation `mdstack/parser-0.9.2.tm`
belongs in the `lib/` next to the script. The message names the
required minimum version 0.2; any newer 0.x fits.

```
ERROR: mdhtml 0.1 not found: can't find package docir::mdSource
```

`mdstack::html` is there, docir is not. The launcher looks for a docir
next to mdstack (`../../../docir/lib/tm`). Otherwise put
`docir-0.1.1.tm` and `docir/` into the `lib/`. Instead of
`docir::mdSource` the message may also name `docir::html`,
`docir::diag` or `docir::diagram`.

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
runs on another port.

```
mdctl: keine Antwort von 127.0.0.1:8099
```

"No answer": the connection was made, but no answer came within
`--timeout` (default 10 s). Exit code 1.

---

## HTTP Status

| Status | Meaning |
|---|---|
| 301 | directory without trailing slash |
| 304 | unchanged |
| 403 | path outside the root (also a symlink leading out), dot file with `--dotfiles 0` |
| 404 | not found |
| 405 | method not GET/HEAD |
| 414 | request line longer than `--maxline` |
| 416 | range not satisfiable (start beyond the end of the file); an unreadable Range header gives 200 |
| 431 | one header line longer than `--maxline`, or all headers longer than `--maxheader` |
| 503 | health: root not readable |

---

## Certificate

```
GUELTIG, ABER OHNE subjectAltName
```

"Valid, but without subjectAltName": browsers reject it. Regenerate it
with a SAN. `--check` ends with exit code 1.
