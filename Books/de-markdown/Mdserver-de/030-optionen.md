# Optionen

## Einführung

`tclsh mdserver.tcl [Optionen]`. Alle Optionen außer `--config` und
`--help` können auch in einer Einstellungsdatei stehen (Kapitel
*Einstellungsdatei und GUI*). Die Vorgaben sind die vorsichtigen:
`--bind 127.0.0.1` (nur dieser Rechner), `--trusted-proxy` leer
(`X-Forwarded-For` wird ignoriert), dazu Grenzen für offene
Verbindungen.

---

## Tabelle

| Option | Standard | Bedeutung |
|---|---|---|
| `--config` | — | Einstellungsdatei, eine Option je Zeile; die Befehlszeile geht vor |
| `--port` | `8080` | HTTP-Port |
| `--bind` | `127.0.0.1` | Horchadresse. `*`, leer oder `0.0.0.0` = alle Schnittstellen; die Startmeldung warnt dann |
| `--maxconn` | `200` | offene Verbindungen insgesamt; darüber sofort 503 mit `Retry-After: 1`. `0` = ohne Grenze |
| `--maxperaddr` | `32` | offene Verbindungen je Absenderadresse; darüber 503. Adressen aus `--trusted-proxy` zählen nicht. `0` = ohne Grenze |
| `--dotfiles` | `0` | `.git`, `.env` ausliefern |
| `--pdf-search` | `auto` | PDFs in der Suche: `auto` (wenn `tclutils::tupdftext` ladbar), `1`, `0` |
| `--pdf-cache` | `$HOME/.cache/mdserver-pdf` | Cache für den PDF-Text, außerhalb der Wurzel. Ohne `HOME` unter dem Arbeitsverzeichnis |
| `--pdf-worker` | `1` | PDFs in einem zweiten `tclsh` lesen; `0`: im Serverprozess |
| `--office-search` | `auto` | `.odt`, `.ods`, `.odp`, `.docx`, `.xlsx` in der Suche: `auto` (jedes Format, dessen Modul ladbar ist), `1`, `0` |
| `--csv-view` | `auto` | `.csv` als Tabellenseite und in der Suche: `auto` (wenn `tclutils::tucsv` 0.2 ladbar), `1`, `0` |
| `--office-view` | `auto` | Office-Dateien als Seite statt als Download: `auto` (jedes Format, dessen Modul ladbar ist), `1`, `0` |
| `--viewcache` | `32` | MB für fertige Office- und CSV-Seiten; eine Seite bleibt, bis sich Änderungszeit oder Größe der Datei ändern. `0` = aus |
| `--trusted-proxy` | leer | Gegenstellen, deren `X-Forwarded-For` gilt. Exakte Adresse, keine Maske |
| `--maxline` | `8190` | Bytes je Zeile. Anfragezeile darüber: 414, Kopfzeile darüber: 431. `0` = ohne Grenze |
| `--maxheader` | `16384` | Bytes aller Köpfe; darüber 431. `0` = ohne Grenze |
| `--healthpath` | `/__mdserver/health` | Health-Pfad |
| `--statuspath` | leer | Status als Text über HTTP (wie `mdctl.tcl status`); leer = aus. Nur hinter einer Anmeldung |
| `--access` | leer | `zugriff.txt` (`pfad;gruppen`), außerhalb der Wurzel; leer = alles offen |
| `--users` | leer | `benutzer.txt` (`name;gruppen;hash`), außerhalb der Wurzel; ohne: nur `gast` |
| `--auth-http` | `0` | Anmeldung auch über HTTP, nur zum Testen |
| `--root` | `.` | Dokumentwurzel |
| `--theme` | `hell` | `hell`, `dunkel`, `solarized`. In `site` zählt nur `dunkel` |
| `--style` | `site` | Seitenstil: `site`, `plain`, `sidebar`, `sticky`, `collapsible` |
| `--stylesdir` | `../styles` | CSS neben `lib/` |
| `--navbg` `--navfg` | `#2c3e50` `#ffffff` | Farben der Navi-Leiste, nur ältere Stile |
| `--navmax` | `6` | Sektionen inline; mehr ins Dropdown. `0` = nie klappen. Nur ältere Stile |
| `--title` | `mdserver` | Site-Titel, in `site` links in der Kopfleiste |
| `--toc` | `1` | Inhaltsverzeichnis oben, nur ältere Stile |
| `--control` | leer | Control-Port, horcht immer nur auf `127.0.0.1` |
| `--no-log` | — | kein Zugriffsprotokoll |
| `--cert` `--key` | leer | TLS |
| `--tlsport` | `8443` | HTTPS-Port |
| `--help` | — | Hilfe |

Mehrere Proxys: `--trusted-proxy "127.0.0.1 10.0.0.5"`.

Für `--pdf-search`, `--pdf-worker`, `--office-search`, `--office-view`
und `--csv-view` gelten auch `off`, `no` und `false` als aus. `--pdf-search 1` warnt beim Start, wenn
`tclutils::tupdftext` fehlt; `auto` schaltet die Suche dann still ab.

---

## Was im Stil `site` wirkt

Der Stil `site` baut die Seite selbst, mit einem Stylesheet
(`styles/site.css`). Darum greifen nicht alle Optionen:

| Option | in `site` |
|---|---|
| `--theme dunkel` | Dunkelmodus für alle Seiten |
| `--theme hell`, `solarized` | ohne Wirkung; hell oder dunkel nach Systemeinstellung |
| `--toc` | ohne Wirkung; „Auf dieser Seite“ steht rechts ab drei Überschriften |
| `--navbg` `--navfg` `--navmax` | ohne Wirkung; `site` hat eine eigene Kopfleiste |
| `--title` | Name links in der Kopfleiste und im Fenstertitel |

Theme-Namen, `--toc` und die Leistenfarben gelten für `plain`,
`sidebar`, `sticky` und `collapsible`.

---

## `--dotfiles`

Aus, weil eine Wurzel, die zugleich Arbeitskopie ist, sonst
`/.git/config` herausgibt. Die Suche hält sich daran: Punkt-Ordner
bleiben bei `--dotfiles 0` aus dem Suchbestand.

---

## Zusammenfassung

- Die Vorgaben sind vorsichtig: nur `127.0.0.1`, kein vertrauter Proxy,
  höchstens 200 Verbindungen, 32 je Absender.
- Vorgabestil ist `site`; `--style plain` gibt das alte Aussehen.
- Stile liegen in `styles/` neben `lib/` im Repository mdserver.
- `--access`, `--users`: Zugriff (Kapitel *Zugriff*); `--config`: alle
  Optionen in einer Datei.
- Control-Port ist optional, für systemd-Stop aber der saubere Weg.

---

*Nächstes Kapitel: [Navigation und Theme](040-navigation-theme.md)*
