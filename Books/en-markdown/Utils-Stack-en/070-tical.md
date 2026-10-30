# Calendar: tical

## What tical Is

[tical]{.index} 1.1.1 is a calendar and iCalendar engine in pure Tcl, with
a repository of its own next to tclutils, tkutils and ctrlutils. It
separates three layers:

```
tical::core        Kalenderdaten eines Monats (Tage, ISO-Wochen, heute)
tical::view::*     ViewSpec: Raster für Monat, Woche oder Tag
tical::render::*   Ausgabe: Text, Tk-Canvas, PDF
```

A [ViewSpec]{.index} is a dict with a grid of cells; every renderer
draws every ViewSpec of its type. Appointments have one common format
(`tical::event`); the views distribute them over the cells. In addition
there are public holidays (`tical::holidays`), iCalendar export
(`tical::io::ical`) and import (`tical::io::import`), an in-memory
appointment model (`tical::model`) and an SQLite adapter
(`tical::adapter::sqlite`).

The core needs no Tk and runs under Tcl 8.6 and 9. Four layers are
optional and each needs a third-party package:

| Package | needs |
|---|---|
| `tical::render::canvas` | Tk |
| `tical::render::pdf` | `pdf4tcl` |
| `tical::adapter::sqlite` | `tdbc::sqlite3` |
| `tical::io::import` | tclutils: `tclutils::tuical` |

The `tical` umbrella loads everything else: `core`, `util`, `config`,
`locale`, `term`, `holidays`, `holidays::de`, `event`, `model`,
`io::ical`, the three views and `render::term`. The application loads
the four optional packages one by one.

---

## Loading

tical ships a `pkgIndex.tcl` in its root folder; it loads every file
with `source -encoding utf-8`, also under Tcl 8.6 with cp1252. The files are called
`*.tm`, but they sit in subfolders (`core/`, `views/`, `render/` …) and
are found through `auto_path`, not through the [module path]{.index}:

```tcl
lappend auto_path /pfad/zu/tical
package require tical                    ;# -> 1.1
package require tical::render::canvas    ;# nur mit Tk
```

`tical::io::import` finds tclutils through the module path, like every
application of the stack:

```tcl
tcl::tm::path add /pfad/zu/tclutils/lib/tm
package require tical::io::import        ;# -> 1.1
```

With `tcl::tm::path add /pfad/zu/tical`, Tcl finds only the file of the
umbrella; `package require tical` then ends with
`can't find package tical::util 1.0`. Instead of `lappend auto_path`,
`TCLLIBPATH` or a folder that is already on the `auto_path` also works
(chapter [Pairing and Setup](020-pairing-und-setup.md)).

tkutils looks for tical for its calendar widgets in two places: in
`TICAL_DIR` and, without that variable, in sibling folders `tical*` next
to the tkutils checkout. The tests and `bin/tkutical.tcl` do it this
way. An application of your own extends `auto_path` itself.

---

## How It Relates to tclutils and tkutils

tclutils and ctrlutils never load tical. tkutils loads it only in two
optional widgets that are not in the `tkutils` umbrella. For many
calendar tasks, tclutils or tkutils has a module of its own without
tical:

| Task | tclutils | tkutils | tical |
|---|---|---|---|
| month as text | `tucal` (like `cal`) | `tkucal` (shows `tucal`) | `render::term` |
| month as image or PDF | `tumonthpng` (PNG) | — | `render::pdf` (PDF) |
| calendar widget | — | `tkucalendar`, `tkudateentry` (only Tk and `clock`); `tkutical`, `tkumonthcanvas` (on tical) | `render::canvas` |
| public holidays | `tuholiday` | — | `holidays`, `holidays::de` |
| expanding recurrence rules | `turrule` | — | `event::expand` (own code, the same occurrences) |
| reading iCalendar | `tuical::parse` | `tkuical` (table) | `io::import::parse` (through `tuical`) |
| writing iCalendar | `tuical::toIcs` | — | `io::ical::exportEvents` |

The two tkutils widgets on tical:

- `tkutils::tkutical` 0.4: month or week view with navigation, week
  numbers and day selection; draws through `tical::render::canvas`;
  appointments with `-events` (since 0.4, needs tical 1.1), series on
  each of their days.
