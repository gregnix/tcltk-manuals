# Weitere Zeilenfilter

Dieses Kapitel setzt [Text und Dateien](040-text-und-dateien.md) fort.
Die Module hier nummerieren, umbrechen, richten aus, kehren um, zählen
und erzeugen Zeilen. Jedes hat ein Unix-Vorbild aus den coreutils
oder util-linux; die Abweichungen stehen beim jeweiligen Modul. Kein
Modul startet ein Programm.

Alle Optionen gehen über denselben Parser. Eine unbekannte Option
wirft `{TCLUTILS COMMON OPTION -name}` und nennt in der Meldung die
bekannten. Eine Ganzzahl unter 1, wo eine positive verlangt ist,
wirft `{TCLUTILS COMMON INTEGER -name}`, ein Nicht-Wahrheitswert
`{TCLUTILS COMMON BOOLEAN -name}`. Diese drei Codes stehen unten nicht
bei jedem Modul noch einmal.

`file` liest die Datei mit der Systemkodierung und wandelt `\r\n` in
`\n`. Ob ein abschließendes `\n` erhalten bleibt, hängt vom Modul ab:

| Abschließendes `\n` | Module |
|---|---|
| bleibt | `tunl`, `tutac`, `turev`, `tuexpand`, `tutr` |
| fällt weg | `tufold`, `tufmt`, `tucolumn`, `tushuf`, `tupr` |

---

## Zeilen nummerieren: tunl

[tunl]{.index} nummeriert Zeilen wie Unix `nl`.

```tcl
::tclutils::tunl::text text ?option wert ...?
::tclutils::tunl::file pfad ?option wert ...?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-style` | `nonempty` | `all` jede Zeile, `nonempty` nur Zeilen mit Inhalt, `none` keine |
| `-start` | 1 | erste Nummer |
| `-increment` | 1 | Schritt |
| `-width` | 6 | Stellen der Nummer, rechtsbündig |
| `-separator` | `\t` | zwischen Nummer und Zeile |

Eine Zeile ohne Nummer beginnt mit `-width` Leerzeichen und dem
Trenner. Unix `nl` setzt bei einer leeren Zeile nur Leerzeichen, ohne
Tabulator. Ein abschließendes `\n` bleibt und erzeugt keine eigene
Zeile. Ein leerer Text ergibt `""`.

`-start` und `-increment` sind Ganzzahlen, auch negative und beliebig
große. `-width` ist eine Ganzzahl ab 1.

| Fehler | `-errorcode` |
|---|---|
| `-style` außer `all`, `nonempty`, `none` | `{TCLUTILS TUNL STYLE}` |
| `-start` keine Ganzzahl | `{TCLUTILS TUNL START}` |
| `-increment` keine Ganzzahl | `{TCLUTILS TUNL INCREMENT}` |
| `-width` keine Ganzzahl ab 1 | `{TCLUTILS TUNL WIDTH}` |

```tcl
package require tclutils::tunl
::tclutils::tunl::text "a\n\nb" -width 2 -separator " "
                                          ;# -> " 1 a\n   \n 2 b"
::tclutils::tunl::text "a\n\nb" -style all -width 2 -separator " "
                                          ;# -> " 1 a\n 2 \n 3 b"
::tclutils::tunl::text "a\nb" -start 10 -increment 5 \
    -width 2 -separator ": "              ;# -> 10: a\n15: b
```

`tucat -number 1` aus [Text und Dateien](040-text-und-dateien.md)
nummeriert dagegen fest mit sechs Stellen und Tabulator.

---

## Umbrechen: tufold und tufmt

[tufold]{.index} bricht jede Zeile für sich, wie Unix `fold`.
[tufmt]{.index} fasst Absätze zusammen und bricht sie neu, wie Unix
`fmt`.

