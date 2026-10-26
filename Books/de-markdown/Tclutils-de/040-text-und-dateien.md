# Text und Dateien

Die Textfilter spiegeln Unix-Werkzeuge als Tcl-API. Rein kommt ein
String oder eine Liste, heraus kommt ein String oder eine Liste. Die
Filter selbst starten kein Programm. Das Mapping auf die Unix-Namen
steht in `docs/guide/coreutils-mapping.md`. Dieses Kapitel beschreibt
die Befehle, mit denen ein Ablauf aus Filtern, Dateityp und ZIP
gebaut wird. Es führt nicht jedes Filtermodul aus dem Mapping auf.

Gemeinsames Muster, wo das Modul es hat: `text` arbeitet auf einem
String, `file` auf einem Pfad, `files` auf einer Pfadliste.

---

## Anfang und Ende

| Befehl | Wirkung |
|---|---|
| `tucat::text`, `file`, `files` | Text unverändert, oder mit Zeilennummern |
| `tuhead::text`, `file` | die ersten `n` Zeilen; Vorgabe 10 |
| `tutail::text`, `file` | die letzten `n` Zeilen; Vorgabe 10 |

`tucat` nummeriert mit `-number 1` jede Zeile, auch eine leere, als
sechs Stellen, Tabulator, Text (`format %6d`). `-nonblank 1` nummeriert
nur Zeilen mit Inhalt. Ein Text, der auf `\n` endet, hat eine leere
letzte Zeile, und die wird mitgezählt.

```tcl
package require tclutils::tucat
package require tclutils::tuhead
package require tclutils::tutail
set text "alpha\nbeta\nbeta\nalpha"
::tclutils::tuhead::text $text 2          ;# -> alpha\nbeta
::tclutils::tutail::text $text 1          ;# -> alpha
::tclutils::tucat::text "alpha\nbeta" -number 1
                                          ;# -> "     1\talpha\n     2\tbeta"
```

`tuhead` und `tutail` haben kein Folgen von Dateien. Eine negative
Anzahl ist ein Fehler ohne eigenen `-errorcode`.

---

## Suchen: tugrep

```tcl
::tclutils::tugrep::search text muster ?option wert ...?
::tclutils::tugrep::match  zeile muster ?option wert ...?
::tclutils::tugrep::file   pfad muster ?option wert ...?
::tclutils::tugrep::files  pfade muster ?option wert ...?
```

Das Muster ist ein regulärer Ausdruck. `-fixed 1` sucht die Zeichenkette
literal.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-nocase` | 0 | ohne Groß/Klein |
| `-linenumbers` | 0 | jede Zeile als `{nummer text}`, Nummer ab 1 |
| `-invert` | 0 | die Zeilen ohne Treffer |
| `-fixed` | 0 | keine Regex |
| `-word` | 0 | ganzes Wort, wie grep `-w` |
| `-wholeline` | 0 | die ganze Zeile, wie grep `-x` |
| `-max` | 0 | nach N Treffern aufhören; 0 heißt ohne Grenze |
| `-count` | 0 | nur die Anzahl |
| `-fileswithmatches` | 0 | nur die Pfade mit Treffer |
| `-filenames` | 0 | Treffer mit Dateinamen davor |

```tcl
package require tclutils::tugrep
set text "alpha\nbeta\nERROR eins\nerror zwei\nERRORCODE"
::tclutils::tugrep::search $text ERROR
                                          ;# -> {ERROR eins} ERRORCODE
::tclutils::tugrep::search $text error -nocase 1 -linenumbers 1
                                          ;# -> {3 {ERROR eins}} {4 {error zwei}} {5 ERRORCODE}
::tclutils::tugrep::search "ERROR\nERRORCODE" ERROR -word 1
                                          ;# -> ERROR
::tclutils::tugrep::search "a\na\na" a -max 1
                                          ;# -> a
::tclutils::tugrep::search $text error -nocase 1 -count 1
                                          ;# -> 3
```

`-word` trifft `ERROR` und nicht `ERRORCODE`. `-max` zählt Zeilen, nicht
Treffer in einer Zeile.

---

## Sortieren und Doppelte

`tusort` sortiert Zeilen oder eine Liste. `tuuniq` entfernt nur
benachbarte Doppelte, wie Unix `uniq`. Wer alle Doppelten will, sortiert
zuerst.

| Option `tusort` | Wirkung |
|---|---|
| `-numeric`, `-integer`, `-real` | Zahlenvergleich |
| `-dictionary` | wie `lsort -dictionary` |
| `-nocase` | ohne Groß/Klein |
| `-reverse` | absteigend |
| `-unique` | Doppelte beim Sortieren weg |

`tuuniq` kennt `-nocase`. `adjacentCount` liefert `{anzahl wert}` je
benachbarter Gruppe. `count` zählt über die ganze Liste.

```tcl
package require tclutils::tusort
package require tclutils::tuuniq
::tclutils::tusort::text "10\n2\n10" -numeric 1 -unique 1
                                          ;# -> 2\n10
::tclutils::tuuniq::uniqList {a b b a}    ;# -> a b a
::tclutils::tuuniq::uniqList [::tclutils::tusort::sortList {a b b a}]
                                          ;# -> a b
