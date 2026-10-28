# Starten

## Einführung

Arbeitsverzeichnis: `mdstack/tools/mdserver/` oder ein Pfad, der
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

Ohne `--bind` horcht der Prozess auf **allen** Schnittstellen. Der Port
ist dann ohne Anmeldung erreichbar. Die Startmeldung sagt es:
`0.0.0.0:8080 (alle Schnittstellen)`.

Ohne `--style` gilt `site`, das ganze Seitenlayout. Das frühere
Aussehen gibt `--style plain`.

---

## Lokal zum Lesen

```bash
tclsh mdserver.tcl --root ../../docs --port 8080
```

Dann `http://127.0.0.1:8080/`. Startseite: `index.md` in der Wurzel.
Fehlt sie, zeigt `site` die Ordner und Dokumente als Kacheln.

---

## Module finden

Der [Launcher]{.index} `mdserver.tcl` hängt vor dem
`package require mdserver 0.4` diese Ordner an den Modulpfad, relativ
zum Skript und nur, wenn es sie gibt:

| Pfad | Inhalt |
|---|---|
| `lib` | `mdserver-0.4.tm` und `pdftext-worker.tcl`, bei einer Installation alle Module |
| `../lib` | Alternative für eine eigene Ablage |
| `../../lib` | das `lib/` von mdstack (`mdstack::parser`, `::html`, `::theme`) |
| `../../../docir/lib/tm` | ein docir-Repo neben mdstack |

Aus dem Repo läuft der Server damit ohne `TCLLIBPATH`, wenn `docir/`
neben `mdstack/` liegt:

```
arbeit/
  mdstack/
    lib/mdstack/...
    tools/mdserver/mdserver.tcl
  docir/
    lib/tm/docir-0.1.1.tm
    lib/tm/docir/...
```

Für eine Installation außerhalb des Repos gehört alles in das `lib/`
neben dem Skript. Genau diese Dateien, kein ganzes mdstack:

```
mdserver/
  mdserver.tcl
  mdctl.tcl
  mkcert.tcl
  styles/
    site.css
    sidebar.css
    sticky-top.css
    collapsible.css
  lib/
    mdserver-0.4.tm
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

Die Unterordner `mdstack/` und `docir/` sind Teil des Paketnamens:
für `docir::html` sucht Tcl die Datei `docir/html-0.2.tm`. Flach nebeneinander
gelegt findet `package require` sie nicht.

Für die PDF-Suche kommt tclutils dazu. Der Launcher sucht es nicht
selbst: entweder liegen `tclutils/common-0.2.tm`,
`tclutils/tupdftext-0.1.tm` und `tclutils/tutask-0.2.tm` ebenfalls in
`lib/` (`tupdftext` und `tutask` laden `common`), oder die Umgebungsvariable `TCLUTILS_TM` zeigt auf
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
- Leer gelassenes `--bind` ist eine bewusste Öffnung, kein Default für
  das LAN.
- Installation: alle Module in `lib/` neben dem Skript, mit den
  Unterordnern `mdstack/` und `docir/`.
- PDF-Suche: tclutils in `lib/` oder über `TCLUTILS_TM`.

---

*Nächstes Kapitel: [Optionen](030-optionen.md)*
