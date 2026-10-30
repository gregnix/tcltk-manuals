# Tablelist-Helfer

Dieses Kapitel setzt [Listen und tablelist](050-listen-und-tablelist.md)
fort. Die zehn Module hier arbeiten auf einer fertigen Tablelist, nicht
auf dem Wrapper `tkutablelist`. Für den Wrapper gilt
`[tkutils::tkutablelist::tableWidget $w]`.

[tkutltools]{.index} 0.3 lädt alle zehn und `tclutils::tunum`. Es steht
außerhalb des Umbrellas. Ist weder `tablelist` noch `tablelist_tile`
geladen, fordert es `tablelist_tile` an. Ist eine der beiden Varianten
schon da, bleibt sie. Wrapper und Helfer laden dieselbe Variante; die
Reihenfolge zum Umbrella ist frei (Kapitel
[tkutils verstehen](010-tkutils-verstehen.md)).

| Modul | Version | Aufgabe |
|---|---|---|
| `tkutlsort` | 0.3 | Vergleich je Spalte, leere Zellen |
| `tkutlfmt` | 0.3 | Anzeige je Spalte |
| `tkutlclip` | 0.3 | Auswahl als TSV oder CSV, Strg+C |
| `tkutlfooter` | 0.4 | Fußzeile, Summe, weitere Aggregate |
| `tkutlfind` | 0.3 | Suche mit Markierung |
| `tkutlstate` | 0.4 | Spaltenlayout und Sortierung sichern |
| `tkutltree` | 0.3 | verschachtelte Dicts als Baum, Nachladen |
| `tkutlfilter` | 0.1 | Zeilen verstecken, die nicht passen |
| `tkutlgroup` | 0.1 | flache Zeilen gruppieren, mit Summen |
| `tkutldrag` | 0.1 | Zeilen mit der Maus umsortieren |

`tkutltools` fordert `tkutlfmt` ab 0.1 an; die Datei im Baum ist 0.3.

---

## Sortieren: tkutlsort

```tcl
::tkutils::tkutlsort::column  tbl spalte typ ?befehl? ?-empty first|last?
::tkutils::tkutlsort::columns tbl {spalte typ spalte typ ...} ?-empty first|last?
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

Eine leere Zelle in einer `integer`- oder `real`-Spalte bringt den
Tablelist-Vergleich zum Fehler. Seit 0.3 legt `-empty first` oder
`-empty last` fest, wo leere und unlesbare Zellen stehen, und zwar in
beiden Richtungen. `-empty` gilt für `integer`, `real` und `num`;
`columns` gibt es nur an diese Spalten weiter.

```tcl
tablelist::tablelist .t -columns {10 Artikel left 6 Menge right}
.t insertlist end {{Schrauben 100} {Muttern {}} {Dübel 20}}
::tkutils::tkutlsort::column .t 1 integer -empty last
.t sortbycolumn 1 -decreasing
puts [lmap r [.t get 0 end] {lindex $r 1}]   ;# -> 100 20 {}
```

Ein unbekannter Typ wirft `{TKUTILS TKUTLSORT TYPE}`, eine
`command`-Spalte ohne Befehl `{TKUTILS TKUTLSORT CMD}`, eine ungerade
Liste an `columns` `{TKUTILS TKUTLSORT SPEC}`, ein anderer Wert für
`-empty` `{TKUTILS TKUTLSORT EMPTY}` mit
`bad -empty "middle": must be first or last`, eine andere Option
`OPTION`.

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

`copySelection` und `copyAll` liefern die Zahl der kopierten Zeilen;
`copyAll` nimmt nur sichtbare Zeilen, keine versteckten und keine in
zugeklappten Knoten. `asText` liefert den Text und lässt die
Zwischenablage in Ruhe. `installBindings` bindet `<<Copy>>` auf den
Körper der Tabelle (`bodytag`) und beendet die Bindung mit `break`.
Ohne `break` liefe danach die eigene `<<Copy>>`-Bindung von Tablelist und
überschriebe die Zwischenablage mit ihrem TSV; bis 0.2 kam deshalb bei
Strg+C nie das gewünschte Format an. Die Optionen prüft
`installBindings` sofort, nicht erst beim ersten Strg+C.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-format` | `tsv` | `tsv` oder `csv` |
| `-header` | `0` | Spaltentitel als erste Zeile |
| `-formatted` | `1` | angezeigte Werte, bei `0` die Rohzellen |
| `-columns` | `visible` | `visible` oder `all` |
| `-separator` | `,` | Trennzeichen für CSV, ein Zeichen; TSV nimmt immer den Tabulator |

```tcl
::tkutils::tkutlclip::installBindings .t -format csv -separator {;} -header 1
puts [::tkutils::tkutlclip::asText .t {0 1} -format csv -separator {;}]
```