```tcl
::tclutils::tufold::foldLine zeile ?-width n? ?-words 0|1?
::tclutils::tufold::text     text  ?-width n? ?-words 0|1?
::tclutils::tufold::file     pfad  ?-width n? ?-words 0|1?
::tclutils::tufmt::reflow     text ?-width n?
::tclutils::tufmt::reflowFile pfad ?-width n?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `tufold -width` | 80 | höchstens so viele Zeichen je Zeile |
| `tufold -words` | 0 | 1 bricht an der letzten Leerstelle vor der Grenze |
| `tufmt -width` | 75 | Zielbreite der Absätze |

`foldLine` liefert eine Liste der Teilzeilen, `text` und `file` einen
String. Die Breite zählt Zeichen, nicht Bildschirmspalten: Ein
Tabulator ist ein Zeichen. Ohne `-words` schneidet `tufold` hart nach
`-width` Zeichen; eine Leerstelle am Schnitt bleibt am Ende der Zeile.
Mit `-words 1` bricht `tufold` an der letzten Leerstelle bis Spalte
`-width` plus eins. Alle Leerzeichen am Umbruch fallen weg, am Ende der
Zeile wie am Anfang der Folgezeile. Unix `fold -s` lässt sie stehen:
Aus `"ab   cd"` mit Breite 3 macht es `"ab "`, `"  "` und `"cd"`,
`tufold` dagegen `ab` und `cd`. Ein Wort, das länger ist als `-width`,
schneidet auch `-words 1` hart. Leere Zeilen bleiben leer.

`tufmt` trennt Absätze an Leerzeilen; mehrere Leerzeilen werden zu
einer. Im Absatz fallen alle Zeilenwechsel und mehrfachen Leerzeichen
weg, dann füllt das Modul die Zeilen Wort für Wort bis zur Breite. Der
Einzug der ersten Absatzzeile gilt für alle Zeilen des Absatzes und
zählt zur Breite; ein Tabulator im Einzug zählt als ein Zeichen. Ein
Wort, das länger ist als die Breite, steht allein und ungekürzt in
seiner Zeile. `\r` entfernt das Modul vorher.

```tcl
package require tclutils::tufold
package require tclutils::tufmt
::tclutils::tufold::text "abcdefghij" -width 4
                                          ;# -> abcd\nefgh\nij
::tclutils::tufold::foldLine "eins zwei drei vier" -width 9 -words 1
                                          ;# -> {eins zwei} {drei vier}
::tclutils::tufold::foldLine "ab   cd" -width 3 -words 1
                                          ;# -> ab cd
::tclutils::tufmt::reflow "a  b\nc d e" -width 3
                                          ;# -> a b\nc d\ne
::tclutils::tufmt::reflow "  a b c d\n\n\nx" -width 5
                                          ;# -> "  a b\n  c d\n\nx"
```

---

## Tabulatoren: tuexpand

[tuexpand]{.index} wandelt Tabulatoren in Leerzeichen und zurück, wie
Unix `expand` und `unexpand`.

```tcl
::tclutils::tuexpand::expand   text ?-tabs n?
::tclutils::tuexpand::unexpand text ?-tabs n? ?-all 0|1?
::tclutils::tuexpand::file     pfad ?-mode m? ?-tabs n? ?-all 0|1?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-tabs` | 8 | Abstand der Tabstopps |
| `-all` | 0 | `unexpand`: 0 nur führende Leerzeichen, 1 alle Folgen |
| `-mode` | `expand` | nur `file`: welche Richtung |

`expand` füllt jeden Tabulator bis zum nächsten Tabstopp auf. Ein
abschließendes `\n` bleibt.

`unexpand` wandelt ohne `-all` nur den Leerraum am Zeilenanfang um,
Leerzeichen wie Tabulatoren; der Rest der Zeile bleibt, wie er ist,
auch Tabulatoren im Inneren. `-all 1` wandelt jede Folge von Leerraum
um. In einer Folge aus mindestens zwei Zeichen, und in jeder Folge am
Zeilenanfang, wird jeder erreichte Tabstopp zum Tabulator; was nach dem
letzten Tabstopp übrig ist, bleibt Leerzeichen. Ein einzelnes
Leerzeichen im Inneren der Zeile bleibt ein Leerzeichen, auch direkt
vor einem Tabstopp. Leerzeichen direkt vor einem Tabulator gehen in
ihm auf. So verhält sich auch Unix `unexpand` (`-a` für `-all 1`).

`file` wirft bei unbekanntem `-mode` `{TCLUTILS TUEXPAND MODE}`, bei
fehlendem Wert `{TCLUTILS TUEXPAND OPTION}`. `expand` und `unexpand`
kennen `-mode` nicht. `-all` gilt nur für `unexpand`; `expand` und
`file -mode expand` werfen dafür `{TCLUTILS COMMON OPTION -all}`.

```tcl
package require tclutils::tuexpand
::tclutils::tuexpand::expand "ab\tc" -tabs 4  ;# -> ab  c
::tclutils::tuexpand::unexpand "        x  y" ;# -> \tx  y
::tclutils::tuexpand::unexpand "ab  cd      e" -tabs 4 -all 1
                                          ;# -> ab\tcd\t\te
