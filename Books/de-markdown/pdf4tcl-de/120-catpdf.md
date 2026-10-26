# catPdf

## Einführung

[`catPdf`]{.index} hängt fertige PDFs aneinander. Kein Dokumentobjekt.
Seit 0.9.4.40 bleibt die logische Struktur erhalten. Seit 0.9.4.44
werden Formulare vereinigt.

---

## Rezept

```tcl
package require pdf4tcl 0.9.4.69
pdf4tcl::catPdf teil1.pdf teil2.pdf gesamt.pdf
```

Optionen **vor** den Dateinamen (seit 0.9.4.48):

```tcl
::pdf4tcl::catPdf -title "Gesamtdatei" -author "" \
        teil1.pdf teil2.pdf gesamt.pdf
```

`-title -author -subject -keywords -creator -producer`. Leerer Wert
löscht den Eintrag. Nicht genannte Einträge behalten, was das erste
Dokument hatte.

Seit 0.9.4.51 stehen die Werte in `/Info` **und** im XMP. Vorher nur
`/Info` — Acrobat (XMP bevorzugt) zeigte weiter den Titel von Teil 1.
Das Paket wird **editiert, nicht neu gebaut**, damit Erweiterungsschemata
(etwa Factur-X `fx:`) erhalten bleiben.

ISO 19005-1 Klausel 6.7.3 verlangt Gleichheit von `/Info` und XMP.
Prüfen gegen **1b**, nicht 2b: PDF/A-2/3 haben die Regel fallen lassen.
Dieselbe inkonsistente Datei: veraPDF 1b FAIL, 2b PASS.

---

## Getaggt mischen

Beide Eingaben getaggt: ein Strukturbaum, Elemente des zweiten
Dokuments an das erste gehängt. Seitenmarker bleiben.

Getagt plus ungetagt geht nicht sauber. pdf4tcl schreibt gültiges PDF
und hängt an `::pdf4tcl::warnings`:

- getagt + ungetagt → spätere Seiten außerhalb des Baums
- ungetagt + getagt → Struktur des zweiten Dokuments fällt weg

Vorher alle Teile gleich taggen.

---

## Formulare (0.9.4.44)

Die Feldliste ist die Vereinigung. Vorher überlebte nur das Formular
des ersten Dokuments: Widgets der anderen saßen auf den Seiten, kein
Leser bot sie zum Füllen an.

**Namen werden nicht eindeutig gemacht.** Zwei Felder desselben Namens
sind ein Feld mit einem gemeinsamen Wert (ISO 32000-1 12.7.3.2).
Kollision steht in `::pdf4tcl::warnings`.

---

## XRef-Streams

Objektverzeichnis als Stream (PDF 1.5+): ISO 19005-1 verbietet die
Form, PDF/A-2 und -3 verlangen sie. Seit 0.9.4.49/50 liest catPdf
beides, inklusive Object-Streams.

| Eingabe | Zusammenfügen |
|---------|---------------|
| gewöhnliches PDF aus pdf4tcl | ja |
| PDF/A-1b | ja |
| PDF/A-2b, -3b, -3a | seit 0.9.4.49 |
| Objekte in Containern | seit 0.9.4.50 |

`qpdf --object-streams=generate` ohne `--newline-before-endstream`
verletzt ISO 19005-2 6.1.7.1. Die **Eingabe** fällt in veraPDF durch,
also auch das Ergebnis — pdf4tcl reicht Streams unverändert durch.

---

## Grenzen

- Fontdictionaries bleiben verdoppelt; identische Font-Streams werden
  geteilt.
- Katalog- und Pages-Objekte angehängter Dokumente bleiben als tote
  Objekte (wenige hundert Byte).
- Waisen (unerreichbare `/Info` der angehängten Dateien) fallen seit
  0.9.4.50 weg.

---

## Zusammenfassung

- `catPdf ?optionen? eingabe … ausgabe`.
- Titel seit 0.9.4.48, XMP seit 0.9.4.51.
- Struktur seit 0.9.4.40, Formulare seit 0.9.4.44, XRef-Stream seit
  0.9.4.49.

---

*Nächstes Kapitel: [PDF/A](130-pdfa.md)*
