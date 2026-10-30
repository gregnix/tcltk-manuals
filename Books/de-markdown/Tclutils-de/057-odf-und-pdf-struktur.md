# ODF und PDF-Struktur

[tupdf]{.index} 0.2 liest die Struktur einer PDF: Kopfzeile, Objektnummern,
Seitenmarker, Trailer, Infos und einen Hinweis auf ZUGFeRD. Den Text der
Seiten liest `tupdftext`, Kapitel
[Text aus PDF-Dateien](055-pdf-text.md).

[tuodf]{.index} 0.2 schreibt und liest ein schlichtes OpenDocument mit
Absätzen. [tudocx]{.index} und [tuxlsx]{.index} 0.1 tun dasselbe für
Word- und Excel-Dateien (Office Open XML). Alle liegen im Umbrella.

---

## PDF: tupdf

```tcl
package require tclutils::tupdf
::tclutils::tupdf::version  datei
::tclutils::tupdf::objects  datei
::tclutils::tupdf::object   datei nummer
::tclutils::tupdf::trailer  datei
::tclutils::tupdf::metadata datei
::tclutils::tupdf::summary  datei
::tclutils::tupdf::zugferd  datei
```

`version` nimmt die Zahl hinter `%PDF-` in den ersten 1024 Bytes.
`objects` liefert die Nummern aus `N G obj`, sortiert und einmalig.
Komprimierte Objektströme packt das Modul mit `zlib` aus, bevor es zählt.
`object` gibt den Rohtext von `id gen obj` bis `endobj`. `pages` in
`summary` zählt `/Type /Page` und lässt `/Pages` aus.

Die folgende Datei hat den Kopf `%PDF-1.4`, vier Objekte, eine Seite und
ein Info-Objekt mit `Title (Lager)` und `Author (Nord)`.

```tcl
::tclutils::tupdf::version $datei                    ;# -> 1.4
::tclutils::tupdf::objects $datei                    ;# -> 1 2 3 4
dict get [::tclutils::tupdf::summary $datei] pages   ;# -> 1
dict get [::tclutils::tupdf::metadata $datei] Title  ;# -> Lager
```

`summary` trägt zusätzlich `version`, `size`, `objects`, `encrypted`,
`linearized`, `acroform` und `zugferdDetected`. Vorhandene Infofelder
liegen in demselben Dict. Hier sind `encrypted`, `linearized` und
`acroform` 0, `zugferdDetected` ebenfalls 0.

`zugferd` ist eine Suche im Dateitext, keine Konformitätsprüfung. Ohne
Anhang und ohne die Marker bleibt das Dict leer in den Listen:

```tcl
dict get [::tclutils::tupdf::zugferd $datei] detected ;# -> 0
dict get [::tclutils::tupdf::zugferd $datei] profile  ;# -> {}
```

Die Schlüssel sind `detected`, `profile`, `attachmentNames`, `mimeTypes`
und `hints`. Ein Treffer setzt `profile` auf `factur-x`, `zugferd` oder
`unknown`.

| Code | Wann |
|---|---|
| `{TCLUTILS TUPDF FORMAT}` | kein `%PDF-`-Kopf, oder `endobj` fehlt nach dem Objekt |
| `{TCLUTILS TUPDF ARG}` | die Objektnummer ist keine ganze Zahl |
| `{TCLUTILS TUPDF NOTFOUND}` | die Nummer steht nach dem Aufblasen nicht im Text |

`object $datei x` wirft `ARG`. `object $datei 9` an der Datei oben wirft
`NOTFOUND`.

---

## ODF: tuodf

```tcl
package require tclutils::tuodf
::tclutils::tuodf::createText datei absätze ?-title T? ?-creator C?
::tclutils::tuodf::parts      datei
::tclutils::tuodf::part       datei name
::tclutils::tuodf::paragraphs datei
::tclutils::tuodf::text       datei
```

`createText` gibt den Dateipfad zurück. Der Behälter ist ein ZIP.
`mimetype` steht als erster Eintrag und bleibt unkomprimiert. `-title`
und `-creator` landen in `meta.xml`.

```tcl
set z [::tclutils::tuodf::createText lager.odt \
    [list {Lager Nord} {a < b} {}] -title Lager -creator Nord]
::tclutils::tuodf::parts $z
    ;# -> mimetype content.xml styles.xml meta.xml META-INF/manifest.xml
::tclutils::tuodf::part $z mimetype
    ;# -> application/vnd.oasis.opendocument.text
::tclutils::tuodf::paragraphs $z          ;# -> {Lager Nord} {a < b} {}
::tclutils::tuodf::text $z                ;# -> Lager Nord\na < b\n
```

`a < b` kommt als Text zurück. Im XML steht `&lt;`. Ein leerer Eintrag
in der Liste ist ein leerer Absatz. `text` hängt die Absätze mit `\n`
aneinander, deshalb endet das Ergebnis mit einem Zeilenumbruch.
`meta.xml` enthält `<dc:title>Lager</dc:title>` und
`<dc:creator>Nord</dc:creator>`.

