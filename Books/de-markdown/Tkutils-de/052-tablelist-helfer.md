# Tablelist-Helfer

Dieses Kapitel setzt [Listen und tablelist](050-listen-und-tablelist.md)
fort. Die sieben Module hier arbeiten auf einer fertigen Tablelist, nicht
auf dem Wrapper `tkutablelist`. Für den Wrapper gilt
`[tkutils::tkutablelist::tableWidget $w]`.

[tkutltools]{.index} 0.2 lädt alle sieben und `tclutils::tunum`. Es steht
außerhalb des Umbrellas. Ist weder `tablelist` noch `tablelist_tile`
geladen, fordert es `tablelist_tile` an. Ist eine der beiden Varianten
schon da, bleibt sie. Wrapper und Helfer laden dieselbe Variante; die
Reihenfolge zum Umbrella ist frei (Kapitel
[tkutils verstehen](010-tkutils-verstehen.md)).

| Modul | Version | Aufgabe |
|---|---|---|
| `tkutlsort` | 0.2 | Vergleich je Spalte |
| `tkutlfmt` | 0.3 | Anzeige je Spalte |
| `tkutlclip` | 0.2 | Auswahl als TSV oder CSV |
| `tkutlfooter` | 0.3 | Fußzeile, Summe, weitere Aggregate |
| `tkutlfind` | 0.2 | Suche mit Markierung |
| `tkutlstate` | 0.3 | Spaltenlayout sichern |
| `tkutltree` | 0.2 | verschachtelte Dicts als Baum |

`tkutltools` fordert `tkutlfmt` ab 0.1 und `tkutlstate` ab 0.1 an. Die
Dateien im Baum sind 0.3.

---

## Sortieren: tkutlsort

```tcl
::tkutils::tkutlsort::column  tbl spalte typ ?befehl?
::tkutils::tkutlsort::columns tbl {spalte typ spalte typ ...}
```

| Typ | Tablelist-Modus |
|---|---|
| `string` | `dictionary` |
| `nocase` | `asciinocase` |
| `integer` | `integer` |
| `real` | `real` |
| `num` | Befehl über `tclutils::tunum` |
| `command` | eigener Vergleich mit zwei Argumenten |

`num` liest Gruppierung und Währung. Unlesbare Zellen stehen hinter den
Zahlen. Das Modul setzt nur den Vergleich. Sortiert wird mit
`sortbycolumn` oder einem Klick auf die Spaltenüberschrift.

Ein unbekannter Typ wirft `{TKUTILS TKUTLSORT TYPE}`, eine
`command`-Spalte ohne Befehl `{TKUTILS TKUTLSORT CMD}`, eine ungerade
Liste an `columns` `{TKUTILS TKUTLSORT SPEC}`.

---

## Anzeige: tkutlfmt

```tcl
::tkutils::tkutlfmt::column  tbl spalte typ ?option wert ...?
::tkutils::tkutlfmt::columns tbl {spalte typ ?{option wert ...}? ...}
```

Die Zelle behält den Rohwert. Die Anzeige kommt über `-formatcommand`.
`integer`, `number`, `currency` und `percent` stehen rechts, sofern
`-align` fehlt. `date` formatiert mit `clock`.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-locale` | `eu` | `eu` mit Punkt als Tausender und Komma als Dezimal, oder `us` |
| `-group` | aus `-locale` | Tausendertrenner |
| `-decimal` | aus `-locale` | Dezimalzeichen |
| `-decimals` | je Typ | Nachkommastellen: `integer` 0, `number` und `currency` 2, `percent` 1 |
| `-symbol` | `€` | nur Währung |
| `-symbolpos` | `post` | `pre` oder `post` |
| `-align` | automatisch | `right`, `left`, `center` |
| `-informat` | leer | `clock scan`, sonst Zahl oder erkennbare Zeit |
| `-outformat` | `%Y-%m-%d` | `clock format` |

Ein unbekannter Typ wirft `{TKUTILS TKUTLFMT TYPE}`, eine unbekannte
Option `{TKUTILS TKUTLFMT OPTION -name}` und nennt die bekannten, ein
fremdes `-locale` `{TKUTILS TKUTLFMT LOCALE}` mit
`locale must be eu or us`.

---

## Zwischenablage: tkutlclip

```tcl
::tkutils::tkutlclip::copySelection   tbl ?option wert ...?
::tkutils::tkutlclip::copyAll         tbl ?option wert ...?
::tkutils::tkutlclip::asText          tbl zeilen ?option wert ...?
::tkutils::tkutlclip::installBindings tbl ?option wert ...?
```

`copySelection` und `copyAll` liefern die Zahl der kopierten Zeilen.
`asText` liefert den Text und lässt die Zwischenablage in Ruhe.
`installBindings` bindet `<<Copy>>` auf den Körper der Tabelle.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-format` | `tsv` | `tsv` oder `csv` |
| `-header` | `0` | Spaltentitel als erste Zeile |
| `-formatted` | `1` | angezeigte Werte, bei `0` die Rohzellen |
| `-columns` | `visible` | `visible` oder `all` |

TSV ersetzt Tabulator und Zeilenumbruch in einer Zelle durch ein
Leerzeichen. CSV behält sie. Fehlercodes: `{TKUTILS TKUTLCLIP OPTION}`
(`unknown option "-foo"`, ohne Optionsnamen im Code und ohne
`Known:`-Zeile), `FORMAT` (`format must be tsv or csv`), `COLUMNS`.

---

## Fußzeile: tkutlfooter

