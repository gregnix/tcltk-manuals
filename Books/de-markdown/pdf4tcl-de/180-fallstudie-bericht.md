# Fallstudie: Bericht

## Einführung

Ein einseitiger Bericht: CID-Schrift, Kopf, drei Kennzahlen, ein
Formularfeld, Stempel. Die Teile kommen aus den vorigen Kapiteln,
hier in einem Ablauf.

---

## Schrift und Dokument

```tcl
package require pdf4tcl 0.9.4.69

pdf4tcl::loadBaseTrueTypeFont BaseDejaVu \
        /usr/share/fonts/truetype/dejavu/DejaVuSans.ttf
pdf4tcl::createFontSpecCID BaseDejaVu Bericht

set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient 1 -margin 48 \
        -userpassword "lesen" -ownerpassword "setzen" \
        -permissions {print}]
$pdf metadata -title "Monatsbericht März 2026" -author "Muster GmbH"
$pdf startPage
$pdf setFont 16 Bericht
```

Verschlüsselung plus CID: seit 0.9.4.67 lesbar. User darf drucken,
nicht kopieren.

---

## Kopf und Kennzahlen

```tcl
$pdf text "Monatsbericht März 2026" -x 0 -y 8
$pdf setFont 10 Bericht
$pdf text "Muster GmbH — intern" -x 0 -y 28

$pdf setStrokeColor 0.2 0.2 0.2
$pdf setLineWidth 0.5
$pdf line 0 40 500 40

set kasten {{Umsatz 128} {Aufträge 41} {Offen 7}}
set x 0
foreach paar $kasten {
    lassign $paar label wert
    $pdf setFillColor 0.93 0.93 0.93
    $pdf rectangle $x 56 150 48 -filled 1
    $pdf setFillColor 0 0 0
    $pdf text $label -x [expr {$x+10}] -y 64
    $pdf setFont 18 Bericht
    $pdf text $wert -x [expr {$x+10}] -y 84
    $pdf setFont 10 Bericht
    incr x 170
}
```

Nach grauer Füllung die Füllfarbe auf Schwarz zurücksetzen, sonst
erbt der Text Grau.

---

## Feld und Stempel

```tcl
$pdf text "Freigabe:" -x 0 -y 130
$pdf addForm text 80 120 200 16 -id freigabe -maxlen 24

$pdf addAnnotStamp 400 500 90 28 -name Approved -color {0.2 0.5 0.2}
```

`setFont` stand schon. Ohne Schrift bliebe der Stempel in PDFium
leer ([Annotationen](100-annotationen.md)).

```tcl
$pdf endPage
$pdf write -file bericht.pdf
$pdf destroy
```

---

## Später füllen

`fillForms` und `getForms` lesen verschlüsselte Dateien nicht
(kein `-password`). Auf der AES-`bericht.pdf` von oben schlägt
`fillForms` mit `no such field(s) … freigabe` fehl. Für den
Fill-Schritt dieselbe Zeichnung **ohne**
`-userpassword`/`-ownerpassword` schreiben:

```tcl
# Konstruktor ohne Kennwörter, sonst wie oben …
$pdf write -file bericht-offen.pdf
$pdf destroy
pdf4tcl::fillForms bericht-offen.pdf bericht-frei.pdf \
        {freigabe "Müller, 28.03."}
```

Einfaches Textfeld: Appearance wird neu gebaut (0.9.4.64).
NeedAppearances bleibt aus, der Rahmen eines unberührten Kästchens
— hier keines — ginge nicht verloren.

Prüfen:

```bash
qpdf --check bericht-frei.pdf
pdftotext bericht-frei.pdf -
```

---

## Was bewusst fehlt

- Seitenumbruch und Tabelle: `pdf4tcllib`
- PDF/A: Base-14 weglassen, `-pdfa 2b`, `metadata` bleibt
- Zweite Seite per `catPdf` mit Anhang
- Comb-Feld ohne MaxLen: nicht füllen und Appearance erwarten

Das ist der Kern, den die Howtos zerlegen. Hier steht er als eine
Anwendung.

---

## Zusammenfassung

- CID laden, Dokument mit AES, Kopf zeichnen, Feld, Stempel, schreiben.
- fillForms für das Textfeld; Stempel nur nach setFont.
- Layout über Seiten: nicht in diesem Paket.

---

*Nächstes Kapitel: [Fallen](800-anhang-fallen.md)*
