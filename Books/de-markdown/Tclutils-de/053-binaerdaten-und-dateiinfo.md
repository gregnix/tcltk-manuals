# Binärdaten und Dateiinformationen

Die Module dieses Kapitels zeigen Bytes an, suchen und ändern sie in
einer Datei, vergleichen zwei Dateien und lesen Größe und Metadaten.
`tucode` liefert dazu die Zeichentabellen für ASCII und Latin-1. Alle
Module sind reines Tcl.

| Gruppe | Module |
|---|---|
| Ansehen | `tuhexdump`, `tuod`, `tustrings` |
| Ändern | `tuhexedit` |
| Vergleichen | `tucmp` |
| Größe und Metadaten | `tusize`, `tustat` |
| Zeichentabellen | `tucode` |

Die Befehle mit Daten als Argument erwarten Bytes: einen Tcl-String,
in dem jedes Zeichen einen Wert von 0 bis 255 hat. So einen String
liefert `read` auf einem Kanal mit `-translation binary`, und so lesen
auch die `file`-Varianten der Module ihre Datei. Ein Text mit Zeichen
über 255, etwa `€`, ist kein Byte-String. `tuhexdump`, `tuod`,
`tustrings`, `tucmp` und `tuhexedit::writeBytes` prüfen das vorab und
werfen unter Tcl 8.6 und 9 gleich `{TCLUTILS <MODUL> BYTES}`, etwa
`{TCLUTILS TUOD BYTES}`. Text wird deshalb vorher mit
`encoding convertto utf-8` in Bytes gewandelt.

```tcl
package require tclutils::tuod
::tclutils::tuod::bytes [encoding convertto utf-8 €]
                                          ;# -> 226 130 172
catch {::tclutils::tuod::bytes €} msg opts ;# -> 1
dict get $opts -errorcode         ;# -> TCLUTILS TUOD BYTES
```

Prüfsummen, Hashes, Base64 und der Zeilenvergleich stehen im Kapitel
[Kodierung, Hash und Vergleich](052-kodierung-hash-vergleich.md), die
Erkennung des Dateityps mit `tufile` im Kapitel
[Text und Dateien](040-text-und-dateien.md).

---

## Hexdump: tuhexdump

[tuhexdump]{.index} gibt Bytes als Zeilen mit Adresse, Hex-Werten und
ASCII-Spalte aus, in der Form von `hexdump -C`.

```tcl
::tclutils::tuhexdump::data bytes ?option wert ...?
::tclutils::tuhexdump::file pfad  ?option wert ...?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-width` | `16` | Bytes je Zeile, ganze Zahl ab 1 |
| `-offset` | `0` | erstes Byte; die Adresse zählt ab hier |
| `-length` | `-1` | Anzahl der Bytes; negativ heißt bis zum Ende |

Rückgabe ist ein String, Zeilen getrennt durch `\n`, ohne `\n` am Ende.
Jede Zeile hat die Adresse mit acht Hex-Stellen, die Bytes in
Kleinbuchstaben und zwischen `|` die Zeichen 32 bis 126; jedes andere
Byte steht dort als `.`. Die letzte Zeile wird mit Leerzeichen auf die
volle Breite aufgefüllt. Leere Daten ergeben einen leeren String.

Abweichungen von `hexdump -C` und `xxd`: keine Lücke nach dem achten
Byte, keine Zusammenfassung gleicher Zeilen mit `*`, keine Schlusszeile
mit der Endadresse.

```tcl
package require tclutils::tuhexdump
set daten "Hallo, Welt!\n\x00\x01\xff"
puts [::tclutils::tuhexdump::data $daten -width 8]
```

```text
00000000  48 61 6c 6c 6f 2c 20 57  |Hallo, W|
00000008  65 6c 74 21 0a 00 01 ff  |elt!....|
```

```tcl
::tclutils::tuhexdump::data "Hallo, Welt!" -offset 7 -length 4 -width 4
                              ;# -> 00000007  57 65 6c 74  |Welt|
```

