# pdf4tcl verstehen

## Einführung

[pdf4tcl]{.index} schreibt PDF aus Tcl. Eine Klasse, Methoden am
Dokumentobjekt, Ausgabe per `write`. Dieses Kapitel legt fest, wofür
das Paket taugt und wo andere Schichten ansetzen.

Das Buch beschreibt **0.9.4.69**: tagged Text bleibt in `BT`/`ET`.
Dazu kommen die Links im Dokument aus **0.9.4.72** (Kapitel
[Annotationen](100-annotationen.md)).
CID-Subset mit Identity-CMap und Tabellen-Prüfsummen seit 0.9.4.68,
verschlüsselte CID-Schriften über `WriteObjectDirect` seit 0.9.4.67,
Appearance-Streams für Stempel und `fillForms`.

---

## Erstes Dokument

```tcl
package require pdf4tcl 0.9.4.69

set pdf [::pdf4tcl::new %AUTO% -paper a4 -orient true -compress 1]
$pdf startPage
$pdf setFont 12 Helvetica
$pdf text "Hallo Welt" -x 50 -y 50
$pdf endPage
$pdf write -file ausgabe.pdf
$pdf destroy
```

`%AUTO%` vergibt den Objektnamen. `-orient true` (Default) setzt Y
oben, wie Tk. `-compress 1` (Default) packt Content-Streams.

Ohne `startPage` beginnt die erste Zeichenoperation die Seite selbst.
Trotzdem `startPage` / `endPage` explizit setzen: Rand, Papier und
offene Ebenen bleiben dann übersichtlich.

---

## Was pdf4tcl ist — und was nicht

Geeignet:

- Seiten mit Text, Vektoren, Bildern
- Unicode über [CID-Schrift]{.index}
- AcroForm anlegen und später füllen
- Canvas-Export, AES-Verschlüsselung, PDF/A, Ebenen
- Mehrere PDFs aneinanderhängen (`catPdf`)

Ungeeignet als alleinige Schicht:

- Tabellen mit Seitenumbruch, Fließtext über Spalten, Etikettenbogen
- Das leistet `pdf4tcllib` auf derselben Zeichen-API

pdf4tcl zeichnet. Layout bleibt Aufgabe des Aufrufers oder der
Begleitbibliothek.

---

## Koordinaten und Einheiten

Default-Einheit ist Punkt (`-unit p`). Millimeter: `-unit mm`.
Mit `-orient 1` liegt der Ursprung oben links im Satzspiegel
(nach `-margin`). PDF intern zählt Y von unten; die Klasse rechnet um.

Farben liegen in **0.0 .. 1.0**, nicht 0..255. Seit 0.9.4.39 wirft
ein Wert außerhalb einen Fehler statt stillschweigend zu schreiben.

---

## Warnungen

Manche Mängel unterbrechen nicht: Standardschrift unter `-pdfa`,
Alpha unter PDF/A-1. Nach `write` die Liste prüfen:

```tcl
if {[llength $::pdf4tcl::warnings]} {
    puts $::pdf4tcl::warnings
}
```

---

## Verwandte Quellen

- Manpage `pdf4tcl.md` — jede Methode
- `pdf4tcl/doc/en/howtos/` — eine Aufgabe je Datei, mit Skript
- `pdf4tcl/UPGRADING.md` — was sich an bestehendem Code ändert
- `pdf4tcl/demo/` — ein Merkmal je Programm

Dieses Buch fasst den Stoff als Lehrtext. Die Howtos bleiben die
ablauffähige Probe.

---

## Zusammenfassung

- `pdf4tcl::new`, Seite, zeichnen, `write`, `destroy`.
- Version **0.9.4.69** für tagged Text in `BT`/`ET`, CID-cmap,
  AES mit eingebetteter Schrift und Appearance-Streams.
- Layout-Helfer liegen außerhalb dieses Pakets.

---

*Nächstes Kapitel: [Dokument und Seite](020-dokument-und-seite.md)*
