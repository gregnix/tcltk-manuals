# Data Formats

CSV, JSON and INI are pure Tcl and need no third-party package. Amounts
are read by `tunum` in the chapter
[Characters, Numbers, Dates and Paths](045-zeichen-zahlen-datum.md), the
text of a PDF in the chapter
[Text from PDF Files](055-pdf-text.md). Base64, digests and dicts
are described in the chapter
[Encoding, Hashing and Comparing](052-kodierung-hash-vergleich.md).
Markdown, iCalendar, vCard and notes are described in the chapter
[Notes and Calendars](054-notizen-und-kalender.md).

---

## CSV: tucsv

[tucsv]{.index} splits lines, joins them again and reads a table
into dicts. It is not an import framework.

| Command | Effect |
|---|---|
| `parseLine zeile` | one line to a list; `-delimiter` (default comma), `-quote` (default `"`), `-trim` (default 0) |
| `joinLine felder` | a list to a line; the same `-delimiter` and `-quote`, plus `-alwaysQuote` (default 0) |
| `parse text ?optionen?` | lines to a list of field lists; a field may contain a line break |
| `text zeilen ?optionen?` | field lists back to text; additionally `-newline` |
| `dicts zeilen` | the first line becomes the header, each further line a dict |
| `file pfad ?optionen?` | a file, like `parse` |
| `writeFile pfad zeilen ?optionen?` | writes a file |

A field with a comma, a quote or a line break is put in
quotes. A quote inside the field is doubled.
`-alwaysQuote 1` puts every field in quotes.

```tcl
package require tclutils::tucsv
::tclutils::tucsv::parseLine {a,"b,c","d""e"}
                                          ;# -> a {b,c} {d"e}
::tclutils::tucsv::joinLine [list a {b,c} {d"e}]
                                          ;# -> a,"b,c","d""e"
set zeilen [::tclutils::tucsv::parse "name;city\nAlice;Berlin" -delimiter {;}]
                                          ;# -> {name city} {Alice Berlin}
::tclutils::tucsv::dicts $zeilen          ;# -> {name Alice city Berlin}
::tclutils::tucsv::parse "a,\"b\nc\",d"   ;# -> a {b\nc} d
```

`-strict 1` is the default. An unclosed quote throws
`{TCLUTILS TUCSV QUOTE}` with `unterminated quoted field`.
`-strict 0` takes the rest as a field and does not throw. `parse`
removes a leading UTF-8 BOM by itself; this is stated in `docs/tucsv.md`.

Fields without quotes, cut only at the delimiter, belong
to `tucut` in the chapter [Text and Files](040-text-und-dateien.md).

---

## JSON: tujson

[tujson]{.index} reads and writes JSON. It is not JSON5: no comments,
no trailing commas, no JSONPath, no streaming.

`parse` and `fromJson` return Tcl values. The distinction between
object, array and scalar is lost in the process.

| JSON | Tcl from `parse` |
|---|---|
| object | dict, keys in the order of the text |
| array | list |
| string | string |
| number | the digit text from the source |
| `true` / `false` | `1` / `0` |
| `null` | empty string |

```tcl
package require tclutils::tujson
set d [::tclutils::tujson::parse {{"name":"Gregor","items":[1,2],"ok":true,"x":null}}]
dict get $d name                          ;# -> Gregor
dict get $d items                         ;# -> 1 2
dict get $d ok                            ;# -> 1
dict get $d x                             ;# -> (leer)
```

Malformed text throws `{TCLUTILS TUJSON PARSE offset}`. For `{`
alone the message is `invalid JSON at offset 1: expected object key string`.

`parseTyped` keeps the kind. Each node is `{art wert}`:

| Kind | Value |
|---|---|
| `object` | dict, key to a node |
| `array` | list of nodes |
| `string` | the string |
| `number` | the digits from the source |
| `boolean` | `true` or `false` |
| `null` | empty |

```tcl
::tclutils::tujson::parseTyped {{"tags":["x"],"n":1}}
    ;# -> object {tags {array {{string x}}} n {number 1}}
```