- `tkutils::tkumonthcanvas` 0.5: month, quarter or year on a canvas of
  its own with themes and notes; takes dates, names and holidays from
  `tical::config`, `tical::locale`, `tical::holidays` and
  `tical::view::month`. It derives the holiday region from the locale
  (`de_DE` → `DE`).

Public holidays: [tuholiday]{.index} from tclutils returns the
nationwide German days including Easter Sunday and Whit Sunday (11 in
2026), `tical::holidays::de` the nine statutory days without the two
Sundays; with `-sundays 1` the same list as `tuholiday` (see "Public
Holidays"). Both compute Easter themselves. Neither knows state holidays.

[turrule]{.index} expands an RRULE into occurrences, [tuical]{.index}
reads iCalendar text. tical has no reader of its own:
`tical::io::import` calls `tuical` and returns appointments in the format
of `tical::event` (section [Import](#import)). Since 1.1.1 tical expands
series itself (`tical::event::expand`), so the views show them without
tclutils as well; a test compares the result with `turrule`.

---

## Views

All views return a ViewSpec. Missing options come from
`tical::config`:

```tcl
tical::config::getDefaults
;# -> firstweek iso locale de_DE today {} weekstart mon theme default timezone Europe/Berlin
```

Since 1.0.2 `tical::config::set` checks key and value: a typo such as
`weekStart` ends with errorcode `TICAL CONFIG KEY`, a zone Tcl does not
know, a locale other than German, English, French or `weekstart sonntag`
with `TICAL CONFIG VALUE`; the old value stays. `today` (`YYYY-MM-DD`,
empty: the real date) sets which day is marked as today, for example for
output that stays the same.

| View | `type` | Options | Cells |
|---|---|---|---|
| `tical::view::month::getData` | `month-grid` | `-year`, `-month` (required), `-tz`, `-weekStart mon\|sun`, `-firstWeek iso\|simple\|us`, `-showAdjacentDays 0\|1` (1), `-holidays REGION`, `-count N` (1), `-events LIST` | 42 (6 × 7) |
| `tical::view::week::getData` | `week-grid` | `-year` and `-week` or `-date`, `-tz`, `-holidays`, `-events` | 7 |
| `tical::view::day::getData` | `day-grid` | `-date` (required), `-hourStart` (0), `-hourEnd` (23), `-tz`, `-holidays`, `-events` | one per hour |

`-date` takes `2025-10-14` and `20251014`. Since 1.1.1 the views also
check the values: `-month` 1 to 12, `-week` 1 to 52 or 53 (the ISO weeks
of the year; before, `-week 60` slipped silently into the next year), a
valid `-date`, `-hourStart` not after `-hourEnd`. A wrong value ends with
errorcode `TICAL VIEW OPTION`, no longer with a `CLOCK …` error.

An unknown option or an option without a value is an error with
errorcode `TICAL VIEW OPTION`; the message names the known options. Up
to 1.0.1 the view skipped such options silently, so a typo like
`-weekstart` had no effect:

```tcl
tical::view::month::getData -year 2025 -month 10 -weekstart sun
;# Error: view::month::getData: unknown option "-weekstart", must be -count,
;#   -events, -firstWeek, -holidays, -month, -showAdjacentDays, -tz,
;#   -weekStart or -year
```

The week start is an option of the view, not of the renderers: with
`-weekStart sun` (also `sunday`) the grid starts on Sunday, and all
renderers label their columns after the cells. The week view always
runs from Monday to Sunday (ISO week).

`-firstWeek` sets the week number of the cells: `iso` (default,
ISO 8601: week 1 holds the first Thursday), `simple` (week 1 is
January 1 to 7) or `us` (weeks from Sunday, week 1 holds January 1).
January 1, 2023 was a Sunday:

```tcl
lmap fw {iso simple us} {
    set m [tical::view::month::getData -year 2023 -month 1 \
        -weekStart sun -firstWeek $fw]
    dict get [lindex [dict get $m cells] 0] week
}
;# -> 52 01 01
```

The renderers show for each grid row the week of the middle cell; so a
Sunday grid with ISO weeks, too, names the week that six of the seven
days belong to.

A cell is a dict with `date`, `dow` (1 = Monday), `week`, `markers` and
`events`; in the month view also `inMonth`, in the day view `hour` and
`time`. `markers` contains `today` and `holiday`, `events` the
appointments (section [Appointments](#appointments)). With
`-showAdjacentDays 0`, the cells before and after the month are empty
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

`-date` in the week view uses the ISO year: 2024-12-30 lies in week 1
of 2025.

```tcl
set w [tical::view::week::getData -date 2024-12-30]
list [dict get $w year] [dict get $w week]    ;# -> 2025 1
```

The region for `-holidays` is the key under which the holiday plugin is
registered, such as `DE`; case does not matter (`de` works like `DE`).
An unknown region marks no day; there is no error.

`-count N` with N > 1 returns, instead of one ViewSpec, a list of N
consecutive months from `-year`/`-month` on, across the turn of the
year as well. `-count 1` (the default) returns one ViewSpec as without
the option; smaller values end with
`view::month::getData: -count must be an integer >= 1, got "0"`.

```tcl
set q [tical::view::month::getData -year 2025 -month 11 -count 3]
llength $q                                    ;# -> 3
lmap m $q {dict get $m month}                 ;# -> 11 12 1
```

The list goes as it is to `render::pdf::createQuarter` or
`createYear`.

`validate` checks the required fields and the `type` in every view.

---

## Appointments

An appointment is the same dict throughout tical, modelled on iCalendar
([tical::event]{.index}):

| Key | Meaning |
|---|---|
| `summary` | title (required, may be empty) |
| `dtstart` | start (required): `YYYYMMDD` all-day, `YYYYMMDDTHHMMSS` local, `YYYYMMDDTHHMMSSZ` UTC |
| `dtend` | end (optional), of the same kind; for all-day exclusive, that is the day after the last day |
| `allday` | `0` or `1`; follows `dtstart` |
| `uid`, `description`, `location`, `status`, `categories`, `rrule`, `exdate` | optional |

`tical::event::normalize` brings an appointment into this form and
checks it. It also takes ISO input (`2025-10-14`, `2025-10-14T09:00`)
and, for one version (1.1), the older field names: `title`, `date`,
`startTime`, `endTime` from `tical::model`, `starts_at` and `ends_at`
from `tical::adapter::sqlite`.

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

The fair lasts three days: `dtend` 20251023 is exclusive. An end before
the start ends with
`dtend "20251014T090000" is before dtstart "20251014T100000"`
(errorcode `TICAL EVENT RANGE`).

`-events LIST` gives a view its appointments. It puts every appointment
into the `events` of every cell it touches, the neighbouring days of
the month included. An entry is the appointment plus `part` (`single`,
`start`, `middle`, `end`) and `time` (start `HH:MM` on the first day,
otherwise empty); all-day appointments come before the others. A series
(`rrule`) appears on each of its days, with `recurrence-id`; up to 1.1 it
appeared only on the first. `tical::event::expand appointments from to
?tz?` returns the occurrences directly as well. It knows `FREQ` (daily to
yearly), `INTERVAL`, `COUNT`, `UNTIL`, `BYDAY` (also `1MO`, `-1FR`),
`BYMONTH`, `BYMONTHDAY` and `WKST`, and honours `EXDATE` and overrides
with `RECURRENCE-ID`.

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

The day view also has a key `events` with all appointments of the day;
its hour cells contain the timed appointments running in that hour:

```tcl
set t [tical::view::day::getData -date 2025-10-14 \
    -hourStart 8 -hourEnd 10 -events $termine]
lmap c [dict get $t cells] {lmap e [dict get $c events] {dict get $e summary}}
;# -> {} Teamrunde {}
```

An appointment with `Z` is converted into the time zone of the view
(`-tz`); one without `Z` counts as local time there.

---

## Renderers

### Text: render::term

```tcl
tical::render::term::print $viewSpec ?-weekNumbers 0|1? ?-color 0|1? ?-weekStart mon|sun?
```

Returns the month as text, six rows of seven days; days of the
neighbouring month appear as `..`. Week and day are printed as lists
since 1.1.1 (see below); any other type ends with
`render::term::print: expected type month-grid, week-grid or day-grid, got "year-grid"`.
Every column is four characters wide, the week column and the heading
included; the numbers stand right-aligned below each other.

The cells, four characters each between the quotes:

```
" 17 "          day
"(18)"  " (3)"  public holiday of the view (-holidays DE)
"[17]"  " [3]"  today, only with -color 1; today wins over holiday
" 17*"          day with an appointment (events of the cell)
"[17*"  "(18*"  today or holiday with an appointment
" .. "          day of the neighbouring month
```

Up to 1.0.1 a holiday appeared as `+18`, today as `*17`; `+18` read like
a sum.

Month and day names come from [tical::locale]{.index} and follow
`tical::config::set locale …`; with the default `de_DE` the heading
reads `Oktober 2025` and the column headings are `Mo Di Mi Do Fr Sa So`
(with `-weekNumbers 1` preceded by `KW`). After
`tical::config::set locale en_US` they read `October 2025` and
`Wk Mo Tu We Th Fr Sa Su`.

The column order comes from the cells of the view. `render::term` takes
`-weekStart` only as a check: if the value matches the view, the output
stays the same; if it contradicts it, the call ends with errorcode
`TICAL RENDER WEEKSTART`. Code that passes the matching value keeps
working. Unknown options end with
`render::term::print: unknown option "-colour", must be -color, -weekNumbers or -weekStart`.

```tcl
set so [tical::view::month::getData -year 2025 -month 10 \
    -weekStart sun -holidays DE]
puts [tical::render::term::print $so]
string equal [tical::render::term::print $so -weekStart sun] \
    [tical::render::term::print $so]          ;# -> 1
tical::render::term::print $so -weekStart mon
;# Error: render::term::print: -weekStart mon contradicts the view (starts on
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

`tical::locale` returns the same names directly:

```tcl
tical::locale::getMonthName 10                ;# -> Oktober
tical::locale::getWeekdaysShort               ;# -> Mo Di Mi Do Fr Sa So
tical::locale::getWeekdaysShort 7             ;# -> So Mo Di Mi Do Fr Sa
tical::locale::getWeekLabel short             ;# -> KW
```

`tical::locale` knows `de`, `en` and `fr` and follows
`tical::config::set locale …`. The optional argument of the weekday
lists is the first day (1 = Monday … 7 = Sunday); `getWeekLabel`
returns `KW`, `Week` or `Semaine`, with `short` `KW`, `Wk` or `Sem`.


Week and day as lists. The week has one line per day, the appointments
follow the day, one per line: `HH:MM title` with a time, all-day ones
without, `.. title` for an appointment that began on an earlier day. A
holiday stands in round brackets, today (with `-color 1`) in square
ones.

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

The day has one line per hour of the view; all-day appointments stand
below the title, an appointment that began before the first hour in the
first line with `..`:

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

`-weekNumbers` only affects the month (the week names its number in the
title), `-weekStart` checks month and week; the week always starts on
Monday.

### Tk: render::canvas

```tcl
tical::render::canvas::draw $canvas $viewSpec ?-interactive 0|1? ?-fontsize 12? ?-weekNumbers 0|1?
```

Draws a month, week or day on an existing canvas: today yellow, public
holidays red, weekends blue, neighbouring days grey. Appointments of the
cells appear in the month as up to three dots below the number, in week
and day as titles with time (tag `event`); the week columns become
wider for them. Unknown options end with errorcode
`TICAL RENDER OPTION`. Month name,
weekdays and the title of the week view (`KW 42, 2025`) come from
`tical::locale`, the column order from the view. With
`-interactive 1` the days of the month and week views react to the mouse
and to clicks; the day view has no bindings. The selection applies per
canvas:

| Call | Effect |
|---|---|
| `setSelectMode $c none\|single\|multiple` | selection mode; default `none` |
| `getSelection $c` | sorted ISO dates |
| `setSelection $c {dates}` | single dates and ranges `A..B` |
| `clearSelection $c` | empties the selection |
| `setSelectionCommand $c cmd` | `cmd $c $selection` after every change |
| `setCallback ?$c? cmd` | only with `none`: `cmd $c $date` on a click; without `$c` for all canvases, with `$c` for this one only (wins) |

With `multiple`, a click toggles the day, a Shift-click selects the
range from the day clicked last up to here.

```tcl
canvas .c -width 400 -height 350 -bg white
pack .c
tical::render::canvas::draw .c $s -interactive 1 -weekNumbers 1
tical::render::canvas::setSelectMode .c multiple
tical::render::canvas::setSelection .c {2025-10-06..2025-10-08 2025-10-20}
;# -> 2025-10-06 2025-10-07 2025-10-08 2025-10-20
```

`setCallback` takes a command prefix, optionally preceded by the canvas:
`setCallback [list apply {{c datum} {puts $datum}}]` applies to all,
`setCallback .c …` since 1.1.1 to `.c` only. The form with a parameter
list and a body as two arguments ends with errorcode `TICAL RENDER ARGS`
(`"c datum" is not a widget path`).

### PDF: render::pdf

```tcl
tical::render::pdf::create        datei $viewSpec ?optionen?
tical::render::pdf::createQuarter datei {spec spec spec} ?optionen?
tical::render::pdf::createYear    datei {12 specs} ?optionen?
tical::render::pdf::drawMonth|drawWeek|drawDay $pdf $viewSpec ?optionen?
```

`create` writes one page with a month, week or day. `createQuarter` puts
three months side by side, `createYear` twelve in a 4 × 3 grid, both in
landscape. Options with or without a dash: `paper` (`a4`, `a3`, `a5`,
`letter`, in any case), `orientation` (`portrait`, for quarter and year
`landscape`), `fontsize` (10), `margin` (20), `weekNumbers` (1),
`showGrid` (1) and the colours `colorToday`, `colorHoliday`,
`colorWeekend`, `colorEvent`, `colorEventText`. Other names and values
end with errorcode `TICAL RENDER OPTION`; up to 1.0.1, `-paper Letter`
silently became A4. `draw…` draws into a `pdf4tcl` object that is
already open. The return value is the file name. Names and column order
as with `render::canvas`.

Appointments of the cells colour the day and appear as titles below the
number, as many as fit into the cell (the last line then `+N`); in the
small blocks of quarter and year a dot remains. The option `events` of
1.0.1 (a list of dates that are only coloured) is still accepted by 1.1;
it goes away with 1.2.

```tcl
package require tical::render::pdf
set specs [tical::view::month::getData -year 2025 -month 10 \
    -count 3 -holidays DE -events $termine]
tical::render::pdf::createQuarter q4.pdf $specs   ;# -> q4.pdf
tical::render::pdf::create okt.pdf [lindex $specs 0] -paper Letter
;# -> okt.pdf
```

---

## Public Holidays

`tical::holidays` manages plugins per region. A plugin is a command that
returns a dict `ISO date → name` for a year; `tical::holidays::de`
registers itself as `DE` when loaded, with the nine nationwide holidays.
`getHolidays -sundays 1 year` adds Easter Sunday and Whit Sunday and then
returns the same list as `tclutils::tuholiday::holidays`. For the views,
register that as a region, under `DE` or a name of your own:

```tcl
tical::holidays::register DE {::tical::holidays::de::getHolidays -sundays 1}
tical::holidays::getHolidays DE 2026 4
;# -> 3 Karfreitag 5 Ostersonntag 6 Ostermontag
```

Since a plugin is only a command prefix that gets the year appended,
`tuholiday` fits directly as well:
`tical::holidays::register DE ::tclutils::tuholiday::holidays`.

```tcl
tical::holidays::getHolidays DE 2026 4      ;# -> 3 Karfreitag 6 Ostermontag
tical::holidays::register AT ::meineapp::feiertageAT
```

`getHolidays` returns a dict `day → name` for one month; `getMarkers`
returns the same as a marker list. An unknown region gives an empty
dict.

---

## iCalendar

`tical::io::ical` writes appointments according to RFC 5545: VCALENDAR
with VEVENT, lines with CRLF, lines over 75 bytes (UTF-8) folded. An appointment is a
dict with `uid`, `dtstart`, `summary` (required), plus optionally
`dtend` or `duration`, `description`, `location`, `status`,
`categories`, `rrule` and `exdate`. Times have the form
`YYYYMMDDTHHMMSSZ` (UTC); without `Z`, `io::ical` writes them unchanged
and they count as local time. `exportEvents` first sends every
appointment through `tical::event::normalize`; so ISO input and the
older field names work too, and a missing `uid` is generated. An
appointment with `recurrence-id` (a moved occurrence of a series) gets
`RECURRENCE-ID`, with `TZID` like `DTSTART`; since 1.1.1 it comes back
as an override when read in again, not as a second appointment.
`makeEvent` adds `uid` and `dtstamp`:

```tcl
set ev [tical::io::ical::makeEvent -uid team-1@example.org \
    -dtstart 20251014T090000Z -dtend 20251014T100000Z \
    -summary "Teamrunde" -rrule {freq WEEKLY count 4}]
set ics [tical::io::ical::exportEvents [list $ev]]
```

Result without the `DTSTAMP` line (the time of the export):

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

`rrule` is a dict with `freq` (`DAILY`, `WEEKLY`, `MONTHLY`, `YEARLY`),
`count` or `until`, `interval`, `byday`, `bymonth`, `bymonthday` and
`wkst`, or an RRULE string (`FREQ=WEEKLY;COUNT=4`). Other frequencies
end with `FREQ must be DAILY|WEEKLY|MONTHLY|YEARLY, got "HOURLY"`.
`exportToFile $events file` writes the same into a file (UTF-8, line
ending CRLF; up to 1.0 it was `\r\r\n`).

### All-Day Appointments

A date without a time (`20251020` or `2025-10-20`) is an all-day
appointment. `io::ical` writes it with `VALUE=DATE`; `DTEND` is
exclusive as in iCalendar. Up to 1.0.1 it wrote a date without
`VALUE=DATE`, which RFC 5545 does not allow.

```tcl
set ganz [tical::io::ical::makeEvent -uid messe-1@example.org \
    -summary Messe -dtstart 2025-10-20 -dtend 2025-10-23]
set ics2 [tical::io::ical::exportEvents [list $ganz]]
```

The VEVENT without `DTSTAMP`, a fair from October 20 to 22:

```
BEGIN:VEVENT
UID:messe-1@example.org
DTSTART;VALUE=DATE:20251020
DTEND;VALUE=DATE:20251023
SUMMARY:Messe
END:VEVENT
```

`validate` checks the required fields, the form of `dtstart` and
`dtend` (`YYYYMMDD`, `YYYYMMDDTHHMMSS` or `YYYYMMDDTHHMMSSZ`, both of the
same kind, the end not before the start) and the `rrule`. `exportEvents`
does not call it. `validate` rejects ISO input; it checks what would be
written as it is:

```tcl
tical::io::ical::validate $ev                 ;# -> 1
tical::io::ical::validate {uid u1 dtstart 20251014 dtend 20251015 summary S}
;# -> 1
tical::io::ical::validate {uid u1 dtstart 2025-10-14 summary S}
;# Error: dtstart format invalid: "2025-10-14" (expected YYYYMMDD,
;#   YYYYMMDDTHHMMSS or YYYYMMDDTHHMMSSZ)
```

---

## Import

[tical::io::import]{.index} reads iCalendar text and expands
recurrences. It is optional and needs tclutils: `tuical` splits the
text; `tical::event::expand` works out the RRULE. Without tclutils,
`package require tical::io::import` ends with
`can't find package tclutils::tuical 0.1`; the rest of tical still
loads.

| Call | Result |
|---|---|
| `parse $ics` | list of appointments in the format of `tical::event` |
| `readFile file` | the same from a file (UTF-8) |
| `expand $appointments from to ?tz?` | occurrences that touch the days `from` to `to`, sorted by start |
| `eventsInRange $ics from to ?tz?` | `expand [parse $ics] from to` |

`parse` reads `UID`, `SUMMARY`, `DESCRIPTION`, `LOCATION`, `STATUS`,
`CATEGORIES`, `DTSTART` and `DTEND` (all-day with `VALUE=DATE`),
`DURATION` (when `DTEND` is missing), `RRULE`, `EXDATE` and
`RECURRENCE-ID`. `TZID` stays as the key `tzid`, with the wall-clock time
of that zone; `tical::event` and the views convert it to the display
zone (`-tz`, otherwise `tical::config`). A series is expanded in its own
zone: 09:00 in New York stays 09:00 there; in Berlin that is 14:00
instead of 15:00 in the days between the two clock changes. Understood
are IANA names, prefixed ids such as `/mozilla.org/…/Europe/Berlin` and
common Windows names such as `W. Europe Standard Time`;
`tical::event::tzid name` returns the Tcl zone or `""`. A TZID Tcl does
not know (a custom `VTIMEZONE`) leaves the time as local time. The export
writes `DTSTART;TZID=Europe/Berlin:…` back, without `VTIMEZONE`.
`expand` leaves out the days from
`EXDATE` and replaces an occurrence for which a VEVENT with the same
`UID` and a matching `RECURRENCE-ID` exists. If it has
`STATUS:CANCELLED` (the way Google and Outlook delete a single
occurrence of a series), the occurrence is dropped. `EXDATE;VALUE=DATE`
removes the whole day of a timed series. Every occurrence carries
`recurrence-id` but no `rrule` any more.

The export from above, read back:

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

The result of `expand` goes unchanged to `getData … -events`. An RRULE
with parts that tical does not know (`BYSETPOS`, `BYWEEKNO`,
`BYHOUR` …) ends with errorcode `TICAL IMPORT RRULE` instead of with too
many appointments.

---

## Model and SQLite

`tical::model` keeps appointments (`createAppointment -summary -dtstart
?-dtend? …`) and events (`createEvent -summary -dtstart …`) in memory,
with `get…`, `update…`, `delete…`, `list…`, `getAppointmentsByDate`
and `toEvents`. The records have the fields of `tical::event`, plus
`id`, `type` and `created`. For one version (1.1) the model still
accepts the old options `-title`, `-date`, `-startTime`, `-endTime`,
`-allDay`, `-category`, and every record still contains the fields of
the same names; they go away with 1.2. `-tzid` gives the zone of local
times (since 1.1.1, before an unknown option); the record and
`toEvents` keep it.

```tcl
tical::model::createAppointment -summary Zahnarzt \
    -dtstart 2025-10-14T09:00 -dtend 2025-10-14T09:30  ;# -> appt-1
dict keys [tical::model::getAppointmentsByDate 2025-10-14]   ;# -> appt-1
tical::model::createAppointment -title Kontrolle -date 2025-10-15 \
    -startTime 10:00                                    ;# -> appt-2
dict get [tical::model::getAppointment appt-2] dtstart  ;# -> 20251015T100000
```

`toEvents` returns all records as appointments (`uid` = the ID), ready
for `getData … -events`.

`tical::adapter::sqlite` stores appointments through `tdbc::sqlite3` in
a table `events`: `connect`, `create`, `read`, `update`, `delete`,
`exists`, `listRange`, `listAll`, `disconnect`. `create` and `update`
take the format of `tical::event` (`dtstart`, `dtend`), `read` and
`list…` return it with `allday`. 1.1 still accepts the fields
`starts_at` and `ends_at` from 1.0.1 and returns them as well; they go
away with 1.2. The columns of the table stay. `listRange db from to
?tz?` takes ISO bounds; a date as the end includes the whole day. Since
1.1.1 it compares points in time: local times and dates count in `tz`
(otherwise `tical::config`), UTC values as UTC; before, they were
compared as text. Local times with `tzid` count in that zone.
Categories with a comma stay one category. `tzid` sits in a column of
its own; `migrate` adds it to a table from 1.1. Before, the zone was
lost on saving.

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

## Example

October 2025 with public holidays and appointments, as text and as a
widget:

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

Output:

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

Legend: `(3)` public holiday, `14*` day with an appointment; with
`-color 1` today would stand in square brackets.

The same as a widget from tkutils, with multiple selection:

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

## Errors

tical messages are English and carry an errorcode of the form
`TICAL <MODULE> <REASON>`, like `TCLUTILS <MODULE> <REASON>` in
tclutils. Modules: `CORE`, `CONFIG`, `UTIL`, `LOCALE`, `EVENT`, `VIEW`,
`RENDER`, `MODEL`, `ICAL`, `IMPORT`, `SQLITE`. Wrong options carry the
reason `OPTION`.

```tcl
try {
    tical::view::month::getData -year 2025
} trap {TICAL VIEW} {msg} {
    puts $msg
}
;# -> view::month::getData: -year and -month are required
```

The messages are listed in the appendix [Error Messages](830-anhang-fehlermeldungen.md).

---

## Tests

`tests/all.tcl` starts each of the 17 test files in a process of its
own, with `-encoding utf-8`. If an optional package is missing (Tk,
`pdf4tcl`, `tdbc`, tclutils), the run reports the file as
`SKIP … missing package …`; a missing tical package is a failure; the exit code is non-zero only on failures.
Tk tests need a display (`xvfb-run -a tclsh tests/all.tcl`).
`io-import.test` looks for tclutils in `TCLUTILS_TM` (its `lib/tm`;
empty: nowhere) or in the sibling folder `../tclutils/lib/tm`.

| Tcl | Result |
|---|---|
| 9.0.4 (with `pdf4tcl`, `tdbc::sqlite3` and tclutils) | 17 files, 343 passed |
| 8.6.14 (with `pdf4tcl` and tclutils, without `tdbc::sqlite3`) | 16 files, 309 passed; `adapter-sqlite.test` skipped |

Under 8.6.14 with Latin-1 as the system encoding the run gives the same;
before `pkgIndex.tcl` switched to `source -encoding utf-8`, two tests
failed there and month names arrived as `MÃ¤rz`.

Without `pdf4tcl` the run also skips `render-pdf.test` (19 tests),
without tclutils `io-import.test` (23 tests), `roundtrip.test` (7 tests:
import sample files, export, import again, expand series) and three
comparisons with
`tuholiday` and `turrule`: without both, 285 passed under 9.0.4, 254
under 8.6.14.

In tkutils 0.49.0, `tkutical.test` (17) and `tkumonthcanvas.test` (13)
also run against tical 1.1.1, without failures under Tcl/Tk 8.6.14 and
9.0.4.

::: {.info}
**Tested with** tical 1.1.1, Tcl/Tk 8.6.14 and 9.0.4 on Linux (Xvfb),
`pdf4tcl` 0.9.4.73, tclutils 0.69.0; all examples of this chapter under
both versions, the SQLite examples only under 9.0.4.

**Not tested:** Windows, macOS; the demos under `demos/` and the look
of the PDF pages only by hand.
:::

---

## In short

- Load tical through `auto_path`, not through `tcl::tm::path`.
- Core without Tk; load canvas, PDF and SQLite one by one.
- Region for `-holidays` in any case: `DE` or `de`.
- `-count N` (N > 1) returns a list of N month ViewSpecs.
- Unknown options are errors (`TICAL … OPTION`), in views as well.
- All renderers label after `tical::locale` (default German); the view
  sets the week start (`-weekStart sun`), not the renderer;
  `render::term -weekStart` only checks.
- One appointment format (`tical::event`): `summary`, `dtstart`,
  `dtend`; a date without time is all-day, `dtend` is then exclusive.
- Appointments go into the view with `getData … -events`; multi-day ones
  appear in every cell they touch, series on each of their days.
- `render::term`: `[17]` today (`-color 1`), `(18)` holiday, `17*`
  appointment; week and day as lists.
- `TZID` is converted; unknown zones stay local time.
- Easter Sunday and Whit Sunday only with `holidays::de -sundays 1`.
- All-day is written and read as `VALUE=DATE`.
- Read and expand with `tical::io::import` (needs tclutils).
- `title`/`date`/`startTime` and `starts_at` still work in 1.1, no
  longer in 1.2.
- Catch errors with `trap {TICAL …}`.

---

*Next chapter: [Pitfalls](800-anhang-fallen.md)*
