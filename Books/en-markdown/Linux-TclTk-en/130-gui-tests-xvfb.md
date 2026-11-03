# GUI tests with Xvfb

## Introduction

Tk tests need a display, even on a server without a screen
or in a CI pipeline. On Linux, [Xvfb]{.index} provides it, an
X server that draws only into memory. Xvfb has no
window manager. What that means for focus, frames and iconify is shown in
the next chapter. This chapter sets up the display: Xvfb and
`xvfb-run`, screen size and DPI, fonts, and the exit status
a pipeline can rely on.

The basis is `serie-xvfb`, checked with Tcl/Tk 8.6.14 and 9.0.4 under
Xvfb without a window manager and with openbox. In the container all
20 howtos ran with both versions: 19 OK, 1 SKIP (howto 10, iconify,
needs a window manager), 0 FAIL.

---

## Xvfb and xvfb-run

Debian package `xvfb`. It brings the server `Xvfb` and the helper script
[`xvfb-run`]{.index} (`serie-xvfb`, howto 17). If it is missing, a
test suite reports SKIP, not FAIL:

```tcl
if {[auto_execok xvfb-run] eq ""} {
    puts "SKIP: xvfb-run fehlt"
    exit 0
}
```

`xvfb-run` starts a server, sets `DISPLAY`, starts the program
and stops the server afterwards (`serie-xvfb`, howto 18):

```bash
xvfb-run -a wish9.0 test.tcl
xvfb-run -a -s "-screen 0 800x600x16 -dpi 50" wish9.0 test.tcl
xvfb-run -a sh -c 'openbox >/dev/null 2>&1 & sleep 1; wish9.0 test.tcl'
```

- `-a` looks for a free display, starting at `:99`.
- `-s "…"` passes options to Xvfb: `-screen 0 WxHxD` (width, height,
  color depth) and `-dpi N`.
- Without `-s`, the `xvfb-run` of the test machine used `-screen 0
  1280x1024x24`. Older versions used `640x480x8`. So always
  specify it.
- A window manager starts beforehand in the same `sh -c`. `sleep 1` gives
  it time to register. openbox is the Debian package `openbox`.

A script that does not end by itself keeps `xvfb-run` open. Test scripts
end with `exit`; the series enforces this via `SERIES_AUTO=1`.

`beispiele/gui-test-xvfb.sh` sums this up: fixed size, fixed
DPI, window manager via `WM=openbox`, SKIP without `xvfb-run`.

### Own server instead of xvfb-run

For many short runs a persistent server pays off:

```bash
Xvfb :93 -screen 0 1280x1024x24 -nolisten tcp -noreset &
export DISPLAY=:93
```

The option [`-noreset`]{.index} is important. Without it, Xvfb resets its
state as soon as the last client closes its connection. In the
container this lost every resource loaded with `xrdb` before
the test started; `xprop -root` no longer showed a property that had
just been set. With `-noreset` they stayed.

---

## Screen, DPI and fonts

`winfo screenwidth`, `screenheight` and `screendepth` return exactly
the values from `-screen` (`serie-xvfb`, howto 01). `tk scaling` follows
`-dpi`: 1.389 without the option (Xvfb then reports 100 dpi), 0.695 with
`-dpi 50`, 2.770 with `-dpi 200`.

The fonts come via fontconfig from the machine the test runs on,
not from Xvfb. Their size is given in points, so the
pixel size grows with `-dpi`. A test that expects fixed pixels
(width of a label, click point on a tab) breaks with a different
DPI or on a machine with a different default font. Such tests
calculate relatively:

```tcl
set breite [font measure TkDefaultFont "Hallo Welt"]
set soll   [winfo reqwidth .l]
```

Under Tk 9, the pixel dimensions of ttk also grow with the DPI (in the
container: scrollbar 15 pixels at 100 dpi, 27 at 192 dpi). A test
that is green under 8.6 can break at the same place under 9, see
[Fonts, scaling, themes](090-schriften-skalierung-themes.md).

For reproducible runs, size, depth and DPI therefore belong fixed in
the test call, and the font fixed in the test:

```tcl
font configure TkDefaultFont -family "DejaVu Sans" -size 10
```

---

## Exit status and abort

A `wish` without a display ends with 0 after running the script without
Tk (container check, see
[X11, window managers and Wayland](080-x11-fenstermanager-wayland.md)).
For a pipeline this is dangerous: a wrongly set `DISPLAY`
looks like a passed test. Test scripts therefore start with:

```tcl
if {[catch {package require Tk} fehler]} {
    puts stderr "FAIL: $fehler"
    exit 1
}
```

`tcltest` does not set the exit status by itself either.
In the version from Tcl 9.0.4, `tcltest::runAllTests` returns the value 1
if a test file fails (source `tcltest.tcl`). `all.tcl`
passes it on:

```tcl
exit [tcltest::runAllTests]
```

The details are in the book *Testen*.

For hangs, an outer `timeout` helps:

```bash
timeout 60 xvfb-run -a wish9.0 tests/all.tcl
```

---

## tclsh or wish

`wish` loads Tk at startup, `tclsh` only with `package require Tk`.
After that both behave the same (`serie-xvfb`, howto 14): `.`
exists, but while the script runs it is **not yet mapped**;
`winfo ismapped .` is 0. Mapping happens only at the next `update`
or when the event loop runs.

Under `tclsh` the event loop does not run by itself. A test
under `tclsh` needs `update` or `vwait`, a program under `tclsh`
a `vwait forever` at the end. `serie-xvfb` chooses the interpreter via
the first line of the howto: if it contains `wish`, `run-all.tcl` starts
the `wish` matching the version of the running `tclsh`.

---

## Summary

- Debian package `xvfb`, `xvfb-run -a -s "-screen 0 WxHxD -dpi N"`.
- Without `xvfb-run`: SKIP, not FAIL.
- Own Xvfb with `-noreset`, otherwise it loses resources.
- DPI determines `tk scaling`, fonts come from the client. Fix size, DPI
  and font in the test.
- `wish` without a display ends with 0. Tests check `package require Tk`
  themselves and end with an exit status.

---

*Next chapter: [What the test sets up itself](135-gui-tests-fenstermanager.md)*
