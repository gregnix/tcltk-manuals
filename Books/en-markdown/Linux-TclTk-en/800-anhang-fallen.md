# Pitfalls

Short list. Each line describes what **not** to do. The
reasoning is in the chapter named.

---

## Platform and interpreter

- Detecting Linux with `tcl_platform(platform) eq "unix"`. That also
  matches macOS. Use `os`.
- Reading the distribution from `tcl_platform(osVersion)`. That is the
  kernel, in the container even the host's.
- Detecting Debian by `/etc/debian_version`. Ubuntu has the file too
  (container: `trixie/sid`).
- Reading `tcl_platform(threaded)` without `info exists`. Under Tcl 9
  the key is missing.
- Taking `$env(USER)` for the user. It can be missing.
  `tcl_platform(user)` is reliable.
- Calling `wish` without a version number and expecting Tk 9. A source
  build does not create a `wish` link.
- Installing your own Tcl into `/usr`. Use `/opt`.
- Comparing permissions from `file attributes -permissions` as strings.
  8.6 returns `041777`, 9.0 `0o41777`.
- Taking `[lindex [file volumes] 0]` for `/`. Under Tcl 9
  `//zipfs:/` comes first.
- On Debian, installing `tcl9.1` without `tk9.1` and expecting Tk 9.1.
  `package require Tk` then loads Debian's Tk 9.0.
- Assuming a Tcl under `/opt` is separate without checking with `ldd`.
  It can load Debian's `libtcl` of the same name.
- Using an alias as the launch file. It does not apply in scripts and
  makefiles.

## Paths and search paths

- `file normalize ~` under Tcl 9. That yields `./~`. `$env(HOME)` or
  `file home`.
- Hard-coding `~/Documents`. The directory is localized;
  ask `xdg-user-dir DOCUMENTS`.
- Storing settings as a dotfile directly in `$HOME`. XDG:
  `~/.config/<programm>/`.
- Separating `TCLLIBPATH` with colons. It is a Tcl list.
- Separating `TCL9_0_TM_PATH` with spaces. Here the colon applies.
- Setting `TCLLIBPATH` for all versions to a directory with Tcl 9
  packages. `tclsh8.6` sees it too.
- Expecting a Tcl 9 under `/opt` to see the packages from
  `/usr/share/tcltk`.
- Putting your own packages for the system Tcl into `/usr/share/tcltk`. That
  belongs to `apt`; use `/usr/local/share/tcltk`.
- Expecting `libsqlite3-tcl` up to 3.53.4-2 under Debian's Tcl 9. It is
  built only for 8.6; only 3.54.1-1 (unstable) supports Tcl 9.
- Placing a second sqlite3 with a lower number alongside. The highest
  number wins; the directory only counts when the numbers are equal.
- A package as `.tm` and alongside it as `pkgIndex.tcl`. Which copy
  loads depends on what was loaded before; see *Which copy
  wins* in the chapter *Search paths*.
- Placing your own sqlite3 for Tcl 9 only in front of Debian's directory. Under 8.6
  the index then displaces Debian's version.
- Taking `package ifneeded` as proof of which library is loaded.
  Use `info loaded`.
- Testing a package draft with `dpkg -i`. Unpacking with `dpkg-deb -x`
  and loading via `auto_path` is enough and changes nothing under `/usr`.
- Forgetting the matching `libsqlite3-0` when testing an unpacked
  `libsqlite3-tcl`. The dynamically linked binding needs the
  same SQLite version.

## Encoding

- Assuming Linux is always UTF-8. Without a locale, `encoding system` is
  iso8859-1.
- Opening a file without `fconfigure -encoding`.
- Starting a UTF-8 script with umlauts under Tcl 8.6 from cron without
  a guard or `-encoding utf-8`.
- Relying on `LANG=de_DE` having the same effect under 8.6 and 9.
  8.6: iso8859-1, 9.0: utf-8.
- Setting `LANGUAGE` for `msgcat`. `msgcat` reads `LC_ALL`,
  `LC_MESSAGES`, `LANG`.

## Processes

- `exec` without `auto_execok` on a program that may be missing.
- Interpreting every `exec` error as a non-zero exit status. A
  line on stderr is an error too.