Bei Standardbreite ist eine Zeile 77 Zeichen lang.

| Fehler | `-errorcode` |
|---|---|
| `-width` keine ganze Zahl ab 1 | `{TCLUTILS COMMON INTEGER -width}` |
| `-offset` negativ oder keine ganze Zahl | `{TCLUTILS TUHEXDUMP OFFSET}` |
| `-length` keine ganze Zahl | `{TCLUTILS TUHEXDUMP LENGTH}` |
| Zeichen über 255 in den Daten | `{TCLUTILS TUHEXDUMP BYTES}` |
| unbekannte Option, Option ohne Wert | `{TCLUTILS COMMON OPTION -name}` |

---

## Oktal, dezimal, Zeichen: tuod

[tuod]{.index} gibt Bytes einzeln als Oktal-, Hex- oder Dezimalzahl oder als
Zeichen aus. `bytes` liefert die Bytewerte als Liste ohne Vorzeichen;
`binary scan` mit `c` allein ergäbe für `\xff` den Wert `-1`.

```tcl
::tclutils::tuod::bytes bytes ?option wert ...?
::tclutils::tuod::data  bytes ?option wert ...?
::tclutils::tuod::file  pfad  ?option wert ...?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-format` | `octal` | `octal` (`%03o`), `hex` (`%02x`), `decimal` (`%03d`), `char` |
| `-width` | `16` | Bytes je Zeile, mindestens 1 |
| `-offset` | `0` | erstes Byte |
| `-length` | `-1` | Anzahl der Bytes; negativ heißt bis zum Ende |
| `-address` | `hex` | `hex` (8 Stellen), `octal` (7), `decimal` (8), `none` |

`-format char` zeigt die Zeichen 32 bis 126 und sonst `.`. Zwischen
Adresse und Werten stehen zwei Leerzeichen, zwischen den Werten eines.
`bytes` wertet nur `-offset` und `-length` aus und nimmt die übrigen
Optionen ohne Wirkung an.

Abweichungen von `od`: Unix `od` zeigt ohne Option Zwei-Byte-Wörter
oktal und die Adresse oktal. `tuod` zeigt jedes Byte einzeln und die
Adresse hex; `-address octal` ergibt die Adresse wie bei `od`. Statt
`\n` und `\0` wie bei `od -c` steht `.`. Gleiche Zeilen werden nicht
zu `*` zusammengefasst, eine Schlusszeile mit der Endadresse fehlt.

```tcl
package require tclutils::tuod
::tclutils::tuod::bytes "A\x00\xff"       ;# -> 65 0 255
::tclutils::tuod::data ABC                ;# -> 00000000  101 102 103
::tclutils::tuod::data "Hallo\n" -format hex -address none
                                          ;# -> 48 61 6c 6c 6f 0a
::tclutils::tuod::data abcdef -format char -offset 2 -length 3
                                          ;# -> 00000002  c d e
set daten "Hallo\n\x00\xff"
puts [::tclutils::tuod::data $daten -format char \
    -address octal -width 4]
```

```text
0000000  H a l l
0000004  o . . .
```

| Fehler | `-errorcode` |
|---|---|
| unbekanntes `-format` | `{TCLUTILS TUOD FORMAT wert}` |
| unbekannte `-address` | `{TCLUTILS TUOD ADDRESS wert}` |
| `-width` keine ganze Zahl ab 1 | `{TCLUTILS TUOD WIDTH}` |
| `-offset` negativ oder keine ganze Zahl | `{TCLUTILS TUOD OFFSET}` |
| `-length` keine ganze Zahl | `{TCLUTILS TUOD LENGTH}` |
| Zeichen über 255 in den Daten | `{TCLUTILS TUOD BYTES}` |
| unbekannte Option, Option ohne Wert | `{TCLUTILS COMMON OPTION -name}` |

