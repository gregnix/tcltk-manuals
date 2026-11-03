# What the test sets up itself

## Introduction

On the workstation, the window manager gives a new window
focus, puts it into a frame and can iconify it. Under Xvfb
without a window manager nobody does that. A test that relies on any of these
is green on the workstation and red in the pipeline, or
the other way round. The rule from `serie-xvfb` (howto 16): what the environment
contributes, the test must not assume. It sets it up itself, with
`update`, `focus -force` and `winfo rooty`. Then it behaves the same under Xvfb
without a window manager and with openbox.

All statements in this chapter are checked in `serie-xvfb` with Tcl/Tk 8.6.14
and 9.0.4, without a window manager and with openbox. The values without a
window manager were confirmed by the container check with `beispiele/wm-probe.tcl`.
The exception is the Xfce case in the section *The frame comes
late*; it comes from test runs on a workstation.

---

## Overview

| | Xvfb without window manager | Xvfb with openbox |
|--|--------------------------|------------------|
| `winfo manager .` | `wm` | `wm` |
| `wm frame .` vs. `winfo id .` | equal | different |
| `winfo ismapped`, `winfo viewable` after `update` | 1 | 1 |
| `focus -force` | works | works |
| Focus after `update` without `focus -force` | empty | `.` |
| Title bar `rooty - gy` | 0 | 20 |
| `wm iconify` | stays `normal`, about 2 s | `iconic` |
| local `grab` | works | works |

---

## Mapping: update first

A window that the script has just created is not yet on the
screen. It is mapped at the next `update` (`serie-xvfb`,
howto 03 and 14):

```tcl
toplevel .t
winfo ismapped .t        ;# 0
update
winfo ismapped .t        ;# 1, even without a window manager
```

[`winfo viewable`]{.index} additionally requires that all ancestors
are mapped. After `wm withdraw .`, a frame in `.` is not
`viewable`, even if it is mapped itself (howto 15).

---

## Generating keys: establishing focus

`event generate` with a key event goes to the widget with the
**keyboard focus**, not to the window you name (howto 07):

```tcl
entry .e1; entry .e2; pack .e1 .e2
update
focus -force .e1
update
event generate .e2 <Key-x>      ;# ends up at .e1
```

Three pitfalls follow from this, all checked without a window manager and with
openbox:

1. **Before `update`:** a new toplevel is not mapped and has
   no focus. `event generate .t <Escape>` does not arrive
   (howto 05). This is not an Xvfb difference, it applies everywhere.
2. **Withdrawn:** a window after `wm withdraw` does not get the key,
   not even after `focus -force .`. Only after `wm deiconify`,
   `update` and `focus -force` (howto 06).
3. **Without a window manager:** after `update`, `focus` is empty. Nobody
   assigns the focus. A generated key arrives only after
   `focus -force` (howto 07 and 20). With openbox, `.` usually already has
   the focus after `update`. The test still does not wait
   for it.

The pattern for every key test is in the series as
`serie::fokusVorbereiten`:

```tcl
proc fokusVorbereiten {{w .}} {
    update
    focus -force $w
    update
}
fokusVorbereiten .
event generate . <Control-s>
```

Container check with `beispiele/wm-probe.tcl`: key without
`focus -force` arrived 0 times, with `focus -force` once, under 8.6.14
and 9.0.4.

---

## Grab

A local [`grab`]{.index} is internal to Tk and needs no
window manager (howto 11). The series makes the window visible
first:

```tcl
toplevel .dlg
update
grab .dlg
grab current            ;# .dlg
```

Without `update` no error occurs. Container check, 8.6.14 and
9.0.4: `grab .d` on a freshly created, not yet visible
toplevel returns without error, `grab current` is `.d`,
`grab status .d` is `local`; the same after `wm withdraw .d`. A
local grab on an invisible window thus silently locks the rest of the
interface. A global grab (`grab -global`) depends on the X server. On
the workstation (Xfce, 8.6.18, 9.0.4, 9.1.0) it returns without error,
`grab status` is `global`, `grab release` lifts it; the
session remained usable. In a test only with `grab release` in `finally`.

---

## Position of dialogs

`wm geometry +x+y` sets the **frame corner** of a window,
`winfo rootx/rooty` returns the corner of the **client area** (howto 04
and 12). A dialog that is to sit directly below the title bar of the
main window:

```tcl
set x [winfo rootx .]
set y [winfo rooty .]
wm geometry .dlg +$x+$y
```

The dialog's frame then begins at the top edge of the main window's
client area; its own client area lies lower by its own
title bar. Without a window manager,
`winfo rooty .dlg` equals `y`, under openbox `y + 20`.

A fixed number is always wrong somewhere (howto 13). Measured
title bars: without a window manager 0, openbox 20, Xfce on the
author's workstation 29. Code like

```tcl
wm geometry .dlg +[expr {$gx}]+[expr {$gy + 80}]
```

is only right if the title bar happens to be 80 pixels. The series demo
measures the frame and checks that 80 would be wrong here.

`scan [wm geometry .] {%dx%d%[+-]%d%[+-]%d}` also reads the form
`-X-Y`. Then X counts from the right, and the calculation above does not hold.
Set it with `+X+Y` beforehand.

