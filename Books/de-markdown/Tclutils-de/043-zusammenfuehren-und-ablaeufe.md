# Zusammenführen, Aufteilen, Abläufe

Dieses Kapitel setzt [Text und Dateien](040-text-und-dateien.md) fort.
Es behandelt die Module, die mehrere Zeilenströme verbinden, Text auf
Dateien verteilen, Abläufe ordnen und Text ungefähr durchsuchen. Jedes
Modul hat ein Unix-Vorbild oder lehnt sich an eines an. Keins startet
ein Programm; alles läuft in Tcl.

| Gruppe | Module | Unix-Vorbild |
|---|---|---|
| Zeilenströme verbinden | `tupaste`, `tujoin`, `tucomm` | paste, join, comm |
| Aufteilen | `tucsplit`, `tusplit` | csplit, split |
| Pipeline-Hilfen | `tutee`, `tuxargs`, `tutsort` | tee, xargs, tsort |
| Felder und Regeln | `tuawk` | awk |
| Ungefähre Suche | `tufuzzy`, `tuagrep` | agrep |

Gemeinsam für die Textvarianten: Ein Text, der auf `\n` endet, ergibt
keine leere letzte Zeile.
Optionen stehen paarweise als `-option wert`. Wahrheitswerte nehmen
alles, was `string is boolean` kennt.

---

## Spalten nebeneinander: tupaste

[tupaste]{.index} setzt Zeile *n* jeder Eingabe zu einer Ausgabezeile zusammen,
wie Unix `paste`.

```tcl
::tclutils::tupaste::lines lineLists ?-delimiter d?
::tclutils::tupaste::texts textList  ?-delimiter d?
::tclutils::tupaste::files paths     ?-delimiter d?
```

`lines` nimmt eine Liste von Zeilenlisten, `texts` eine Liste von
Texten, `files` eine Liste von Pfaden. Alle drei liefern einen String,
Zeilen durch `\n` getrennt, ohne `\n` am Ende.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-delimiter` | `\t` | steht zwischen den Spalten; auch mehrere Zeichen oder leer |

Ist eine Eingabe kürzer, steht an ihrer Stelle ein leeres Feld. Die
Zahl der Ausgabezeilen richtet sich nach der längsten Eingabe.

Abweichungen von `paste`: `-delimiter` gilt als Ganzes für jede Lücke;
eine Liste von Trennzeichen, die reihum wechselt (`paste -d ',;'`),
gibt es nicht. Ebenso fehlt `paste -s` (eine Eingabe als eine Zeile).
Eine unbekannte Option und eine Option ohne Wert melden
`TCLUTILS COMMON OPTION -name`.

```tcl
package require tclutils::tupaste
::tclutils::tupaste::texts [list "a\nb\nc\n" "1\n2\n"] -delimiter ";"
                                          ;# -> a;1\nb;2\nc;
::tclutils::tupaste::lines {{a b} {1 2}} -delimiter " | "
                                          ;# -> a | 1\nb | 2
::tclutils::tupaste::files {namen.txt orte.txt} -delimiter ": "
    ;# -> Ada: London\nLinus: Helsinki
