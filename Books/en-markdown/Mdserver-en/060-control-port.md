# Control Port

## Introduction

`--control PORT` opens a control channel **on localhost only**. Through
it the process ends cleanly — without `fuser -k`, without searching for
the PID.

---

## Usage

```bash
tclsh mdserver.tcl --root /srv/md --control 8099
tclsh mdctl.tcl --port 8099 ping     # -> pong
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

- Control port = localhost, `ping` / `stop`.
- Stop waits 5 s for running responses.
- ExecStop belongs to the unit, not SIGTERM alone.

---

*Next chapter: [TLS](070-tls.md)*
