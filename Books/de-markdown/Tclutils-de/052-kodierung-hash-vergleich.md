# Kodierung, Hash und Vergleich

Base64 und Base32, CRC, die Digests und xxHash32, der Wechsel der
Kodierung, UUIDs, Query-Strings, verschachtelte Dicts, ein
Zeilenvergleich und das Anwenden eines Diffs. Alles liegt im Umbrella. CRC nutzt `zlib` aus
Tcl selbst, die Digests sind reines Tcl und brauchen kein tcllib.

---

## Base64: tubase64

`encode` und `decode` gehen über `binary encode`/`decode base64`.
`encodeFile` liest die Datei binär, `decodeFile` den Text.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-maxlen` | `0` | Zeilenumbruch nach so vielen Zeichen; `0` lässt die Zeile ganz |
| `-encoding` | `binary` | `encode`: `binary` nimmt jedes Zeichen als ein Byte, `utf-8` wandelt Text zuerst; `decode`: `utf-8` macht aus den Bytes wieder Text |

```tcl
package require tclutils::tubase64
::tclutils::tubase64::encode hallo          ;# -> aGFsbG8=
::tclutils::tubase64::decode aGFsbG8=       ;# -> hallo
::tclutils::tubase64::encode hallohallo -maxlen 4
                                          ;# -> aGFs\nbG9o\nYWxs\nbw==
```

`-maxlen -1` wirft `{TCLUTILS TUBASE64 MAXLEN}`. Ein Text ohne gültiges
Base64, etwa `!!!`, kommt als leere Zeichenkette zurück, ohne
Fehlercode.

`encode` nimmt ohne Option Bytes. Ein Zeichen über 255 wirft unter
Tcl 8.6 wie unter 9.0 `{TCLUTILS TUBASE64 BYTES}`; bis tclutils 0.68.0
behielt Tcl 8.6 still nur das untere Byte. Text gehört mit
`-encoding utf-8` hinein:

```tcl
::tclutils::tubase64::encode "Jörg €" -encoding utf-8   ;# -> SsO2cmcg4oKs
::tclutils::tubase64::decode SsO2cmcg4oKs -encoding utf-8 ;# -> Jörg €
::tclutils::tubase64::encode Jörg                        ;# -> SvZyZw==
```

Das letzte Beispiel kodiert `ö` als ein Byte `f6`. `tuhash` und
`tuxxhash` wandeln Text dagegen von sich aus nach UTF-8; sie werden
meist auf Text angewandt, `tubase64`, `tubase32` und `tucrc` meist auf
Datei- und Bilddaten.

---

## Base32: tubase32

[tubase32]{.index} kodiert nach RFC 4648, wahlweise mit dem Alphabet
base32hex. Tcl selbst bringt nur Base64 mit; die Umsetzung ist reines
Tcl. `encodeFile` liest die Datei binär, `decodeFile` den Text.

| Befehl | Wirkung |
|---|---|
| `encode daten ?-pad b? ?-hex b?` | Base32-Text in Großbuchstaben |
| `decode text ?-hex b?` | die Bytes |
| `encodeFile pfad ?-pad b? ?-hex b?` | die Bytes der Datei kodiert |
| `decodeFile pfad ?-hex b?` | den Text der Datei dekodiert |

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-pad` | `1` | füllt mit `=` auf eine volle Gruppe von acht Zeichen; `0` lässt es weg |
| `-hex` | `0` | `1` nimmt das Alphabet `0`–`9`, `A`–`V` (base32hex, RFC 4648 §7) |

`decode` übergeht `=`, Leerzeichen, Tabulator und Zeilenumbruch und
nimmt Klein- wie Großbuchstaben. Das Ende prüft `decode` wie RFC 4648
§3.5: Die Zahl der Zeichen muss eine sein, die `encode` erzeugt (ein
Vielfaches von 8 plus 0, 2, 4, 5 oder 7), und die Bits nach dem letzten
ganzen Byte müssen 0 sein. `decode MY` ergibt `f`, `decode MZ` ist ein
Fehler.

