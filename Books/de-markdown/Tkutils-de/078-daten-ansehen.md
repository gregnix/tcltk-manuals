# Daten ansehen

Die Widgets dieses Kapitels zeigen, was die Engines in tclutils schon
lesen: CSV, JSON, XML, INI, Markdown, SQLite, Diff, Hex, Zeichenketten,
Base64, unscharfe Suche, ZIP und PDF-Struktur. Dazu der DAV-Browser,
der Texteditor und die Systemübersicht. Die API der Engine steht im Handbuch tclutils.

`tkuxml`, `tkusqlite`, `tkusysinfo` und der Editor laden extra. Die übrigen Viewer
dieses Kapitels liegen im Umbrella, soweit das Kapitel es nicht
anders sagt.

---

## CSV: tkucsv

[tkucsv]{.index} 0.1 zeigt eine Tabelle über `tclutils::tucsv`.

```tcl
set w [::tkutils::tkucsv::widget .w ?-height n? ?-header 0|1?]
::tkutils::tkucsv::setData  $w text ?option wert ...?
::tkutils::tkucsv::loadFile $w pfad ?option wert ...?
::tkutils::tkucsv::getRows  $w
```

Optionen von `setData` und `loadFile` gehen an `tucsv::parse`.
`getRows` liefert alle Zeilen, die Kopfzeile eingeschlossen.

---

## JSON: tkujson

[tkujson]{.index} 0.1 zeigt den Baum von `tujson::parseTyped`. Objekte,
Arrays und Skalare bleiben unterschieden.

```tcl
set w [::tkutils::tkujson::widget .w ?-height n?]
::tkutils::tkujson::setJson  $w text
::tkutils::tkujson::loadFile $w pfad
::tkutils::tkujson::getTree  $w
```

`setJson` liefert den Typ der Wurzel. `getTree` liefert `{typ wert}`.
Ein Objekt erscheint als `object (n)`, ein Array als `array (n)`.
Schlüssel behalten ihre Reihenfolge. Array-Elemente heißen `[0]`,
`[1]` und so fort.

---

## XML: tkuxml

[tkuxml]{.index} 0.1 braucht tDOM und steht außerhalb des Umbrellas.

```tcl
set w [::tkutils::tkuxml::widget .w ?-height n?]
::tkutils::tkuxml::setXml   $w text
::tkutils::tkuxml::loadFile $w pfad
::tkutils::tkuxml::getRoot  $w
```

`setXml` liefert den Namen des Wurzelelements. Der Baum zeigt
Elementnamen, Attribute und Text.

---

## INI: tkuini

[tkuini]{.index} 0.3 zeigt Abschnitte links und die Paare des gewählten
Abschnitts rechts. Der Abschnitt `""` heißt `(global)`. Die Engine ist
`tclutils::tuini`.

```tcl
set w [::tkutils::tkuini::widget .w]
::tkutils::tkuini::loadText       $w text
::tkutils::tkuini::loadFile       $w datei
::tkutils::tkuini::sections       $w
::tkutils::tkuini::selectSection  $w abschnitt
::tkutils::tkuini::currentSection $w
::tkutils::tkuini::data           $w
```

`loadText` liefert die Zahl der Abschnitte. `loadFile` und `save` arbeiten
in UTF-8, gleich welches Encoding das System hat (seit 0.3).

Mit `tuini` 0.2 werfen `setKey` und `addSection`
`{TCLUTILS TUINI VALUE}`, wenn INI den Wert nicht fassen kann, etwa einen
Zeilenumbruch; die Daten bleiben dann unverändert. Die Bearbeitungsleiste
schneidet Leerzeichen am Rand von Schlüssel und Abschnitt ab und zeigt
einen solchen Fehler als Meldung.

---

## Markdown: tkumd und tkumdview

[tkumd]{.index} 0.1 zeigt die Überschriften als Baum über
`tclutils::tumd`.

```tcl
set w [::tkutils::tkumd::widget .w ?-height n?]
::tkutils::tkumd::setMarkdown $w text
::tkutils::tkumd::loadFile    $w pfad
::tkutils::tkumd::getHeadings $w
```

`getHeadings` liefert eine Liste `{stufe titel}`.

[tkumdview]{.index} 0.1 zeigt dieselbe Gliederung und eine Vorschau.

