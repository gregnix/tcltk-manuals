# Building Tk: dependencies

## Introduction

Building Tcl/Tk 9 on Linux yourself requires a compiler and the X11
development packages. The build itself, with all switches, is described
in *Tcl/Tk 9.0 bauen* and *Tcl/Tk 9.1 bauen*. This chapter only checks
which libraries a Linux Tk actually needs and brings along, and where
the Debian package differs from a source build. It is based on
`serie-tcltk-bauen`, checked on Debian forky (September 2026) with
`tclsh8.6` (8.6.18) and `tclsh9.0` (9.0.4), 12 of 12 howtos passed in
each case. In the container the series ran under 8.6.14 with 11 OK and
1 SKIP (howto 10: Ubuntu does not have Itcl installed for 8.6), and
under 9.0.4 with 11 OK and 1 FAIL; the FAIL is described below.

---

## What Debian needs to build Tk

`apt-cache showsrc tk8.6` lists four X development packages and
`tcl8.6-dev` as Build-Depends (howto 02):

```text
libx11-dev libxss-dev libxext-dev libxft-dev tcl8.6-dev
```

Plus the toolchain from `build-essential`. `libxft-dev` pulls in
fontconfig and freetype. For freetype the package is now called
`libfreetype-dev`; `libfreetype6-dev` is only a transitional package.

According to *Tcl/Tk 9.0 bauen* (tried on Ubuntu 24.04), a source build
of Tk 9 additionally needs [`libxi-dev`]{.index}: `configure` got stuck
there on `X11/extensions/XInput2.h`. Debian does not list `libxi-dev`
for `tk8.6`, and no linked Tk library needs `libXi` (see below).
`XInput2` does not occur in the source code of Tk 9.0.4 (container
search across all files). Where the requirement came from is not
resolved. The series' recommendation stands: for a self-built Tk 9,
install the package; it does no harm, and `configure` does not abort
late for lack of the header.

---

## TK_LIBS and TCL_LIBS

What an installation links is recorded in `tkConfig.sh` and
`tclConfig.sh` (howtos 03 and 04). Debian forky:

```text
TK_LIBS  (8.6)  -lX11 -lXss -lXext -lXft -lfontconfig -lfreetype … -lz …
TCL_LIBS (8.6)  -ldl -lz -lpthread -lm
TCL_LIBS (9.0)  -ldl -lz -lpthread -lm -ltommath
```

Container check:

```text
TK_LIBS  (Quellbau 9.0.4)  -lX11 -lXss -lXext -lXft -lfontconfig -lfreetype -lfontconfig -ldl -lz -lpthread -lm
TCL_LIBS (Ubuntu 8.6.14)   -ldl -lz -lpthread -lm
TCL_LIBS (Quellbau 9.0.4)  -ldl -lz -lpthread -lm
```

This is where the FAIL in the container comes from: howto 03 expects
`-ltommath` under 9.0. The Debian package `tcl9.0` links against the
system library libtommath; a source build compiles in the bundled
version and needs no `-ltommath`. Both are correct; the demo only
checks the Debian situation.

`zlib1g-dev` is mandatory for Tcl. If it is missing, a self-build often
stops with an unclear `configure` message (howto 03).

---

## What is really linked

`TK_LIBS` is the intention, `ldd` on the library is the result
(howto 07). Debian forky, `libtk8.6.so` and `libtcl9tk9.0.so`: Xft,
Xss, X11, Xext, fontconfig, freetype, Xrender, zlib, no `libXi`.
`ldd` lists `libpng16` for all three Tk versions, but only via
freetype (see below).

`ldd` also shows what a library pulls in through others. Xrender
comes via Xft, not as its own `-lXrender`. The list of direct
dependencies is more precise:

```bash
readelf -d /opt/tcl9/lib/libtcl9tk9.0.so | grep -E 'NEEDED|RUNPATH'
```

Container check:

| Library | directly needed (`NEEDED`) | `RUNPATH` |
|------------|-----------------------------|-----------|
| `libtk8.6.so` (Ubuntu) | Xft, fontconfig, X11, Xss, m, c | none |
| `libtcl9tk9.0.so` (source build) | Xft, fontconfig, X11, Xss, m, c | `/opt/tcl9/lib` |
| `libtcl8.6.so` (Ubuntu) | z, m, c | none |
| `libtcl9.0.so` (source build) | z, m, c | `/opt/tcl9/lib` |

In the container `ldd` lists `libpng16` for **both** Tk versions, as a
dependency of freetype. The same on the workstation (Debian forky):
`readelf -d` shows no `libpng` under `NEEDED` for `libtk8.6.so`,
`libtcl9tk9.0.so` and `libtcl9tk9.1.so`; `libfreetype.so.6` has it
directly there. Tk 9.1 additionally needs HarfBuzz and Xrender directly.

The `RUNPATH` `/opt/tcl9/lib` is set by the source build. It ensures
that `tclsh9.0` finds its library without `LD_LIBRARY_PATH`, but ties
it to this location. This becomes important when distributing, see
[Distributing](150-weitergeben.md).

---

## tclConfig.sh on Debian

On Debian and Ubuntu, `/usr/lib/tcl8.6/tclConfig.sh` is a two-line
wrapper (howto 09; the same in the container):

```sh
#! /bin/sh
. /usr/lib/`dpkg-architecture -qDEB_HOST_MULTIARCH`/tcl8.6/tclConfig.sh
```

The values are in `/usr/lib/x86_64-linux-gnu/tcl8.6/tclConfig.sh`.
Searching the wrapper file for `TCL_LIBS` with `grep` finds nothing.
A source build into `/opt/tcl9` puts `tclConfig.sh` directly into
`/opt/tcl9/lib`; `configure --with-tcl=` wants exactly this directory.
For TEA extensions see *Tcl-Erweiterungen*.

---

## Threads and shared

- Tcl 8.6 is always built with threads: `TCL_THREADS=1`. Tcl 9 no
  longer has a switch; `--enable-threads` only produces
  `WARNING: unrecognized options` (howto 05).
- A normal Linux build is shared: `TCL_SHARED_BUILD=1`,
  `libtcl9.0.so`, `info sharedlibextension` is `.so` (howto 06;
  container: all three confirmed). Static (`--disable-shared`) is
  the exception for zipkits.

---

## Two pitfalls when building

From `serie-tcltk-bauen`, howto 11:

- **Empty `.o`:** An aborted `make` leaves behind object files
  of zero bytes with a new timestamp. `make` does not compile them
  again, and the linker later fails with
  `file format not recognized`. Find them with
  `find . -name '*.o' -size 0`.
- **`LD_LIBRARY_PATH` with Tcl 9:** The freshly built `tclsh` in the
  build directory does not find `libtcl9.0.so` as long as it is not
  installed. The message suggests `TCLSH_NATIVE`; what is meant is
  the library path: `env LD_LIBRARY_PATH=$PWD make`.

The series' `configure` lines (howto 12):

```bash
cd tcl9.0.4/unix
./configure --prefix=/opt/tcl90 --enable-shared --enable-64bit
env LD_LIBRARY_PATH=$PWD make
make install

cd ../../tk9.0.4/unix
./configure --prefix=/opt/tcl90 --exec-prefix=/opt/tcl90 \
    --with-tcl=/opt/tcl90/lib --enable-64bit
env LD_LIBRARY_PATH=/opt/tcl90/lib make
make install
```

`configure` runs in the `unix/` directory, not in the root of the tree.

---

## Summary

- Debian builds Tk against `libx11-dev libxss-dev libxext-dev libxft-dev`.
  For a Tk 9 source build, add `libxi-dev`.
- Linked are Xft, fontconfig, X11, Xss; through these Xext, Xrender,
  freetype, zlib, `libpng`. No `libXi`. Tk 9.1 also HarfBuzz and
  Xrender directly.
- `-ltommath` only with the Debian package `tcl9.0`, not with a source
  build.
- `tclConfig.sh` on Debian is a wrapper; the values are in the
  multiarch file.
- A source build sets `RUNPATH` to the prefix.

---

*Next chapter: [Distributing](150-weitergeben.md)*
