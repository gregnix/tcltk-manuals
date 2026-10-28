# Notes and Calendars

Markdown, iCalendar with recurrence rules, vCard, a note tree in memory
and in SQLite, a monthly calendar as text, and the nationwide public
holidays in Germany. Everything is in the umbrella and is pure Tcl;
`tunotesdb` needs `sqlite3` with FTS5 when called. `tuvcard` also uses
`tubase64`.

---

## Markdown: tumd

[tumd]{.index} converts a subset of CommonMark into an HTML fragment,
without an `<html>` frame. Headings are ATX (`#` to `######`). In
addition there are paragraphs, fenced code, block quotes, flat lists
and horizontal rules. Inline: code in backticks, `**fett**`, `*kursiv*`,
links, images and autolinks. Nested lists, Setext headings, tables and
reference links stay as they are and are not recognized as such. An
indented list becomes a flat list.

`frontmatter` separates a YAML header between two `---` lines. If the
closing rule is missing, the header stays empty and the text whole.
`toHtml` omits the header. `headings` returns pairs of level and text.
`toc` builds a list with anchors. The anchor is lowercase and consists
only of `a`–`z`, digits, spaces and hyphens. Other characters are
dropped.

```tcl
package require tclutils::tumd
::tclutils::tumd::toHtml "# Größe\n\nEin **Regal** und `x < y`."
                                          ;# -> <h1 id="gre">Größe</h1>\n<p>Ein <strong>Regal</strong> und <code>x &lt; y</code>.</p>
::tclutils::tumd::headings "# Größe"       ;# -> {1 Größe}
::tclutils::tumd::toc "# Größe"            ;# -> - [Größe](#gre)
::tclutils::tumd::frontmatter "---\ntitle: Lager\n---\n# Lager\n"
                                          ;# -> {title: Lager} {# Lager\n}
::tclutils::tumd::toHtml "- a\n  - b"      ;# -> <ul>\n<li>a</li>\n<li>b</li>\n</ul>
```

The anchor of `Größe` is `gre`. `tustr::slugify` turns it into `gr-e`.

---

## iCalendar: tuical

`parse` reads the text into a list of components. A component is a
dict with `type`, `props` and `components`. A property is a dict with
`name`, `value` and `params`. The value stays raw, as in the file.
`escapeText` and `unescapeText` handle `\`, `;`, `,` and the newline
according to RFC 5545. `eventInfo`, `todoInfo` and `journalInfo`
unescape the text fields. A continuation line starts with a space or
tab.

`events`, `todos` and `journals` find `VEVENT`, `VTODO` and `VJOURNAL`
in nested components as well. `newComponent` builds a component from a
flat `Name Wert` list. `toIcs` writes it back, each line with CR/LF.

```tcl
package require tclutils::tuical
set ics "BEGIN:VCALENDAR\nBEGIN:VEVENT\nUID:1\nSUMMARY:Lager\\, Nord\nDTSTART:20240315T090000\nEND:VEVENT\nEND:VCALENDAR\n"
set ev [lindex [::tclutils::tuical::events [::tclutils::tuical::parse $ics]] 0]
dict get [::tclutils::tuical::eventInfo $ev] summary
                                          ;# -> Lager, Nord
dict get [::tclutils::tuical::eventInfo $ev] dtstart
                                          ;# -> 20240315T090000