### The frame comes late

When the window manager adds its frame depends on the
window manager. Under Xvfb with openbox, for a simple
toplevel it is already there when the first `update` after `wm geometry`
returns; this also holds for a transient one. A probe script with
a dialog at `+300+250` gave with 8.6.14 and 9.0.4:

| Time | without window manager | openbox |
|--|--|--|
| after `update` | `winfo rootx/rooty` 300,250 | 301,270 |
| 10 to 1000 ms later | unchanged | unchanged |
| `<Configure>` with offset | none | before `<Map>`, after 17 to 28 ms |

On an Xfce workstation with wish 9.1.0 the offset came later. A
dialog that the code had corrected once after 100 ms
ended up 5 pixels to the right and 28 to 29 pixels below the target. This
did not happen in every run: in both runs of the whole suite, and in the
single run of the test file in the third of three. Under Xvfb, with and without
openbox, it never happened.

For the code this means: a correction after a fixed wait is not
enough. It watches `<Configure>` on the dialog for a while, about one
second after it appears, and corrects each time shortly afterwards.
It calculates from the frame corner from `wm geometry`, not from
`winfo rootx`; otherwise the correction overshoots the target when there
is no frame.

For the test this means: under Xvfb the case does not occur by
itself. The test sets it up and moves the dialog itself after it
appears, starting from the frame corner:

```tcl
after 300 {
    regexp {\+(-?\d+)\+(-?\d+)$} [wm geometry .d] -> fx fy
    wm geometry .d +[expr {$fx + 5}]+[expr {$fy + 29}]
}
```

Using `winfo rootx` here instead of the frame corner additionally shifts by
the frame under openbox, in the probe run 6 and 49 instead of 5 and
29 pixels. With the centered transient dialog from the next section,
the frame corner also gives 6 and 49, because `wm geometry` is not
correct there. That does no harm to a test that only checks that the
correction takes effect; one that compares the offset exactly places the
dialog beforehand not exactly centered or not transient.

`beispiele/spaeter-rahmen.tcl` shows both side by side. With 8.6.14
and 9.0.4, without a window manager and with openbox, the result was
the same, likewise on lxpro under Xvfb without a window manager with 8.6.18,
9.0.4 and 9.1.0:

```text
einmal     Abstand der Mitten: 5,29
beobachten Abstand der Mitten: 0,0
```

### openbox places centered dialogs itself

An exception showed up under openbox with a transient dialog
that the program places exactly centered over the client area of the parent
window. Parent window `.p` with `wm geometry .p 800x500+500+300`, dialog
418×92 pixels, transient to `.p`; read 50 ms after placing, with
8.6.14 and 9.0.4:

| requested frame corner | `wm geometry` | frame according to `xwininfo` | client area |
|--|--|--|--|
| +692+524 (centered) | +692+524 | 691,504 | 692,524 |
| +680+524 | +680+524 | 680,524 | 681,544 |
| +692+524, not transient | +692+524 | not read | 693,544 |

In the first case the frame lies centered over the frame of `.p`, not
at the requested position. Apparently openbox places a transient
dialog that is requested centered in the center itself. The client area
is then immediately at the target. But `wm geometry` keeps reporting the
requested position, still after 950 ms; the frame corner derived from it is off by 1 and 20
pixels. Only after the program sets the position again itself
do the values match again.

---

## Tests that need a window manager

Iconify, real frame position and focus changes by the window manager
cannot be checked without one. Such tests report SKIP if
none is running. The detection (howto 09) is described in
[X11, window managers and Wayland](080-x11-fenstermanager-wayland.md):
`wm frame` vs. `winfo id`, otherwise an iconify probe.

In the series the guards are called `serie::brauchtWM` (any
window manager) and `serie::brauchtRahmen` (a reparenting one). Without a
window manager the iconify probe costs about two seconds, because Tk
waits for a state change (container: 2002 and 2003 ms). The
series therefore lets `SERIE_WM` preset the result:

```bash
SERIE_WM=0 xvfb-run -a wish9.0 run-all.tcl
```

For tests with a window manager, `xvfb-run` starts openbox beforehand, see
[GUI tests with Xvfb](130-gui-tests-xvfb.md). The howtos have not been run
with xfwm4 under Xvfb.

On Windows and macOS there is always a window manager. There
nothing skips; the X11-specific howtos report SKIP because
`tk windowingsystem` is not `x11`. The howtos have not been tried
on Windows.

---

## Summary

- `update` before every check of visibility, position or focus.
- Generated keys go to the focus widget. `focus -force`, then
  `update`, then `event generate`.
- A local `grab` only needs a visible window.
- Dialog position from `winfo rooty`, never from `wm geometry` plus a fixed number.
- A frame can arrive after mapping. Watch `<Configure>` for a while;
  in the test, produce the late shift yourself.
- openbox places a transient dialog requested centered itself;
  `wm geometry` then does not report the frame corner.
- Iconify and frames only with a window manager; without one SKIP,
  preset via `SERIE_WM`.

---

*Next chapter: [Building Tk: dependencies](140-tk-bauen-abhaengigkeiten.md)*
