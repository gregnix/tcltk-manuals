# ODF und PDF-Struktur

[tupdf]{.index} 0.2 liest die Struktur einer PDF: Kopfzeile, Objektnummern,
Seitenmarker, Trailer, Infos und einen Hinweis auf ZUGFeRD. Den Text der
Seiten liest `tupdftext`, Kapitel
[Text aus PDF-Dateien](055-pdf-text.md).

[tuodf]{.index} 0.1 schreibt und liest ein schlichtes OpenDocument mit
Absätzen. Beide liegen im Umbrella.

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

`paragraphs` liest `text:p`. Tabellen und andere Blöcke übergeht es.
Eine fehlende ZIP-Datei meldet `tuzip`, nicht einen eigenen Code von
`tuodf`.

---

## Merkliste

- Den Seitentext liest `tupdftext`. `tupdf` liefert Version, Objekte, Infos.
- `/Pages` zählt nicht als Seite. `zugferd` prüft die Datei nicht auf Norm.
- `tuodf` schreibt Absätze. `mimetype` ist der erste, unkomprimierte Eintrag.
- Ein leerer Absatz am Ende hängt an `text` einen Zeilenumbruch.

---

*Nächstes Kapitel: [Diagramme](056-diagramme.md)*
