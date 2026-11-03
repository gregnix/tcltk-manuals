# Xfce from Tcl

## Introduction

[Xfce]{.index} is the desktop on the author's workstation. A
Tcl program talks to it via command-line tools: settings
via `xfconf-query`, preferred applications via `exo-open`, messages via
`notify-send`. All three need the session D-Bus. This chapter
follows `serie-xfce`, checked with Xfce **4.20** under X11 on Debian.
There is no Xfce in the container; every value here comes from the series.

---

## Detecting Xfce

`serie-xfce` (howto 01 and 04):

```tcl
$env(XDG_CURRENT_DESKTOP)        ;# XFCE
$env(XDG_SESSION_TYPE)           ;# x11
$env(XDG_MENU_PREFIX)            ;# xfce-
$env(DBUS_SESSION_BUS_ADDRESS)   ;# unix:path=/run/user/UID/bus
exec xfce4-about --version       ;# … Xfce 4.20
```

`XDG_CURRENT_DESKTOP` can be a colon-separated list
(`ubuntu:GNOME`). A check therefore looks for one element:

```tcl
proc desktop {} {
    if {![info exists ::env(XDG_CURRENT_DESKTOP)]} { return "" }
    return [split [string toupper $::env(XDG_CURRENT_DESKTOP)] :]
}
if {"XFCE" in [desktop]} { ... }
```

Without a desktop session the series stops before it checks anything. In
the container howto 01 reports:

```text
SKIP: serie-xfce braucht XFCE (XDG_CURRENT_DESKTOP=)
```

---

## xfconf: reading settings

Xfce stores its settings in [xfconf]{.index}, a service
on the session D-Bus. It is divided into channels, each channel into
properties with paths (`serie-xfce`, howto 02):

```tcl
exec xfconf-query -l                           ;# channels
exec xfconf-query -c xfwm4 -l                  ;# properties
exec xfconf-query -c xfwm4 -p /general/theme
exec xfconf-query -c xfwm4 -p /general/workspace_count
```

Existing channels include `xfwm4`, `thunar`, `xfce4-panel`,
`xfce4-session`, `xsettings`. The values (theme, number of
workspaces) are up to the user. The series therefore checks only
type and length, not a specific value. Without a session every call
fails with "Verbindung ist gescheitert".

A reader with a default:

```tcl
proc xfconf {kanal pfad {vorgabe ""}} {
    set p [auto_execok xfconf-query]
    if {$p eq ""} { return $vorgabe }
    if {[catch {exec {*}$p -c $kanal -p $pfad 2>/dev/null} wert]} {
        return $vorgabe
    }
    return $wert
}
set skala [xfconf xsettings /Gdk/WindowScalingFactor 1]
```

The channel `xsettings` matters for Tk: at startup under Xfce, Tk 9 reads
exactly `/Gdk/WindowScalingFactor` and, if it is 2, sets the interface
to 200 % (source `scaling.tcl`, see
[Fonts, scaling, themes](090-schriften-skalierung-themes.md)).
Tk does not detect Xfce by `XDG_CURRENT_DESKTOP`, but by
`ps -e` showing a process `xfce4-session`. On the workstation
`ps -e` finds it from `wish9.0` and `wish9.1`.
`WindowScalingFactor` is 1 there, so everything stays at the
value from the display: `tk scaling` 1.332, `scalingPct` 100, under 9.0
`::tk::fontScalingFactor` 1.

---

## xfconf: writing settings

```tcl
exec xfconf-query -c serie-xfce -p /howto/demo -n -t string -s ok
exec xfconf-query -c serie-xfce -p /howto/demo
exec xfconf-query -c serie-xfce -p /howto -r -R
```

`-n` creates a new property, `-t` names its type, `-r -R`
deletes recursively. The series (howto 03) writes only into its own
test channel and removes it afterwards. A program writes user settings
in `xfwm4` or in the panel only if that is its job.

A channel of its own is a convenient place for the settings of an
Xfce program, but it ties the program to Xfce. For a program
that also runs under other desktops, a file under
`XDG_CONFIG_HOME` (see [Paths, environment, XDG](040-pfade-umgebung-xdg.md))
is the better choice.

---

## Preferred applications: exo-open

Under Xfce, `xdg-open` asks `exo-open`. Called directly,
`exo-open` starts the applications set in Xfce by role
(`serie-xfce`, howto 05 and 09):

```tcl
exec {*}[auto_execok exo-open] --launch FileManager &
exec {*}[auto_execok exo-open] --launch TerminalEmulator &
exec {*}[auto_execok exo-open] --launch WebBrowser https://www.tcl-lang.org &
```

Under Xfce 4.20: the file manager is Thunar 4.20,
`xdg-mime query default inode/directory` returns `thunar.desktop`.
Text files are opened by `org.xfce.mousepad.desktop`. The terminal is
`xfce4-terminal` 1.2.0.

A folder in the file manager:

```tcl
exec {*}[auto_execok xdg-open] $ordner &
```

Thunar directly: `exec thunar $ordner &`. Under `SERIES_AUTO` the
series opens no window and only checks whether the tools are present.

---

## Notifications

The service is provided by `xfce4-notifyd`. On the workstation it lives in
`/usr/lib/x86_64-linux-gnu/xfce4/notifyd/`, so not in the `PATH`.
`auto_execok xfce4-notifyd` does not find it; whether the service is
running is asked via `notify-send` itself or via D-Bus. The call of
`notify-send` and the behavior of `tk sysnotify` are described in
[Native dialogs and desktop integration](110-dialoge-und-desktop.md).

---

## Window manager, panel, session

`serie-xfce` (howto 10 and 11):

```tcl
exec xfwm4 --version
exec xfce4-panel --version
exec xfce4-session --version
```

[xfwm4]{.index} is the window manager of the session. It reparents:
on the workstation the title bar is 29 pixels high (`serie-xvfb`,
howto 04), measured as `winfo rooty . - gy`. With a different theme
the value changes. A Tk program under Xfce gets focus,
iconify and fullscreen from the window manager; under Xvfb without a
window manager all of that is missing, see
[X11, window managers and Wayland](080-x11-fenstermanager-wayland.md).

The panel layout lives in the channel `xfce4-panel`. The series does not
read it.

---

## Summary

- Detecting Xfce: `XFCE` in `XDG_CURRENT_DESKTOP`, read as a list with `:`.
- Settings: `xfconf-query -c Kanal -p Pfad`. Write only into
  channels of your own.
- Under Xfce, Tk 9 reads `xsettings /Gdk/WindowScalingFactor`.
- Applications by role: `exo-open --launch`. Folders: Thunar.
- Everything depends on the session D-Bus. Without it every call fails.

---

*Next chapter: [GUI tests with Xvfb](130-gui-tests-xvfb.md)*
