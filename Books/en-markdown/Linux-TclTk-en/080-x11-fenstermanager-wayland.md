# X11, window managers and Wayland

## Introduction

On Linux, Tk speaks only X11. `tk windowingsystem` always returns
`x11`. Unlike on Windows and macOS, the windowing system is split
into two programs: the X server, which draws and delivers input, and
the [window manager]{.index}, which provides the frame, title bar,
focus and iconify. A Tk program can run without a window manager,
but then it lacks a few things. This chapter separates what Tk does
itself, what the window manager does, and what a Wayland session
changes about it.

---

## DISPLAY and starting without a display

At startup, Tk connects to the X server given in
[`DISPLAY`]{.index}. If the variable is missing or the server does not
answer, Tk fails. Container check, 8.6.14 and 9.0.4 identical:

```text
$ env -i wish9.0 probe.tcl
application-specific initialization failed: no display name and no $DISPLAY environment variable
$ env -i DISPLAY=:77 wish9.0 probe.tcl
application-specific initialization failed: couldn't connect to display ":77"
```

What happens next is remarkable: `wish` does **not** abort. It runs
the script without Tk, `package require Tk` then returns the error,
and the exit status of `wish` is 0. A test run in a pipeline that
only looks at the exit status reports success, although not a single
line of the user interface has run. Remedy at the start of the script:

```tcl
if {[catch {package require Tk} fehler]} {
    puts stderr "Tk fehlt: $fehler"
    exit 1
}
```

`tclsh` with `package require Tk` behaves as expected: the error
aborts the script.

What Tk knows about the server:

```tcl
winfo server .          ;# X11R0 The X.Org Foundation 12101011 (Xvfb)
winfo screen .          ;# :93.0
winfo screenwidth .     ;# 1280
winfo screenmmwidth .   ;# 325
winfo visual .          ;# truecolor
```

---

## Window class and WM_CLASS

Every main window carries the X property [`WM_CLASS`]{.index} with
two parts: name and class. The window manager, the taskbar and
`.desktop` files recognize a program by it. Tk derives both from the
program name. Container check with `xprop`, 8.6.14 and 9.0.4
identical:

| Start | `tk appname` | `WM_CLASS` |
|-------|--------------|------------|
| `wish9.0 meinprog.tcl` | `meinprog.tcl` | `"meinprog.tcl", "Meinprog.tcl"` |
| `wish9.0 meinprog.tcl -name meinname` | `meinname` | `"meinname", "Meinname"` |
| `tclsh9.0 meinprog` with `package require Tk` | `meinprog` | `"meinprog", "Meinprog"` |

The class is the name with a capital first letter. Tk does not accept
a custom class name for `.` from the command line: a `-class` in
`argv` is ignored and stays in `argv`. `-name`, on the other hand,
also works when a script sets it in `::argv` before
`package require Tk`:

```tcl
set ::argv [list -name meineapp]
set ::argc 2
package require Tk           ;# WM_CLASS "meineapp", "Meineapp"
```

For a program started as `meineapp.tcl`, the class is therefore
`Meineapp.tcl`, with the extension. Anyone writing a `.desktop` file
with `StartupWMClass` must match exactly this value, see
[Native dialogs and desktop integration](110-dialoge-und-desktop.md).
Further toplevels carry their window name and their class: a
`toplevel .t -class Zweit` has `WM_CLASS` `"t", "Zweit"` in the
container (8.6.14 and 9.0.4). For `.` itself there is no such way.

Tk also sets `WM_NAME` and `_NET_WM_NAME` from `wm title`, and
`_NET_WM_PID` as soon as `WM_CLIENT_MACHINE` is set (source
`tkUnixWm.c`). In the container, `_NET_WM_PID` was missing on the
window; the condition for it has not been investigated.

---

## What the window manager provides

A [reparenting]{.index} window manager puts every main window into a
frame of its own with a title bar. This results in two sets of
coordinates: `wm geometry` sets and returns the **frame corner**,
`winfo rootx` and `winfo rooty` the corner of the **client area**.
The difference is the frame.

```tcl
wm geometry . 360x220+30+40
update
scan [wm geometry .] {%dx%d+%d+%d} w h gx gy
set titel [expr {[winfo rooty .] - $gy}]
```

Measured in `serie-xvfb` (howto 04 and 13, Tcl/Tk 8.6.14 and 9.0.4):

| Environment | Title bar `rooty - gy` | `wm frame .` vs. `winfo id .` |
|----------|---------------------------|----------------------------------|
| Xvfb without window manager | 0 | equal |
| Xvfb with openbox | 20 (sides 1) | different |
| Xfce on the author's workstation | 29 (sides 5) | different |

Under Xfce the same for 8.6.18, 9.0.4 and 9.1.0; example 9.0.4:
`wm frame` `0x92e055`, `winfo id` `0x7a00009`.

A fixed number such as 80 for "below the main window" fits none of
these environments. To place a dialog below the title bar of the main
window, use `winfo rooty .`.

What is missing without a window manager, container check with
`beispiele/wm-probe.tcl`, 8.6.14 and 9.0.4 identical:

| Operation | without window manager |
|---------|---------------------|
| Focus after `update` | empty, nobody assigns it |
| `wm iconify .` | state stays `normal`, Tk waits about 2000 ms |
| `wm attributes . -fullscreen 1` | attribute stays 0, size unchanged |
| `focus -force .` | works |
| `grab` | works (Tk-internal, `serie-xvfb`, howto 11) |