```

Im letzten Aufruf enthält `namen.txt` die Zeilen `Ada` und `Linus`,
`orte.txt` die Zeilen `London` und `Helsinki`.

---

## Über einen Schlüssel verbinden: tujoin

[tujoin]{.index} verbindet zwei getrennte Textquellen über ein Schlüsselfeld,
angelehnt an Unix `join`.

```tcl
::tclutils::tujoin::lines leftLines rightLines ?option wert ...?
::tclutils::tujoin::texts leftText  rightText  ?option wert ...?
::tclutils::tujoin::files leftPath  rightPath  ?option wert ...?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-delimiter` | `\t` | Feldtrenner der Eingabe; mehrere Zeichen sind ein literaler Trenner |
| `-joiner` | wie `-delimiter` | Feldtrenner der Ausgabe |
| `-leftfield` | 1 | Schlüsselfeld links, ab 1 |
| `-rightfield` | 1 | Schlüsselfeld rechts, ab 1 |
| `-header` | 0 | erste Zeile beider Seiten ist Kopfzeile |
| `-outer` | `none` | `none`, `left`, `right`, `full` |
| `-anti` | `none` | `none`, `left`, `right`, `both` |

Jede Ausgabezeile besteht aus dem Schlüssel, den übrigen Feldern links
und den übrigen Feldern rechts. Die Rückgabe ist ein String mit `\n`
zwischen den Zeilen.

- `-outer none` ist der innere Join: nur Zeilen mit Partner.
- `-outer left`, `right`, `full` nehmen Zeilen ohne Partner der
  genannten Seite mit. Die fehlende Seite wird mit leeren Feldern
  aufgefüllt, so viele, wie die breiteste Zeile dieser Seite Felder hat.
- `-anti left`, `right`, `both` liefern nur Zeilen ohne Partner:
  Schlüssel und Felder der eigenen Seite, ohne Auffüllen.
- Mit `-header 1` steht die verbundene Kopfzeile vorn. Bei `-anti`
  entfällt sie.

Abweichungen von `join`: Die Eingaben müssen nicht sortiert sein; die
rechte Seite wird als Index gelesen. Die Ausgabe folgt der Reihenfolge
links; Zeilen ohne Partner von rechts folgen danach in ihrer
Reihenfolge. Doppelte Schlüssel ergeben wie bei `join` jede Kombination.
Vorgabetrenner ist der Tabulator, nicht Leerraum. `-outer` entspricht
`join -a`, füllt aber auf; `-anti` entspricht `join -v`.

| Fehler | Meldung | `-errorcode` |
|---|---|---|
| unbekannte Option | `unknown option "-x"` | `TCLUTILS COMMON OPTION -x` |
| Option ohne Wert | `missing value for option "-x"` | `TCLUTILS COMMON OPTION -x` |
| Feldnummer kleiner 1 | `-leftfield must be a positive integer` | `TCLUTILS COMMON INTEGER -leftfield` |
| `-header` kein Wahrheitswert | `-header requires a boolean value` | `TCLUTILS COMMON BOOLEAN -header` |
| unbekannter Wert | `unknown -outer: x` | `TCLUTILS COMMON VALUE -outer` |
| `-outer` und `-anti` zugleich | `cannot combine -outer and -anti` | `TCLUTILS TUJOIN COMBINE` |
| leerer `-delimiter` | `delimiter must not be empty` | `TCLUTILS COMMON DELIMITER` |

Die Meldung zu einem unbekannten Wert nennt in einer zweiten Zeile die
erlaubten Werte, etwa `Known: none left right full`; bei `-anti` heißt
sie `unknown -anti: x` mit dem `-errorcode` `TCLUTILS COMMON VALUE -anti`.

```tcl
package require tclutils::tujoin
set L "1;Ada\n2;Linus\n3;Grace\n"
set R "1;Berlin\n2;Helsinki\n4;Paris\n"
::tclutils::tujoin::texts $L $R -delimiter ";"
    ;# -> 1;Ada;Berlin\n2;Linus;Helsinki
::tclutils::tujoin::texts $L $R -delimiter ";" -outer full
    ;# -> 1;Ada;Berlin\n2;Linus;Helsinki\n3;Grace;\n4;;Paris
::tclutils::tujoin::texts $L $R -delimiter ";" -anti both
                                          ;# -> 3;Grace\n4;Paris
::tclutils::tujoin::texts $L $R -delimiter ";" -joiner ,
    ;# -> 1,Ada,Berlin\n2,Linus,Helsinki
::tclutils::tujoin::texts "id;name\n1;Ada" "ort;id\nBerlin;1" \
    -delimiter ";" -header 1 -rightfield 2
    ;# -> id;name;ort\n1;Ada;Berlin
```

Für CSV mit Anführungszeichen ist `tujoin` nicht gebaut; das Zerlegen
übernimmt `tucsv`, Kapitel [Datenformate](050-datenformate.md).

---

## Zwei Mengen vergleichen: tucomm

[tucomm]{.index} vergleicht zwei sortierte Zeilenlisten wie Unix `comm`.

```tcl
::tclutils::tucomm::compareLines aLines bLines ?-sort b? ?-nocase b?
::tclutils::tucomm::text  aText bText ?-sort b? ?-nocase b?
::tclutils::tucomm::files aFile bFile ?-sort b? ?-nocase b?
::tclutils::tucomm::formatColumns comparison ?-separator s?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-sort` | 0 | beide Eingaben vorher sortieren, in der Ordnung des Vergleichs |
| `-nocase` | 0 | Vergleich ohne Groß/Klein |
| `-separator` | `\t` | nur `formatColumns`: Einrückung je Spalte |

Rückgabe der drei Vergleichsbefehle ist ein Dict mit den Schlüsseln
`onlyA` (nur links), `onlyB` (nur rechts) und `both`. Bei `both` steht
die Zeile aus der linken Eingabe. Doppelte Zeilen zählen einzeln, wie
bei `comm`.

`formatColumns` macht daraus Text im Stil von `comm`: `onlyA` ohne
Einrückung, `onlyB` mit einem Trenner davor, `both` mit zwei. Anders als
`comm` stehen die Gruppen nacheinander, nicht in einer gemeinsamen
sortierten Folge.

Der Vergleich ist ein Mischlauf mit `string compare`, mit `-nocase 1`
über die klein geschriebene Zeile. Das ist die Ordnung nach Zeichencodes,
wie bei `comm` und `sort` mit dem C-Locale. `-sort 1` sortiert beide
Eingaben in genau dieser Ordnung (`lsort` ohne Option, mit `-nocase 1`
nach der klein geschriebenen Zeile). Gleiche Zeilen landen damit immer
unter `both`, auch bei Ziffern (`a9`, `a10`) und gemischter Schreibung.
Unsortierte Eingaben ohne `-sort 1` ergeben ein falsches Ergebnis ohne
Fehler. Wer selbst sortiert, nimmt `lsort` ohne Option;
`lsort -dictionary` ordnet `a9` vor `a10` und passt nicht zum
Mischlauf.

Fehler: unbekannte Option `TCLUTILS COMMON OPTION -name`, ein
Wahrheitswert, der keiner ist, `TCLUTILS COMMON BOOLEAN -sort`
bzw. `-nocase`.

```tcl
package require tclutils::tucomm
set r [::tclutils::tucomm::text "apfel\nbirne\nkiwi\n" \
    "birne\nkiwi\nmango\n"]
