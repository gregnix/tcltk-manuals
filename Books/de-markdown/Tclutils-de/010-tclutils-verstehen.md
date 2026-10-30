# tclutils verstehen

## Einführung

[tclutils]{.index} ist eine Sammlung kleiner Pure-Tcl-Module ohne Tk:
Textfilter, Datenformate, Provider, HTTPS-Politik, Einstellungen,
Hintergrundaufgaben (`tutask`) und ein Test-Runner. Der Kern braucht nur
Tcl selbst (`zlib` für ZIP gehört zu Tcl). Die Module verlangen
`package require Tcl 8.6-` und laufen damit unter Tcl **8.6** und
**9.x**.

Dieses Handbuch beschreibt tclutils **0.69.0**. Es richtet sich an
Server-, CLI- und CI-Programme ohne Tk und an Anwendungen, die die
Engines unter tkutils und ctrlutils nutzen.

---

## Abhängigkeiten

Einige optionale Module brauchen mehr, und zwar erst beim Aufruf:

| Modul | braucht |
|---|---|
| `tufetch` | `tls` oder ein `curl`/`wget`-Binary |
| `tuhttps`, `tudav`, `tupostgrest` | `tls` für HTTPS |
| `tuprovider::ftp` | tcllib-Paket `ftp` (erst bei `open ftp …`) |
| `tuprovider::sftp` | OpenSSH-`sftp`, eigenes `package require` |
| `tusqlite` / `tutdbc` | ein vom Aufrufer geöffnetes sqlite3- bzw. TDBC-Handle |
| `tutask` (nur `pool`) | Paket `Thread` (erst beim ersten `pool`) |

`package require tclutils` lädt auch ohne tls und Thread. tcllib-`ftp`
verlangt `tuprovider::ftp` erst bei `open ftp …`, nicht beim Laden des
Umbrella.

---

## Rolle

| Stück | Rolle |
|---|---|
| Präfix | `tu*` / Namespace `tclutils::…` |
| Schicht | Model — Logik ohne GUI |
| Geschwister | tkutils (View), ctrlutils (Controller) |
| Laden | `package require tclutils` oder Einzelmodul |

```
tclutils = Model · tkutils = View · ctrlutils = Controller
```

Die GUI-Schicht und die Controller beschreiben die Bücher *tkutils* und
*Utils-Stack*. Dieses Buch behandelt Engines, Pfade, Provider,
Einstellungen, Tasks und Tests.

---

## Abgrenzung

- Keine Abschrift aller `docs/*.md`; die Detail-API steht dort, im
  tclutils-Baum.
- Kein Ersatz für *Pakete und Module* (`.tm`-Mechanik allgemein).
- Kein Dateimanager: Dateiblick und Explorer beschreibt *Utils-Stack*.

---

## Aufbau

Kapitel 2 und 3 behandeln Installation und Module. Danach folgen Text
und Dateien, Zeichen und Pfade, Datenformate, TDBC und MaxMind,
Kodierung und Hash,
Notizen und Kalender, PDF-Text, ODF und PDF-Struktur, Diagramme,
Provider, Netz und HTTPS,
Einstellungen, `tutask`, die Tests und die Grenzen. Die
Anhänge enthalten Fallen (A), die Modulliste (B), das Glossar (C),
Fehlermeldungen (D), den API-Katalog (E) und Praxisbeispiele (F).

---

## Merkliste

- Pure Tcl, kein Tk, Version 0.69.0.
- Kern ohne Fremdpakete; tls, tcllib-`ftp`, curl/wget, Thread nur für
  optionale Module bzw. den Pool von `tutask`.
- Pairing laut CHANGELOG von tkutils 0.49.0: tclutils 0.69.0 + tkutils
  0.49.0 + ctrlutils 0.5. tkutils 0.49.0 braucht mindestens tclutils
  0.64.0, den CSV-Export von `tkutablelist` erst mit 0.69.0.

---

*Nächstes Kapitel: [Installation](020-installation.md)*