::tclutils::tuexpand::unexpand "a\tb"     ;# -> a\tb
::tclutils::tuexpand::unexpand "abcdefg          x" -all 1
                                          ;# -> abcdefg\t\t x
```

---

## Spalten: tucolumn

[tucolumn]{.index} richtet Spalten aus, wie `column` aus util-linux.
Es gibt zwei Arten: `table` für Zeilen mit Feldern (`column -t`),
`fill` für eine Wortliste, die auf mehrere Spalten verteilt wird.

```tcl
::tclutils::tucolumn::table text  ?option wert ...?
::tclutils::tucolumn::text  text  ?option wert ...?
::tclutils::tucolumn::fill  liste ?-width n? ?-gap n?
::tclutils::tucolumn::file  pfad  ?-mode table|fill? ?option wert ...?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-separator` | `""` | Feldtrenner der Eingabe; leer heißt Folgen von Leerraum |
| `-output` | zwei Leerzeichen | Trenner der Ausgabe |
| `-right` | 0 | 1 setzt alle Zellen rechtsbündig |
| `-width` | 80 | `fill`: Zielbreite der Zeile |
| `-gap` | 2 | `fill`: Leerzeichen zwischen Spalten, mindestens 1 |
| `-mode` | `table` | nur `file` |

`text` ist dasselbe wie `table`. Die Spaltenbreite ist die längste
Zelle der Spalte, in Zeichen. Die letzte Spalte jeder Zeile füllt
`table` nicht auf, so entsteht kein Leerraum am Zeilenende. Zeilen
dürfen verschieden viele Felder haben. Ein Trenner aus mehreren Zeichen
gilt als Ganzes. Leere Zeilen bleiben als leere Zeilen stehen;
`column -t` lässt sie ohne `-e` weg.

`fill` füllt spaltenweise: erst die erste Spalte von oben nach unten,
dann die nächste. Passt nicht einmal eine Spalte in `-width`, ist es
eine. `file -mode fill` zerlegt die Datei an Leerraum in Wörter. Eine
leere Liste ergibt `""`.

`file` wirft bei unbekanntem `-mode` `{TCLUTILS TUCOLUMN MODE}`, bei
fehlendem Wert `{TCLUTILS TUCOLUMN OPTION}`.

```tcl
package require tclutils::tucolumn
::tclutils::tucolumn::table "Name Alter\nBob 7"
                                          ;# -> Name  Alter\nBob   7
::tclutils::tucolumn::table "Name;Alter\nBob;7" -separator ";" \
    -output " | "                         ;# -> Name | Alter\nBob  | 7
::tclutils::tucolumn::fill {a b c d e} -width 7
                                          ;# -> "a  c  e\nb  d"
```

---

## Tabellen: tutable

[tutable]{.index} setzt eine Tabelle aus Kopfzeile und Zeilen als
Text, entweder als Markdown-Tabelle oder mit ASCII-Rahmen. Ein
Unix-Vorbild gibt es nicht; für das Ausrichten fertiger Textzeilen ist
`tucolumn` da.

```tcl
::tclutils::tutable::render koepfe zeilen ?option wert ...?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-style` | `markdown` | `markdown` (Pipe-Tabelle) oder `box` (`+`, `-`, `\|`) |
| `-align` | leer | je Spalte `l`, `r` oder `c`; fehlende Einträge gelten als `l` |

Die Rückgabe ist ein String ohne abschließendes `\n`. Die Zahl der
Spalten bestimmt `koepfe`: Fehlende Zellen einer Zeile bleiben leer.
Die Breite zählt Zeichen. Die Trennzeile im Markdown trägt die
Ausrichtung (`:--`, `--:`, `:-:`); auch `l` bekommt den Doppelpunkt
links. Im Markdown ist jede Spalte mindestens drei Zeichen breit, so
breit wie `:--`; Zellen und Trennzeile stehen bündig. Im Rahmen ist
eine Spalte so breit wie ihre längste Zelle.

| Fehler | `-errorcode` |
|---|---|
| `-style` außer `markdown` und `box` | `{TCLUTILS TUTABLE OPT}` |
| Ausrichtung außer `l`, `r` und `c` | `{TCLUTILS TUTABLE OPT}` |
| Zeile mit mehr Zellen als `koepfe` | `{TCLUTILS TUTABLE COLUMNS}` |
| `koepfe` leer | `{TCLUTILS TUTABLE HEADERS}` |

```tcl
package require tclutils::tutable
puts [::tclutils::tutable::render {Name Alter} {{Alice 30} {Bob 7}}]
puts [::tclutils::tutable::render {Artikel Menge} \
    {{Äpfel 12} {Birnen 3}} -align {l r} -style box]
