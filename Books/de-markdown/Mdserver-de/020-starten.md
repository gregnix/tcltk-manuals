# Starten

## Einführung

Arbeitsverzeichnis: das Repository `mdserver/` oder ein Pfad, der
`mdserver.tcl` findet. Die [Wurzel]{.index} der Dokumente ist `--root`,
nicht das Skriptverzeichnis.

---

## Kanonischer Start (LAN hinter Proxy)

```bash
tclsh mdserver.tcl \
    --root /srv/md \
    --port 8080 \
    --bind 127.0.0.1 \
    --trusted-proxy 127.0.0.1 \
    --control 8099 \
    --title Dokumente
```

`--bind 127.0.0.1` ist die [Vorgabe]{.index}; hier steht es, damit die
Zeile auch mit einer älteren Fassung dasselbe tut. Ohne `--bind` horcht
mdserver nur auf diesem Rechner. Andere Rechner erreichen den Port erst
mit `--bind '*'` (alle Schnittstellen) oder einer Adresse. Dann ist er
ohne Anmeldung offen, und die Startmeldung sagt es:

```
  HTTP:  0.0.0.0:8080 (alle Schnittstellen)
         http://localhost:8080/
  Achtung: von anderen Rechnern erreichbar (--bind *); ohne Anmeldung davor nur im vertrauten Netz
```

Bis Anfang November 2026 hieß ein fehlendes `--bind` alle
Schnittstellen. Wer sich darauf verlassen hat, braucht jetzt
`--bind '*'`.

Ohne `--style` gilt `site`, das ganze Seitenlayout. Das frühere
Aussehen gibt `--style plain`.

---

## Lokal zum Lesen

```bash
tclsh mdserver.tcl --root ../meinprojekt/docs --port 8080
```

Dann `http://127.0.0.1:8080/`. Startseite: `index.md` in der Wurzel.
Fehlt sie, zeigt `site` die Ordner und Dokumente als Kacheln.

Im Heimnetz, ohne Proxy, für vertraute Rechner:

```bash
tclsh mdserver.tcl --root ../meinprojekt/docs --port 8080 --bind '*'
```

Die Anführungszeichen braucht die Shell, sonst setzt sie für `*` die
Dateinamen des Ordners ein. Wer `--bind '*'` braucht und nicht allen im
Netz alles zeigen will, schaltet den Zugriff ein (Kapitel *Zugriff*).

---

## Module finden

mdserver braucht aus mdstack `mdstack::parser` und `mdstack::html`
(`mdstack::theme` wahlweise), und `mdstack::html` braucht docir. Alle
drei sind eigene Repositories. Der [Launcher]{.index} `mdserver.tcl`
hängt vor dem `package require` diese Ordner an den
[Modulpfad]{.index}, nur wenn es sie gibt (`lib/modulpfad.tcl`):

| Reihenfolge | Ordner | Inhalt |
|---|---|---|
| 1 | `lib` neben dem Skript | die mdserver-Module, bei einer Installation alle Module |
| 2 | `MDSTACK_LIB`, `DOCIR_TM` | das `lib/` von mdstack und das `lib/tm` von docir, wenn gesetzt |
| 3 | `../mdstack/lib`, `../docir/lib/tm` | mdstack und docir als Nachbarn des Repositorys |
| 4 | der übliche Modulpfad | installierte Pakete |

Liegen die drei Repositories nebeneinander, läuft der Server ohne
weitere Einstellung:

```
arbeit/
  mdserver/
    mdserver.tcl
    lib/mdserver-0.5.tm
  mdstack/
    lib/mdstack/...
  docir/
    lib/tm/docir-0.1.1.tm
    lib/tm/docir/...
```

Liegen sie woanders, zeigen zwei Umgebungsvariablen dorthin:

```bash
MDSTACK_LIB=/opt/mdstack/lib DOCIR_TM=/opt/docir/lib/tm \
    tclsh mdserver.tcl --root /srv/md
```

Fehlt mdstack oder docir, nennt die Meldung alle durchsuchten Ordner
(Anhang *Fehlermeldungen*).

Für eine Installation ohne die Repositories gehört alles in das `lib/`
neben dem Skript. Genau diese Dateien, kein ganzes mdstack:

```
mdserver/
  mdserver.tcl
  mdctl.tcl
  mdserver-gui.tcl
  mkcert.tcl
  styles/
    site.css
    sidebar.css
    sticky-top.css
    collapsible.css
  lib/
    modulpfad.tcl
    mdserver-0.5.tm
    mdserver/
      search-0.5.tm
      view-0.5.tm
      access-0.5.tm
      conf-0.5.tm
    pdftext-worker.tcl
    mdstack/
      parser-0.9.2.tm
      html-0.2.tm
      theme-0.1.tm
    docir-0.1.1.tm
    docir/
      mdSource-0.2.tm
      html-0.2.tm
      diag-0.1.tm
      diagram-0.1.tm
```

Die Unterordner `mdserver/`, `mdstack/` und `docir/` sind Teil des
Paketnamens: für `docir::html` sucht Tcl die Datei `docir/html-0.2.tm`,
für `mdserver::view` die Datei `mdserver/view-0.5.tm`. Flach
nebeneinander gelegt findet `package require` sie nicht.

Für die PDF-Suche kommt tclutils dazu. Der Launcher sucht es nicht
selbst: entweder liegen `tclutils/common-0.3.tm`,
`tclutils/tupdftext-0.1.tm` und `tclutils/tutask-0.2.tm` ebenfalls in
`lib/` (`tupdftext` und `tutask` laden `common`), für Office-Dateien,
CSV und JSON dazu `tuzip`, `tuodf`, `tudocx`, `tuxlsx`, `tucsv` und
`tujson`, oder die Umgebungsvariable `TCLUTILS_TM` zeigt auf
das Modulverzeichnis einer tclutils-Ablage (das Verzeichnis, das den
Ordner `tclutils/` enthält):

```bash
TCLUTILS_TM=/opt/tclutils/lib/tm tclsh mdserver.tcl --root /srv/md
```

---

## Health

Standardpfad `/__mdserver/health`. Für eine Probe hinter nginx oder in
einer Unit. Antwort `200 ok`, oder `503 root unreadable`, wenn `--root`
kein lesbares Verzeichnis mehr ist.

---

## Zusammenfassung

- `--root` ist der Dokumentenbaum.
- Hinter Proxy: Loopback, trusted-proxy, Control-Port.
- Ohne `--bind` nur dieser Rechner; `--bind '*'` öffnet bewusst für das
  Netz, und die Startmeldung warnt.
- mdstack und docir: Nachbarordner, `MDSTACK_LIB`/`DOCIR_TM` oder alle
  Module in `lib/` neben dem Skript, mit den Unterordnern `mdserver/`,
  `mdstack/` und `docir/`.
- PDF-Suche: tclutils in `lib/` oder über `TCLUTILS_TM`.

---

*Nächstes Kapitel: [Optionen](030-optionen.md)*