dict get $r onlyA                         ;# -> apfel
dict get $r both                          ;# -> birne kiwi
::tclutils::tucomm::formatColumns $r -separator |
    ;# -> apfel\n|mango\n||birne\n||kiwi
::tclutils::tucomm::compareLines [lsort {a10 a9}] {a10}
    ;# -> onlyA a9 onlyB {} both a10
::tclutils::tucomm::compareLines {a9 a10} {a10} -sort 1
    ;# -> onlyA a9 onlyB {} both a10
::tclutils::tucomm::compareLines {a B} {B} -sort 1
    ;# -> onlyA a onlyB {} both B
```

Die beiden letzten Aufrufe zeigen die Fälle aus dem Absatz oben: `a10`
und `B` stehen in beiden Eingaben und erscheinen unter `both`. Ein
zeilenweiser
Unterschied mit Reihenfolge ist Sache von `tudiff`, Kapitel
[Kodierung, Hash und Vergleich](052-kodierung-hash-vergleich.md).

---

## An Mustern aufteilen: tucsplit

[tucsplit]{.index} schreibt einen Text in mehrere Dateien und beginnt bei jeder
Zeile, die zu einem Muster passt, eine neue Datei. Vorbild ist Unix
`csplit`.

```tcl
::tclutils::tucsplit::splitText text pattern ?option wert ...?
::tclutils::tucsplit::file      path pattern ?option wert ...?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-regexp` | 1 | Muster als regulärer Ausdruck; 0 heißt `string match` |
| `-keepmatch` | 1 | die passende Zeile beginnt den neuen Teil; 0 lässt sie weg |
| `-empty` | 0 | leere Teile mitschreiben |
| `-prefix` | `xx` | Anfang des Dateinamens |
| `-suffix` | leer | Ende des Dateinamens, etwa `.md` |
| `-digits` | 2 | Stellen der laufenden Nummer, ab 0 |
| `-outdir` | `.` | Zielverzeichnis; fehlt es, wird es angelegt |

Rückgabe ist die Liste der geschriebenen Pfade, mindestens einer: Ein
Text ohne Treffer und ein leerer Text ergeben je eine Datei. Vor dem
ersten Treffer steht ohne `-empty 1` kein leerer Teil. Die Teile enden
ohne `\n`, auch wenn die Eingabe eins hatte. Vorhandene Dateien gleichen
Namens werden überschrieben.

Abweichungen von `csplit`: Ein einziges Muster gilt für alle Zeilen; es
gibt keine Liste von Mustern, keine Zeilennummern als Grenze und keine
Wiederholungsangabe `{*}`. Namen und Zählung (`xx00`, `xx01`) sind wie
bei `csplit`.

| Fehler | `-errorcode` |
|---|---|
| `-outdir` ist eine Datei | `TCLUTILS TUCSPLIT OUTDIR` |
| unbekannte Option | `TCLUTILS COMMON OPTION -name` |
| `-digits` kleiner 1 | `TCLUTILS COMMON INTEGER -digits` |
| kein Wahrheitswert | `TCLUTILS COMMON BOOLEAN -name` |

```tcl
package require tclutils::tucsplit
set dir [file join [pwd] kapitel]
set md "Vorwort\n# Eins\neins\n# Zwei\nzwei\n"
set teile [::tclutils::tucsplit::splitText $md {^# } -outdir $dir]
lmap p $teile {file tail $p}              ;# -> xx00 xx01 xx02
set teile [::tclutils::tucsplit::splitText $md {^# } -outdir $dir \
    -prefix kap -suffix .md -keepmatch 0]
lmap p $teile {file tail $p}
    ;# -> kap00.md kap01.md kap02.md
```

Im ersten Lauf enthält `xx00` die Zeile `Vorwort`, `xx01` den Text
`# Eins\neins`, `xx02` den Text `# Zwei\nzwei`. Im zweiten Lauf fehlen
die Überschriften: `kap01.md` enthält nur `eins`.

---

## Nach Größe aufteilen: tusplit

[tusplit]{.index} teilt Text nach Zeilenzahl oder Daten nach Bytezahl, wie
Unix `split`.

```tcl
::tclutils::tusplit::splitLines text ?option wert ...?
::tclutils::tusplit::splitBytes data ?option wert ...?
::tclutils::tusplit::file  path ?-lines n | -bytes n? ?option wert ...?
::tclutils::tusplit::lines path n ?option wert ...?
::tclutils::tusplit::bytes path n ?option wert ...?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-lines` | 1000 | Zeilen je Teil (`splitLines`, `file`) |
| `-bytes` | 1024 | Bytes je Teil (`splitBytes`); bei `file` schaltet die Option in den Bytemodus |
| `-prefix` | `x` | Anfang des Dateinamens |
| `-suffix` | leer | Ende des Dateinamens |
| `-digits` | 2 | Stellen der laufenden Nummer, ab 0 |
| `-outdir` | `.` | Zielverzeichnis; fehlt es, wird es angelegt |

`file` liest im Zeilenmodus als Text, im Bytemodus binär. Ohne `-lines`
und `-bytes` gilt der Zeilenmodus mit 1000 Zeilen. `lines` und `bytes`
sind Kurzformen von `file … -lines n` und `file … -bytes n`. Rückgabe ist
die Liste der Pfade; eine leere Eingabe ergibt eine leere Datei `x00`.

`splitBytes` erwartet eine Bytefolge, also Zeichen bis `\xFF`. Text mit
anderen Zeichen vorher mit `encoding convertto utf-8` umwandeln. Ein
Zeichen über `\xFF` ist ein Fehler `TCLUTILS TUSPLIT BYTES`, unter
Tcl 8.6 und 9.0 gleich; die Prüfung läuft, bevor eine Datei entsteht.

Abweichungen von `split`: Die Nummer ist dezimal (`x00`, `x01`, wie
`split -d`), nicht `xaa`, `xab`. Teile aus `splitLines` enden ohne `\n`.
Eine Aufteilung in eine feste Zahl von Teilen (`split -n`) gibt es nicht.

| Fehler | `-errorcode` |
|---|---|
| `-lines` und `-bytes` zugleich bei `file` | `TCLUTILS TUSPLIT MODE` |
| `-outdir` ist eine Datei | `TCLUTILS TUSPLIT OUTDIR` |
| Zeichen über `\xFF` bei `splitBytes` | `TCLUTILS TUSPLIT BYTES` |
| Anzahl oder `-digits` kleiner 1 | `TCLUTILS COMMON INTEGER -name` |
| unbekannte Option, Option ohne Wert | `TCLUTILS COMMON OPTION -name` |

```tcl
package require tclutils::tusplit
set dir [file join [pwd] teile]
set teile [::tclutils::tusplit::splitLines "1\n2\n3\n4\n5\n" \
    -lines 2 -outdir $dir]
lmap p $teile {file tail $p}              ;# -> x00 x01 x02
set teile [::tclutils::tusplit::splitBytes abcdefg -bytes 3 \
    -outdir $dir -prefix teil -suffix .bin]
lmap p $teile {file tail $p}
    ;# -> teil00.bin teil01.bin teil02.bin
```

`x00` enthält `1\n2`, `x02` nur `5`. Die drei Binärteile enthalten
`abc`, `def` und `g`.

---

## In mehrere Ziele schreiben: tutee

[tutee]{.index} schreibt dieselben Daten in mehrere Dateien und auf Wunsch nach
`stdout`, wie Unix `tee`.

```tcl
::tclutils::tutee::write data paths ?option wert ...?
::tclutils::tutee::writeFile inputFile paths ?-append b? ?-stdout b?
::tclutils::tutee::copyChannel inChan outChans ?option wert ...?
```

| Option | Vorgabe | Befehle | Wirkung |
|---|---|---|---|
| `-append` | 0 | `write`, `writeFile` | anhängen statt überschreiben |
| `-stdout` | 0 | alle | zusätzlich nach `stdout` |
| `-nonewline` | 0 | `write` | kein `\n` am Ende |
| `-chunksize` | 8192 | `copyChannel` | Zeichen je Lesevorgang |

- `write` schreibt `data` mit `puts`, also mit `\n` am Ende, außer mit
  `-nonewline 1`. Rückgabe ist `data`.
- `writeFile` liest `inputFile` als Text und schreibt den Inhalt
  unverändert, ohne zusätzliches `\n`. Rückgabe ist der Inhalt.
  `-nonewline` gibt es hier nicht.
- `copyChannel` liest `inChan` bis zum Ende und schreibt jeden Block in
  alle Kanäle aus `outChans`. Rückgabe ist die Zahl der kopierten
  Zeichen; bei binär geöffneten Kanälen sind das Bytes. Die Kanäle
  öffnet und schließt der Aufrufer.

`write` öffnet alle Ziele, bevor es schreibt, und leert sie erst, wenn
alle offen sind. Schlägt das Öffnen eines Ziels fehl, kommt der Fehler
von `open` (`POSIX ENOENT …`). Die schon geöffneten Kanäle sind dann
wieder geschlossen, vorhandene Dateien behalten ihren Inhalt, und
Dateien, die erst dieser Aufruf angelegt hat, sind wieder entfernt.
`writeFile` verhält sich ebenso.

Fehler der Optionen: `TCLUTILS COMMON BOOLEAN -name`,
`TCLUTILS COMMON INTEGER -chunksize`, `TCLUTILS COMMON OPTION -name`.

```tcl
package require tclutils::tutee
set dir [file join [pwd] tee]
file mkdir $dir
set a [file join $dir a.txt]
set b [file join $dir b.txt]
::tclutils::tutee::write hallo [list $a $b]
                                          ;# -> hallo
::tclutils::tutee::write noch [list $a] -append 1 -nonewline 1
                                          ;# -> noch
set in  [open $a rb]
set out [open [file join $dir kopie.txt] wb]
::tclutils::tutee::copyChannel $in [list $out]
                                          ;# -> 10
close $in; close $out
```

Danach enthält `a.txt` den Text `hallo\nnoch`, `b.txt` den Text
`hallo\n`, `kopie.txt` dasselbe wie `a.txt`.

---

## Listen stapelweise abarbeiten: tuxargs

[tuxargs]{.index} teilt eine Liste in Stapel und ruft für jeden Stapel einen
Tcl-Befehl auf. Vorbild ist Unix `xargs`; statt eines Programms läuft
ein Befehlspräfix.

```tcl
::tclutils::tuxargs::batches items ?-n n? ?-skipempty b?
::tclutils::tuxargs::apply   items commandPrefix ?option wert ...?
::tclutils::tuxargs::command items commandPrefix ?option wert ...?
```

| Option | Vorgabe | Befehle | Wirkung |
|---|---|---|---|
| `-n` | 100 | alle | höchstens so viele Elemente je Stapel |
| `-skipempty` | 1 | alle | leere Elemente vorher entfernen |
| `-collect` | 1 | `apply`, `command` | Ergebnisse sammeln; 0 liefert leer |

`batches` liefert die Liste der Stapel. `apply` ruft je Stapel
`{*}$commandPrefix {*}$stapel` auf und liefert mit `-collect 1` die Liste
der Ergebnisse, ein Element je Stapel. `command` ist derselbe Befehl
unter anderem Namen. Ein Fehler im aufgerufenen Befehl bricht den Lauf
ab und kommt unverändert beim Aufrufer an.

Abweichungen von `xargs`: Die Eingabe ist eine Tcl-Liste, kein Text, der
an Leerraum zerlegt wird; Anführungszeichen und Leerzeichen in Elementen
sind damit kein Thema. Es gibt keine Grenze nach Zeichenzahl und keine
parallele Ausführung (`xargs -P`). Die Vorgabe `-n 100` ist fest, nicht
von der Länge der Kommandozeile abhängig.

Fehler: `-n` kleiner 1 ist `TCLUTILS COMMON INTEGER -n`; dazu
`TCLUTILS COMMON BOOLEAN -name` und `TCLUTILS COMMON OPTION -name`.

```tcl
package require tclutils::tuxargs
::tclutils::tuxargs::batches {a b c d e} -n 2
                                          ;# -> {a b} {c d} e
::tclutils::tuxargs::batches {a {} b} -n 2
                                          ;# -> {a b}
::tclutils::tuxargs::apply {1 2 3 4 5} ::tcl::mathop::+ -n 2
                                          ;# -> 3 7 5
::tclutils::tuxargs::apply {a b c} {list x} -n 2
                                          ;# -> {x a b} {x c}
::tclutils::tuxargs::apply $pfade {file delete} -n 50 -collect 0
```

Der letzte Aufruf löscht die Dateien aus `$pfade` in Stapeln zu 50.

---

## Abhängigkeiten ordnen: tutsort

[tutsort]{.index} sortiert topologisch, wie Unix `tsort`: Jedes Paar `u v`
bedeutet „`u` kommt vor `v`“.

```tcl
::tclutils::tutsort::pairs tokens
::tclutils::tutsort::text  text
::tclutils::tutsort::file  path
```

`pairs` nimmt eine flache Liste und liefert eine Liste. `text` und
`file` zerlegen an Leerraum, wie `tsort`, und liefern die Knoten mit
`\n` getrennt. Ein Paar `u u` meldet einen Knoten ohne Bedingung an.
Die Reihenfolge ist stabil: Von den Knoten, die frei werden, kommt der
zuerst gelesene zuerst. Die Ausgabe von GNU `tsort` ist bei gleicher
Eingabe anders geordnet, aber ebenso gültig.

| Fehler | Meldung | `-errorcode` |
|---|---|---|
| ungerade Zahl von Wörtern | `input contains an odd number of tokens` | `TCLUTILS TUTSORT ODD` |
| Zyklus | `input contains a cycle involving: …` | `TCLUTILS TUTSORT CYCLE` |

Bei einem Zyklus bricht `tutsort` ab; GNU `tsort` gibt eine Warnung aus
und liefert trotzdem eine Folge. Die Meldung nennt nur die Knoten, die
auf einem Zyklus liegen, in der Reihenfolge des ersten Auftretens.
Knoten, die nur hinter einem Zyklus liegen, fehlen darin.

```tcl
package require tclutils::tutsort
::tclutils::tutsort::pairs {hemd jacke hose guertel hose schuhe}
    ;# -> hemd hose jacke guertel schuhe
::tclutils::tutsort::text "a b\nb c\nx x"
                                          ;# -> a\nx\nb\nc
::tclutils::tutsort::pairs {a b b a b c}
    ;# Fehler: input contains a cycle involving: a b
```

---

## Felder und Regeln: tuawk

[tuawk]{.index} bringt das Modell von awk nach Tcl: Jede Zeile ist ein Datensatz,
wird in Felder zerlegt, und eine Liste von Regeln aus Muster und Aktion
läuft darüber. Es ist kein Interpreter der awk-Sprache. Muster sind
Tcl-Ausdrücke, Aktionen sind Tcl-Skripte.

```tcl
::tclutils::tuawk::run  text rules ?-fs s? ?-ofs s? ?-ors s?
::tclutils::tuawk::file path rules ?-fs s? ?-ofs s? ?-ors s?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-fs` | leer | Feldtrenner; leer heißt Folgen von Leerraum |
| `-ofs` | ein Leerzeichen | steht zwischen den Argumenten von `emit` |
| `-ors` | `\n` | steht nach jeder Ausgabe von `emit` |

Rückgabe ist die gesammelte Ausgabe aller `emit`-Aufrufe als String.
`tuawk` schreibt nichts nach `stdout`. `file` liest die Datei als Text
und ruft `run`.

### Regeln

`rules` ist eine flache Liste von Paaren `muster aktion`. Die Regeln
laufen für jeden Datensatz in ihrer Reihenfolge; jede passende Regel
führt ihre Aktion aus.

| Muster | Bedeutung |
|---|---|
| `BEGIN` | Aktion läuft einmal vor dem ersten Datensatz |
| `END` | Aktion läuft einmal nach dem letzten Datensatz |
| leer (`{}`) | passt immer |
| `/regex/` | regulärer Ausdruck gegen die ganze Zeile |
| sonst | Tcl-Ausdruck für `expr`, etwa `{$2 > 3}` oder `{$1 eq "x"}` |

Eine leere Aktion bedeutet `emit $0`, also die Zeile ausgeben.

### Felder und Variablen

| Name | Inhalt |
|---|---|
| `$0` | die ganze Zeile |
| `$1` … | die Felder, ab 1 |
| `$NF` | Zahl der Felder dieser Zeile; vor dem ersten Datensatz 0 |
| `$NR` | Nummer der Zeile, ab 1; vor dem ersten Datensatz 0 |
| `emit arg …` | Ausgabe: Argumente mit `-ofs` verbunden, `-ors` danach |

Felder sind Variablen und lassen sich in einer Aktion ändern
(`set 2 …`); `$0` ändert sich dabei nicht.

Feldtrenner `-fs`: Leer zerlegt wie awk an Folgen von Leerraum und
ignoriert Leerraum am Rand. Ein einzelnes Zeichen zerlegt mit `split`;
zwei Trenner hintereinander ergeben ein leeres Feld. Mehrere Zeichen
gelten als regulärer Ausdruck.

Alle Regeln eines Aufrufs laufen in einem eigenen Rahmen, wie der
Rumpf einer Prozedur, in einem Namensraum, der nach dem Lauf gelöscht
wird. `set name …` legt immer eine Variable dieses Rahmens an, nie eine
globale Variable gleichen Namens; das gilt unter Tcl 8.6 und 9.0
gleich. Variablen aus Aktionen gelten über alle Datensätze bis `END`,
wie globale Variablen in awk. Die Aktionen haben den vollen
Tcl-Befehlssatz; Regeln aus fremder Quelle sind deshalb wie Code zu
behandeln.

In einer Aktion überspringt `break` die übrigen Regeln für den
aktuellen Datensatz, wie `next` in awk; `continue` geht zur nächsten
Regel.

### Unterschiede zu awk

- Ein Feld jenseits von `NF` ist ein Fehler, keine leere Zeichenkette:
  `can't read "3": no such variable`, `-errorcode`
  `TCL LOOKUP VARNAME 3`. Wer mit kürzeren Zeilen rechnet, prüft vorher
  `$NF`.
- Eine unbelegte Variable ist ebenfalls ein Fehler, nicht 0. Startwerte
  gehören in `BEGIN`.
- `-fs " "` zerlegt an jedem einzelnen Leerzeichen; die awk-Bedeutung
  „Leerraum“ hat nur der leere Trenner.
- Kein `printf`, kein `getline`, kein eigener Datensatztrenner. Für
  Formatierung dient `format` im Argument von `emit`.

| Fehler | `-errorcode` |
|---|---|
| unbekannte Option, Option ohne Wert | `TCLUTILS TUAWK OPTION` |
| ungerade Zahl von Elementen in `rules` | `TCLUTILS TUAWK RULES` |
| Feld jenseits von `NF` | `TCL LOOKUP VARNAME n` |

Fehler in Mustern und Aktionen kommen unverändert beim Aufrufer an.

### Beispiele

```tcl
package require tclutils::tuawk
set daten "Ada 3\nLinus 5\nGrace 4\n"
::tclutils::tuawk::run $daten {{$2 > 3} {emit $1}}
                                          ;# -> Linus\nGrace\n
::tclutils::tuawk::run $daten {/^L/ {}}  ;# -> Linus 5\n
::tclutils::tuawk::run $daten {{} {emit $NR $NF $1}} -ofs ";"
    ;# -> 1;2;Ada\n2;2;Linus\n3;2;Grace\n
set regeln {
    BEGIN {set s 0}
    {}    {set s [expr {$s + $2}]}
    END   {emit "Summe: $s"}
}
::tclutils::tuawk::run $daten $regeln    ;# -> Summe: 12\n
```

Gruppieren mit einem Dict, Trenner und Ausgabe umstellen:

```tcl
set log "INFO start\nERROR disk\nINFO ende\n"
::tclutils::tuawk::run $log {
    BEGIN {set n {}}
    {}    {dict incr n $1}
    END   {dict for {k v} $n {emit $k $v}}
}                                         ;# -> INFO 2\nERROR 1\n
::tclutils::tuawk::run $log {/ERROR/ {emit $NR $2}}
                                          ;# -> 2 disk\n
::tclutils::tuawk::run "Ada;3\nLinus;5" {{} {emit $2 $1}} \
    -fs ";" -ofs ,                        ;# -> 3,Ada\n5,Linus\n
::tclutils::tuawk::run "k=v; x=y" {{} {emit $2}} -fs {;\s*}
                                          ;# -> x=y\n
::tclutils::tuawk::run "a b" {{} {emit [format %-4s| $1]}}
                                          ;# -> a   |\n
```

Für ein vollständiges awk-Programm bleibt `exec awk`.

---

## Ungefähr vergleichen: tufuzzy

[tufuzzy]{.index} stellt die Grundlagen der ungefähren Suche bereit. Das Maß ist
der Levenshtein-Abstand: die kleinste Zahl von Einfügungen, Löschungen
und Ersetzungen einzelner Zeichen.

```tcl
::tclutils::tufuzzy::distance       a b              ?-nocase b?
::tclutils::tufuzzy::searchDistance pattern text     ?-nocase b?
::tclutils::tufuzzy::similarity     a b              ?-nocase b?
::tclutils::tufuzzy::subsequence    pattern text     ?-nocase b?
::tclutils::tufuzzy::bestMatch      pattern candidates ?-nocase b?
```

| Befehl | Rückgabe |
|---|---|
| `distance` | Abstand der beiden Zeichenketten, ganze Zahl |
| `searchDistance` | kleinster Abstand von `pattern` zu irgendeinem Ausschnitt von `text` |
| `similarity` | `1.0 - abstand / längere Länge`, zwischen `0.0` und `1.0`; zwei leere Ketten ergeben `1.0` |
| `subsequence` | 1, wenn die Zeichen von `pattern` in dieser Reihenfolge in `text` vorkommen, sonst 0 |
| `bestMatch` | der Kandidat mit dem kleinsten Abstand; bei Gleichstand der erste; leere Liste ergibt `""` |

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-nocase` | 0 | beide Seiten vorher mit `string tolower` |

`subsequence` ist die Suche, wie sie Auswahllisten im Stil von fzf
verwenden: `tcu` passt auf `tclutils`, `utc` nicht. Die Rechnung läuft
über Zeichen, nicht über Bytes; Umlaute zählen als ein Zeichen.

| Fehler | Meldung | `-errorcode` |
|---|---|---|
| unbekannte Option | `unknown option -x` | `TCLUTILS TUFUZZY OPTION` |
| Option ohne Wert | `missing value for option -x` | `TCLUTILS TUFUZZY OPTION` |
| überzählige Argumente | `unexpected arguments: …` | `TCLUTILS TUFUZZY ARGS` |
| `-nocase` kein Wahrheitswert | `-nocase requires a boolean value` | `TCLUTILS COMMON BOOLEAN -nocase` |

```tcl
package require tclutils::tufuzzy
::tclutils::tufuzzy::distance kitten sitting     ;# -> 3
::tclutils::tufuzzy::distance Haus haus -nocase 1
                                                 ;# -> 0
::tclutils::tufuzzy::searchDistance gama "gamma line"
                                                 ;# -> 1
::tclutils::tufuzzy::similarity kitten sitting
                                          ;# -> 0.5714285714285714
::tclutils::tufuzzy::subsequence tcu tclutils    ;# -> 1
::tclutils::tufuzzy::bestMatch tujion {tujoin tupaste tucomm}
                                                 ;# -> tujoin
```

---

## Ungefähr suchen: tuagrep

[tuagrep]{.index} ist ein grep mit Fehlertoleranz, aufgebaut auf
`tufuzzy::searchDistance`. Eine Zeile passt, wenn der Abstand des
Musters zu einem Ausschnitt der Zeile höchstens `-maxdist` ist. Vorbild
ist Unix `agrep`.

```tcl
::tclutils::tuagrep::search text     pattern ?option wert ...?
::tclutils::tuagrep::match  line     pattern ?option wert ...?
::tclutils::tuagrep::file   filename pattern ?option wert ...?
::tclutils::tuagrep::files  fileList pattern ?option wert ...?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-maxdist` | 1 | größter erlaubter Abstand, ganze Zahl ab 0; 0 heißt exakter Teilstring |
| `-nocase` | 0 | ohne Groß/Klein |
| `-invert` | 0 | die Zeilen ohne Treffer |
| `-linenumbers` | 0 | jede Zeile als `{nummer text}`, Nummer ab 1 |
| `-count` | 0 | nur die Anzahl |
| `-filenames` | 0 | nur `file`: Treffer als `{datei treffer}` |
| `-fileswithmatches` | 0 | nur `file`, `files`: nur die Pfade mit Treffer |

| Befehl | Rückgabe |
|---|---|
| `search` | Liste der Treffer, mit `-count 1` die Anzahl |
| `match` | 1 oder 0 für eine Zeile; beachtet `-maxdist`, `-nocase`, `-invert` |
| `file` | wie `search`; mit `-fileswithmatches 1` der Pfad oder `""` |
| `files` | Treffer aller Dateien, immer mit Dateinamen; mit `-count 1` ein Dict `pfad anzahl`; mit `-fileswithmatches 1` die Liste der Pfade |

Die Optionen gleichen denen von `tugrep` aus
[Text und Dateien](040-text-und-dateien.md). `tuagrep` kennt kein
`-max`, kein `-word` und kein `-wholeline`, und das Muster ist immer
literal: keine regulären Ausdrücke. `agrep` erlaubt dagegen Muster
mit Fehlertoleranz und Gewichte für Einfügen, Löschen und Ersetzen;
`-maxdist` entspricht `agrep -k` bzw. `-1` bis `-9`.

`search` zerlegt den Text an `\n` in dieselben Zeilen, die `file` liest:
Ein `\n` am Ende schließt die letzte Zeile ab und beginnt keine leere;
ein leerer Text hat keine Zeile. Ein leeres Muster passt auf jede Zeile.
Ein Text hat keinen Dateinamen; `search` und `match` nehmen
`-filenames` und `-fileswithmatches` an, lassen sie aber ohne Wirkung.
`files` setzt den Dateinamen immer dazu.

| Fehler | Meldung | `-errorcode` |
|---|---|---|
| unbekannte Option | `unknown option -x` | `TCLUTILS TUAGREP OPTION` |
| Option ohne Wert | `missing value for option -x` | `TCLUTILS TUAGREP OPTION` |
| überzählige Argumente | `unexpected arguments: …` | `TCLUTILS TUAGREP ARGS` |
| `-maxdist` keine ganze Zahl ab 0 | `-maxdist must be a non-negative integer` | `TCLUTILS TUAGREP MAXDIST` |
| Schalter kein Wahrheitswert | `-invert requires a boolean value` | `TCLUTILS COMMON BOOLEAN -name` |

Eine Datei, die sich nicht öffnen lässt, meldet `open` mit
`POSIX ENOENT …`.

```tcl
package require tclutils::tuagrep
set text "gamma line\nbeta line\ndelta"
::tclutils::tuagrep::search $text gama   ;# -> {gamma line}
::tclutils::tuagrep::search $text gama -maxdist 0
                                          ;# ->
::tclutils::tuagrep::search $text gama -linenumbers 1
                                          ;# -> {1 {gamma line}}
::tclutils::tuagrep::search $text gama -invert 1
                                          ;# -> {beta line} delta
::tclutils::tuagrep::match Hauptstrasse strase
                                          ;# -> 1
::tclutils::tuagrep::search "eins\nzwei\n" xyz -invert 1
                                          ;# -> eins zwei
::tclutils::tuagrep::search $text gama -maxdist x
    ;# Fehler: -maxdist must be a non-negative integer
```

Mit Dateien; `a.txt` enthält `gamma line` und `beta`, `b.txt` enthält
`nichts` und `gamma`, `c.txt` enthält `leer`:

```tcl
::tclutils::tuagrep::files {a.txt b.txt c.txt} gama
    ;# -> {a.txt {gamma line}} {b.txt gamma}
::tclutils::tuagrep::files {a.txt b.txt c.txt} gama -count 1
                                          ;# -> a.txt 1 b.txt 1 c.txt 0
::tclutils::tuagrep::files {a.txt b.txt c.txt} gama \
    -fileswithmatches 1                   ;# -> a.txt b.txt
```

---

*Nächstes Kapitel: [Zeichen, Zahlen, Datum und Pfade](045-zeichen-zahlen-datum.md)*