```

```text
| Name  | Alter |
| :---- | :---- |
| Alice | 30    |
| Bob   | 7     |
+---------+-------+
| Artikel | Menge |
+---------+-------+
| Äpfel   |    12 |
| Birnen  |     3 |
+---------+-------+
```

---

## Umkehren und Mischen: tutac, turev, tushuf

[tutac]{.index} kehrt die Reihenfolge der Zeilen um (Unix `tac`),
[turev]{.index} die Zeichen in jeder Zeile (Unix `rev`),
[tushuf]{.index} mischt die Zeilen (Unix `shuf`).

| Befehl | Wirkung |
|---|---|
| `tutac::text text`, `file pfad` | Zeilen rückwärts; abschließendes `\n` bleibt |
| `tutac::lines liste` | die Liste rückwärts, wie `lreverse` |
| `turev::line zeile` | die Zeichen rückwärts, wie `string reverse` |
| `turev::text text`, `file pfad` | jede Zeile für sich; abschließendes `\n` bleibt |
| `tushuf::lines liste ?opt?` | gemischte Liste |
| `tushuf::text text ?opt?`, `file pfad ?opt?` | gemischte Zeilen, ohne abschließendes `\n` |

`tutac` behandelt die letzte Zeile ohne `\n` wie jede andere:
`"a\nb"` wird zu `"b\na"`. Unix `tac` liefert hier `ba` und ein `\n`.
`turev` kehrt nach Codepunkten um; zusammengesetzte Zeichen aus Basis
und Akzent trennt es.

| Option `tushuf` | Vorgabe | Wirkung |
|---|---|---|
| `-seed` | aus der Uhr | Ganzzahl; gleicher Wert, gleiche Reihenfolge |
| `-count` | −1 | höchstens so viele Zeilen; negativ heißt alle, 0 keine |

`tushuf` nutzt einen eigenen Zufallsgenerator, nicht `rand()`. Mit
demselben `-seed` ist die Reihenfolge auf jeder Plattform und unter Tcl
8.6 und 9.0 gleich. Der Wert darf beliebig groß sein, auch unter
Tcl 8.6 über 32 Bit hinaus; der Generator nutzt seine unteren 31 Bit.
Ein `-seed`, der keine Ganzzahl ist, wirft `{TCLUTILS TUSHUF SEED}`,
ein solcher `-count` `{TCLUTILS TUSHUF COUNT}`.

```tcl
package require tclutils::tutac
package require tclutils::turev
package require tclutils::tushuf
::tclutils::tutac::text "a\nb\nc\n"       ;# -> c\nb\na\n
::tclutils::turev::text "abc\nxyz"        ;# -> cba\nzyx
::tclutils::tushuf::lines {a b c d e} -seed 7
                                          ;# -> b e d a c
::tclutils::tushuf::lines {a b c d e} -seed 7 -count 2
                                          ;# -> b e
```

---

## Zahlenfolgen: tuseq

[tuseq]{.index} erzeugt Zahlenfolgen wie Unix `seq`.

```tcl
::tclutils::tuseq::range ?erste? ?schritt? letzte ?option wert ...?
::tclutils::tuseq::text  ?erste? ?schritt? letzte ?option wert ...?
```

Ein Wert heißt `letzte` (ab 1, Schritt 1), zwei heißen `erste letzte`,
drei `erste schritt letzte`. Optionen dürfen vor, zwischen oder hinter
den Werten stehen: Ein Argument, das mit `-` beginnt und keine Zahl
ist, leitet eine Option ein. Negative Zahlen gelten als Wert. `range`
liefert eine Liste, `text` einen String.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-format` | leer | `format`-Muster je Zahl, wie `seq -f` |
| `-equalwidth` | 0 | mit Nullen auf gleiche Breite, wie `seq -w` |
| `-separator` | `\n` | nur `text`: Trenner, wie `seq -s` |

