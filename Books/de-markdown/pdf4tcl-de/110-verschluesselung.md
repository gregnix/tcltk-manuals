# Verschlüsselung

## Einführung

Kennwort am Konstruktor schaltet [AES]{.index} ein. AES-128
(`-encversion 4`, Default seit 0.9.4.11) und AES-256
(`-encversion 5`, seit 0.9.4.16). Ohne Kennwort bleibt die Datei offen.

---

## AES-128

```tcl
set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient 1 \
        -userpassword "oeffnen" \
        -ownerpassword "aendern" \
        -permissions print]
$pdf startPage
$pdf setFont 12 Helvetica
$pdf text "Vertraulich." -x 50 -y 50
$pdf endPage
$pdf write -file geheim.pdf
$pdf destroy
```

Leeres `-ownerpassword`: das User-Kennwort gilt für beide.
`-permissions` nimmt symbolische Listen, Presets oder eine rohe
`/P`-Zahl. Default wirkt als „alles erlaubt“.

| Kennwort | Wirkung |
|----------|---------|
| user | öffnet; `/P` gilt |
| owner | volle Rechte; `/P` ignoriert |

`-permissions` allein sperrt die Datei **nicht**. Ohne User-Kennwort
öffnet jeder Viewer; `/P` ist Hinweis an konforme Leser.

---

## AES-256

```tcl
set pdf [::pdf4tcl::new %AUTO% -paper a4 \
        -userpassword "oeffnen" -ownerpassword "aendern" \
        -encversion 5]
```

Braucht ein SHA-384-Backend. Rein-Tcllib ist langsam (Sekunden statt
Millisekunden). In Produktion ein schnelles Krypto-Paket vorziehen.

---

## CID-Schriften: WriteObjectDirect (0.9.4.67)

Bis **0.9.4.66** liefen die fünf Objekte von `WriteCIDFontObjects`
am Encrypt vorbei gerade in die Datei. Das Dokument entstand, war
ohne Kennwort dicht — und **mit** Kennwort unlesbar:

```
qpdf: inflate: incorrect header check
pdftotext -upw … : (leer)
```

Der Font-Stream war bytegleich zur unverschlüsselten Datei. Ein
Leser, der `/Encrypt` gehorcht, entschlüsselt ihn trotzdem und
erhält Müll.

Seit **0.9.4.67** schreibt `WriteObjectDirect` dieselben Objekte
über Encrypt (Strings und Stream, Schlüssel an der Objektnummer).
Workarounds (Standardschrift in verschlüsselter Ausgabe) können weg.
Dateien aus .66 neu erzeugen — der Inhalt steht im Klartext in der
alten Datei, der eingebettete Font ist für den Leser tot.

XMP-Metadaten liefen bis .66 ebenfalls im Klartext, während die
Datei `/EncryptMetadata true` behauptet. `qpdf --check` fängt das
nicht: der Stream ist unkomprimiert, es gibt kein inflate.

---

## Prüfen

```bash
qpdf --password=oeffnen --check geheim.pdf
pdftotext geheim.pdf -                 # Incorrect password
pdftotext -upw oeffnen geheim.pdf -    # Text
```

Alle drei zählen. Die ersten zwei allein bestehen auch bei einer
verschlüsselten, aber kaputten Datei — genau das, was 0.9.4.66
erzeugte.

---

## Zusammenfassung

- AES-128: `-encversion 4`. AES-256: `-encversion 5`.
- User-Kennwort zum Öffnen, Owner für volle Rechte.
- CID plus Encrypt: erst ab 0.9.4.67 lesbar. Alte Dateien neu bauen.

---

*Nächstes Kapitel: [catPdf](120-catpdf.md)*