`data` und `file` prüfen `-format` und `-address` vor dem ersten Byte,
ein falscher Wert fällt also auch bei leeren Daten auf.

---

## Lesbare Zeichenketten: tustrings

[tustrings]{.index} sucht in Binärdaten Folgen druckbarer ASCII-Zeichen, wie
Unix `strings`.

```tcl
::tclutils::tustrings::extract bytes ?-minlength n?
::tclutils::tustrings::file    pfad  ?-minlength n?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-minlength` | `4` | kürzere Folgen werden verworfen; ganze Zahl ab 1 |

Druckbar sind die Bytes 32 bis 126. Jedes andere Byte beendet eine
Folge, auch Tabulator und Zeilenende. Rückgabe ist eine Tcl-Liste der
Folgen in der Reihenfolge des Vorkommens, ohne Position.

Abweichungen von `strings`: GNU `strings` zählt den Tabulator zur
Zeichenkette, `tustrings` trennt dort. Eine Ausgabe der Position wie
`strings -t` gibt es nicht. Umlaute sind auch in Latin-1 keine
druckbaren ASCII-Zeichen und trennen ebenfalls.

```tcl
package require tclutils::tustrings
set bin "\x00\x01%PDF-1.7\x00ab\x00Hallo Welt\n\xffKey\tWert"
::tclutils::tustrings::extract $bin  ;# -> %PDF-1.7 {Hallo Welt} Wert
::tclutils::tustrings::extract $bin -minlength 2
                          ;# -> %PDF-1.7 ab {Hallo Welt} Key Wert
::tclutils::tustrings::extract "Größe 12"  ;# -> {e 12}
```

Eine Option `-encoding` gibt es nicht; druckbar sind immer die Bytes
32 bis 126.

| Fehler | `-errorcode` |
|---|---|
| `-minlength` keine ganze Zahl ab 1 | `{TCLUTILS COMMON INTEGER -minlength}` |
| Zeichen über 255 in den Daten | `{TCLUTILS TUSTRINGS BYTES}` |
| unbekannte Option, Option ohne Wert | `{TCLUTILS COMMON OPTION -name}` |

---

## Lesen, suchen, patchen: tuhexedit

[tuhexedit]{.index} liest Bytes an einer Stelle, sucht Byte- und Textmuster und
überschreibt Bytes in der Datei. Es ist eine Bibliothek, kein Editor
mit Oberfläche. Unix hat dafür kein einzelnes Werkzeug; das
Überschreiben an fester Stelle entspricht `dd ... conv=notrunc`.

```tcl
::tclutils::tuhexedit::readBytes  pfad offset länge
::tclutils::tuhexedit::writeBytes pfad offset bytes ?sicherung?
::tclutils::tuhexedit::patch      pfad offset hex ?-backup 1?
::tclutils::tuhexedit::backup     pfad ?zielname?
::tclutils::tuhexedit::findHex    pfad hex
::tclutils::tuhexedit::findString pfad text ?kodierung?
::tclutils::tuhexedit::dump       pfad ?option wert ...?
```

| Befehl | Rückgabe |
|---|---|
| `readBytes` | die Bytes; am Dateiende weniger, hinter dem Ende leer |
| `writeBytes`, `patch` | der Pfad, wie übergeben |
| `backup` | der Name der Kopie; Vorgabe `pfad.bak` |
| `findHex`, `findString` | Liste der Offsets ab 0, auch überlappend |
| `dump` | Hexdump wie `tuhexdump::file`, mit dessen Optionen |

Ein Offset ist eine ganze Zahl ab 0 oder Hex mit `0x`, etwa `0x100`;
`0x` ohne gültige Hex-Ziffer ist ein Fehler.
Hex-Muster für `findHex` und `patch` dürfen Leerzeichen, `:`, `-`, `,`
und `0x` vor jedem Byte enthalten; `{50 4B 03 04}`, `504b0304` und
`0x50,0x4B,0x03,0x04` sind dasselbe Muster. `findString` wandelt den
Text vor der Suche mit der Kodierung in Bytes, Vorgabe `utf-8`. Ein
`ä` in einer Latin-1-Datei findet deshalb nur `findString pfad ä
iso8859-1`. Ein Zeichen, das die Kodierung nicht darstellen kann, ist
ein Fehler.

