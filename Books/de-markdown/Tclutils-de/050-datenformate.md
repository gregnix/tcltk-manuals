# Datenformate

CSV, JSON und INI sind Pure Tcl und brauchen kein Fremdpaket. Beträge
liest `tunum` im Kapitel
[Zeichen, Zahlen, Datum und Pfade](045-zeichen-zahlen-datum.md), den
Text einer PDF das Kapitel
[Text aus PDF-Dateien](055-pdf-text.md). Base64, Digests und Dicts
stehen im Kapitel
[Kodierung, Hash und Vergleich](052-kodierung-hash-vergleich.md).
Markdown, iCalendar, vCard und Notizen stehen im Kapitel
[Notizen und Kalender](054-notizen-und-kalender.md).

---

## CSV: tucsv

[tucsv]{.index} zerlegt Zeilen, fügt sie wieder zusammen und liest eine Tabelle
in Dicts. Es ist kein Import-Rahmen.

| Befehl | Wirkung |
|---|---|
| `parseLine zeile` | eine Zeile zur Liste; `-delimiter` (Vorgabe Komma), `-quote` (Vorgabe `"`), `-trim` (Vorgabe 0) |
| `joinLine felder` | eine Liste zur Zeile; dieselben `-delimiter` und `-quote`, dazu `-alwaysQuote` (Vorgabe 0) |
| `parse text ?optionen?` | Zeilen zu einer Liste von Feldlisten; ein Feld darf einen Zeilenumbruch enthalten |
| `text zeilen ?optionen?` | Feldlisten zurück zum Text; zusätzlich `-newline` |
| `dicts zeilen` | erste Zeile wird Kopf, jede weitere ein Dict |
| `file pfad ?optionen?` | Datei wie `parse` |
| `writeFile pfad zeilen ?optionen?` | Datei schreiben |

Ein Feld mit Komma, Anführungszeichen oder Zeilenumbruch wird in
Anführungszeichen gesetzt. Ein Anführungszeichen im Feld verdoppelt
sich. `-alwaysQuote 1` setzt jedes Feld in Anführungszeichen.

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

`-strict 1` ist die Vorgabe. Ein nicht geschlossenes Anführungszeichen
wirft `{TCLUTILS TUCSV QUOTE}` mit `unterminated quoted field`.
`-strict 0` nimmt den Rest als Feld und wirft nicht. Ein führendes
UTF-8-BOM entfernt `parse` von selbst; das steht so in `docs/tucsv.md`.

Felder ohne Anführungszeichen, nur am Trennzeichen geschnitten, gehören
zu `tucut` im Kapitel [Text und Dateien](040-text-und-dateien.md).

---

## JSON: tujson

[tujson]{.index} liest und schreibt JSON. Es ist kein JSON5: keine Kommentare,
keine nachhängenden Kommas, kein JSONPath, kein Strom.

`parse` und `fromJson` liefern Tcl-Werte. Dabei geht der Unterschied
von Objekt, Array und Skalar verloren.

| JSON | Tcl aus `parse` |
|---|---|
| Objekt | Dict, Schlüssel in der Reihenfolge des Texts |
| Array | Liste |
| String | String |
| Zahl | der Zifferntext aus der Quelle |
| `true` / `false` | `1` / `0` |
| `null` | leerer String |

```tcl
package require tclutils::tujson
set d [::tclutils::tujson::parse {{"name":"Gregor","items":[1,2],"ok":true,"x":null}}]
dict get $d name                          ;# -> Gregor
dict get $d items                         ;# -> 1 2
dict get $d ok                            ;# -> 1
dict get $d x                             ;# -> (leer)
```

Ein fehlerhafter Text wirft `{TCLUTILS TUJSON PARSE offset}`. Bei `{`
allein lautet die Meldung `invalid JSON at offset 1: expected object key string`.

`parseTyped` behält die Art. Jeder Knoten ist `{art wert}`:

| Art | Wert |
|---|---|
| `object` | Dict, Schlüssel auf einen Knoten |
| `array` | Liste von Knoten |
| `string` | der String |
| `number` | die Ziffern aus der Quelle |
| `boolean` | `true` oder `false` |
| `null` | leer |

```tcl
::tclutils::tujson::parseTyped {{"tags":["x"],"n":1}}
    ;# -> object {tags {array {{string x}}} n {number 1}}
```

`toJson` schreibt so einen Baum zurück. Die Konstruktoren `str`, `num`,
`bool`, `null`, `obj` und `arr` bauen ihn von Hand. `-indent N` mit
N > 0 bricht Zeilen um, je Stufe N Leerzeichen. Die Vorgabe 0 ist eine
Zeile. Eine unbekannte Art wirft `{TCLUTILS TUJSON TYPE}`.

```tcl
set doc [::tclutils::tujson::obj [list \
    name [::tclutils::tujson::str Alice] \
    n    [::tclutils::tujson::num 1] \
    z    [::tclutils::tujson::null]]]
::tclutils::tujson::toJson $doc
    ;# -> {"name":"Alice","n":1,"z":null}
```

`quote` und `escape` setzen einen String in JSON-Anführungszeichen.
`validate` prüft, ohne einen Wert zu bauen. `minify` und `pretty`
formatieren Text, `fileMinify` und `filePretty` eine Datei.
Auf der Kommandozeile: `tclsh bin/tujson.tcl validate|minify|pretty|parse datei`.

`true` als `1` und `null` als leer sind Absicht von `parse`. Wer die
Art braucht, nimmt `parseTyped`.

---

## INI: tuini

[tuini]{.index} liest INI in ein Dict: Abschnitt auf ein Dict von Schlüssel zu
Wert. Schlüssel vor der ersten `[section]` liegen im Abschnitt `""`.
Die Reihenfolge bleibt. Kommentare mit `#` oder `;` fallen weg.

| Befehl | Wirkung |
|---|---|
| `parse text` | das Dict |
| `toIni dict` | INI-Text, `schlüssel=wert` ohne Leerzeichen um `=` |
| `sections dict` | die Abschnittsnamen |
| `keys dict ?abschnitt?` | die Schlüssel |
| `get dict abschnitt schlüssel ?vorgabe?` | der Wert, oder die Vorgabe |
| `has dict abschnitt schlüssel` | 1 oder 0 |
| `setValue dict abschnitt schlüssel wert` | eine Kopie mit dem neuen Wert |
| `addSection dict abschnitt` | Kopie, Abschnitt ist da |
| `removeKey`, `removeSection` | Kopie ohne Schlüssel oder Abschnitt |

`setValue` ändert das übergebene Dict nicht.

```tcl
package require tclutils::tuini
set ini [::tclutils::tuini::parse "# k\n\n\[lager\]\nort = Nord\n"]
::tclutils::tuini::sections $ini             ;# -> lager
::tclutils::tuini::get $ini lager ort        ;# -> Nord
::tclutils::tuini::get $ini lager fehlt -    ;# -> -
set ini [::tclutils::tuini::setValue $ini lager gang 3]
::tclutils::tuini::toIni $ini                ;# -> \[lager\]\nort=Nord\ngang=3
```

Ein nicht geschlossener Abschnitt wirft `{TCLUTILS TUINI SYNTAX}`,
etwa `unterminated section header: [offen`. Dieselbe Grenze gilt für
Werte mit Zeilenumbruch in `tusettings`, Kapitel
[tusettings](080-tusettings.md): das Modul speichert INI und reicht
die Syntax an `tuini` weiter.

---

## XML: tuxml

[tuxml]{.index} schreibt kleine Elemente. Es prüft kein Dokument und kennt kein
XPath. `escape` setzt `&`, `<` und `>` um; mit `-quotes 1` auch
Anführungszeichen. `unescape` löst die vordefinierten Entitäten und
`&#…;` auf. `textElement` maskiert den Text, `element` fügt ihn roh ein.

