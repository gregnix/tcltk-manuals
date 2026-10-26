# Zeichen, Zahlen, Datum und Pfade

Vier Module für das, was der Tcl-Kern nur umständlich oder gar nicht
liefert: sichtbare Zeichen ([tustr]{.index}), Beträge ([tunum]{.index}),
Kalenderdaten ([tudate]{.index}) und Pfade ohne Dateisystem
([tupath]{.index}). Alle vier liegen im Umbrella, keines braucht Tk.

---

## tustr

`tustr` ergänzt `string`. Was der Kern kann (`string reverse`,
`string map`, `string repeat`), bleibt beim Kern.

| Befehl | Wirkung |
|---|---|
| `isEmpty s` | 1 bei leerem String |
| `truncate s n ?ende?` | kürzt auf `n` Zeichen; Vorgabe für `ende` ist `...`, die Zeichen zählen mit |
| `padLeft`, `padRight`, `center` | füllen auf eine Breite; Vorgabezeichen ist das Leerzeichen |
| `startsWith`, `endsWith` | 1, wenn der Rand passt |
| `removePrefix`, `removeSuffix` | schneiden den Rand ab, sonst unverändert |
| `splitTrim s ?sep?` | trennt, entfernt Leerzeichen, wirft leere Stücke weg; Vorgabe für `sep` ist das Leerzeichen |
| `toCamel`, `toSnake` | `my-cool_var` wird `myCoolVar`, `myCoolVar` wird `my_cool_var` |
| `slugify s` | Kleinbuchstaben, alles außer `a`–`z` und Ziffern wird zu `-` |
| `capitalize s` | erster Buchstabe groß |
| `count s teil` | nicht überlappende Treffer |
| `graphemes s` | Liste der sichtbaren Zeichen |
| `isPrintable zeichen` | 1, wenn genau ein druckbares Zeichen vorliegt |

`truncate`, `padLeft`, `padRight` und `center` rechnen mit
`string length`, nicht mit `graphemes`. Eine negative Breite oder Länge
ergibt `{TCLUTILS TUSTR ARG}`.

```tcl
package require tclutils::tustr
::tclutils::tustr::truncate HalloWelt 6          ;# -> Hal...
::tclutils::tustr::toCamel my-cool_var           ;# -> myCoolVar
::tclutils::tustr::toSnake myCoolVar             ;# -> my_cool_var
::tclutils::tustr::splitTrim { a , , b } ,       ;# -> a b
::tclutils::tustr::count ababa ba                ;# -> 2
::tclutils::tustr::slugify "Hallo, Welt!"        ;# -> hallo-welt
::tclutils::tustr::slugify "Größe"               ;# -> gr-e
```

`slugify` überträgt Umlaute nicht (`ö` wird nicht `oe`). „Größe“ verliert
`ö` und `ß`, übrig bleibt `gr-e`.

### Sichtbare Zeichen

`graphemes` zerlegt einen String in sichtbare Zeichen, ein vereinfachtes
UAX #29. Basiszeichen mit kombinierenden Akzenten, Emoji-ZWJ-Folgen,
Flaggenpaare und CR LF bleiben zusammen. Hangul-Silben und indische
Konjunkte deckt es nicht ab. `[join [graphemes $s] ""]` ergibt wieder `$s`.

`isPrintable` prüft genau ein Zeichen nach Unicode, nicht nur ASCII:
0 für C0/C1-Steuerzeichen und DEL, 1 für U+00A0. Ein leerer String oder
mehr als ein Zeichen wirft `{TCLUTILS TUSTR ARG}` mit
`isPrintable expects exactly one character`. Ersatzpaare, die Tcl 8.6 aus
einem Kanal liefert, zählen bei beiden Befehlen als ein Zeichen.

```tcl
llength [::tclutils::tustr::graphemes "e\u0301x"]   ;# -> 2
string length "e\u0301x"                           ;# -> 3
::tclutils::tustr::isPrintable \u00e4               ;# -> 1
::tclutils::tustr::isPrintable \x07                 ;# -> 0
```

---

## tupath

`tupath` liegt um `file`. `clean` und `relative` fragen das Dateisystem
nicht; `normalize` und `readlink` tun es.

