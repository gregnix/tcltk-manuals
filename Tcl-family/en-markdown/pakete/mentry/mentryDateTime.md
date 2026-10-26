# Multi-Entry Widgets for Date and Time

## For Mentry Version 4.5

### by

## Csaba Nemethi

csaba.nemethi@t-online.de

---

## Contents

- [The mentry::dateMentry Command](#the-mentry-datementry-command)
- [The mentry::timeMentry Command](#the-mentry-timementry-command)
- [The mentry::dateTimeMentry Command](#the-mentry-datetimementry-command)
- [The mentry::putClockVal Command](#the-mentry-putclockval-command)
- [The mentry::getClockVal Command](#the-mentry-getclockval-command)

[Start page](index.md)

---

## The `mentry::dateMentry` Command

**NAME**
: `mentry::dateMentry` – Create and manipulate mentry widgets for date

**SYNOPSIS**
: 

```
mentry::dateMentry pathName format separator ?options?
```

**DESCRIPTION**
: This command creates a new mentry widget `pathName` for displaying and editing a date according to the `format` argument, which must be a string of length 3, consisting of the letters `"d"` for the day (`01` - `31`), `"m"` for the month (`01` - `12`), and `"y"` or `"Y"` for the year without century (`00` - `99`) or with century (e.g., `2008`), in an arbitrary order.  These field descriptor characters have the same meanings as in the  `clock format`  command.  The `separator` argument specifies the text to be displayed in the labels separating the three entry components of the mentry widget (the most common values are the `"/"`, `"-"`, and `"."` characters).  The supported `options` are the same as in the case of the `mentry::mentry` command.

: The command sets the `type` attribute of the widget to the value `"Date"`, saves the value of `format` in its `format` attribute, and returns the name of the newly created widget.

**DEFAULT BINDINGS**
: The `mentry::dateMentry` command defines four new keyboard bindings for the entry components of the mentry widget it creates:  The `Up` key increments the entry's value by 1 if the latter is less than the allowed maximum for that component.  Similarly, the `Down` key decrements the entry's value by 1 if the latter is greater than the allowed minimum for that component.  The `Prior` key increments the entry's value by at most 10 if the latter is less than the allowed maximum for that component.  Similarly, the `Next` key decrements the entry's value by at most 10 if the latter is greater than the allowed minimum for that component.  If the entry is empty then all of these keys insert the component-specific minimum value into the entry.

: The actions performed by the `Up` and `Down` keys can also be triggered with the aid of the mouse wheel or a two-finger gesture on the touchpad.  In addition, on Mac OS X/11+ Aqua, the actions performed by the `Prior` and `Next` keys are also triggered by the `<Option-MouseWheel>` event.  The same holds true on all windowing systems if the Tk version is 8.7a4 or later, where the `Option` modifier is bound to the `Option` key on Mac OS X/11+ and to the `Alt` key on Windows and X11.

**KEYWORDS**
: mentry, widget, date


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::timeMentry` Command

**NAME**
: `mentry::timeMentry` – Create and manipulate mentry widgets for time

**SYNOPSIS**
: 

```
mentry::timeMentry pathName format separator ?options?
```

**DESCRIPTION**
: This command creates a new mentry widget `pathName` for displaying and editing a time according to the `format` argument, which must be a string of length 2 or 3, consisting of the following field descriptor characters of the  `clock format`  command: `"H"` or `"I"`, followed by `"M"`, and optionally the letter `"S"`.  An `"H"` as first character specifies the time format `"%H:%M"` or `"%H:%M:%S"` (i.e., with the hour between `0` and `23`), while the letter `"I"` stands for  `"%I:%M %p"`  or  `"%I:%M:%S %p"`  (i.e., with AM/PM indicator).  The `separator` argument specifies the text to be displayed in the labels separating the entry components of the mentry widget (this is usually the `":"` character).  The `options` are the same as in the case of the `mentry::mentry` command.

: The command sets the `type` attribute of the widget to the value `"Time"`, saves the value of `format` in its `format` attribute, and returns the name of the newly created widget.

**DEFAULT BINDINGS**
: The `mentry::timeMentry` command defines four new keyboard bindings for the entry components of the mentry widget it creates:  The `Up` key increments the entry's value by 1 if the latter is less than the allowed maximum for that component.  Similarly, the `Down` key decrements the entry's value by 1 if the latter is greater than the allowed minimum for that component.  The `Prior` key increments the entry's value by at most 10 if the latter is less than the allowed maximum for that component.  Similarly, the `Next` key decrements the entry's value by at most 10 if the latter is greater than the allowed minimum for that component.  If the entry is empty then all of these keys insert the component-specific minimum value into the entry.

: The actions performed by the `Up` and `Down` keys can also be triggered with the aid of the mouse wheel or a two-finger gesture on the touchpad.  In addition, on Mac OS X/11+ Aqua, the actions performed by the `Prior` and `Next` keys are also triggered by the `<Option-MouseWheel>` event.  The same holds true on all windowing systems if the Tk version is 8.7a4 or later, where the `Option` modifier is bound to the `Option` key on Mac OS X/11+ and to the `Alt` key on Windows and X11.

**KEYWORDS**
: mentry, widget, time


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::dateTimeMentry` Command

**NAME**
: `mentry::dateTimeMentry` – Create and manipulate mentry widgets for date & time

**SYNOPSIS**
: 

```
mentry::dateTimeMentry pathName format dateSeparator timeSeparator ?options?
```

**DESCRIPTION**
: This command creates a new mentry widget `pathName` for displaying and editing a date & time according to the `format` argument, which must be a string of length 5 or 6, with the first 3 characters consisting of the letters `"d"` for the day (`01` - `31`), `"m"` for the month (`01` - `12`), and `"y"` or `"Y"` for the year without century (`00` - `99`) or with century (e.g., `2008`), in an arbitrary order, followed by 2 or 3 further field descriptor characters of the `clock format`  command, which must be: `"H"` or `"I"`, then `"M"`, and optionally the letter `"S"`.  An `"H"` specifies the time format `"%H:%M"` or `"%H:%M:%S"` (i.e., with the hour between `0` and `23`), while the letter `"I"` stands for  `"%I:%M %p"`  or  `"%I:%M:%S %p"`  (i.e., with AM/PM indicator).  The `dateSeparator` argument specifies the text to be displayed in the labels separating the entry components in the date part of the mentry widget (the most common values are the `"/"`, `"-"`, and `"."` characters).  Similarly, the `timeSeparator` argument stands for the text to be displayed in the labels separating the entry components in the time part of mentry widget (this is usually the `":"` character).  The date and time parts in turn are separated from each other by a space character.  The supported `options` are the same as in the case of the `mentry::mentry` command.

: The command sets the `type` attribute of the widget to the value `"DateTime"`, saves the value of `format` in its `format` attribute, and returns the name of the newly created widget.

**DEFAULT BINDINGS**
: The `mentry::dateTimeMentry` command defines four new keyboard bindings for the entry components of the mentry widget it creates:  The `Up` key increments the entry's value by 1 if the latter is less than the allowed maximum for that component.  Similarly, the `Down` key decrements the entry's value by 1 if the latter is greater than the allowed minimum for that component.  The `Prior` key increments the entry's value by at most 10 if the latter is less than the allowed maximum for that component.  Similarly, the `Next` key decrements the entry's value by at most 10 if the latter is greater than the allowed minimum for that component.  If the entry is empty then all of these keys insert the component-specific minimum value into the entry.

: The actions performed by the `Up` and `Down` keys can also be triggered with the aid of the mouse wheel or a two-finger gesture on the touchpad.  In addition, on Mac OS X/11+ Aqua, the actions performed by the `Prior` and `Next` keys are also triggered by the `<Option-MouseWheel>` event.  The same holds true on all windowing systems if the Tk version is 8.7a4 or later, where the `Option` modifier is bound to the `Option` key on Mac OS X/11+ and to the `Alt` key on Windows and X11.

**KEYWORDS**
: mentry, widget, date, time


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::putClockVal` Command

**NAME**
: `mentry::putClockVal` – Output a clock value to a date, time, or date & time mentry

**SYNOPSIS**
: 

```
mentry::putClockVal clockValue pathName ?-gmt boolean?
```

**DESCRIPTION**
: This command outputs the date, time, or date & time corresponding to the integer `clockValue` to the mentry widget `pathName`, which must have been created with the `mentry::dateMentry`, `mentry::timeMentry`, or `mentry::dateTimeMentry` command (this is checked by examining the widget's `type` attribute, which must have the value `"Date"`, `"Time"`, or `"DateTime"`).

: Like in the case of the  `clock format`  command, the optional argument pair  `-gmt boolean` specifies whether the clock value is to be formatted as Greenwich Mean Time or according to the local timezone as defined by the operating environment.

**KEYWORDS**
: mentry, widget, date, time, clock


[Contents](#contents)     [Start page](index.md)

---

## The `mentry::getClockVal` Command

**NAME**
: `mentry::getClockVal` – Get the clock value from a date, time, or date & time mentry

**SYNOPSIS**
: 

```
mentry::getClockVal pathName ?-base clockValue? ?-gmt boolean?
```

**DESCRIPTION**
: This command returns the clock value corresponding to the date, time, or date & time contained in the mentry widget `pathName`, which must have been created with the `mentry::dateMentry`, `mentry::timeMentry`, or `mentry::dateTimeMentry` command (this is checked by examining the widget's `type` attribute, which must have the value `"Date"`, `"Time"`, or `"DateTime"`).

: Like in the case of the  `clock scan`  command, the optional argument pair  `-base clockValue` specifies that the date contained in `clockValue` is to be used when getting the clock value from the given mentry widget, and the optional argument pair  `-gmt boolean` specifies whether the clock value is to be calculated relative to Greenwich Mean Time or according to the local timezone as defined by the operating environment.

: If an error occurs during the conversion, the command sets the focus to the first erronous entry component, generates an error, and returns one of the values contained in the following table:


| Return Value | Meaning |
| --- | --- |
| `"EMPTY"` | Any entry component (except the one containing the seconds) is empty. |
| `"BAD"` | The value of the day, month, or hour (the latter only if the AM/PM indicator is present) is `0`. |
| `"BAD_DATE"` | The \<year, month, day> triple is invalid (note that the command is aware of leap years). |
| `"BAD_YEAR"` | The above triple is valid, but the conversion (made with the aid of the  `clock scan`  command) failed because of an unsupported year value (e.g., between `38` and `70`). |

**KEYWORDS**
: mentry, widget, date, time, clock


[Contents](#contents)     [Start page](index.md)
