# Site aufbauen

## Einführung

Von einem leeren Ordner zu einer lesbaren Site. Inhalte und Server
getrennt halten: die Wurzel enthält nur, was ausgeliefert werden darf.

---

## Mindestbaum aus den Repositories

```
arbeit/
  mdserver/
    mdserver.tcl
    mdctl.tcl
    mkcert.tcl
    lib/mdserver-0.5.tm
    lib/mdserver/...
    styles/
  mdstack/
    lib/mdstack/...
  docir/
    lib/tm/...
  meinprojekt/
    docs/
      index.md
      einleitung.md
      api/
        index.md
```

`docs/` ist `--root`. `mdserver/` ist der Dienst. Ohne mdstack und
docir startet er nicht; als Nachbarordner findet der Launcher beide
selbst (Kapitel *Starten*). Für eine Installation ohne die Repositories
gehören die Module in `lib/` neben `mdserver.tcl` — die genaue Liste
steht ebenfalls dort.

---

## Start

```bash
cd arbeit/mdserver
tclsh mdserver.tcl --root ../meinprojekt/docs --port 8080 \
    --title "Mein Projekt" --control 8099
```

`http://127.0.0.1:8080/`. Ohne `index.md` erscheinen die Kacheln.

Bücher brauchen keinen Vorlauf mehr. Fehlt die `index.md`, erzeugt
mdserver die Startseite aus `book.tcl`. `book-webindex.tcl` (bookkit)
ist optional — für eine feste `index.md` und ein
`stichwortverzeichnis.md`. `mdstack::indexgen` schreibt bei Bedarf
`index.md` für Ordner ohne `book.tcl`; im Stil `site` reichen die
Kacheln.

---

## Empfohlene Site

Eine Wurzel für das LAN, Dienst und Schlüssel daneben:

```
/srv/md/                          --root
  index.md                        Startseite
  buecher/
    book-beispiel/
      README.md
      Beispiel-de/
        book.tcl
        010-einleitung.md
        ...
      Beispiel-de.pdf
      Beispiel-de.html
    book-zweites/
      ...
  tcltk/
    index.md                      aus nroff2md
    dict.md
    ...
  notizen/
    ...
  pdfs/
    handbuch.pdf                  mit tclutils durchsuchbar
/opt/mdserver/                    Dienst
  mdserver.tcl
  mdctl.tcl
  lib/
  styles/
/opt/mdstack/  /opt/docir/        Nachbarn, findet der Launcher selbst
/etc/mdserver/                    außerhalb von --root
  mdserver.conf                   Einstellungen (--config)
  zugriff.txt                     Rechte (--access)
  benutzer.txt                    Benutzer (--users)
  server.crt
  server.key
```

**Bücher.** Die bookkit-Ordner `book-xyz/` kommen unverändert nach
`buecher/`, samt den gebauten `.pdf` und `.html` neben dem Buchordner.
`/buecher/` zeigt sie als Buch-Kacheln mit Untertitel und Sprache. Im
Buch stehen PDF und HTML über der Kapitelliste und auf der Startseite.

**Tcl/Tk-Handbuch.** `nroff2md` (aus `mdstack/tools/`) wandelt die
nroff-Manpages der Tcl/Tk-Quellen in Markdown. Für einen Unterordner
gehört `--linkmode file` dazu:

```bash
tclsh nroff2md.tcl --batch tcltkdoc/ /srv/md/tcltk/ --linkmode file
```

`--linkmode server` schreibt Verweise als `/dict` — absolut zur Wurzel.
Das passt nur, wenn das Handbuch selbst `--root` ist. In `/srv/md/tcltk/`
zeigte `/dict` ins Leere. `--linkmode file` schreibt `dict.md`, relativ
und damit in jedem Ordner richtig.

**Schlüssel und Zugriff.** `server.crt`, `server.key`, `zugriff.txt` und
`benutzer.txt` liegen außerhalb von `--root`, etwa in `/etc/mdserver/`
neben `mdserver.conf`. Nie in `/srv/md/`: dort liefert mdserver jede
Datei aus. Für `zugriff.txt` und `benutzer.txt` verweigert der Server
den Start, für die Schlüssel nicht. Hinter nginx ohne eigene Anmeldung
braucht mdserver gar keinen Schlüssel.

**Als Dienst.** Ein fertiges Beispiel für genau diesen Aufbau liegt im
Repository mdserver unter `beispiel/server/`: mdserver in einem
unprivilegierten LXC-Container mit eigener Adresse im Heimnetz,
Dokumente und Programm nur lesend eingebunden, Dienstbenutzer
`mdserver`, Einstellungsdatei, Zugriff und HTTPS. Die Anleitung steht
dort in `README.md`, die Schritte im Container erledigt `install.sh`.
Unter Proxmox entfällt das Anlegen des Containers von Hand; der Rest ist
gleich.

---

## Demo

Unter `demo/` im Repository mdserver liegen `start.tcl` und
Beispieldocs in `docs/`, darunter ein Buch. Zum Ansehen des Dienstes,
nicht als Produktionswurzel.

```bash
cd mdserver
tclsh mdserver.tcl --root demo/docs --port 8080
```

---

## Zusammenfassung

- Wurzel = Inhalte. Skriptbaum = Dienst. Schlüssel, Einstellungen und
  Zugriff woanders.
- Fertiges Beispiel als Dienst im LXC-Container: `beispiel/server/` im
  Repository mdserver.
- mdstack und docir gehören zum Dienst, am einfachsten als Nachbarn.
- `index.md` in der Wurzel ist die Startseite.
- Bücher brauchen keinen webindex-Lauf; bookkit-Ordner nach `buecher/`.
- Handbuch im Unterordner: `nroff2md --linkmode file`.
- PDFs in der Wurzel sind mit tclutils seitenweise durchsuchbar.

---

*Nächstes Kapitel: [Fallen](800-anhang-fallen.md)*
