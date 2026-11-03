# Distributing

## Introduction

A Tcl program leaves its own machine in one of three ways: as a script
for the Tcl on the target machine, as a system package (`.deb`, `.rpm`)
or as a single executable file with [zipfs]{.index}. The book
*Ausliefern* describes all three in detail,
with zipkits, starkits and installers. This chapter only names what
stands out on Linux: which Tcl the target machine has, what an image
depends on, and what is needed for the desktop. The basis for zipfs is
`serie-tcl9-app`, rerun completely in the container (18 of 18 OK,
`tclsh9.0` 9.0.4).

---

## Which Tcl does the target machine have?

A script needs a suitable Tcl on the target machine. On Linux this is
usually 8.6 from the package:

- Debian Stable (trixie): Tcl 8.6.16 and the package `tcl9.0` 9.0.1.
- Debian Testing (forky) and unstable: 8.6.18, `tcl9.0` 9.0.4 and
  `tcl9.1` 9.1.0.
- Ubuntu 24.04: 8.6.14. In the container `apt-cache policy` knows no
  package `tcl9.0`.

A program that requires Tcl 9 therefore does not run with the system
Tcl on most Linux machines. It either brings its own Tcl, or it stays
8.6-capable. For a `.deb` with `Depends: tcl9.0`: the package must
exist on the target system. *Ausliefern*, chapter *Linux:
deb und rpm*, therefore advises checking `apt-cache policy tcl9.0 tcl8.6`
on the target beforehand.

A script that is to run under both versions observes the differences
in this book: tilde (see
[Paths, environment, XDG](040-pfade-umgebung-xdg.md)), encoding of
scripts ([Encoding and locale](060-kodierung-und-locale.md)),
mouse wheel ([Mouse, keyboard, clipboard](100-maus-tastatur-zwischenablage.md)).

---

## An image with zipfs mkimg

Tcl 9 can attach a directory as a ZIP to an interpreter. The result
is an executable file that mounts its archive under `//zipfs:/app`
at startup and runs `main.tcl` from it
(`serie-tcl9-app`, howtos 06 and 07):

```tcl
zipfs mkimg app.bin app.vfs app.vfs "" [info nameofexecutable]
file attributes app.bin -permissions 0o755
```

The fourth argument `""` is the password. It must be present when the
base follows as the fifth, otherwise the path ends up in the password
field.

Container check with a `main.tcl` that prints its location, built
on `/opt/tcl9/bin/tclsh9.0`:

```text
Größe     16374 Byte
lib       //zipfs:/lib/tcl/tcl_library
mounts    //zipfs:/lib/tcl  /opt/tcl9/lib/libtcl9.0.so
          //zipfs:/app      …/app.bin
script    //zipfs:/app/main.tcl
```

16 KB, because the image contains only the small `tclsh9.0` and its own
archive. The Tcl library is inside `libtcl9.0.so` and is mounted from
there. The image therefore depends on exactly this file:

```bash
ldd app.bin | grep tcl
#   libtcl9.0.so => /opt/tcl9/lib/libtcl9.0.so
readelf -d /opt/tcl9/bin/tclsh9.0 | grep RUNPATH
#   Library runpath: [/opt/tcl9/lib]
```

On a machine without `/opt/tcl9/lib/libtcl9.0.so` it does not start.
This has not been checked on a second machine, but follows from
`RUNPATH` and `NEEDED`. Such an image is good for practice, not for
distributing.

`serie-tcl9-app` stresses the opposite for static bases: if the
Tcl library is in the archive of the executable itself, `mkimg`
replaces this archive, and `tcl_library` must be copied into your own
`app.vfs` (howto 15). With the dynamic source build under `/opt/tcl9`
it is in `libtcl9.0.so` and is preserved. Which situation applies is
shown by `zipfs mount` in the base.

For GUI programs the base is `wish9.0`, not `tclsh9.0`
(howto 09). The image then additionally depends on `libtcl9tk9.0.so` and
on the X libraries of the target machine (see
[Building Tk: dependencies](140-tk-bauen-abhaengigkeiten.md)).

---

## Zipkit: static base

To distribute, the image needs a base that does not point to
`/opt/tcl9`: a statically built `tclsh` or `wish` with an
attached Tcl library, a [zipkit]{.index} (`serie-tcl9-app`,
howto 13). How to build or obtain one (BAWT, your own build with
`--disable-shared`) is described in *Ausliefern*, chapter *Zipkits bauen und
füllen*, and in *Tcl/Tk 9.0 bauen*, chapter *Statisch bauen*.

Even a static Tk depends on the system's X libraries (`libX11`,
`libXft`, `libfontconfig`). These exist on every Linux desktop, but
not on every server. And it depends on the C library: the source build
in the container requires symbols up to `GLIBC_2.38` (`objdump -T`),
Ubuntu 24.04 has 2.39. On a target with an older glibc it does not
start. Anyone building for many distributions builds on the oldest.
This has not been checked.

Because an image is just base plus ZIP, the same ZIP content can be
combined with a different base for a different platform, as long as
it contains no `.so` (howtos 16 and 17):

```sh
cat zipkit-linux-x86_64 app.zip > app
chmod +x app
```

---

## Desktop: launcher and icon

A program for the desktop needs, besides the executable file:

- a `.desktop` file in `~/.local/share/applications/` or
  `/usr/share/applications/`,
- an icon in the icon theme, for example
  `/usr/share/icons/hicolor/48x48/apps/meineapp.png`,
- a window class that matches `StartupWMClass`.

All three are described in
[Native dialogs and desktop integration](110-dialoge-und-desktop.md).
With an image, Tk takes the name not from the file but from the
start script in the archive. Container check, image `meineapp.bin` based on
`wish9.0`: `tk appname` is `main.tcl`, the class `Main.tcl`. Every
image with `main.tcl` thus has the same name for the window manager.
With `./meineapp.bin -name meineapp` it becomes `Meineapp`. The `-name`
therefore belongs in the `Exec` line. With a `wish` base, Tk is
already loaded when `main.tcl` runs; there only the command line helps.
With a `tclsh` base, `main.tcl` can set it in `::argv` before
`package require Tk` (see
[X11, window managers and Wayland](080-x11-fenstermanager-wayland.md)).

---

## Summary

- The target Tcl is usually 8.6. Tcl 9 is available as a package in
  Debian Stable (`tcl9.0` 9.0.1), Testing and unstable (`tcl9.0` 9.0.4,
  `tcl9.1` 9.1.0); Ubuntu 24.04 does not have it.
- `zipfs mkimg` on a dynamic `tclsh9.0` yields a small image that
  depends on `/opt/tcl9/lib/libtcl9.0.so`. To distribute, use a static
  base (zipkit).
- Even when static, X libraries and glibc are up to the target machine.
- The desktop needs `.desktop`, an icon and a matching window class.
- Details: *Ausliefern*.

---

*Next chapter: [FAQ](160-faq.md)*