`writeBytes` und `patch` legen vorher eine Kopie `pfad.bak` an und
überschreiben eine vorhandene Kopie. `writeBytes` mit `0` als viertem
Argument und `patch` mit `-backup 0` lassen die Kopie weg. Die Datei
wird an der Stelle überschrieben, nichts wird eingefügt oder entfernt;
die Länge der Datei bleibt gleich. Reichen die Bytes ab dem Offset über
das Dateiende hinaus, wirft der Befehl einen Fehler, bevor er die Kopie
anlegt; Datei und Kopie bleiben dann unverändert. `findHex`,
`findString` und `patch` lesen die ganze Datei, `readBytes` nur den
angegebenen Teil.

```tcl
package require tclutils::tuhexedit
set fh [open probe.bin wb]
puts -nonewline $fh ABCDEFGH
close $fh
::tclutils::tuhexedit::readBytes probe.bin 2 3    ;# -> CDE
::tclutils::tuhexedit::findString probe.bin CD    ;# -> 2
::tclutils::tuhexedit::findHex probe.bin {47 48}  ;# -> 6
::tclutils::tuhexedit::patch probe.bin 0x2 {58 59}
                                          ;# -> probe.bin
::tclutils::tuhexedit::readBytes probe.bin 0 8    ;# -> ABXYEFGH
::tclutils::tuhexedit::readBytes probe.bin.bak 0 8
                                          ;# -> ABCDEFGH
::tclutils::tuhexedit::dump probe.bin -width 8
              ;# -> 00000000  41 42 58 59 45 46 47 48  |ABXYEFGH|
catch {::tclutils::tuhexedit::patch probe.bin 7 {58 59}} msg opts
                                          ;# -> 1
dict get $opts -errorcode     ;# -> TCLUTILS TUHEXEDIT RANGE
```

| Fehler | `-errorcode` |
|---|---|
| Offset negativ, keine Zahl oder `0x` ohne Hex-Ziffer | `{TCLUTILS TUHEXEDIT OFFSET}` |
| Länge negativ oder keine Zahl | `{TCLUTILS TUHEXEDIT LENGTH}` |
| Schreiben über das Dateiende | `{TCLUTILS TUHEXEDIT RANGE}` |
| `writeBytes` mit Zeichen über 255 | `{TCLUTILS TUHEXEDIT BYTES}` |
| Zeichen nicht in der Kodierung (`findString`) | `{TCLUTILS TUHEXEDIT ENCODING}` |
| leeres Suchmuster | `{TCLUTILS TUHEXEDIT NEEDLE}` |
| Hex mit ungerader Stellenzahl | `{TCLUTILS TUBIN HEX ODD}` |
| Hex mit anderen Zeichen | `{TCLUTILS TUBIN HEX BADCHAR}` |
| unbekannte Option an `patch` | `{TCLUTILS COMMON OPTION -name}` |
| unbekannte Kodierung | `{TCL LOOKUP ENCODING name}` |
| Datei fehlt | `{POSIX ENOENT ...}` |

`writeBytes` legt keine neue Datei an; eine fehlende Datei wirft
`{POSIX ENOENT ...}`. Alle Prüfungen laufen vor dem Schreiben, ein
abgelehnter Aufruf ändert nichts.

---

## Byteweise vergleichen: tucmp

[tucmp]{.index} vergleicht zwei Byte-Strings oder zwei Dateien und meldet die
erste Abweichung, wie Unix `cmp`.

```tcl
::tclutils::tucmp::data            bytes1 bytes2
::tclutils::tucmp::files           pfad1 pfad2
::tclutils::tucmp::equal           pfad1 pfad2
::tclutils::tucmp::firstDifference pfad1 pfad2
```

