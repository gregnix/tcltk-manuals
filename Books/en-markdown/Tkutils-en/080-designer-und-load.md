# Designer and load

## tkurender / tkuload

[tkurender]{.index} is the rendering core of tkudesigner and tkuload; it
knows the widget type [placeholder]{.index} (options `text`, `role`,
`width`, `height`). [tkuload]{.index} builds a live user interface from a
`.tkd` design and offers [slot]{.index}: empty a placeholder frame, and
the host packs the real widget into it.

Both modules have namespaces of their own (`::tkurender`, `::tkuload`)
and are not in the umbrella. The packages are called
`tkutils::tkurender` (0.2) and `tkutils::tkuload` (0.3).

```tcl
package require tkutils::tkuload
package require tkutils::tkurender
package require tkutils::tkufilelist

# Entwurf mit einem benannten Platzhalter (sonst aus tkudesigner, .tkd)
::tkurender::newModel
set p [::tkurender::addNode placeholder $::tkurender::D(root)]
::tkurender::setName $p filelist
::tkurender::setOpt  $p role filelist
set spec [::tkurender::serialize]

ttk::frame .host
pack .host -fill both -expand 1
set ui [::tkuload::build .host $spec]

set box [::tkuload::slot $ui filelist]
::tkutils::tkufilelist::widget $box.l -dir [pwd]
pack $box.l -fill both -expand 1
pack propagate $box 1
```

From a file: `::tkuload::buildFromFile $parent $pfad`.

`build` returns a dict with `root`, `byId`, `byType` and `byName`. `.`
is also allowed as `$parent`; `build` then creates a frame of its own,
`.tkuloadHost<n>`. Build every design into its own empty parent: the
widget names come from the node ids, so a second build into the same
parent collides. On the first `build`, `tkuload` adds the paths from
`TCLUTILS_TM` and `TKUTILS_TM` to the module path, if set.

Further commands for named widgets: `widgetByName`, `setValue`,
`getValue`, `fill` (dict name → value, unknown names are skipped) and
`collect` (values back as a dict). Since 0.3 `namespace export` names
all eight commands, so `namespace import ::tkuload::*` brings in all of
them; up to 0.2 only `build`, `buildFromFile` and `slot` were exported.

---

## Fixed Size of the Placeholder

The placeholder is a `ttk::frame` with a fixed size — by default
**200×120** pixels — and `pack propagate 0`. `slot` removes only the
children; size and propagation stay. A widget packed into it is
therefore clipped to 200×120. The frame from the example is exactly
200×120 with propagation 0 before `pack propagate $box 1`, and 199×251
afterwards (Tcl/Tk 9.0.4: 199×231). Remedies:

- `pack propagate $box 1` — the frame grows with its content, or
- set `width`/`height` suitably in the designer, or
- stretch the placeholder in the layout with `-fill both -expand 1` (or
  a grid weight).

---

## Use

According to the book *Utils-Stack*, the app **Dateiblick** stays
hand-wired (no `.tkd`); its code is not in tclutils, tkutils or
ctrlutils and is not checked here. tkudesigner shows placeholders in the
palette (group *Widget*; in the code `defType placeholder Widget`).

Errors of tkuload:

| Code | Message |
|---|---|
| `{TKULOAD PARENT}` | `no such parent widget: .nix` |
| `{TKULOAD NONAME}` | `no widget named 'foo'` (from `slot` and `widgetByName`) |

Details: `docs/tkuload.md` in the tkutils tree.

---

## Page Layout: tkulayoutcanvas

[tkulayoutcanvas]{.index} 0.2 places named blocks on a page in
millimeters. The engine is `tclutils::tulayout`. Fine typography and
columns stay in the application or in `tkutemplate` (next section).

```tcl
::tkutils::tkulayoutcanvas::widget     $path ?option value ...?
::tkutils::tkulayoutcanvas::getBlocks  $path
::tkutils::tkulayoutcanvas::setBlocks  $path $blocks
::tkutils::tkulayoutcanvas::select     $path $id
::tkutils::tkulayoutcanvas::getCanvas  $path
::tkutils::tkulayoutcanvas::redraw     $path
```

| Option | Default | Effect |
|---|---|---|
| `-paper` | `a4` | `a4`, `a5`, `letter` |
| `-orientation` | `portrait` | `portrait` or `landscape` |
| `-margin` | `20.0` | margin in mm |
| `-gridmm` | `5.0` | grid in mm |
| `-scale` | `3.0` | pixels per mm |
| `-blocks` | `{}` | dict of the blocks |
| `-definitions` | `{}` | catalog: label and size per id |
| `-blockorder` | `{}` | order of the blocks; else from the definitions, else sorted |
| `-onchange` | `{}` | `command $path $blocks` after a drag or an edit |
| `-onselect` | `{}` | `command $path $id` when a block is selected (page, list, `select`); new in 0.2 |

`mergePreset` takes only the named keys from a preset, by default `x`,
`y`, `w` and `show`.

A block with `y 0` or `lockedY 1` is in the flow: only the renderer
decides where it goes. Since 0.2 the page shows it two millimeters below
the visible block before it, where a renderer that flows blocks puts it.
Up to 0.1 it stacked such blocks from the top margin in steps of 12 mm.

