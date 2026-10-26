# Dokument und Seite

## Einführung

Ein [Dokument]{.index} entsteht im Konstruktor. Jede Seite beginnt mit
`startPage` und endet mit `endPage`. Optionen am Konstruktor gelten
als Default; `startPage` darf Papier, Rand und Ausrichtung überschreiben.

---

## Konstruktor

```tcl
set pdf [::pdf4tcl::new %AUTO% \
        -paper a4 \
        -orient 1 \
        -margin 50 \
        -compress 1]
```

Häufige Optionen:

| Option | Default | Bedeutung |
|--------|---------|-----------|
| `-paper` | `a4` | Formatname oder `{breite höhe}` |
| `-orient` | `1` | Y von oben |
| `-landscape` | `0` | Breite und Höhe tauschen |
| `-margin` | `0` | einer, zwei oder vier Werte |
| `-unit` | `p` | `p`, `mm`, `cm`, `i` |
| `-compress` | `1` | Content-Streams packen |
| `-cmyk` | `0` | DeviceCMYK statt RGB |
| `-pdfa` | `""` | Konformitätsstufe, siehe [PDF/A](130-pdfa.md) |
| `-userpassword` | `""` | siehe [Verschlüsselung](110-verschluesselung.md) |

Papiergrößen: A-Serie, seit 0.9.4.25 auch B- und C-Serie sowie 4A0
und 2A0. A3-Höhe ist **1191.0** pt (vorher 1190.0). Tests, die die
alte Zahl fest eintragen, an `getPaperSize` hängen.

```tcl
lassign [pdf4tcl::getPaperSize a3] w h
lassign [$pdf getPageSize] pw ph
```

`getPageSize` liefert die aktuelle Seite in der Dokumenteinheit.

---

## Seite

```tcl
$pdf startPage
# zeichnen
$pdf endPage
$pdf startPage -paper a5 -margin 20
# zweite Seite kleiner
$pdf endPage
```

`startPage` bei offener Seite ruft `endPage` selbst. Eine noch offene
[Ebene]{.index} (`beginLayer` ohne `endLayer`) lehnt `endPage` ab.

---

## Schreiben

```tcl
$pdf write -file bericht.pdf
$pdf write -chan $ch
$pdf write
```

`-file` öffnet und schließt die Datei. `-chan` schreibt in einen
offenen Kanal (seit 0.9.4.25). Ohne Option geht die Ausgabe nach
stdout. Danach `destroy`.

`finish` schließt das Dokument; `write` ruft das intern. Nach
`finish` nicht weiterzeichnen.

---

## Rand und Ursprung

`-margin 50` setzt alle vier Seiten. Zwei Werte: links/rechts,
oben/unten. Vier Werte: links, rechts, oben, unten — in der
Dokumenteinheit.

Mit `-orient 1` ist `-x 0 -y 0` die obere linke Ecke des Satzspiegels,
nicht der Papierecke. Ohne Rand fallen beide zusammen.

---

## Zusammenfassung

- Konstruktor setzt Defaults; `startPage` darf abweichen.
- `-orient 1`: Y oben. Einheit Default Punkt.
- `write -file` oder `write -chan`, dann `destroy`.

---

*Nächstes Kapitel: [Text und Standardschriften](030-text-und-standardschriften.md)*