Sind alle drei Werte Ganzzahlen, rechnet das Modul ganzzahlig, in
beliebiger Größe, auch unter Tcl 8.6 über 32 Bit hinaus. Sonst rechnet
es mit Gleitkomma und gibt die Zahlen mit `%g` aus; `1.0` wird so zu
`1`.
Ein Schritt in die falsche Richtung ergibt eine leere Liste. Ein
`-format` für Ganzzahlen (`%d`) scheitert an Gleitkommawerten mit
`{TCL VALUE INTEGER}`. `-equalwidth` setzt das Minuszeichen vor die
Nullen. `-separator` gilt nur für `text`; `range` wirft dafür
`{TCLUTILS COMMON OPTION -separator}`.

| Fehler | `-errorcode` |
|---|---|
| null oder mehr als drei Werte | `{TCLUTILS TUSEQ ARGS}` |
| Wert ist keine Zahl | `{TCLUTILS TUSEQ VALUE}` |
| Schritt 0 | `{TCLUTILS TUSEQ INCREMENT}` |
| Option ohne Wert | `{TCLUTILS TUSEQ OPTION}` |

```tcl
package require tclutils::tuseq
::tclutils::tuseq::range 5                ;# -> 1 2 3 4 5
::tclutils::tuseq::range 5 -1 1           ;# -> 5 4 3 2 1
::tclutils::tuseq::range 1 0.5 2          ;# -> 1 1.5 2
::tclutils::tuseq::range 8 11 -equalwidth 1
                                          ;# -> 08 09 10 11
::tclutils::tuseq::range -2 1 -equalwidth 1
                                          ;# -> -2 -1 00 01
::tclutils::tuseq::range 1 3 -format %03d ;# -> 001 002 003
::tclutils::tuseq::text -separator , 3    ;# -> 1,2,3
::tclutils::tuseq::text 3 -separator ,    ;# -> 1,2,3
::tclutils::tuseq::text 1 2 7 -separator ,
                                          ;# -> 1,3,5,7
::tclutils::tuseq::range 5000000000 5000000001
                                          ;# -> 5000000000 5000000001
```

---

## Zeichen ersetzen: tutr

[tutr]{.index} ersetzt, löscht und verdichtet Zeichen, wie Unix `tr`.

```tcl
::tclutils::tutr::translate text menge1 menge2
::tclutils::tutr::delete    text menge1
::tclutils::tutr::squeeze   text menge1
::tclutils::tutr::file      pfad menge1 menge2 ?option wert ...?
```

Eine Menge besteht aus einzelnen Zeichen und Bereichen `a-z`. Ein `-`
am Anfang oder Ende steht für sich selbst. Ein absteigender Bereich
wie `c-a` wirft `{TCLUTILS TUTR RANGE}`. `translate` ersetzt das n-te
Zeichen von `menge1` durch das n-te von `menge2`; ist `menge2` kürzer,
gilt ihr letztes Zeichen für den Rest. Steht ein Zeichen in `menge1`
mehrfach, gilt seine letzte Zuordnung. Alle Ersetzungen geschehen in
einem Durchgang, `ab` nach `ba` vertauscht also. Ein leeres `menge2`
wirft `{TCLUTILS TUTR SET2}`, außer auch `menge1` ist leer.
`delete` entfernt die Zeichen der Menge. `squeeze` verdichtet
aufeinanderfolgende gleiche Zeichen der Menge zu einem.

| Option `file` | Vorgabe | Wirkung |
|---|---|---|
| `-delete` | 0 | 1 löscht `menge1` statt zu ersetzen |
| `-squeeze` | 0 | 1 verdichtet danach die Zeichen aus `menge2` |

`file` verlangt `menge2` auch bei `-delete 1`; sie wird dann nur für
`-squeeze` gebraucht und darf sonst `""` sein. Mit leerem `menge2`,
`-squeeze 1` und ohne `-delete` verdichtet `file` nur die Zeichen aus
`menge1`, wie `tr -s menge1`. Ohne `-delete` und `-squeeze` wirft ein
leeres `menge2` `{TCLUTILS TUTR SET2}`.