- Calling `xdg-open` without `&`.
- Using a blocking `exec` to call a program that reads your own
  X selection. Both wait for each other.
- Calling `auto_reset` just to make `auto_execok` search again.
  It also removes commands loaded later.

## X11 and window managers

- Relying on the exit status of `wish`. Without a display it exits
  with 0.
- Detecting a window manager with `winfo manager .`. That is always
  `wm`.
- Comparing `wm frame .` and `winfo id .` as strings. 8.6
  writes leading zeros.
- Placing a dialog below the main window with `gy + 80`. Frames
  are 0, 20 or 29 pixels high. `winfo rooty .`.
- Taking `wm geometry` for the position of the client area. It is the
  frame corner.
- Correcting a dialog's position once after a fixed delay.
  Some window managers create the frame later.
- Under openbox, taking `wm geometry` of a centered transient
  dialog for the frame corner. openbox places it itself; Tk reports
  the requested position.
- Expecting `-fullscreen`, `-zoomed`, `iconify` without a window manager.
- Writing `StartupWMClass=meineapp` and starting `wish meineapp.tcl`.
  The class is `Meineapp.tcl`.
- Under Wayland, expecting `tk windowingsystem` to be `wayland`. It is
  `x11`.

## Font, scaling, themes

- Assuming a font family. fontconfig substitutes silently.
- Hard-wiring pixel sizes in tests. They depend on DPI, font and,
  under Tk 9, on the scaling.
- Under Tk 8.6, assuming `Xft.dpi` affects `tk scaling`. It affects
  only the font.
- Expecting a native Linux theme. There are `clam alt default classic`.
- Starting Xvfb without `-noreset` and loading resources with `xrdb`. The
  server forgets them as soon as the last client leaves.

## Mouse, keyboard, clipboard

- Under Tk 9, binding the wheel via `<Button-4>`/`<Button-5>`. Those are
  the side buttons 8 and 9 there.
- Under Tk 8.6 on X11, binding only `<MouseWheel>`. The wheel arrives there
  as `<Button-4>`/`<Button-5>`.
- Binding `<Command-c>` on X11. 8.6: Alt, 9.0 and 9.1: no key
  (container and Xfce).
- Binding `<Super-c>`. The name is `Mod4`.
- Taking selecting for copying. Selecting sets PRIMARY, copying sets
  CLIPBOARD.
- Expecting the clipboard to survive the program's exit.
- `selection get -selection PRIMARY` without `catch`.

## Desktop

- Expecting the GTK file dialog. Tk draws its own, and it
  shows hidden files.
- Relying on the shell's `PATH` in `Exec=` of a `.desktop` file.
- Calling `zenity` without `-ignorestderr`. The GTK warning on stderr
  becomes an error, even if a file was selected.
- Taking `tk systray exists` for "icon visible".
- Taking `xfce4-clipman` installed for "clipboard persists". It
  must be running.
- Taking `tk sysnotify` for "notification shown". Without D-Bus it stays silent.

## Tests

- A key test without `update` and `focus -force`.
- Sending `event generate .w <Key>` to a widget without focus and expecting
  the binding of `.w`. The key goes to the focus widget.
- Reporting FAIL without `xvfb-run`. SKIP is correct.
- Calling `xvfb-run` without `-s` and expecting the screen size of another
  version.
- Forgetting `exit [tcltest::runAllTests]`. Otherwise `all.tcl` exits with 0.

## Building and distributing

- Leaving out `libxi-dev` for a Tk 9 source build.
- Passing `--enable-threads` to Tcl 9. Unknown switch.
- Searching for `TCL_LIBS` in `/usr/lib/tcl8.6/tclConfig.sh`. That is a
  wrapper.
- Distributing a `zipfs mkimg` built on a dynamic `tclsh9.0`. It
  depends on `/opt/tcl9/lib`.
- Building an image on a newer glibc than the target has.
- Leaving out the password argument of `zipfs mkimg` when the base
  follows.
- Installing a TEA package against Debian's Tcl with `make install-binaries`.
  It wants to go to `/usr/bin`; use `install-lib-binaries`.
- Building an extension for Tcl 9 against 9.1 and expecting it under 9.0.
  Build against 9.0.

---

*Next chapter: [CLI](810-anhang-cli.md)*
