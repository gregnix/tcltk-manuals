# Scaffolding

Actions and the launcher are in the chapter
[Actions and Layout](070-aktionen-und-layout.md). This chapter holds the
bars, tabs, tooltips and the small helpers for focus, mouse wheel and
selection rectangle. The modules belong to the umbrella, except
`tkuscrolledframe`.

---

## Toolbar: tkutoolbar

[tkutoolbar]{.index} 0.2 builds a bar of buttons, toggles, drop-down
menus, separators and embedded widgets. Every piece has an id.

```tcl
set tb [::tkutils::tkutoolbar::widget .tb \
    ?-orient horizontal|vertical? ?-displaymode icon|text|both? \
    ?-spacing px? ?-padding px? ?-buttonstyle flat|raised?]
::tkutils::tkutoolbar::addButton   $tb id label befehl ?-icon bild? ?-tooltip text? ?-shortcut taste?
::tkutils::tkutoolbar::addToggle   $tb id label varname ?-onvalue v? ?-offvalue v?
::tkutils::tkutoolbar::addDropdown $tb id label ?-menu {{label befehl} ...}?
::tkutils::tkutoolbar::addSeparator $tb
::tkutils::tkutoolbar::addWidget    $tb id kind ?seite?
```

`-buttonstyle` is `flat`. `raised` gives buttons a border. Toggles stay
flat. `-shortcut` binds on the toplevel and goes away when the bar is
destroyed. Tooltips go through `tkuballoon`. Without an icon, the mode
`icon` shows the text.

```tcl
::tkutils::tkutoolbar::setEnabled     $tb id 0|1
::tkutils::tkutoolbar::setDisplayMode $tb icon|text|both
::tkutils::tkutoolbar::buttonWidget   $tb id
::tkutils::tkutoolbar::items          $tb
```

Errors `{TKUTILS TKUTOOLBAR <GRUND>}`: `OPTION`, `ORIENT`,
`DISPLAYMODE`, `BUTTONSTYLE`, `NOITEM`, `NOTOOLBAR`.

---

## Status: tkustatus

[tkustatus]{.index} 0.2 has a main line, named fields and a progress
bar. The accessors are called `setText` and `getText`, so that `set`
stays free.

```tcl
set st [::tkutils::tkustatus::widget .st]
::tkutils::tkustatus::setText   $st text
::tkutils::tkustatus::getText   $st
::tkutils::tkustatus::addField  $st id ?-width n?
::tkutils::tkustatus::setField  $st id text
::tkutils::tkustatus::fieldText $st id
::tkutils::tkustatus::progress  $st ?0..100?
::tkutils::tkustatus::flash     $st text ?ms?
```

`progress` without a value or with an empty value hides the bar.
`flash` shows the text and restores the previous line afterwards.

---

## Tabs: tkutab

[tkutab]{.index} 0.2 is a `ttk::notebook` with a "+" button and
closable tabs. `add` returns the frame of the new tab. `current` returns
the frame of the active one, `tabs` the frames in order, `count` the
number.

| Option | Effect |
|---|---|
| `-onnew` | script on "+" |
| `-onclose` | script, the frame being closed is appended |
| `-onselect` | script, the selected frame is appended |

Closing works through `close` and the middle mouse button.

---

## Tree: tkutree

[tkutree]{.index} 0.2 is a thin `ttk::treeview`. `tkufiletree` sits on
top of it. The file window is in the chapter
[File Widgets](040-datei-widgets.md).

```tcl
set w [::tkutils::tkutree::widget .tr ?-columns ids? ?-headings texte? \
    ?-show spec? ?-height n? ?-command befehl?]
::tkutils::tkutree::insert   $w eltern text ?-values liste? ?-open 0|1? ?-id id?
::tkutils::tkutree::loadTree $w knoten
::tkutils::tkutree::selection $w
::tkutils::tkutree::itemText  $w id
::tkutils::tkutree::children  $w ?id?
::tkutils::tkutree::treeview  $w
```

---

## Tooltip: tkuballoon

[tkuballoon]{.index} 0.1 attaches a tooltip to any widget.

```tcl
::tkutils::tkuballoon::add       $w text ?-delay ms? ?-wraplength px?
::tkutils::tkuballoon::clear     $w
::tkutils::tkuballoon::configure ?-delay ms? ?-wraplength px?
::tkutils::tkuballoon::cget      option
::tkutils::tkuballoon::enable
::tkutils::tkuballoon::disable
```

The defaults are 600 ms and a wrap length of 320 pixels. `disable`
turns all tooltips off and hides an open one.

---

## Context Menu: tkucontextmenu

[tkucontextmenu]{.index} 0.1 builds menus and binds them to the
platform's context button: button 3 on X11 and Windows, button 2 and
Control-click on macOS.