`data` und `files` liefern ein Dict:

| Schlüssel | Inhalt |
|---|---|
| `equal` | `1` bei gleichen Daten, sonst `0` |
| `offset` | erste abweichende Stelle ab 0; `-1` bei gleichen Daten |
| `byte1`, `byte2` | Bytewert 0–255 an `offset`; leer, wo die Daten zu Ende sind |
| `size1`, `size2` | Anzahl der Bytes beider Daten |

`equal` liefert nur `equal`, `firstDifference` nur `offset`. Ist eine
Seite der Anfang der anderen, steht `offset` auf der Länge der kürzeren
Seite und deren Byte ist leer.

Abweichungen von `cmp`: Der Offset zählt ab 0, `cmp` zählt Byte und
Zeile ab 1. Eine Zeilennummer gibt es nicht, das Ergebnis ist ein Dict
statt eines Exit-Status. `files` liest beide Dateien ganz in den
Speicher.

```tcl
package require tclutils::tucmp
dict get [::tclutils::tucmp::data abc abc] equal    ;# -> 1
dict get [::tclutils::tucmp::data abc abc] offset   ;# -> -1
::tclutils::tucmp::data abc abx
::tclutils::tucmp::data abc abcd
```

```text
equal 0 offset 2 byte1 99 byte2 120 size1 3 size2 3
equal 0 offset 3 byte1 {} byte2 100 size1 3 size2 4
```

`data` vergleicht Bytes. Ein Zeichen über 255 ist ein Fehler, auch
wenn beide Strings gleich sind; Text wird vorher mit
`encoding convertto` gewandelt.

```tcl
set cmp [::tclutils::tucmp::data [encoding convertto utf-8 a€] \
    [encoding convertto utf-8 aä]]
dict get $cmp byte1                       ;# -> 226
dict get $cmp size1                       ;# -> 4
```

| Fehler | `-errorcode` |
|---|---|
| Zeichen über 255 in `data` | `{TCLUTILS TUCMP BYTES}` |
| Datei fehlt | `{POSIX ENOENT ...}` |

---

## Größen: tusize

[tusize]{.index} summiert Dateigrößen unter einem Verzeichnis und schreibt
Bytezahlen lesbar, ein kleines `du`.

```tcl
::tclutils::tusize::bytes   pfad
::tclutils::tusize::entries verzeichnis
::tclutils::tusize::human   n ?-si 0|1?
```

| Befehl | Rückgabe |
|---|---|
| `bytes` | Größe der Datei, oder die Summe aller Dateien darunter |
| `entries` | Liste `{bytes pfad}` je direktem Eintrag, nach Pfad sortiert |
| `human` | Zahl mit Einheit |

| Option `human` | Vorgabe | Wirkung |
|---|---|---|
| `-si` | `0` | `0`: Basis 1024, `B KiB MiB GiB TiB PiB EiB ZiB YiB`; `1`: Basis 1000, `B kB MB GB TB PB EB ZB YB` |

`bytes` nimmt Punkt-Dateien mit. Gezählt wird die Dateigröße, nicht
der belegte Platz auf dem Datenträger, und die Verzeichnisse selbst
zählen nicht mit. Unter der Basis gibt `human` die ganze Zahl mit `B`
aus, sonst den Wert mit einer Nachkommastelle. Über `YiB` (`YB`) geht
es nicht hinaus, größere Werte bleiben in dieser Einheit.

Die Einheit nennt immer ihre Basis: `KiB` ist 1024, `kB` ist 1000. 1500
und 1536 Bytes sind beide `1.5 KiB`, weil nur eine Nachkommastelle
steht. `tunumfmt::toHuman` schreibt dagegen wie `numfmt` das bloße `K`
für 1000 (`1.5K`); für Bytes passt dort `-to iec` (`1.5Ki`).