::tclutils::tuical::escapeText "a;b\nc"    ;# -> a\;b\nc
```

A line without a colon and an `END` without `BEGIN` throw
`{TCLUTILS TUICAL SYNTAX}`. A property list of odd length throws
`{TCLUTILS TUICAL ARG}`.

---

## Recurrences: turrule

[turrule]{.index} expands an iCalendar recurrence rule `RRULE`
(RFC 5545) into individual occurrences. Calculations are done in UTC.

| Command | Effect |
|---|---|
| `parse rrule` | dict of the parts; keys in uppercase, values as written |
| `occurrences ?optionen?` | list of occurrences |
| `eventsInRange ics von bis` | list of dicts `uid summary start` for all `VEVENT` in the period; loads `tuical` |

| Option | Default | Effect |
|---|---|---|
| `-dtstart` | | start, required; `JJJJ-MM-TT`, `JJJJMMTT`, also with time `THHMMSS` or `THH:MM:SS`; a trailing `Z` is dropped |
| `-rule` | | the rule without `RRULE:` |
| `-from` | `-dtstart` | earlier occurrences do not appear |
| `-to` | | later occurrences do not appear |
| `-count` | `0` | at most this many occurrences; `0` for no limit |

| Rule part | Scope |
|---|---|
| `FREQ` | `DAILY`, `WEEKLY`, `MONTHLY`, `YEARLY` |
| `INTERVAL` | interval between periods, default 1 |
| `COUNT` | number of occurrences, counted from `-dtstart` |
| `UNTIL` | latest point in time; as a date without time, the whole day |
| `BYDAY` | weekdays `MO` to `SU`; `MONTHLY`, `YEARLY`: also with an ordinal such as `1MO`, `4TH` or `-1FR` |
| `BYMONTHDAY` | days of the month, negative from the end of the month; not with `WEEKLY` |
| `BYMONTH` | months 1–12; `YEARLY` takes these months, otherwise it restricts |
| `WKST` | only `MO` |

`YEARLY` works like this: with `BYMONTH`, each named month applies, and
an ordinal in `BYDAY` counts within the month (`BYMONTH=11;BYDAY=4TH`
is the fourth Thursday in November). Without `BYMONTH`, `BYMONTHDAY`
applies in every month, and an ordinal in `BYDAY` counts within the
year (`BYDAY=20MO` is the 20th Monday). Without these parts the
anniversary of `-dtstart` remains. If `BYDAY` and `BYMONTHDAY` appear
together, only days that satisfy both remain (`BYDAY=FR;BYMONTHDAY=13`).
A monthly occurrence on the 31st skips months without a 31st day, a
yearly occurrence on February 29 skips years without a leap day.

Other parts such as `BYSETPOS`, `BYWEEKNO`, `BYYEARDAY`, `BYHOUR` or a
`WKST` other than `MO` throw `{TCLUTILS TURRULE UNSUPPORTED}` instead
of being dropped.

`COUNT` counts from `-dtstart`; `-from` and `-to` only trim the
output. A `-dtstart` without time yields dates, one with time yields
`JJJJ-MM-TTTHH:MM:SS` with the same time. `UNTIL` without time
includes the whole day: an occurrence at 09:00 on the day of `UNTIL`
is included.

```tcl
package require tclutils::turrule
::tclutils::turrule::parse "FREQ=WEEKLY;BYDAY=TU,TH;COUNT=4"
    ;# -> FREQ WEEKLY BYDAY TU,TH COUNT 4
::tclutils::turrule::occurrences -dtstart 2025-10-01 \
    -rule "FREQ=WEEKLY;BYDAY=TU,TH;COUNT=4"
    ;# -> 2025-10-02 2025-10-07 2025-10-09 2025-10-14
::tclutils::turrule::occurrences -dtstart 2025-01-31 \
    -rule "FREQ=MONTHLY;BYMONTHDAY=-1" -count 3
    ;# -> 2025-01-31 2025-02-28 2025-03-31
::tclutils::turrule::occurrences -dtstart 20251002T090000 \
    -rule "FREQ=DAILY;INTERVAL=2" -count 2
    ;# -> 2025-10-02T09:00:00 2025-10-04T09:00:00
set ics "BEGIN:VCALENDAR\nBEGIN:VEVENT\nUID:4\nSUMMARY:Standup\n"
append ics "DTSTART:20251002T090000\nRRULE:FREQ=WEEKLY\n"
append ics "END:VEVENT\nEND:VCALENDAR\n"
set ev [::tclutils::turrule::eventsInRange $ics 2025-10-01 2025-10-10]
lmap e $ev {dict get $e start}
    ;# -> 2025-10-02T09:00:00 2025-10-09T09:00:00
::tclutils::turrule::occurrences -dtstart 2025-01-01 \
    -rule "FREQ=YEARLY;BYMONTH=11;BYDAY=4TH;COUNT=2"
    ;# -> 2025-11-27 2026-11-26
::tclutils::turrule::occurrences -dtstart 2025-01-01 \
    -rule "FREQ=MONTHLY;BYDAY=FR;BYMONTHDAY=13;COUNT=2"
    ;# -> 2025-06-13 2026-02-13
::tclutils::turrule::occurrences -dtstart 2025-01-06T09:00:00 \
    -rule "FREQ=WEEKLY;UNTIL=20250120"
    ;# -> 2025-01-06T09:00:00 2025-01-13T09:00:00 2025-01-20T09:00:00
