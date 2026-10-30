# tkdevtools

## Die App

[tkdevtools]{.index} (`apps/tkdevtools/tkdevtools.tcl`) ist ein
Nachschlage- und Probier-Browser für Tk-Entwicklung: Referenztabellen,
Cheat-Sheets und Proben in einer App mit Navigationsbaum. Reine Anzeige —
im normalen Betrieb schreibt die App keine Dateien, nur die
Zwischenablage. Ausnahme ist der Screenshot-Modus.

```bash
wish apps/tkdevtools/tkdevtools.tcl
tclsh apps/tkdevtools/tkdevtools.tcl --shot out.png shadow
```

Der Screenshot-Modus rendert ein Werkzeug (Schlüssel wie `shadow`,
`colors`, `regexp`) in eine PNG-Datei mit 900×600 Pixeln und beendet sich.
Er braucht das Paket `img::window` (Img); fehlt es, versucht die App
ImageMagicks `import -window root`. Ohne Schlüssel bleibt das erste
Werkzeug (*Tcl / Tk*) gewählt.

Mit `tclsh` und den Schlüsseln `shadow`, `colors` und `regexp` entstehen
drei PNG mit 900×600 Pixeln, Exit-Code 0.

Voraussetzungen: Tcl/Tk 8.6 oder 9.x, mindestens **tclutils 0.64.0**
(`tucolor`, `tustr` 0.2, `tudate` 0.2, `tupkgfinder` 0.2, `tuappinfo`,
`tupath`, `tunum` 0.4; empfohlen 0.69.0), aus tkutils `tkutablelist` ab 0.4
und `tkuunits`, dazu Tablelist. Die App lädt `tablelist_tile` vor
`tkutablelist`; die Helfer `tkutl*` nehmen dieselbe Variante (Kapitel
[tkutils verstehen](010-tkutils-verstehen.md)). Die Helfer
`tkutlsort`, `tkutlfind`, `tkutlclip` werden genutzt, wenn vorhanden.
Mit `tkutlclip` 0.3 (tkutils 0.49.0) kopiert Strg+C in den Tabellen die
markierten Zeilen als TSV; vorher überschrieb die eigene Bindung von
Tablelist die Zwischenablage. Die
Bibliotheken findet die App über `apps/_lib/paths.tcl` (dieselbe Logik wie
`tools/setup.tcl`).

Der Knopf *Copy report* im Werkzeug *Tcl / Tk* kopiert einen
Umgebungsbericht (`tuappinfo::buildReport`) in die Zwischenablage.

---

## Die Werkzeuge

| Gruppe | Werkzeuge |
|---|---|
| Runtime | Tcl / Tk, OS / platform, Packages, **Package shadows**, Paths, Display, Environment, Channels, Photo formats, External tools |
| Reference | Colors, Characters, Graphemes, Fonts, Bitmaps, **Font aliases** |
| Conversion / time | Units, Timezones, clock format, **Number format** |
| Platform | **Paths**, **glob**, **Programs**, **Encoding profiles** |
| Tk widgets / style | Widget tree, Clipboard, Cursors, Relief / Anchor, Keysym probe, ttk Themes, Widget explorer |
| Layout | pack, grid |
| Text / patterns | regexp, format / scan, Encodings, Virtual events |

Fett: seit 0.46.0. *Paths* gibt es zweimal: unter *Runtime* die
Suchpfade (`auto_path`, `tcl_pkgPath`, `tcl::tm::path`, Encoding-Ordner),
unter *Platform* die Pfadprobe.

---

## Werkzeuge seit 0.46.0

**Package shadows.** Jede Kopie eines Pakets in Modulpfaden und
`auto_path` (`tupkgfinder::shadows`). Rot markiert ist eine zweite Kopie
derselben Version, die nie geladen wird — etwa eine Installation neben dem
Arbeitsbaum. Die Zeile ist hellrot hinterlegt, die aktive Kopie grün
geschrieben, andere Versionen grau. Welche gewinnt, hängt von der
Pfadreihenfolge ab.

**Paths (Platform).** `file pathtype`, `split`, `dirname`, `normalize`,
`nativename` und `tupath::clean` für einen Pfad, dazu die Einordnung nach
Windows- und Unix-Regeln (`/x` und `C:x` sind unter Windows
volumerelativ).

**glob.** Was ein Muster in einem Verzeichnis trifft, mit `-types`. Zeigt,
wie viele Punkt-Dateien `*` hier auslässt; unter Windows trifft `*` sie,
und `*` plus `.*` liefert sie doppelt — der Fehler, den `tkufiletree`
behoben hat (Kapitel [Datei-Widgets](040-datei-widgets.md)).

**Programs.** `auto_execok` für einen Namen und die PATH-Einträge mit
Treffern; Trennzeichen und unter Windows PATHEXT.

**Encoding profiles.** Bytes (hex) in einer Kodierung mit den Profilen
`strict`, `replace` und `tcl8` gelesen (Tcl 9). `strict` bricht beim ersten
ungültigen Byte ab, wie ein Kanal mit Standardprofil. Unter Tcl 8.6 gibt es
keine Profile; die Tabelle zeigt dann eine Zeile `(8.6)` mit dem Ergebnis
ohne Fehler.

**Font aliases.** Was Tk aus Helvetica, Times, Courier, Arial und den
`Tk*Font`-Namen macht (Familie, Größe, Metriken). Gelb: der Name kommt
unverändert zurück (Tk 9 unter Windows bei Helvetica) und kann in einem
PDF-Export mit der gleichnamigen Standardschrift zusammenfallen. Die Zeile
ist dann gelb hinterlegt.

**Number format.** Dieselben Werte mit `format %.Nf` (Rundung der
C-Laufzeit; glibc und Windows unterscheiden sich bei x,5) und
`tunum::format` (kaufmännisch, 0,5 weg von null), dazu der gespeicherte
double-Wert.

---

## Zusammenfassung

- tkdevtools: Referenz und Proben, schreibt nichts.
- Seit 0.46.0: Package shadows, Paths, glob, Programs, Encoding profiles,
  Font aliases, Number format.
- Braucht mindestens tclutils 0.64.0 (empfohlen 0.69.0) und Tablelist.
- `--shot` braucht Img (`img::window`) oder ImageMagick.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 (Img 1.4.16) und 9.0.4 (Img 2.1.1) unter
Linux und Xvfb: `--shot` mit `shadow`, `colors` und `regexp`.

**Nicht getestet:** Anzeige der Kodierungsprofile unter Tcl 9,
Schrift-Aliase unter Windows.
:::

---

*Nächstes Kapitel: [Grenzen](090-grenzen.md)*