| Befehl | Wirkung |
|---|---|
| `normalize pfad` | absolut, löst `.`, `..` und symbolische Links (`file normalize`) |
| `clean pfad` | `.`, `..` und `//` nur lexikalisch; ein leerer Pfad wird `.` |
| `isAbsolute pfad` | 1 oder 0 |
| `components pfad` | `file split` |
| `join teile…` | `file join` |
| `relative basis ziel` | Weg von der Basis zum Ziel, beide absolut oder beide relativ |
| `commonPath liste` | längstes gemeinsames Verzeichnis, sonst `""` |
| `readlink pfad` | Ziel eines symbolischen Links |

```tcl
package require tclutils::tupath
::tclutils::tupath::clean a/./b/../c             ;# -> a/c
::tclutils::tupath::clean /a/../../b             ;# -> /b
::tclutils::tupath::clean ""                     ;# -> .
::tclutils::tupath::commonPath {/a/b/c /a/b/d}   ;# -> /a/b
::tclutils::tupath::relative /a/b /a/b/c/d       ;# -> c/d
::tclutils::tupath::relative /a/b /a/b           ;# -> .
```

Seit tclutils 0.64.0 behält ein absoluter Pfad seine Wurzel: `..` endet
dort. Unter Windows gilt das laut Code auch für `C:/`, `/`
(laufwerksrelativ) und `//server/share`. Die Modulversion blieb 0.1.

`relative` mit einem relativen und einem absoluten Pfad wirft
`{TCLUTILS TUPATH RELATIVE}`. `commonPath` ohne Pfad wirft
`{TCLUTILS TUPATH ARGS}`. `readlink` auf einer gewöhnlichen Datei wirft
`{TCLUTILS TUPATH NOTLINK}`. Teilen sich die Pfade kein erstes Stück,
liefert `commonPath` `""`.

---

## tudate

`tudate` rechnet in der lokalen Zeitzone, auf `clock`.

| Befehl | Wirkung |
|---|---|
| `parse text ?-format fmt?` | Sekunden seit der Epoche; ohne `-format` ISO, `d.m.Y`, `d/m/Y`, `Y/m/d`, danach ein freier Versuch |
| `iso sekunden ?-time 0?` | `yyyy-mm-dd`, mit `-time 1` zusätzlich `THH:MM:SS` |
| `add sekunden zahl einheit` | Kalenderaddition; Einheit `second`, `minute`, `hour`, `day`, `week`, `month`, `year`, auch im Plural |
| `diff a b ?-unit days?` | `a` minus `b`, ganzzahlig; Einheiten `seconds`, `minutes`, `hours`, `days`, `weeks` |
| `relative sekunden ?-base sek?` | englische Tagesformel; ohne `-base` ist die Basis jetzt |
| `today` | heutiges Datum als ISO-Text |
| `zones` | sortierte Namen für `clock format -timezone` |

```tcl
package require tclutils::tudate
set t [::tclutils::tudate::parse 15.03.2024]
::tclutils::tudate::iso $t                              ;# -> 2024-03-15
::tclutils::tudate::iso [::tclutils::tudate::add $t 1 month]
                                                        ;# -> 2024-04-15
::tclutils::tudate::relative $t -base $t                ;# -> today
::tclutils::tudate::relative [::tclutils::tudate::add $t 3 day] -base $t
                                                        ;# -> in 3 days
expr {"Europe/Berlin" in [::tclutils::tudate::zones]}   ;# -> 1
```

`relative` antwortet englisch: `today`, `tomorrow`, `yesterday`,
`in N days`, `N days ago`. Ein unlesbares Datum ergibt
`{TCLUTILS TUDATE PARSE}`, eine unbekannte Einheit
`{TCLUTILS TUDATE UNIT}`.

`diff -unit days` teilt die Sekunden durch 86400 und schneidet ab. Es
zählt keine Kalendertage. Vom 15. März 2024 zum 15. April 2024 liefert
es 30, nicht 31: in der lokalen Zone (CEST, `TZ` nicht gesetzt) fehlt
durch die Sommerzeit eine Stunde. `add` selbst geht über `clock add`
und landet auf dem 15. April.