```tcl
set m [::tkutils::tkucontextmenu::create .m ?-tearoff 0|1? ?-dynamic 0|1?]
::tkutils::tkucontextmenu::addItem     $m label ?-command befehl? ?-accelerator text?
::tkutils::tkucontextmenu::addCheckItem $m label ?-variable v?
::tkutils::tkucontextmenu::addRadioItem $m label -variable v -value wert
::tkutils::tkucontextmenu::addSeparator $m
::tkutils::tkucontextmenu::addSubmenu   $m label $unter
::tkutils::tkucontextmenu::attach       $m $w ?-button 2|3?
::tkutils::tkucontextmenu::show         $m x y
```

`enable` and `disable` address an entry by its label.
`createStandardEdit` creates the usual edit entries. `createFromSpec`
takes a list of entries.

---

## Keys: tkubind

[tkubind]{.index} 0.1 writes `Mod` as Control on X11 and Windows and as
Command on macOS. Global shortcuts stay active while an entry field, a
text or a Tablelist has the focus.

```tcl
set id [::tkutils::tkubind::key "Mod-s" {speichern} ?-toplevel .? ?-id name?]
::tkutils::tkubind::unbind $id
::tkutils::tkubind::accelerator "Mod-Shift-p"
::tkutils::tkubind::isEditing
::tkutils::tkubind::platform ?schlüssel?
::tkutils::tkubind::context     $w {menü %X %Y}
::tkutils::tkubind::doubleClick $w {öffnen %W}
```

`accelerator` returns `Ctrl+Shift+P` on X11 and Windows, `@^P` on macOS.
Groups switch several shortcuts together:

```tcl
::tkutils::tkubind::group define editKeys {{Mod-b {fett}} {Mod-i {kursiv}}}
::tkutils::tkubind::group enable  editKeys ?-toplevel .?
::tkutils::tkubind::group enabled editKeys
```

`clear` removes all bindings and groups.

---

## Focus: tkukeynav

[tkukeynav]{.index} 0.1 moves the focus and binds Return and Escape.

```tcl
::tkutils::tkukeynav::next $w
::tkutils::tkukeynav::prev $w
::tkutils::tkukeynav::enable $w ?-onreturn befehl? ?-onescape befehl? ?-tab 0|1?
::tkutils::tkukeynav::disable $w
::tkutils::tkukeynav::form $rahmen ?-onsubmit befehl? ?-wrap 0|1? ?-onescape befehl?
```

`next` and `prev` return the widget that gets the focus. `form` binds
the input fields in the frame.

---

## Search and Filter

[tkusearchbar]{.index} 0.1 is a field with a clear button and an
optional filter list. Typing calls `-command` after `-delay`
milliseconds of quiet. Default 300, width 28. Clearing and a filter
change fire at once. `setText` sets the text and does not fire.

```tcl
set s [::tkutils::tkusearchbar::widget .s ?-command befehl? ?-delay ms? ?-filters liste?]
::tkutils::tkusearchbar::getText $s
::tkutils::tkusearchbar::clear   $s
::tkutils::tkusearchbar::getFilter $s
```

[tkufilterbar]{.index} 0.2 creates one field per column. `-command`
receives a dict of the non-empty fields. Default pause 300 ms, field
width 10. `setFilter` does not fire, `clear` does.

```tcl
set f [::tkutils::tkufilterbar::widget .f ?-command befehl?]
::tkutils::tkufilterbar::setColumns $f {name ort}
::tkutils::tkufilterbar::getFilters $f
```

---

## Scrolling

[tkuscrolledframe]{.index} 0.1 needs `scrollutil` from tklib and is
outside the umbrella. `widget` returns the outer frame, `content` the
frame to pack into.

```tcl
set sf [::tkutils::tkuscrolledframe::widget .sf ?-width n? ?-height n?]
set innen [::tkutils::tkuscrolledframe::content $sf]
::tkutils::tkuscrolledframe::see $sf $kind ?ecke?
```

[tkuwheel]{.index} 0.2 redirects the mouse wheel from a widget to a
scrollable target.

```tcl
::tkutils::tkuwheel::redirect ziel $w ?-orient y|x|both? ?-amount n? ?-dynamic 0|1?
::tkutils::tkuwheel::unbind   $w ?-recursive 0|1?
```

`-dynamic 1` also covers widgets created in `$w` later.

---

## Selection Rectangle: tkumarquee

[tkumarquee]{.index} 0.1 drags a rectangle on a canvas.

```tcl
::tkutils::tkumarquee::enable  .c ?-onselect befehl? ?-onstart befehl? ?-button n?
::tkutils::tkumarquee::disable .c
::tkutils::tkumarquee::region  .c
::tkutils::tkumarquee::active  .c
```

`region` returns `{x1 y1 x2 y2}` or the empty string. `active` is `1`
while the button is held.

---

## In short

- `tkutoolbar` addresses widgets by id. Tooltips come from `tkuballoon`.
- `tkustatus` uses `setText`, not `set`.
- `tkutab::add` returns the content frame.
- `Mod` in `tkubind` is Control or Command, depending on the platform.
- `tkuscrolledframe` needs `scrollutil` and its own `package require`.

---

*Next chapter: [Input](074-eingabe.md)*