```tcl
package require tclutils::tubase32
::tclutils::tubase32::encode foobar        ;# -> MZXW6YTBOI======
::tclutils::tubase32::encode foobar -pad 0 ;# -> MZXW6YTBOI
::tclutils::tubase32::encode foobar -hex 1 ;# -> CPNMUOJ1E8======
::tclutils::tubase32::decode mzxw6ytboi    ;# -> foobar
::tclutils::tubase32::encode [encoding convertto utf-8 Größe]
                                          ;# -> I5ZMHNWDT5SQ====
::tclutils::tubase32::decode MY            ;# -> f
catch {::tclutils::tubase32::decode MZ} m o
dict get $o -errorcode                     ;# -> TCLUTILS TUBASE32 BITS
```

Die Eingabe von `encode` sind Bytes. Ein Zeichen über 255 wirft unter
Tcl 9.0 `{TCL VALUE BYTES}`; unter Tcl 8.6 bleibt still nur das untere
Byte. Text gehört deshalb vorher durch `encoding convertto utf-8`.

Anders als `tubase64` liefert `tubase32` bei ungültigem Text keine
leere Zeichenkette, sondern einen Fehler. Ein Zeichen außerhalb des
Alphabets wirft `{TCLUTILS TUBASE32 CHAR}`, etwa
`invalid base32 character: "1"`. Eine unmögliche Länge wie `MZX` wirft
`{TCLUTILS TUBASE32 LENGTH}`, Bits ungleich 0 am Ende wie bei `MZ`
`{TCLUTILS TUBASE32 BITS}`. Ein ungültiges Wahrheitswort an
`-pad` oder `-hex` wirft `{TCLUTILS COMMON BOOLEAN -pad}` bzw. `-hex`.

---

## CRC: tucrc

`crc32` und `adler32` reichen die Bytes an `zlib` weiter. Ein zweites
Argument ist der Startwert für eine fortgesetzte Summe. Danach darf
`-encoding binary|utf-8` stehen, wie bei `tubase64`: ohne Option ist
ein Zeichen über 255 `{TCLUTILS TUCRC BYTES}`, mit `utf-8` gleicht die
Summe der von `crc32File` einer UTF-8-Datei mit diesem Text. `hex32` macht
daraus acht Hex-Zeichen in Großbuchstaben. `crc32File` und
`adler32File` lesen die Datei binär.

```tcl
package require tclutils::tucrc
::tclutils::tucrc::crc32 hallo              ;# -> 3111268817
::tclutils::tucrc::hex32 [::tclutils::tucrc::crc32 hallo]
                                          ;# -> B97231D1
::tclutils::tucrc::adler32 hallo            ;# -> 102498833
```

Ein falsches Argument meldet `wrong # args` mit
`{TCLUTILS TUCRC OPTION}`, eine unbekannte Kodierung
`{TCLUTILS TUCRC ENCODING}`.

---

## Digests: tuhash

`sha256`, `sha1` und `md5` sind eigene Umsetzungen von FIPS 180-4 und
RFC 1321. Die Dateibefehle hashen die Bytes der Datei. Am Text hängt
`-encoding`:

| Wert | Wirkung |
|---|---|
| `utf-8` | Vorgabe; der Text wird zuerst nach UTF-8 gewandelt |
| `binary` | jedes Zeichen ist ein Byte 0–255 |

```tcl
package require tclutils::tuhash
::tclutils::tuhash::sha256 ""               ;# -> e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
::tclutils::tuhash::sha256 abc              ;# -> ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
::tclutils::tuhash::md5 ""                  ;# -> d41d8cd98f00b204e9800998ecf8427e
::tclutils::tuhash::sha1 ""                 ;# -> da39a3ee5e6b4b0d3255bfef95601890afd80709
```

Eine andere Kodierung wirft `{TCLUTILS TUHASH ENCODING}`. Dieselben
leeren Digests sind die Prüfvektoren der Normen.

---

## xxHash32: tuxxhash

[tuxxhash]{.index} rechnet XXH32, einen schnellen Hash ohne kryptographischen
Anspruch, in reinem Tcl. Er dient zum Erkennen von Änderungen und zum
Vorsortieren möglicher Duplikate, nicht zum Schutz gegen Fälschung.
Varianten mit 64 oder 128 Bit gibt es nicht.

