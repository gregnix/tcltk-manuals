# Netz und HTTPS

## tuhttps

[tuhttps]{.index} ist die gemeinsame HTTPS-Politik für Clients, die
`::http::register` nutzen. Zertifikate werden geprüft; Abschalten nur
über `-insecure 1`. Eine interne CA gibt man mit `-cafile` an.
`tuhttps::with prefix script` registriert `https` nur für die Dauer
eines Skripts und stellt danach die vorige Registrierung wieder her, auch
bei Fehlern. Im Skript kein `return` verwenden (Kommentar im Code). Eine
Anwendung, die selbst danach `https` registriert, oder asynchrone
`::http::geturl -command`-Aufrufe während `with` sieht `tuhttps` nicht:
die Registrierung ist befristet, nicht gesperrt.

Clients: `tufetch`, `tudav`, `tupostgrest`. Roh-REST ohne
tclutils-Politik: Buch *Tcl REST*.

---

## tls 1.x und tls 2.0

| tls | CA-Speicher |
|---|---|
| 2.0 (Tcl 9) | OpenSSL-Standardpfade, keine Datei nötig |
| 1.x (Tcl 8.6, auch Windows) | findet den System-Speicher nicht selbst |

Nur unter [tls]{.index} < 2.0 sucht `tuhttps` ein CA-Bundle, und zwar
in dieser Reihenfolge: `$env(SSL_CERT_FILE)`, dann feste Pfade
(`/etc/ssl/certs/ca-certificates.crt`, `/etc/pki/tls/certs/ca-bundle.crt`,
`/etc/ssl/ca-bundle.pem`, `/etc/ssl/cert.pem`,
`/usr/local/etc/openssl/cert.pem`). Findet es keines, wirft es
`{TCLUTILS TUHTTPS NOCA}` und nennt den Ausweg (`-cafile`,
`SSL_CERT_FILE`). Es fällt nie auf „ungeprüft“ zurück. Unter Windows mit
tls 1.x: `SSL_CERT_FILE` setzen oder `-cafile` übergeben.

Unter Windows mit tls 2.0 entscheidet OpenSSL. Findet es keinen
Speicher, scheitert der Handshake. `-cafile` bleibt der Ausweg.

---

## Was socketCmd zurückgibt

`socketCmd` liefert das Befehlspräfix für `::http::register`. Es öffnet
keinen Socket. Unter Tcl 8.6.18 mit tls 2.0.1:

| Aufruf | Präfix |
|---|---|
| `-host example.org` | `::tls::socket -autoservername 1 -require 1` |
| `-insecure 1 -host example.org` | `::tls::socket -autoservername 1 -request 0 -require 0` |
| `-host 127.0.0.1` | `::tls::socket -autoservername 0 -require 1` |

Eine IP bekommt kein SNI (`-autoservername 0`). tls ab 2.0 hängt kein
`-cafile` an. Die Suche von `caFile` läuft trotzdem und liefert die
erste lesbare Datei. Auf diesem Linux ist das
`/etc/ssl/certs/ca-certificates.crt`. Gebraucht wird sie erst, wenn
`socketCmd` ein tls älter als 2.0 sieht. Eine nicht lesbare `-cafile`
wirft auch unter tls 2 `{TCLUTILS TUHTTPS CAFILE}`.

---

## tufetch

[tufetch]{.index} 0.4 holt per nativem `http` + `tls`, sonst per `curl`
oder `wget`. Alle drei Wege prüfen das Zertifikat. `-cafile` und
`-insecure` gelten für alle drei.

| Befehl | Wirkung |
|---|---|
| `get url ?optionen?` | Rumpf als UTF-8-Text |
| `download url pfad ?optionen?` | Rumpf als Bytes in die Datei, Rückgabe `native`, `curl` oder `wget` |

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-timeout` | 30000 | Millisekunden |
| `-redirects` | 5 | danach `{TCLUTILS TUFETCH REDIRECT}` |
| `-method` | `get` | `get` oder `post` |
| `-headers` | | flache Liste Name Wert |
| `-data` | | Rumpf, zusammen mit `-method post` |
| `-type` | | Content-Type dieses Rumpfs |
| `-cafile` | | CA-Datei für die Prüfung |
| `-insecure` | 0 | jedes Zertifikat gilt |

Fehlt unter tls 1.x jedes CA-Bundle, tritt der native Weg zur Seite und
`curl`/`wget` übernehmen (sie bringen eigene CA-Speicher mit). Gibt es
keines der beiden, kommt `{TCLUTILS TUFETCH NOMETHOD}` mit dem Ausweg
in der Meldung (`no HTTP method available: …` plus Text von `NOCA`).
Ganz ohne tls und ohne curl/wget lautet sie
`no HTTP method available -- install the Tcl tls package or curl/wget`.

`{TCLUTILS TUFETCH CAFILE}` heißt dagegen: die mit `-cafile` genannte
Datei ist nicht lesbar. Diesen Code gibt es nur auf dem nativen Weg, also
mit `tls`. Ohne `tls` reicht `tufetch` die Datei an curl
(`--cacert`) bzw. wget (`--ca-certificate=`) weiter. Ein Fehler von
curl kommt dann als `CONNECT`, einer von wget als `CHILDSTATUS` (laut
Code). `tuhttps` meldet den Fall
als `{TCLUTILS TUHTTPS CAFILE}`. Ohne `tls` kommt dort
`{TCLUTILS TUHTTPS NOTLS}` — die tls-Prüfung läuft vor der
`-cafile`-Prüfung.

Weitere Codes von `tufetch`: `{TCLUTILS TUFETCH HTTP <Klasse> <Status>}`
(etwa `HTTP 4XX 404`), `URL` (nur `http://` und `https://`), `TIMEOUT`,
`CONNECT` und `REDIRECT`. Präfix-Traps wie `trap {TCLUTILS TUFETCH HTTP}`
fangen eine ganze Klasse. Über wget wird ein HTTP-Status nicht übersetzt;
er erscheint als `CHILDSTATUS` von `exec`.

