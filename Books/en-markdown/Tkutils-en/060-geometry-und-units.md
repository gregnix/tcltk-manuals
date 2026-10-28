# Geometry and Units

## tkugeometry 0.1

[tkugeometry]{.index} remembers size, position and zoom state of a
toplevel through `tclutils::tusettings`, in a file of its own,
`<Konfig-Ordner>/<app>/geometry.ini`. An app that saves its own settings
dict on exit therefore cannot overwrite the geometry. Needs at least
tclutils **0.64.0** (which added `tusettings`); 0.68.0 is recommended.

The configuration folder comes from `tusettings::dir config`: on Linux
`$XDG_CONFIG_HOME/<app>`, otherwise `$HOME/.config/<app>`; according to
the code `%APPDATA%\<app>` on Windows and
`$HOME/Library/Application Support/<app>` on macOS (checked on Linux
only).

| Command | Effect | Return value |
|---|---|---|
| `track w app ?-key k? ?-default geo?` | restore now, save on destroy | applied geometry or `""` |
| `restore w app ?-key k? ?-default geo?` | apply the saved geometry | applied geometry or `""` |
| `save w app ?-key k?` | save now | saved geometry |
| `key w` | key from the path | `.` → `main`, `.dlg` → `dlg` |

```tcl
package require tkutils::tkugeometry
::tkutils::tkugeometry::track . meineapp -default 800x600         ;# -> 800x600
toplevel .vorschau
::tkutils::tkugeometry::track .vorschau meineapp -default 400x300 ;# -> 400x300
```

`track` restores by itself — a preceding `restore` is not needed.
`-default` (a size such as `800x600` or a full geometry) applies when
nothing is saved yet. Saving happens on the window's `<Destroy>` through
a bindtag of its own; the app's `<Destroy>` bindings stay untouched. Call
`save` only when the geometry should be saved at another time. With
`-key` you choose a section name other than the one from `key`.

Under Xvfb without a window manager, `geometry.ini` contains after exit:

```ini
[main]
geometry=800x600+0+0
zoomed=0
```

---

## Off the Screen

A saved position that is no longer on the screen — the second monitor is
missing, the resolution is smaller — is not used. The window keeps its
size (shrunk to the screen if necessary) and is **centered**. "On the
screen" means: the top strip of the window (title bar, 100×30 pixels)
lies within Tk's virtual root — on X11 all monitors as one rectangle, on
Windows the virtual desktop. The check does not detect a gap between
monitors of different sizes.

Example with a screen of 1280×1024 pixels: the saved value is
`500x400+5000+5000`, `restore` sets `500x400+390+312` — same size,
centered.

The zoom state is saved as `zoomed` and restored where Tk knows it
(`wm state zoomed` on Windows/macOS, `wm attributes -zoomed` on X11).

Errors: `{TKUTILS TKUGEOMETRY WINDOW}`, message
`".nix" is not an existing toplevel` (no existing toplevel). An unknown
option reports `{TCLUTILS COMMON OPTION <opt>}` with
`unknown option "<opt>"` and `Known: -key -default`, because the module
uses the option check of tclutils. Invalid app names and unreadable
files report the `tusettings` errors, for example
`{TCLUTILS TUSETTINGS APP}` with
`bad app name "a/b": must be a plain directory name`.

---

## tkuunits 0.1

[tkuunits]{.index} converts screen measures between px, pt, mm, cm and
inch. Tk understands the units itself (`winfo fpixels . 10m`), but pixels
back to millimeters or unit to unit is left to the caller. For label and
print previews.

| Command | Return value |
|---|---|
| `units` | `px pt mm cm inch` |
| `toPixels wert einheit ?fenster?` | pixels as a floating-point number |
| `fromPixels px ?fenster?` | dict with `px pt mm cm inch` |
| `convert wert von nach ?fenster?` | floating-point number |

```tcl
package require tkutils::tkuunits
puts [::tkutils::tkuunits::convert 62 mm cm]       ;# -> 6.2
puts [::tkutils::tkuunits::convert 1 inch pt]      ;# -> 72.0
set px [::tkutils::tkuunits::toPixels 62 mm]       ;# Etikettenbreite am Schirm
puts [dict get [::tkutils::tkuunits::fromPixels 300] mm]
```

Besides `px pt mm cm inch`, the Tk letters `p m c i` and `in` are
accepted. `pt` is the printer's point, 1/72 inch, as in Tk. Pixel values
depend on the resolution of the window (default `.`) and thus on
`tk scaling`; unit-to-unit results do not.

Errors (messages from the test):

| Code | Message |
|---|---|
| `{TKUTILS TKUUNITS UNIT}` | `unknown unit "furlong": must be px, pt, mm, cm, inch` |
| `{TKUTILS TKUUNITS VALUE}` | `expected a number but got "2c"` |
| `{TKUTILS TKUUNITS WINDOW}` | `bad window path name ".nix"` |

With `tk scaling` 1.39 (Xvfb default) and 2.0, `convert 1 inch pt`
stays at `72.0`; `convert 62 mm cm` returns `6.2` at 1.39 and
`6.199999999999999` at 2.0 — a floating-point rounding remainder. Round
output yourself, for example with `format %.2f`.

---

## Summary

- `track` restores and saves on close; `-default` for the first start.
- Position off the screen → centered, size kept.
- Units for device-independent measures on the screen.

::: {.info}
**Tested with** Tcl/Tk 8.6.14 and 9.0.4 on Linux, Xvfb without a window
manager, screen 1280×1024: all examples, error codes and messages of this
chapter.

**Not tested:** configuration folder on Windows and macOS, several
monitors, zoom state (Xvfb without a window manager has none).
:::

---

*Next chapter: [Actions and Layout](070-aktionen-und-layout.md)*