| Befehl | Wirkung |
|---|---|
| `xxh32 daten ?seed? ?-encoding e?` | acht Hex-Zeichen in Kleinbuchstaben |
| `xxh32file pfad ?seed?` | dasselbe für die Bytes der ganzen Datei |

`seed` ist eine ganze Zahl, Vorgabe `0`. Davon zählen die unteren
32 Bit. Wie bei `tuhash` hängt am Text `-encoding`; es steht nach
`seed`:

| Wert | Wirkung |
|---|---|
| `utf-8` | Vorgabe; der Text wird zuerst nach UTF-8 gewandelt |
| `binary` | jedes Zeichen ist ein Byte 0–255 |

```tcl
package require tclutils::tuxxhash
::tclutils::tuxxhash::xxh32 ""              ;# -> 02cc5d05
::tclutils::tuxxhash::xxh32 hello           ;# -> fb0077f9
::tclutils::tuxxhash::xxh32 hello 1         ;# -> fcfffba9
::tclutils::tuxxhash::xxh32 Größe           ;# -> 3a44ca22
set b [encoding convertto utf-8 Größe]
::tclutils::tuxxhash::xxh32 $b 0 -encoding binary
                                          ;# -> 3a44ca22
```

`xxh32 Größe` hasht die sieben UTF-8-Bytes und stimmt mit `xxh32file`
einer UTF-8-Datei mit diesem Text überein. Ein Zeichen über 255 wie
`€` geht ebenso. `-encoding binary` nimmt die Zeichen als Bytes, etwa
für Daten aus `binary format` oder einem Kanal mit
`-translation binary`.

Ein `seed`, der keine ganze Zahl ist, wirft `{TCLUTILS TUXXHASH SEED}`.
Ein anderer Wert an `-encoding` wirft `{TCLUTILS TUXXHASH ENCODING}`,
ein Zeichen über 255 bei `-encoding binary`
`{TCLUTILS TUXXHASH BYTES}`, ein anderes Argument als `-encoding`
`{TCLUTILS TUXXHASH OPTION}`.
Eine Datei, die sich nicht öffnen lässt, wirft
`{TCLUTILS TUXXHASH IO}`. Mit 32 Bit treten in großen Beständen
zufällige Kollisionen auf; gleiche Werte sind nur Kandidaten für einen
Vergleich der Bytes oder mit `sha256`.

---

## Kodierung wechseln: tuiconv

[tuiconv]{.index} wandelt zwischen den Kodierungen, die Tcl kennt, und liest
und schreibt Dateien mit ausdrücklicher Kodierung. Die Kanäle sind
dabei binär; die Umwandlung geschieht mit `encoding convertfrom` und
`encoding convertto`.

| Befehl | Wirkung |
|---|---|
| `encodings` | die Namen aus `encoding names`, sortiert |
| `convert bytes von nach ?-replace b?` | Bytes in `von` zu Bytes in `nach` |
| `readFile pfad kodierung ?-replace b?` | der Text der Datei |
| `writeFile pfad text kodierung ?-replace b?` | schreibt die Datei, gibt `pfad` zurück |
| `convertFile ein aus von nach ?-replace b?` | liest `ein`, schreibt `aus`, gibt `aus` zurück |

Ein Name muss genau in `encoding names` stehen, etwa `utf-8`,
`iso8859-1` oder `cp1252`. Schreibweisen wie `utf8` oder `latin1`
werfen `{TCLUTILS TUICONV ENCODING name}` mit
`unknown encoding "utf8"`. Die Liste ist unter Tcl 9.0 länger als
unter 8.6.

```tcl
package require tclutils::tuiconv
set utf8 [encoding convertto utf-8 Größe]
set cp [::tclutils::tuiconv::convert $utf8 utf-8 cp1252]
binary encode hex $cp                       ;# -> 4772f6df65
set zurueck [::tclutils::tuiconv::convert $cp cp1252 utf-8]
encoding convertfrom utf-8 $zurueck         ;# -> Größe
```

