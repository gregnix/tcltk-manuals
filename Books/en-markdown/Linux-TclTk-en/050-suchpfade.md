# Search paths

## Introduction

`package require` searches in [`auto_path`]{.index}, modules (`.tm`) in
the tm path. Every Tcl assembles both lists at startup from built-in
values and environment variables. Debian and Ubuntu change the
built-in values with their own patches. A self-built Tcl under
`/opt` does not know them. Anyone who has both side by side must know
who sees which packages.

The basics of `package`, `pkgIndex.tcl` and `.tm` are in the book
*Pakete und Module*. This chapter covers only the
Linux values.

---

## auto_path of the distribution Tcl

Container check, `tclsh8.6` from Ubuntu 24.04, with `env -i`, without
`TCLLIBPATH`:

```text
/usr/share/tcltk/tcl8.6
/usr/share/tcltk
/usr/lib
/usr/local/lib/tcltk
/usr/local/share/tcltk
/usr/lib/tcltk/x86_64-linux-gnu
/usr/lib/tcltk
/usr/lib/tcltk/tcl8.6
```

The list follows the Debian Tcl policy: architecture-independent packages
under [`/usr/share/tcltk`]{.index}, packages with a C part under
`/usr/lib/tcltk/<multiarch>`, local packages under `/usr/local/share/tcltk`
and `/usr/local/lib/tcltk`. `tcl_pkgPath` names the same package directories
in a different order, but not the library directory of the version.
That one is only in `auto_path`, at the front for 8.6: `/usr/share/tcltk/tcl8.6`.
Correspondingly, Debian's `tclsh9.0` lacks `/usr/lib/tcl9.0` in
`tcl_pkgPath`, and `tclsh9.1` lacks `/usr/lib/tcl9.1`.
Debian unstable with 8.6.18 returns the same list in
the same order.

Packaged libraries live there with the version number in the
directory name. In the container, `struct::list` loads from
`/usr/share/tcltk/tcllib1.21/struct/list.tcl`.

Your own packages for the system Tcl belong in `/usr/local/share/tcltk`
(pure Tcl) or `/usr/local/lib/tcltk` (with `.so`). There the
system Tcl finds them without further configuration, and `apt` does not touch them.

---

## auto_path of the Debian packages for Tcl 9

On Debian unstable, `tclsh9.0` from the package `tcl9.0`, without the
entries from
`TCLLIBPATH`:

```text
/usr/lib/tcl9.0
/usr/lib
/usr/local/lib/tcltk
/usr/local/share/tcltk
/usr/lib/tcltk/x86_64-linux-gnu
/usr/lib/tcltk
/usr/share/tcltk
/usr/lib/tcltk/tcl9.0          (fehlt)
```

`tclsh9.1` reports the same list with `9.1` instead of `9.0`. Unlike a
source build, Debian's Tcl 9 therefore sees **all** package directories of the
distribution, including those with libraries only for 8.6. Whether a package
loads under Tcl 9 is then decided by its `pkgIndex.tcl` alone. Packages like
tdom, tcltls, Thread or Img put two libraries side by side,
`libtdom0.9.6.so` for 8.6 and `libtcl9tdom0.9.6.so` for 9, and their
index chooses by version. Where the second file is missing,
`package require` fails under Tcl 9 (section *sqlite3 under Debian's
Tcl 9*).

In the list of tm paths, the packages for Tcl 9 show two directories
as a single entry:

```text
/usr/lib/tcltk /usr/share/tcltk/tcl9/site-tcl
/usr/lib/tcltk /usr/share/tcltk/tcl9/9.0
```

Tcl 9 does not find modules under `/usr/share/tcltk/tcl9` this way. On
the Debian unstable system checked, these directories do not exist, so
nothing is missing at present.

---

## auto_path of a source build

Container check, `/opt/tcl9/bin/tclsh9.0`, `env -i`:

```text
//zipfs:/lib/tcl/tcl_library
//zipfs:/lib/tcl
/opt/tcl9/lib
```

That is all. `/usr/share/tcltk` is not in it. A Tcl 9 under
`/opt` sees not a single package of the distribution, neither Tk extensions
nor Tcllib. That is intentional: a package for 8.6 with a C part does not load
under Tcl 9 anyway. Pure Tcl packages often run under both
versions, but must be added explicitly.

In the container, `/opt/tcl9/lib` brought its own versions: Tcllib 1.9
(`package versions struct::list`), Thread 3.0.6, sqlite3 3.53.0.
In total, after a `package require` for a
missing package, `tclsh9.0` knew 628 package names, `tclsh8.6` 584.

What `package require` returns on Debian forky/sid (Debian packages,
without `TCLLIBPATH`); `serie-tcltk-bauen`, howto 10, still lists
Thread 3.0.6 and tdbc 1.1.14:

| Package | Tcl 8.6.18 | Tcl 9.0.4 | Tcl 9.1.0 |
|-------|-----------|-----------|-----------|
| Thread | 3.0.7 | 3.0.7 | 3.0.7 |
| Itcl | 4.3.8 | 4.3.8 | 4.3.8 |
| sqlite3 | 3.53.4 | missing | missing |
| tdbc | 1.1.15 | 1.1.15 | 1.1.15 |