TSV ersetzt Tabulator und Zeilenumbruch in einer Zelle durch ein
Leerzeichen. CSV behält sie und läuft immer über `tclutils::tucsv` 0.2,
wie `tkutablelist::toCsv`: Dieselbe Zeile ergibt in beiden denselben
Text. Fehlercodes: `{TKUTILS TKUTLCLIP OPTION}`
(`unknown option "-foo"`, ohne Optionsnamen im Code und ohne
`Known:`-Zeile), `FORMAT` (`format must be tsv or csv`), `COLUMNS`,
`SEPARATOR` (`separator must be one character`).

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
und `-stretch`. Den ersten Abgleich plant `attach` für die Leerlaufzeit;
`detach` bricht ihn ab, und ist eine der Tabellen bis dahin zerstört,
tut er nichts (0.4; vorher kam ein Hintergrundfehler
`invalid command name`).

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
laufen im Kreis und rufen `seecell`; sie liefern `{zeile spalte}` mit der
aktuellen Zeilennummer. Gesucht wird im angezeigten Text, also nach
`tkutlfmt`. Seit 0.3 merkt sich das Modul die Treffer als
Zeilenschlüssel: Nach einem Sortieren stimmen `matches`, `next` und
`prev` weiter, gelöschte Zeilen fallen heraus. Versteckte Zeilen, etwa
von `tkutlfilter`, übergeht `find`, außer mit `-hidden 1`. Liegt ein
Treffer in einem zugeklappten Knoten, klappt `next` die Vorfahren auf.
`clear` stellt die Zellfarben wieder her, die vor `find` gesetzt waren.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-columns` | alle sichtbaren | Spalten |
| `-mode` | `substring` | `substring`, `exact`, `glob`, `regexp` |
| `-nocase` | `1` | ohne Großschreibung |
| `-highlightbg` | `#ffe9a8` | Hintergrund der Treffer |
| `-highlightfg` | leer | Vordergrund, optional |
| `-hidden` | `0` | `1`: auch versteckte Zeilen |

```tcl
::tkutils::tkutlfind::find .t schr      ;# -> 1
.t sortbycolumn 0 -increasing
::tkutils::tkutlfind::next .t           ;# -> 2 0  (Schrauben steht jetzt unten)
```

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
::tkutils::tkutlstate::autosave        tbl schlüssel setPrefix ?-delay ms? ?-onerror befehl?
::tkutils::tkutlstate::cancelAutosave  tbl
::tkutils::tkutlstate::lastError       tbl
```

`save` liefert seit 0.4 ein Dict der Version 2: `version`, `ncols`,
`columns` in der angezeigten Reihenfolge (je Spalte `id`, `width`,
`hide`) und `sort` mit allen Sortierspalten und Richtungen. Die `id` ist
der Spaltenname (`-name`), sonst `#` und der Titel. Breite und
Sichtbarkeit hängen so an der Spalte, nicht an ihrer Nummer; `restore`
stellt die Reihenfolge mit `movecolumn` wieder her.

```tcl
.t columnconfigure 0 -name artikel
::tkutils::tkutlstate::save .t
;# -> version 2 ncols 3 columns {{id artikel width 10 hide 0}
;#    {id #Menge width 6 hide 0} {id #Preis width 8 hide 0}}
;#    sort {columns {{#Menge}} orders decreasing}
```

Zustände der Version 1 aus 0.1 bis 0.3 (nach Spaltennummer) stellt
`restore` weiter her. `autosave` speichert auch nach Verstecken und
Sortieren. Scheitert das Speichern, schickt `autosave` der Tabelle
`<<TkutlStateSaveFailed>>` (`%d` ist die Meldung), ruft `-onerror` mit
Tabelle und Meldung und merkt sich die Meldung für `lastError`, bis ein
Speichern gelingt; bis dahin verschwand der Fehler in einem `catch`. `restoreFromFile` und
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
::tkutils::tkutltree::fromData tbl daten -fields {feld ...} ?option wert ...?
::tkutils::tkutltree::toData   tbl       -fields {feld ...} ?-childrenkey children? ?-node root? ?-idfield f?
::tkutils::tkutltree::clear    tbl ?-node root?
::tkutils::tkutltree::lazy     tbl ladebefehl -fields {feld ...} ?option wert ...?
::tkutils::tkutltree::reveal   tbl index
::tkutils::tkutltree::findId   tbl id
```

Feld *i* füllt Spalte *i*. Ein fehlendes Feld wird eine leere Zelle.
`toData` liest die Rohzellen, nicht den formatierten Text. Hin und
zurück ergibt dieselbe Struktur. `fromData` fügt jede Ebene mit einem
`insertchildlist` ein und liefert seit 0.3 die Schlüssel der obersten
Knoten (bis 0.2 den Tabellenpfad).

| Option von `fromData` | Wirkung |
|---|---|
| `-childrenkey` | Schlüssel der Kindliste, Vorgabe `children` |
| `-parent` | Knoten, unter dem eingefügt wird, Vorgabe `root` |
| `-idfield f` | Wert von Feld `f` wird `-name` der Zeile |
| `-expand` | `none` alles zu, `all` alles auf, eine Zahl `N`: `N` Ebenen sichtbar; ohne Angabe wie Tablelist einfügt (aufgeklappt) |
| `-lazykey f` | ein Knoten mit wahrem Feld `f` und ohne Kinder bekommt einen Pfeil und lädt später nach |

`lazy` setzt `-expandcommand` und `-populatecommand` der Tabelle. Beim
ersten Aufklappen eines solchen Knotens, oder wenn
`searchcolumn -descend` ihn erreicht, ruft es einmal
`ladebefehl tbl schlüssel` und fügt die gelieferten Knoten ein.

```tcl
proc ladeOrdner {tbl key} {
    set dir [$tbl rowcget $key -name]
    lmap f [lsort [glob -nocomplain -directory $dir *]] {
        list pfad $f name [file tail $f] lazy [file isdirectory $f]
    }
}
tablelist::tablelist .baum -columns {30 Name left} -treecolumn 0
::tkutils::tkutltree::lazy .baum ladeOrdner -fields {name} \
    -idfield pfad -lazykey lazy
