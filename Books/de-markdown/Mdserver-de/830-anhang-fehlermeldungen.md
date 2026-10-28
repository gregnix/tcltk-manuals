# Fehlermeldungen

## Einführung

Meldungen am Start und im Betrieb. `ERROR` und `WARNING` gehen nach
stderr, die Meldungen des PDF-Workers ins Protokoll.

---

## Start

```
ERROR: Cannot bind to HTTP port 8080: couldn't open socket: address already in use
ERROR: Cannot bind to HTTP port 8080 on 127.0.0.1: couldn't open socket: address already in use
```

Port belegt; mit `--bind` steht die Adresse dabei. Über den Control-Port
der alten Instanz `stop`, sonst den Prozess finden. Nicht blind
`fuser -k`, wenn ein anderer Dienst 8080 hat.

```
WARNING: tls not available -- HTTPS disabled: can't find package tls
```

Kein Abbruch. `--cert` und `--key` sind gesetzt, `tcl-tls` fehlt. HTTP
läuft weiter, HTTPS nicht.

```
ERROR: Certificate not found: server.crt
ERROR: Key not found: server.key
```

Pfad zu `--cert` oder `--key` falsch. Relativ gilt zum
Arbeitsverzeichnis.

```
ERROR: mdserver 0.4 nicht gefunden: can't find package mdserver 0.4
       mdserver-0.4.tm muss in lib/ liegen.
```

Der Launcher findet sein eigenes Modul nicht. `lib/mdserver-0.4.tm`
neben `mdserver.tcl` prüfen.

```
ERROR: mdparser 0.2 not found: can't find package mdstack::parser 0.2
```

Das mdstack-`lib/` fehlt. Der Launcher sucht es selbst unter `../../lib`;
bei einer Installation gehört `mdstack/parser-0.9.2.tm` in das `lib/`
neben dem Skript. Die Meldung nennt die verlangte Mindestfassung 0.2;
jede neuere 0.x passt.

```
ERROR: mdhtml 0.1 not found: can't find package docir::mdSource
```

`mdstack::html` ist da, docir nicht. Der Launcher sucht ein docir
neben mdstack (`../../../docir/lib/tm`). Sonst `docir-0.1.1.tm` und
`docir/` in das `lib/` legen. Statt `docir::mdSource` kann auch
`docir::html`, `docir::diag` oder `docir::diagram` genannt sein.

```
WARNING: mdstack::theme 0.1 not found -- themes disabled: …
```

Kein Abbruch. `--theme` wirkt dann nicht.

```
WARNING: control port 8099 not bound: …
```

Kein Abbruch, aber `mdctl.tcl` erreicht den Dienst nicht. Port belegt.

```
WARNING: --pdf-search: tclutils::tupdftext not found (TCLUTILS_TM or module path) -- PDFs are not searched: can't find package tclutils::tupdftext 0.1
```

Kein Abbruch. Nur mit `--pdf-search 1`; bei `auto` steht es allein im
Banner (`PDF:   Suche aus: …`). tclutils in `lib/` legen oder
`TCLUTILS_TM` setzen (Kapitel *Starten*).

---

## PDF-Worker

Diese Zeilen stehen im Protokoll (stdout, mit Uhrzeit davor), nicht
auf stderr. Mit `--no-log` fehlen sie.

```
pdf worker: starpack -- reading in the server
pdf worker: lib/pdftext-worker.tcl missing -- reading in the server
pdf worker: tclutils::tutask not found -- reading in the server
```

Kein Worker; mdserver liest die PDFs im eigenen Prozess wie mit
`--pdf-worker 0`. Steht beim Start, wenn die PDF-Suche an ist.

```
pdf worker: /srv/md/a.pdf has no text, reader failed: …
```

`tupdftext` konnte die Datei nicht lesen (beschädigt, keine PDF). Sie
steht leer im Cache, bis sie sich ändert.

```
pdf worker failed on /srv/md/a.pdf (…) -- the next search tries again
pdf worker failed again on /srv/md/a.pdf (…) -- skipped until it changes
```

Der Worker ist abgestürzt, endete mit einem Fehlercode oder brauchte
länger als 10 Minuten. Beim zweiten Mal bleibt die PDF draußen, bis sie
sich ändert.

---

## mdctl

```
mdctl: 127.0.0.1:8099 nicht erreichbar: couldn't open socket: connection refused
```

Kein mdserver mit `--control 8099` aktiv, oder er läuft auf einem
anderen Port.

```
mdctl: keine Antwort von 127.0.0.1:8099
```

Verbindung kam zustande, aber innerhalb von `--timeout` (Vorgabe 10 s)
keine Antwort. Rückgabe 1.

---

## HTTP-Status

| Status | Bedeutung |
|---|---|
| 301 | Verzeichnis ohne Schrägstrich |
| 304 | unverändert |
| 403 | Pfad außerhalb der Wurzel (auch Symlink hinaus), Punkt-Datei bei `--dotfiles 0` |
| 404 | nicht gefunden |
| 405 | Methode nicht GET/HEAD |
| 414 | Anfragezeile länger als `--maxline` |
| 416 | Bereich nicht erfüllbar (Anfang hinter Dateiende); unlesbarer Range-Kopf gibt 200 |
| 431 | eine Kopfzeile länger als `--maxline` oder alle Köpfe länger als `--maxheader` |
| 503 | Health: Wurzel nicht lesbar |

---

## Zertifikat

```
GUELTIG, ABER OHNE subjectAltName
```

Browser lehnen ab. Neu erzeugen, SAN setzen. `--check` endet mit
Rückgabe 1.
