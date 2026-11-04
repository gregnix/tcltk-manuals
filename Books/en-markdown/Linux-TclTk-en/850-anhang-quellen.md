# Sources

## Introduction

The book explains in the text where a statement comes from. This
appendix lists the sources in full. Third-party texts are summarized,
not translated or copied. Short verbatim passages, such as error
messages and commands, are shown in code blocks.

---

## Own runs

### The author's howto series

The series are the author's companion material; `serie-linux`,
`serie-xvfb` and `serie-xfce` are under [`Serien/`](https://github.com/gregnix/tcltk-manuals/tree/main/Serien).
Each contains
`README.md` with the section "Gemessen" (measured), `TUTORIAL.md`,
`howto/00-referenz.md` and, for each howto, an explanation `NN-*.md`
with a demo `NN-*.tcl`; `run-all.tcl` starts all demos.

| Series | Howtos | As of, per README | Used in |
|-------|--------|------------------------|--------------|
| `serie-linux` | 12 | Linux, Tcl 8.6.18, Debian forky; no date | tcl_platform, paths, encoding, exec, dialogs |
| `serie-xvfb` | 20 | Tcl/Tk 8.6.14 and 9.0.4 under Xvfb, without a window manager and with openbox; no date | X11, both test chapters |
| `serie-xfce` | 12 | Xfce 4.20, Debian, X11; no date | Xfce, desktop integration |
| `serie-tcltk-bauen` | 12 | Debian forky, 2026-09-15, `tclsh8.6` and `tclsh9.0`, 12/12 each | Which Tcl, building Tk, search paths |
| `serie-tcl9-app` | 18 | Tcl 9.0.x | Distributing |

The values for Xfce with a 29-pixel title bar come from `serie-xvfb`
(howtos 04 and 13), checked on the author's workstation.

### Container check

On 2026-10-20 in a container with Ubuntu 24.04.5 LTS, kernel 6.18.44,
x86_64, glibc 2.39.

- Tcl/Tk 8.6.14 from the Ubuntu packages `tcl8.6`, `tk8.6`.
- Tcl/Tk 9.0.4 as a source build under `/opt/tcl9`, sources next to it
  under `tcl9.0.4` and `tk9.0.4`.
- Xvfb 21.1.12 without a window manager, 1280x1024x24, 100 dpi; for
  scaling additionally 1920x1080 with `-dpi 192`; for X resources with
  `-noreset`.
- Tools: `xdotool`, `xclip`, `xprop`, `xrdb`, `xmodmap`, `readelf`,
  `objdump`, `notify-send` 0.8.3 (libnotify 0.8.3).
- Runs with `env -i` for search paths and encoding.
- Scripts: `beispiele/messprobe-linux.tcl`, `rad-und-tasten.tcl`,
  `auswahl-probe.tcl`, `wm-probe.tcl`, `spaeter-rahmen.tcl`, `utf8-wache.tcl`,
  `xdg-ordner.tcl`; plus all series except `serie-xfce` (see
  [CLI](810-anhang-cli.md)).

### Check on lxpro

On the author's workstation, Debian unstable (forky), October 2026,
run by the author:

- Debian packages `tcl8.6` 8.6.18, `tcl9.0` 9.0.4, `tcl9.1` 9.1.0,
  `tk9.0` 9.0.4, `tk9.1` 9.1.0, `libsqlite3-tcl` 3.53.4-2, from
  2026-11-03 on 3.54.1-1 from unstable.
- BAWT builds 9.0.1 and 9.0.4 under `/opt/Tcl`, source build 9.1.0
  under `/opt/tcl91`.
- sqlite3 3.53.4 from `sqlite3.53.4.tar.gz` of the Tcl 9.1.0
  distribution, built against Debian's `tcl8.6-dev`, `tcl9.0-dev` and
  `tcl9.1-dev`.
- Reports with `examples/demo-tuappinfo.tcl` from tclutils 0.69.0.
- Check of the open points on 2026-11-02 under Xfce 4.20, X11,
  `wish` 8.6.18, 9.0.4 and 9.1.0: `os-release`, `wm frame`, `-alpha`,
  `scalingPct` on the dialog, `<Command-c>`, Super, `xfce4-clipman`,
  `zenity`, `desktop-file-validate`, `tk systray`, Xfce detection,
  `grab -global`, `readelf -d`.

### What was missing in the container

Installed additionally for XWayland: `weston` 13.0.0, `xwayland`,
`x11-apps` (Ubuntu packages), Weston nested inside Xvfb.

Not present in the container and therefore not checked: desktop
session, session DBus, Xfce, window manager, Wayland, CUPS,
`xdg-user-dirs`, `desktop-file-utils`, `zenity`, `kdialog`, Debian
itself.

---

## Tcl and Tk

- **Tcl/Tk source code 9.0.4**, read in the container:
  - `tk/generic/tkEvent.c`: translation of buttons 4 to 7 into
    `MouseWheel`.
  - `tk/generic/tkBind.c`: modifier table (`Command`, `Option`),
    button numbers from 4 on with `event generate`.
  - `tk/unix/tkUnixKey.c`: determining the Meta and Alt bits.
  - `tk/unix/tkUnixWm.c`: `WM_CLASS`, `_NET_WM_*`.
  - `tk/unix/tkUnixEvent.c`: fallback to 75 dpi under XWayland.
  - `tk/unix/tkUnixSysNotify.c`, `tk/unix/tkUnixSysTray.c`,
    `tk/library/systray.tcl`: `tk sysnotify`, `tk systray`.
  - `tk/library/print.tcl`: `tk print` under X11.
  - `tk/library/scaling.tcl`: scaling under X11.
  - `tk/library/ttk/fonts.tcl`: standard fonts.
  - `tk/library/tkfbox.tcl`: file dialog, hidden files.
  - `tcl/library/init.tcl`, `tcl/library/auto.tcl`: `auto_execok`,
    `auto_reset`.
  - `tcl/library/msgcat/msgcat.tcl`: locale variables.
  - `tcl/library/tcltest/tcltest.tcl` (2.5.11): return value of
    `runAllTests`.
  - `tcl/unix/Makefile.in`, `tk/unix/Makefile.in`: installed
    programs.
  <https://core.tcl-lang.org/tcl/>, <https://core.tcl-lang.org/tk/>
- **Tcl/Tk manual pages** 9.0: `bind`, `event`, `selection`,
  `clipboard`, `wm`, `winfo`, `tk`, `file`, `exec`, `encoding`,
  `zipfs`, `tm`. <https://www.tcl-lang.org/man/tcl9.0/>
- **TIP 602**: no longer expand the tilde in the file system.
  <https://core.tcl-lang.org/tips/doc/trunk/tip/602.md>
- **TIP 656**: encoding profiles, `strict` as the default.
  <https://core.tcl-lang.org/tips/doc/trunk/tip/656.md>
- **Tcl/Tk 9.1.0**, download page with release notes and the bundled
  packages, among them `sqlite3.53.4.tar.gz`.
  <https://sourceforge.net/projects/tcl/files/Tcl/9.1.0/>

---

## Debian

- **tcltk-defaults**: default version of Tcl/Tk in Debian.
  <https://tracker.debian.org/pkg/tcltk-defaults>

---

## Specifications

- **XDG Base Directory Specification**, freedesktop.org.
  <https://specifications.freedesktop.org/basedir-spec/latest/>
- **Desktop Entry Specification**, freedesktop.org.
  <https://specifications.freedesktop.org/desktop-entry-spec/latest/>
- **Extended Window Manager Hints (EWMH)**, freedesktop.org.
  <https://specifications.freedesktop.org/wm-spec/latest/>
- **xdg-user-dirs**, freedesktop.org.
  <https://www.freedesktop.org/wiki/Software/xdg-user-dirs/>
- **os-release**, systemd manual page `os-release(5)`.
- Manual pages: `Xvfb(1)`, `xvfb-run(1)`, `xrdb(1)`, `xprop(1)`,
  `xmodmap(1)`, `xclip(1)`, `xdotool(1)`, `xdg-open(1)`, `notify-send(1)`,
  `fc-match(1)`, `readelf(1)`, `ld.so(8)`, `locale(7)`.

---

## Companion books in the same series

| Book | Used for |
|------|---------------|
| *Debian unter Linux* (`book-linux-debian`), chapters *Tcl unter Linux*, *Debian erkennen*, *Suite und Codename* | Location of the Tcl installations on lxpro and decoder, rules for `/opt`, `os-release` |
| *Tcl/Tk unter macOS* (`book-macos-tcltk`) | Structure and style; comparison with Aqua |
| *Tcl/Tk 9.0 bauen* (`book-tcltk9.0-bauen`), *Tcl/Tk 9.1 bauen* (`book-tcltk9.1-bauen`) | Unix dependencies, `libxi-dev`, multiple installations, static builds |
| *Tcl-Anwendungen ausliefern* (`book-tcl-ausliefern`), in the text *Ausliefern* | zipfs, zipkits, `.deb` and `.rpm` |
| *C-Erweiterungen* (`book-tcl-erweiterungen`) | TEA against `tclConfig.sh` |
| *Pakete und Module* (`book-package-module`) | `auto_path`, `.tm` |
| *Tcl/Tk-Versionen nebeneinander* (`book-tcltk-versionen`) | same package version, binary extensions per version |
| *tclutils* (`book-tclutils`) | `tuappinfo` |
| *Tcl/Tk 9.1* (`book-tcltk9.1`) | `tk fileicon`, BiDi under X11 |
| *Encoding* (`book-encoding`) | Profiles, TIP 656 |
| *Testen* (`book-tcl-testen`) | `tcltest` |
| *Printing* (`book-printing`) | Printing via CUPS |

---

## Contradictions between the sources

Where results differ, the chapter says so. The most important ones:

- *Debian unter Linux*, chapter *Tcl unter Linux*: "`<Command-c>` …
  so on Linux responds to Alt+C." True for Tk 8.6; under Tk 9.0 and
  9.1 no key at all, in the container and on the Xfce workstation. See
  [Mouse, keyboard, clipboard](100-maus-tastatur-zwischenablage.md).
- `serie-linux`, README: `file volumes` returns `/`. Under Tcl 9
  additionally `//zipfs:/`.
- `serie-tcltk-bauen`, howto 03: `TCL_LIBS` of 9.0.4 contains
  `-ltommath`. True for the Debian package, not for the source build.
- `serie-tcltk-bauen`, howtos 04 and 07: Tk 9 additionally links
  `libpng`. In the container and on the workstation, `libpng16`
  appears for all Tk versions only via freetype (`readelf -d`).
- *Tcl/Tk 9.0 bauen*: `libxi-dev` needed because of `XInput2.h`. In
  the Tk 9.0.4 source code, `XInput2` does not occur.

---

## Trademarks

Linux is a trademark of Linus Torvalds. Debian is a trademark of
Software in the Public Interest, Inc. Ubuntu is a trademark of
Canonical Ltd. Xfce, X.Org and freedesktop.org are names of their
respective projects. Tcl and Tk are under a BSD-style license. This
book is not affiliated with these organizations.

---

*End of the book.*
