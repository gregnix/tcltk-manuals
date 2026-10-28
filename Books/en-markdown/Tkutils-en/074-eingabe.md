# Input

Forms, single labeled fields and the specialized inputs for date, time,
number and tags. Validation relies on `tclutils::tuvalidate`. All
modules of this chapter are in the umbrella.

---

## Form: tkuform

[tkuform]{.index} 0.1 builds a form from a list of field dicts and reads
the values as a dict. `tkudialog::form` uses the same module. The dialog
is in the chapter [Dialogs](030-dialoge.md).

A field needs `name`. In addition: `label`, `type`, `default`, `values`
for `combo`, `state` for `combo` (`normal` or `readonly`), `from` and
`to` for `spin`, `height` for `text`. The type is `entry`, `password`,
`check`, `combo`, `spin` or `text`, default `entry`.

```tcl
set w [::tkutils::tkuform::widget .w $felder ?-padding 8? ?-columns 1?]
::tkutils::tkuform::values    $w
::tkutils::tkuform::get       $w name
::tkutils::tkuform::setField  $w name wert
::tkutils::tkuform::setValues $w dict
::tkutils::tkuform::fieldNames $w
::tkutils::tkuform::widgetOf  $w name
```

`values` returns a dict of name to value. `setValues` skips unknown
keys. `setField` is named so that `set` stays free. `-columns` puts
several label/field pairs side by side. A field of type `text` always
takes a line of its own across the full width.

| Code | Cause |
|---|---|
| `{TKUTILS TKUFORM OPTION}` | unknown widget option |
| `{TKUTILS TKUFORM VALUE}` | unusable `-columns` |
| `{TKUTILS TKUFORM SPEC}` | field without `name` |
| `{TKUTILS TKUFORM TYPE}` | unknown field type |

---

## One Line: tkulabeled

[tkulabeled]{.index} 0.1 is a line of label and control, for when a
whole form is too much. The type is a value: `entry`, `combo`, `spin`,
`check` or `text`.

```tcl
::tkutils::tkulabeled::add $pfad $typ \
    ?-label text? ?-labelwidth n? ?-orient horizontal|vertical? ?weitere Optionen?
::tkutils::tkulabeled::value       $pfad ?neu?
::tkutils::tkulabeled::control     $pfad
::tkutils::tkulabeled::labelwidget $pfad
```

With one argument it reads the value, with two it sets it. Options
other than `-label`, `-labelwidth` and `-orient` go to the inner
control.

---

## Validation: tkuvalidate

[tkuvalidate]{.index} 0.1 attaches a check to an entry, combo or
spinbox. An invalid value turns the text red, sets the ttk state
`invalid` and shows the reason through `tkuballoon`.

```tcl
::tkutils::tkuvalidate::attach $w $prüfer \
    ?-message text? ?-when focusout|key|both? ?-allowempty 0|1? \
    ?-onvalid befehl? ?-oninvalid befehl?
::tkutils::tkuvalidate::check    $w
::tkutils::tkuvalidate::valid    $w
::tkutils::tkuvalidate::clear    $w
::tkutils::tkuvalidate::allValid {w ...}
```

`$prüfer` is a name from `tclutils::tuvalidate` (`email`, `url`,
`ipv4`, `port`, `alpha`, `alnum`, `numeric`, `integer`) or a command
prefix. The field's value is appended. The prefix returns a boolean.
`check` and `allValid` return `0` or `1`. `clear` removes highlighting
and binding.

---

## Date: tkudateentry

[tkudateentry]{.index} 0.1 is a field plus a month calendar to drop
down. Monday comes first. `getDate` always returns `yyyy-mm-dd`, or
`""` when the field is empty or invalid. The display follows
`-dateformat`.

```tcl
set w [::tkutils::tkudateentry::widget .d \
    ?-dateformat fmt? ?-width n? ?-textvariable var? ?-command befehl?]
::tkutils::tkudateentry::getText $w
::tkutils::tkudateentry::getDate $w
::tkutils::tkudateentry::setDate $w iso
::tkutils::tkudateentry::today   $w
::tkutils::tkudateentry::clear   $w
```

`-command` receives the ISO date, the empty string on clearing.
`setDate` with a text that is not an ISO date raises
`{TKUTILS TKDATEENTRY DATE}`. An empty `setDate` clears the field.

The month to click without an input line is `tkucalendar` in the
chapter [Calendar and Notes](076-kalender-und-notizen.md).

---

## Time: tkutimeentry

[tkutimeentry]{.index} 0.1 shows hour and minute as spinboxes, with
`-seconds` also the second. `getTime` and `setTime` use `HH:MM` or
`HH:MM:SS`.

```tcl
set w [::tkutils::tkutimeentry::widget .t \
    ?-time HH:MM? ?-increment min? ?-seconds 0|1? ?-command befehl?]
::tkutils::tkutimeentry::getTime $w
::tkutils::tkutimeentry::setTime $w 09:30
```

`-increment` is the minute step, default 5. `-command` receives the
time on every change. An unusable `setTime` raises
`{TKUTILS TKTIMEENTRY TIME}`.

---

## Number: tkunumentry

[tkunumentry]{.index} 0.1 allows typing only a number with at most
`-decimals` decimal places. Clamping and reformatting happen on commit,
i.e. Return or loss of focus.

```tcl
set w [::tkutils::tkunumentry::widget .n \
    ?-decimals n? ?-min v? ?-max v? ?-textvariable var? ?-width n? ?-command befehl?]
::tkutils::tkunumentry::getValue $w
::tkutils::tkunumentry::setValue $w 3.14
::tkutils::tkunumentry::clear    $w
```

`getValue` returns the number, or `""` when the field is empty.
`setValue` with a text that is not a number raises
`{TKUTILS TKNUMENTRY VALUE}`. `-command` receives the value on commit.

---

## Tags: tkutags

[tkutags]{.index} 0.1 shows tags as removable chips. Return or "+" adds
one. Duplicates and empty ones are dropped. With `-readonly`, input and
remove button are missing. `-suggestions` turns the field into a
combobox.

```tcl
set w [::tkutils::tkutags::widget .t \
    ?-tags liste? ?-suggestions liste? ?-textvariable var? ?-readonly 0|1? ?-command befehl?]
::tkutils::tkutags::getTags   $w
::tkutils::tkutags::setTags   $w liste
::tkutils::tkutags::addTag    $w tag
::tkutils::tkutags::removeTag $w tag
::tkutils::tkutags::clear     $w
```

`-textvariable` mirrors the list. If `-tags` is empty, the variable
sets the initial value. `-command` receives the list on every change.

---

## In short

- `tkuform::values` is a dict. `setField` sets one field.
- `tkuvalidate` takes the names from `tclutils::tuvalidate` or a command
  of your own.
- `tkudateentry::getDate` is ISO, the display follows `-dateformat`.
- `tkunumentry` formats on commit, not on every keystroke.

---

*Next chapter: [Calendar and Notes](076-kalender-und-notizen.md)*