`toJson` writes such a tree back. The constructors `str`, `num`,
`bool`, `null`, `obj` and `arr` build it by hand. `-indent N` with
N > 0 breaks lines, N spaces per level. The default 0 is a single
line. An unknown kind throws `{TCLUTILS TUJSON TYPE}`.

```tcl
set doc [::tclutils::tujson::obj [list \
    name [::tclutils::tujson::str Alice] \
    n    [::tclutils::tujson::num 1] \
    z    [::tclutils::tujson::null]]]
::tclutils::tujson::toJson $doc
    ;# -> {"name":"Alice","n":1,"z":null}
```

`quote` and `escape` put a string in JSON quotes.
`validate` checks without building a value. `minify` and `pretty`
format text, `fileMinify` and `filePretty` a file.
On the command line: `tclsh bin/tujson.tcl validate|minify|pretty|parse datei`.

`true` as `1` and `null` as empty are intended behavior of `parse`. If
the kind matters, use `parseTyped`.

---

## INI: tuini

[tuini]{.index} reads INI into a dict: section to a dict of key to
value. Keys before the first `[section]` are in the section `""`.
The order is kept. Comments with `#` or `;` are dropped.

| Command | Effect |
|---|---|
| `parse text` | the dict |
| `toIni dict` | INI text, `schlüssel=wert` without spaces around `=` |
| `sections dict` | the section names |
| `keys dict ?abschnitt?` | the keys |
| `get dict abschnitt schlüssel ?vorgabe?` | the value, or the default |
| `has dict abschnitt schlüssel` | 1 or 0 |
| `setValue dict abschnitt schlüssel wert` | a copy with the new value |
| `addSection dict abschnitt` | a copy in which the section exists |
| `removeKey`, `removeSection` | a copy without the key or section |

`setValue` does not change the dict passed in.

```tcl
package require tclutils::tuini
set ini [::tclutils::tuini::parse "# k\n\n\[lager\]\nort = Nord\n"]
::tclutils::tuini::sections $ini             ;# -> lager
::tclutils::tuini::get $ini lager ort        ;# -> Nord
::tclutils::tuini::get $ini lager fehlt -    ;# -> -
set ini [::tclutils::tuini::setValue $ini lager gang 3]
::tclutils::tuini::toIni $ini                ;# -> \[lager\]\nort=Nord\ngang=3
```

An unclosed section throws `{TCLUTILS TUINI SYNTAX}`,
for example `unterminated section header: [offen`. The same limit applies to
values with a line break in `tusettings`, chapter
[tusettings](080-tusettings.md): the module stores INI and passes
the syntax on to `tuini`.

---

## XML: tuxml

[tuxml]{.index} writes small elements. It does not validate a document
and knows no XPath. `escape` converts `&`, `<` and `>`; with `-quotes 1`
also quotes. `unescape` resolves the predefined entities and
`&#…;`. `textElement` escapes the text, `element` inserts it raw.

```tcl
package require tclutils::tuxml
::tclutils::tuxml::declaration               ;# -> <?xml version="1.0" encoding="UTF-8"?>
::tclutils::tuxml::textElement lager {ort Nord} {a < b}
                                          ;# -> <lager ort="Nord">a &lt; b</lager>
```

A name that does not start with a letter or `_` throws
`{TCLUTILS TUXML NAME <name>}`, an attribute name
`{TCLUTILS TUXML ATTR <name>}`.

---

## SQLite: tusqlite

[tusqlite]{.index} opens no database and does not load `sqlite3`. The
caller passes an open handle. `insert` builds the statement in
its own scope so that a value does not bind to a variable
of the caller. `rows` returns dicts in the order of the
rows. `value` takes the first column of the first row, otherwise the
default.

A value equal to `[tusqlite::null]` becomes SQL NULL. `rows` returns this
cell as an empty string. `quoteId` puts a name in
quotes and doubles a quote inside it.

```tcl
package require sqlite3
package require tclutils::tusqlite
sqlite3 db :memory:
db eval {create table lager (ort text, gang integer)}
::tclutils::tusqlite::insert db lager {ort Nord gang 3}
                                          ;# -> 1
::tclutils::tusqlite::rows db {select ort, gang from lager}
                                          ;# -> {ort Nord gang 3}
::tclutils::tusqlite::value db {select gang from lager where ort = 'x'} -
                                          ;# -> -
```