```tcl
set w [::tkutils::tkumdview::widget .w ?-width n? ?-height n?]
::tkutils::tkumdview::loadFile    $w pfad
::tkutils::tkumdview::setMarkdown $w text
::tkutils::tkumdview::getMarkdown $w
::tkutils::tkumdview::headings    $w
::tkutils::tkumdview::toHtml      $w
```

`loadFile` liest UTF-8. `loadFile` und `setMarkdown` liefern die
Zeichenzahl. `tocWidget` und `textWidget` liefern die beiden inneren
Widgets.

---

## SQLite: tkusqlite

[tkusqlite]{.index} 0.1 braucht das Paket `sqlite3` und steht außerhalb
des Umbrellas. Links stehen die Tabellen, rechts die Zeilen der
gewählten Tabelle. `tclutils::tusqlite` ist die Engine ohne Oberfläche.

```tcl
set w [::tkutils::tkusqlite::widget .w ?-height n?]
::tkutils::tkusqlite::openFile  $w datei
::tkutils::tkusqlite::tables    $w
::tkutils::tkusqlite::showTable $w name
::tkutils::tkusqlite::getRows   $w
::tkutils::tkusqlite::closeDb   $w
```

`openFile` nimmt auch `:memory:` und liefert die Zahl der Tabellen.
`showTable` liefert die Zahl der Zeilen.

---

## Diff, Hex, Zeichenketten, Base64

[tkudiff]{.index} 0.1 zeigt einen Zeilenvergleich über
`tclutils::tudiff`.

```tcl
set w [::tkutils::tkudiff::widget .w ?-width n? ?-height n?]
::tkutils::tkudiff::setTexts  $w alt neu ?option wert ...?
::tkutils::tkudiff::loadFiles $w alt neu ?option wert ...?
::tkutils::tkudiff::getOps    $w
```

Optionen gehen an `tudiff::text`. `getOps` liefert eine Liste
`{op token}`.

[tkuhexedit]{.index} 0.2 zeigt und ändert Bytes über `tuhexdump` und
`tubin`. `saveFile` schreibt über eine temporäre Datei; scheitert das
Schreiben, bleibt die alte Datei stehen.

```tcl
set w [::tkutils::tkuhexedit::widget .hex]
::tkutils::tkuhexedit::loadFile   $w datei
::tkutils::tkuhexedit::gotoOffset $w 0x100
::tkutils::tkuhexedit::findHex    $w {50 4B 03 04}
::tkutils::tkuhexedit::patchHex   $w 0x100 {00 FF}
::tkutils::tkuhexedit::saveFile   $w
```

[tkustrings]{.index} 0.1 listet lesbare ASCII-Folgen über
`tclutils::tustrings`. `setData` und `loadFile` nehmen `-minlength` und
liefern die Zahl. `getStrings` liefert die Folgen.

[tkubase64]{.index} 0.2 kodiert und dekodiert über `tclutils::tubase64`.
`encode` und `decode` liefern den Ausgabetext. `setInput`, `getInput`
und `getOutput` lesen und schreiben die beiden Felder. Die Felder
halten Text: `encode` wandelt ihn zuerst nach UTF-8, `decode` liest die
Bytes als UTF-8, so wird `Jörg €` zu `SsO2cmcg4oKs` und kommt
unverändert zurück. Bis 0.1 brach `€` unter Tcl 9 ab, und `ö` wurde ein
Byte.

---

## Unscharfe Liste: tkufuzzy

[tkufuzzy]{.index} 0.1 filtert eine Liste über `tclutils::tufuzzy`.

```tcl
set w [::tkutils::tkufuzzy::widget .w ?-height n?]
::tkutils::tkufuzzy::setItems     $w liste
::tkutils::tkufuzzy::filter       $w muster
::tkutils::tkufuzzy::getMatches   $w
::tkutils::tkufuzzy::getSelection $w
```

`filter` liefert die Treffer nach Rang und setzt die angezeigte Liste.
`getSelection` liefert den gewählten Eintrag oder `""`.

---

## ZIP: tkuzip

[tkuzip]{.index} 0.1 listet die Mitglieder eines Archivs über
`tclutils::tuzip`: Name, Größe ungepackt, Größe gepackt, Methode.

