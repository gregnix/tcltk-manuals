# Formulare erzeugen

## Einführung

`addForm` legt AcroForm-Felder auf die aktuelle Seite. Der
[Appearance-Stream]{.index} entsteht beim Anlegen. Ein Dokument, das
in einem Durchgang mit Werten gebaut wird, braucht `fillForms` nicht.

Feldtext ist praktisch Base-14 / Latin-1. CID in AcroForm ist hart;
Umlaute in Beschriftungen auf der Seite als normaler `text` setzen.

---

## Textfeld und Schalter

```tcl
set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient 1 -margin 50]
$pdf startPage
$pdf setFont 12 Helvetica
$pdf text "Name:" -x 0 -y 40
$pdf addForm text 60 28 200 16 -id f_name

$pdf addForm pushbutton 0 70 90 20 -id f_reset \
        -caption "Reset" -action reset
$pdf addForm pushbutton 100 70 90 20 -id f_go \
        -caption "Submit" -action submit \
        -url "mailto:bestellung@example.com"
$pdf endPage
$pdf write -file formular.pdf
$pdf destroy
```

Typen: `text`, `password`, `checkbutton` (Alias `checkbox`),
`radiobutton`, `combobox`, `listbox`, `pushbutton`, `signature`.

`-id` nur Wortzeichen, kein Punkt. Verschachtelte Namen entstehen
im Feldbaum fremder Dateien, nicht beim Anlegen hier.

---

## Optionen

| Option | Wirkung |
|--------|---------|
| `-init` | Startwert, überall sichtbar |
| `-align` | `left` / `center` / `right` |
| `-multiline` | mehrzeilig |
| `-maxlen` / `-comb` | Kammfeld, Zellen = Breite / MaxLen |
| `-options` | Auswahlliste als Labels (kein Export/Label-Paar) |
| `-tooltip` | Kurzinfo |
| `-readonly` / `-required` | Flags |
| `-color` `-bgcolor` `-bordercolor` `-borderwidth` | Darstellung |
| `-layer` | `/OC` an der Annotation |
| `-format date` | Formatierung im Viewer |
| `-calculate` | Summe über Feld-IDs, braucht JS im Viewer |

`-comb 1` verlangt `-maxlen`, schließt `-multiline` aus, ehrt
`-align`. Seit 0.9.4.63.

`text`, `password`, `checkbutton` und `radiobutton` laufen vor
`setFont`. `combobox`, `listbox`, `pushbutton` und `signature`
verlangen eine gesetzte Schrift (Meldung seit 0.9.4.63: `no font set`).

Leeres Textfeld trägt seit 0.9.4.63 einen Appearance-Stream (Länge 0),
damit `fillForms` etwas überschreiben kann.

Leeres Feld mit `-bordercolor` und `-borderwidth` zeichnet seit
0.9.4.66 den Rahmen statt eines leeren Streams. Ohne Rahmen bleibt
der Stream leer.

---

## Summe (JS im Viewer)

```tcl
$pdf addForm text 400 200 90 16 -id b1 -align right -init 120
$pdf addForm text 400 220 90 16 -id b2 -align right -init 80
$pdf addForm text 400 250 90 16 -id f_sum -align right \
        -calculate {sum {b1 b2}} -init 200 \
        -borderwidth 1 -bgcolor {0.95 0.95 0.85}
```

`-init` zeigt den Wert überall. `-calculate` aktualisiert in Acrobat,
Firefox, Chromium, Foxit.

---

## PDF/A und Häkchen

Ein Häkchen als ZapfDingbats-Glyph ist nicht einbettbar. Seit
0.9.4.55 zeichnet pdf4tcl den Haken als Vektor, sobald `-pdfa` oder
PDF/UA gesetzt ist. Ohne Konformitätsanspruch bleibt der Glyph.
`-markstyle font` / `vector` / `auto` (Default `auto`).

---

## Ebenen und Felder

`beginLayer` erreicht Annotationen nicht — sie liegen außerhalb des
Content-Streams. `-layer` an `addForm` schreibt `/OC` ins
Annotations-Dictionary.

---

## Zusammenfassung

- `addForm TYP x y b h -id name`.
- Appearance entsteht beim Anlegen.
- Comb braucht `-maxlen`. Schriftpflicht hängt am Typ.
- PDF/A: Häkchen als Vektor (`-markstyle auto`).

---

*Nächstes Kapitel: [fillForms](090-fillforms.md)*
