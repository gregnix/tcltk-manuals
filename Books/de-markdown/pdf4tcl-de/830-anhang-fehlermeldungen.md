# Fehlermeldungen

Häufige Meldungen und die übliche Ursache.

---

## no font set

`addForm` für `combobox`, `listbox`, `pushbutton` oder `signature`
vor `setFont`. Textfeld und Kästchen dürfen vorher kommen.
Seit 0.9.4.63; früher `can't read "FontsAttrs(,specialencoding)"`.

## unknown color: "1" -- expected a name like "red", "#rrggbb", …

Farbe kein Triplett 0..1, kein Hex, kein Tabellenname. `1` allein
ist ungültig. Seit 0.9.4.63 mit Beispiel in der Meldung.

## unknown color / invalid … component

Komponente außerhalb 0.0 .. 1.0 (seit 0.9.4.39). `255 0 0` durch
`1 0 0` oder `#ff0000` ersetzen.

## createFontSpecCID: base font '…' not loaded

`loadBaseTrueTypeFont` fehlt oder der Basisname weicht ab.

## invalid TTF file checksum

Beschädigte oder unvollständige TrueType-Datei. CID-Subsets vor
0.9.4.68 trugen Tabellen-Prüfsumme 0 und fielen hier durch, wenn
man sie erneut lud.

## fillForms: no such field(s)

Name nicht im Formular. Seit 0.9.4.64 volle Kette: `person.city`,
nicht `city`. Tippfehler nicht ignorieren — sonst leeres Formular
ohne Erklärung.

## fillForms: "…" is not an option of "…"

Auswahlwert weder Export noch Label. Leerer Wert ist erlaubt.
Seit 0.9.4.65.

## unknown form type …

Typ nicht in `text checkbutton combobox listbox password
radiobutton pushbutton signature`. Alias: `checkbox` für
`checkbutton`.

## unknown metadata option "…"

Nur `-author -creator -keywords -producer -subject -title
-creationdate -moddate`.

## papersize "…" is unknown

Kein ISO-Name und keine Zweierliste `{breite höhe}`.

## rotation … not a multiple of 90

`-rotate` nur Vielfache von 90.

## endLayer without beginLayer / layer still open

Ebene nicht paarig. `endPage` mit offener Ebene ist Fehler
(0.9.4.63, ISO 32000-1 14.6).

## Adobe: leere Seite, keine Meldung

Kein throw. `q` in `BT` (vor 0.9.4.62), CID-Subset ohne cmap
(vor 0.9.4.68) oder tagged `Tj` außerhalb von `BT`/`ET`
(vor 0.9.4.69). In Poppler oft voll. Siehe
[gsave und Text](160-gsave-und-text.md) und
[CID-Subset und CMap](170-cid-subset-cmap.md).

## qpdf: inflate: incorrect header check

Verschlüsseltes PDF mit CID aus 0.9.4.66 oder früher. Neu bauen
mit 0.9.4.67+. Siehe [Verschlüsselung](110-verschluesselung.md).

## PDF/A: the standard font Helvetica has no embeddable font program

Warnung in `::pdf4tcl::warnings`, kein Abbruch. veraPDF fällt durch.
TrueType laden.

## pdf4tcl: linkAdd target(s) never defined with destinationAdd: …

Warnung auf stderr beim Schreiben, kein Abbruch. Ein `linkAdd` nennt
einen Namen, den kein `destinationAdd` angelegt hat; der Link bleibt
wirkungslos. Namen angleichen. Siehe [Annotationen](100-annotationen.md).

## destination "…" already defined

Derselbe Name zweimal an `destinationAdd`. Namen sind je Dokument
eindeutig.

## invalid destination name "…": must match [A-Za-z0-9._-]+

Leerzeichen, Umlaut oder Sonderzeichen im Namen eines Ziels oder Links.

---

*Ende des Anhangs. Einstieg: [pdf4tcl verstehen](010-pdf4tcl-verstehen.md)*