::tclutils::tuuniq::adjacentCount {a a b} ;# -> {2 a} {1 b}
```

---

## Felder und Ersetzen

`tucut` schneidet Felder aus einer Zeile. Das ist kein CSV: Anführungszeichen
und Kommas im Feld gehören zu `tucsv`, Kapitel
[Datenformate](050-datenformate.md). Feldnummern zählen ab 1. Bereiche
schreiben sich `2-4`. `-chars` schneidet Zeichen, ebenfalls ab 1, auch
offen als `4-` oder `-3`.

```tcl
package require tclutils::tucut
::tclutils::tucut::field "a;b;c" ";" 2         ;# -> b
::tclutils::tucut::fields "a;b;c;d" ";" {1 3}  ;# -> a;c
::tclutils::tucut::fields "a;b;c;d" ";" 2-3    ;# -> b;c
```

`text` und `file` nehmen `-delimiter`, `-fields` und `-chars`.

`tused` ersetzt und löscht zeilenweise. Ohne `-all` gilt der erste
Treffer der Zeile. `-fixed 1` sucht literal, sonst als Regex.
`-nocase 1` ignoriert die Schreibung. `delete` wirft die passenden
Zeilen weg. `process` nimmt eine Regeliste (`s`, `d`).

```tcl
package require tclutils::tused
::tclutils::tused::replace "foo foo" foo bar         ;# -> bar foo
::tclutils::tused::replace "foo foo" foo bar -all 1  ;# -> bar bar
::tclutils::tused::delete "# c\nzeile" {^#}          ;# -> zeile
```

Adressen wie bei sed (`3`, `$`, `/regex/`, Bereich, Verneinung mit `!`,
Schritt `erste~schritt`) hängen an der Regel in `process` und `script`.
Die Formen stehen in `docs/tused.md`.

---

## Dateityp und Suche im Baum

`tufile` liest nur den Kopf der Datei und vergleicht ihn mit einer
Signaturtabelle. Kein libmagic, keine Masken.

| Befehl | Ergebnis |
|---|---|
| `detect pfad` | Dict des genauesten Treffers, oder leer |
| `type pfad` | Kurzname (`pdf`, `png`, `zip`) oder `""` |
| `mime pfad` | MIME-Typ oder `""` |
| `describe pfad` | Satz, oder `data` |
| `checkExtension pfad` | Dict mit `status`: `ok`, `mismatch`, `noext`, `unknown`, `unknownext` |

```tcl
package require tclutils::tufile
::tclutils::tufile::type /pfad/seite.pdf    ;# -> pdf
::tclutils::tufile::mime /pfad/seite.pdf    ;# -> application/pdf
```

An einer Seite aus pdf4tcl ist der Typ `pdf`. Laut `docs/tufile.md` teilen sich
DOCX, XLSX und PPTX nur die ZIP-Signatur und kommen als `zip`; ODT, ODS
und ODP erkennt das Modul am `mimetype`-Eintrag ab Byte 30.

`tufind` läuft den Baum in Tcl.

| Befehl | Was zurückkommt |
|---|---|
| `files wurzel muster ?optionen?` | Dateien |
| `directories wurzel muster` | Verzeichnisse |
| `all wurzel muster` | beides |
| `walk wurzel muster script` | ruft das Script je Treffer |

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-recursive` | 1 | in Unterverzeichnisse |
| `-maxdepth` | −1 | −1 heißt ohne Grenze |
| `-mindepth` | 0 | flacher wird verworfen |
| `-hidden` | 0 | Punkt-Dateien mitnehmen |
| `-tails` | 0 | nur der Dateiname, nicht der volle Pfad |
| `-type` | | `file`, `dir`, `any` |
| `-size` | | `N`, `+N`, `-N`, dazu `k`, `m`, `g` |
| `-mtime` | | Alter in Tagen: `+N` älter, `-N` neuer |

```tcl
package require tclutils::tufind
::tclutils::tufind::files $dir *.pdf -tails 1 -maxdepth 1
```

Mit `-tails 1` und `-maxdepth 1` sind das die Namen direkt in `$dir`,
keine Pfade aus Unterverzeichnissen.

---

## ZIP

`tuzip` liest und schreibt ZIP mit gespeicherten und mit deflate-Einträgen.
Das reicht für normale Archive und für ODF, das ein ZIP ist. Binärdateien
öffnet es binär.

| Befehl | Wirkung |
|---|---|
| `names archiv` | die Mitgliedsnamen |
| `entries archiv` | Dicts je Mitglied |
| `readMember archiv name` | der Inhalt |
| `extract archiv name zieldatei` | schreibt eine Datei |
| `create archiv dateien ?-base dir? ?-compress 1?` | neues Archiv |
| `createMembers archiv member` | aus dem Speicher; je Dict `name`, `content`, `method` |

```tcl
package require tclutils::tuzip
::tclutils::tuzip::create $archiv [list $datei] -base $dir -compress 1
::tclutils::tuzip::names $archiv                 ;# -> notiz.txt
::tclutils::tuzip::readMember $archiv notiz.txt  ;# -> hallo zip
```

`-base` schneidet das Verzeichnis vom Namen ab. Die Reihenfolge in
`createMembers` bleibt; ein ODF legt `mimetype` so als ersten,
ungespeicherten Eintrag. Der Provider über derselben Datei steht im
Kapitel [Provider](060-provider.md).

Pfade ohne Dateisystem, sichtbare Zeichen und Beträge:
[Zeichen, Zahlen, Datum und Pfade](045-zeichen-zahlen-datum.md).

Einige Module haben ein Programm unter `bin/`. Die Liste steht in
`docs/guide/cli.md`. Dieses Buch führt sie nicht einzeln auf.

---

## Merkliste

- `text`, `file`, `files`: String rein, String oder Liste heraus.
- `tuuniq` entfernt nur Nachbarn. Vorher `tusort`, wenn alle Doppelten weg sollen.
- `tucut` ist kein CSV.
- `tugrep -word` trifft das Wort, nicht den Anfang eines längeren Wortes.
- `tuzip` liest den Inhalt, der Provider entscheidet, ob Schreiben erlaubt ist.

---

*Nächstes Kapitel: [Weitere Zeilenfilter](042-zeilenfilter.md)*