In einen symbolischen Link steigt `bytes` nicht ab und folgt ihm
nicht. Gezählt wird der Link selbst mit `file lstat`; unter Unix ist
seine Größe die Länge des Zielpfads. Das gilt für Links auf Dateien,
auf Verzeichnisse und für Links ohne Ziel. Ein Link im Kreis führt so
nicht in eine Schleife.

Abweichungen von `du`: `du` zählt ohne Option belegte Blöcke und die
Verzeichnisse selbst. `tusize::bytes` liegt näher an `du -sb`, ohne die
Verzeichniseinträge.

```tcl
package require tclutils::tusize
file mkdir projekt/sub
foreach {pfad n} {projekt/a.txt 100 projekt/sub/b.bin 3000} {
    set fh [open $pfad wb]
    puts -nonewline $fh [string repeat x $n]
    close $fh
}
::tclutils::tusize::bytes projekt        ;# -> 3100
::tclutils::tusize::entries projekt
                          ;# -> {100 projekt/a.txt} {3000 projekt/sub}
::tclutils::tusize::human 500            ;# -> 500 B
::tclutils::tusize::human 1536           ;# -> 1.5 KiB
::tclutils::tusize::human 1500 -si 1     ;# -> 1.5 kB
::tclutils::tusize::human 5368709120     ;# -> 5.0 GiB
::tclutils::tusize::human [expr {2**70}] ;# -> 1.0 ZiB
```

An einem echten Baum hängt die Summe vom Inhalt ab; das Ergebnis von
`entries` hat dann dieselbe Form, eine Liste von Paaren aus Zahl und
Pfad.

| Fehler | `-errorcode` |
|---|---|
| Pfad fehlt (`bytes`) | `{TCLUTILS TUSIZE NOTFOUND}` |
| kein Verzeichnis oder fehlt (`entries`) | `{TCLUTILS TUSIZE NOTDIR}` |
| `n` keine ganze Zahl (`human`) | `{TCLUTILS TUSIZE VALUE}` |
| `-si` kein Wahrheitswert | `{TCLUTILS COMMON BOOLEAN -si}` |
| unbekannte Option | `{TCLUTILS COMMON OPTION -name}` |

---

## Metadaten: tustat

[tustat]{.index} liefert die Werte von `file stat` als Dict und formatiert eine
Auswahl davon als Text, ähnlich Unix `stat`.

```tcl
::tclutils::tustat::file   pfad
::tclutils::tustat::files  pfade
::tclutils::tustat::render dict ?-timeformat format?
```

`file` liefert ein Dict mit den Schlüsseln aus `file stat` (`atime`,
`blksize`, `blocks`, `ctime`, `dev`, `gid`, `ino`, `mode`, `mtime`,
`nlink`, `size`, `uid`) und dazu `path` (wie übergeben), `normalized`
(Ergebnis von `file normalize`), `type` (Ergebnis von `file type`:
`file`, `directory`, `link` und so weiter) und `modeOctal` (`mode` in
der gewohnten Oktalform, etwa `100644`). Bei einem Link kommt `target`
hinzu, das Ergebnis von `file readlink`. `files` liefert eine Liste
solcher Dicts in der Reihenfolge der Pfade.

| Option `render` | Vorgabe | Wirkung |
|---|---|---|
| `-timeformat` | `%Y-%m-%d %H:%M:%S` | Format für `clock format`, Ortszeit |

`render` gibt die Felder `path`, `type`, `size`, `mtime`, `mode`,
`ino`, `dev`, `uid` und `gid` in dieser Reihenfolge aus, je Zeile der
Name auf zehn Zeichen und der Wert. Fehlt ein Feld im Dict, fehlt die
Zeile. Andere Felder gibt `render` nicht aus.

Einem Link folgt `file` nicht, wie Unix `stat` ohne `-L`: Größe,
Rechte und Zeiten kommen aus `file lstat` und gehören zum Link selbst.
Ein Link ohne Ziel ist deshalb kein Fehler. `mode` ist eine Dezimalzahl
mit Dateityp und Rechten; `render` gibt sie so aus.

