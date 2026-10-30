# Calendar and Notes

Month, week and tasks in the user interface. The engines stay in
tclutils (`tucal`, `tuical`, `tunotes`, `tuvcard`, `tuldif`). `tkutical`
and `tkumonthcanvas` also need tical and are outside the umbrella. How
tical gets onto the `auto_path` is in the chapter
[Understanding tkutils](010-tkutils-verstehen.md); tical itself, its
views and renderers are described in the book *Utils-Stack*.

---

## A Month to Click: tkucalendar

[tkucalendar]{.index} 0.2 is a month of day buttons.

```tcl
::tkutils::tkucalendar::widget       pfad ?option wert ...?
::tkutils::tkucalendar::getDate      pfad
::tkutils::tkucalendar::getFormatted pfad
::tkutils::tkucalendar::setDate      pfad iso
::tkutils::tkucalendar::today        pfad
::tkutils::tkucalendar::next         pfad
::tkutils::tkucalendar::prev         pfad
::tkutils::tkucalendar::getMonth     pfad
```

`getDate` returns the selected ISO date or `""`. `getFormatted` uses
`-dateformat`. `getMonth` returns `yyyy mm` of the displayed month.
`next` and `prev` page by one month.

| Option | Default | Effect |
|---|---|---|
| `-date` | none | initially selected day, ISO |
| `-firstday` | `monday` | `monday` or `sunday` |
| `-dateformat` | `%Y-%m-%d` | format for `getFormatted` |
| `-locale` | the current one | names of months and weekdays |
| `-command` | empty | script, the ISO date is appended |

The input line with the same calendar as a drop-down is `tkudateentry`
in the chapter [Input](074-eingabe.md).

---

## Text Calendar: tkucal

[tkucal]{.index} 0.1 shows the month as text through `tclutils::tucal`.

```tcl
set w [::tkutils::tkucal::widget .w ?-year j? ?-month m? ?-weeknumbers 0|1?]
::tkutils::tkucal::setMonth $w jahr monat
::tkutils::tkucal::getMonth $w
::tkutils::tkucal::next     $w
::tkutils::tkucal::prev     $w
::tkutils::tkucal::today    $w
::tkutils::tkucal::getText  $w
```

`setMonth` and `getMonth` return `{year month}`. An invalid month raises
the error of `tucal`, for example `{TCLUTILS TUCAL MONTH}` with
`invalid month 13`. The week starts on Sunday, as with `cal`.
`getText` is the drawn calendar text.

---

## tical: tkutical and tkumonthcanvas

[tkutical]{.index} 0.4 draws a month or a week through tical.

```tcl
set w [::tkutils::tkutical::widget .w ?-year j? ?-month m? \
    ?-weeknumbers 0|1? ?-fontsize n? ?-holidays region? \
    ?-selectmode none|single|multiple? ?-command befehl? ?-events liste?]
::tkutils::tkutical::setMonth $w jahr monat
::tkutils::tkutical::getSelection $w
::tkutils::tkutical::setSelection $w {daten und A..B}
```

`setMonth` returns `{year month}` and raises an error for an invalid
month. `getSelection` returns sorted ISO dates. `-events` and
`setEvents` (since 0.4) take appointments in the format of
`tical::event`; they appear as dots in the month and as titles in the
week, a series on each of its days. This needs tical 1.1 or later,
otherwise `{TKUTILS TKUTICAL EVENTS}`.

[tkumonthcanvas]{.index} 0.5 draws month, quarter and year onto an
existing canvas. `init` sets font and theme before drawing.

```tcl
::tkutils::tkumonthcanvas::init ?-fontsize 11? ?-font Arial?
::tkutils::tkumonthcanvas::drawMonth   $c jahr monat ?x0 y0?
::tkutils::tkumonthcanvas::drawQuarter $c jahr monat ?x0 y0?
::tkutils::tkumonthcanvas::drawYear    $c jahr ?x0 y0 spalten?
::tkutils::tkumonthcanvas::clear       $c
::tkutils::tkumonthcanvas::setSelectMode none|single|multiple
::tkutils::tkumonthcanvas::getSelection
::tkutils::tkumonthcanvas::setTheme default|dark|light
::tkutils::tkumonthcanvas::addNote datum text
```

`drawQuarter` takes any month of the quarter. `setCallback` knows `day`,
`week`, `month` and `select`. Themes are `default`, `dark` and `light`,
plus `defineTheme`.

---

## Appointments: tkuical

[tkuical]{.index} 0.3 shows the `VEVENT` entries of an iCalendar text in
a table: summary, start, end, location. The engine is
`tclutils::tuical`.

```tcl
set w [::tkutils::tkuical::widget .w]
::tkutils::tkuical::loadText      $w text
::tkutils::tkuical::loadFile      $w datei
::tkutils::tkuical::setComponents $w komponenten
::tkutils::tkuical::events        $w
::tkutils::tkuical::count         $w
::tkutils::tkuical::toText        $w
::tkutils::tkuical::save          $w datei
```

