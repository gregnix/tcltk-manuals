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

[tkulayoutcanvas]{.index} 0.1 places named blocks on a page in
millimeters. The engine is `tclutils::tulayout`. Fine typography and
columns stay in the application.

```tcl
::tkutils::tkulayoutcanvas::widget     $pfad ?option wert ...?
::tkutils::tkulayoutcanvas::getBlocks  $pfad
::tkutils::tkulayoutcanvas::setBlocks  $pfad $blöcke
::tkutils::tkulayoutcanvas::select     $pfad $id
::tkutils::tkulayoutcanvas::getCanvas  $pfad
::tkutils::tkulayoutcanvas::redraw     $pfad
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

`mergePreset` takes only the named keys from a preset, by default `x`,
`y`, `w` and `show`.

---

## Summary

- placeholder/slot for host apps and the designer.
- Placeholder 200×120, `pack propagate 0` — keep it in mind when
  filling.
- `build` returns `root`, `byId`, `byType`, `byName`; values through
  `setValue`/`getValue`/`fill`/`collect`.
- Required for Dateiblick: no.
- `tkulayoutcanvas` places blocks in millimeters. The engine is
  `tulayout`.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 and 9.0.4 on Linux under Xvfb: the example
with `slot`, the sizes of the placeholder, the errors of `tkuload`.

**Not tested:** the app Dateiblick.
:::

---

*Next chapter: [Images](082-bilder.md)*