Ohne Server bleiben diese beiden Fehler:

```tcl
package require tclutils::tufetch
::tclutils::tufetch::get ftp://example.com/a
    ;# -> {TCLUTILS TUFETCH URL}  unsupported or invalid URL
::tclutils::tufetch::get https://example.com/ -cafile /gibt/es/nicht.pem
    ;# -> {TCLUTILS TUFETCH CAFILE}  cannot read CA file

package require tclutils::tuhttps
try {
    ::tclutils::tuhttps::socketCmd -cafile /gibt/es/nicht.pem
} trap {TCLUTILS TUHTTPS CAFILE} msg {
    puts "CA-Datei: $msg"
} trap {TCLUTILS TUHTTPS NOTLS} msg {
    puts "kein tls: $msg"
}
```

Mit tls lautet die Meldung `cannot read CA file: /gibt/es/nicht.pem`,
ohne tls `https needs the tls package: can't find package tls`. Fehlt
unter tls 1.x jedes Bundle, kommt `NOCA` mit dem Text, `-cafile` oder
`SSL_CERT_FILE` zu setzen.

---

## tusparql

[tusparql]{.index} ist ein schlanker SPARQL-Client. Den Transport
übernimmt `tufetch`, die Query-Strings baut `tuurl`, das Ergebnis liest
`tujson` (SPARQL 1.1 Query Results JSON). Damit gelten dieselben
Voraussetzungen wie bei `tufetch`: `http` mit `tls`, sonst `curl` oder
`wget`. XML-Ergebnisse liest das Modul nicht.

| Befehl | Wirkung |
|---|---|
| `query endpunkt sparql ?optionen?` | `SELECT`; Liste von Dicts, je Zeile Variable auf Wert |
| `ask endpunkt sparql ?optionen?` | `ASK`; `1` oder `0` |

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-method` | `get` | `post` schickt die Abfrage als Rumpf; jeder andere Wert gilt als `get` |
| `-timeout` | 30000 | Millisekunden, an `tufetch` weitergereicht |
| `-headers` | | weitere Kopfzeilen, flache Liste Name Wert; ein `Accept` darin ersetzt `-accept` |
| `-accept` | `application/sparql-results+json` | Wert der Kopfzeile `Accept` |

Laut Code hängt `get` an den Endpunkt `?query=…&format=json` an, mit
`+` für das Leerzeichen. `post` schickt die Abfrage roh mit dem
Content-Type `application/sparql-query`. `Accept` geht genau einmal
hinaus: steht in `-headers` schon ein `Accept` (gleich in welcher
Schreibung), gilt dieses, sonst der Wert von `-accept`. Die Antwort
liest `tusparql` immer als JSON. Ein Endpunkt, der schon einen
Query-String hat, etwa `…/sparql?key=1`, bekommt die Parameter mit `&`
angehängt.

Eine Ergebniszeile enthält nur `value` je Variable; `type`,
`datatype` und `xml:lang` fallen weg. Eine Variable ohne Bindung, etwa
hinter `OPTIONAL`, fehlt im Dict der Zeile. Die Reihenfolge der
Variablen kommt aus `head vars`. Fehlt diese Liste, gelten die
Variablen aller Zeilen in der Reihenfolge ihres ersten Auftretens,
nicht nur die der ersten Zeile.

Das Beispiel braucht einen erreichbaren Endpunkt; das Ergebnis hängt
von dessen Daten ab und steht deshalb nur als Form da.

```tcl
package require tclutils::tusparql
set ep https://query.wikidata.org/sparql
set q {SELECT ?ort WHERE { ?ort wdt:P31 wd:Q515 } LIMIT 2}
::tclutils::tusparql::query $ep $q -timeout 10000
    ;# -> {ort http://www.wikidata.org/entity/Q…} {ort …}
::tclutils::tusparql::ask $ep {ASK { wd:Q64 wdt:P31 wd:Q515 }}
    ;# -> 1
```

Die URL eines `get`-Aufrufs für `ASK {}` an
`https://example.org/sparql` lautet
`https://example.org/sparql?query=ASK+%7B%7D&format=json`. Eine Antwort
mit zwei Zeilen, deren zweite `gang` nicht bindet, ergibt
`{ort Nord gang 3} {ort Süd}`.

Eine Antwort ohne `boolean` wirft bei `ask`
`{TCLUTILS TUSPARQL NOTASK}`. Fehler beim Transport und HTTP-Status
kommen unverändert aus `tufetch` (`{TCLUTILS TUFETCH …}`), ein
Antworttext, der kein JSON ist, als `{TCLUTILS TUJSON PARSE offset}`.
Eine unbekannte Option wirft `{TCLUTILS COMMON OPTION -name}`.

---

## Zusammenfassung

- Eine Stelle für HTTPS: `tuhttps`.
- tls 1.x braucht ein CA-Bundle; sonst `NOCA` bzw. `NOMETHOD`.
- `CAFILE` = `-cafile` nicht lesbar, nicht „CA fehlt“.
- `-insecure` bewusst und lokal halten.
- SPARQL: `tusparql` über `tufetch`, nur JSON-Ergebnisse, Zeilen als Dicts ohne Typ.
- Query-Strings: Kapitel [Kodierung, Hash und Vergleich](052-kodierung-hash-vergleich.md) (`tuurl`).

---

*Nächstes Kapitel: [tusettings](080-tusettings.md)*
