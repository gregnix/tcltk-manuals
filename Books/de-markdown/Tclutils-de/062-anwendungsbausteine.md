# Bausteine für Anwendungen

Siebzehn kleine Module, die eine Anwendung um ihre eigentliche Aufgabe
herum braucht: Protokoll und Ereignisse, Prüfen und Rechnen, Umgebung
und Auslieferung, Ausgabe im Terminal und auf der Seite. Alle sind
reines Tcl ohne Tk und liegen im Umbrella `tclutils`. Plattformabhängig
sind `tuappinfo`, `tusysinfo`, `tudeploy`, `tuexe`, `tuopen` und `tuterm`; `tuzipfs`
braucht für die meisten Befehle Tcl 9.

| Gruppe | Module |
|---|---|
| Protokoll und Ereignisse | `tulog`, `tuevent`, `turegistry` |
| Prüfen und Rechnen | `tuvalidate`, `tulist`, `tumath`, `tunumany` |
| Umgebung und Auslieferung | `tuappinfo`, `tusysinfo`, `tuedid`, `tudeploy`, `tuexe`, `tuopen`, `tuzipfs` |
| Ausgabe | `tuterm`, `tupagespec`, `tulayout` |

Unbekannte Optionen und Optionen ohne Wert melden die Module
unterschiedlich: über `::tclutils::common::parseOptions` mit
`{TCLUTILS COMMON OPTION <opt>}` oder mit einem eigenen Code. Die
Abschnitte nennen den Code jeweils.

---

## tulog

[tulog]{.index} ist ein Protokoll mit vier Stufen. Ein Logger ist ein Befehl;
die Stufen `info` und `error` sind Unterbefehle und verdecken daher
keine Tcl-Befehle.

```tcl
::tclutils::tulog::new ?option wert ...?        ;# -> Logger-Befehl
$log debug|info|warn|error nachricht
$log log stufe nachricht
$log setLevel stufe
$log level
$log destroy
::tclutils::tulog::assert ausdruck ?nachricht?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-channel` | `stderr` | Kanal für die Ausgabe |
| `-level` | `info` | niedrigste Stufe, die ausgegeben wird |
| `-name` | `""` | Name hinter der Stufe |
| `-timestamp` | `1` | Zeitstempel `%Y-%m-%dT%H:%M:%S`, lokale Zeit |

Die Stufen steigen in der Reihenfolge `debug`, `info`, `warn`, `error`.
Eine Nachricht erscheint, wenn ihre Stufe mindestens die des Loggers
ist. Jede Zeile hat die Form `ZEIT [STUFE] name: nachricht`; ohne
Zeitstempel fällt `ZEIT ` weg, ohne Namen steht `[STUFE]: nachricht`.
Nach jeder Zeile wird der Kanal geleert.

`new` liefert den Befehlsnamen `::tclutils::tulog::logger<n>`. Die
Unterbefehle zum Schreiben, `setLevel` und `destroy` liefern `""`,
`level` die aktuelle Stufe. Nach `destroy` gibt es den Befehl nicht
mehr.

```tcl
package require tclutils::tulog
set log [::tclutils::tulog::new -name app -channel stdout \
    -timestamp 0]
$log info "Start"
$log debug "unterdrückt"
$log warn "Platte fast voll"
$log setLevel debug
$log level                                   ;# -> debug
$log destroy
```

Ausgabe auf `stdout`:

```text
[INFO] app: Start
[WARN] app: Platte fast voll
```

`assert` wertet den Ausdruck mit `expr` im Kontext des Aufrufers aus.
Ist er falsch, bricht es mit `{TCLUTILS TULOG ASSERT}` ab; die Meldung
ist die übergebene Nachricht oder `assertion failed: <ausdruck>`.

```tcl
set n 3
::tclutils::tulog::assert {$n > 2}           ;# -> (leer)
catch {::tclutils::tulog::assert {$n > 5}} m
set m                          ;# -> assertion failed: $n > 5
```

| Fall | Code |
|---|---|
| unbekannte Stufe bei `-level`, `log`, `setLevel` | `{TCLUTILS TULOG LEVEL}` |
| `-timestamp` nicht boolesch | `{TCLUTILS COMMON BOOLEAN -timestamp}` |
| unbekannte Option bei `new` | `{TCLUTILS COMMON OPTION <opt>}` |
| unbekannter Unterbefehl, falsche Zahl Argumente | ohne `-errorcode` |
| Assertion falsch | `{TCLUTILS TULOG ASSERT}` |

`new` prüft alle Optionen, bevor es den Logger anlegt; nach einem
Fehler bleibt kein Logger zurück. `-channel` prüft `new` nicht. Ein Kanal, den es nicht gibt, fällt erst
bei der ersten Ausgabe auf: `can not find channel named "…"` mit
`{TCL LOOKUP CHANNEL …}`.

---

## tuevent

[tuevent]{.index} ist ein Ereignisbus nach dem Muster Veröffentlichen und
Abonnieren. Jeder Bus ist ein Token; Abonnenten sind Befehlspräfixe.

| Befehl | Wirkung | Rückgabe |
|---|---|---|
| `create` | neuer Bus | Token `tuevent<n>` |
| `subscribe bus ereignis handler` | Handler anmelden; derselbe Handler nur einmal | `""` |
| `unsubscribe bus ereignis handler` | Handler abmelden; fehlt er, geschieht nichts | `""` |
| `emit bus ereignis ?arg ...?` | Handler aufrufen | Zahl der aufgerufenen Handler |
| `handlers bus ereignis` | angemeldete Handler | Liste in Anmeldereihenfolge |
| `events bus` | Ereignisse mit Handlern | sortierte Liste |
| `clear bus ?ereignis?` | Handler eines Ereignisses oder aller löschen | `""` |
| `destroy bus` | Bus mit allen Anmeldungen löschen | `""` |

`emit` ruft jeden Handler auf globaler Ebene auf, die Argumente hinten
angehängt, in der Reihenfolge der Anmeldung. Ein Fehler in einem Handler
bricht `emit` ab und geht an den Aufrufer; die folgenden Handler laufen
dann nicht. Ein Token, das `create` nicht geliefert hat oder das
`destroy` gelöscht hat, ergibt `{TCLUTILS TUEVENT BUS}` mit
`unknown event bus: "<token>"`.

```tcl
package require tclutils::tuevent
set bus [::tclutils::tuevent::create]
set log {}
proc merke {id} { lappend ::log $id }
::tclutils::tuevent::subscribe $bus saved merke
::tclutils::tuevent::subscribe $bus saved merke
::tclutils::tuevent::emit $bus saved 42      ;# -> 1
set log                                      ;# -> 42
::tclutils::tuevent::emit $bus closed        ;# -> 0
::tclutils::tuevent::events $bus             ;# -> saved
::tclutils::tuevent::destroy $bus
```

---

## turegistry

[turegistry]{.index} legt Werte unter Schlüsseln ab, etwa Datenbankverbindungen
oder Dienste, die mehrere Teile einer Anwendung brauchen. Jede Registry
ist ein Token.

| Befehl | Wirkung | Rückgabe |
|---|---|---|
| `create` | neue Registry | Token `turegistry<n>` |
| `put reg schlüssel wert` | Wert ablegen, alten ersetzen | der Wert |
| `get reg schlüssel ?vorgabe?` | Wert lesen | Wert oder Vorgabe |
| `has reg schlüssel` | Schlüssel vorhanden? | `1` oder `0` |
| `keys reg ?muster?` | Schlüssel, mit `string match` gefiltert | sortierte Liste |
| `remove reg schlüssel` | Schlüssel löschen | `1`, wenn er da war, sonst `0` |
| `destroy reg` | Registry löschen | `""` |

`get` ohne Vorgabe bricht bei fehlendem Schlüssel mit
`{TCLUTILS TUREGISTRY KEY}` ab, Meldung
`registry key not set: "<schlüssel>"`. Eine leere Vorgabe `{}` zählt
als Vorgabe. Ein unbekanntes Token ergibt `{TCLUTILS TUREGISTRY REG}`.

```tcl
package require tclutils::turegistry
set reg [::tclutils::turegistry::create]
::tclutils::turegistry::put $reg db conn1    ;# -> conn1
::tclutils::turegistry::put $reg db.timeout 30
::tclutils::turegistry::get $reg db          ;# -> conn1
::tclutils::turegistry::get $reg cache leer  ;# -> leer
::tclutils::turegistry::keys $reg db.*       ;# -> db.timeout
::tclutils::turegistry::remove $reg db       ;# -> 1
::tclutils::turegistry::has $reg db          ;# -> 0
::tclutils::turegistry::destroy $reg
```

Mehr als ein Vorgabewert bei `get` ist ein Aufruffehler ohne
`-errorcode`, aber nur, wenn der Schlüssel fehlt. Ist er gesetzt,
liefert `get` den Wert und übergeht die überzähligen Argumente.

---

## tuvalidate