```

Without `-to`, `-count`, `COUNT` and `UNTIL`, `occurrences` throws
`{TCLUTILS TURRULE UNBOUNDED}`. A rule without `FREQ` or with a
frequency other than the four above throws `{TCLUTILS TURRULE FREQ}`,
an unreadable date `{TCLUTILS TURRULE DATE}`. An unknown weekday
abbreviation such as `XX`, the ordinal 0, or an ordinal with `DAILY`
and `WEEKLY` throw `{TCLUTILS TURRULE BYDAY}`; a month outside 1–12 in
`BYMONTH` or a day outside ±1–31 in `BYMONTHDAY` throws
`{TCLUTILS TURRULE VALUE}`.

---

## vCard: tuvcard

`parse` returns a list of cards. A card is a list of property dicts,
the same structure as in `tuical`. `property` returns the first value
of a name, `get` all values, `fullName` the property `FN`. `toVcf`
writes CR/LF. The case of the name does not
matter.

```tcl
package require tclutils::tuvcard
set vcf "BEGIN:VCARD\nFN:Ada\nN:Lovelace;Ada;;;\nTEL:1\nEND:VCARD\n"
set card [lindex [::tclutils::tuvcard::parse $vcf] 0]
::tclutils::tuvcard::fullName $card          ;# -> Ada
::tclutils::tuvcard::get $card TEL           ;# -> 1
::tclutils::tuvcard::names $card             ;# -> FN N TEL
```

A line without a colon throws `{TCLUTILS TUVCARD SYNTAX}`.

---

## Note Tree: tunotes

A store is a dict mapping id to note. A note has `id`, `parent_id`,
`title`, `content`, `created`, `modified` and `tags`. `create`,
`update` and `delete` receive the name of the variable and change it.
`get`, `search`, `count`, `roots` and `children` receive the value.
The id is `clock microseconds`.

`search` compares title and content with `string match`, ignoring
case. An asterisk in the query is a pattern character. `toJson` and
`fromJson` go through `tujson`. `fromJson` fills missing fields with
empty values. `load` of a missing file yields an empty store. `delete`
with the third argument `1` (default) removes the branch; with `0` the
children are attached to the root.

```tcl
package require tclutils::tunotes
set store [dict create]
set id [::tclutils::tunotes::create store Lager "Regal 3" {ort}]
dict get [::tclutils::tunotes::get $store $id] title
                                          ;# -> Lager
dict get [::tclutils::tunotes::get $store $id] tags
                                          ;# -> ort
::tclutils::tunotes::count $store           ;# -> 1
set gelesen [::tclutils::tunotes::fromJson {{"7":{"title":"Lager"}}}]
dict get [dict get $gelesen 7] title        ;# -> Lager
dict get [dict get $gelesen 7] parent_id    ;# ->
```

An unknown id throws `{TCLUTILS TUNOTES NOTFOUND}`, as does a `create`
with a missing parent.

---

## Notes in SQLite: tunotesdb

[tunotesdb]{.index} stores the same notes as `tunotes` in SQLite, one
row per note, with an FTS5 index for full-text search. Like `tusqlite`,
the module does not load `sqlite3`: the caller opens the database and
passes the handle. The note dict has the same structure as in
`tunotes`; `parent_id` is empty for a root.

`init db` creates the table, the FTS5 index and three triggers if they
are missing, and turns on `journal_mode = WAL` and `foreign_keys`. A
repeated call does no harm.

| Command | Effect |
|---|---|
| `create db titel inhalt ?tags? ?elter?` | the new id from `clock microseconds` |
| `update db id titel inhalt ?tags? ?elter?` | the id; `elter` defaults to `KEEP` and then stays |
| `get db id`, `exists db id` | the note dict, or 1 or 0 |
| `delete db id ?kaskade?` | `1` (default) deletes the branch, `0` turns the children into roots |
| `move db id elter` | the id; a note below itself or below a child is rejected |
| `ids db`, `count db` | all ids, or their number |
| `roots db`, `children db elter` | roots, or direct children; `children db ""` are the roots |
| `descendants`, `ancestors`, `parent`, `path`, `depth`, `siblings`, `subtree` | the tree via `WITH RECURSIVE`; `path` starts at the root |
| `search db frage ?optionen?` | hit dicts `id title snippet rank`, best first |
| `byTag db tag`, `tags db` | ids with the tag, or all tags, sorted |
| `toStore db`, `fromStore db store ?-clear 1?` | the bridge to a `tunotes` store |

| Option of `search` | Default | Effect |
|---|---|---|
| `-limit` | `50` | at most this many hits; `0` for all |
| `-snippet` | `10` | words of context in the snippet; the hit is enclosed in `[` `]` |

The query goes to FTS5 unchanged: several words mean AND,
`"wort folge"` is a phrase, `wort*` a prefix, and `OR` and `NOT` apply
as written. The tokenizer `unicode61` with `remove_diacritics 2`
searches without regard to case and accents. Tags are stored as a Tcl
list in one column; `byTag` compares in Tcl.

```tcl
package require sqlite3
package require tclutils::tunotesdb
sqlite3 db :memory:
::tclutils::tunotesdb::init db
set a [::tclutils::tunotesdb::create db Lager "Regal 3 Nord" ort]
set b [::tclutils::tunotesdb::create db Regal "Fach 2, Schrauben" \
    {} $a]