An empty dict throws `{TCLUTILS TUSQLITE EMPTY}`.

---

## LDIF: tuldif

[tuldif]{.index} reads LDIF according to RFC 2849 into a list of entries and
writes them back. An entry is an ordered list of pairs
`{attribut wert}`. `dn` is an attribute like any other; a
multi-valued attribute appears several times in the list.

| Command | Effect |
|---|---|
| `parse text` | list of entries; a blank line separates two entries |
| `toLdif einträge` | LDIF text, a blank line after each entry |
| `dn eintrag` | value of `dn`, otherwise the empty string |
| `get eintrag attribut` | all values of the attribute; case does not matter |
| `attributes eintrag` | attribute names in the order of first appearance |
| `toDict eintrag` | dict of attribute to list of values |
| `addAttr eintrag attribut wert` | a copy with the pair appended |
| `setAttr eintrag index attribut wert` | a copy with the pair at `index` replaced |
| `removeAttr eintrag index` | a copy without the pair at `index` |

`parse` skips comment lines with `#` and the `version:` line. A
line that starts with a space continues the previous one. A
value `attr:: …` is decoded through `tubase64` and read as UTF-8,
because LDIF values are UTF-8 according to RFC 2849. Bytes that do not
form valid UTF-8 (a binary attribute such as `jpegPhoto`) stay bytes, one
character per byte. With `attr:< url`, the URL itself is the value; no
file is read.

`toLdif` writes a value as Base64 if it starts with a space, `:`
or `<`, ends with a space or contains a character
outside ASCII 32–126. Before Base64, the value is converted to UTF-8;
`Hällo` becomes `SMOkbGxv`, and a character above 255 such as `€` works
the same way. `toLdif` does not wrap long lines.

```tcl
package require tclutils::tuldif
set ldif "dn: cn=Alice,dc=ex\ncn: Alice\nmail: a@ex.com\n"
append ldif "mail: alice@ex.com\n\ndn: cn=Bob,dc=ex\ncn: Bob\n"
set e [::tclutils::tuldif::parse $ldif]
llength $e                                ;# -> 2
set alice [lindex $e 0]
::tclutils::tuldif::dn $alice             ;# -> cn=Alice,dc=ex
::tclutils::tuldif::get $alice MAIL       ;# -> a@ex.com alice@ex.com
::tclutils::tuldif::attributes $alice     ;# -> dn cn mail
::tclutils::tuldif::toDict $alice
    ;# -> dn cn=Alice,dc=ex cn Alice mail {a@ex.com alice@ex.com}
set e2 [::tclutils::tuldif::parse "dn: x\ncn:: SGFsbG8=\n"]
::tclutils::tuldif::get [lindex $e2 0] cn ;# -> Hallo
::tclutils::tuldif::toLdif [list {{dn x} {cn { Lager}}}]
                                          ;# -> dn: x\ncn:: IExhZ2Vy\n
::tclutils::tuldif::toLdif [list {{dn x} {cn {Lager }}}]
                                          ;# -> dn: x\ncn:: TGFnZXIg\n
::tclutils::tuldif::toLdif [list {{dn x} {cn Hällo}}]
                                          ;# -> dn: x\ncn:: SMOkbGxv\n
set e3 [::tclutils::tuldif::parse "dn: x\ncn:: SMOkbGxv\n"]
::tclutils::tuldif::get [lindex $e3 0] cn ;# -> Hällo
```

A binary value that `parse` returns as bytes goes through UTF-8 again
in `toLdif` and therefore does not come out byte for byte the same.
`tuldif` is meant for text values.

A line without a colon throws `{TCLUTILS TULDIF SYNTAX}` with
`LDIF line without ':' -> zeile`. `tuldif` reads only content records. A
change record throws, at the word `changetype`, the code
`{TCLUTILS TULDIF CHANGETYPE}` with
`LDIF change records are not supported (changetype: modify)`.

```tcl
set aend "dn: cn=A\nchangetype: modify\nreplace: mail\n"
catch {::tclutils::tuldif::parse $aend} m o
dict get $o -errorcode            ;# -> TCLUTILS TULDIF CHANGETYPE
```