[tuvalidate]{.index} enthält Prüfungen, die `1` oder `0` liefern. Am geprüften
Wert scheitern sie nicht; Fehler gibt es nur bei falschen Argumenten.
Die Prüfungen für E-Mail und URL erkennen die übliche Form, sie sind
keine vollständigen RFC-Prüfungen.

| Befehl | 1, wenn |
|---|---|
| `email s` | `lokal@domain.tld`; lokal aus `A-Z a-z 0-9 . _ % + -`, Domain aus `A-Z a-z 0-9 . -`, Endung mindestens zwei ASCII-Buchstaben |
| `url s` | beginnt mit `http://` oder `https://`, ohne Leerraum, das erste Zeichen danach ist nicht `/ $ . ? #` |
| `ipv4 s` | vier Gruppen aus 1–3 Ziffern, jede höchstens 255, ohne führende Null |
| `port s` | nur Dezimalziffern, Wert 1 bis 65535 |
| `alpha s` | nur `A-Z a-z`, nicht leer |
| `alnum s` | nur `A-Z a-z 0-9`, nicht leer |
| `numeric s` | `string is double -strict` |
| `integer s` | `string is integer -strict` |
| `length s min max` | `min <= [string length s] <= max` |
| `pattern s re` | `regexp re s` trifft |
| `inList s liste` | `s` ist Element der Liste (genauer Vergleich) |

```tcl
package require tclutils::tuvalidate
::tclutils::tuvalidate::email a@b.com             ;# -> 1
::tclutils::tuvalidate::email "jörg@b.de"    ;# -> 0
::tclutils::tuvalidate::url ftp://tcl.tk/         ;# -> 0
::tclutils::tuvalidate::ipv4 10.0.0.256           ;# -> 0
::tclutils::tuvalidate::ipv4 010.0.0.1            ;# -> 0
::tclutils::tuvalidate::ipv4 0.0.0.0              ;# -> 1
::tclutils::tuvalidate::port 0x50                 ;# -> 0
::tclutils::tuvalidate::port 080                  ;# -> 1
::tclutils::tuvalidate::numeric 1,5               ;# -> 0
::tclutils::tuvalidate::length abc 3 20           ;# -> 1
::tclutils::tuvalidate::pattern 2024-03-15 {^\d{4}-\d\d-\d\d$}
                                                  ;# -> 1
```

`alpha` und `alnum` kennen nur ASCII; für Unicode-Buchstaben gilt
`string is alpha`. `ipv4` prüft streng wie `inet_pton`: Eine Gruppe
mit führender Null (`010`) ergibt 0, die Gruppe `0` allein ist gültig.
`port` nimmt nur die ASCII-Ziffern `0` bis `9`, ohne Vorzeichen, ohne
Leerraum und ohne `0x`; `0x50` und `" 80"` ergeben 0. Führende Nullen
sind erlaubt und zählen dezimal: `080` ist Port 80, unter Tcl 8.6 und
9 gleich.

| Fall | Code |
|---|---|
| `length`: `min` oder `max` keine ganze Zahl | `{TCLUTILS TUVALIDATE ARG}` |
| `pattern`: ungültiger regulärer Ausdruck | `{TCLUTILS TUVALIDATE REGEX}` |

---

## tulist

[tulist]{.index} ergänzt die Listenbefehle des Kerns. `lreverse`,
`lsort -unique`, `lsearch` und `lmap` bleiben beim Kern. `map`,
`filter`, `reduce`, `all` und `any` nehmen einen Befehlspräfix, keinen
Skriptrumpf; er läuft auf globaler Ebene mit dem Element hinten
angehängt. Lokale Variablen des Aufrufers sind darin nicht sichtbar;
`apply` mit Parametern löst das.

| Befehl | Wirkung |
|---|---|
| `unique liste` | Doppelte entfernen, Reihenfolge des ersten Auftretens bleibt |
| `flatten liste ?tiefe?` | Unterlisten auflösen, Vorgabe für `tiefe` ist 1; `tiefe <= 0` liefert die Liste unverändert |
| `chunk liste größe` | Stücke zu höchstens `größe` Elementen |
| `zip liste ...` | Tupel, endet mit der kürzesten Liste; ohne Liste `{}` |
| `sum liste` | Summe, leere Liste `0` |
| `avg liste` | Mittelwert als Gleitkommazahl |
| `min liste`, `max liste` | kleinstes, größtes Element nach `<` und `>` |
| `reduce liste start cmd` | Linksfaltung: `acc = cmd acc element` |
| `map liste cmd` | Ergebnisse von `cmd element` |
| `filter liste cmd` | Elemente, für die `cmd element` wahr ist |
| `all liste cmd`, `any liste cmd` | `1`/`0`; leere Liste: `all` 1, `any` 0 |
| `take liste n`, `drop liste n` | erste `n` Elemente bzw. der Rest; `n <= 0` ergibt `{}` bzw. die ganze Liste |

```tcl
package require tclutils::tulist
::tclutils::tulist::unique {a b a c b}            ;# -> a b c
::tclutils::tulist::flatten {{1 2} {3 {4 5}}}     ;# -> 1 2 3 {4 5}
::tclutils::tulist::flatten {{1 2} {3 {4 5}}} 2   ;# -> 1 2 3 4 5
::tclutils::tulist::chunk {1 2 3 4 5} 2           ;# -> {1 2} {3 4} 5
::tclutils::tulist::zip {a b c} {1 2}             ;# -> {a 1} {b 2}
::tclutils::tulist::avg {1 2 3 4}                 ;# -> 2.5
::tclutils::tulist::max {b a c}                   ;# -> c
::tclutils::tulist::reduce {1 2 3 4} 0 ::tcl::mathop::+
                                                  ;# -> 10
::tclutils::tulist::map {1 2 3} {apply {{x} {expr {$x*$x}}}}
                                                  ;# -> 1 4 9
::tclutils::tulist::filter {1 2 3 4} {apply {{x} {expr {$x%2==0}}}}
                                                  ;# -> 2 4
::tclutils::tulist::drop {a b c d} 2              ;# -> c d
```

`min` und `max` vergleichen Zahlen numerisch, sonst als Text. `sum` und
`avg` rechnen mit `expr`; ein nicht numerisches Element bricht mit
`{ARITH DOMAIN {non-numeric string}}` ab. Ebenso ein nicht numerisches
`n` bei `take` und `drop`.

| Fall | Code |
|---|---|
| `chunk`: Größe keine positive ganze Zahl | `{TCLUTILS TULIST SIZE}` |
| `avg`, `min`, `max` einer leeren Liste | `{TCLUTILS TULIST EMPTY}` |

---

## tumath

[tumath]{.index} ergänzt `expr` um Rechnungen, die dort fehlen. `round`,
`ceil`, `floor` und `abs` bleiben bei `expr`.

| Befehl | Rückgabe | Fehler |
|---|---|---|
| `clamp x lo hi` | `x`, auf `lo` bis `hi` begrenzt | `lo > hi`: `ARG` |
| `inRange x lo hi` | `1`, wenn `lo <= x <= hi` | – |
| `percent teil ganzes` | `teil / ganzes * 100` als Gleitkommazahl | `ganzes == 0`: `DIVZERO` |
| `sign x` | `-1`, `0` oder `1` | – |
| `gcd a b` | größter gemeinsamer Teiler, nicht negativ; `gcd 0 0` ist 0 | keine ganzen Zahlen: `ARG` |
| `lcm a b` | kleinstes gemeinsames Vielfaches; 0, wenn ein Argument 0 ist | über `gcd` |
| `factorial n` | `n!`, mit Tcls großen Ganzzahlen | `n` negativ oder keine ganze Zahl: `ARG` |
| `roundTo x stellen` | `round(x * 10**stellen) / 10**stellen`, Gleitkommazahl | `stellen` negativ oder keine ganze Zahl: `ARG` |

Die Codes lauten `{TCLUTILS TUMATH ARG}` und
`{TCLUTILS TUMATH DIVZERO}`.

```tcl
package require tclutils::tumath
::tclutils::tumath::clamp 12 0 10            ;# -> 10
::tclutils::tumath::percent 30 200           ;# -> 15.0
::tclutils::tumath::gcd -24 36               ;# -> 12
::tclutils::tumath::lcm 4 6                  ;# -> 12
::tclutils::tumath::factorial 25   ;# -> 15511210043330985984000000
::tclutils::tumath::roundTo 3.14159 2        ;# -> 3.14
::tclutils::tumath::roundTo 2.5 0            ;# -> 3.0
::tclutils::tumath::roundTo 1.005 2          ;# -> 1.0
```

`roundTo` rechnet mit Gleitkommazahlen. `1.005 * 100` ergibt
`100.49999…`, daher `1.0` statt `1.01`. Für Beträge mit fester
Stellenzahl rundet `tunum::format` auf den Dezimalziffern, siehe
[Zeichen, Zahlen, Datum und Pfade](045-zeichen-zahlen-datum.md).

---

## tunumany