`loadText` returns the number of appointments. `-editable 1` is the
default and shows a bar for summary, start, end and location.
`addEvent`, `removeEvent` and `setField` change an appointment.
`setField` knows `summary`, `start`, `end` and `location`. Other
properties and components that are not appointments are kept when
writing, in their place: a to-do after the appointment stays after it. `loadFile` and `save` work in UTF-8, whatever the system
encoding; `save` writes the CRLF line ends once (up to 0.2
`\r\r\n`). With `tuical` 0.2 the last line ends with CRLF too; a file
read and written without change then stays the same apart from the
folding of long lines.

---

## Tasks: tkutodo

[tkutodo]{.index} 0.2 shows `VTODO` components: summary, due date,
priority, percent. `-editable 1` lets the status be toggled, also with
the space bar and a double click.

```tcl
set w [::tkutils::tkutodo::widget .t ?-editable 1? ?-onchange befehl?]
::tkutils::tkutodo::loadText $w text
::tkutils::tkutodo::setTodos $w komponenten
::tkutils::tkutodo::todos    $w
::tkutils::tkutodo::count    $w
::tkutils::tkutodo::toggle   $w ?index?
```

Done sets `STATUS` to `COMPLETED`, `PERCENT-COMPLETE` to `100` and a
timestamp `COMPLETED`. Back sets `NEEDS-ACTION`, `PERCENT-COMPLETE` to
`0` and removes `COMPLETED`.

---

## Notes: tkunotes

[tkunotes]{.index} 0.4 is a tree on the left and an editor on the right.
Storage and search come from `tclutils::tunotes`.

```tcl
set w [::tkutils::tkunotes::widget .w ?-file notizen.json? ?-toolbar 0?]
::tkutils::tkunotes::addRoot  $w titel inhalt ?tags?
::tkutils::tkunotes::addChild $w eltern titel inhalt ?tags?
::tkutils::tkunotes::commit   $w ?id?
::tkutils::tkunotes::delete   $w id ?cascade?
::tkutils::tkunotes::search   $w text
::tkutils::tkunotes::load     $w datei
::tkutils::tkunotes::save     $w ?datei?
::tkutils::tkunotes::store    $w
```

`addRoot` returns the id. `search` returns ids. `load` returns the
count. `commit` writes the editor fields into the store. `store` is the
dict of `tunotes`. The toolbar is on; `-toolbar 0` hides it. Its Save
button takes the fields and since 0.3 also writes the JSON file
(`-file`, the one loaded or saved last, else it asks); up to 0.2 it only
did `commit`. In the Tags field a comma separates the tags,
`Arbeit Büro, privat` is two (up to 0.2 every word was a tag). Since
0.4 edits are kept when another note is chosen (click in the tree,
`select`, new note, search hit): title, tags and content of the
previous note go into the store. Up to 0.3 they were lost without
Save. Only Save or `save` writes the file.

---

## Contacts and LDIF

[tkuvcard]{.index} 0.3 shows every card as a node with `FN` and the
properties as children. The engine is `tclutils::tuvcard`.

```tcl
set w [::tkutils::tkuvcard::widget .w]
::tkutils::tkuvcard::loadText $w text
::tkutils::tkuvcard::cards    $w
::tkutils::tkuvcard::count    $w
```

`loadText` returns the number of cards. `-editable 1` is the default.
`setProperty` changes name, value and `TYPE` of a line and keeps the
other parameters such as `PREF` (up to 0.2 they were lost); several
types are separated by commas (`"CELL, VOICE"`). `tkuvcard` reads and
writes files in UTF-8 with CRLF.

[tkuldif]{.index} 0.3 shows every LDIF entry as a node with `dn` and
every attribute line as a child. The engine is `tclutils::tuldif`.
`loadText` returns the number of entries. `-editable 1` is the default.
`entries` returns the entries. Files in UTF-8. With `tuldif` 0.3,
binary attributes such as `jpegPhoto` keep their bytes when saved.

---

## Calculator: tkucalc

[tkucalc]{.index} 0.2 is a pocket calculator. `evaluate` computes
without a window; the package requires Tk anyway.

```tcl
::tkutils::tkucalc::widget       pfad ?-onresult befehl? ?-history 0?
::tkutils::tkucalc::evaluate     text
::tkutils::tkucalc::clear        pfad
::tkutils::tkucalc::getHistory   pfad
::tkutils::tkucalc::clearHistory pfad
```

`evaluate` replaces the German decimal comma with a dot, `^` with `**`
and the characters × ÷ − with `*` `/` `-`. Apart from digits, operators,
parentheses, dot, `e`, spaces, `^` and `%`, the text raises
`invalid characters in expression`. An empty text raises
`empty expression`. Neither has its own `-errorcode`.

Without `%`, every integer becomes `n.0`, so that `10/4` is a
floating-point division. With `%` the number stays an integer, because
modulo needs integer operands. The computation runs in a safe
interpreter. `Inf`, `-Inf` and `NaN` become `divide by zero`. A result
ending in `.0` loses that ending.

`-history 1` shows the previous lines. `-onresult` receives the result.

---

## In short

- `tkucalendar::getDate` is ISO. `getFormatted` follows `-dateformat`.
- `tkutical` and `tkumonthcanvas` need tical and their own
  `package require`.
- `tkuical` and `tkutodo` read iCalendar through `tuical`.
- `tkucalc::evaluate` computes in a safe interpreter.

---

*Next chapter: [Viewing Data](078-daten-ansehen.md)*