::tkutils::tkutltree::fromData .baum [list [list pfad $start name $start lazy 1]] \
    -fields {name} -idfield pfad -lazykey lazy
```

`findId` sucht eine ID im ganzen Baum (`findrowname -descend`), `reveal`
klappt die Vorfahren einer Zeile auf und rollt zu ihr. Fehlercodes:
`{TKUTILS TKUTLTREE FIELDS}` (`-fields is required`), `OPTION` und
`EXPAND` (`bad -expand "x": must be none, all or a level count`).

---

## Filtern: tkutlfilter

[tkutlfilter]{.index} versteckt die Zeilen, die nicht passen. Die Zeilen
bleiben in der Tabelle; IDs, Attribute und eingebettete Fenster bleiben
erhalten.

```tcl
::tkutils::tkutlfilter::filter tbl text ?option wert ...?
::tkutils::tkutlfilter::later  tbl ms text ?option wert ...?
::tkutils::tkutlfilter::clear  tbl
::tkutils::tkutlfilter::query  tbl
```

Eine Zeile bleibt sichtbar, wenn der Text in einer der Spalten vorkommt,
jede Bedingung aus `-where` passt und `-command` 1 liefert. `filter`
liefert die Zahl der passenden Zeilen. Ein leerer Text ohne `-where` und
`-command` hebt den Filter auf. `later` filtert erst nach `ms`
Millisekunden Ruhe und schickt danach `<<TkutlFilterApplied>>` an die
Tabelle; das passt zu `<KeyRelease>` an einem Eingabefeld. Wird die
Tabelle vorher zerstört, entfällt der wartende Aufruf.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-columns` | alle sichtbaren | Spalten für den Text |
| `-mode` | `substring` | `substring`, `exact`, `glob`, `regexp` |
| `-nocase` | `1` | ohne Großschreibung |
| `-where` | leer | `{spalte text ...}`, alle müssen passen; Spalte als Nummer, `-name` oder Titel |
| `-command` | leer | eigener Test `befehl tbl schlüssel zeile`, liefert 0 oder 1 |

```tcl
::tkutils::tkutlfilter::filter .t "" -where {Artikel u}   ;# -> 2
puts [lmap r [.t get 0 end -viewable] {lindex $r 0}]      ;# -> Muttern Schrauben
::tkutils::tkutlfilter::clear .t
```

Das Dict, das [tkufilterbar]{.index} an sein `-command` gibt, passt direkt
in `-where`. Zeilen, die die Anwendung selbst versteckt hat, bleiben
versteckt und zählen nicht mit. Im Baum bleibt ein Elternknoten
sichtbar, solange ein Nachfahre passt. `size` und `get 0 end` zählen
weiter alle Zeilen; die sichtbaren liefert `get 0 end -viewable`.
`tkutablelist::toCsv` und `tkutlclip::copyAll` nehmen nur sichtbare
Zeilen. Fehlercodes: `{TKUTILS TKUTLFILTER <GRUND>}` mit `OPTION`,
`MODE`, `REGEXP`, `WHERE`, `COLUMN`.

---

## Gruppieren: tkutlgroup

[tkutlgroup]{.index} macht aus flachen Zeilen einen Baum: je Wert einer
Schlüsselspalte eine Elternzeile, die Zeilen selbst als Kinder.

```tcl
::tkutils::tkutlgroup::group   tbl zeilen schlüsselspalte ?option wert ...?
::tkutils::tkutlgroup::ungroup tbl
```