[tunumany]{.index} ist ein Eingang für Zahlen in zwei Schreibweisen. Beträge mit
Tausendertrennung und Währung gehen an `tunum::parse`, Größen mit
SI- oder IEC-Einheit (`1.5K`, `2Mi`) an `tunumfmt::fromHuman`. Die
beiden Parser selbst bleiben getrennt; `tunum` beschreibt das Kapitel
[Zeichen, Zahlen, Datum und Pfade](045-zeichen-zahlen-datum.md).

```tcl
::tclutils::tunumany::parse text ?-default wert? ?-prefer weg?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-default` | `""` | Rückgabe, wenn nichts lesbar ist |
| `-prefer` | `auto` | `auto`, `si` oder `locale`: welcher Parser zuerst gefragt wird |

Mit `auto` wählt `parse` den SI-Weg, wenn der getrimmte Text eine Zahl
mit Punkt oder Komma als Dezimalzeichen, optional Leerzeichen und genau einen der
Buchstaben `K M G T P E Z Y` (auch klein) mit optionalem `i` ist. Alles
andere geht an `tunum::parse` mit Locale `auto`. Liefert der gewählte
Parser nichts, fragt `parse` den anderen. Beide Module lädt `parse` erst
beim Aufruf; fehlt eines, fällt dieser Weg aus.

```tcl
package require tclutils::tunumany
::tclutils::tunumany::parse "1.234,56"       ;# -> 1234.56
::tclutils::tunumany::parse "1,234.56"       ;# -> 1234.56
::tclutils::tunumany::parse "12 €"      ;# -> 12.0
::tclutils::tunumany::parse 42               ;# -> 42.0
::tclutils::tunumany::parse 1.5K             ;# -> 1500
::tclutils::tunumany::parse 2Mi              ;# -> 2097152
::tclutils::tunumany::parse 2KiB             ;# -> 2048
::tclutils::tunumany::parse "3 G"            ;# -> 3000000000
::tclutils::tunumany::parse 1.5m             ;# -> 1500000
::tclutils::tunumany::parse 1,5K             ;# -> 1500
::tclutils::tunumany::parse 1,500K -default x ;# -> x
::tclutils::tunumany::parse x -default 0     ;# -> 0
```

Kleinbuchstaben stehen für dieselben Einheiten: `m` ist Mega, nicht
Milli. Ein Dezimalkomma vor der Einheit zählt: `1,5K` ist 1500 (bis
tclutils 0.68.0 der leere String). Stehen genau drei Ziffern hinter dem
Komma (`1,500K`), könnte es auch Tausender trennen; diese Form liest
`parse` nicht und gibt die Vorgabe zurück. Weil die Vorgabe `""` auch
für Unlesbares steht, hilft ein `-default`, das keine Zahl sein kann,
die beiden Fälle zu trennen. Ganze Zahlen ohne Einheit laufen über `tunum` und kommen
als Gleitkommazahl zurück. Ein `i` direkt nach dem Einheitenbuchstaben
macht die Einheit zur IEC-Einheit, auch mit nachgestelltem `B`: `2KiB`
ergibt 2048, `2KB` ergibt 2000.

| Fall | Code |
|---|---|
| unbekannte Option, Option ohne Wert (`parse 1.5 -default`) | `{TCLUTILS TUNUMANY OPTION}` |
| `-prefer` nicht `auto`, `si`, `locale` | `{TCLUTILS TUNUMANY PREFER}` |

---

## tuappinfo

[tuappinfo]{.index} sammelt Angaben über Tcl, Programm, Plattform, Umgebung,
Suchpfade und geladene Pakete in einem Textbericht, etwa für einen
Info-Dialog oder eine Fehlermeldung an den Entwickler. Die Anzeige
übernimmt der Aufrufer.

```tcl
::tclutils::tuappinfo::trackTm datei
::tclutils::tuappinfo::buildReport ?-title text? ?-anonymize 0|1?
::tclutils::tuappinfo::writeLog datei ?-title text? ?-anonymize 0|1?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-title` | `Application Information` | Überschrift `==== <titel> ====` |
| `-anonymize` | `0` | Benutzer-, Rechner- und Pfadangaben verdecken |

`trackTm` merkt eine Moduldatei für den letzten Abschnitt vor und
liefert die Liste aller gemerkten Dateien. `buildReport` liefert den
Bericht als einen String, `writeLog` schreibt ihn als UTF-8 über eine
temporäre Datei (`common::replaceFile`) und liefert den Dateinamen;
scheitert das Schreiben, bleibt ein altes Protokoll stehen. Bis 0.2
schrieb es in der Systemkodierung.

Der Bericht hat diese Abschnitte in dieser Reihenfolge:

| Abschnitt | Inhalt |
|---|---|
| Kopf | Titel, `Timestamp:`, `PID:` |
| `--- Tcl / Tk ---` | `info patchlevel`, `tk_patchLevel` (nur mit Tk; bis 0.2 `tk_version`), `info nameofexecutable`, Betriebssystem und Version, Maschine, `Host:` |
| `--- Environment ---` | `USER`, `USERNAME`, `HOME`, `TEMP`, `TMP`, `PATH`, soweit gesetzt |
| `--- auto_path ---` | ein Eintrag pro Zeile |
| `--- Loaded Packages ---` | jedes Paket mit `package provide`-Version |
| `--- tm::path ---` | `tcl::tm::path list` |
| `--- Loaded TM Modules ---` | die mit `trackTm` gemerkten Dateien, sonst `(none tracked)` |

Plattformabhängig laut Code: `Host:` steht nur da, wenn die
Umgebungsvariable `COMPUTERNAME` gesetzt ist; Windows setzt sie, unter
Linux und macOS fehlt die Zeile in der Regel. `USERNAME`, `TEMP` und
`TMP` sind typische Windows-Variablen, `USER` und `HOME` typische unter
Linux und macOS.

`-anonymize 1` ersetzt:

| Angabe | Ersatz |
|---|---|
| `USER`, `USERNAME` | `<user-xxxxxxxx>` |
| `Host` | `<host-xxxxxxxx>` |
| `HOME` | `<HOME>` |
| `TEMP`, `TMP` | `<TEMP>` |
| `PATH` | `<anonymized>` |
| Pfade unter dem Heimatverzeichnis | `<HOME>/…` |
| alle anderen Pfade | `<path>/<letzter Teil>` |
| gemerkte Moduldateien | `<tm-xxxxxxxx>.tm` |

`xxxxxxxx` ist ein gleichbleibender, nicht kryptografischer Hash aus
acht Hexziffern; gleiche Namen ergeben gleiche Werte. Die Pfadregel
gilt für `Executable` und für jeden Eintrag in `auto_path` und
`tm::path`. Heimatverzeichnis ist `$HOME`, ohne `HOME` `$USERPROFILE`;
ein Pfad gilt als darunter, wenn er gleich ist oder mit
`<heim>/` beginnt. Aus `/usr/share/tcltk` wird `<path>/tcltk`, aus
`$HOME/lib/tm` wird `<HOME>/lib/tm`. Trennzeichen erscheinen als `/`;
unter Windows vergleicht `tuappinfo` das Heimatverzeichnis ohne
Unterschied von Groß/Klein. Unverändert bleiben `Platform`, `Machine`,
die Versionen und die Paketliste.

```tcl
package require tclutils::tuappinfo
::tclutils::tuappinfo::trackTm /opt/app/lib/tm/foo-1.0.tm
set r [::tclutils::tuappinfo::buildReport -title "MeineApp 1.0"]
lindex [split $r \n] 0                ;# -> ==== MeineApp 1.0 ====
string match "*(none tracked)*" $r    ;# -> 0
```

Die übrigen Zeilen hängen vom Rechner ab: unter Linux etwa
`Tcl version: 9.0.4`, `Platform: Linux <kernel>`, `HOME: /home/<name>`.

| Fall | Code |
|---|---|
| unbekannte Option, Option ohne Wert | `{TCLUTILS TUAPPINFO OPTION}` |
| `-anonymize` nicht boolesch | `{TCLUTILS TUAPPINFO VALUE}` |

`writeLog` prüft die Optionen über `buildReport`, bevor es die Datei
anlegt.

---

## tusysinfo

[tusysinfo]{.index} beschreibt den Rechner: Betriebssystem, Prozessor,
Arbeitsspeicher, Modell, Festplatten und Monitore, unter Linux, macOS und
Windows. `tuappinfo` beschreibt die Tcl-Laufzeit, `tusysinfo` die
Maschine darunter.

```tcl
::tclutils::tusysinfo::collect ?option wert ...?        ;# -> Dict
::tclutils::tusysinfo::report  info ?-title text? ?-anonymize 0|1?
::tclutils::tusysinfo::toJson  info ?-indent n?
```

Das Modul liest zuerst Dateien und die Registry und ruft ein Programm
nur dort auf, wo nichts anderes die Angaben hat. Fehlt ein Programm,
bleiben seine Felder leer; `collect` scheitert daran nicht.