```tcl
package require tclutils::tuxml
::tclutils::tuxml::declaration               ;# -> <?xml version="1.0" encoding="UTF-8"?>
::tclutils::tuxml::textElement lager {ort Nord} {a < b}
                                          ;# -> <lager ort="Nord">a &lt; b</lager>
```

Ein Name, der nicht mit Buchstabe oder `_` beginnt, wirft
`{TCLUTILS TUXML NAME <name>}`, ein Attributname
`{TCLUTILS TUXML ATTR <name>}`.

---

## SQLite: tusqlite

[tusqlite]{.index} öffnet keine Datenbank und lädt `sqlite3` nicht. Der
Aufrufer übergibt ein offenes Handle. `insert` baut die Anweisung in
einem eigenen Geltungsbereich, damit ein Wert nicht an eine Variable
des Aufrufers bindet. `rows` liefert Dicts in der Reihenfolge der
Zeilen. `value` nimmt die erste Spalte der ersten Zeile, sonst die
Vorgabe.

Ein Wert gleich `[tusqlite::null]` wird SQL-NULL. `rows` gibt diese
Zelle als leere Zeichenkette zurück. `quoteId` setzt einen Namen in
Anführungszeichen und verdoppelt ein Anführungszeichen darin.

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

Ein leeres Dict wirft `{TCLUTILS TUSQLITE EMPTY}`.

---

## LDIF: tuldif

[tuldif]{.index} liest LDIF nach RFC 2849 in eine Liste von Einträgen und
schreibt sie zurück. Ein Eintrag ist eine geordnete Liste von Paaren
`{attribut wert}`. `dn` ist ein Attribut wie jedes andere, ein
mehrwertiges Attribut steht mehrmals in der Liste.

| Befehl | Wirkung |
|---|---|
| `parse text` | Liste der Einträge; eine Leerzeile trennt zwei Einträge |
| `toLdif einträge` | LDIF-Text, nach jedem Eintrag eine Leerzeile |
| `dn eintrag` | Wert von `dn`, sonst die leere Zeichenkette |
| `get eintrag attribut` | alle Werte des Attributs; Groß- und Kleinschreibung zählt nicht |
| `attributes eintrag` | Attributnamen in der Reihenfolge des ersten Auftretens |
| `toDict eintrag` | Dict Attribut auf Liste der Werte |
| `addAttr eintrag attribut wert` | Kopie mit angehängtem Paar |
| `setAttr eintrag index attribut wert` | Kopie, das Paar an `index` ersetzt |
| `removeAttr eintrag index` | Kopie ohne das Paar an `index` |

`parse` übergeht Kommentarzeilen mit `#` und die Zeile `version:`. Eine
Zeile, die mit einem Leerzeichen beginnt, setzt die vorige fort. Ein
Wert `attr:: …` wird über `tubase64` dekodiert und als UTF-8 gelesen,
denn LDIF-Werte sind nach RFC 2849 UTF-8. Bytes, die kein gültiges
UTF-8 ergeben (ein Binärattribut wie `jpegPhoto`), bleiben Bytes, ein
Zeichen je Byte. Bei `attr:< url` ist die URL selbst der Wert; eine
Datei wird nicht gelesen.

`toLdif` schreibt einen Wert als Base64, wenn er mit Leerzeichen, `:`
oder `<` beginnt, mit einem Leerzeichen endet oder ein Zeichen
außerhalb von ASCII 32–126 enthält. Vor Base64 wird der Wert nach UTF-8
gewandelt; `Hällo` wird `SMOkbGxv`, ein Zeichen über 255 wie `€` geht
ebenso. Lange Zeilen bricht `toLdif` nicht um.

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

Ein Binärwert, den `parse` als Bytes liefert, geht durch `toLdif`
erneut über UTF-8 und kommt deshalb nicht Byte für Byte gleich heraus.
`tuldif` ist für Textwerte gedacht.

