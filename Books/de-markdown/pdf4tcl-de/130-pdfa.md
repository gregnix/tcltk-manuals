# PDF/A

## Einführung

[`-pdfa`]{.index} am Konstruktor setzt die Konformitätsstufe.
Ohne eingebettete Schrift fällt die Datei in veraPDF durch — Base-14
reicht nicht.

---

## Stufe B

```tcl
pdf4tcl::loadBaseTrueTypeFont BaseDejaVu /pfad/DejaVuSans.ttf
pdf4tcl::createFont BaseDejaVu Body iso8859-1

set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient 1 -margin 50 \
        -pdfa 2b]
$pdf metadata -title "Archivprobe" -author "pdf4tcl"
$pdf startPage
$pdf setFont 12 Body
$pdf text "Diese Datei behauptet PDF/A-2b." -x 0 -y 24
$pdf endPage
$pdf write -file archiv-2b.pdf
$pdf destroy
```

Optional: `-pdfa-icc /pfad/srgb.icc`. Sonst sucht pdf4tcl ein Profil.

| Stufe | Typischer Einsatz |
|-------|-------------------|
| `1b` / `1a` | älteres Archiv; keine Transparenz; keine eingebetteten Dateien |
| `2b` / `2a` | modernes Archiv; XRef-Stream; PDF 1.7 |
| `3b` / `3a` | plus eingebettete Dateien (Factur-X / ZUGFeRD) |

`1b` schreibt `%PDF-1.4` und klassische xref-Tabelle. `2b`/`3b`:
XRef-Stream und `%PDF-1.7` (seit 0.9.4.22).

---

## Stufe U (seit 0.9.4.56)

Zwischen B und A: Erscheinung erhaltbar **und** Text als Unicode
extrahierbar, ohne Tagging.

```tcl
set pdf [::pdf4tcl::new %AUTO% -paper a4 -pdfa 3u]
```

Kein `1u`: die Stufe kam mit Teil 2. CID-Schriften tragen ToUnicode;
was B mit eingebetteter Schrift besteht, besteht U. Einsatz: Archiv
ohne Strukturbaum, typisch Scan plus OCR.

---

## Stufe A (seit 0.9.4.41)

A verlangt getaggtes PDF und Dokumentsprache. Beides wird bei
`finish` geprüft; fehlt eines, entsteht keine Datei mit falschem
`pdfaid:conformance A`:

```tcl
set pdf [::pdf4tcl::new %AUTO% -paper a4 -pdfa 3a]
$pdf tagged 1 -lang de-DE -ua 1
$pdf metadata -title "Zugängliches Archiv"
$pdf viewerPreferences -displaydoctitle 1
$pdf startPage
$pdf setFont 12 Body
$pdf tagText H1 "Titel" -x 0 -y 24
$pdf tagBegin P
$pdf text "Getaggter Fließtext." -x 0 -y 50
$pdf tagEnd
```

A prüft nicht, ob das Tagging sinnvoll ist — nur dass es da ist.
Jedes Absatz `/P` und jede Überschrift `/H1` validiert und sagt
einem Leser nichts Nützliches.

---

## Fallen

- Standardschrift unter `-pdfa`: Warnung seit 0.9.4.41, Datei fällt
  in veraPDF durch.
- `setAlpha` unter 1 mit PDF/A-1: Warnung seit 0.9.4.22.
- Eingebettete Dateien bei PDF/A-1: Fehler. Factur-X: `3b`/`3a`.
- Häkchen: Vektor unter Konformität, siehe
  [Formulare erzeugen](080-formulare-erzeugen.md).

```bash
verapdf -f 2b archiv-2b.pdf
verapdf -f 3a archiv-3a.pdf
verapdf -f ua1 archiv-3a.pdf
```

---

## Zusammenfassung

- `-pdfa 1b|2b|3b|1a|2a|3a|2u|3u`, immer mit eingebetteter Schrift.
- A: `tagged 1 -lang …` vor `finish`.
- U: Unicode ohne Strukturbaum.

---

*Nächstes Kapitel: [Ebenen](140-ebenen.md)*