`zones` liest die erste Quelle, die Einträge hat: Tcls tzdata, sonst
`/usr/share/zoneinfo`. Namen aus dem Systemverzeichnis prüft es mit
`clock`, weil Tcl 8.6 ohne eigene tzdata Namen wie `Etc/GMT+1` ablehnt.
`UTC` ist immer dabei. Die Liste mischt die beiden Quellen nicht.

---

## tunum

`tunum` liest Beträge, wie sie in Tabellen stehen, und schreibt sie
deutsch. `tunumfmt` ist ein anderes Modul: das liest Größen wie `1.5K`,
`2Mi` und `2KiB`.

| Befehl | Wirkung |
|---|---|
| `parse text ?-default {}? ?-locale auto?` | Tcl-Double, oder `-default`, wenn nichts erkennbar ist |
| `sum werte ?-default 0?` | Summe, unlesbare Einträge fallen weg; immer Locale `auto` |
| `isNumber text` | 1, wenn `parse` mit `auto` einen Wert findet |
| `format zahl ?-locale de? ?-decimals 2?` | Tausenderpunkt, Dezimalkomma |

Locale `auto` (Vorgabe von `parse`): ein Komma mit Ziffern am Ende ist
das Dezimalkomma, Punkte sind Tausender. Sonst ist der Punkt dezimal und
die Kommas sind Tausender. `€`, `$`, `£`, `¥` und Leerzeichen fallen weg.

Locale `de-strict`: der Punkt ist immer ein Tausender und fällt weg, das
Komma ist dezimal, Währungszeichen bleiben stehen. `956.06` wird damit
`95606.0`. Wer den Punkt als Dezimalzeichen meint, nimmt `auto`.

```tcl
package require tclutils::tunum
::tclutils::tunum::parse "1.234,56"                 ;# -> 1234.56
::tclutils::tunum::parse "1,234.56"                 ;# -> 1234.56
::tclutils::tunum::parse "12 \u20AC"                ;# -> 12.0
::tclutils::tunum::parse "abc"                      ;# -> (leer)
::tclutils::tunum::sum {1,50 2,00 abc 4,20}         ;# -> 7.7
::tclutils::tunum::parse 956.06 -locale de-strict   ;# -> 95606.0
::tclutils::tunum::format 1234.5                    ;# -> 1.234,50
::tclutils::tunum::format 1234.5 -decimals 0        ;# -> 1.235
::tclutils::tunum::format 2.675                     ;# -> 2,68
::tclutils::tunum::format -2.5 -decimals 0          ;# -> -3
format %.2f 2.675                                   ;# -> 2.67
```

`format` rundet seit Modul 0.4 auf den Dezimalziffern halb von null weg,
auf jeder Plattform gleich. Bis tclutils 0.63.0 lief das über
`format %.*f`, und dort entschied die C-Laufzeit. Das abweichende
Verhalten der Windows-Laufzeit vor 0.4 steht im CHANGELOG. Eine Währung
hängt der Aufrufer selbst an:
`"[::tclutils::tunum::format $n] EUR"`.

Die Prozedur heißt `format` und liegt im Namensraum `tclutils::tunum`.
Der Aufruf bleibt `::tclutils::tunum::format`, dann verdeckt sie Tcls
`format` nicht. `-decimals` unter 0 ergibt `{TCLUTILS TUNUM DECIMALS}`,
eine andere Locale als `de` ergibt `{TCLUTILS TUNUM LOCALE}`.
`parse -locale` kennt `auto` und `de-strict`.

---

## Merkliste

- Sichtbare Länge: `tustr::graphemes`, nicht `string length`.
- `slugify` behält nur ASCII.
- `tupath::clean` und `relative` lesen keine Datei; `..` endet an der Wurzel.
- `tudate::diff -unit days` teilt Sekunden; `relative` antwortet englisch.
- Beträge: `tunum::format`. `de-strict` behandelt jeden Punkt als Tausender.
- Bundesweite Feiertage: Kapitel [Notizen und Kalender](054-notizen-und-kalender.md).

---

*Nächstes Kapitel: [Datenformate](050-datenformate.md)*