| System | Quellen |
|---|---|
| Linux | `/etc/os-release`, `/proc/cpuinfo`, `/proc/meminfo`, `/sys/class/dmi/id`, `/sys/block`, `/sys/class/drm/*/edid`; kein Programm, kein root |
| macOS | `sw_vers`, `uname`, `sysctl`, `system_profiler -json` (einige Sekunden) |
| Windows | Registry (Paket `registry`) für System, CPU, Modell und die EDID der Monitore; ein PowerShell-Aufruf (CIM) für Speicher, Festplatten und die aktiven Monitore |

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-sections` | alle | Auswahl aus `os cpu memory machine disks displays` |
| `-serials` | `0` | `1`: Seriennummern von Rechner, Festplatten, Monitoren |
| `-commands` | `1` | `0`: kein Programm aufrufen |
| `-timeout` | `10000` | Grenze in ms je Programmaufruf |
| `-platform` | dieser Rechner | `linux`, `macos`, `windows` |
| `-root` | leer | Linux: `/etc`, `/proc`, `/sys` unter diesem Ordner lesen (Tests) |

`collect` liefert ein Dict mit `platform`, `host` und je Abschnitt einem
Dict (`os`, `cpu`, `memory`, `machine`) oder einer Liste von Dicts
(`disks`, `displays`). Größen stehen in Byte. Ein Monitor trägt die
Felder aus seiner EDID (Abschnitt `tuedid`), den Anschluss und
`present` (1 angeschlossen, 0 nicht angeschlossen). Unter Windows gilt
ein Monitor ohne Status als nicht angeschlossen. Kommt von PowerShell
keine oder eine unlesbare Antwort, steht eine Liste `warnings` im Dict
und `report` zeigt einen Abschnitt „Warnings“; Speicher, Festplatten und
Monitorstatus fehlen dann, statt leer zu erscheinen.

```tcl
package require tclutils::tusysinfo
set i [::tclutils::tusysinfo::collect -sections {os memory}]
lsort [dict keys $i]                  ;# -> host memory os platform
dict get $i os id                     ;# -> debian (je nach Rechner)
puts [::tclutils::tusysinfo::report $i -anonymize 1]
```

`report` zeigt Festplatten in GB wie auf dem Etikett und den Speicher in
GiB, `toJson` schreibt Zahlen als Zahlen. Die Kommandozeile
`bin/tusysinfo.tcl` gibt dasselbe aus, mit `--json`, `--serials`,
`--anonymize` und `--sections`.

Seriennummern, Rechnernamen und MAC-Adressen machen einen Rechner und
an einem Büroarbeitsplatz seinen Benutzer erkennbar. Seriennummern kommen
nur mit `-serials 1`, MAC-Adressen gar nicht; `report -anonymize 1`
verdeckt Rechnername und Seriennummern.

Weitere Eigenheiten:

- Linux: die Seriennummer des Rechners (`product_serial`) darf nur root
  lesen. Virtuelle Maschinen haben oft keine DMI-Daten und keinen
  Monitor.
- Windows: Die Registry behält jeden Monitor, der einmal angeschlossen
  war, oft denselben unter mehreren Einträgen (anderer Anschluss,
  anderer Treiber). `tusysinfo` führt jede EDID einmal und setzt
  `present` nach `Get-PnpDevice -Class Monitor`: 1 bei Status OK, sonst
  0, leer ohne diese Liste. In einer Remotedesktop-Sitzung gelten die
  echten Monitore als nicht angeschlossen; `report` schreibt dann
  „(not connected)“. `WmiMonitorID` meldet auf manchen Rechnern „Nicht
  unterstützt“ und wird deshalb nicht benutzt.
  Windows 11 meldet als `ProductName` weiter „Windows 10 …“; ab Build
  22000 steht Windows 11 da. SSD oder HDD kommt aus `Get-PhysicalDisk`;
  eine NVMe-Platte gilt als SSD.
- Platzhalter der Firmware wie „Default string“ oder „To be filled by
  O.E.M.“ bleiben leer.
- macOS: `system_profiler` braucht einige Sekunden; `-sections {os cpu
  memory}` lässt ihn weg. Er nennt beim Monitor Hersteller, Modell,
  Produktcode, Woche und Jahr, aber keine Größe; `widthCm`, `heightCm`
  und `diagonal` bleiben 0. Je APFS-Container (`disk3`) gibt es einen
  Eintrag, seine Volumes stehen in `volumes`; die Größe ist die des
  Containers, etwas weniger als die der Platte.
- Linux: `disks` zeigt die Geräte, nicht Loop-Geräte, RAM-Disks und
  Device-Mapper-Volumes (LVM, LUKS); RAID (`md*`) bleibt. Debian
  testing/sid hat keine `VERSION_ID`; `version` kommt dann aus
  `/etc/debian_version`, etwa `forky/sid`.
- Geprüft auf einem Linux-PC mit zwei Monitoren (Debian sid), einem
  Windows-11-PC und einem Mac mini (Apple Silicon, macOS 27). Die Tests
  spielen aufgezeichnete Ausgaben dieser Rechner nach.

| Fall | Code |
|---|---|
| unbekannte Option, Option ohne Wert | `{TCLUTILS TUSYSINFO OPTION}` |
| unbekannter Abschnitt | `{TCLUTILS TUSYSINFO SECTION}` |
| unbekannte Plattform | `{TCLUTILS TUSYSINFO PLATFORM}` |

---

## tuedid

[tuedid]{.index} liest den EDID-Block eines Monitors. Darin beschreibt
sich der Monitor in 128 Byte: Hersteller, Produktcode, Seriennummer,
Woche und Jahr der Herstellung, Größe in Zentimetern und die bevorzugte
Auflösung; Textfelder tragen Modellnamen und eine Seriennummer als Text.

```tcl
::tclutils::tuedid::parse    bytes       ;# -> Dict
::tclutils::tuedid::parseHex text        ;# Hexziffern, Leerzeichen und ":" egal
::tclutils::tuedid::vendor   kürzel      ;# DEL -> Dell
```

Die Bytes liegen unter Linux in `/sys/class/drm/card*-*/edid`, unter
Windows in der Registry (`Enum\DISPLAY\…\Device Parameters`, Wert
`EDID`); `xrandr --verbose` und `ioreg` unter macOS geben sie als Hex
aus. `tusysinfo` liest sie selbst.

```tcl
package require tclutils::tuedid
set fh [open /sys/class/drm/card0-DP-1/edid rb]
set d [::tclutils::tuedid::parse [read $fh]]
close $fh
dict get $d vendor                    ;# -> Dell
dict get $d diagonal                  ;# -> 27.2 (Zoll)
dict get $d preferred                 ;# -> width 1920 height 1080 refresh 60.0
```

| Schlüssel | Inhalt |
|---|---|
| `valid` | 1 bei richtiger Prüfsumme; ein Block mit falscher Summe wird trotzdem gelesen |
| `manufacturer`, `vendor` | PNP-Kürzel (`DEL`) und Name für bekannte Kürzel |
| `productCode`, `serial`, `serialText`, `name` | Produktcode (Hex), Seriennummer als Zahl und als Text, Modellname |
| `week`, `year` | Herstellung, 0 wenn unbekannt |
| `widthCm`, `heightCm`, `diagonal` | Größe; 0 bei Beamern ohne Angabe |
| `preferred` | erste detaillierte Auflösung: `width`, `height`, `refresh` |

Erweiterungsblöcke (CEA-861, DisplayID) zählt `extensions`; gelesen
werden sie nicht. Weniger als 128 Byte werfen `{TCLUTILS TUEDID SHORT}`,
ein fehlender EDID-Kopf `{TCLUTILS TUEDID HEADER}`, Text, der kein Hex
ist, `{TCLUTILS TUEDID HEX}`.

---

## tudeploy

[tudeploy]{.index} findet die Modulverzeichnisse und Ressourcen, die eine
Anwendung neben sich mitbringt, trägt sie in `tcl::tm::path` ein und
lädt Pakete daraus. Es kennt keine bestimmte Anwendung; Verzeichnisse
und Pakete kommen als Argumente. Das Modul ist zugleich ein Ensemble:
`::tclutils::tudeploy roots` und `::tclutils::tudeploy::roots` sind
derselbe Aufruf.

```tcl
::tclutils::tudeploy::baseDirs
::tclutils::tudeploy::platformTag
::tclutils::tudeploy::roots ?option wert ...?
::tclutils::tudeploy::addModulePaths ?option wert ...?
::tclutils::tudeploy::require pakete ?option wert ...?
::tclutils::tudeploy::resourceDirs name ?option wert ...?
::tclutils::tudeploy::sourceModule paket ?option wert ...?
```

`baseDirs` liefert die Verzeichnisse des Hauptskripts (`argv0`) und des
laufenden Programms (`info nameofexecutable`), normalisiert, ohne
Doppelte, nur vorhandene. `platformTag` liefert `<os><bits>`:

| `tcl_platform` | Ergebnis |
|---|---|
| `platform` = `windows` | `windows32` oder `windows64` |
| `platform` = `unix`, `os` = `Darwin` | `macos32` oder `macos64` |
| `platform` = `unix`, jedes andere `os` | `linux32` oder `linux64` |

Die Bits kommen aus `tcl_platform(pointerSize)`. Auch BSD-Systeme
erhalten damit `linux…`.

### roots und addModulePaths

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-base` | `[baseDirs]` | Basisverzeichnisse |
| `-env` | `{}` | Namen von Umgebungsvariablen; deren Werte kommen unverändert an den Anfang |
| `-roots` | `vendor {libs common} libs {lib tm}` | Unterpfade je Basis, jeder als Liste von Pfadteilen |
| `-parents` | `1` | auch die Elternverzeichnisse der Basen durchsuchen |