```tcl
package require tkutils::tkulayoutcanvas
tkutils::tkulayoutcanvas::widget .lc -blockorder {head table foot} -blocks {
    head  {x 20 y 25 w 170 h 15}
    table {x 20 y 55 w 170 h 40}
    foot  {x 20 y 0  w 170 h 10}
} -onselect {apply {{p id} { puts "selected: $id" }}}
pack .lc -fill both -expand 1
tkutils::tkulayoutcanvas::select .lc head   ;# prints "selected: head"
dict get [tkutils::tkulayoutcanvas::getBlocks .lc] foot y   ;# -> 0.0
```

The page shows `foot` at 97 mm: `table` ends at 55 + 40 = 95 mm.

`getBlocks` returns only the keys `tulayout` knows (`label x y w h show
lockedY`). Whoever sends blocks with further keys through the page merges
the result back with `tulayout::mergeLayout`, or those keys are gone.

---

## Templates: tkutemplate

[tkutemplate]{.index} 0.1 edits a whole document template in the format
of `pdf4tcltemplate` (pdf4tcllib): paper, margins, colors and blocks with
a type (`text`, `pairs`, `table`, `image`, `rule`), font, alignment, text
with placeholders and table columns. `tkulayoutcanvas` places the blocks;
everything else sits in three tabs beside it: *Block*, *Columns*, *Page*.
What comes back from the page `tkutemplate` merges into the template with
`mergeLayout` (keys `x y w show`); no other attribute is lost.

```tcl
::tkutils::tkutemplate::widget      $path ?option value ...?
::tkutils::tkutemplate::getTemplate $path
::tkutils::tkutemplate::setTemplate $path $template
::tkutils::tkutemplate::setSample   $path $data
::tkutils::tkutemplate::select      $path $id
::tkutils::tkutemplate::addBlock    $path $id ?type?
::tkutils::tkutemplate::deleteBlock $path $id
::tkutils::tkutemplate::moveBlock   $path $id up|down
::tkutils::tkutemplate::setBlock    $path $id key value ?key value ...?
::tkutils::tkutemplate::loadFile    $path $file
::tkutils::tkutemplate::saveFile    $path $file
::tkutils::tkutemplate::preview     $path ?file?
```

| Option | Default | Effect |
|---|---|---|
| `-template` | `{blocks {}}` | the template |
| `-sample` | `{}` | sample data for the preview |
| `-onchange` | `{}` | `command $path $template` after every change |
| `-scale`, `-gridmm` | `2.5`, `5` | pixels per mm, grid in mm |
| `-font`, `-fontbold` | `{}` | fonts of the preview; else pdf4tcllib's TrueType fonts |

`setBlock` checks what it sets: numbers, booleans, `type`, `page`,
`align`, color as a theme name or `r g b`. An empty value removes the
key, except for `type` and `cols`. A block that becomes a table gets two
columns, an image a height. `moveBlock` changes the order, and the order
counts: a block with `y 0` follows the one before it.

```tcl
package require tkutils::tkutemplate
tkutils::tkutemplate::widget .te -template {
    paper a4 margin 20 size 10
    blocks {
        head  {x 20 y 18 w 110 size 18 bold 1}
        table {type table x 20 y 100 w 170 cols {pos text}}
        close {x 20 y 0 w 170 gap 8 text "Thank you, {name}."}
    }
} -sample {head Nursery name Customer table {{pos 1 text Rose}}}
pack .te -fill both -expand 1
tkutils::tkutemplate::setBlock .te head size 20 align center
dict get [tkutils::tkutemplate::getTemplate .te] blocks head
    ;# -> x 20 y 18 w 110 size 20 bold 1 align center
catch {tkutils::tkutemplate::setBlock .te head align middle} m o
dict get $o -errorcode            ;# -> TKUTILS TKUTEMPLATE VALUE
```

**Preview.** `preview` draws the template with `-sample` into a PDF and
returns the file (a temporary one when none is given); the *Preview*
button opens it with `tclutils::tuopen`. Blocks without sample data get a
stand-in, so every block shows in the PDF. Only the preview loads
`pdf4tcltemplate` and `pdf4tcl`; the editor itself needs only Tk,
tclutils and `tkulayoutcanvas`. If either is missing, `preview` reports
`{TKUTILS TKUTEMPLATE PREVIEW}`. pdf4tcllib loads without pdf4tcl too;
`preview` therefore checks both.

**Files.** `saveFile` writes the template as Tcl, one block per line;
`loadFile` reads it back, and the result equals the saved template. The
height the page shows is an estimate from type and sample data and is not
saved.

Launcher `bin/tkutemplate.tcl ?template.tcl?`, demo
`examples/demo-tkutemplate.tcl`.

---

## Summary

- placeholder/slot for host apps and the designer.
- Placeholder 200×120, `pack propagate 0` — keep it in mind when
  filling.
- `build` returns `root`, `byId`, `byType`, `byName`; values through
  `setValue`/`getValue`/`fill`/`collect`.
- Required for Dateiblick: no.
- `tkulayoutcanvas` places blocks in millimeters. The engine is
  `tulayout`. Blocks in the flow show below the block before them.
- `tkutemplate` edits a whole template for `pdf4tcltemplate`; the
  preview needs pdf4tcllib and pdf4tcl.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 and 9.0.4 on Linux under Xvfb: the example
with `slot`, the sizes of the placeholder, the errors of `tkuload`.

The examples for `tkulayoutcanvas` 0.2 and `tkutemplate` 0.1 under
Tcl/Tk 8.6.14 and 9.0.4; the preview with pdf4tcl 0.9.4.74.

**Not tested:** the app Dateiblick.
:::

---

*Next chapter: [Images](082-bilder.md)*
