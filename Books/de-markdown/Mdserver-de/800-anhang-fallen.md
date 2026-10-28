# Fallen

## Einführung

Betriebsfehler, die wie „der Server hängt“ aussehen.

---

## Ohne `--bind` im LAN

Der Port ist auf allen Schnittstellen offen, ohne Anmeldung. Hinter nginx
gehört `127.0.0.1` hin.

---

## `echo stop | nc`

Läuft in den Timeout. `mdctl.tcl` verwenden.

---

## SIGTERM statt ExecStop

Große PDF wird abgeschnitten. Control-Port in der Unit.

---

## `?style=sidebar` ändert nichts

CSS-Datei nicht gefunden. `--stylesdir` prüfen, Dateien neben `lib/`
(`styles/sidebar.css`). Dasselbe gilt für `site`: ohne `styles/site.css`
steht das Layout ungestylt untereinander.

---

## `?theme=solarized` oder `?toc=0` ändert nichts

Der Vorgabestil ist `site`. Dort zählt nur `theme=dunkel`; Theme-Namen,
`toc`, `--navbg`, `--navfg`, `--navmax` gelten für die älteren Stile.
Abhilfe: `?style=plain&theme=solarized` oder `--style plain`.

---

## Die Seiten sehen nach dem Update anders aus

Vorgabe ist `site`, früher war es `plain`. Wer das alte Aussehen will,
startet mit `--style plain`.

---

## `can't find package docir::mdSource`

mdstack allein reicht nicht. `mdstack::html` 0.2 braucht fünf
docir-Module. Aus dem Repo: `docir/` neben `mdstack/` legen. Bei einer
Installation: `docir-0.1.1.tm` und `docir/` in das `lib/` neben
`mdserver.tcl` (Kapitel *Starten*).

---

## Module flach in `lib/`

`html-0.2.tm` direkt in `lib/` statt in `lib/mdstack/` wird nicht
gefunden. Der Unterordner ist Teil des Paketnamens.

---

## `X-Forwarded-For` ohne trusted-proxy

Jeder Klient könnte sich die Protokolladresse selbst setzen. Darum
liest mdserver den Kopf nur von Gegenstellen aus `--trusted-proxy`;
ohne die Option steht im Protokoll die Gegenstelle, bei nginx davor
also immer `127.0.0.1`.

---

## Wurzel = Git-Arbeitskopie, `--dotfiles 1`

`/.git/config` geht raus. Vorgabe ist aus — so lassen.

---

## `server.key` unter `--root`

mdserver liefert jede Datei der Wurzel, deren Name nicht mit einem Punkt
beginnt. `GET /server.key` gibt den Schlüssel heraus. Schlüssel außerhalb
der Wurzel ablegen.

---

## Clean-URL-Link auf eine Datei ohne `.md`

404, wenn die Datei nur als `.md` existiert und der Link einen anderen
Stamm hat. Ziel und Dateiname angleichen.

---

## Tcl/Tk-Handbuch im Unterordner, Verweise ins Leere

Mit `nroff2md --linkmode server` erzeugt, zeigen die Verweise auf
`/dict` — die Wurzel, nicht den Unterordner. Für einen Unterordner mit
`--linkmode file` neu erzeugen.

---

## Suche findet eine Datei nicht

Die Suche liest `.md` und, mit tclutils, `.pdf`. Punkt-Ordner bleiben
draußen (bei `--dotfiles 0`), Symlinks immer — auch solche, die
innerhalb der Wurzel bleiben. Wörter unter zwei Zeichen werden
ignoriert.

---

## Suche findet keine PDF

Banner-Zeile `PDF:` lesen. `Suche aus: tclutils::tupdftext nicht
gefunden` heißt: tclutils fehlt auf dem Modulpfad. Unter systemd gehört
`Environment=TCLUTILS_TM=…` in die Unit, die Shell-Umgebung gilt dort
nicht. Ist die Suche an, liest der Worker die PDFs nach dem Start nach
und nach; bis dahin meldet die Trefferseite „… PDFs werden noch
gelesen“. Eine gescannte PDF ohne Textebene gibt nie einen Treffer.

---

## Handbuchseiten heißen alle „NAME“

Nur in *Alle Dokumente* (`/?nav=index`). Seitenleiste, Kacheln, Titel
und Suche nehmen `CommandName` oder die NAME-Zeile (Kapitel
*Seitenlayout und Suche*).

---

*Nächstes Kapitel: [CLI](810-anhang-cli.md)*