Thread comes from the package `tcl-thread` 1:3.0.7-2, tdbc from
`/usr/lib/tcltk/x86_64-linux-gnu/tdbc1.1.15`. sqlite3 fails under 9.0
and 9.1 with `this extension is compiled for Tcl 8.6` (section
*sqlite3 under Debian's Tcl 9*).

A source build takes sqlite from the `pkgs/` directory of the Tcl tree; the
Debian package `tcl9.0` lacked it there.

---

## sqlite3 under Debian's Tcl 9

The package [`libsqlite3-tcl`]{.index} contains, up to 3.53.4-2, only
one library, built for Tcl 8.6. Under `tclsh9.0` and `tclsh9.1`,
`package require sqlite3` then fails:

```text
% package require sqlite3
this extension is compiled for Tcl 8.6
```

Since 3.54.1-1 (unstable, November 2026) the package ships a second
library for Tcl 9; then there is nothing to do:

```text
/usr/lib/tcltk/x86_64-linux-gnu/sqlite3/
    libsqlite3.54.1.so        for 8.6
    libtcl9sqlite3.54.1.so    for 9.0 and 9.1
```

Both are dynamically linked against `libsqlite3.so.0` from
`libsqlite3-0`; the one built against 9.1 also loads under 9.0.4.

### With 3.53.4-2 or older

A second sqlite3 next to it only helps with the same number and at the
front of `auto_path`; with different numbers `package require` takes the
highest. So build the same version for both Tcl, from the sources of the
Tcl distribution (for 9.1.0 `sqlite3.53.4.tar.gz`, a TEA package):

```bash
cd sqlite3.53.4
mkdir b86 b90
(cd b86 && ../configure --with-tcl=/usr/lib/tcl8.6 --libdir=$HOME/lib/tcltk \
        && make && make install-lib-binaries)
(cd b90 && ../configure --with-tcl=/usr/lib/tcl9.0 --libdir=$HOME/lib/tcltk \
        && make && make install-lib-binaries)
```

- `install-lib-binaries`, not `install-binaries`: the latter also wants
  to put `sqlite3_analyzer` into `/usr/bin`.
- Build against 9.0: the library then loads under 9.0 and 9.1.
- Both libraries belong in the same directory; the generated index
  picks by version.

`~/lib/tcltk` goes to the front via `TCLLIBPATH`. If a package with a
higher number arrives later, the package wins again.

### Own build and package

An own build and Debian's package do not have the same
`PRAGMA compile_options`. Two of them change behavior:

| Option | own build 3.53.4 | Debian 3.54.1-1 |
|---|---|---|
| `DQS=0` | set: `SELECT "abc"` is an error | missing: returns `abc` |
| `USE_URI` | missing: `file:…` without `-uri 1` becomes a file name | set: URI |

The program fixes the behavior itself, the same in every build:

```tcl
sqlite3 db $datei -uri 1      ;# file: names always as URI
db config dqs_dml 0           ;# "text" in SELECT/INSERT … is an error
db config dqs_ddl 0           ;# likewise in CREATE TABLE …
```

`tdbc::sqlite3` is pure Tcl and needs no build of its own. Under 8.6
Debian's module loads, under Tcl 9 any `sqlite3-1.1.15.tm` in a tm path
of the version, for example via `TCL9_0_TM_PATH`. If the program has loaded
a package from an index before, the index wins at the same version
(section *Which copy wins*).

---

## TCLLIBPATH

[`TCLLIBPATH`]{.index} is put at the **front** of `auto_path` at startup.
The value is a Tcl list, separated by spaces, not
by colons like `PATH`. Container check, both versions
the same:

| `TCLLIBPATH` | Start of `auto_path` |
|--------------|------------------------|
| `/x/eins /x/zwei` | `/x/eins /x/zwei …` |
| `/x/eins:/x/zwei` | `/x/eins:/x/zwei …`, a single entry |

The second entry is a path that does not exist. Tcl reports nothing,
the package stays unfindable.

`TCLLIBPATH` applies to **every** Tcl that the session starts. Anyone who adds
directories with Tcl 9 packages to it also gives them to `tclsh8.6`. Tcl searches
one level below each entry for `pkgIndex.tcl`; a `.so` for
Tcl 9 fails under 8.6 at `load`. Cleaner is to keep a separate
directory per version and extend `auto_path` in the program:

```tcl
set hier [file dirname [file normalize [info script]]]
set auto_path [linsert $auto_path 0 [file join $hier lib]]
```

---

## tm paths

Modules are not searched in `auto_path`, but in the tm path
(`tcl::tm::path list`). Container check, Tcl 9.0.4 from `/opt/tcl9`:

```text
/opt/tcl9/lib/tcl9/site-tcl
/opt/tcl9/lib/tcl9/9.0
//zipfs:/lib/tcl/tcl9/site-tcl
//zipfs:/lib/tcl/tcl9/9.0
```

The Ubuntu `tclsh8.6` reports 25 entries: `site-tcl` and the directories
`8.0` to `8.6` each under `/usr/lib/tcltk/tcl8`, `/usr/lib/tcl8` and
`/usr/share/tcltk/tcl8`, plus `/usr/share/tcltk/tcl8.6/tcl8`.

Additional locations come from environment variables whose name carries the
version: [`TCL9_0_TM_PATH`]{.index} for Tcl 9.0, `TCL8_6_TM_PATH`
for 8.6, plus `TCL8_5_TM_PATH` and so on for older minor versions,
which 8.6 also reads. Tcl 9.1 reads `TCL9_1_TM_PATH` and also
`TCL9_0_TM_PATH`. For each name there is a spelling with a dot
(`TCL9.0_TM_PATH`), which `tm.tcl` also reads; in `bash` it cannot
be exported. These variables separate with a **colon**,
unlike `TCLLIBPATH`. Container check:

- `TCL9_0_TM_PATH=/x/tm90a:/x/tm90b`: Tcl 9.0.4 puts `/x/tm90b` and
  `/x/tm90a` at the top, in this reversed order.
- `TCL9_TM_PATH` and `TCL8_TM_PATH` (without minor version) are read by neither
  version.
- `TCL8_6_TM_PATH` is not seen by Tcl 9.0.
- Ubuntu's 8.6.14 does not put the entries from `TCL8_6_TM_PATH` at the
  top, but behind the eight directories under `/usr/lib/tcltk/tcl8`
  (checked with `TCL8_5_TM_PATH` and `TCL8_6_TM_PATH`: index 8 to 10
  of 28). Modules of the same name and same version in these directories
therefore win; a higher version wins regardless of the directory.

The reversed order follows from the fact that `tcl::tm::path add` inserts each
entry at the front. Anyone who needs a particular order sets it
in the program with `tcl::tm::path add`.

---

## Which copy wins

If a package exists as a module in the tm path and at the same time behind a
`pkgIndex.tcl` in `auto_path`, the copy that is loaded depends on what
the program requested before:

- If no index has been read yet, a matching module ends the search.
- The first search for a package that is not a module reads every
  `pkgIndex.tcl` in all directories of `auto_path`. After that, Tcl knows
  all versions from them. If one of them matches, a later call no longer
  asks for modules.
- With the same version, the index then wins. If the previously searched
  package lay in a different namespace directory than the module, the
  index wins even with a lower version: the module handler
  only searched in that directory, `struct/` for `struct::list`, the
  root for `tablelist`.

Checked with 8.6.14, 9.0.4 and 9.1.0, with the same result. The full
table and a script to reproduce it are in *Ausliefern*, chapter
Suchpfade.

On Linux this mainly affects old copies in directories from
`TCLLIBPATH`. A typical case: `~/lib/tcltk` still holds an
earlier installation with `pkgIndex.tcl`, the new one is in the same
version as a module in `site-tcl`. A program that first loads `tablelist`
(behind an index) gets the old copy afterwards; a
program that only requests the module gets the new one. The remedy is to remove the old
copy.

---

## Which package was loaded?

```tcl
package require struct::list
puts [package ifneeded struct::list [package present struct::list]]
```

The line shows the command Tcl would use to load the package, and thus
its path. That is the quickest answer to "why does my Tcl 9 load
the old package": usually a directory from `TCLLIBPATH` comes first.

For packages with a C part, [`info loaded`]{.index} is the proof. It names
every library the interpreter has actually loaded:

```tcl
package require sqlite3
puts [info loaded]
```

The report from `tclutils::tuappinfo` shows everything at once: the
search variables (`TCLLIBPATH`, `TCL*_TM_PATH`, `LD_LIBRARY_PATH`) entry
by entry, `auto_path`, `tcl_pkgPath` and the tm path with a
mark `(missing)` on every directory that does not exist, every loaded
package with its file and the list from `info loaded`. The example
of the library loads the named packages first:

```bash
tclsh9.0 examples/demo-tuappinfo.tcl sqlite3
```

---

## Summary

- Debian Tcl: `auto_path` via `/usr/share/tcltk` and
  `/usr/lib/tcltk/<multiarch>`, own packages into `/usr/local/…/tcltk`.
- Debian's Tcl 9 sees the same package directories as 8.6. Whether a package loads
  is decided by its index.
- `libsqlite3-tcl` up to 3.53.4-2 is built only for 8.6, from 3.54.1-1
  also for Tcl 9. For older ones: build the same version for 8.6 and 9.0
  and put it at the front of `auto_path`.
- Tcl 9 under `/opt` sees no distribution packages.
- `TCLLIBPATH`: Tcl list with spaces, applies to every Tcl of the
  session.
- `TCL9_0_TM_PATH`, `TCL8_6_TM_PATH`: colon, per version,
  inserted in reverse; 9.1 also reads `TCL9_0_TM_PATH`.
- A matching `.tm` ends the search as long as no index has been
  read. After that, with the same version, the index wins; after a package
  from a different namespace directory, even an older one does.
- Origin of a package: `package ifneeded` with `package present`;
  loaded libraries: `info loaded`.

---

*Next chapter: [Encoding and locale](060-kodierung-und-locale.md)*
