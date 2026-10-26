# API

Kurzreferenz pdf4tcl 0.9.4.69, Links im Dokument aus 0.9.4.72.
Optionen unvollständig; die Manpage bleibt die Norm.

---

## Paket und Objekt

```tcl
package require pdf4tcl 0.9.4.69
set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient 1 -margin 50]
$pdf startPage
$pdf endPage
$pdf write -file out.pdf
$pdf destroy
```

Konstruktor (Auswahl): `-paper -orient -landscape -margin -unit
-compress -cmyk -pdfa -pdfa-icc -markstyle -userpassword
-ownerpassword -encversion -permissions`.

`write -file` / `-chan`. Warnungen: `::pdf4tcl::warnings`.

---

## Text und Schrift

```tcl
$pdf setFont 12 Helvetica
$pdf text "Zeile" -x 0 -y 24
$pdf drawTextBox x y w h $txt -align left -newyvar nextY
$pdf getStringWidth $txt
$pdf getStringWidth $txt -font Helvetica -size 12
$pdf getSubstCount

pdf4tcl::loadBaseTrueTypeFont Base datei.ttf
pdf4tcl::createFont Base Body iso8859-1
pdf4tcl::createFontSpecEnc Base Body $codepoints
pdf4tcl::createFontSpecCID Base Uni
```

---

## Grafik

```tcl
$pdf setFillColor red
$pdf setStrokeColor 0 0 0
$pdf setLineWidth 1
$pdf setAlpha 0.5
$pdf line x1 y1 x2 y2
$pdf rectangle x y w h -filled 1
$pdf circle x y r
$pdf gsave
$pdf clip x y w h
$pdf linearGradient x1 y1 x2 y2 c1 c2
$pdf translate dx dy
$pdf rotate winkel
$pdf scale sx sy
$pdf grestore
```

---

## Bilder und Canvas

```tcl
set id [$pdf addImage datei.png -id logo]
$pdf putImage $id x y -width 120
$pdf canvas .c -bbox $bb -x 50 -y 50 -width 400 -height 300 \
        -sticky nw -fontmap {DocText Uni}
```

---

## Formular, Annotation, Ebene

```tcl
$pdf addForm text x y w h -id name -init "" -maxlen 8 -comb 1
pdf4tcl::getForms in.pdf
pdf4tcl::fillForms in.pdf out.pdf {name Wert}
pdf4tcl::exportForms in.pdf out.fdf

$pdf addAnnotStamp x y w h -name Approved
$pdf addAnnotNote x y w h -content "…"
$pdf addAnnotLine x1 y1 x2 y2
$pdf hyperlinkAdd x y w h url                  ;# Adresse
$pdf destinationAdd name ?-y y? ?-x x?         ;# Ziel (0.9.4.72)
$pdf linkAdd x y w h name                      ;# Sprung (0.9.4.72)

set l [$pdf addLayer "Gitter" -visible 0 -print 0]
$pdf beginLayer $l
$pdf endLayer
```

---

## Zusammenfügen, Metadaten, PDF/A

```tcl
pdf4tcl::catPdf -title "Gesamt" a.pdf b.pdf out.pdf
$pdf metadata -title "…" -author "…"
$pdf viewerPreferences -displaydoctitle 1
$pdf tagged 1 -lang de-DE -ua 1
$pdf addEmbeddedFile name.txt -contents $bytes -mimetype text/plain
```

Konstruktor `-pdfa 1b|2b|3b|1a|2a|3a|2u|3u`.
`-encversion 4` AES-128, `5` AES-256.

---

*Nächstes Kapitel: [Glossar](820-anhang-glossar.md)*
