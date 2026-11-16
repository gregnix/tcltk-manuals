# Fallen

## Einführung

Betriebsfehler, die wie „der Server hängt“ aussehen.

---

## Nach dem Update nicht mehr im LAN erreichbar

Seit November 2026 horcht mdserver ohne `--bind` nur auf `127.0.0.1`.
Wer ihn bisher ohne `--bind` für das ganze Netz gestartet hat, braucht
jetzt `--bind '*'` (mit Anführungszeichen) oder die Adresse der
Schnittstelle. Hinter nginx bleibt es bei `127.0.0.1`.

---

## `--bind '*'` ohne Anmeldung

Der Port ist auf allen Schnittstellen offen, ohne Anmeldung. Die
Startmeldung warnt („Achtung: von anderen Rechnern erreichbar“). Nur im
vertrauten Netz, sonst Proxy mit Anmeldung davor oder der eigene
Zugriff (`--access`, Kapitel *Zugriff*).

---

## Mit Zugriff sieht niemand etwas

`zugriff.txt` hat keine Zeile für `/`. Was keine passende Zeile hat, ist
für niemanden offen, auch die Startseite. Das Protokoll sagt es beim
Start (`keine Zeile fuer "/"`). Fast immer gehört `/;mitarbeiter` oder
`/;gast` hinein; die GUI bietet „Regel / anlegen…“ an.

---

## Niemand kann sich anmelden

Die Anmeldung geht nur über HTTPS. Ohne `--cert` und `--key` gibt es
kein HTTPS, und jede Anmeldung über HTTP bekommt 403. Die Startmeldung
warnt („Anmeldung nur ueber HTTPS, und HTTPS ist nicht aktiv“). Ohne
`--users` gibt es niemanden, der sich anmelden könnte; dann gilt nur
`gast`.

---

## Nach fünf Versuchen geht auch das richtige Passwort nicht

Fünf falsche Passwörter sperren die Adresse 10 Minuten lang (429). Das
gilt auch für das richtige. Abwarten; ein Neustart des Servers hebt die
Sperre auf. Die Sperre gilt der Gegenstelle der Verbindung, nicht
`X-Forwarded-For`: hinter einem Proxy ist das für alle der Proxy, und
einer sperrt alle aus.

---

## `zugriff.txt` in der Wurzel

Der Server startet nicht: `--access … liegt in der Dokumentenwurzel und
wuerde ausgeliefert`. Dasselbe für `benutzer.txt`. Beide neben die
Einstellungsdatei legen, außerhalb von `--root`. Eine Einstellungsdatei
ohne `root` hat die Wurzel `.`, also ihren eigenen Ordner — dann liegen
die Dateien daneben doch „in der Wurzel“.

---

## Änderung in `mdserver.conf` wirkt nicht

`reload` liest nur `zugriff.txt` und `benutzer.txt`. Alle anderen
Einstellungen, auch ein neuer Steuerport, gelten erst nach einem
Neustart. Ein `mdctl.tcl reload` an einen Port, den der laufende Server
noch nicht kennt, endet mit `connection refused`.

---

## Älterer Stand: Benutzername mit „s“

Bis zum Stand vom 16.11.2026 prüfte mdserver Benutzernamen mit dem
Glob-Muster `*[:;\s]*`. Dort heißt `\s` nicht Leerraum, sondern „`\`
oder `s`“: `hans`, `klaus` und jeder andere Name mit einem `s` galten
als ungültig. Der Server startete mit so einem Namen in `benutzer.txt`
nicht, `mdctl.tcl passwd` und die GUI lehnten ihn ab. Behoben (Tests
`access-10`, `gui-18`).

---

## Hinter dem Proxy 503 bei vielen Nutzern

`--maxperaddr` (32) zählt je Absenderadresse. Hinter einem Proxy ist das
immer dieselbe. Die Adresse des Proxys gehört in `--trusted-proxy`; dann
zählt nur noch `--maxconn`.

---

## Suche findet nach dem Start zu wenig

Der Suchindex entsteht nach dem Start im Hintergrund, bei großen
Beständen eine Weile. Bis dahin sagt die Ergebnisseite, wie viele
Dateien noch fehlen. Später noch einmal suchen.

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
docir-Module. Aus den Repositories: `docir/` neben `mdserver/` legen
oder `DOCIR_TM` setzen. Bei einer Installation: `docir-0.1.1.tm` und
`docir/` in das `lib/` neben `mdserver.tcl` (Kapitel *Starten*).

---

## Nach dem Umzug: mdstack nicht gefunden

Bis 0.4 lag mdserver in `mdstack/tools/mdserver/` und fand mdstack über
`../../lib`. Seit 0.5 ist er ein eigenes Repository und sucht mdstack
als Nachbarn (`../mdstack/lib`) oder in `MDSTACK_LIB`. Wer nur den
alten Ordner `tools/mdserver/` irgendwohin kopiert hat, bekommt
`mdstack nicht gefunden` mit der Liste der durchsuchten Ordner. Unter
systemd gehören `MDSTACK_LIB` und `DOCIR_TM` als `Environment=` in die
Unit, wenn die Repositories nicht nebeneinander liegen.

---

## `lib/mdserver/` fehlt

Wer nach dem Update nur `mdserver-0.5.tm` kopiert hat, bekommt beim Start
`mdserver::search 0.5 not found` oder dieselbe Meldung für `view` oder
`access`. Der Ordner `lib/mdserver/` mit `search-0.5.tm`, `view-0.5.tm`,
`access-0.5.tm` und `conf-0.5.tm` gehört dazu.

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

Die Suche liest `.md` und, mit tclutils, `.pdf`, Office-Dateien und
`.csv` (Banner-Zeilen `PDF:`, `Office:`, `CSV:`). Punkt-Ordner bleiben
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

## `or` findet nichts mehr

`a or b` sucht drei Wörter, darunter `or`. Nur `OR`, `ODER` und `|`
verbinden zwei Wörter zu „eins von beiden“.

---

## Eine CSV- oder Office-Datei lässt sich nicht herunterladen

Ein Link auf eine `.csv` oder eine Office-Datei öffnet die Tabellen-
oder Textseite, in jedem Stil. Die Datei selbst liefert `?raw=1` (Link
oben auf der Seite), für alle Dateien `--csv-view 0` bzw.
`--office-view 0`.

---

## Datum aus einer XLSX ist eine Zahl

Excel speichert ein Datum als Seriennummer. Die Suche findet „46325“,
nicht „30.10.2026“.

---

## Handbuchseiten heißen alle „NAME“

Nur in *Alle Dokumente* (`/?nav=index`). Seitenleiste, Kacheln, Titel
und Suche nehmen `CommandName` oder die NAME-Zeile (Kapitel
*Seitenlayout und Suche*).

---

## Älterer Stand: Befehle über die URL

Bis zum Stand vom 30.10.2026 lief der URL-Pfad durch `subst`. Eine
Anfrage auf `/[exec id]` führte `id` als Server-Benutzer aus, auch hinter
einem Proxy. Jede ältere Installation aktualisieren; der neue Stand
dekodiert nur `%XX` (Test `url-1`), ein kaputtes `%` im Pfad ist 400.

---

## Dateinamen mit Umlauten: 404

Unter systemd ist `LANG` nicht gesetzt, Tcl liest Dateinamen dann als
iso8859-1. Die Startmeldung warnt mit `Achtung: Systemkodierung`. In der
Unit `Environment=LANG=C.UTF-8` setzen (steht in
`mdserver.service.beispiel`).

---

*Nächstes Kapitel: [CLI](810-anhang-cli.md)*
