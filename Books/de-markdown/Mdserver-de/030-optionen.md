# Optionen

## Einführung

`tclsh mdserver.tcl [Optionen]`. Leere Vorgabe bei `--bind` und
`--trusted-proxy` heißt: alle Schnittstellen, `X-Forwarded-For` wird
ignoriert.

---

## Tabelle

| Option | Standard | Bedeutung |
|---|---|---|
| `--port` | `8080` | HTTP-Port |
| `--bind` | leer | Horchadresse. Leer = alle Schnittstellen |
| `--dotfiles` | `0` | `.git`, `.env` ausliefern |
| `--pdf-search` | `auto` | PDFs in der Suche: `auto` (wenn `tclutils::tupdftext` ladbar), `1`, `0` |
| `--pdf-cache` | `$HOME/.cache/mdserver-pdf` | Cache für den PDF-Text, außerhalb der Wurzel. Ohne `HOME` unter dem Arbeitsverzeichnis |
| `--pdf-worker` | `1` | PDFs in einem zweiten `tclsh` lesen; `0`: im Serverprozess |
| `--trusted-proxy` | leer | Gegenstellen, deren `X-Forwarded-For` gilt. Exakte Adresse, keine Maske |
| `--maxline` | `8190` | Bytes je Zeile. Anfragezeile darüber: 414, Kopfzeile darüber: 431. `0` = ohne Grenze |
| `--maxheader` | `16384` | Bytes aller Köpfe; darüber 431. `0` = ohne Grenze |
| `--healthpath` | `/__mdserver/health` | Health-Pfad |
| `--root` | `.` | Dokumentwurzel |
| `--theme` | `hell` | `hell`, `dunkel`, `solarized`. In `site` zählt nur `dunkel` |
| `--style` | `site` | Seitenstil: `site`, `plain`, `sidebar`, `sticky`, `collapsible` |
| `--stylesdir` | `../styles` | CSS neben `lib/` |
| `--navbg` `--navfg` | `#2c3e50` `#ffffff` | Farben der Navi-Leiste, nur ältere Stile |
| `--navmax` | `6` | Sektionen inline; mehr ins Dropdown. `0` = nie klappen. Nur ältere Stile |
| `--title` | `mdserver` | Site-Titel, in `site` links in der Kopfleiste |
| `--toc` | `1` | Inhaltsverzeichnis oben, nur ältere Stile |
| `--control` | leer | Control-Port, nur localhost |
| `--no-log` | — | kein Zugriffsprotokoll |
| `--cert` `--key` | leer | TLS |
| `--tlsport` | `8443` | HTTPS-Port |
| `--help` | — | Hilfe |

Mehrere Proxys: `--trusted-proxy "127.0.0.1 10.0.0.5"`.

Für `--pdf-search` und `--pdf-worker` gelten auch `off`, `no` und
`false` als aus. `--pdf-search 1` warnt beim Start, wenn
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

- Die gefährlichen Defaults sind Bind und trusted-proxy: leer.
- Vorgabestil ist `site`; `--style plain` gibt das alte Aussehen.
- Stile liegen in `tools/mdserver/styles/` neben `lib/`.
- Control-Port ist optional, für systemd-Stop aber der saubere Weg.

---

*Nächstes Kapitel: [Navigation und Theme](040-navigation-theme.md)*