::tclutils::tunotesdb::count db             ;# -> 2
expr {[::tclutils::tunotesdb::parent db $b] == $a}
                                          ;# -> 1
::tclutils::tunotesdb::depth db $b          ;# -> 1
set h [lindex [::tclutils::tunotesdb::search db schraube*] 0]
dict get $h snippet                         ;# -> Fach 2, [Schrauben]
::tclutils::tunotesdb::tags db              ;# -> ort
```

`fromStore` reads the store in one transaction. A note with an existing
id is changed in place; its children in the database remain. The order
in the store does not matter, and a child may come before its parent:
the foreign key check waits until the end of the transaction. Every
`parent_id` must be in the store or in the database; otherwise
`fromStore` throws `NOTFOUND` and rolls everything back.

```tcl
set st [::tclutils::tunotesdb::toStore db]
dict set st $a title Lagerhalle
::tclutils::tunotesdb::fromStore db [dict create $a [dict get $st $a]]
                                          ;# -> 1
::tclutils::tunotesdb::count db             ;# -> 2
expr {[::tclutils::tunotesdb::path db $b] eq [list $a $b]}
                                          ;# -> 1
```

The `-errorcode` is `{TCLUTILS TUNOTESDB grund}`:

| Reason | Case |
|---|---|
| `NODB` | the handle is not a usable `sqlite3` command |
| `NOFTS5` | SQLite without FTS5 |
| `NOTFOUND` | no note with the id, or no such parent (also a `parent_id` passed to `fromStore`) |
| `CYCLE` | `move` below itself or a descendant |
| `BADQUERY` | FTS5 cannot parse the query, for example `"offen` |
| `BADOPTION` | unknown option, or `-limit` not a number ≥ 0 |
| `BADNOTE` | a note passed to `fromStore` lacks a field |

---

## Monthly Calendar: tucal

[tucal]{.index} prints calendars as text, like the `cal` command. The
PNG counterpart is `tumonthpng` in the chapter
[Images without Tk: PNG, SVG, Colors](058-bilder-ohne-tk.md).

| Command | Effect |
|---|---|
| `month ?monat? ?jahr? ?optionen?` | one month; without arguments the current month, without a year the current year (UTC) |
| `now ?…?` | the same as `month` |
| `render jahr monat ?optionen?` | one month, year first |
| `three ?monat? ?jahr? ?optionen?` | previous month, month and next month side by side |
| `year jahr ?optionen?` | the whole year in four rows of three months each |

A single four-digit number from 1900 passed to `month` counts as a
year and yields `year`. In `year` the months run row by row as in
`cal`: the first row shows January, February and March.

| Option | Default | Effect |
|---|---|---|
| `-mondayfirst` | `0` | `1` starts the week on Monday |
| `-weeknumbers` | `0` | `1` puts the week number on the left; with Monday first per ISO (`%V`), otherwise `%U` |
| `-iso` | `0` | `1` sets `-mondayfirst 1` and `-weeknumbers 1` |
| `-locale` | | locale of `clock format` for month and weekday names, such as `de_DE`; empty means English (`Su Mo Tu …`) |

