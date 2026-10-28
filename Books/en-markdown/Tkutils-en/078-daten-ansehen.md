# Viewing Data

The widgets of this chapter show what the engines in tclutils already
read: CSV, JSON, XML, INI, Markdown, SQLite, diff, hex, strings, Base64,
fuzzy search, ZIP and PDF structure. Plus the DAV browser and the text
editor. The engine API is in the manual *tclutils*.

`tkuxml`, `tkusqlite` and the editor are loaded separately. The other
viewers of this chapter are in the umbrella unless the chapter says
otherwise.

---

## CSV: tkucsv

[tkucsv]{.index} 0.1 shows a table through `tclutils::tucsv`.

```tcl
set w [::tkutils::tkucsv::widget .w ?-height n? ?-header 0|1?]
::tkutils::tkucsv::setData  $w text ?option wert ...?
::tkutils::tkucsv::loadFile $w pfad ?option wert ...?
::tkutils::tkucsv::getRows  $w
```

Options of `setData` and `loadFile` go to `tucsv::parse`. `getRows`
returns all rows, the header row included.

---

## JSON: tkujson

[tkujson]{.index} 0.1 shows the tree of `tujson::parseTyped`. Objects,
arrays and scalars stay distinct.

```tcl
set w [::tkutils::tkujson::widget .w ?-height n?]
::tkutils::tkujson::setJson  $w text
::tkutils::tkujson::loadFile $w pfad
::tkutils::tkujson::getTree  $w
```

`setJson` returns the type of the root. `getTree` returns
`{type value}`. An object appears as `object (n)`, an array as
`array (n)`. Keys keep their order. Array elements are called `[0]`,
`[1]` and so on.

---

## XML: tkuxml

[tkuxml]{.index} 0.1 needs tDOM and is outside the umbrella.

```tcl
set w [::tkutils::tkuxml::widget .w ?-height n?]
::tkutils::tkuxml::setXml   $w text
::tkutils::tkuxml::loadFile $w pfad
::tkutils::tkuxml::getRoot  $w
```

`setXml` returns the name of the root element. The tree shows element
names, attributes and text.

---

## INI: tkuini

[tkuini]{.index} 0.2 shows sections on the left and the pairs of the
selected section on the right. The section `""` is called `(global)`.
The engine is `tclutils::tuini`.

```tcl
set w [::tkutils::tkuini::widget .w]
::tkutils::tkuini::loadText       $w text
::tkutils::tkuini::loadFile       $w datei
::tkutils::tkuini::sections       $w
::tkutils::tkuini::selectSection  $w abschnitt
::tkutils::tkuini::currentSection $w
::tkutils::tkuini::data           $w
```

`loadText` returns the number of sections.

---

## Markdown: tkumd and tkumdview

[tkumd]{.index} 0.1 shows the headings as a tree through
`tclutils::tumd`.

```tcl
set w [::tkutils::tkumd::widget .w ?-height n?]
::tkutils::tkumd::setMarkdown $w text
::tkutils::tkumd::loadFile    $w pfad
::tkutils::tkumd::getHeadings $w
```

`getHeadings` returns a list `{level title}`.

[tkumdview]{.index} 0.1 shows the same outline and a preview.

```tcl
set w [::tkutils::tkumdview::widget .w ?-width n? ?-height n?]
::tkutils::tkumdview::loadFile    $w pfad
::tkutils::tkumdview::setMarkdown $w text
::tkutils::tkumdview::getMarkdown $w
::tkutils::tkumdview::headings    $w
::tkutils::tkumdview::toHtml      $w
```

`loadFile` reads UTF-8. `loadFile` and `setMarkdown` return the number
of characters. `tocWidget` and `textWidget` return the two inner
widgets.

---

## SQLite: tkusqlite

[tkusqlite]{.index} 0.1 needs the package `sqlite3` and is outside the
umbrella. The tables are on the left, the rows of the selected table on
the right. `tclutils::tusqlite` is the engine without a user interface.

```tcl
set w [::tkutils::tkusqlite::widget .w ?-height n?]
::tkutils::tkusqlite::openFile  $w datei
::tkutils::tkusqlite::tables    $w
::tkutils::tkusqlite::showTable $w name
::tkutils::tkusqlite::getRows   $w
::tkutils::tkusqlite::closeDb   $w
```

`openFile` also takes `:memory:` and returns the number of tables.
`showTable` returns the number of rows.

---

## Diff, Hex, Strings, Base64

[tkudiff]{.index} 0.1 shows a line comparison through
`tclutils::tudiff`.

```tcl
set w [::tkutils::tkudiff::widget .w ?-width n? ?-height n?]
::tkutils::tkudiff::setTexts  $w alt neu ?option wert ...?
::tkutils::tkudiff::loadFiles $w alt neu ?option wert ...?
::tkutils::tkudiff::getOps    $w
```

Options go to `tudiff::text`. `getOps` returns a list `{op token}`.

[tkuhexedit]{.index} 0.1 shows and changes bytes through `tuhexdump` and
`tubin`.

