# Daten ansehen

Die Widgets dieses Kapitels zeigen, was die Engines in tclutils schon
lesen: CSV, JSON, XML, INI, Markdown, SQLite, Diff, Hex, Zeichenketten,
Base64, unscharfe Suche, ZIP und PDF-Struktur. Dazu der DAV-Browser
und der Texteditor. Die API der Engine steht im Handbuch tclutils.

`tkuxml`, `tkusqlite` und der Editor laden extra. Die übrigen Viewer
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

[tkuini]{.index} 0.2 zeigt Abschnitte links und die Paare des gewählten
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

`loadText` liefert die Zahl der Abschnitte.

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

[tkuhexedit]{.index} 0.1 zeigt und ändert Bytes über `tuhexdump` und
`tubin`.

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

[tkubase64]{.index} 0.1 kodiert und dekodiert über `tclutils::tubase64`.
`encode` und `decode` liefern den Ausgabetext. `setInput`, `getInput`
und `getOutput` lesen und schreiben die beiden Felder.

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

[tkueditor]{.index} 0.2 ist ein Texteditor mit Leiste und Statuszeile.
Er fordert `tkuicon`, `tkutoolbar` und `tkustatus` an, dazu
`tclutils::tuiconv`. Der Kopf des Moduls nennt ihn Prototyp.

```tcl
set w [::tkutils::tkueditor::widget .w ?-width n? ?-height n? ?-wrap modus?]
::tkutils::tkueditor::setText    $w text
::tkutils::tkueditor::getText    $w
::tkutils::tkueditor::loadFile   $w pfad ?-encoding name?
::tkutils::tkueditor::saveFile   $w ?pfad? ?-encoding name? ?-eol lf|crlf?
::tkutils::tkueditor::find       $w nadel ?-from index? ?-nocase?
::tkutils::tkueditor::replace    $w nadel ersatz ?-all? ?-nocase?
::tkutils::tkueditor::gotoLine   $w n
::tkutils::tkueditor::isModified $w
```

`setText` löscht die Markierung „geändert". `find` liefert einen Index
oder `""`. `replace` liefert die Zahl. `readonly` sperrt die Eingabe.
`setText` bleibt dabei möglich. `statusbarWidget` liefert die
`tkustatus`-Leiste oder `""`, wenn sie aus ist.

---

## Merkliste

- Die Viewer rufen die gleichnamige Engine in tclutils. XML braucht tDOM, SQLite das Paket `sqlite3`.
- `tkujson::setJson` liefert den Typ der Wurzel, `tkuxml::setXml` den Namen des Wurzelelements.
- `tkudavbrowser::setData` baut den Baum ohne Netz. `refresh` blockiert.
- `tkueditor` 0.2 ist als Prototyp gekennzeichnet.

---

*Nächstes Kapitel: [Designer und load](080-designer-und-load.md)*