Seit 0.2 ist die Umwandlung unter Tcl 8.6 und 9.0 gleich streng. Ein
Zeichen, das die Zielkodierung nicht kennt, etwa `ł` nach `cp1252`,
wirft `{TCLUTILS TUICONV UNMAPPABLE cp1252}`; Bytes, die in der
Quellkodierung ungültig sind, werfen `{TCLUTILS TUICONV INVALID name}`.
`-replace 1` an allen Befehlen ersetzt stattdessen, beim Schreiben
durch `?`. `writeFile` wandelt vor dem Öffnen um: Bei einem Fehler
behält die Datei ihren Inhalt. Bis 0.1 setzte Tcl 8.6 still `?` ein,
Tcl 9.0 warf einen Tcl-Fehler ohne eigenen Code.

```tcl
catch {::tclutils::tuiconv::convert [encoding convertto utf-8 ł] utf-8 cp1252} m
set m             ;# -> character U+0142 at index 0 cannot be written in cp1252
binary encode hex [::tclutils::tuiconv::convert \
    [encoding convertto utf-8 ł] utf-8 cp1252 -replace 1]
                                          ;# -> 3f
```

---

## UUID: tuuuid

`v4` ist zufällig, `v7` trägt die Unix-Zeit in Millisekunden in den
ersten 48 Bit und danach Zufall (RFC 9562). `generate` nimmt
`-version` `4` oder `7`, Vorgabe `4`. `nil` ist die Null-UUID.
`validate` prüft die Form `8-4-4-4-12`, Groß- und Kleinschreibung.
`version` liest die Ziffer an Stelle 14.

```tcl
package require tclutils::tuuuid
::tclutils::tuuuid::nil                     ;# -> 00000000-0000-0000-0000-000000000000
::tclutils::tuuuid::validate [::tclutils::tuuuid::nil]
                                          ;# -> 1
::tclutils::tuuuid::version [::tclutils::tuuuid::nil]
                                          ;# -> 0
::tclutils::tuuuid::version [::tclutils::tuuuid::v4]
                                          ;# -> 4
::tclutils::tuuuid::version [::tclutils::tuuuid::v7]
                                          ;# -> 7
```

`version nein` wirft `{TCLUTILS TUUUID INVALID}`. `generate -version 9`
wirft `{TCLUTILS TUUUID VERSION}`. Die Zufallsbytes kommen von
`/dev/urandom`, sonst von `rand()`.

---

## Query-Strings: tuurl

Nicht reserviert bleiben Buchstaben, Ziffern und `-._~`. Alles andere
wird über die UTF-8-Bytes mit `%` kodiert.

| Befehl | `-plus` | Wirkung |
|---|---|---|
| `encode`, `decode` | `0` | Leerzeichen wird `%20`; `+` bleibt `+` |
| `buildQuery`, `parseQuery` | `1` | Leerzeichen wird `+`, und `+` wird beim Lesen wieder zum Leerzeichen |

```tcl
package require tclutils::tuurl
::tclutils::tuurl::encode "a b"             ;# -> a%20b
::tclutils::tuurl::encode "a b" -plus 1     ;# -> a+b
::tclutils::tuurl::encode Größe             ;# -> Gr%C3%B6%C3%9Fe
::tclutils::tuurl::decode %C3%BC            ;# -> ü
::tclutils::tuurl::buildQuery {ort {Nord Lager} gang 3}
                                          ;# -> ort=Nord+Lager&gang=3
::tclutils::tuurl::parseQuery {ort=Nord+Lager&gang=3}
                                          ;# -> ort {Nord Lager} gang 3
```

Ein Schlüssel ohne `=` bekommt den leeren Wert. Steht ein Schlüssel
mehrmals in der Query (`a=1&a=2`, etwa bei Checkboxen), behält
`parseQuery` nur den letzten Wert; wer alle braucht, teilt die Query
selbst am `&`. Ein ungültiges
Wahrheitswort an `-plus` wirft `{TCLUTILS COMMON BOOLEAN -plus}`.

---

## Verschachtelte Dicts: tudict

