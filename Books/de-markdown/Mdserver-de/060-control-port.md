# Control-Port

## Einführung

`--control PORT` öffnet einen Steuerkanal **nur auf localhost**. Darüber
endet der Prozess sauber — ohne `fuser -k`, ohne PID-Suche.

---

## Bedienen

```bash
tclsh mdserver.tcl --root /srv/md --control 8099
tclsh mdctl.tcl --port 8099 ping     # -> pong
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

- Control-Port = localhost, `ping` / `stop`.
- Stop wartet 5 s auf laufende Antworten.
- ExecStop gehört zur Unit, nicht SIGTERM allein.

---

*Nächstes Kapitel: [TLS](070-tls.md)*