`roots` liefert die vorhandenen Verzeichnisse in dieser Reihenfolge:
zuerst die Werte der `-env`-Variablen, die gesetzt und nicht leer sind;
dann für jede Basis jeder Unterpfad aus `-roots`; mit `-parents 1`
danach dasselbe für jedes Elternverzeichnis. Ein Wurzelverzeichnis
enthält Paketordner: `<wurzel>/<paket>/<modul>-<version>.tm` ergibt
`package require <paket>::<modul>`.

`addModulePaths` nimmt dieselben Optionen, ruft für jede Wurzel
`tcl::tm::path add` auf und liefert die Wurzeln, die danach im
Modulpfad stehen, neu eingetragen oder schon vorhanden. Lehnt
`tcl::tm::path` ein Verzeichnis ab, weil es in einem schon eingetragenen
liegt oder eines enthält, übergeht `addModulePaths` das ohne Fehler und
lässt es in der Rückgabe weg.

```tcl
package require tclutils::tudeploy
::tclutils::tudeploy::platformTag     ;# linux64, windows64, macos64 …
::tclutils::tudeploy::roots -base [list $appdir] -parents 0
```

Mit `$appdir/vendor` und `$appdir/lib/tm` vorhanden liefert `roots` die
Liste `$appdir/vendor $appdir/lib/tm`.

### require

`require pakete ?option wert ...?` trägt die Wurzeln ein und führt für
jedes Paket `package require` aus.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-tmadd` | `1` | vorher `addModulePaths` mit den übrigen Optionen aufrufen |
| `-fail` | `0` | bei fehlenden Paketen abbrechen statt `0` liefern |
| `-base`, `-env`, `-roots`, `-parents` | wie `roots` | gehen an `addModulePaths` |

Die Rückgabe ist `1`, wenn alle Pakete geladen sind, sonst `0`. Mit
`-fail 1` bricht `require` mit `{TCLUTILS TUDEPLOY REQUIRE}` ab, die
Meldung nennt die fehlenden Pakete:
`package(s) not found: foo::nix`. Auch mit `-tmadd 0` prüft `require`
die Optionen von `roots`; `-tmadd` und `-fail` müssen boolesch sein.

```tcl
if {![::tclutils::tudeploy::require {meinlib::kern meinlib::ui}]} {
    error "Module fehlen"
}
```

### resourceDirs

`resourceDirs name ?option wert ...?` liefert die vorhandenen
Verzeichnisse, in denen eine mitgelieferte Ressource liegen kann, etwa
ein Decoder. Je Basis, mit `-parents 1` auch je Elternverzeichnis, in
dieser Reihenfolge:

1. `vendor/<name>/<tag>`
2. `vendor/<name>`
3. `vendor/<tag>`
4. `vendor`
5. `bin`
6. die Basis selbst

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-base`, `-env`, `-parents` | wie `roots` | |
| `-tag` | `[platformTag]` | Plattformordner |

`-roots` kennt `resourceDirs` nicht. Ein leerer Name ergibt
`{TCLUTILS TUDEPLOY USAGE}`. Die Liste passt direkt zu
`tuexe::find -dirs`:

```tcl
set dirs [::tclutils::tudeploy::resourceDirs webp -env MYAPP_WEBP]
set exe [::tclutils::tuexe::find dwebp -dirs $dirs]
```

### sourceModule

`sourceModule paket ?option wert ...?` lädt ein Paket, dessen `.tm`
nicht an der Stelle liegt, die sein Name verlangt, zum Beispiel ein
Paket `qpdf` als `vendor/qpdf/lib/qpdf-0.2.tm`. Ein eigener Eintrag
`vendor/qpdf/lib` im Modulpfad scheitert, weil er unter `vendor` liegt.
`sourceModule` sucht deshalb in den Verzeichnissen nach
`<letzter Namensteil>-<version>.tm`, sortiert nach Version absteigend,
und führt `source` auf globaler Ebene aus, bis das Paket vorhanden ist.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-dirs` | `{}` | Verzeichnisse direkt; sonst `roots` mit den übrigen Optionen |
| `-fail` | `0` | bei Misserfolg abbrechen statt `0` liefern |
| `-base`, `-env`, `-roots`, `-parents` | wie `roots` | nur ohne `-dirs` |

Rückgabe `1` oder `0`; mit `-fail 1` `{TCLUTILS TUDEPLOY REQUIRE}` mit
`could not source module for package: <paket>`. `sourceModule` prüft
zuerst die Optionen; ist das Paket danach schon geladen, liefert es
sofort `1`. Dateien, deren Versionsteil keine gültige Version ist, und
Dateien, deren `source` fehlschlägt, übergeht es.

```tcl
::tclutils::tudeploy::sourceModule qpdf -env QPDF_TM \
    -roots {{vendor qpdf lib}}
```

| Fall | Code |
|---|---|
| unbekannte Option, Option ohne Wert, Argument ohne `-` | `{TCLUTILS TUDEPLOY OPTION}` |
| `-tmadd`, `-fail` nicht boolesch | `{TCLUTILS TUDEPLOY VALUE}` |
| `resourceDirs` ohne Namen | `{TCLUTILS TUDEPLOY USAGE}` |
| Paket fehlt, mit `-fail 1` | `{TCLUTILS TUDEPLOY REQUIRE}` |

Eine Anwendung muss `tclutils` selbst erst ladbar machen, bevor sie
`tudeploy` nutzen kann. Wie `tclutils` in den Modulpfad kommt, steht im
Kapitel [Installation](020-installation.md).

---

## tuexe

[tuexe]{.index} sucht externe Programme in mitgelieferten Verzeichnissen und im
`PATH` und probiert dabei mehrere Namen.

```tcl
::tclutils::tuexe::find namen ?-dirs liste? ?-pathfirst 0|1? ?-all 0|1?
::tclutils::tuexe::all namen ?-dirs liste? ?-pathfirst 0|1?
::tclutils::tuexe::exists namen ?-dirs liste? ?-pathfirst 0|1?
```

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-dirs` | `{}` | zusätzliche Verzeichnisse |
| `-pathfirst` | `0` | `1`: erst `PATH`, dann `-dirs` |
| `-all` | `0` | `1`: alle Treffer statt des ersten |

`namen` ist ein Name oder eine Liste. Für jeden Namen nacheinander
durchsucht `find` erst alle `-dirs`, dann den `PATH` (mit
`-pathfirst 1` umgekehrt), und liefert den ersten Treffer als
normalisierten Pfad, sonst `""`. Ein späterer Name kommt erst dran, wenn
der frühere nirgends gefunden ist: bei `{gs gswin64c}` gewinnt ein `gs`
im `PATH` gegen ein `gswin64c` in `-dirs`. `all` liefert alle Treffer
ohne Doppelte in Suchreihenfolge, `exists` `1` oder `0`.

Im `PATH` sucht `tuexe` mit `auto_execok` und nimmt dessen erstes Wort.
In den `-dirs` gilt laut Code:

| Plattform | geprüft wird |
|---|---|
| Linux, macOS | `<dir>/<name>`; reguläre Datei und ausführbar |
| Windows | `<dir>/<name>`, dann `<dir>/<name><ext>` für jede Endung aus `PATHEXT` (klein geschrieben), ohne `PATHEXT` `.exe .com .bat .cmd`; reguläre Datei, keine Prüfung auf Ausführbarkeit |

```tcl
package require tclutils::tuexe
::tclutils::tuexe::find {gs gswin64c gswin32c}   ;# Pfad oder ""
::tclutils::tuexe::find qpdf -dirs [list $vendorBin]
::tclutils::tuexe::exists gibtsnicht             ;# -> 0
```

Unter Linux liefert `find sh` etwa `/usr/bin/sh`; mit einem
ausführbaren `sh` in `$vendorBin` und `-dirs [list $vendorBin]` dessen
Pfad, mit zusätzlich `-pathfirst 1` wieder `/usr/bin/sh`.

Eine unbekannte Option ergibt `{TCLUTILS TUEXE OPTION}` mit
`unknown option '<opt>'`, eine Option ohne Wert (`find sh -dirs`)
denselben Code mit `option '<opt>' requires a value`.

---

## tuopen