Der Kern kann `dict get $d a b` schon. [tudict]{.index} ergänzt den Weg mit
Vorgabe, die Blattpfade, eine flache Form, das tiefe Mischen und das
Umdrehen.

| Befehl | Wirkung |
|---|---|
| `getOr dict vorgabe schlüssel …` | Wert oder die Vorgabe, wenn ein Schlüssel fehlt |
| `paths dict` | Blattpfade, jeder Pfad eine Liste von Schlüsseln |
| `flatten dict ?sep?` | ein flaches Dict, Schlüssel mit `.` verbunden |
| `mergeDeep dict …` | von links nach rechts; verschachtelte Dicts mischen, Skalare überschreiben |
| `invert dict` | Schlüssel und Wert tauschen; bei doppeltem Wert bleibt der letzte |

Die Vorgabe steht vor dem Pfad.

```tcl
package require tclutils::tudict
::tclutils::tudict::getOr {ui {theme dark}} - ui theme
                                          ;# -> dark
::tclutils::tudict::getOr {ui {theme dark}} - ui fehlt
                                          ;# -> -
::tclutils::tudict::paths {a {b {c 1}} d 2}
                                          ;# -> {a b c} d
::tclutils::tudict::flatten {a {b {c 1}} d 2}
                                          ;# -> a.b.c 1 d 2
::tclutils::tudict::invert {a 1 b 2}        ;# -> 1 a 2 b
::tclutils::tudict::invert {a 1 b 1}        ;# -> 1 b
```

Ohne Schlüssel wirft `getOr` `{TCLUTILS TUDICT ARG}`. Ein Wert, der wie
ein Dict aussieht, wird eins: `flatten` von `{name {a b}}` ergibt
`name.a b`, weil `a b` gerade Länge hat. `mergeDeep` steht mit einem
Beispiel im Anhang [Praxis](850-praxis-und-fehlerfaelle.md).

---

## Zeilenvergleich: tudiff

`text` liefert eine Liste von `equal`, `delete` und `insert`, jeweils
mit der Zeile. `unifiedText` setzt daraus einen einheitlichen Diff,
`contextText` die Kontextform. `files`, `unified` und `context` lesen
zwei Dateien. `directory` vergleicht zwei Bäume.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-maxcells` | `2000000` | Obergrenze für die Tabelle, Zeilen alt mal Zeilen neu |
| `-fromlabel`, `-tolabel` | `old`, `new` | Kopfzeilen von `unifiedText` und `contextText` |

```tcl
package require tclutils::tudiff
::tclutils::tudiff::text "a\nb" "a\nc"      ;# -> {equal a} {delete b} {insert c}
::tclutils::tudiff::unifiedText "a\nb" "a\nc"
                                          ;# -> --- old\n+++ new\n@@ -1,2 +1,2 @@\n a\n-b\n+c
```

`-maxcells 0` wirft `{TCLUTILS TUDIFF OPTION MAXCELLS}`. Zwei Texte mit
je zwei Zeilen und `-maxcells 1` werfen `{TCLUTILS TUDIFF TOO_LARGE}`,
weil 2 × 2 die Grenze übersteigt.

Zeilenenden zählen nach Vorgabe nicht mit: CRLF, CR und LF sind gleich,
ein fehlendes letztes Newline auch (`-eol ignore`). `-eol strict` (seit
0.2) vergleicht jede Zeile mit ihrem Ende. Die Operationen tragen dann
das Ende mit, und `unifiedText` markiert ein fehlendes Newline wie GNU
diff. `files`, `unified` und `context` nehmen dazu `-encoding`.

```tcl
::tclutils::tudiff::text "a\r\nb" "a\nb\n"              ;# -> {equal a} {equal b}
::tclutils::tudiff::unifiedText "a\nb\n" "a\nb" -eol strict
;# -> --- old\n+++ new\n@@ -1,2 +1,2 @@\n a\n-b\n+b\n\\ No newline at end of file
```

---

## Diff anwenden: tupatch

[tupatch]{.index} ist das Gegenstück zu `tudiff`: es wendet einen einheitlichen
Diff auf einen Text an. Das kann die Ausgabe von `unifiedText` sein,
aber auch `diff -u` oder `git diff` mit mehreren Abschnitten.

| Befehl | Wirkung |
|---|---|
| `text quelle patch ?optionen?` | der geänderte Text |
| `fromFile pfad patch ?optionen?` | wie `text`, die Quelle aus der Datei |
| `parse patch` | Liste der Abschnitte als Dicts |

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-reverse` | `0` | `1` wendet den Diff rückwärts an und nimmt ihn so zurück |
| `-strict` | `1` | prüft Kontext- und Löschzeilen gegen die Quelle; `0` folgt blind dem Diff |