Eine Zeile ohne Doppelpunkt wirft `{TCLUTILS TULDIF SYNTAX}` mit
`LDIF line without ':' -> zeile`. `tuldif` liest nur Inhaltssätze. Ein
Änderungssatz wirft beim Wort `changetype` den Code
`{TCLUTILS TULDIF CHANGETYPE}` mit
`LDIF change records are not supported (changetype: modify)`.

```tcl
set aend "dn: cn=A\nchangetype: modify\nreplace: mail\n"
catch {::tclutils::tuldif::parse $aend} m o
dict get $o -errorcode            ;# -> TCLUTILS TULDIF CHANGETYPE
```

---

## Lesezeichen: tubookmark

[tubookmark]{.index} liest und schreibt das Netscape-Lesezeichenformat, die
HTML-Datei, über die Browser Lesezeichen importieren und exportieren.
Ein Lesezeichen ist ein Dict mit `title`, `url`, `folder`, `tags` und
`adddate`. `folder` ist der Ordnerpfad mit `/`, leer für die oberste
Ebene. `tags` ist eine Liste.

| Befehl | Wirkung |
|---|---|
| `parse html` | flache Liste der Lesezeichen-Dicts |
| `serialize lesezeichen ?-title text?` | die HTML-Datei als Text |

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-title` | `Bookmarks` | Inhalt von `<TITLE>` und `<H1>` |

`parse` liest das HTML Tag für Tag, nicht Zeile für Zeile. Jedes
`<A …>…</A>` ist ein Lesezeichen, auch wenn mehrere Links in einer
Zeile stehen. Ordner ergeben sich aus `<H3>` und den geschachtelten
`<DL>`. Entitäten in Titel, `HREF`, `TAGS` und `ADD_DATE` löst
`tuxml::unescape` auf. `TAGS` wird am Komma geteilt, `ADD_DATE` bleibt
Text. Andere Attribute wie `ICON` fallen weg.

`serialize` sortiert die Ordner einer Ebene nach Namen und setzt sie
vor die Lesezeichen dieser Ebene. Titel und Ordnername werden maskiert
(`&`, `<`, `>`), die Attributwerte `HREF`, `TAGS` und `ADD_DATE`
zusätzlich `"` als `&quot;`. Ein `/` im Ordnernamen ist immer
Pfadtrenner. Jede Zeile des Kopfs beginnt in der ersten Spalte.

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

Eigene Fehlercodes gibt es nicht. Eine unbekannte Option an `serialize`
wirft `{TCLUTILS COMMON OPTION -name}`.

---

## Was hier keine eigene Liste hat

TDBC und MaxMind stehen im Kapitel
[TDBC und MaxMind](051-tdbc-und-mmdb.md). ODF und die PDF-Struktur
stehen im Kapitel [ODF und PDF-Struktur](057-odf-und-pdf-struktur.md).

Die Ansicht derselben Daten in der Oberfläche liegt in *tkutils*
(`tkujson`, `tkuical`). `tupdf` liest die Struktur, `tupdftext` den Text.

---

## Merkliste

- CSV mit Anführungszeichen: `tucsv`. Schneiden an einem Trennzeichen: `tucut`.
- `tujson::parse` macht `true` zu `1` und `null` zu leer. Die Art behält `parseTyped`.
- `tuini::setValue` gibt ein neues Dict zurück.
- INI-Kommentare sind `#` und `;`. Um das Gleichheitszeichen schreibt `toIni` keine Leerzeichen.
- `tuxml` maskiert in `textElement`. `element` setzt den Inhalt roh ein.
- `tusqlite` bindet SQL-NULL über `null`. Aus `rows` kommt die leere Zeichenkette.
- `tuldif`: Eintrag = Liste von Paaren. Base64-Werte sind UTF-8; Änderungssätze werfen `CHANGETYPE`.
- `tubookmark`: jedes `<A>` ein Lesezeichen; `folder` ist ein Pfad mit `/`.

---

*Nächstes Kapitel: [TDBC und MaxMind](051-tdbc-und-mmdb.md)*
