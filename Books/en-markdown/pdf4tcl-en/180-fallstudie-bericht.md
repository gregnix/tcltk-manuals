# Case Study: Report

## Introduction

A one-page report: CID font, header, three key figures, a form field,
a stamp. The parts come from the previous chapters, here combined in
one sequence.

---

## Font and Document

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

Encryption plus CID: readable since 0.9.4.67. The user may print,
not copy.

---

## Header and Key Figures

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

After a gray fill, reset the fill color to black; otherwise the text
inherits the gray.

---

## Field and Stamp

```tcl
$pdf text "Freigabe:" -x 0 -y 130
$pdf addForm text 80 120 200 16 -id freigabe -maxlen 24

$pdf addAnnotStamp 400 500 90 28 -name Approved -color {0.2 0.5 0.2}
```

`setFont` was already set. Without a font the stamp would stay empty
in PDFium ([Annotations](100-annotationen.md)).

```tcl
$pdf endPage
$pdf write -file bericht.pdf
$pdf destroy
```

---

## Filling Later

`fillForms` and `getForms` do not read encrypted files (no
`-password`). On the AES-encrypted `bericht.pdf` from above,
`fillForms` fails with `no such field(s) … freigabe`. For the fill
step, write the same drawing **without**
`-userpassword`/`-ownerpassword`:

```tcl
# Konstruktor ohne Kennwörter, sonst wie oben …
$pdf write -file bericht-offen.pdf
$pdf destroy
pdf4tcl::fillForms bericht-offen.pdf bericht-frei.pdf \
        {freigabe "Müller, 28.03."}
```

Simple text field: the appearance is rebuilt (0.9.4.64).
NeedAppearances stays off, so the border of an untouched check box —
there is none here — would not be lost.

Check:

```bash
qpdf --check bericht-frei.pdf
pdftotext bericht-frei.pdf -
```

---

## What Is Deliberately Missing

- Page breaks and tables: `pdf4tcllib`
- PDF/A: drop Base-14, `-pdfa 2b`, `metadata` stays
- A second page with an attachment via `catPdf`
- Comb field without MaxLen: do not fill it and expect an appearance

This is the core that the how-tos take apart. Here it stands as one
application.

---

## Summary

- Load CID, document with AES, draw the header, field, stamp, write.
- fillForms for the text field; stamp only after setFont.
- Layout across pages: not in this package.

---

*Next chapter: [Pitfalls](800-anhang-fallen.md)*
