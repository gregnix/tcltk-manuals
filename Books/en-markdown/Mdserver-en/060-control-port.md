# Control Port

## Introduction

`--control PORT` opens a control channel **on localhost only**. Through
it the process ends cleanly — without `fuser -k`, without searching for
the PID. It also tells how the service is doing (`status`) and clears
the caches (`reload`).

---

## Usage

```bash
tclsh mdserver.tcl --root /srv/md --control 8099
tclsh mdctl.tcl --port 8099 ping     # -> pong
tclsh mdctl.tcl --port 8099 status   # several lines
tclsh mdctl.tcl --port 8099 reload   # -> reloading
tclsh mdctl.tcl --port 8099 stop     # -> stopping
```

`mdctl.tcl` lies next to `mdserver.tcl`.

| Option | Default | Meaning |
|---|---|---|
| `--port` | — | control port (`--control` of the server), required |
| `--host` | `127.0.0.1` | address of the control port |
| `--timeout` | `10000` | milliseconds `mdctl.tcl` waits for the answer |

Exit code 0 when an answer came, 1 otherwise (messages in the appendix
*Error Messages*). systemd needs the 0.

**No** `echo stop | nc`. OpenBSD netcat on Debian does not close the
sending direction after EOF; without `-N` the connection runs into the
timeout. Other `nc` variants do not know `-N`. Tcl is there wherever
mdserver runs — hence `mdctl.tcl`.

---

## Status

`status` tells what the service has done since the start:

```
mdserver: 0.4, Tcl 8.6.14
started: … 10:37:35 (up 2 h 14 min)
root: /srv/md
http: 127.0.0.1:8080
connections: 2 open, peak 17, limits 200 / 32 per address, rejected 0
requests: 4211 (2xx 4102, 3xx 31, 4xx 78, 5xx 0)
search index: 3002 files, checked 12 s ago
pdf queue: 0
view cache: 3 pages, 0.9 of 32 MB, 40 hits, 3 built
slowest:
    4728 ms  11-05 10:37 GET /tabellen/gross.xlsx 200 view xlsx
     612 ms  11-05 11:02 GET / 200 search
```

| Line | Content |
|---|---|
| `started` | start time and uptime |
| `http`, `https` | address bound to |
| `connections` | open, peak at once, limits, rejected with 503 |
| `requests` | requests per status class |
| `search index` | files in the index; while it is built `building (1234 of 30002 files read)` |
| `pdf queue` | PDFs the worker is still reading |
| `view cache` | office and CSV pages in the page cache, hits and pages built |
| `slowest` | the five slowest requests: duration, time, path without query, status, note of the log line |

`view cache` is the [page cache]{.index} for office and CSV pages
(`--viewcache`). The counters live in memory; after a restart they start at zero.
`slowest` shows where the one thread gets stuck: here a large table on
its first request.

The same is available over HTTP when switched on:

```bash
tclsh mdserver.tcl --root /srv/md --statuspath /__mdserver/status
```

The default is off. The page names paths and counters; it belongs behind
authentication.

---

## Reload

`reload` forgets the office and CSV pages of the page cache and the
titles of the lists, and reads the search index again in the
background. Until the new one is there, the old one answers.

It is rarely needed. Search and page cache recognise a changed file by
modification time and size. `reload` is for the case where both stay
the same, such as a folder restored with old timestamps.

---

## What stop Does

1. Listening sockets closed: no new connection.
2. Running responses: **5 s** of time.
3. After that they are cut, log line
   `shutdown: 1 Verbindung(en) abgeschnitten` (connections cut).

If all responses finish in time, the log says `shutdown: fertig`
(done).

Without this sequence a restart cuts a large PDF in the middle of a
byte.

---

## systemd (Key Values, Not the Installation)

```ini
ExecStart=... mdserver.tcl --root /srv/md --port 8080 --bind 127.0.0.1 \
    --trusted-proxy 127.0.0.1 --control 8099
ExecStop=... mdctl.tcl --port 8099 stop
TimeoutStopSec=15
```

`TimeoutStopSec` above the 5 s. Without `ExecStop` SIGTERM comes. Tcl
without TclX has no signal handling — the process ends in the middle of
a response.

Example unit file: `mdserver.service.beispiel` next to the script.
Container, nginx, Samba: the LAN books.

---

## Summary

- Control port = localhost, `ping`, `status`, `reload`, `stop`.
- `status` shows connections, requests, search index and the slowest
  requests; `--statuspath` the same over HTTP, off by default.
- Stop waits 5 s for running responses.
- ExecStop belongs to the unit, not SIGTERM alone.

---

*Next chapter: [TLS](070-tls.md)*