`paragraphs` liest Absätze (`text:p`) und seit 0.2 auch Überschriften
(`text:h`), in der Reihenfolge des Dokuments. Absätze in Tabellen, Listen,
Tabellenzellen einer `.ods` und Folien einer `.odp` findet es mit; den
Aufbau selbst (Zeilen, Spalten, Ebenen) gibt es nicht wieder.
Eine fehlende ZIP-Datei meldet `tuzip`, nicht einen eigenen Code von
`tuodf`.

---

## Word: tudocx

```tcl
package require tclutils::tudocx
::tclutils::tudocx::createText datei absätze ?-title T? ?-creator C?
::tclutils::tudocx::parts      datei
::tclutils::tudocx::part       datei name
::tclutils::tudocx::paragraphs datei
::tclutils::tudocx::text       datei
```

Die Befehle heißen wie bei `tuodf`. `createText` schreibt die fünf Teile,
die eine `.docx` mindestens braucht; Word, LibreOffice und python-docx
öffnen sie. Ein Tabulator im Absatz wird `w:tab`, ein Zeilenumbruch
`w:br`.

```tcl
set d [::tclutils::tudocx::createText lager.docx \
    [list {Lager Nord} "Regal\t3" {}] -title Lager]
::tclutils::tudocx::parts $d
    ;# -> {[Content_Types].xml} _rels/.rels word/document.xml docProps/core.xml docProps/app.xml
::tclutils::tudocx::paragraphs $d        ;# -> {Lager Nord} {Regal<TAB>3} {}
```

`paragraphs` liest den Hauptteil, den `_rels/.rels` nennt, meist
`word/document.xml`: jeden Absatz in der Reihenfolge des Dokuments, auch
Überschriften, Listenpunkte und Tabellenzellen. Gelöschter Text einer
Änderungsverfolgung (`w:delText`) und Feldbefehle (`w:instrText`) bleiben
weg. Kopf- und Fußzeilen, Fußnoten und Kommentare stehen in anderen Teilen
und werden nicht gelesen. Fehlt der Hauptteil, ist das
`{TCLUTILS TUDOCX PART …}`.

---

## Excel: tuxlsx

```tcl
package require tclutils::tuxlsx
::tclutils::tuxlsx::writeRows datei zeilen ?-sheet NAME? ?-numbers auto|0? ?-title T? ?-creator C?
::tclutils::tuxlsx::sheets    datei
::tclutils::tuxlsx::rows      datei ?-sheet NAME|NUMMER?
::tclutils::tuxlsx::text      datei
::tclutils::tuxlsx::part      datei name
::tclutils::tuxlsx::parts     datei
```

`writeRows` schreibt ein Blatt. Mit `-numbers auto` wird ein Wert, der wie
eine Dezimalzahl aussieht, als Zahl gespeichert, alles andere als Text;
`007` bleibt Text.

```tcl
set x [::tclutils::tuxlsx::writeRows lager.xlsx \
    {{Artikel Menge} {Schraube 120} {Mutter 007}} -sheet Lager]
::tclutils::tuxlsx::sheets $x            ;# -> Lager
::tclutils::tuxlsx::rows $x              ;# -> {Artikel Menge} {Schraube 120} {Mutter 007}
::tclutils::tuxlsx::rows $x -sheet Nord  ;# Fehler {TCLUTILS TUXLSX SHEET Nord}
```

`rows` liest jede Arbeitsmappe, auch die von Excel und LibreOffice. Die
Werte kommen so, wie die Datei sie speichert: Text aus der Tabelle der
gemeinsamen Zeichenketten oder direkt in der Zelle, Zahlen wie
geschrieben, ein Datum als Seriennummer, Wahrheitswerte als `1` und `0`,
eine Formel mit ihrem zuletzt berechneten Wert, ein Fehler als Text
(`#DIV/0!`). Lücken werden mit `""` gefüllt. Formate liest `tuxlsx` nicht.
`text` gibt alle Blätter aus, Zellen mit Tabulator, Zeilen mit
Zeilenumbruch getrennt.

---

## Merkliste

- Den Seitentext liest `tupdftext`. `tupdf` liefert Version, Objekte, Infos.
- `/Pages` zählt nicht als Seite. `zugferd` prüft die Datei nicht auf Norm.
- `tuodf` schreibt Absätze. `mimetype` ist der erste, unkomprimierte Eintrag.
- `tudocx` und `tuxlsx` heißen und arbeiten wie `tuodf`; `tuxlsx::rows`
  liefert Werte, wie die Datei sie speichert (Datum als Seriennummer).
- Ein leerer Absatz am Ende hängt an `text` einen Zeilenumbruch.

---

*Nächstes Kapitel: [Diagramme](056-diagramme.md)*