```tcl
set w [::tkutils::tkuzip::widget .w ?-height n?]
::tkutils::tkuzip::openFile       $w archiv
::tkutils::tkuzip::getEntries     $w
::tkutils::tkuzip::selectedMember $w
```

`openFile` liefert die Zahl der Mitglieder. `getEntries` liefert die
Dicts von `tuzip::entries`. `selectedMember` liefert den Namen oder
`""`.

---

## PDF-Struktur: tkupdfinspect

[tkupdfinspect]{.index} 0.1 zeigt den Aufbau einer PDF-Datei über
`tclutils::tupdf`. Der Text der Seiten ist eine andere Aufgabe
(`tupdftext` im Handbuch tclutils).

```tcl
set w [::tkutils::tkupdfinspect::widget .w ?-width n? ?-height n?]
::tkutils::tkupdfinspect::loadFile    $w pfad
::tkutils::tkupdfinspect::currentFile $w
::tkutils::tkupdfinspect::summary     $w
```

`loadFile` füllt den Baum und liefert den Pfad. `summary` ist das
Dict des letzten Ladens. `currentFile` ist `""`, solange nichts
geladen ist. `treeWidget` und `textWidget` liefern Baum und
Detailtext. Das Detail ist nur lesbar.

---

## DAV

[tkudavaccount]{.index} 0.1 ist das Formular für URL, Benutzer,
Passwort und Art (`carddav`, `caldav`, `webdav`). Der Prüfknopf macht
ein PROPFIND über `tclutils::tudav` und blockiert so lange.

```tcl
set a [::tkutils::tkudavaccount::widget .a ?-type carddav? ?-command befehl?]
::tkutils::tkudavaccount::setConfig $a {url https://h/c/ user alice password pw}
::tkutils::tkudavaccount::testConnection $a
```

`testConnection` liefert `1` oder `0`. `-command` bekommt `ok` und
eine Meldung.

[tkudavbrowser]{.index} 0.2 listet Sammlungen eines CalDAV- oder
CardDAV-Servers, gruppiert nach Art. Er ist nur lesend, außer mit
`-editable 1`.

```tcl
set b [::tkutils::tkudavbrowser::widget .b ?-oncollection befehl?]
::tkutils::tkudavbrowser::setClient .b $client
::tkutils::tkudavbrowser::refresh    .b
::tkutils::tkudavbrowser::setData    .b $sammlungen
```

`refresh` ruft `discover` und `listCollections` und blockiert. Dieselbe
Href erscheint einmal, auch wenn ein Server beide Arten aus einem
Home-Set liefert. `setData` baut den Baum aus fertigen Dicts
`{href displayname kind}` ohne Netz. `-oncollection` bekommt das
Widget und das Dict der Auswahl. `collections` liefert die flache
Liste, `selected` das Dict oder `{}`.

---

## Editor: tkueditor

[tkueditor]{.index} 0.4 ist ein Texteditor mit Leiste und Statuszeile.
Er fordert `tkuicon`, `tkutoolbar` und `tkustatus` an, dazu
`tclutils::tuiconv`.

```tcl
set w [::tkutils::tkueditor::widget .w ?-width n? ?-height n? ?-wrap modus?]
::tkutils::tkueditor::setText    $w text
::tkutils::tkueditor::getText    $w
::tkutils::tkueditor::loadFile   $w pfad ?-encoding name?
::tkutils::tkueditor::saveFile   $w ?pfad? ?-encoding name? ?-eol lf|crlf|cr?
::tkutils::tkueditor::find       $w nadel ?-from index? ?-nocase?
::tkutils::tkueditor::replace    $w nadel ersatz ?-all? ?-nocase?
::tkutils::tkueditor::gotoLine   $w n
::tkutils::tkueditor::isModified $w
```

`setText` löscht die Markierung „geändert". `find` liefert einen Index
oder `""`. `replace` liefert die Zahl. `readonly` sperrt die Eingabe.
`setText` bleibt dabei möglich. `statusbarWidget` liefert die
`tkustatus`-Leiste oder `""`, wenn sie aus ist.

Zeilenenden erkennt `loadFile` als `lf`, `crlf`, `cr` oder `mixed`
(mehrere Arten in einer Datei); `eol` liefert den Stil. Eine gemischte
Datei, unverändert gespeichert, bleibt Byte für Byte gleich; nach einer
Änderung schreibt `saveFile` die häufigste Art und sagt das in der
Statuszeile. Bis 0.2 machte ein einziges CRLF die ganze Datei zu CRLF,
ein einzelnes CR wurde LF.