```tcl
package require tclutils::tustat
set d [::tclutils::tustat::file projekt/a.txt]
dict get $d size                          ;# -> 100
dict get $d type                          ;# -> file
dict get $d path                          ;# -> projekt/a.txt
llength [::tclutils::tustat::files {projekt/a.txt projekt}]
                                          ;# -> 2
file link -symbolic projekt/l.txt a.txt
set l [::tclutils::tustat::file projekt/l.txt]
dict get $l type                          ;# -> link
dict get $l target                        ;# -> a.txt
puts [::tclutils::tustat::render $d]
```

Die Ausgabe von `render` hat diese Form; Zeit, Rechte und Nummern
hängen von Datei und Rechner ab:

```text
path       projekt/a.txt
type       file
size       100
mtime      JJJJ-MM-TT hh:mm:ss
mode       Dezimalzahl
ino        Dezimalzahl
dev        Dezimalzahl
uid        Dezimalzahl
gid        Dezimalzahl
```

`file` und `files` haben keine eigenen Fehlercodes; ein fehlender Pfad
wirft `{POSIX ENOENT ...}` aus `file type`.
Eine unbekannte Option an `render` wirft
`{TCLUTILS COMMON OPTION -name}`.

---

## Zeichentabellen: tucode

[tucode]{.index} gibt Tabellen der Zeichen 0 bis 255 aus, ASCII und Latin-1,
dazu ausgewählte Zeichengruppen, und schlägt einzelne Zeichen nach. Das
Unix-Vorbild sind die Handbuchseiten `ascii(7)` und `iso_8859-1(7)`.

```tcl
::tclutils::tucode::lookup     wert
::tclutils::tucode::lookupChar zeichen
::tclutils::tucode::table      von bis ?option wert ...?
::tclutils::tucode::render     von bis ?option wert ...?
::tclutils::tucode::ascii      ?option wert ...?
::tclutils::tucode::latin1     ?option wert ...?
::tclutils::tucode::ansi       ?option wert ...?
::tclutils::tucode::signs      ?gruppe ...? ?option wert ...?
::tclutils::tucode::groups
```

`lookup` nimmt eine Dezimalzahl, Hex mit `0x`, einen Codepunkt mit
`U+` (`U+00E4`, auch klein `u+e4`) oder ein Zeichen aus Latin-1. Bei
mehreren Zeichen gilt das erste. Ein leerer Wert, ein Zeichen über 255
und ein Codepunkt über `U+00FF` sind Fehler. `lookupChar` ist derselbe
Befehl. Rückgabe ist ein Dict:

| Schlüssel | Inhalt |
|---|---|
| `code` | Wert 0–255 |
| `hex`, `oct` | zwei Hex-Stellen groß, drei Oktalstellen |
| `glyph` | Anzeige: `^@` bis `^_` und `^?` für Steuerzeichen, `SP` für das Leerzeichen, `.` für 128–159 und das weiche Trennzeichen |
| `name` | Kurzname: `NUL`, `DEL`, `nbsp`, `ssharp`, `auml`; bei 32–126 das Zeichen selbst |
| `char` | das Zeichen |