[tuopen]{.index} öffnet eine URL oder Datei mit dem Standardprogramm des
Systems, eine Datei im Editor oder einen Ordner im Dateimanager, und
nennt das Konfigurationsverzeichnis einer Anwendung.

| Befehl | Wirkung | Rückgabe |
|---|---|---|
| `command ziel ?-platform p? ?-os o?` | Befehl zum Öffnen bilden, nicht ausführen | Befehlsliste |
| `launch ziel ?-platform p? ?-os o?` | Befehl im Hintergrund starten | Befehlsliste |
| `editCommand ziel ?-editor cmd? ?-platform p? ?-os o?` | Editorbefehl bilden | Befehlsliste |
| `edit ziel ?-editor cmd? ?-platform p? ?-os o?` | Editor starten | Befehlsliste |
| `openDir ziel ?-platform p? ?-os o?` | Ordner öffnen; ist `ziel` eine Datei, deren Ordner | Befehlsliste |
| `configDir app ?-platform p? ?-os o?` | Konfigurationsverzeichnis | Pfad |
| `configFile app datei ?-platform p? ?-os o?` | Datei darin | Pfad |

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-platform` | `tcl_platform(platform)` | `windows` oder anderes |
| `-os` | `tcl_platform(os)` | enthält es `darwin` (ohne Groß/Klein), gilt macOS |
| `-editor` | `""` | eigener Editorbefehl, auch mehrere Wörter; geht allem anderen vor |

Was laut Code je Plattform entsteht:

| | Windows | macOS | Linux und andere Unix |
|---|---|---|---|
| `command`, URL | `rundll32 url.dll,FileProtocolHandler <ziel>` | `open <ziel>` | `xdg-open <ziel>` |
| `command`, sonst | `cmd.exe /c start "" <ziel>` | `open <ziel>` | `xdg-open <ziel>` |
| `editCommand` | `notepad <ziel>` | `open -e <ziel>` | `$EDITOR <ziel>`, sonst `xdg-open <ziel>` |
| `configDir` | `%APPDATA%\<app>`, sonst `%USERPROFILE%\AppData\Roaming\<app>` | `~/Library/Application Support/<app>` | `$XDG_CONFIG_HOME/<app>`, sonst `~/.config/<app>` |

Als URL gilt unter Windows ein Ziel, das mit einem Schema aus mindestens
zwei Zeichen und `:` beginnt (`https:`, `mailto:`); `C:/…` ist ein
Laufwerk. `rundll32` reicht die URL ohne `cmd.exe` weiter, ein `&` in
der Abfrage bleibt so Teil der URL. `cmd.exe` würde dort den Befehl
trennen.

`$EDITOR` wird als Liste gelesen, `vim -n` ergibt `vim -n <ziel>`. Das
Heimatverzeichnis ist `$HOME`, ohne `HOME` `file normalize ~`.
`configDir` legt nichts an. [tusettings](080-tusettings.md) nennt unter
Linux und macOS dasselbe Verzeichnis und schreibt INI-Dateien hinein;
unter Windows weicht nur der Ersatz ohne `APPDATA` ab.

`command`, `editCommand` und `configDir` starten nichts; mit `-platform`
und `-os` zeigen sie das Ergebnis für jede Plattform:

```tcl
package require tclutils::tuopen
::tclutils::tuopen::command https://tcl.tk/ -platform windows
            ;# -> rundll32 url.dll,FileProtocolHandler https://tcl.tk/
::tclutils::tuopen::command C:/doc/a.pdf -platform windows
                          ;# -> cmd.exe /c start {} C:/doc/a.pdf
::tclutils::tuopen::command a.pdf -platform unix -os Darwin
                          ;# -> open a.pdf
::tclutils::tuopen::editCommand notiz.txt -editor {code -w}
                          ;# -> code -w notiz.txt
::tclutils::tuopen::configDir meineapp -platform unix -os Linux
                          ;# ~/.config/meineapp, mit $HOME aufgelöst
```

`launch`, `edit` und `openDir` führen den Befehl mit `exec … &` aus und
liefern ihn zurück. `launch` kehrt zurück, sobald der Prozess gestartet
ist; ob das Programm die Datei danach öffnen kann, meldet es nicht.

```tcl
::tclutils::tuopen::launch https://tcl.tk/
::tclutils::tuopen::openDir [file join $dir bericht.pdf]
```

| Fall | Code |
|---|---|
| `ziel` leer oder nur Leerraum | `{TCLUTILS TUOPEN TARGET}` |
| `app` leer oder nur Leerraum | `{TCLUTILS TUOPEN APP}` |
| `exec` scheitert, etwa ohne `xdg-open` | `{TCLUTILS TUOPEN LAUNCH}`, `cannot open "<ziel>": …` bzw. `cannot edit …` |
| unbekannte Option | `{TCLUTILS COMMON OPTION <opt>}` |

`namespace export` nennt alle sieben Befehle; nach
`namespace import ::tclutils::tuopen::*` stehen sie ohne Präfix bereit.

---

## tuzipfs

[tuzipfs]{.index} legt sich um `zipfs` aus Tcl 9: ZIP-Archive einhängen und
lesen und eigenständige Programme (Zipkits) bauen. Das Paket lädt auch
unter Tcl 8.6 und steht im Umbrella. Befehle, die `zipfs` brauchen,
brechen dort mit `{TCLUTILS TUZIPFS UNAVAILABLE}` ab, Meldung
`zipfs is not available in this Tcl interpreter; Tcl 9 is required`.
ZIP-Dateien unter Tcl 8.6 liest und schreibt `tuzip`, siehe
[Text und Dateien](040-text-und-dateien.md).

| Befehl | Wirkung | Tcl 8.6 |
|---|---|---|
| `available` | `1`, wenn der Befehl `zipfs` existiert | `0` |
| `requireAvailable` | `1`, sonst Fehler | `UNAVAILABLE` |
| `root` | `zipfs root`, also `//zipfs:/` | `UNAVAILABLE` |
| `mounts` | `zipfs mount`: Paare aus Einhängepunkt und Archiv | `UNAVAILABLE` |
| `mount archiv ?name?` | einhängen, liefert `//zipfs:/<name>` | `UNAVAILABLE` |
| `unmount punkt` | aushängen, liefert `punkt` | `UNAVAILABLE` |
| `listFiles punkt ?-glob m? ?-recursive b?` | Einträge, sortiert | `UNAVAILABLE` |
| `find punkt ?…?` | dasselbe wie `listFiles` | `UNAVAILABLE` |
| `exists pfad` | `zipfs exists` | `UNAVAILABLE` |
| `readFile pfad` | Inhalt als Bytes | `UNAVAILABLE` |
| `withMounted archiv var rumpf ?-mount name?` | einhängen, Rumpf ausführen, aushängen | `UNAVAILABLE` |
| `rcopy quelle ziel` | rekursive Bytekopie, liefert `ziel` | läuft |
| `copyStdlib ziel ?-tk b? ?-from q?` | `tcl_library` (und `tk_library`) kopieren | läuft |
| `mkimg datei vfs ?…?` | `zipfs mkimg` mit Prüfungen | `UNAVAILABLE` |
| `buildImage -out datei -vfs dir ?…?` | `copyStdlib`, dann `mkimg` | Optionsprüfung und `copyStdlib` laufen, `mkimg` bricht ab |

### Archiv lesen

`mount` ohne Namen erzeugt `tclutils_<pid>_<clicks>`. Ein fehlendes
Archiv meldet `zipfs` selbst mit `{POSIX ENOENT …}`.

| Option von `listFiles` | Vorgabe | Wirkung |
|---|---|---|
| `-glob` | `*` | Muster gegen den letzten Namensteil oder den ganzen Pfad |
| `-recursive` | `1` | `1`: alle Einträge über `zipfs find`; `0`: nur die oberste Ebene über `glob` |

Die Liste enthält auch Verzeichnisse. Mit `-recursive 0` gilt `-glob`
nur für die oberste Ebene. `readFile` liest binär; Text entsteht mit
`encoding convertfrom`.

`withMounted` hängt ein, setzt die Variable im Kontext des Aufrufers auf
den Einhängepunkt, führt den Rumpf dort aus und hängt danach immer aus,
auch nach einem Fehler. Die Rückgabe ist das Ergebnis des Rumpfs.

```tcl
package require tclutils::tuzipfs
if {[::tclutils::tuzipfs::available]} {
    ::tclutils::tuzipfs::withMounted $zip mp {
        set xml [::tclutils::tuzipfs::listFiles $mp -glob *.xml]
        set txt [::tclutils::tuzipfs::readFile $mp/notiz.txt]
    }
}
```

Für ein Archiv mit `notiz.txt` (Inhalt `Hallo`) und `sub/a.xml` ergibt
das unter Tcl 9 `xml` = `//zipfs:/tclutils_<pid>_<clicks>/sub/a.xml`
und `txt` = `Hallo`; ohne `-glob` enthielte die Liste zusätzlich
`…/notiz.txt` und das Verzeichnis `…/sub`.

### Programm bauen