---

## Bookmarks: tubookmark

[tubookmark]{.index} reads and writes the Netscape bookmark format, the
HTML file through which browsers import and export bookmarks.
A bookmark is a dict with `title`, `url`, `folder`, `tags` and
`adddate`. `folder` is the folder path with `/`, empty for the top
level. `tags` is a list.

| Command | Effect |
|---|---|
| `parse html` | flat list of bookmark dicts |
| `serialize lesezeichen ?-title text?` | the HTML file as text |

| Option | Default | Effect |
|---|---|---|
| `-title` | `Bookmarks` | content of `<TITLE>` and `<H1>` |

`parse` reads the HTML tag by tag, not line by line. Each
`<A …>…</A>` is a bookmark, even if several links stand on one
line. Folders result from `<H3>` and the nested
`<DL>`. Entities in the title, `HREF`, `TAGS` and `ADD_DATE` are resolved
by `tuxml::unescape`. `TAGS` is split at the comma, `ADD_DATE` stays
text. Other attributes such as `ICON` are dropped.

`serialize` sorts the folders of a level by name and puts them
before the bookmarks of that level. Title and folder name are escaped
(`&`, `<`, `>`), the attribute values `HREF`, `TAGS` and `ADD_DATE`
additionally `"` as `&quot;`. A `/` in a folder name is always a
path separator. Each line of the header starts in the first column.

```tcl
package require tclutils::tubookmark
set html "<DL><p>\n<DT><A HREF=\"https://tcl.tk/\" TAGS=\"tcl,lang\">"
append html "Tcl &amp; Tk</A>\n<DT><H3>Dev</H3>\n<DL><p>\n"
append html "<DT><A HREF=\"https://core.tcl-lang.org/\">Fossil</A>\n"
append html "</DL><p>\n</DL><p>\n"
set bms [::tclutils::tubookmark::parse $html]
llength $bms                              ;# -> 2
dict get [lindex $bms 0] title            ;# -> Tcl & Tk
dict get [lindex $bms 0] tags             ;# -> tcl lang
dict get [lindex $bms 1] folder           ;# -> Dev
set neu [::tclutils::tubookmark::serialize $bms -title Lager]
llength [::tclutils::tubookmark::parse $neu]
                                          ;# -> 2
set zwei "<DT><A HREF=\"a\">A</A><DT><A HREF=\"b\">B</A>"
llength [::tclutils::tubookmark::parse $zwei]
                                          ;# -> 2
set bm [dict create title T url u folder "" tags {a"b} adddate 1]
set h [::tclutils::tubookmark::serialize [list $bm]]
string match {*TAGS="a&quot;b"*} $h       ;# -> 1
set t [dict get [lindex [::tclutils::tubookmark::parse $h] 0] tags]
lindex $t 0                               ;# -> a"b
```

There are no module-specific error codes. An unknown option to `serialize`
throws `{TCLUTILS COMMON OPTION -name}`.

---

## What Has No Section of Its Own Here

TDBC and MaxMind are described in the chapter
[TDBC and MaxMind](051-tdbc-und-mmdb.md). ODF and the PDF structure
are described in the chapter [ODF and PDF Structure](057-odf-und-pdf-struktur.md).

The view of the same data in the user interface is in *tkutils*
(`tkujson`, `tkuical`). `tupdf` reads the structure, `tupdftext` the text.

---

## In short

- CSV with quotes: `tucsv`. Cutting at a delimiter: `tucut`.
- `tujson::parse` turns `true` into `1` and `null` into empty. `parseTyped` keeps the kind.
- `tuini::setValue` returns a new dict.
- INI comments are `#` and `;`. `toIni` writes no spaces around the equals sign.
- `tuxml` escapes in `textElement`. `element` inserts the content raw.
- `tusqlite` binds SQL NULL through `null`. `rows` returns the empty string.
- `tuldif`: entry = list of pairs. Base64 values are UTF-8; change records throw `CHANGETYPE`.
- `tubookmark`: each `<A>` is a bookmark; `folder` is a path with `/`.

---

*Next chapter: [TDBC and MaxMind](051-tdbc-und-mmdb.md)*