`table` und `render` sind derselbe Befehl für den Bereich `von` bis
`bis`, beide aus 0 bis 255. `ascii` ist `0 127`, `latin1` ist
`128 255`, `ansi` ist `latin1`. Die Einträge laufen spaltenweise von
oben nach unten.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-columns` | `4` | Spalten nebeneinander |
| `-showName` | `1` | Kurzname je Eintrag |
| `-compact` | `0` | `1`: Matrix mit 16 Zeichen je Zeile, nur die Anzeige |

In der vollen Tabelle wird jeder Name auf die Länge des längsten
Namens im Bereich aufgefüllt, so stehen die Spalten bündig. Mit vier
Spalten ist sie für ASCII 73 und für Latin-1 85 Zeichen breit.

`signs` gibt Gruppen mit Titel, Linie und einem Eintrag je Zeile aus;
ohne Gruppe alle. `groups` liefert die Namen sortiert. Die Gruppen
`controls`, `whitespace`, `quotes`, `dashes`, `german`, `currency`,
`math` und `latin1hi` enthalten Latin-1-Zeichen; `arrows`, `boxdraw`
und `boxdraw2` enthalten Unicode-Zeichen über 255 und zeigen sie als
`U+XXXX`. `signs` nimmt die Optionen vor oder nach den Gruppen an;
wirksam ist dort `-showName`.

```tcl
package require tclutils::tucode
::tclutils::tucode::lookup 0xDF
```

```text
code 223 hex DF oct 337 glyph ß name ssharp char ß
```

```tcl
dict get [::tclutils::tucode::lookup 65] name       ;# -> A
dict get [::tclutils::tucode::lookup ä] code        ;# -> 228
dict get [::tclutils::tucode::lookup U+00E4] name   ;# -> auml
dict get [::tclutils::tucode::lookup 0] glyph       ;# -> ^@
dict get [::tclutils::tucode::lookup 160] name      ;# -> nbsp
puts [::tclutils::tucode::table 0 7 -columns 2]
puts [::tclutils::tucode::table 64 95 -compact 1]
puts [::tclutils::tucode::signs currency]
puts [::tclutils::tucode::signs dashes -showName 0]
```

```text
Dec Hex  Chr  Name
----------------------------------------
  0 00  ^@   NUL |   4 04  ^D   EOT
  1 01  ^A   SOH |   5 05  ^E   ENQ
  2 02  ^B   STX |   6 06  ^F   ACK
  3 03  ^C   ETX |   7 07  ^G   BEL

    0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
40  @  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O
50  P  Q  R  S  T  U  V  W  X  Y  Z  [  \  ]  ^  _

Currency symbols
----------------------------------------
 36 24  $    $
162 A2  ¢    cent
163 A3  £    pound
164 A4  ¤    curren
165 A5  ¥    yen
Dashes and hyphen
----------------------------------------
 45 2D  -
173 AD  .
```

In der kompakten Form ist jede Zelle drei Zeichen breit; die Ziffern
der Kopfzeile stehen über ihren Spalten.

| Fehler | `-errorcode` |
|---|---|
| Wert außerhalb 0–255, `von` > `bis`, keine ganze Zahl | `{TCLUTILS TUCODE RANGE}` |
| leerer Wert, Zeichen über 255 (`lookup €`), `U+` über `U+00FF` | `{TCLUTILS TUCODE LOOKUP}` |
| unbekannte Gruppe | `{TCLUTILS TUCODE GROUP}` |
| `-columns` keine ganze Zahl ab 1 | `{TCLUTILS COMMON INTEGER -columns}` |
| `-showName`, `-compact` kein Wahrheitswert | `{TCLUTILS COMMON BOOLEAN -name}` |
| unbekannte Option, Option ohne Wert | `{TCLUTILS COMMON OPTION -name}` |

---

## Merkliste

- Daten-Befehle erwarten Bytes 0–255. Text vorher mit
  `encoding convertto utf-8` wandeln; sonst folgt
  `{TCLUTILS <MODUL> BYTES}`.
- `tuhexdump` und `tuod` fassen gleiche Zeilen nicht zusammen.
- `tustrings` trennt am Tabulator.
- `patch` und `writeBytes` legen ohne `-backup 0` bzw. `0` eine Kopie
  `.bak` an, fügen nichts ein und schreiben nicht über das Dateiende.
- `tucmp` zählt den Offset ab 0, nicht ab 1 wie `cmp`.
- `tusize` zählt Dateigrößen, nicht Blöcke; Links mit ihrer eigenen
  Größe.
- `tustat::file` folgt Links nicht; `target` nennt das Ziel.

---

*Nächstes Kapitel: [Notizen und Kalender](054-notizen-und-kalender.md)*
