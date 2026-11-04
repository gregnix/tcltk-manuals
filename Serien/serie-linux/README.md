# Serie: linux

Howto-Serie zu **Tcl/Tk unter Linux** — Pfade, XDG, Umgebung, exec, Encoding.
Kein Desktop-Spezifisches (dafür: **`serie-xfce`**).

## Voraussetzungen

- Linux
- Tcl 8.6+ (`tclsh`; Kapitel 11 optional `wish`)

## Start

```bash
tclsh howto/01-erste-schritte.tcl
tclsh run-all.tcl
```

## Struktur

| Datei | Inhalt |
|--------|--------|
| `_bootstrap.tcl` | Linux-Check, XDG-Hilfsprocs |
| `howto/00-referenz.md` | Kurzreferenz |
| `howto/NN-….md` / `.tcl` | Erklärung und Demo |
| `TUTORIAL.md` | Lernpfad |

## Handbuch vs. Serie

- XFCE vertiefen: `serie-xfce/`
- GUI-Tests ohne Bildschirm: `serie-xvfb/`
- Buch: *Tcl/Tk unter Linux* ([Markdown](../../Books/de-markdown/Linux-TclTk-de/), [PDF](../../Books/de-pdf/Linux-TclTk-de.pdf)).

## Gemessen (Linux, Tcl 8.6.18, Debian forky)

- `encoding system` folgt `LANG` (`C` → iso8859-1, `C.UTF-8` → utf-8); `file volumes` → `/`
- Config: `XDG_CONFIG_HOME` oder `~/.config` (nicht Windows-`APPDATA`)
- `$env(HOME)` ist gesetzt (Gegensatz zu Windows)
- `tcl_platform(user)` kann von `$env(USER)` abweichen (effective uid)
- `xdg-open` für Dateien/URLs; nicht in `SERIES_AUTO` aufrufen