`zipfs mkimg` ersetzt das ZIP-Archiv, das am Basekit hängt. Ein Basekit
von BAWT oder Magicsplat trägt seine Standardbibliothek in diesem
Archiv (`//zipfs:/app/tcl_library`). Ein Abbild nur mit der Anwendung
verliert sie und startet nicht. `copyStdlib` legt sie deshalb vorher in
den VFS-Baum.

`rcopy` kopiert Byte für Byte und liest dabei auch aus einem
eingehängten `zipfs`. Dateien und Ordner, deren Name mit einem Punkt
beginnt, kopiert es mit; `.` und `..` übergeht es.

| Option von `copyStdlib` | Vorgabe | Wirkung |
|---|---|---|
| `-tk` | `0` | auch `tk_library` kopieren |
| `-from` | `running` | `running`: `info library` und `$::tk_library` des laufenden Interpreters; sonst ein Verzeichnis mit `tcl_library/` (und `tk_library/`), etwa der Einhängepunkt eines fremden Basekits |

| Option von `mkimg` | Vorgabe | Wirkung |
|---|---|---|
| `-strip` | das VFS-Verzeichnis | Pfadanfang, der im Archiv wegfällt |
| `-basekit` | laufendes Programm | Vorlage; ohne Angabe muss das laufende Programm selbst ein Zipkit sein |
| `-password` | `""` | Kennwort für das Archiv |

| Option von `buildImage` | Vorgabe | Wirkung |
|---|---|---|
| `-out` | – | Ausgabedatei, Pflicht |
| `-vfs` | – | fertiger VFS-Baum, Pflicht |
| `-basekit` | `""` | an `mkimg` |
| `-stdlib` | `none` | `none`, `cli` (nur `tcl_library`) oder `gui` (mit `tk_library`) |
| `-stdlibfrom` | `running` | an `copyStdlib -from` |

```tcl
file mkdir app.vfs
file copy meineapp.tcl [file join app.vfs main.tcl]
::tclutils::tuzipfs::buildImage -out meineapp -vfs app.vfs \
    -basekit basekit-tcl -stdlib cli
```

`buildImage` liefert die Ausgabedatei. `main.tcl` an der Wurzel des
Archivs startet beim Aufruf des Programms. Ob das Ergebnis ohne
installiertes Tcl läuft, hängt vom Basekit ab: Nur ein statisch
gebautes ist eigenständig.

| Fall | Code |
|---|---|
| `zipfs` fehlt | `{TCLUTILS TUZIPFS UNAVAILABLE}` |
| `-tk 1` ohne `tk_library` | `{TCLUTILS TUZIPFS NOTK}` |
| `-from` ohne `tcl_library` | `{TCLUTILS TUZIPFS NOSTDLIB}` |
| `mkimg`: VFS kein Verzeichnis | `{TCLUTILS TUZIPFS NODIR}` |
| `buildImage` ohne `-out`/`-vfs`, `-stdlib` falsch | `{TCLUTILS TUZIPFS OPTION}` |
| `-recursive`, `-tk` nicht boolesch | `{TCLUTILS COMMON BOOLEAN <opt>}` |
| unbekannte Option | `{TCLUTILS COMMON OPTION <opt>}` |

---

## tuterm

[tuterm]{.index} erzeugt ANSI-Steuerfolgen (SGR) für Schriftattribute und
Farben im Terminal und entfernt sie wieder.

| Befehl | Rückgabe |
|---|---|
| `style ?spec ...?` | Steuerfolge; `""`, wenn ausgeschaltet |
| `wrap text ?spec ...?` | Steuerfolge, Text, Reset; nur der Text, wenn ausgeschaltet |
| `off attr` | Folge zum Abschalten eines Attributs |
| `names ?was?` | `all` (Vorgabe): Kategorien; `fg`/`bg`: Farbnamen; ein Attribut: `on off`; `reset` und Unbekanntes: `{}` |
| `strip text` | Text ohne Folgen der Form `ESC [ … m` |
| `enable ?bool?` | Schalter lesen oder setzen; liefert den Stand |
| `auto` | Schalter aus `NO_COLOR` setzen; liefert den Stand |
| `enableVT`, `disableVT` | VT-Modus der Windows-Konsole; `1` bei Erfolg |

| Spec | Wirkung |
|---|---|
| `reset` | alles zurücksetzen |
| `bold` `dim` `italic` `underline` `blink` `reverse` `invisible` `strike` | Attribut ein |
| `<attr>:on`, `<attr>:off` | Attribut ein oder aus |
| `fg:<farbe>`, `bg:<farbe>` | Vorder- und Hintergrund; `fgcolor:` und `bgcolor:` gleichwertig |

Eine Farbe ist ein Name (`black` … `white`, `gray`, `bright_black` …
`bright_white`), ein Index `0` bis `255` (256 Farben) oder `#rrggbb`
(24 Bit). `gray` und `bright_black` sind dieselbe Farbe. Jede Spec ist
ein eigenes Argument; `"fg:red bold"` als ein Argument ist eine
unbekannte Farbe.

```tcl
package require tclutils::tuterm
proc zeige {s} { string map [list \x1b {\e}] $s }
zeige [::tclutils::tuterm::style bold fg:red]   ;# -> \e[1m\e[31m
zeige [::tclutils::tuterm::wrap OK fg:green]    ;# -> \e[32mOK\e[0m
zeige [::tclutils::tuterm::style fg:208 bg:#00aa00]
                          ;# -> \e[38;5;208m\e[48;2;0;170;0m
zeige [::tclutils::tuterm::off underline]       ;# -> \e[24m
::tclutils::tuterm::strip [::tclutils::tuterm::wrap OK bold]
                                                ;# -> OK
::tclutils::tuterm::enable 0                    ;# -> 0
::tclutils::tuterm::wrap OK bold                ;# -> OK
::tclutils::tuterm::enable 1                    ;# -> 1
```

Nach dem Laden ist `tuterm` eingeschaltet, auch wenn `NO_COLOR` gesetzt
ist oder die Ausgabe in eine Datei geht. Erst `auto` wertet `NO_COLOR`
aus: Ist die Variable vorhanden, auch leer, schaltet es aus, sonst ein.
Ob `stdout` ein Terminal ist, prüft `tuterm` nicht. Ausgeschaltet prüft
`style` die Specs nicht; Tippfehler fallen dann nicht auf.

Plattform laut Code: `enableVT` und `disableVT` liefern außerhalb von
Windows sofort `1`. Unter Windows setzen bzw. löschen sie das Bit
`0x0004` im Konsolenmodus von `stdout` über das Paket `twapi`; fehlt
`twapi` oder scheitert der Aufruf, liefern sie `0`.

| Fall | Code |
|---|---|
| unbekannte Spec oder `attr:` mit anderem Wert als `on`/`off` | `{TCLUTILS TUTERM STYLE}` |
| unbekannte Farbe, Index außerhalb 0–255 | `{TCLUTILS TUTERM VALUE}` |
| `off` für `reset` oder eine Farbkategorie | `{TCLUTILS TUTERM CATEGORY}` |
| `enable` mit nicht booleschem Wert | `{TCLUTILS COMMON BOOLEAN bool}` |

`enable` nimmt jeden booleschen Wert von Tcl (`0`/`1`, `yes`/`no`,
`true`/`false`, `on`/`off`) und liefert `0` oder `1`; nach einem
Fehler bleibt der Schalter unverändert.

---

## tupagespec

[tupagespec]{.index} übersetzt Seitenangaben wie `1-3,5,7-` in eine Liste von
Seitennummern und eine Liste zurück in die kurze Form.

```tcl
::tclutils::tupagespec::parse angabe gesamt ?-base 1?
::tclutils::tupagespec::count angabe gesamt
::tclutils::tupagespec::compact seiten
```

| Teil | Bedeutung |
|---|---|
| leer, `all`, `*` | alle Seiten |
| `N` | eine Seite |
| `A-B` | Bereich; `A > B` wird getauscht |
| `A-` | `A` bis `gesamt` |
| `-B` | 1 bis `B` |
| `end`, `last` | steht für `gesamt` |

Teile stehen durch Komma getrennt; Leerraum um ein Komma und leere Teile
übergeht `parse`, Groß/Klein spielt keine Rolle. Leerraum innerhalb
eines Teils (`1 - 3`) ist ein Syntaxfehler.

| Option | Vorgabe | Wirkung |
|---|---|---|
| `-base` | `1` | `1`: Seiten ab 1; `0`: jede Nummer um 1 kleiner |

`parse` liefert die Seiten sortiert und ohne Doppelte, `count` deren
Anzahl (ohne `-base`). `compact` sortiert, entfernt Doppelte und fasst
Folgen zu `A-B` zusammen; eine leere Liste ergibt `""`.

