# Which Tcl?

## Introduction

On a Linux workstation there are often several Tcls side by side: the
distribution's under `/usr` and a self-built one under `/opt`. Both are
called `tclsh` with a version number. Which one answers is decided by
the `PATH` or the full path. This chapter shows how to recognize the
running Tcl and how the two kinds differ.

---

## The three origins

| Origin | Location | Invocation | checked with |
|----------|-----|--------|----------|
| Distribution package Tcl 8.6 | `/usr/bin` | `tclsh8.6`, `wish8.6`, often `tclsh` | Debian forky 8.6.18, Ubuntu 24.04 8.6.14 |
| Distribution package Tcl 9.0 | `/usr/bin` | `tclsh9.0`, `wish9.0` | Debian forky 9.0.4 (`serie-tcltk-bauen`) |
| Distribution package Tcl 9.1 | `/usr/bin` | `tclsh9.1`, `wish9.1` | Debian forky and unstable 9.1.0 |
| Source build | `/opt/tcl9` | `/opt/tcl9/bin/tclsh9.0`, `wish9.0` | Container 9.0.4 |

Which packages the Debian branches carry, among them [`tcl9.0`]{.index}
(source packages, as of
2026-11-02, `qa.debian.org/madison.php`):

| Package | Stable (trixie) | Testing (forky) | unstable (sid) |
|---|---|---|---|
| `tcl8.6` | 8.6.16 | 8.6.18 | 8.6.18 |
| `tcl9.0` | 9.0.1 | 9.0.4 | 9.0.4 |
| `tcl9.1` | – | 9.1.0 | 9.1.0 |

For each `tcl…` there is the matching `tk…` in the same version. The
maintainer of the Tcl packages announced in November 2026 that Tcl/Tk
9.0 will be dropped for forky; 9.1 would then remain alongside 8.6.
8.6 stays the default: Debian builds packages with a C part only
against 8.6, as long as the `tcltk-defaults` packages say nothing else.
The Debian book, chapter *Tcl unter Linux*, describes the situation on
the author's machines: on the Debian workstation the packages for
8.6.18, 9.0.4 and 9.1.0 under `/usr` and a self-built 9.1.0 under
`/opt/tcl91`, on a second machine a self-built 9.0.4 under `/opt/tcl9`. Ubuntu 24.04 in the
container has only 8.6.14 as a package.

The rules from the Debian book apply here unchanged: never install your
own Tcl into `/usr`, but into `/opt`. The build itself is described in
*Tcl/Tk 9.0 bauen* and *Tcl/Tk 9.1 bauen*, chapter
*Mehrere Installationen*.

---

## Who answers?

In the shell:

```bash
type -a tclsh tclsh8.6 tclsh9.0 wish9.0
ls -l /usr/bin/tclsh /usr/bin/wish
dpkg -S /usr/bin/tclsh8.6          # Debian and Ubuntu only
```

In the container, `/usr/bin/tclsh` is a symlink to `tclsh8.6`,
`/usr/bin/wish` one to `wish8.6`. `update-alternatives --display tclsh`
reports "no alternatives for tclsh" there: the link belongs to the
package `tcl`, not to the alternatives system.

In the interpreter:

```tcl
puts [info nameofexecutable]    ;# path of the invocation
puts [info patchlevel]
puts $tcl_library
puts [tcl::pkgconfig get libdir,runtime]
```

Container check:

| Value | `tclsh8.6` (Ubuntu) | `tclsh9.0` (`/opt/tcl9`) |
|------|---------------------|--------------------------|
| `info patchlevel` | 8.6.14 | 9.0.4 |
| `$tcl_library` | `/usr/share/tcltk/tcl8.6` | `//zipfs:/lib/tcl/tcl_library` |
| `libdir,runtime` | `/usr/lib/x86_64-linux-gnu` | `/opt/tcl9/lib` |
| `scriptdir,runtime` | `/usr/share/tcltk/tcl8.6` | `/opt/tcl9/lib/tcl9.0` |
| `zipfs mount` | command missing | `//zipfs:/lib/tcl` on `libtcl9.0.so` |

Two things stand out. Debian and Ubuntu put the Tcl library into
`/usr/share/tcltk`, not into `/usr/lib/tcl8.6` like a source build of
8.6. And a source build of Tcl 9 attaches the script library as a ZIP
to `libtcl9.0.so`. `$tcl_library` then points into [zipfs]{.index}.
The folder `/opt/tcl9/lib/tcl9.0` from `scriptdir,runtime` does not
exist in the container; it is a leftover of the build default.

The Debian packages for Tcl 9 store the library without zipfs. On
the Debian workstation, `tclsh9.0` reports the folder `/usr/lib/tcl9.0`, `tclsh9.1` the
folder `/usr/lib/tcl9.1`.

---

## Tk for Tcl 9.1

Debian splits Tcl and Tk into separate packages. If you install only
`tcl9.1`, you have no `wish9.1`, and `package require Tk` in `tclsh9.1`
still reports a version. On the Debian workstation, without the
package `tk9.1`:

```text
% package require Tk
9.0.4
```

`tclsh9.1` finds the index of Debian's Tk 9.0 under
`/usr/lib/tcltk/x86_64-linux-gnu/tk9.0` via `auto_path` and loads it.
That works because Tk 9.0 binds to Tcl via the stub table; the release
notes of Tk 9.1.0 explicitly name Tcl 9.0 or 9.1 as the basis. But it
is not Tk 9.1: the new features of 9.1 are missing. Remedy:

```bash
sudo apt install tk9.1
```

After that, `package require Tk` in `tclsh9.1` returns version 9.1.0,
and `wish9.1` is there.