```tcl
set orders {
    {{Tämo GmbH} Schrauben 100 200,00}
    {{Quarz KG}  Muttern    50  50,00}
    {{Tämo GmbH} Dübel      20  60,50}
}
tablelist::tablelist .o -treecolumn 0 \
    -columns {12 Kunde left 10 Artikel left 6 Menge right 8 Betrag right 4 N right}
::tkutils::tkutlgroup::group .o $orders 0 -sum {2 3} -count 4
puts [.o get 0]      ;# -> {Tämo GmbH} {} 120 260.50 2
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-sum` | leer | Spalten mit Summe in der Elternzeile |
| `-count` | leer | Spalte für die Zahl der Zeilen |
| `-blank` | `1` | Schlüsselspalte in den Kindzeilen leer |
| `-format` | `%.2f` | `format` für Summen, die keine ganze Zahl sind |
| `-font` | fett | Schrift der Elternzeilen |
| `-expand` | `1` | `0`: Gruppen zugeklappt |
| `-replace` | `1` | vorher alle Zeilen entfernen; `0` hängt die Gruppen an |

Ein zweiter Aufruf von `group` ersetzt die Gruppen; bis dahin stapelte
er sie unter die ersten. Zahlen wie `200,00` liest `tclutils::tunum`. Eine Zelle ohne Zahl zählt
als 0. Gruppen erscheinen in der Reihenfolge, in der ihr Schlüssel zuerst
vorkommt. Beim Sortieren sortiert Tablelist die Elternzeilen nach ihren
Summen und die Kinder in jeder Gruppe; die Gruppen bleiben zusammen.
`ungroup` liefert die Zeilen in der angezeigten Reihenfolge zurück, mit
gefüllter Schlüsselspalte. Fehlercodes: `{TKUTILS TKUTLGROUP OPTION}`
und `COLUMN` (`bad column "9": must be 0..4`).

---

## Ziehen: tkutldrag

[tkutldrag]{.index} lässt den Benutzer Zeilen mit der Maus umsortieren
und meldet jede Verschiebung.

```tcl
::tkutils::tkutldrag::enable  tbl ?option wert ...?
::tkutils::tkutldrag::disable tbl
::tkutils::tkutldrag::order   tbl ?eltern?
```

`enable` setzt `-movablerows`. Das wirkt nur im Auswahlmodus `single`
oder `multiple`; `enable` macht aus `browse` `single` und aus
`extended` `multiple` und liefert den Modus. `order` liefert die IDs
(`-name`) der Kinder von `eltern` (Vorgabe `root`) in der angezeigten
Reihenfolge, für Zeilen ohne ID den Schlüssel.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-command` | leer | nach dem Ablegen: `befehl tbl id eltern position` |
| `-samelevel` | `1` | nur unter Geschwistern umsortieren, keine neuen Eltern |
| `-acceptchild` | leer | eigenes `-acceptchildcommand`, ersetzt `-samelevel` |
| `-acceptdrop` | leer | eigenes `-acceptdropcommand`, ersetzt `-samelevel` |

```tcl
proc verschoben {tbl id eltern pos} {
    speichereReihenfolge [::tkutils::tkutldrag::order $tbl]
}
::tkutils::tkutldrag::enable .t -command verschoben
```

Escape bricht das Ziehen ab. Mit `-samelevel 1` darf eine Zeile im Baum
nur vor einem Geschwister landen; das Ende einer Kindliste unterhalb der
obersten Ebene ist dann kein Ziel. Eine unbekannte Option wirft
`{TKUTILS TKUTLDRAG OPTION}`.

---

## Merkliste

- `tkutltools` 0.3 lädt die zehn Helfer und `tunum`.
- Sortieren und Formatieren lassen den Rohwert in der Zelle.
- Leere Zellen in Zahlenspalten: `tkutlsort … -empty last`.
- Strg+C mit eigenem Format: `tkutlclip::installBindings`, seit 0.3
  wirksam.
- Die Fußzeile ersetzt ein vorhandenes horizontales Scrollen nicht.
- `tkutlstate` kennt nur Spalten, die es noch gibt; mit `-name` überlebt
  eine Spalte auch einen neuen Titel.
- Filtern versteckt, Suchen markiert; beide zählen über Schlüssel.

::: {.info}
**Getestet mit** Tcl/Tk 8.6.14 (Tablelist 6.20) und 9.0.4 (Tablelist
7.11) unter Linux und Xvfb: Laden von `tkutltools`, die Beispiele, die
Fehlercodes und Meldungen. Das Ziehen mit der Maus ist nur über das
Ereignis `<<TablelistRowMoved>>` geprüft, nicht mit echter Maus.
:::

---

*Nächstes Kapitel: [Geometrie und Units](060-geometry-und-units.md)*
