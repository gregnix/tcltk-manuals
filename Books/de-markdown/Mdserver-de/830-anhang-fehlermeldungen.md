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
ERROR: mdstack nicht gefunden: can't find package mdstack::parser 0.2
       Gesucht in:
         /opt/mdserver/lib
         /opt/mdstack/lib  (fehlt)
         /opt/docir/lib/tm  (fehlt)
         und auf dem Modulpfad
       mdstack neben mdserver legen (../mdstack/lib) oder MDSTACK_LIB setzen;
       docir ebenso (../docir/lib/tm oder DOCIR_TM).
```

mdstack oder docir fehlt. Die Liste nennt die Ordner, die der Launcher
durchsucht hat, in seiner Reihenfolge; `(fehlt)` heißt, den Ordner gibt
es nicht. Statt `mdstack::parser` kann `docir::mdSource`, `docir::html`,
`docir::diag` oder `docir::diagram` genannt sein: dann ist mdstack da,
docir nicht. Die Meldung nennt die verlangte Mindestfassung 0.2; jede
neuere 0.x passt.

```
ERROR: mdserver 0.5 nicht gefunden: can't find package mdserver 0.5
       mdserver-0.5.tm muss in lib/ liegen.
```

Der Launcher findet sein eigenes Modul nicht. `lib/mdserver-0.5.tm`
neben `mdserver.tcl` prüfen.

```
ERROR: mdserver::search 0.5 not found (can't find package mdserver::search 0.5).
       lib/mdserver/search-0.5.tm muss neben lib/mdserver-0.5.tm liegen.
```

Suche, Ansicht und Zugriff sind eigene Module. Den Ordner
`lib/mdserver/` neben `mdserver-0.5.tm` legen. Dieselbe Meldung gibt es
für `mdserver::view` und `mdserver::access`.

---

## Einstellungsdatei

```
ERROR: mdserver.conf Zeile 4: unbekannte Option "portx"
ERROR: mdserver.conf Zeile 2: port: keine Zahl: abc
ERROR: mdserver.conf Zeile 7: style: einer von site, plain, sidebar, sticky, collapsible, nicht kacheln
ERROR: mdserver.conf Zeile 9: port steht schon in Zeile 2
ERROR: mdserver.conf Zeile 5: no-log ist ein Schalter (ohne Wert, oder 0/1)
```

Der Server startet nicht. Datei und Zeile stehen vorn. Optionen ohne
`--` schreiben; ein Schalter steht ohne Wert.

---

## Zugriff

```
ERROR: --access /srv/md/zugriff.txt liegt in der Dokumentenwurzel und wuerde ausgeliefert -- ausserhalb ablegen
ERROR: --users /etc/mdserver/benutzer.txt ist nicht lesbar
```

Der Server startet nicht. `zugriff.txt` und `benutzer.txt` gehören
außerhalb von `--root` und müssen für den Dienst lesbar sein.

```
ERROR: zugriff.txt Zeile 3: erwartet pfad;gruppen: /fibu/
ERROR: zugriff.txt Zeile 4: der Pfad beginnt mit /: fibu/;fibu
ERROR: benutzer.txt Zeile 2: erwartet name;gruppen;hash
ERROR: benutzer.txt Zeile 3: kein Hash (mdctl.tcl passwd)
ERROR: benutzer.txt Zeile 4: anna steht zweimal
```

Beim Start: der Server startet nicht. Bei `reload` steht dieselbe Zeile
im Protokoll (`Zugriff: neu laden fehlgeschlagen, es gilt der alte
Stand: …`), und der alte Stand bleibt.

Im Protokoll beim Start, kein Abbruch:

```
Zugriff: Gruppe "fibu" (zugriff.txt Zeile 3) hat niemand
Zugriff: keine Zeile fuer "/" -- was keine Zeile hat, ist fuer niemanden offen
```

Die erste Zeile ist meist ein Tippfehler. Ein zweites `;` statt eines
Leerzeichens (`/lohn/;lohn;management`) macht aus beiden Namen eine
Gruppe `lohn;management`, die ebenfalls niemand hat. Die zweite Zeile
heißt: ohne Grundregel sieht niemand etwas (Anhang *Fallen*).

In der Startmeldung, kein Abbruch:

```
  Achtung: Anmeldung nur ueber HTTPS, und HTTPS ist nicht aktiv (--cert/--key)
  Achtung: --auth-http 1 -- Passwoerter auch unverschluesselt ueber HTTP
```

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

```
WARNING: --office-search: not found: tclutils::tudocx, tclutils::tuxlsx
WARNING: --csv-view: tclutils::tucsv 0.2 not found -- CSV files are sent as they are: …
```

Kein Abbruch. Nur mit `--office-search 1` bzw. `--csv-view 1`; bei
`auto` stehen die Formate allein im Banner (`Office:`, `CSV:`). Die
erste Zeile heißt: ODF wird gesucht, Word und Excel nicht, weil das
tclutils älter als 0.69.0 ist.

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
anderen Port. Nach einem neuen `control` in der Einstellungsdatei: der
laufende Server kennt den Port erst nach einem Neustart.

```
mdctl: keine Antwort von 127.0.0.1:8099
```

Verbindung kam zustande, aber innerhalb von `--timeout` (Vorgabe 10 s)
keine Antwort. Rückgabe 1.

```
mdctl: anna ist neu -- Gruppen angeben, z. B. "office fibu"
mdctl: mindestens 8 Zeichen
mdctl: die beiden Eingaben sind verschieden
mdctl: Name ohne : ; und Leerzeichen
mdctl: Gruppen durch Leerzeichen trennen, nicht durch ;
```

Meldungen von `mdctl.tcl passwd`; die Datei bleibt unverändert.

---

## HTTP-Status

| Status | Bedeutung |
|---|---|
| 301 | Verzeichnis ohne Schrägstrich |
| 303 | nach dem Anmelden über `/__mdserver/login` zurück zur Seite |
| 304 | unverändert |
| 400 | im Pfad ein `%` ohne zwei Hexziffern, `%00` oder NUL |
| 401 | mit Zugriff: Anmeldung nötig (Pfad nicht für `gast` offen, auch wenn es ihn nicht gibt) |
| 403 | Pfad außerhalb der Wurzel (auch Symlink hinaus), Punkt-Datei bei `--dotfiles 0`; mit Zugriff: Anmeldung über HTTP |
| 404 | nicht gefunden; mit Zugriff auch: angemeldet, aber ohne Recht |
| 405 | Methode nicht GET/HEAD |
| 414 | Anfragezeile länger als `--maxline` |
| 416 | Bereich nicht erfüllbar (Anfang hinter Dateiende); unlesbarer Range-Kopf gibt 200 |
| 429 | mit Zugriff: fünf falsche Passwörter von dieser Adresse in 10 Minuten |
| 431 | eine Kopfzeile länger als `--maxline` oder alle Köpfe länger als `--maxheader` |
| 501 | `?format=json` ohne `tclutils::tujson`: `format=json needs tclutils::tujson` |
| 503 | Health: Wurzel nicht lesbar; zu viele offene Verbindungen (`--maxconn`, `--maxperaddr`), mit `Retry-After: 1` |

---

## Zertifikat

```
GUELTIG, ABER OHNE subjectAltName
```

Browser lehnen ab. Neu erzeugen, SAN setzen. `--check` endet mit
Rückgabe 1.
