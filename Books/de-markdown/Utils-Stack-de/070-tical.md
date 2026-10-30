# Kalender: tical

## Was tical ist

[tical]{.index} 1.1.1 ist eine Kalender- und iCalendar-Engine in reinem
Tcl, mit eigenem Repository neben tclutils, tkutils und ctrlutils. Sie
trennt drei Schichten:

```
tical::core        Kalenderdaten eines Monats (Tage, ISO-Wochen, heute)
tical::view::*     ViewSpec: Raster für Monat, Woche oder Tag
tical::render::*   Ausgabe: Text, Tk-Canvas, PDF
```

Ein [ViewSpec]{.index} ist ein Dict mit einem Raster aus Zellen; jeder
Renderer zeichnet jeden ViewSpec seines Typs. Termine haben ein
gemeinsames Format (`tical::event`); die Views verteilen sie auf die
Zellen. Dazu kommen Feiertage (`tical::holidays`), iCalendar-Export
(`tical::io::ical`) und -Import (`tical::io::import`), ein Terminmodell
im Speicher (`tical::model`) und ein SQLite-Adapter
(`tical::adapter::sqlite`).

Der Kern braucht kein Tk und läuft unter Tcl 8.6 und 9. Vier Schichten
sind optional und brauchen je ein Fremdpaket:

| Paket | braucht |
|---|---|
| `tical::render::canvas` | Tk |
| `tical::render::pdf` | `pdf4tcl` |
| `tical::adapter::sqlite` | `tdbc::sqlite3` |
| `tical::io::import` | tclutils: `tclutils::tuical` |

Das Sammelpaket `tical` lädt alles andere: `core`, `util`, `config`,
`locale`, `term`, `holidays`, `holidays::de`, `event`, `model`,
`io::ical`, die drei Views und `render::term`. Die vier optionalen Pakete
lädt die Anwendung einzeln.

---

## Laden

tical bringt ein `pkgIndex.tcl` im Wurzelordner mit; es lädt jede Datei
mit `source -encoding utf-8`, auch unter Tcl 8.6 mit cp1252. Die Dateien heißen
zwar `*.tm`, liegen aber in Unterordnern (`core/`, `views/`, `render/`
…) und werden über `auto_path` gefunden, nicht über den
[Modulpfad]{.index}:

```tcl
lappend auto_path /pfad/zu/tical
package require tical                    ;# -> 1.1
package require tical::render::canvas    ;# nur mit Tk
```

`tical::io::import` findet tclutils über den Modulpfad, wie jede
Anwendung des Stacks:

```tcl
tcl::tm::path add /pfad/zu/tclutils/lib/tm
package require tical::io::import        ;# -> 1.1
```

Mit `tcl::tm::path add /pfad/zu/tical` findet Tcl nur die Datei des
Sammelpakets; danach endet `package require tical` mit
`can't find package tical::util 1.0`. Statt `lappend auto_path` geht auch
`TCLLIBPATH` oder ein Ordner, der schon im `auto_path` steht (Kapitel
[Pairing und Setup](020-pairing-und-setup.md)).

tkutils sucht tical für seine Kalender-Widgets an zwei Stellen: in
`TICAL_DIR` und, ohne diese Variable, in Geschwisterordnern `tical*`
neben dem tkutils-Checkout. So machen es die Tests und
`bin/tkutical.tcl`. Eine eigene Anwendung ergänzt `auto_path` selbst.

---

## Verhältnis zu tclutils und tkutils

tclutils und ctrlutils laden tical nie. tkutils lädt es nur in zwei
optionalen Widgets, die nicht im Sammelpaket `tkutils` stehen. Für viele
Kalenderaufgaben gibt es in tclutils oder tkutils ein eigenes Modul ohne
tical:

| Aufgabe | tclutils | tkutils | tical |
|---|---|---|---|
| Monat als Text | `tucal` (wie `cal`) | `tkucal` (zeigt `tucal`) | `render::term` |
| Monat als Bild oder PDF | `tumonthpng` (PNG) | — | `render::pdf` (PDF) |
| Kalender-Widget | — | `tkucalendar`, `tkudateentry` (nur Tk und `clock`); `tkutical`, `tkumonthcanvas` (auf tical) | `render::canvas` |
| Feiertage | `tuholiday` | — | `holidays`, `holidays::de` |
| Wiederholregeln expandieren | `turrule` | — | `event::expand` (eigener Code, dieselben Termine) |
| iCalendar lesen | `tuical::parse` | `tkuical` (Tabelle) | `io::import::parse` (über `tuical`) |
| iCalendar schreiben | `tuical::toIcs` | — | `io::ical::exportEvents` |

Die beiden tkutils-Widgets auf tical:

- `tkutils::tkutical` 0.4: Monats- oder Wochenansicht mit Navigation,
  Wochennummern und Tagesauswahl; zeichnet über
  `tical::render::canvas`; Termine mit `-events` (seit 0.4, braucht
  tical 1.1), Serien an jedem ihrer Tage.
- `tkutils::tkumonthcanvas` 0.5: Monat, Quartal oder Jahr auf einem
  eigenen Canvas mit Themes und Notizen; nimmt Datum, Namen und
  Feiertage aus `tical::config`, `tical::locale`, `tical::holidays` und
  `tical::view::month`. Die Feiertagsregion leitet es aus der Locale ab
  (`de_DE` → `DE`).

Feiertage: [tuholiday]{.index} aus tclutils liefert die bundesweiten
Tage einschließlich Oster- und Pfingstsonntag (11 im Jahr 2026),
`tical::holidays::de` die neun gesetzlichen Tage ohne die beiden
Sonntage; mit `-sundays 1` dieselbe Liste wie `tuholiday` (siehe
„Feiertage“). Beide rechnen Ostern selbst. Länderfeiertage kennt keines.

