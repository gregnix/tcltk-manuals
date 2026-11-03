# Test environment

## Introduction

This appendix lists the machines and versions on which the examples in
this book were tried, the check scripts for them and the points that
are still open. The chapters mention only what is needed for
understanding. How the values were obtained is described in
[Appendix E: Sources](850-anhang-quellen.md).

---

## Machines and versions

Two environments, both x86_64 with X11:

| What | The author's Debian workstation | Container |
|---|---|---|
| System | Debian forky (testing) | Ubuntu 24.04.5 LTS, kernel 6.18, glibc 2.39 |
| Tcl 8.6 | 8.6.18 from the package | 8.6.14 from the packages `tcl8.6`, `tk8.6` |
| Tcl/Tk 9 | 9.0.4 and 9.1.0 from the packages | 9.0.4, source build under `/opt/tcl9` |
| Display | Xfce 4.20 under X11 (window manager xfwm4) | Xvfb without a window manager, 1280x1024x24, 100 dpi |
| Source of the values | the five howto series | `beispiele/` and the series except `serie-xfce` |

In the container, the interpreters for search paths and encoding run
with an empty environment (`env -i`), so that no variable from the
session distorts the values. Statements about Tk internals (mouse
wheel, `tk print`, `tk systray`, scaling) were looked up in the Tk 9.0.4
sources and verified in the container. The values with a window manager
come from `serie-xvfb` (openbox) and from the author's workstation
(Xfce).

The container has no desktop session, no session DBus, no Xfce, no
window manager, no Wayland and no CUPS. The Xfce values therefore come
only from `serie-xfce`.

---

## Check scripts

| Script | checks | Chapter |
|---|---|---|
| `beispiele/messprobe-linux.tcl` | all values in the tables of this book | all, see [CLI](810-anhang-cli.md) |
| `beispiele/rad-und-tasten.tcl` | mouse wheel and modifiers with `xdotool` | Mouse, keyboard, clipboard |
| `beispiele/auswahl-probe.tcl` | PRIMARY and CLIPBOARD, without deadlock | Mouse, keyboard, clipboard |
| `beispiele/wm-probe.tcl` | focus, frame, iconify, fullscreen, `WM_CLASS` | X11, window managers; tests |
| `beispiele/spaeter-rahmen.tcl` | dialog position with a late frame | Tests |
| `beispiele/utf8-wache.tcl` | UTF-8 script under `LANG=C` with 8.6 | Encoding and locale |
| `beispiele/xdg-ordner.tcl` | XDG directories and user directories, 8.6 and 9 | Paths, environment, XDG |
| `serie-*/run-all.tcl` | all howtos of a series (not published) | see chapter 1 |

---

## Not yet tested

| Chapter | open |
|---|---|
| [X11, window managers and Wayland](080-x11-fenstermanager-wayland.md) | a real Wayland session (nested Weston checked) |
| [Native dialogs and desktop integration](110-dialoge-und-desktop.md) | `tk systray` in the Xfce panel, visually |
| [What the test sets up itself](135-gui-tests-fenstermanager.md) | the howtos on Windows |

A result for one of these points belongs in the respective chapter and
is removed from here.
