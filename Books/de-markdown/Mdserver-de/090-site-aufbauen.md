# Site aufbauen

## Einführung

Von einem leeren Ordner zu einer lesbaren Site. Inhalte und Server
getrennt halten: die Wurzel enthält nur, was ausgeliefert werden darf.

---

## Mindestbaum aus dem Repo

```
arbeit/
  mdstack/
    lib/
      mdstack/parser-0.9.2.tm
      mdstack/html-0.2.tm
      mdstack/theme-0.1.tm
    tools/
      mdserver/
        lib/mdserver-0.4.tm
        lib/pdftext-worker.tcl
        styles/
        mdserver.tcl
        mdctl.tcl
        mkcert.tcl
  docir/
    lib/tm/
      docir-0.1.1.tm
      docir/...
  meinprojekt/
    docs/
      index.md
      einleitung.md
      api/
        index.md
```

`docs/` ist `--root`. `tools/mdserver/` ist der Dienst. Ohne das
mdstack-`lib/` und ohne `docir/` daneben startet er nicht. Der Launcher
findet beide selbst (Kapitel *Starten*). Für eine Installation ohne
Repo gehören die Module in `lib/` neben `mdserver.tcl` — die genaue
Liste steht ebenfalls dort.

---

## Start

```bash
cd arbeit/mdstack/tools/mdserver
tclsh mdserver.tcl --root ../../../meinprojekt/docs --port 8080 \
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
/etc/mdserver/                    Schlüssel, außerhalb von --root
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

**Schlüssel.** `server.crt` und `server.key` liegen außerhalb von
`--root`, etwa in `/etc/mdserver/`. Nie in `/srv/md/`: dort liefert
mdserver sie aus. Hinter nginx braucht mdserver gar keinen Schlüssel.

---

## Demo

Unter `tools/mdserver/demo/` liegen `start.tcl` und Beispieldocs in
`docs/`, darunter ein Buch. Zum Ansehen des Dienstes, nicht als
Produktionswurzel.

```bash
cd tools/mdserver
tclsh mdserver.tcl --root demo/docs --port 8080
```

---

## Zusammenfassung

- Wurzel = Inhalte. Skriptbaum = Dienst. Schlüssel woanders.
- mdstack-`lib/` und docir gehören zum Dienst.
- `index.md` in der Wurzel ist die Startseite.
- Bücher brauchen keinen webindex-Lauf; bookkit-Ordner nach `buecher/`.
- Handbuch im Unterordner: `nroff2md --linkmode file`.
- PDFs in der Wurzel sind mit tclutils seitenweise durchsuchbar.

---

*Nächstes Kapitel: [Fallen](800-anhang-fallen.md)*
