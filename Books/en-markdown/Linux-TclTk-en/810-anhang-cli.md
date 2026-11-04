# CLI

Quick reference for the commands in this book and the example scripts.
Unless stated otherwise, the results come from the container check on
2026-10-20 (Ubuntu 24.04, Tcl/Tk 8.6.14 and 9.0.4, Xvfb without a
window manager).

---

## At runtime

```tcl
array get tcl_platform
info patchlevel
info nameofexecutable
puts $tcl_library
puts $auto_path
tcl::tm::path list
tcl::pkgconfig get libdir,runtime
zipfs mount                         ;# Tcl 9 only
encoding system
tk windowingsystem                  ;# x11
winfo server .
tk scaling
tk::pkgconfig get fontsystem        ;# xft
ttk::style theme names              ;# clam alt default classic
```

---

## Shell

```bash
type -a tclsh tclsh8.6 tclsh9.0 wish9.0
dpkg -S /usr/bin/tclsh8.6
cat /etc/os-release
locale -a
echo "$XDG_SESSION_TYPE $DISPLAY $WAYLAND_DISPLAY $XDG_CURRENT_DESKTOP"
xdg-user-dir DOCUMENTS
xdg-mime query default inode/directory
fc-match sans-serif
xrdb -query
xmodmap -pm
xprop WM_CLASS                      # then click into the window
readelf -d /opt/tcl9/lib/libtcl9tk9.0.so | grep -E 'NEEDED|RUNPATH'
xvfb-run -a -s "-screen 0 1280x1024x24 -dpi 96" wish9.0 test.tcl
xfconf-query -c xsettings -p /Gdk/WindowScalingFactor
```

---

## Check script

`beispiele/messprobe-linux.tcl` prints all values used by the tables in
this book: platform and `os-release`, interpreter and search paths,
locale, tilde and `file volumes`, XDG variables, `exec` error cases, Tk
with screen, scaling and mouse wheel bindings, fonts, themes and X
resources, window attributes, `tk systray`, `tk sysnotify`, `tk print`
and the clipboard. Each query runs on its own; if a tool is missing, the
error message appears in that line.

```bash
tclsh8.6 messprobe-linux.tcl            # Tcl part only
env -i HOME=$HOME PATH=/usr/bin:/bin DISPLAY=$DISPLAY LANG=C.UTF-8 \
    /opt/tcl9/bin/wish9.0 messprobe-linux.tcl
wish9.0 messprobe-linux.tcl -keys       # then a window for keys
```

Differences between 8.6.14 and 9.0.4 in the container (identical values
omitted):

```text
                        8.6.14                        9.0.4
threaded                1                             (Schlüssel fehlt)
tcl_library             /usr/share/tcltk/tcl8.6       //zipfs:/lib/tcl/tcl_library
tk_library              /usr/share/tcltk/tk8.6        //zipfs:/lib/tk/tk_library
zipfs mount             (kein zipfs)                  //zipfs:/lib/tk  …/libtcl9tk9.0.so
                                                      //zipfs:/lib/tcl …/libtcl9.0.so
file home               Fehler                        /root
file normalize ~        /root                         <Arbeitsordner>/~
file volumes            /                             //zipfs:/ /
file tempdir            Fehler                        /tmp/tcl_…
Rechte /tmp             041777                        0o41777
tk::scalingPct          fehlt                         100
tk Unterbefehle         ohne print/sysnotify/systray  mit print, sysnotify, systray
Mausrad Text            Button-4/5, MouseWheel        nur MouseWheel
TButton -padding        3 3                           2.25p
<<Copy>>                ohne XF86Copy                 mit <Key-XF86Copy>
systray                 fehlt                         angelegt, exists=1
sysnotify               fehlt                         libnotify geladen
tk::print::cups         fehlt                         Tcl-Ensemble (lpstat/lpr)
```

Identical in both: `os` Linux, `machine` x86_64, `encoding system`
utf-8 under `C.UTF-8`, `windowingsystem` x11, screen 1280x1024 px,
325x260 mm, `tk scaling` 1.389, `TkDefaultFont` Inter 10, themes
`clam alt default classic`, background `#d9d9d9`, class
`Messprobe-linux.tcl`.

---

## More example scripts

| File | Purpose | Chapter |
|-------|-------|---------|
| `xdg-ordner.tcl` | XDG directories and user directories, 8.6 and 9 | Paths, environment, XDG |
| `utf8-wache.tcl` | UTF-8 script that works with 8.6 under `LANG=C` | Encoding and locale |
| `rad-und-tasten.tcl` | Trigger and read mouse wheel and modifiers with `xdotool` | Mouse, keyboard, clipboard |
| `auswahl-probe.tcl` | PRIMARY and CLIPBOARD, without deadlock | Mouse, keyboard, clipboard |
| `wm-probe.tcl` | Focus, frame, iconify, fullscreen, `WM_CLASS` | X11, window managers; tests |
| `spaeter-rahmen.tcl` | Dialog position with a late frame, once corrected vs. observed | Tests |
| `meinapp.desktop` | Template for the launcher | Native dialogs and desktop integration |
| `gui-test-xvfb.sh` | Test under `xvfb-run`, optionally with openbox | GUI tests with Xvfb |

All `.tcl` scripts exit on their own and therefore also run under
`xvfb-run`. `rad-und-tasten.tcl` needs `xdotool` and reports SKIP
without it.

---

## Howto series

Three of the series are published (chapter 1). Recorded here is how all
five ran in the
container and with what result:

```bash
cd serie-linux && tclsh8.6 run-all.tcl
cd serie-xvfb  && xvfb-run -a tclsh9.0 run-all.tcl
cd serie-xvfb  && xvfb-run -a sh -c 'openbox >/dev/null 2>&1 & sleep 1; ./run-all.tcl'
cd serie-xfce  && tclsh8.6 run-all.tcl          # only in an Xfce session
cd serie-tcltk-bauen && tclsh9.0 run-all.tcl
cd serie-tcl9-app    && tclsh9.0 run-all.tcl
```

Results in the container on 2026-10-20 (runs with `env -i`):

| Series | 8.6.14 | 9.0.4 |
|-------|--------|-------|
| `serie-linux` | 10 OK, 2 FAIL (03: no `USER`; 05: no `xdg-user-dir`) | 9 OK, 3 FAIL (additionally 02: tilde) |
| `serie-xvfb` (without window manager) | 19 OK, 1 SKIP (10: iconify) | 19 OK, 1 SKIP |
| `serie-tcltk-bauen` | 11 OK, 1 SKIP (10: Itcl missing) | 11 OK, 1 FAIL (03: no `-ltommath`) |
| `serie-tcl9-app` | not applicable | 18 OK |
| `serie-xfce` | SKIP (no Xfce) | not run |

The FAILs are differences in the environment, not errors in the series:
`env -i` does not set `USER`, Ubuntu does not have `xdg-user-dirs`
installed, Tcl 9 does not expand the tilde (see
[Paths, environment, XDG](040-pfade-umgebung-xdg.md)), and the source
build links libtommath in statically (see
[Building Tk: dependencies](140-tk-bauen-abhaengigkeiten.md)).

---

*Next chapter: [Glossary](820-anhang-glossar.md)*