---

## A source build that loads Debian's library

A Tcl under `/opt` is only separate if it also loads its own `libtcl`.
The file has the same name in Debian and in the source build,
`libtcl9.0.so`. If the loader finds Debian's file first, the program
from `/opt` runs with Debian's library. On the Debian workstation with a
BAWT build
9.0.1 under `/opt/Tcl`:

| Invocation | `info patchlevel` | `$tcl_library` |
|--------|-------------------|----------------|
| `/opt/Tcl/bin/tclsh9.0` | 9.0.4 | `/usr/lib/tcl9.0` |
| `LD_LIBRARY_PATH=/opt/Tcl/lib /opt/Tcl/bin/tclsh9.0` | 9.0.1 | `//zipfs:/lib/tcl/tcl_library` |

Without `LD_LIBRARY_PATH`, the BAWT program reports Debian's version
and Debian's script library. It then also sees Debian's packages
first. This can be checked with `ldd`:

```bash
ldd /opt/Tcl/bin/tclsh9.0 | grep libtcl
```

If the line points to `/usr/lib/x86_64-linux-gnu`, the program needs a
small launcher file, for example `~/bin/tclsh9b`:

```sh
#!/bin/sh
LD_LIBRARY_PATH=/opt/Tcl/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH} exec /opt/Tcl/bin/tclsh9.0 "$@"
```

An alias is not enough: it only applies in the interactive shell, not
in scripts and makefiles. The source build into `/opt/tcl9` in the
container needs no launcher file: `readelf -d /opt/tcl9/bin/tclsh9.0`
shows `RUNPATH` `/opt/tcl9/lib`, and the program finds its own library
before that of the system. In the BAWT build on the Debian workstation
no such entry
takes effect; what is there is shown by `readelf -d` on the machine
itself.

---

## tclsh and wish in the PATH

A source build into `/opt/tcl9` puts `tclsh9.0` and `wish9.0` into
`/opt/tcl9/bin`. In the container there was additionally a link
`tclsh -> tclsh9.0` there, but no link `wish`. `make install` does not
create this link: the target `install-binaries` in `unix/Makefile.in`
of 9.0.4 installs only `tclsh9.0`. So the link was created by hand, as
*Tcl/Tk 9.0 bauen* suggests in the chapter *Mehrere Installationen*.
Consequence: with `/opt/tcl9/bin` at the front of the `PATH`, `tclsh`
starts Tcl 9, but `wish` still starts the `wish8.6` from `/usr/bin`.

Therefore always invoke with the version number. For 9.1 alongside
9.0, the Debian book advises not to put both prefixes into the `PATH`,
but to use the full path.

---

## The shebang line

An executable script names its interpreter in the first line. On Linux
there are three common forms:

```tcl
#!/usr/bin/tclsh8.6
#!/usr/bin/env tclsh9.0
#!/opt/tcl9/bin/wish9.0
```

`/usr/bin/env` searches the `PATH`. That makes the script portable, but
dependent on the session: a program from the start menu sees a
different `PATH` than a terminal (see
[Native dialogs and desktop integration](110-dialoge-und-desktop.md)).
The full path is fixed, but tied to one machine.

The Linux kernel passes everything after the interpreter path as
**one** argument. `#!/usr/bin/env tclsh9.0 -encoding utf-8` therefore
looks for a program named `tclsh9.0 -encoding utf-8`. For options there
is `env -S` from GNU coreutils; check it on the target machine first.

The old form for systems on which the path to `wish` is unknown uses
the fact that Tcl reads a backslash at the end of a comment as a
continuation, but the shell does not:

```tcl
#!/bin/sh
# Only the shell reads the next line, for Tcl it is a comment \
exec wish9.0 "$0" "$@"
```

`serie-tcl9-app` (howto 02) uses `#!/usr/bin/env tclsh9.0` for Linux.

---

## How to recognize a Tcl 9

```tcl
if {[package vsatisfies [info patchlevel] 9-]} { ... }
```

Without a version comparison, Tcl 9 gives itself away by three things
(checked in the container):

- `$tcl_library` starts with `//zipfs:/` (in the source build).
- `file volumes` returns `//zipfs:/ /`, under 8.6 only `/`.
- `file attributes /tmp -permissions` returns `0o41777`, under 8.6
  `041777`.

The third affects code that compares the permission value as a string.
`expr` reads numbers with `0o` under both versions. Code that compares
permissions therefore calculates with the numeric value:

```tcl
set r [file attributes $datei -permissions]
expr {$r & 0o777}        ;# same under 8.6 and 9
```

---

## Summary

- Debian Stable: 8.6.16 and package `tcl9.0` 9.0.1. Testing and
  unstable: 8.6.18, `tcl9.0` 9.0.4 and `tcl9.1` 9.1.0. Announced: 9.0
  is dropped for forky, 9.1 remains. Your own Tcl into `/opt`, never
  into `/usr`.
- Debian puts `$tcl_library` into `/usr/share/tcltk/tcl8.6` and
  `/usr/lib/tcl9.x`. A source build of Tcl 9 puts it into zipfs on
  `libtcl9.0.so`.
- Without the package `tk9.1`, `tclsh9.1` loads Debian's Tk 9.0.
- A program under `/opt` can load Debian's `libtcl`. `ldd` checks
  this, a launcher file with `LD_LIBRARY_PATH` fixes it.
- Always invoke with the version number. `wish` without a number is
  usually 8.6.
- A shebang with `env` follows the `PATH` of the session.
- `file volumes` and the format of permissions differ between 8.6
  and 9.

---

*Next chapter: [Paths, environment, XDG](040-pfade-umgebung-xdg.md)*