With openbox, the window becomes `iconic` after `wm iconify`, and `.`
usually already has the focus after `update` (`serie-xvfb`, howto 09
and 10). Tk sets fullscreen, `-zoomed` and `-type` via the
[EWMH]{.index} properties `_NET_WM_STATE` and
`_NET_WM_WINDOW_TYPE`. Whether they take effect is up to the window
manager. `wm attributes . -alpha 0.8` sets `_NET_WM_WINDOW_OPACITY`,
namely on the wrapper window that Tk puts around the client area
(source `tkUnixWm.c`). Under a reparenting window manager, this is
neither `wm frame` nor `winfo id`: with openbox, the property is on
the wrapper window and on the frame that openbox supplies with it,
not on the client (container, 8.6.14 and 9.0.4). `xwininfo` names the
wrapper window as the parent window of the client:

```tcl
regexp {Parent window id: (0x[0-9a-f]+)} [exec xwininfo -tree -id [winfo id .]] -> huelle
exec xprop -id $huelle _NET_WM_WINDOW_OPACITY
```

Under Xfce 4.20 with compositor (`use_compositing` true), `-alpha`
accepts 0.35 and returns 0.35, and the window is visibly
transparent; with `use_compositing` false it is opaque (8.6.18,
9.0.4, 9.1.0). The property is not on the frame or on the client, but
it is on the wrapper window: `1503238553`, i.e. 0.35 × `0xFFFFFFFF`,
for 8.6.18, 9.0.4 and 9.1.0, with and without compositor. So Tk
always sets it; whether anything is visible is decided by the
compositor alone.

The attributes known under X11, container check:

```text
8.6.14   -alpha 1.0 -topmost 0 -zoomed 0 -fullscreen 0 -type {}
9.0.4    -alpha 1.0 -fullscreen 0 -topmost 0 -type {} -zoomed 0
```

Same content, different order. When comparing the output as a list,
compare it as a `dict`.

---

## Detecting a window manager

`winfo manager .` does not help: for a toplevel it is always `wm`,
with and without a window manager (`serie-xvfb`, howto 02). What
works is shown by `serie-xvfb` in howto 09:

1. `wm frame .` vs. `winfo id .`. Different means: a reparenting
   window manager is running.
2. If they are equal, an iconify probe on a helper window decides. If
   it becomes `iconic`, a window manager without frames is running
   (dwm, xmonad). If it stays `normal`, none is running.

Compare the ids **numerically**. Tk 8.6 writes `winfo id` with
leading zeros, `wm frame` without (container: `0x200003` vs.
`0x00200003`), Tk 9.0 writes both without. Before the first mapping,
`wm frame` is `0x0`, so call `update` first.

```tcl
update
set rahmen [expr {[wm frame .] != [winfo id .]}]
```

Without a window manager, the iconify probe costs about two seconds.
The procedures `serie::wmRahmen` and `serie::wmDa` in the series
therefore allow the result to be preset via `SERIE_WM=0` or `1`.

---

## Wayland

Tk 9.0.4 has no Wayland backend. The source mentions Wayland in
exactly two places: in `scaling.tcl` (see
[Fonts, scaling, themes](090-schriften-skalierung-themes.md))
and in `tkUnixEvent.c`, where Tk resets a nonsensical screen width in
millimeters under XWayland to 75 dpi.

In a [Wayland]{.index} session, a Tk program therefore runs via
**XWayland**, the X server that the Wayland compositor brings along.
Then `DISPLAY` and `WAYLAND_DISPLAY` are both set, and
`XDG_SESSION_TYPE` is `wayland`. `tk windowingsystem` stays `x11`.

```tcl
set sitzung [expr {[info exists env(XDG_SESSION_TYPE)]
                   ? $env(XDG_SESSION_TYPE) : "unbekannt"}]
```

What is different under XWayland (global window positions, taking
focus from other programs, screenshots, scaling with multiple
screens) depends on the compositor. On the author's workstation, Xfce
runs under X11 (`serie-xfce`: `XDG_SESSION_TYPE=x11`,
`WAYLAND_DISPLAY` empty); the Debian book also reports `x11` for
lxpro. A real Wayland session (GNOME, KDE, Xfce with Wayland) has
**not been checked** for this book.

### XWayland under Weston

XWayland has been checked in the container: Weston 13.0.0 nested in
Xvfb (`weston --backend=x11-backend.so --xwayland`), Tk via
`DISPLAY=:0`, 8.6.14 and 9.0.4 identical:

| Probe | under XWayland (Weston) |
|---|---|
| `tk windowingsystem` | `x11` |
| `wm frame .` vs. `winfo id .` | different, Weston sets a frame |
| `wm geometry . +100+100` | Weston places the window itself, `wm geometry` reports `+32+32` |
| `wm geometry . +400+300` | reports `+400+300`, the window does not move |
| `winfo rootx`/`rooty` | `6,27` for every window, fixed |
| `focus -force .` | no effect, the focus stays with the window shown last |
| `wm iconify .` | state stays `normal` |
| `-fullscreen 1` | works, whole output |
| `xwd -root` | `BadMatch`, no image |

Under XWayland, window positions can therefore be neither set nor
read: Tk reports what it requested, not where the window is. Code
that places dialogs itself or takes screenshots via X should not rely
on this. Other compositors may behave differently.

---

## Summary

- `tk windowingsystem` is always `x11` on Linux, even under Wayland
  (via XWayland). There, positions can be neither set nor read, no
  iconify, no `focus -force` (Weston).
- Without a display, `wish` reports the error, continues without Tk
  and exits with 0. Scripts check `package require Tk` themselves.
- `WM_CLASS` is the program name and the program name with a capital
  first letter; `-name` changes both.
- `wm geometry` is the frame corner, `winfo rooty` the client area.
  Frame: 0, 20 or 29 pixels, never assume a fixed value.
- Without a window manager: no focus, no iconify, no fullscreen.
  Detect via `wm frame` and an iconify probe.

---

*Next chapter: [Fonts, scaling, themes](090-schriften-skalierung-themes.md)*
