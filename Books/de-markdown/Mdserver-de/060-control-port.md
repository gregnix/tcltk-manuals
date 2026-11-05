# Control-Port

## Einführung

`--control PORT` öffnet einen Steuerkanal **nur auf localhost**. Darüber
endet der Prozess sauber — ohne `fuser -k`, ohne PID-Suche. Er sagt
auch, wie es dem Dienst geht (`status`), und leert die Zwischenspeicher
(`reload`).

---

## Bedienen

```bash
tclsh mdserver.tcl --root /srv/md --control 8099
tclsh mdctl.tcl --port 8099 ping     # -> pong
tclsh mdctl.tcl --port 8099 status   # mehrere Zeilen
tclsh mdctl.tcl --port 8099 reload   # -> reloading
tclsh mdctl.tcl --port 8099 stop     # -> stopping
```

`mdctl.tcl` liegt neben `mdserver.tcl`.

| Option | Standard | Bedeutung |
|---|---|---|
| `--port` | — | Steuerport (`--control` des Servers), Pflicht |
| `--host` | `127.0.0.1` | Adresse des Steuerports |
| `--timeout` | `10000` | Millisekunden, die `mdctl.tcl` auf die Antwort wartet |

Rückgabewert 0, wenn eine Antwort kam, sonst 1 (Meldungen im Anhang
*Fehlermeldungen*). systemd braucht die 0.

**Kein** `echo stop | nc`. OpenBSD-netcat auf Debian schließt die
Senderichtung nach EOF nicht; ohne `-N` läuft die Verbindung in den
Timeout. Andere `nc`-Varianten kennen `-N` nicht. Tcl ist da, wo
mdserver läuft — deshalb `mdctl.tcl`.

---

## Status

`status` sagt, was der Dienst seit dem Start getan hat:

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

| Zeile | Inhalt |
|---|---|
| `started` | Startzeit und Laufzeit |
| `http`, `https` | Adresse, an die gebunden wurde |
| `connections` | offen, höchstens gleichzeitig, Grenzen, mit 503 abgewiesen |
| `requests` | Anfragen nach Statusklasse |
| `search index` | Dateien im Index; während des Aufbaus `building (1234 of 30002 files read)` |
| `pdf queue` | PDFs, die der Worker noch liest |
| `view cache` | Office- und CSV-Seiten in der Zwischenablage, Treffer und neu gebaute |
| `slowest` | die fünf langsamsten Anfragen: Dauer, Zeit, Pfad ohne Query, Status, Notiz der Protokollzeile |

`view cache` ist die [Zwischenablage]{.index} für Office- und
CSV-Seiten (`--viewcache`). Die Zähler liegen im Speicher; nach einem Neustart beginnen sie bei
null. `slowest` zeigt, wo der eine Thread hängen bleibt: hier eine große
Tabelle beim ersten Aufruf.

Dasselbe gibt es über HTTP, wenn man es einschaltet:

```bash
tclsh mdserver.tcl --root /srv/md --statuspath /__mdserver/status
```

Die Vorgabe ist aus. Die Seite nennt Pfade und Zähler; sie gehört
hinter eine Anmeldung.

---

## Reload

`reload` vergisst die Office- und CSV-Seiten der Zwischenablage und die
Titel der Listen und liest den Suchindex im Hintergrund neu. Bis der
neue steht, antwortet der alte.

Nötig ist das selten. Suche und Zwischenablage erkennen eine geänderte
Datei an Änderungszeit und Größe. `reload` ist für den Fall, dass beides
gleich bleibt, etwa ein Ordner, der mit alten Zeitstempeln
zurückgespielt wurde.

---

## Was stop tut

1. Horchsockets zu: keine neue Verbindung.
2. Laufende Antworten: **5 s** Zeit.
3. Danach kappen, Protokollzeile
   `shutdown: 1 Verbindung(en) abgeschnitten`.

Werden alle Antworten rechtzeitig fertig, steht im Protokoll
`shutdown: fertig`.

Ohne diesen Ablauf schneidet ein Restart eine große PDF mitten im Byte
ab.

---

## systemd (Kennwerte, nicht der Installationsweg)

```ini
ExecStart=... mdserver.tcl --root /srv/md --port 8080 --bind 127.0.0.1 \
    --trusted-proxy 127.0.0.1 --control 8099
ExecStop=... mdctl.tcl --port 8099 stop
TimeoutStopSec=15
```

`TimeoutStopSec` über den 5 s. Ohne `ExecStop` kommt SIGTERM. Tcl ohne
TclX hat keine Signalbehandlung — der Prozess endet mitten in der
Antwort.

Unit-Datei als Beispiel: `mdserver.service.beispiel` neben dem Skript.
Container, nginx, Samba: LAN-Bücher.

---

## Zusammenfassung

- Control-Port = localhost, `ping`, `status`, `reload`, `stop`.
- `status` zeigt Verbindungen, Anfragen, Suchindex und die langsamsten
  Anfragen; `--statuspath` dasselbe über HTTP, Vorgabe aus.
- Stop wartet 5 s auf laufende Antworten.
- ExecStop gehört zur Unit, nicht SIGTERM allein.

---

*Nächstes Kapitel: [TLS](070-tls.md)*
