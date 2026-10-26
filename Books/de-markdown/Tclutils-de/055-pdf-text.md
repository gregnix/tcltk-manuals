# Text aus PDF-Dateien

[tupdftext]{.index} 0.1 ist neu in tclutils 0.67.0. Es liest den Text
einer PDF Seite für Seite, in reinem Tcl. Die Ströme packt Tcls `zlib`
aus. poppler und eine C-Erweiterung braucht es nicht. Gedacht ist es für
die Volltextsuche: Wörter, Leerzeichen und Zeilenwechsel. Spalten und
Tabellen kommen in der Reihenfolge des Inhaltsstroms.

Die Struktur einer PDF (Version, Objekte, Trailer, Metadaten, ZUGFeRD)
liest das Schwestermodul `tupdf`. `tupdftext` liest den Text.

---

## Befehle

```tcl
package require tclutils::tupdftext
::tclutils::tupdftext::pages   datei ?-notext error|empty?
::tclutils::tupdftext::text    datei ?-separator s? ?-notext error|empty?
::tclutils::tupdftext::summary datei
```

`pages` liefert eine Liste, eine Zeichenkette je Seite, in Seitenfolge.
Zeilen sind mit `\n` getrennt, Folgen von Leerzeichen zusammengezogen,
Ligaturen (`ﬁ`, `ﬂ`) ausgeschrieben, weiche Trennstriche entfernt.

`text` hängt die Seiten mit `-separator` aneinander. Die Vorgabe ist
der Seitenvorschub `\f`, wie bei `pdftotext`. Eine einzelne Seite hat
keinen Trenner.

`summary` liefert ein Dict:

| Schlüssel | Bedeutung |
|---|---|
| `pages` | Zahl der Seiten |
| `encrypted` | 1, wenn ein Eintrag `/Encrypt` da ist |
| `version` | Version aus der Kopfzeile, etwa `1.4` |
| `textPages` | Seiten mit mindestens einem Zeichen |
| `unmapped` | Glyphen, die als U+FFFD kamen (Zwei-Byte-Schrift ohne `/ToUnicode`) |
| `fonts` | Liste von Dicts `name`, `subtype`, `toUnicode` |

Mit `-notext empty` wird aus einer PDF ohne Text eine Liste leerer
Zeichenketten, eine je Seite. Ohne die Option ist das der Fehler
`NOTEXT`.

Der Befehl heißt `summary`, nicht `info`. Eine Prozedur `info` im
Namensraum des Moduls hätte Tcls `info` für alle Prozeduren des Moduls
verdeckt.

```tcl
set seiten [::tclutils::tupdftext::pages $datei]
llength $seiten                                          ;# -> 1
lindex $seiten 0                                         ;# -> Lager Nord, Regal 3\nGroesse: 12 Stueck
dict get [::tclutils::tupdftext::summary $datei] version ;# -> 1.4
dict get [::tclutils::tupdftext::summary $datei] unmapped
                                                         ;# -> 0
::tclutils::tupdftext::text $zweiSeiten                  ;# -> Seite eins\fSeite zwei
```

Die Kommentare gelten für zwei Dateien aus pdf4tcl: eine Seite Helvetica
mit den beiden Zeilen oben, und zwei Seiten mit „Seite eins“ und
„Seite zwei“. Dieselbe leere Seite ohne die Option wirft
`{TCLUTILS TUPDFTEXT NOTEXT}`; mit `-notext empty` ist die Liste ein
leeres Element. Eine fehlende Datei ergibt `FILE`, eine Datei ohne
`%PDF-`-Kopf `FORMAT`. Tcl 8.6 und Tcl 9 liefern denselben Text.

---

## Fehler

Jeder Fehler trägt `-errorcode {TCLUTILS TUPDFTEXT grund}`:

| Grund | Wann |
|---|---|
| `FILE` | die Datei ist nicht lesbar |
| `FORMAT` | kein `%PDF-`-Kopf, keine Objekte oder keine Seiten |
| `ENCRYPTED` | die Datei ist verschlüsselt; auch ein leeres Benutzerpasswort wird nicht gelesen |
| `NOTEXT` | keine Seite hat Text: ein Scan ohne OCR, oder nur Bilder |
| `OPTION` | unbekannte Option oder fehlender Wert |