Abweichungen von Unix `tr`: keine Klassen wie `[:alpha:]` und keine
eigenen Escapes; `\n` oder `\t` schreibt Tcl selbst in den String.

```tcl
package require tclutils::tutr
::tclutils::tutr::translate "hallo welt" a-z A-Z  ;# -> HALLO WELT
::tclutils::tutr::translate "abcde" a-e xy        ;# -> xyyyy
::tclutils::tutr::delete "a1b2c3" 0-9             ;# -> abc
::tclutils::tutr::squeeze "aaabccc  d" "ac "      ;# -> abc d
::tclutils::tutr::translate "abcabc" aa xy         ;# -> ybcybc
```

---

## Zählen: tuwc

[tuwc]{.index} zählt Zeilen, Wörter, Zeichen und Bytes, wie Unix `wc`.

```tcl
::tclutils::tuwc::text daten
::tclutils::tuwc::file pfad
```

Die Rückgabe ist ein Dict mit `lines`, `words`, `chars`, `bytes`;
`file` fügt `file` mit dem Pfad hinzu.

| Schlüssel | Bedeutung |
|---|---|
| `lines` | Zahl der `\n`, plus eins, wenn der Text nicht auf `\n` endet |
| `words` | Folgen ohne Leerraum |
| `chars` | Zeichen (Codepunkte) |
| `bytes` | `text`: Länge in UTF-8; `file`: Größe der Datei in Bytes |

`lines` weicht von `wc -l` ab: Eine letzte Zeile ohne `\n` zählt mit.
Ein leerer Text hat 0 Zeilen, `"\n"` eine. `file` liest mit der
Systemkodierung und macht aus `\r\n` ein `\n`; `lines`, `words` und
`chars` zählen diesen Text. `bytes` ist bei `file` die Dateigröße, wie
bei `wc -c`.

```tcl
package require tclutils::tuwc
set d [::tclutils::tuwc::text "eins zwei\ndrei"]
dict get $d lines                         ;# -> 2
dict get $d words                         ;# -> 3
set d [::tclutils::tuwc::text "Grüße"]
dict get $d chars                         ;# -> 5
dict get $d bytes                         ;# -> 7
```

---

## Seiten: tupr

[tupr]{.index} teilt Text in Seiten mit Kopfzeile, wie Unix `pr` ohne
Spaltensatz.

```tcl
::tclutils::tupr::text text ?option wert ...?
::tclutils::tupr::file pfad ?option wert ...?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-length` | 66 | Zeilen je Seite, mit Kopf und Fuß |
| `-header` | `""`; bei `file` der Dateiname | Titel im Kopf |
| `-width` | 72 | Breite der Kopfzeile |
| `-number` | 0 | 1 nummeriert die Textzeilen (`%5d`, Tabulator) |
| `-date` | jetzt, `%Y-%m-%d %H:%M` | beliebiger String für den Kopf |

Jede Seite hat fünf Kopfzeilen: zwei leere, die Infozeile, zwei leere.
Die Infozeile hat links Datum und Titel, mit drei Leerzeichen
getrennt, und rechtsbündig `Page n`; ist sie zu lang, steht mindestens
ein Leerzeichen vor `Page`. Danach folgen `-length` minus 10
Textzeilen, auf volle Seitenlänge mit leeren Zeilen aufgefüllt, und
fünf leere Fußzeilen. Die Seiten stehen ohne Seitenvorschub
hintereinander, das Ergebnis endet ohne `\n`. `-width` gilt nur für
den Kopf; lange Textzeilen kürzt das Modul nicht. `-number 1` zählt
über alle Seiten. Ein leerer Text ergibt `""`.

`-length` von 10 oder weniger wirft `{TCLUTILS TUPR LENGTH}`.

```tcl
package require tclutils::tupr
set seiten [::tclutils::tupr::text "a\nb\nc" -length 12 \
    -header Liste -date Montag -width 24]
set z [split $seiten \n]
llength $z                      ;# -> 24
lindex $z 2                     ;# -> Montag   Liste    Page 1
lrange $z 5 6                   ;# -> a b
lindex $z 14                    ;# -> Montag   Liste    Page 2
```

---

*Nächstes Kapitel: [Zusammenführen, Aufteilen, Abläufe](043-zusammenfuehren-und-ablaeufe.md)*