Ein Abschnitt aus `parse` hat `oldStart`, `oldLen`, `newStart`,
`newLen`, `body`, `oldNoNl` und `newNoNl`. `body` ist eine Liste von
Paaren aus Art (` `, `+`, `-`) und Zeile. Kopfzeilen wie `---`, `+++`,
`diff` und `index` fallen weg. `oldNoNl` und `newNoNl` sind 1, wenn
`\ No newline at end of file` hinter der letzten alten bzw. neuen Zeile
steht. Eine leere Zeile beendet einen Abschnitt.

Jeder Abschnitt gilt an der Zeile aus seinem Kopf. Eine Verschiebung
sucht `tupatch` nicht. Die Zeilen werden mit `\n` verbunden. Endet die
Quelle auf `\n`, endet auch das Ergebnis darauf; die Markierung
`\ No newline at end of file` wirkt wie bei `diff -u` (seit 0.3; bis 0.2
fehlte das letzte `\n` im Ergebnis immer). Ohne Abschnitt im
Diff kommt die Quelle unverändert zurück.

```tcl
package require tclutils::tudiff
package require tclutils::tupatch
set alt "alpha\nbeta\ngamma"
set neu "alpha\nBETA\ngamma"
set p [::tclutils::tudiff::unifiedText $alt $neu]
::tclutils::tupatch::text $alt $p           ;# -> alpha\nBETA\ngamma
::tclutils::tupatch::text $neu $p -reverse 1
                                          ;# -> alpha\nbeta\ngamma
llength [::tclutils::tupatch::parse $p]     ;# -> 1
```

Passt eine Zeile nicht, wirft `text` `{TCLUTILS TUPATCH CONTEXT}`,
etwa bei der Quelle `alpha\nbeta\nGAMMA`:
`patch does not apply: expected "gamma" but found "GAMMA" at source
line 3`. Ein Abschnitt hinter dem Ende der Quelle oder einer, der einen
früheren überlappt, wirft `{TCLUTILS TUPATCH RANGE}`. Eine unbekannte
Option wirft `{TCLUTILS COMMON OPTION -name}`. `-reverse` und `-strict`
nehmen jeden Wahrheitswert (`1`, `yes`, `true`, `on` und die
Gegenstücke); `-strict foo` wirft `{TCLUTILS COMMON BOOLEAN -strict}`.

---

## Merkliste

- Base64 ohne Zeilenumbruch: `-maxlen 0`. Ungültiger Text wird leer.
- Digests von Text sind UTF-8. Dateien hashen die Bytes.
- `tuurl`: am einzelnen Wert ist `-plus` aus, an der Query an.
- `getOr`: erst das Dict, dann die Vorgabe, dann die Schlüssel.
- `tudiff` hält die ganze Vergleichstabelle im Speicher.
- Base32: `tubase32`, Eingabe sind Bytes; `-hex 1` für base32hex. Ungültiger Text wirft einen Fehler.
- `xxh32` hasht Text als UTF-8 wie `tuhash`; `-encoding binary` für Bytes.
- `tuiconv` kennt nur die Namen aus `encoding names`. Nicht darstellbare Zeichen und ungültige Bytes sind ein Fehler; `-replace 1` ersetzt.
- `tupatch` wendet ohne Verschiebung an. `-reverse 1` nimmt den Diff zurück.

---

*Nächstes Kapitel: [Binärdaten und Dateiinformationen](053-binaerdaten-und-dateiinfo.md)*