---

## Was ankommt

Objekte sucht es als `N G obj` am Zeilenanfang. Die Querverweistabelle
braucht es nicht; eine beschädigte stört nicht. Eine spätere Definition
derselben Nummer gilt, wie bei einem inkrementellen Update. Objekte in
Objektströmen (`/ObjStm`) füllen Nummern, die nicht direkt dastehen.

Filter: `FlateDecode` (auch mit PNG-Predictor), `ASCIIHexDecode`,
`ASCII85Decode`, `LZWDecode`, und Ketten davon. Seiten kommen über den
Seitenbaum ab `/Root`, mit geerbten `/Resources`. Ohne brauchbaren Baum:
alle Objekte `/Type /Page` in Dateireihenfolge.

Textoperatoren: `Tj`, `TJ`, `'`, `"` mit `Tf`, `Tc`, `Tw`, `Tz`, `TL`,
`Ts`, `Td`, `TD`, `Tm`, `T*`, `q`, `Q`, `cm`. Form-XObjects (`Do`) mit
eigenen Ressourcen und eigener Matrix, bis Tiefe 8; ein Formular, das
sich selbst zeichnet, einmal. Eingebettete Bilder werden übersprungen.

Schriften: Type0 (Zwei-Byte-Codes, `Identity-H`/`-V` oder eine
eingebettete CMap), Type1, TrueType, Type3. Unicode aus `/ToUnicode`
(`bfchar`, `bfrange`), sonst aus `/Encoding` (`WinAnsiEncoding`,
`MacRomanEncoding`, `StandardEncoding`, `PDFDocEncoding` und
`/Differences` mit Glyphennamen). Leerzeichen und Zeilenwechsel kommen
aus den Positionen: ein Sprung um eine halbe Zeile nach unten ist eine
neue Zeile, eine Lücke von mehr als 0,15 em in der Zeile ein Leerzeichen.

---

## Was es nicht tut

- entschlüsseln (`ENCRYPTED`)
- Text aus Bildern lesen
- eine Zwei-Byte-Schrift ohne `/ToUnicode` abbilden (U+FFFD, gezählt in
  `unmapped`)
- Spalten auseinanderhalten
- Wörter zusammensetzen, die am Zeilenende getrennt sind (`pdftotext`
  tut das)

Im Vergleich mit `pdftotext` (poppler 24.02) an 13 PDFs, festgehalten in
`docs/tupdftext.md`: bei elf Dateien 99,5 bis 100 % der Wörter, bei zwei
Formelseiten 91 %. Ein Buch mit 108 Seiten braucht unter Tcl 8.6.14 etwa
3,6 s. Tcl 9.0.4 liefert dort denselben Text; Zeichen außerhalb der BMP
sind unter Tcl 9 ein Zeichen und unter Tcl 8.6 ein Ersatzpaar. Dieser
Vergleich ist hier nicht erneut gelaufen. Eine verschlüsselte Datei ist
in diesem Lauf nicht erzeugt; die Modulbeschreibung nennt dafür
`ENCRYPTED`.

---

## Kommandozeile

```sh
tclsh bin/tupdf.tcl text doc.pdf
tclsh bin/tupdf.tcl text doc.pdf -page 3
```

`book-search.tcl` und mdserver nutzen das Modul für den Text in PDFs.

---

## Merkliste

- `pages` je Seite, `text` mit `\f` dazwischen, `summary` für die Kennzahlen.
- Scan und verschlüsselte Datei sind Fehler, kein stiller Leerstring.
- `-notext empty` macht aus dem Fehler eine leere Seitenzeichenkette.
- Spalten, Silbentrennung am Zeilenende und Text in Bildern bleiben draußen.

---

*Nächstes Kapitel: [ODF und PDF-Struktur](057-odf-und-pdf-struktur.md)*