```tcl
package require tclutils::tupagespec
::tclutils::tupagespec::parse "1-3,5" 10        ;# -> 1 2 3 5
::tclutils::tupagespec::parse "5-" 8            ;# -> 5 6 7 8
::tclutils::tupagespec::parse "-3" 8            ;# -> 1 2 3
::tclutils::tupagespec::parse "4-last" 6        ;# -> 4 5 6
::tclutils::tupagespec::parse "5-3,1,1" 10      ;# -> 1 3 4 5
::tclutils::tupagespec::parse "2-4" 10 -base 0  ;# -> 1 2 3
::tclutils::tupagespec::count "1-3,5" 10        ;# -> 4
::tclutils::tupagespec::compact {8 7 1 2 2 3}   ;# -> 1-3,7-8
```

| Fall | Code |
|---|---|
| Teil nicht lesbar | `{TCLUTILS TUPAGESPEC SYNTAX}`, `invalid page-spec part: '<teil>'` |
| Seite außerhalb `1..gesamt` | `{TCLUTILS TUPAGESPEC RANGE}`, `page <n> out of range (1..<gesamt>)` |
| unbekannte Option | `{TCLUTILS TUPAGESPEC OPTION}` |
| `-base` nicht 0 oder 1; `gesamt` keine nicht negative ganze Zahl | `{TCLUTILS TUPAGESPEC VALUE}` |

Seite 0 und Bereiche über das Ende (`8-12` bei 10 Seiten) sind
`RANGE`-Fehler, keine stillen Kürzungen.

Zahlen sind Folgen der ASCII-Ziffern `0` bis `9` und immer dezimal,
auch mit führender Null; unter Tcl 8.6 und 9 gilt dasselbe. Das gilt
auch für ein `gesamt` nur aus Ziffern:

```tcl
::tclutils::tupagespec::parse 08 10             ;# -> 8
::tclutils::tupagespec::parse 07-09 10          ;# -> 7 8 9
::tclutils::tupagespec::parse 9-end 010         ;# -> 9 10
```

---

## tulayout

[tulayout]{.index} rechnet für Seitenlayouts in Millimetern, Ursprung oben
links: Papierformate, Umrechnung in Pixel, Raster und Blöcke. Ein Block
ist ein Dict; ein Layout hat ein Unter-Dict `blocks` von Block-ID zu
Block. Den Tk-Editor dazu beschreibt das Buch *tkutils*
(`tkulayoutcanvas`).

| Schlüssel | Bedeutung |
|---|---|
| `label` | Bezeichnung |
| `x`, `y`, `w`, `h` | Position und Größe in mm |
| `show` | `1` sichtbar, `0` verborgen |
| `lockedY` | `1`: senkrechte Lage automatisch |

### Seite und Maßstab

| Befehl | Rückgabe |
|---|---|
| `pageSize papier ?ausrichtung?` | `{breite höhe}` in mm |
| `mmToPx mm maßstab` | `mm * maßstab` |
| `pxToMm px maßstab` | `px / maßstab` |
| `snap mm ?-grid 5.0?` | auf das Raster gerundet |
| `fitScale seiteB seiteH sichtB sichtH ?-marginPx 20?` | größter Maßstab, mit dem die Seite samt Rand in die Sicht passt |

`pageSize` kennt `a4` (210 × 297), `a5` (148 × 210) und `letter`
(216 × 279), ohne Unterschied von Groß/Klein. Ein freies Maß in mm
steht als Liste `{breite höhe}` oder als `BxH` bzw. `BXH`, etwa `54x56`
oder `80.5X200`; beide Teile müssen positive Zahlen sein. `1.2.3x5`
ist ein `PAPER`-Fehler. Nur `landscape` tauscht Breite und Höhe; jede andere Angabe gilt als Hochformat. `fitScale` rechnet
`min((sichtB - 2*rand) / seiteB, (sichtH - 2*rand) / seiteH)`.

```tcl
package require tclutils::tulayout
::tclutils::tulayout::pageSize A4 landscape     ;# -> 297 210
::tclutils::tulayout::pageSize 54x56            ;# -> 54 56
::tclutils::tulayout::mmToPx 210 2              ;# -> 420.0
::tclutils::tulayout::snap 12.6                 ;# -> 15.0
::tclutils::tulayout::snap 7 -grid 2            ;# -> 8
::tclutils::tulayout::fitScale 210 297 800 600 -marginPx 0
                                       ;# -> 2.0202020202020203
```

### Blöcke

| Befehl | Wirkung |
|---|---|
| `defaultBlockKeys` | `x y w h show label lockedY` |
| `isAutoY block` | `1`, wenn `lockedY` wahr oder `y == 0` ist |
| `normalizeBlock block ?-defaults d?` | nur `label x y w h show lockedY`, fehlende aus `d`; `x y w h` als Gleitkommazahl, `show` als 0/1 |
| `validateBlocks blocks` | jeden Block normalisieren und prüfen; liefert das neue Dict |
| `ensureBlocks blocks definitionen` | Blöcke mit ihren Definitionen ergänzen, fehlende anlegen, alles prüfen |
| `blockOrder blocks ?definitionen?` | IDs: ohne Definitionen sortiert; mit erst deren Reihenfolge, dann die übrigen |
| `blockRect block ?-height h?` | `{x1 y1 x2 y2}` |
| `mergeBlocks basis vorlage ?-keys k?` | Schlüssel `k` aus der Vorlage in gleichnamige Blöcke der Basis übernehmen |
| `mergeLayout ziel vorlage ?-keys k?` | `mergeBlocks` auf `blocks` zweier Layouts |

Die Vorgabe für `-defaults` ist `x 0 y 0 w 40 h 8 show 1`, für `-keys`
`x y w show`. `mergeBlocks` übergeht Blöcke der Vorlage, die in der
Basis fehlen, und übernimmt Werte unverändert, ohne sie zu
normalisieren. `blockRect` nimmt die Höhe aus `-height`, sonst aus dem
Block, sonst 8.

```tcl
set blocks {
    kopf    {label Kopf x 20 y 30 w 170 h 15 show 1}
    tabelle {label Tabelle x 20 y 0 w 170 h 40 show 1}
}
::tclutils::tulayout::isAutoY [dict get $blocks tabelle]  ;# -> 1
::tclutils::tulayout::blockRect [dict get $blocks kopf]
                                    ;# -> 20.0 30.0 190.0 45.0
set m [::tclutils::tulayout::mergeBlocks $blocks {kopf {x 25 h 99}}]
dict get $m kopf x                                        ;# -> 25
dict get $m kopf h                                        ;# -> 15
::tclutils::tulayout::blockOrder $blocks     ;# -> kopf tabelle
```

`ensureBlocks` ergänzt jeden vorhandenen Block um die Schlüssel, die
ihm fehlen: zuerst aus seiner Definition, dann aus den Standardwerten
von `-defaults`. Ein Wert im Block geht der Definition vor. Eine ID,
die nur in den Definitionen steht, entsteht allein aus ihrer
Definition. `blocks` darf leer sein; dann kommt alles aus den
Definitionen. Das Ergebnis prüft `ensureBlocks` wie `validateBlocks`.

```tcl
set e [::tclutils::tulayout::ensureBlocks {kopf {x 20}} \
    {kopf {w 170 h 15} fuss {x 20 y 280 w 170 h 10}}]
dict get $e kopf          ;# -> x 20.0 y 0.0 w 170.0 h 15.0 show 1
dict get $e fuss                ;# -> x 20.0 y 280.0 w 170.0 h 10.0
::tclutils::tulayout::ensureBlocks {} {kopf {w 170 h 15}}
                                        ;# -> kopf {w 170.0 h 15.0}
```

| Fall | Code |
|---|---|
| unbekanntes Papier, Maß nicht lesbar oder nicht positiv | `{TCLUTILS TULAYOUT PAPER}` |
| Maßstab nicht positiv | `{TCLUTILS TULAYOUT SCALE}` |
| Raster nicht positiv | `{TCLUTILS TULAYOUT GRID}` |
| unbekannte Option, Option ohne Wert | `{TCLUTILS TULAYOUT OPTION}` |
| `validateBlocks`: `blocks` leer oder kein Dict; `ensureBlocks`: `blocks`, Definitionen oder ein Block kein Dict | `{TCLUTILS TULAYOUT BLOCKS}` |
| leere Block-ID | `{TCLUTILS TULAYOUT BLOCKID}` |
| `x`, `y`, `w`, `h` keine Zahl oder negativ, `show` nicht boolesch | `{TCLUTILS TULAYOUT VALUE}` |
| Layout ohne `blocks` | `{TCLUTILS TULAYOUT LAYOUT}` |
| Sicht abzüglich zweimal Rand nicht positiv | `{TCLUTILS TULAYOUT VIEWPORT}` |

Die Meldung bei `VALUE` nennt Block und Schlüssel, etwa
`block 'kopf': bad x 'abc'` oder `block 'kopf': height must be >= 0`.
Optionen prüfen `snap`, `normalizeBlock`, `blockRect`, `mergeBlocks`,
`mergeLayout` und `fitScale` gleich: Erlaubt ist nur die jeweils
genannte Option.

---

*Nächstes Kapitel: [Netz und HTTPS](070-netz-und-https.md)*
