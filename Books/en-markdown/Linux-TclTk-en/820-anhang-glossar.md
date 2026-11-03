# Glossary

---

## Symbols

**.desktop file**
: Launcher according to the Desktop Entry Specification, in
  `~/.local/share/applications/` or `/usr/share/applications/`.
  Keys `Exec`, `Icon`, `StartupWMClass`.

**//zipfs:/**
: Root of the Tcl 9 ZIP file system. In a source build the Tcl library
  lives under `//zipfs:/lib/tcl`, appended to `libtcl9.0.so`. Under
  Tcl 9 also listed in `file volumes`.

## A

**auto_execok**
: Looks up a program in `PATH`, returns a list or an empty result.
  Caches every answer in `auto_execs`.

**auto_path**
: Search list for `package require`. Debian: `/usr/share/tcltk` and
  `/usr/lib/tcltk/<multiarch>`. Source build under `/opt/tcl9`: only
  zipfs and `/opt/tcl9/lib`.

## C

**CLIPBOARD**
: The X11 selection for copy and paste. Set by `<<Copy>>` or
  `clipboard append`. Disappears with its owner unless a manager takes
  it over.

**Command**
: Modifier name in `bind`. On Aqua the Command key. On X11 equal to
  Mod1 (Alt) in Tk 8.6, equal to Meta in Tk 9.0.4.

**container check**
: In this book: check in an Ubuntu 24.04 container on 2026-10-20 with
  Tcl/Tk 8.6.14 (package) and 9.0.4 (`/opt/tcl9`), Xvfb without a
  window manager.

## D

**DBus**
: Message bus of the session. `xfconf-query`, `notify-send` and
  libnotify need it. Address in `DBUS_SESSION_BUS_ADDRESS`.

**DISPLAY**
: Environment variable with the address of the X server, such as `:0`
  or `:99`. Without it Tk does not start under X11.

## E

**encoding system**
: Default encoding of Tcl. On Linux taken from `LC_ALL`, `LC_CTYPE`,
  `LANG`. `C` and no locale: iso8859-1.

**EWMH**
: Extended Window Manager Hints, the `_NET_WM_*` properties. Tk uses
  them to set fullscreen, `-zoomed`, `-type`, opacity and the window
  icon.

**exo-open**
: Xfce tool that starts preferred applications by role
  (`--launch FileManager`). Under Xfce, `xdg-open` passes on to it.

## F

**fontconfig**
: Library that maps font names to files. Tk asks for `sans-serif` and
  `monospace`. `fc-match` shows the result.

**forky**
: Code name of Debian 14, currently testing. Test system of the series.

## L

**libnotify**
: Library for desktop notifications. Tk 9 loads `libnotify.so.4` at
  runtime for `tk sysnotify`.

**locale**
: Language and character set setting from `LC_ALL`, `LC_CTYPE`,
  `LANG`. On Linux it determines `encoding system`.

## M

**Mod1, Mod4**
: X11 modifier bits. In the default layout Mod1 = Alt, Mod4 = Super.

**MouseWheel**
: Wheel event in Tk. Under X11 only from Tk 9 on; Tk 8.6 reports the
  wheel as `<Button-4>` and `<Button-5>`.

**multiarch**
: Debian layout for libraries per architecture, such as
  `/usr/lib/x86_64-linux-gnu`. The real `tclConfig.sh` lives there.

## O

**os-release**
: File `/etc/os-release` with `ID`, `ID_LIKE`, `VERSION_CODENAME`.
  Source for the distribution.

## P

**PRIMARY**
: The X11 selection of the most recently selected text. Pasted with
  the middle mouse button (`<<PasteSelection>>`).

## R

**reparenting**
: A window manager puts the window into a frame of its own. Recognizable
  by `wm frame .` and `winfo id .` being different.

**RUNPATH**
: Search path for libraries, recorded in an ELF file. The source build
  sets `/opt/tcl9/lib`.

## S

**scalingPct**
: `::tk::scalingPct`, Tk 9: resolution as a percentage of 96 dpi,
  rounded to 25, at least 100.

**StartupWMClass**
: Key in a `.desktop` file. Must match the class from `WM_CLASS`.

## T

**TCL9_0_TM_PATH**
: Additional tm paths for Tcl 9.0, also read by 9.1. Separated by
  colons, inserted in reverse order. For 8.6: `TCL8_6_TM_PATH`.

**TCLLIBPATH**
: Environment variable whose entries are put at the front of
  `auto_path`. A Tcl list, separated by spaces.

**tk scaling**
: Pixels per point. At 100 dpi 1.389.

## W

**Wayland**
: Display protocol, successor to X11. Tk 9.0.4 has no Wayland backend
  and runs there via XWayland.

**window manager**
: Program that provides frame, title bar, focus and iconify under X11.
  Under Xfce, xfwm4. Xvfb has none.

**WM_CLASS**
: X property with the name and class of a window. Tk: program name and
  program name with a capital first letter.

## X

**X resources**
: Settings database of the X server (`xrdb`). Tk reads it at startup.
  `*TkTheme` selects the ttk theme.

**X11**
: Windowing system of Tk on Linux. `tk windowingsystem` returns `x11`.

**XDG**
: Freedesktop specifications. Here mainly Base Directory
  (`XDG_CONFIG_HOME` and related) and `user-dirs`.

**xdg-open**
: Opens a file or address with the default application. Package
  `xdg-utils`.

**xdg-user-dir**
: Returns the localized path of a user directory (`DOCUMENTS`).
  Package `xdg-user-dirs`.

**Xfce**
: Desktop on the author's workstation, version 4.20.

**xfconf**
: Settings service of Xfce, read and written with `xfconf-query`.

**Xft**
: X FreeType, Tk's font rendering under X11.
  `tk::pkgconfig get fontsystem` returns `xft`.

**Xft.dpi**
: X resource for the font DPI. Tk 9 derives `tk scaling` from it,
  Tk 8.6 does not.

**Xvfb**
: X server without a screen and without a window manager. For tests.
  `xvfb-run` starts it for one command.

**XWayland**
: X server that a Wayland compositor provides for X11 programs.

## Z

**zipkit**
: Statically built interpreter with the Tcl library appended, the basis
  for distributable `zipfs mkimg` programs.

---

*Next chapter: [Error messages](830-anhang-fehlermeldungen.md)*