```tcl
::tkutils::tkutlfooter::attach  haupt fuss ?-autowire 1?
::tkutils::tkutlfooter::update  haupt fuss
::tkutils::tkutlfooter::setvals fuss {wert ...}
::tkutils::tkutlfooter::autosum haupt fuss ?-columns {1 2}? ?-label SUM:? ?-format %.2f?
::tkutils::tkutlfooter::autoagg haupt fuss ?-columns {1 sum ...}? ?-label text? ?-format %.2f?
::tkutils::tkutlfooter::detach  haupt fuss
```

`attach` macht aus `fuss` eine einzelne Zeile ohne Auswahl und übernimmt
die Spalten. `-autowire 1` hängt das horizontale Scrollen an das
bestehende `-xscrollcommand` der Haupttabelle, statt es zu ersetzen.
Seit 0.2 übernimmt die Fußzeile auch `-titlecolumns`, versteckte Spalten
und `-stretch`.

`autosum` summiert die genannten Spalten, Vorgabe alle, und schreibt
`-label` in Spalte 0. Zahlen liest `tclutils::tunum`. Nach einer
Datenänderung läuft `autosum` erneut. `autoagg` nimmt je Spalte `sum`,
`avg`, `min`, `max`, `count` oder `countnum`. Zähler bleiben ganzzahlig.
Fehler tragen `{TKUTILS TKUTLFOOTER <GRUND>}`, etwa `SPEC` für eine
ungerade `-columns`-Liste bei `autoagg` und `FUNC` für ein unbekanntes
Aggregat. Unbekannte Optionen prüft das Modul nicht: `attach`, `autosum`
und `autoagg` übergehen sie ohne Fehler.

---

## Suchen: tkutlfind

```tcl
::tkutils::tkutlfind::find    tbl text ?option wert ...?
::tkutils::tkutlfind::next    tbl
::tkutils::tkutlfind::prev    tbl
::tkutils::tkutlfind::matches tbl
::tkutils::tkutlfind::clear   tbl
```

`find` liefert die Trefferzahl und färbt die Zellen. `next` und `prev`
laufen im Kreis und rufen `seecell`. Gesucht wird im angezeigten Text,
also nach `tkutlfmt`. Nach einem Sortieren ist `find` erneut nötig, weil
sich die Zeilennummern ändern. `clear` stellt Hintergrund und, wenn
gesetzt, Vordergrund wieder her.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-columns` | alle sichtbaren | Spalten |
| `-mode` | `substring` | `substring`, `exact`, `glob`, `regexp` |
| `-nocase` | `1` | ohne Großschreibung |
| `-highlightbg` | `#ffe9a8` | Hintergrund der Treffer |
| `-highlightfg` | leer | Vordergrund, optional |

Fehlercodes: `{TKUTILS TKUTLFIND MODE}` (`unknown mode "xx"`) und
`OPTION` (`unknown option "-foo"`, ohne Optionsnamen im Code).

---

## Layout sichern: tkutlstate

```tcl
::tkutils::tkutlstate::save            tbl
::tkutils::tkutlstate::restore         tbl zustand
::tkutils::tkutlstate::saveToFile      tbl pfad
::tkutils::tkutlstate::restoreFromFile tbl pfad
::tkutils::tkutlstate::saveVia         tbl schlüssel setPrefix
::tkutils::tkutlstate::restoreVia      tbl schlüssel getPrefix
::tkutils::tkutlstate::autosave        tbl schlüssel setPrefix ?-delay ms?
::tkutils::tkutlstate::cancelAutosave  tbl
```

`save` liefert ein Dict mit `version`, `ncols`, `columns` (je Spalte
`width` und `hide`) und `sortcolumn` (`-1` ohne Sortierung).
`sortorder` kommt nur dazu, wenn eine Spalte sortiert ist, `columnorder`
nur, wenn die Tablelist die Option `-columnorder` kennt; Tablelist 6.20
und 7.11 kennen sie nicht. `restoreFromFile` und
`restoreVia` liefern `1`, wenn ein Zustand ankam, und `0`, wenn er
fehlt. `saveVia` hängt Schlüssel und Dict an den Befehlspräfix.
`restore` ändert nur Spalten, die in beiden Zuständen vorkommen.
Ein Wert, der kein Zustand ist, wirft `{TKUTILS TKUTLSTATE STATE}` mit
`not a tkutlstate dict`. Eine unbekannte Option an `autosave` meldet
`{TKUTILS TKUTLSTATE badoption}` — als einziger Grund im Modul klein
geschrieben.

---

## Baum: tkutltree

Ein Knoten ist ein Dict der Felder plus optional `children`, eine Liste
weiterer Knoten. Die oberste Ebene ist eine Liste von Knoten.

```tcl
::tkutils::tkutltree::fromData tbl daten -fields {feld ...} ?-childrenkey children? ?-parent root?
::tkutils::tkutltree::toData   tbl       -fields {feld ...} ?-childrenkey children? ?-node root?
::tkutils::tkutltree::clear    tbl ?-node root?
```

Feld *i* füllt Spalte *i*. Ein fehlendes Feld wird eine leere Zelle.
`toData` liest die Rohzellen, nicht den formatierten Text. Hin und
zurück ergibt dieselbe Struktur. Fehlercodes:
`{TKUTILS TKUTLTREE FIELDS}` (`-fields is required`) und `OPTION`.

---

## Merkliste

- `tkutltools` 0.2 lädt die sieben Helfer und `tunum`.
- Sortieren und Formatieren lassen den Rohwert in der Zelle.
- Die Fußzeile ersetzt ein vorhandenes horizontales Scrollen nicht.
- `tkutlstate` kennt nur Spalten, die es noch gibt.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 (Tablelist 6.20) und 9.0.4 (Tablelist
7.11) unter Linux und Xvfb: Laden von `tkutltools`, die Fehlercodes und
Meldungen, `tkutlstate::save`.
:::

---

*Nächstes Kapitel: [Geometrie und Units](060-geometry-und-units.md)*