Die Kodierung läuft über `tclutils::tuiconv`. Mit `tuiconv` 0.2 ist sie
auch unter Tcl 8.6 streng: `loadFile` wirft
`{TCLUTILS TUICONV INVALID enc}`, wenn die Datei in der Kodierung
ungültig ist, `saveFile` wirft `{TCLUTILS TUICONV UNMAPPABLE enc}`, wenn
ein Zeichen darin nicht darstellbar ist; die Datei bleibt dann, wie sie
war. Die Knöpfe „Open“ und „Save“ der Leiste fangen diese Fehler ab,
ebenso eine Datei, die sich nicht lesen oder schreiben lässt: Ein
Meldungsfenster und die Statuszeile nennen Datei und Grund, der Text im
Editor bleibt (seit 0.4; bis 0.3 ging der Fehler an `bgerror`).

---

## System: tkusysinfo

[tkusysinfo]{.index} 0.1 zeigt, was `tclutils::tusysinfo` über den Rechner
sammelt: Betriebssystem, Prozessor, Speicher, Modell, Festplatten und
Monitore, dazu einen Abschnitt „Screen“ aus Tk selbst (Pixel,
Millimeter, DPI, `tk scaling`, Farbtiefe, Fenstersystem). Knöpfe:
*Refresh*, *Copy* (Textbericht in die Zwischenablage), *Save...* (Text
oder JSON). Nicht im Umbrella, weil es `tusysinfo` aus tclutils 0.69.0
braucht.

```tcl
set w [::tkutils::tkusysinfo::widget .si ?option wert ...?]
::tkutils::tkusysinfo::refresh $w            ;# neu sammeln -> Dict; ein Fehler steht in der Statuszeile
::tkutils::tkusysinfo::data    $w            ;# letztes Dict
::tkutils::tkusysinfo::report  $w ?-anonymize 0|1?
::tkutils::tkusysinfo::json    $w
::tkutils::tkusysinfo::save    $w datei ?-format text|json? ?-anonymize 0|1?
::tkutils::tkusysinfo::screen  fenster       ;# Tk-Bildschirmdaten
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-sections` | alle | Abschnitte von `tusysinfo` |
| `-serials` | `0` | `1` zeigt Seriennummern |
| `-timeout` | `10000` | Grenze je Programmaufruf in ms |
| `-autoload` | `1` | gleich beim Aufbau sammeln |
| `-height` | `16` | sichtbare Zeilen |
| `-buttons` | `1` | `0` ohne Knopfleiste |

```tcl
package require tkutils::tkusysinfo
pack [::tkutils::tkusysinfo::widget .si -sections {os cpu memory}] \
    -fill both -expand 1
dict keys [::tkutils::tkusysinfo::screen .]
;# -> pixels millimeters dpi scaling depth windowing
```

Tk sieht nur einen Bildschirm: Bei mehreren Monitoren ist `pixels` unter
Linux die ganze X-Arbeitsfläche, unter Windows und macOS der
Hauptmonitor. Die Monitore selbst stehen unter „Monitors“, aus ihrer
EDID. Unter macOS dauert das Sammeln einige Sekunden; der Mauszeiger
zeigt solange `watch`. Eine unbekannte Option wirft
`{TKUTILS TKUSYSINFO OPTION <opt>}`, ein anderes Format bei `save`
`{TKUTILS TKUSYSINFO FORMAT}`.

---

## Merkliste

- Die Viewer rufen die gleichnamige Engine in tclutils. XML braucht tDOM, SQLite das Paket `sqlite3`.
- `tkujson::setJson` liefert den Typ der Wurzel, `tkuxml::setXml` den Namen des Wurzelelements.
- `tkudavbrowser::setData` baut den Baum ohne Netz. `refresh` blockiert.
- `tkueditor` behält gemischte Zeilenenden, solange der Text unverändert ist.
- `tkusysinfo` braucht tclutils 0.69.0 und liegt deshalb außerhalb des Umbrellas.

---

*Nächstes Kapitel: [Designer und load](080-designer-und-load.md)*