[turrule]{.index} expandiert eine RRULE in Termine, [tuical]{.index}
liest iCalendar-Text. tical hat keinen eigenen Leser: `tical::io::import`
ruft `tuical` auf und liefert Termine im Format von `tical::event`
(Abschnitt [Import](#import)). Serien rechnet tical seit 1.1.1 selbst
aus (`tical::event::expand`), damit die Views sie auch ohne tclutils
zeigen; ein Test vergleicht das Ergebnis mit `turrule`.

---

## Views

Alle Views liefern einen ViewSpec. Fehlende Optionen kommen aus
`tical::config`:

```tcl
tical::config::getDefaults
;# -> firstweek iso locale de_DE today {} weekstart mon theme default timezone Europe/Berlin
```

`tical::config::set` prüft seit 1.0.2 Schlüssel und Wert: ein Tippfehler
wie `weekStart` endet mit Errorcode `TICAL CONFIG KEY`, eine Zone, die
Tcl nicht kennt, eine Locale außer Deutsch, Englisch, Französisch oder
`weekstart sonntag` mit `TICAL CONFIG VALUE`; der alte Wert bleibt.
`today` (`YYYY-MM-DD`, leer: das echte Datum) legt fest, welcher Tag als
heute markiert wird, etwa für gleichbleibende Ausgaben.

| View | `type` | Optionen | Zellen |
|---|---|---|---|
| `tical::view::month::getData` | `month-grid` | `-year`, `-month` (Pflicht), `-tz`, `-weekStart mon\|sun`, `-firstWeek iso\|simple\|us`, `-showAdjacentDays 0\|1` (1), `-holidays REGION`, `-count N` (1), `-events LISTE` | 42 (6 × 7) |
| `tical::view::week::getData` | `week-grid` | `-year` und `-week` oder `-date`, `-tz`, `-holidays`, `-events` | 7 |
| `tical::view::day::getData` | `day-grid` | `-date` (Pflicht), `-hourStart` (0), `-hourEnd` (23), `-tz`, `-holidays`, `-events` | eine je Stunde |

`-date` nimmt `2025-10-14` und `20251014`. Seit 1.1.1 prüfen die Views
auch die Werte: `-month` 1 bis 12, `-week` 1 bis 52 oder 53 (die
ISO-Wochen des Jahres; vorher rutschte `-week 60` still ins nächste
Jahr), ein gültiges `-date`, `-hourStart` nicht nach `-hourEnd`. Ein
falscher Wert endet mit Errorcode `TICAL VIEW OPTION`, nicht mehr mit
einem `CLOCK …`-Fehler.

Eine unbekannte Option oder eine Option ohne Wert ist ein Fehler mit
Errorcode `TICAL VIEW OPTION`; die Meldung nennt die bekannten Optionen.
Bis 1.0.1 überging die View solche Optionen still, ein Tippfehler wie
`-weekstart` blieb ohne Wirkung:

```tcl
tical::view::month::getData -year 2025 -month 10 -weekstart sun
;# Fehler: view::month::getData: unknown option "-weekstart", must be -count,
;#   -events, -firstWeek, -holidays, -month, -showAdjacentDays, -tz,
;#   -weekStart or -year
```

Der Wochenstart ist eine Option der View, nicht der Renderer: Mit
`-weekStart sun` (auch `sunday`) beginnt das Raster am Sonntag, und alle
Renderer beschriften ihre Spalten nach den Zellen. Die Wochenansicht
läuft immer von Montag bis Sonntag (ISO-Woche).

`-firstWeek` legt die Wochennummer der Zellen fest: `iso` (Vorgabe,
ISO 8601: Woche 1 enthält den ersten Donnerstag), `simple` (Woche 1 sind
der 1. bis 7. Januar) oder `us` (Wochen ab Sonntag, Woche 1 enthält den
1. Januar). Der 1. Januar 2023 war ein Sonntag:

```tcl
lmap fw {iso simple us} {
    set m [tical::view::month::getData -year 2023 -month 1 \
        -weekStart sun -firstWeek $fw]
    dict get [lindex [dict get $m cells] 0] week
}
;# -> 52 01 01
```

Die Renderer zeigen je Rasterzeile die Woche der mittleren Zelle; so
nennt auch ein Sonntagsraster mit ISO-Wochen die Woche, zu der sechs der
sieben Tage gehören.

Eine Zelle ist ein Dict mit `date`, `dow` (1 = Montag), `week`,
`markers` und `events`; im Monat dazu `inMonth`, in der Tagesansicht
`hour` und `time`. `markers` enthält `today` und `holiday`, `events` die
Termine (Abschnitt [Termine](#termine)). Mit
`-showAdjacentDays 0` sind die Zellen vor und nach dem Monat leer
(`date {}`).

```tcl
set s [tical::view::month::getData -year 2025 -month 10 -holidays DE]
dict keys $s
;# -> type month year cols rows weekStart firstWeek cells legend grid
llength [dict get $s cells]                   ;# -> 42
set w [tical::view::week::getData -date 2025-10-14]
dict get $w week                              ;# -> 42
set d [tical::view::day::getData -date 2025-10-03 \
    -hourStart 8 -hourEnd 17 -holidays DE]
dict get $d rows                              ;# -> 10
dict get [lindex [dict get $d cells] 0] markers  ;# -> holiday
```

`-date` in der Wochenansicht rechnet mit dem ISO-Jahr: Der 30.12.2024
liegt in Woche 1 von 2025.

```tcl
set w [tical::view::week::getData -date 2024-12-30]
list [dict get $w year] [dict get $w week]    ;# -> 2025 1
```

Die Region bei `-holidays` ist der Schlüssel, unter dem das
Feiertags-Plugin registriert ist, etwa `DE`; Groß- und Kleinschreibung
zählen nicht (`de` wirkt wie `DE`). Eine unbekannte Region markiert
keinen Tag; einen Fehler gibt es nicht.

`-count N` mit N > 1 liefert statt eines ViewSpecs eine Liste von N
aufeinanderfolgenden Monaten ab `-year`/`-month`, auch über den
Jahreswechsel. `-count 1` (Vorgabe) liefert einen ViewSpec wie ohne die
Option; kleinere Werte enden mit
`view::month::getData: -count must be an integer >= 1, got "0"`.

```tcl
set q [tical::view::month::getData -year 2025 -month 11 -count 3]
llength $q                                    ;# -> 3
lmap m $q {dict get $m month}                 ;# -> 11 12 1
```

Die Liste geht so, wie sie ist, an `render::pdf::createQuarter` oder
`createYear`.

`validate` prüft in jeder View die Pflichtfelder und den `type`.

---

## Termine

Ein Termin ist in ganz tical dasselbe Dict, angelehnt an iCalendar
([tical::event]{.index}):

| Schlüssel | Bedeutung |
|---|---|
| `summary` | Titel (Pflicht, darf leer sein) |
| `dtstart` | Beginn (Pflicht): `YYYYMMDD` ganztägig, `YYYYMMDDTHHMMSS` lokal, `YYYYMMDDTHHMMSSZ` UTC |
| `dtend` | Ende (optional), von derselben Art; ganztägig exklusiv, also der Tag nach dem letzten Tag |
| `allday` | `0` oder `1`; folgt `dtstart` |
| `uid`, `description`, `location`, `status`, `categories`, `rrule`, `exdate` | optional |

`tical::event::normalize` bringt einen Termin in diese Form und prüft
ihn. Es nimmt auch ISO-Angaben (`2025-10-14`, `2025-10-14T09:00`) und
für eine Version (1.1) die älteren Feldnamen: `title`, `date`,
`startTime`, `endTime` aus `tical::model`, `starts_at` und `ends_at` aus
`tical::adapter::sqlite`.

```tcl
tical::event::normalize {summary Teamrunde dtstart 2025-10-14T09:00 dtend 2025-10-14T10:00}
;# -> summary Teamrunde dtstart 20251014T090000 dtend 20251014T100000 allday 0
tical::event::normalize {summary Messe dtstart 2025-10-20 dtend 2025-10-23}
;# -> summary Messe dtstart 20251020 dtend 20251023 allday 1
tical::event::normalize {title Zahnarzt date 2025-10-14 startTime 09:00}
;# -> summary Zahnarzt dtstart 20251014T090000 allday 0
tical::event::days {summary Messe dtstart 20251020 dtend 20251023 allday 1}
;# -> 2025-10-20 2025-10-21 2025-10-22
```

Die Messe dauert drei Tage: `dtend` 20251023 ist exklusiv. Ein Ende vor
dem Beginn endet mit
`dtend "20251014T090000" is before dtstart "20251014T100000"`
(Errorcode `TICAL EVENT RANGE`).

`-events LISTE` gibt einer View die Termine. Sie legt jeden Termin in
das `events` jeder Zelle, die er berührt, auch in Nachbartage des
Monats. Ein Eintrag ist der Termin plus `part` (`single`, `start`,
`middle`, `end`) und `time` (Beginn `HH:MM` am ersten Tag, sonst leer);
ganztägige Termine stehen vor den anderen. Eine Serie (`rrule`) steht an
jedem ihrer Tage, mit `recurrence-id`; bis 1.1 stand sie nur am ersten.
`tical::event::expand termine von bis ?tz?` liefert die Vorkommen auch
direkt. Es kennt `FREQ` (täglich bis jährlich), `INTERVAL`, `COUNT`,
`UNTIL`, `BYDAY` (auch `1MO`, `-1FR`), `BYMONTH`, `BYMONTHDAY` und
`WKST`, beachtet `EXDATE` und Ausnahmen mit `RECURRENCE-ID`.

```tcl
set termine {
    {summary Teamrunde dtstart 2025-10-14T09:00 dtend 2025-10-14T10:00}
    {summary Messe dtstart 2025-10-20 dtend 2025-10-23}
}
set s [tical::view::month::getData -year 2025 -month 10 -events $termine]
set r {}
foreach c [dict get $s cells] {
    foreach e [dict get $c events] {
        lappend r [list [dict get $c date] [dict get $e summary] \
            [dict get $e part] [dict get $e time]]
    }
}
set r
;# -> {2025-10-14 Teamrunde single 09:00} {2025-10-20 Messe start {}}
;#    {2025-10-21 Messe middle {}} {2025-10-22 Messe end {}}
```

Die Tagesansicht hat zusätzlich einen Schlüssel `events` mit allen
Terminen des Tages; ihre Stundenzellen enthalten die Termine mit
Uhrzeit, die in dieser Stunde laufen:

```tcl
set t [tical::view::day::getData -date 2025-10-14 \
    -hourStart 8 -hourEnd 10 -events $termine]
lmap c [dict get $t cells] {lmap e [dict get $c events] {dict get $e summary}}
;# -> {} Teamrunde {}
```

Ein Termin mit `Z` wird in die Zeitzone der View (`-tz`) umgerechnet;
ein Termin ohne `Z` gilt dort als lokale Zeit.

---

## Renderer

### Text: render::term

```tcl
tical::render::term::print $viewSpec ?-weekNumbers 0|1? ?-color 0|1? ?-weekStart mon|sun?
```

Gibt den Monat als Text zurück, sechs Zeilen zu sieben Tagen; Tage aus
dem Nachbarmonat stehen als `..`. Woche und Tag gibt es seit 1.1.1 als
Liste (siehe unten); ein anderer Typ endet mit
`render::term::print: expected type month-grid, week-grid or day-grid, got "year-grid"`.
Jede Spalte ist vier Zeichen breit, auch die Wochenspalte und die
Kopfzeile; die Zahlen stehen rechtsbündig untereinander.

Die Zellen, jeweils vier Zeichen zwischen den Anführungszeichen:

```
" 17 "          Tag
"(18)"  " (3)"  Feiertag der View (-holidays DE)
"[17]"  " [3]"  heute, nur mit -color 1; heute geht vor Feiertag
" 17*"          Tag mit Termin (events der Zelle)
"[17*"  "(18*"  heute oder Feiertag mit Termin
" .. "          Tag aus dem Nachbarmonat
```

Bis 1.0.1 stand ein Feiertag als `+18`, heute als `*17`; `+18` las sich
wie eine Rechnung.

Monats- und Tagesnamen kommen aus [tical::locale]{.index} und folgen
`tical::config::set locale …`; mit der Vorgabe `de_DE` heißt die
Kopfzeile `Oktober 2025`, die Spaltenköpfe sind `Mo Di Mi Do Fr Sa So`
(mit `-weekNumbers 1` davor `KW`). Nach `tical::config::set locale en_US`
steht dort `October 2025` und `Wk Mo Tu We Th Fr Sa Su`.

Die Spaltenfolge kommt aus den Zellen der View. `-weekStart` nimmt
`render::term` nur als Prüfung an: Stimmt der Wert mit der View überein,
bleibt die Ausgabe gleich; widerspricht er, endet der Aufruf mit
Errorcode `TICAL RENDER WEEKSTART`. Code, der den passenden Wert
übergibt, läuft so weiter. Unbekannte Optionen enden mit
`render::term::print: unknown option "-colour", must be -color, -weekNumbers or -weekStart`.

```tcl
set so [tical::view::month::getData -year 2025 -month 10 \
    -weekStart sun -holidays DE]
puts [tical::render::term::print $so]
string equal [tical::render::term::print $so -weekStart sun] \
    [tical::render::term::print $so]          ;# -> 1
tical::render::term::print $so -weekStart mon
;# Fehler: render::term::print: -weekStart mon contradicts the view (starts on
;#   sun): week start comes from the view; use getData ... -weekStart mon
```

```
 Oktober 2025
 So  Mo  Di  Mi  Do  Fr  Sa
 ..  ..  ..   1   2  (3)  4
  5   6   7   8   9  10  11
 12  13  14  15  16  17  18
 19  20  21  22  23  24  25
 26  27  28  29  30  31  ..
 ..  ..  ..  ..  ..  ..  ..
```

Dieselben Namen liefert `tical::locale` direkt:

```tcl
tical::locale::getMonthName 10                ;# -> Oktober
tical::locale::getWeekdaysShort               ;# -> Mo Di Mi Do Fr Sa So
tical::locale::getWeekdaysShort 7             ;# -> So Mo Di Mi Do Fr Sa
tical::locale::getWeekLabel short             ;# -> KW
```

`tical::locale` kennt `de`, `en` und `fr` und folgt
`tical::config::set locale …`. Das optionale Argument der
Wochentagslisten ist der erste Tag (1 = Montag … 7 = Sonntag);
`getWeekLabel` liefert `KW`, `Week` oder `Semaine`, mit `short` `KW`,
`Wk` oder `Sem`.


Woche und Tag als Liste. Die Woche hat eine Zeile je Tag, die Termine
stehen hinter dem Tag, einer je Zeile: `HH:MM Titel` mit Uhrzeit,
ganztägige ohne, `.. Titel` für einen Termin, der an einem früheren Tag
begonnen hat. Ein Feiertag steht in runden Klammern, heute (mit
`-color 1`) in eckigen.

```tcl
set termine {
    {summary Zahnarzt dtstart 2025-10-13T09:00 dtend 2025-10-13T10:00}
    {summary Training dtstart 2025-10-13T18:00 dtend 2025-10-13T19:30}
    {summary Nacht dtstart 2025-10-14T22:00 dtend 2025-10-15T02:00}
    {summary Urlaub dtstart 2025-10-16 dtend 2025-10-18}
}
puts [tical::render::term::print \
    [tical::view::week::getData -date 2025-10-14 -events $termine]]
```

```
 KW 42 2025
 Mo 13 Okt   09:00 Zahnarzt
             18:00 Training
 Di 14 Okt   22:00 Nacht
 Mi 15 Okt   .. Nacht
 Do 16 Okt   Urlaub
 Fr 17 Okt   .. Urlaub
 Sa 18 Okt
 So 19 Okt
```

Der Tag hat eine Zeile je Stunde der View; ganztägige Termine stehen
unter dem Titel, ein Termin, der vor der ersten Stunde begann, in der
ersten Zeile mit `..`:

```tcl
puts [tical::render::term::print [tical::view::day::getData \
    -date 2025-10-15 -hourStart 0 -hourEnd 2 -events $termine]]
```

```
 Mi 15 Okt 2025
00:00 | .. Nacht
01:00 |
02:00 |
```

`-weekNumbers` wirkt nur im Monat (die Woche nennt ihre Nummer im
Titel), `-weekStart` prüft Monat und Woche; die Woche beginnt immer am
Montag.

### Tk: render::canvas

```tcl
tical::render::canvas::draw $canvas $viewSpec ?-interactive 0|1? ?-fontsize 12? ?-weekNumbers 0|1?
```

Zeichnet Monat, Woche oder Tag auf einen vorhandenen Canvas: heute gelb,
Feiertage rot, Wochenende blau, Nachbartage grau. Termine der Zellen
erscheinen im Monat als bis zu drei Punkte unter der Zahl, in Woche und
Tag als Titel mit Uhrzeit (Tag `event`); die Spalten der Woche werden
dafür breiter. Unbekannte Optionen enden mit Errorcode
`TICAL RENDER OPTION`. Monatsname,
Wochentage und der Titel der Wochenansicht (`KW 42, 2025`) kommen aus
`tical::locale`, die Spaltenfolge aus der View. Mit `-interactive 1`
reagieren die Tage in Monat und Woche auf Maus und Klick; die
Tagesansicht hat keine Bindungen. Die Auswahl gilt je Canvas:

| Aufruf | Wirkung |
|---|---|
| `setSelectMode $c none\|single\|multiple` | Auswahlart; Vorgabe `none` |
| `getSelection $c` | sortierte ISO-Daten |
| `setSelection $c {daten}` | Einzeldaten und Bereiche `A..B` |
| `clearSelection $c` | leert die Auswahl |
| `setSelectionCommand $c cmd` | `cmd $c $auswahl` nach jeder Änderung |
| `setCallback ?$c? cmd` | nur bei `none`: `cmd $c $datum` beim Klick; ohne `$c` für alle Canvas, mit `$c` nur für diesen (geht vor) |

Bei `multiple` schaltet ein Klick den Tag um, ein Klick mit Umschalt
wählt den Bereich vom zuletzt geklickten Tag bis hier.

```tcl
canvas .c -width 400 -height 350 -bg white
pack .c
tical::render::canvas::draw .c $s -interactive 1 -weekNumbers 1
tical::render::canvas::setSelectMode .c multiple
tical::render::canvas::setSelection .c {2025-10-06..2025-10-08 2025-10-20}
;# -> 2025-10-06 2025-10-07 2025-10-08 2025-10-20
```

`setCallback` nimmt ein Kommandopräfix, davor wahlweise den Canvas:
`setCallback [list apply {{c datum} {puts $datum}}]` gilt für alle,
`setCallback .c …` seit 1.1.1 nur für `.c`. Die Form mit Parameterliste
und Rumpf als zwei Argumente endet mit Errorcode `TICAL RENDER ARGS`
(`"c datum" is not a widget path`).

### PDF: render::pdf

```tcl
tical::render::pdf::create        datei $viewSpec ?optionen?
tical::render::pdf::createQuarter datei {spec spec spec} ?optionen?
tical::render::pdf::createYear    datei {12 specs} ?optionen?
tical::render::pdf::drawMonth|drawWeek|drawDay $pdf $viewSpec ?optionen?
```

`create` schreibt eine Seite mit Monat, Woche oder Tag. `createQuarter`
setzt drei Monate nebeneinander, `createYear` zwölf in ein Raster 4 × 3,
beide im Querformat. Optionen mit oder ohne Bindestrich: `paper` (`a4`,
`a3`, `a5`, `letter`, in beliebiger Schreibung), `orientation`
(`portrait`, bei Quartal und Jahr `landscape`), `fontsize` (10),
`margin` (20), `weekNumbers` (1), `showGrid` (1) und die Farben
`colorToday`, `colorHoliday`, `colorWeekend`, `colorEvent`,
`colorEventText`. Andere Namen und Werte enden mit Errorcode
`TICAL RENDER OPTION`; bis 1.0.1 wurde aus `-paper Letter` still A4.
`draw…` zeichnet in ein schon offenes `pdf4tcl`-Objekt. Rückgabe ist der
Dateiname. Namen und Spaltenfolge wie bei `render::canvas`.

Termine der Zellen färben den Tag und stehen als Titel unter der Zahl,
so viele, wie in die Zelle passen (die letzte Zeile dann `+N`); in den
kleinen Blöcken von Quartal und Jahr bleibt ein Punkt. Die Option
`events` aus 1.0.1 (Liste von Daten, die nur eingefärbt werden) nimmt
1.1 noch an; sie entfällt mit 1.2.

```tcl
package require tical::render::pdf
set specs [tical::view::month::getData -year 2025 -month 10 \
    -count 3 -holidays DE -events $termine]
tical::render::pdf::createQuarter q4.pdf $specs   ;# -> q4.pdf
tical::render::pdf::create okt.pdf [lindex $specs 0] -paper Letter
;# -> okt.pdf
```

---

## Feiertage

`tical::holidays` verwaltet Plugins je Region. Ein Plugin ist ein
Befehl, der für ein Jahr ein Dict `ISO-Datum → Name` liefert;
`tical::holidays::de` registriert sich beim Laden als `DE`, mit den neun
bundesweiten Feiertagen. `getHolidays -sundays 1 jahr` nimmt Oster- und
Pfingstsonntag dazu und liefert dann dieselbe Liste wie
`tclutils::tuholiday::holidays`. Für die Views registriert man das als
Region, unter `DE` oder einem eigenen Namen:

```tcl
tical::holidays::register DE {::tical::holidays::de::getHolidays -sundays 1}
tical::holidays::getHolidays DE 2026 4
;# -> 3 Karfreitag 5 Ostersonntag 6 Ostermontag
```

Weil ein Plugin nur ein Befehlspräfix ist, das am Ende das Jahr bekommt,
passt auch `tuholiday` direkt:
`tical::holidays::register DE ::tclutils::tuholiday::holidays`.

```tcl
tical::holidays::getHolidays DE 2026 4      ;# -> 3 Karfreitag 6 Ostermontag
tical::holidays::register AT ::meineapp::feiertageAT
```

`getHolidays` liefert für einen Monat ein Dict `Tag → Name`;
`getMarkers` dasselbe als Markerliste. Eine unbekannte Region ergibt ein
leeres Dict.

---

## iCalendar

`tical::io::ical` schreibt Termine nach RFC 5545: VCALENDAR mit VEVENT,
Zeilen mit CRLF, Zeilen über 75 Byte (UTF-8) gefaltet. Ein Termin ist ein Dict mit
`uid`, `dtstart`, `summary` (Pflicht), dazu wahlweise `dtend` oder
`duration`, `description`, `location`, `status`, `categories`, `rrule`
und `exdate`. Zeiten stehen in der Form `YYYYMMDDTHHMMSSZ` (UTC);
ohne `Z` schreibt `io::ical` sie unverändert, sie gelten dann als
lokale Zeit. `exportEvents` schickt jeden Termin vorher durch
`tical::event::normalize`; ISO-Angaben und die älteren Feldnamen gehen
also auch, eine fehlende `uid` wird erzeugt. Ein Termin mit
`recurrence-id` (eine verschobene Instanz einer Serie) bekommt
`RECURRENCE-ID`, mit `TZID` wie `DTSTART`; seit 1.1.1 kommt er beim
Wiedereinlesen als Ausnahme zurück, nicht als zweiter Termin.
`makeEvent` ergänzt `uid` und `dtstamp`:

```tcl
set ev [tical::io::ical::makeEvent -uid team-1@example.org \
    -dtstart 20251014T090000Z -dtend 20251014T100000Z \
    -summary "Teamrunde" -rrule {freq WEEKLY count 4}]
set ics [tical::io::ical::exportEvents [list $ev]]
```

Ergebnis ohne die Zeile `DTSTAMP` (die Uhrzeit des Exports):

```
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//tical//tical 1.1.1//EN
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VEVENT
UID:team-1@example.org
DTSTART:20251014T090000Z
DTEND:20251014T100000Z
SUMMARY:Teamrunde
RRULE:FREQ=WEEKLY;COUNT=4
END:VEVENT
END:VCALENDAR
```

`rrule` ist ein Dict mit `freq` (`DAILY`, `WEEKLY`, `MONTHLY`,
`YEARLY`), `count` oder `until`, `interval`, `byday`, `bymonth`,
`bymonthday` und `wkst`, oder eine RRULE-Zeichenkette
(`FREQ=WEEKLY;COUNT=4`). Andere Frequenzen enden mit
`FREQ must be DAILY|WEEKLY|MONTHLY|YEARLY, got "HOURLY"`.
`exportToFile $events datei` schreibt dasselbe in eine Datei (UTF-8,
Zeilenende CRLF; bis 1.0 stand dort `\r\r\n`).

### Ganztägige Termine

Ein Datum ohne Uhrzeit (`20251020` oder `2025-10-20`) ist ein
ganztägiger Termin. `io::ical` schreibt ihn mit `VALUE=DATE`; `DTEND` ist
wie in iCalendar exklusiv. Bis 1.0.1 schrieb es ein Datum ohne
`VALUE=DATE`, was RFC 5545 nicht erlaubt.

```tcl
set ganz [tical::io::ical::makeEvent -uid messe-1@example.org \
    -summary Messe -dtstart 2025-10-20 -dtend 2025-10-23]
set ics2 [tical::io::ical::exportEvents [list $ganz]]
```

Der VEVENT ohne `DTSTAMP`, eine Messe vom 20. bis 22. Oktober:

```
BEGIN:VEVENT
UID:messe-1@example.org
DTSTART;VALUE=DATE:20251020
DTEND;VALUE=DATE:20251023
SUMMARY:Messe
END:VEVENT
```

`validate` prüft die Pflichtfelder, das Format von `dtstart` und `dtend`
(`YYYYMMDD`, `YYYYMMDDTHHMMSS` oder `YYYYMMDDTHHMMSSZ`, beide von
derselben Art, das Ende nicht vor dem Beginn) und die `rrule`.
`exportEvents` ruft es nicht selbst auf. ISO-Angaben lehnt `validate` ab;
es prüft, was so geschrieben würde:

```tcl
tical::io::ical::validate $ev                 ;# -> 1
tical::io::ical::validate {uid u1 dtstart 20251014 dtend 20251015 summary S}
;# -> 1
tical::io::ical::validate {uid u1 dtstart 2025-10-14 summary S}
;# Fehler: dtstart format invalid: "2025-10-14" (expected YYYYMMDD,
;#   YYYYMMDDTHHMMSS or YYYYMMDDTHHMMSSZ)
```

---

## Import

[tical::io::import]{.index} liest iCalendar-Text und expandiert
Wiederholungen. Es ist optional und braucht tclutils: `tuical` zerlegt
den Text; die RRULE rechnet `tical::event::expand` aus. Ohne tclutils endet
`package require tical::io::import` mit
`can't find package tclutils::tuical 0.1`; der Rest von tical lädt
weiter.

| Aufruf | Ergebnis |
|---|---|
| `parse $ics` | Liste von Terminen im Format von `tical::event` |
| `readFile datei` | dasselbe aus einer Datei (UTF-8) |
| `expand $termine von bis ?tz?` | Vorkommen, die die Tage `von` bis `bis` berühren, nach Beginn sortiert |
| `eventsInRange $ics von bis ?tz?` | `expand [parse $ics] von bis` |

`parse` liest `UID`, `SUMMARY`, `DESCRIPTION`, `LOCATION`, `STATUS`,
`CATEGORIES`, `DTSTART` und `DTEND` (mit `VALUE=DATE` ganztägig),
`DURATION` (wenn `DTEND` fehlt), `RRULE`, `EXDATE` und `RECURRENCE-ID`.
`TZID` bleibt als Schlüssel `tzid` stehen, mit der Uhrzeit dieser Zone;
`tical::event` und die Views rechnen sie in die Anzeigezone um (`-tz`,
sonst `tical::config`). Eine Serie wird in ihrer eigenen Zone expandiert:
09:00 in New York bleibt 09:00 dort, in Berlin ist das in den Tagen
zwischen den beiden Umstellungen 14:00 statt 15:00. Verstanden werden
IANA-Namen, Präfix-IDs wie `/mozilla.org/…/Europe/Berlin` und gängige
Windows-Namen wie `W. Europe Standard Time`; `tical::event::tzid name`
liefert die Tcl-Zone oder `""`. Eine TZID, die Tcl nicht kennt (eigene
`VTIMEZONE`), lässt die Uhrzeit als lokale Zeit stehen. Der Export
schreibt `DTSTART;TZID=Europe/Berlin:…` zurück, ohne `VTIMEZONE`.
`expand` lässt Tage aus `EXDATE` weg und
ersetzt ein Vorkommen, für das ein VEVENT mit derselben `UID` und
passender `RECURRENCE-ID` existiert; hat dieser `STATUS:CANCELLED` (so
löschen Google und Outlook einen einzelnen Termin einer Serie), fällt
das Vorkommen weg. `EXDATE;VALUE=DATE` streicht bei einer Serie mit
Uhrzeit den ganzen Tag. Jedes Vorkommen trägt
`recurrence-id`, aber kein `rrule` mehr.

Der Export von oben, wieder gelesen:

```tcl
package require tical::io::import
set evs [tical::io::import::parse $ics]
llength $evs                                  ;# -> 1
lmap e [tical::io::import::expand $evs 2025-10-01 2025-12-31] {
    dict get $e dtstart
}
;# -> 20251014T090000Z 20251021T090000Z 20251028T090000Z 20251104T090000Z
set back [lindex [tical::io::import::parse $ics2] 0]
list [dict get $back dtstart] [dict get $back dtend] [dict get $back allday]
;# -> 20251020 20251023 1
```

Das Ergebnis von `expand` geht unverändert an `getData … -events`. Eine
RRULE mit Teilen, die tical nicht kennt (`BYSETPOS`, `BYWEEKNO`,
`BYHOUR` …), endet mit Errorcode `TICAL IMPORT RRULE` statt mit zu
vielen Terminen.

---

## Modell und SQLite

`tical::model` hält Termine (`createAppointment -summary -dtstart
?-dtend? …`) und Ereignisse (`createEvent -summary -dtstart …`) im
Speicher, mit `get…`, `update…`, `delete…`, `list…`,
`getAppointmentsByDate` und `toEvents`. Die Datensätze haben die Felder
von `tical::event`, dazu `id`, `type` und `created`. Für eine Version
(1.1) nimmt das Modell noch die alten Optionen `-title`, `-date`,
`-startTime`, `-endTime`, `-allDay`, `-category` an, und jeder Datensatz
enthält noch die gleichnamigen Felder; mit 1.2 fallen sie weg.
`-tzid` gibt die Zone lokaler Zeiten an (seit 1.1.1, vorher eine
unbekannte Option); der Datensatz und `toEvents` behalten sie.

```tcl
tical::model::createAppointment -summary Zahnarzt \
    -dtstart 2025-10-14T09:00 -dtend 2025-10-14T09:30  ;# -> appt-1
dict keys [tical::model::getAppointmentsByDate 2025-10-14]   ;# -> appt-1
tical::model::createAppointment -title Kontrolle -date 2025-10-15 \
    -startTime 10:00                                    ;# -> appt-2
dict get [tical::model::getAppointment appt-2] dtstart  ;# -> 20251015T100000
```

`toEvents` liefert alle Datensätze als Termine (`uid` = Kennung), fertig
für `getData … -events`.

`tical::adapter::sqlite` speichert Termine über `tdbc::sqlite3` in
einer Tabelle `events`: `connect`, `create`, `read`, `update`, `delete`,
`exists`, `listRange`, `listAll`, `disconnect`. `create` und `update`
nehmen das Format von `tical::event` (`dtstart`, `dtend`), `read` und
`list…` liefern es mit `allday`. Die Felder `starts_at` und `ends_at`
aus 1.0.1 nimmt 1.1 noch an und liefert sie zusätzlich; mit 1.2 fallen
sie weg. Die Spalten der Tabelle bleiben. `listRange db von bis ?tz?`
nimmt ISO-Grenzen; ein Datum als Ende schließt den ganzen Tag ein. Seit
1.1.1 vergleicht es Zeitpunkte: lokale Zeiten und Daten gelten in `tz`
(sonst `tical::config`), UTC-Werte als UTC; vorher wurden sie als Text
verglichen. Lokale Zeiten mit `tzid` gelten in dieser Zone. Kategorien
mit Komma bleiben eine Kategorie. `tzid` steht in einer eigenen Spalte;
`migrate` ergänzt sie in einer Tabelle aus 1.1. Vorher ging die Zone
beim Speichern verloren.

```tcl
package require tical::adapter::sqlite
set db [tical::adapter::sqlite::connect :memory:]
tical::adapter::sqlite::create $db [dict create uid u1 \
    dtstart 2025-10-14T09:00 summary Teamrunde]            ;# -> u1
set e [tical::adapter::sqlite::read $db u1]
list [dict get $e dtstart] [dict get $e starts_at]
;# -> 20251014T090000 20251014T090000
llength [tical::adapter::sqlite::listRange $db 2025-10-01 2025-10-31]  ;# -> 1
tical::adapter::sqlite::disconnect $db
```

---

## Beispiel

Monat Oktober 2025 mit Feiertagen und Terminen, als Text und als
Widget:

```tcl
lappend auto_path /pfad/zu/tical
package require tical

set termine {
    {summary Teamrunde dtstart 2025-10-14T09:00 dtend 2025-10-14T10:00}
    {summary Messe dtstart 2025-10-20 dtend 2025-10-23}
}
set s [tical::view::month::getData -year 2025 -month 10 \
    -holidays DE -events $termine]
puts [tical::render::term::print $s -weekNumbers 1]
foreach c [dict get $s cells] {
    if {"holiday" in [dict get $c markers]} { puts [dict get $c date] }
}
```

Ausgabe:

```
 Oktober 2025
 KW  Mo  Di  Mi  Do  Fr  Sa  So
 40  ..  ..   1   2  (3)  4   5
 41   6   7   8   9  10  11  12
 42  13  14* 15  16  17  18  19
 43  20* 21* 22* 23  24  25  26
 44  27  28  29  30  31  ..  ..
 45  ..  ..  ..  ..  ..  ..  ..

2025-10-03
```

Legende: `(3)` Feiertag, `14*` Tag mit Termin; mit `-color 1` stünde
der heutige Tag in eckigen Klammern.

Dasselbe als Widget aus tkutils, mit Mehrfachauswahl:

```tcl
lappend auto_path /pfad/zu/tical
source /pfad/zu/tkutils/tools/setup.tcl
package require Tk
package require tkutils::tkutical                 ;# -> 0.4

set w [::tkutils::tkutical::widget .cal -year 2025 -month 10 \
    -holidays DE -selectmode multiple \
    -events {{summary Sport dtstart 2025-10-07T18:00 rrule {freq WEEKLY}}} \
    -command {apply {{w sel} {puts "Auswahl: $sel"}}}]
pack $w -fill both -expand 1
::tkutils::tkutical::next $w
::tkutils::tkutical::getMonth $w                  ;# -> 2025 11
::tkutils::tkutical::setSelection $w {2025-11-03..2025-11-05}
;# -> 2025-11-03 2025-11-04 2025-11-05
```

---

## Fehler

Meldungen von tical sind englisch und tragen einen Errorcode der Form
`TICAL <MODUL> <GRUND>`, wie `TCLUTILS <MODUL> <GRUND>` in tclutils.
Module: `CORE`, `CONFIG`, `UTIL`, `LOCALE`, `EVENT`, `VIEW`, `RENDER`,
`MODEL`, `ICAL`, `IMPORT`, `SQLITE`. Falsche Optionen tragen als Grund
`OPTION`.

```tcl
try {
    tical::view::month::getData -year 2025
} trap {TICAL VIEW} {msg} {
    puts $msg
}
;# -> view::month::getData: -year and -month are required
```

Die Meldungen stehen im Anhang [Fehlermeldungen](830-anhang-fehlermeldungen.md).

---

## Tests

`tests/all.tcl` startet jede der 17 Testdateien in einem eigenen
Prozess, mit `-encoding utf-8`. Fehlt ein optionales Paket (Tk,
`pdf4tcl`, `tdbc`, tclutils), meldet der Lauf die Datei als
`SKIP … missing package …`; fehlt ein Paket von tical selbst, ist das ein
Fehler; der Exit-Code ist nur bei Fehlern ungleich
0. Tk-Tests brauchen ein Display (`xvfb-run -a tclsh tests/all.tcl`).
`io-import.test` sucht tclutils in `TCLUTILS_TM` (dessen `lib/tm`; leer:
nirgends) oder im Geschwisterordner `../tclutils/lib/tm`.

| Tcl | Ergebnis |
|---|---|
| 9.0.4 (mit `pdf4tcl`, `tdbc::sqlite3` und tclutils) | 17 Dateien, 343 bestanden |
| 8.6.14 (mit `pdf4tcl` und tclutils, ohne `tdbc::sqlite3`) | 16 Dateien, 309 bestanden; `adapter-sqlite.test` übersprungen |

Unter 8.6.14 mit Latin-1 als Systemkodierung ergibt der Lauf dasselbe;
vor der Umstellung auf `source -encoding utf-8` im `pkgIndex.tcl` waren
dort zwei Tests rot, und die Monatsnamen kamen als `MÃ¤rz` an.

Ohne `pdf4tcl` überspringt der Lauf auch `render-pdf.test` (19 Tests),
ohne tclutils `io-import.test` (23 Tests), `roundtrip.test` (7 Tests:
Beispieldateien importieren, exportieren, wieder importieren, Serien
auflösen) und drei Vergleiche mit
`tuholiday` und `turrule`: ohne beide 285 bestanden unter 9.0.4,
254 unter 8.6.14.

In tkutils 0.49.0 laufen dazu `tkutical.test` (17) und
`tkumonthcanvas.test` (13) gegen tical 1.1.1, unter Tcl/Tk 8.6.14 und
9.0.4 ohne Fehler.

::: {.info}
**Getestet mit** tical 1.1.1, Tcl/Tk 8.6.14 und 9.0.4 unter Linux (Xvfb),
`pdf4tcl` 0.9.4.73, tclutils 0.69.0; alle Beispiele dieses Kapitels unter
beiden Versionen, die SQLite-Beispiele nur unter 9.0.4.

**Nicht getestet:** Windows, macOS; die Demos unter `demos/` und das
Aussehen der PDF-Seiten nur von Hand.
:::

---

## Merkliste

- tical über `auto_path` laden, nicht über `tcl::tm::path`.
- Kern ohne Tk; Canvas, PDF und SQLite einzeln laden.
- Region bei `-holidays` in beliebiger Schreibung: `DE` oder `de`.
- `-count N` (N > 1) liefert eine Liste von N Monats-ViewSpecs.
- Unbekannte Optionen sind Fehler (`TICAL … OPTION`), auch in Views.
- Alle Renderer beschriften nach `tical::locale` (Vorgabe deutsch); den
  Wochenstart setzt die View (`-weekStart sun`), nicht der Renderer;
  `render::term -weekStart` prüft nur.
- Ein Terminformat (`tical::event`): `summary`, `dtstart`, `dtend`;
  Datum ohne Uhrzeit ist ganztägig, `dtend` dann exklusiv.
- Termine mit `getData … -events` in die View; mehrtägige stehen in
  jeder berührten Zelle, Serien an jedem ihrer Tage.
- `render::term`: `[17]` heute (`-color 1`), `(18)` Feiertag, `17*` Termin;
  Woche und Tag als Liste.
- `TZID` wird umgerechnet; unbekannte Zonen bleiben lokale Zeit.
- Oster- und Pfingstsonntag nur mit `holidays::de -sundays 1`.
- Ganztägig wird `VALUE=DATE` geschrieben und gelesen.
- Lesen und expandieren mit `tical::io::import` (braucht tclutils).
- `title`/`date`/`startTime` und `starts_at` gehen in 1.1 noch, in 1.2
  nicht mehr.
- Fehler fangen mit `trap {TICAL …}`.

---

*Nächstes Kapitel: [Fallen](800-anhang-fallen.md)*