```tcl
set w [::tkutils::tkuhexedit::widget .hex]
::tkutils::tkuhexedit::loadFile   $w datei
::tkutils::tkuhexedit::gotoOffset $w 0x100
::tkutils::tkuhexedit::findHex    $w {50 4B 03 04}
::tkutils::tkuhexedit::patchHex   $w 0x100 {00 FF}
::tkutils::tkuhexedit::saveFile   $w
```

[tkustrings]{.index} 0.1 lists readable ASCII runs through
`tclutils::tustrings`. `setData` and `loadFile` take `-minlength` and
return the count. `getStrings` returns the runs.

[tkubase64]{.index} 0.1 encodes and decodes through
`tclutils::tubase64`. `encode` and `decode` return the output text.
`setInput`, `getInput` and `getOutput` read and write the two fields.

---

## Fuzzy List: tkufuzzy

[tkufuzzy]{.index} 0.1 filters a list through `tclutils::tufuzzy`.

```tcl
set w [::tkutils::tkufuzzy::widget .w ?-height n?]
::tkutils::tkufuzzy::setItems     $w liste
::tkutils::tkufuzzy::filter       $w muster
::tkutils::tkufuzzy::getMatches   $w
::tkutils::tkufuzzy::getSelection $w
```

`filter` returns the matches by rank and sets the displayed list.
`getSelection` returns the selected entry or `""`.

---

## ZIP: tkuzip

[tkuzip]{.index} 0.1 lists the members of an archive through
`tclutils::tuzip`: name, uncompressed size, compressed size, method.

```tcl
set w [::tkutils::tkuzip::widget .w ?-height n?]
::tkutils::tkuzip::openFile       $w archiv
::tkutils::tkuzip::getEntries     $w
::tkutils::tkuzip::selectedMember $w
```

`openFile` returns the number of members. `getEntries` returns the dicts
of `tuzip::entries`. `selectedMember` returns the name or `""`.

---

## PDF Structure: tkupdfinspect

[tkupdfinspect]{.index} 0.1 shows the structure of a PDF file through
`tclutils::tupdf`. The text of the pages is a different task
(`tupdftext` in the manual *tclutils*).

```tcl
set w [::tkutils::tkupdfinspect::widget .w ?-width n? ?-height n?]
::tkutils::tkupdfinspect::loadFile    $w pfad
::tkutils::tkupdfinspect::currentFile $w
::tkutils::tkupdfinspect::summary     $w
```

`loadFile` fills the tree and returns the path. `summary` is the dict of
the last load. `currentFile` is `""` as long as nothing is loaded.
`treeWidget` and `textWidget` return tree and detail text. The detail is
read-only.

---

## DAV

[tkudavaccount]{.index} 0.1 is the form for URL, user, password and kind
(`carddav`, `caldav`, `webdav`). The test button sends a PROPFIND
through `tclutils::tudav` and blocks meanwhile.

```tcl
set a [::tkutils::tkudavaccount::widget .a ?-type carddav? ?-command befehl?]
::tkutils::tkudavaccount::setConfig $a {url https://h/c/ user alice password pw}
::tkutils::tkudavaccount::testConnection $a
```

`testConnection` returns `1` or `0`. `-command` receives `ok` and a
message.

[tkudavbrowser]{.index} 0.2 lists the collections of a CalDAV or CardDAV
server, grouped by kind. It is read-only, except with `-editable 1`.

```tcl
set b [::tkutils::tkudavbrowser::widget .b ?-oncollection befehl?]
::tkutils::tkudavbrowser::setClient .b $client
::tkutils::tkudavbrowser::refresh    .b
::tkutils::tkudavbrowser::setData    .b $sammlungen
```

`refresh` calls `discover` and `listCollections` and blocks. The same
href appears once, even when a server returns both kinds from one home
set. `setData` builds the tree from ready-made dicts
`{href displayname kind}` without network access. `-oncollection`
receives the widget and the dict of the selection. `collections` returns
the flat list, `selected` the dict or `{}`.

---

## Editor: tkueditor

[tkueditor]{.index} 0.2 is a text editor with a toolbar and a status
line. It requires `tkuicon`, `tkutoolbar` and `tkustatus`, plus
`tclutils::tuiconv`. The module header calls it a prototype.

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

`setText` clears the "modified" flag. `find` returns an index or `""`.
`replace` returns the count. `readonly` locks input; `setText` remains
possible. `statusbarWidget` returns the `tkustatus` bar, or `""` when it
is switched off.

---

## In short

- The viewers call the engine of the same name in tclutils. XML needs
  tDOM, SQLite the package `sqlite3`.
- `tkujson::setJson` returns the type of the root, `tkuxml::setXml` the
  name of the root element.
- `tkudavbrowser::setData` builds the tree without network access.
  `refresh` blocks.
- `tkueditor` 0.2 is marked as a prototype.

---

*Next chapter: [Designer and load](080-designer-und-load.md)*