Every option needs a value; `-iso` alone is not enough. The return
value is text with `\n`, without a trailing newline. A day cell is
three characters wide in `month`, `render` and `three`, and two in
`year`; a month is thus 27 or 20 characters wide, 4 more with week
numbers. The month title is centered above the day columns. `three`
and `year` place the months side by side with two spaces between
them; the year in `year` is centered over the full width. No line ends
with a space.

```tcl
package require tclutils::tucal
puts [::tclutils::tucal::month 5 2026 -locale de_DE -iso 1]
set kal [::tclutils::tucal::month 2 2026]
llength [split $kal \n]                     ;# -> 6
set titel [lindex [split $kal \n] 0]
string first F $titel                       ;# -> 7
string trim $titel                          ;# -> February 2026
set j [split [::tclutils::tucal::year 2026] \n]
regexp -all -inline {[A-Z][a-z]+} [lindex $j 2]
                                          ;# -> January February March
```

The output of `puts`:

```text
             Mai 2026
     Mo  Di  Mi  Do  Fr  Sa  So
18                    1   2   3
19    4   5   6   7   8   9  10
20   11  12  13  14  15  16  17
21   18  19  20  21  22  23  24
22   25  26  27  28  29  30  31
```

A month outside 1–12 throws `{TCLUTILS TUCAL MONTH}`, a year less
than 1 `{TCLUTILS TUCAL YEAR}`. More than two numbers throw
`{TCLUTILS TUCAL ARGS}`, an option without a value
`{TCLUTILS TUCAL OPTION}`, an unknown option
`{TCLUTILS COMMON OPTION -name}`.

---

## Public Holidays: tuholiday

`easter` calculates Easter Sunday in the Gregorian calendar
(Meeus/Jones/Butcher) and returns an ISO date. `holidays` returns a
dict mapping date to name, sorted. `-region` knows only `de`: the
days that apply in all German states, plus Easter Sunday and
Whit Sunday. Epiphany, Corpus Christi, All Saints' Day and Reformation
Day are missing. `isHoliday` returns the name or the empty string.

| Offset from Easter | Name |
|---|---|
| −2 | Karfreitag (Good Friday) |
| 0 | Ostersonntag (Easter Sunday) |
| +1 | Ostermontag (Easter Monday) |
| +39 | Christi Himmelfahrt (Ascension Day) |
| +49 | Pfingstsonntag (Whit Sunday) |
| +50 | Pfingstmontag (Whit Monday) |

Fixed dates are New Year's Day, Labor Day (May 1), the Day of German
Unity and the two Christmas holidays. For 2024 the dict has eleven
entries.

```tcl
package require tclutils::tuholiday
::tclutils::tuholiday::easter 2024           ;# -> 2024-03-31
::tclutils::tuholiday::easter 2025           ;# -> 2025-04-20
::tclutils::tuholiday::isHoliday 2024-03-31  ;# -> Ostersonntag
::tclutils::tuholiday::isHoliday 2024-03-15  ;# ->
```

`easter xyz` throws `{TCLUTILS TUHOLIDAY YEAR}`. `-region at` throws
`{TCLUTILS TUHOLIDAY REGION}`.

---

## Calendar Views: tical

The modules of this chapter deliver data and text: recurrences,
holidays, iCalendar, a month like `cal`. Views for month, week and day
with renderers for the terminal, the Tk canvas and PDF come with the
separate library [tical]{.index} 1.1. It has its own holidays and an
iCalendar export (with `RRULE`); its core does not need tclutils. Its
optional import (`tical::io::import`) reads iCalendar with `tuical` and
expands recurrences with `turrule`. It is described in the book
*Utils-Stack*.

---

## In short

- `tumd` is a subset. The anchor of `Größe` is `gre`.
- iCalendar and vCard values stay raw. `eventInfo` unescapes text.
- `toIcs` and `toVcf` write CR/LF.
- `tunotes`: change through the variable name, read through the value.
- Public holidays: only `de`, eleven names, no state-specific days.
- `turrule` needs a limit: `-to`, `-count`, `COUNT` or `UNTIL`. Unsupported parts throw `UNSUPPORTED`.
- `tunotesdb`: open the handle yourself, then `init`. `fromStore` changes existing notes in place.
- `tucal` is text like `cal`; as PNG `tumonthpng`.

---

*Next chapter: [Text from PDF Files](055-pdf-text.md)*
