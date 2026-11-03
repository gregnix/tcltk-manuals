# Paths, environment, XDG

## Introduction

On Linux every process has a `HOME`, paths are separated by the slash,
and there is only one root directory. Where a program stores its
settings is governed by the [XDG Base Directory]{.index}
Specification: not as a dot file directly in `$HOME`, but in
`~/.config/<program>/`. This chapter shows the variables, the defaults
when they are missing, and the break in tilde handling between Tcl 8.6
and 9.

---

## HOME and the tilde

`$env(HOME)` is set on Linux, unlike often on Windows (`serie-linux`,
howtos 02 and 03). Paths are built with `file join`:

```tcl
set konfig [file join $env(HOME) .config meineapp]
```

With the tilde, 8.6 and 9 part ways. Tcl 8.6 replaces a leading `~` in
every path with `HOME`. Tcl 9 no longer does that (TIP 602): `~` is an
ordinary file name there. In return there are two new commands.
Container check, working directory `/tmp`, `HOME=/root`:

| Expression | Tcl 8.6.14 | Tcl 9.0.4 and 9.1.0 |
|----------|------------|---------------------|
| `file normalize ~` (started in `/tmp`) | `/root` | `/tmp/~` |
| `file exists ~` | 1 | 0 |
| `file home` | error, unknown | `/root` |
| `file tildeexpand ~/x` | error, unknown | `/root/x` |

On lxpro with the Debian packages, started in the home directory, the
same picture: `tclsh` 8.6.18 returns the home directory for
`file normalize ~` and 1 for `file exists ~`, `tclsh9.0` 9.0.4 and
`tclsh9.1` 9.1.0 return `<home directory>/~` and 0.

So `file normalize ~` only works as a way to the home directory under
8.6. Under Tcl 9 the same expression returns a path in the current
directory. `serie-linux` shows both versions in howto 02; the demo
`02-pfade.tcl` checks "Tilde = HOME" under 8.6 and `file home` and
`file tildeexpand` under 9.

Code for both versions uses `$env(HOME)` and no tilde:

```tcl
proc heim {} {
    if {[info exists ::env(HOME)] && $::env(HOME) ne ""} {
        return $::env(HOME)
    }
    return [file home]          ;# Tcl 9 only
}
```

A tilde that comes from outside, for example from a configuration file,
is only resolved under Tcl 9 by `file tildeexpand`. Under 8.6 every
file command does that by itself.

---

## Environment variables

`serie-linux` (howto 03) reads the usual variables:

```tcl
$env(HOME) $env(USER) $env(SHELL) $env(PATH)
$env(LANG) $env(DISPLAY)
```

Which of them are set depends on the session. In a graphical session,
`DISPLAY`, `XDG_CURRENT_DESKTOP`, `XDG_SESSION_TYPE` and
`XDG_RUNTIME_DIR` are available. In a cron run, under `sudo` or with
`env -i` they are missing. `HOSTNAME` and `TMPDIR` are often missing
in the session too. For the host name there is `info hostname`. The
temporary directory is then `/tmp`.

Access with a default is robust:

```tcl
proc envOder {name vorgabe} {
    if {[info exists ::env($name)] && $::env($name) ne ""} {
        return $::env($name)
    }
    return $vorgabe
}
set tmp [envOder TMPDIR /tmp]
```

Tcl 9 also has `file tempdir` for this. It creates a new, empty
directory and returns its path, in the container `/tmp/tcl_KZSgAw`. The
program removes the directory again itself.

---

## XDG Base Directory

The specification defines four locations for user data. Each variable
may be missing; then the default applies. `serie-linux` (howto 04):

| Variable | Default | Content |
|----------|---------|--------|
| `XDG_CONFIG_HOME` | `~/.config` | Settings |
| `XDG_DATA_HOME` | `~/.local/share` | Data that should persist |
| `XDG_CACHE_HOME` | `~/.cache` | Disposable data |
| `XDG_STATE_HOME` | `~/.local/state` | History, last window size |
| `XDG_RUNTIME_DIR` | none | Sockets, lock files; `/run/user/UID` |

On the author's workstation `XDG_DATA_HOME` is often not set,
`XDG_RUNTIME_DIR` is `/run/user/UID`. In the container with `env -i`
none of these variables is set. `XDG_STATE_HOME` is not checked by the
series; the default comes from the specification.

A program puts its files into its own subdirectory:

```tcl
proc xdgOrdner {var vorgabe app} {
    set basis ""
    if {[info exists ::env($var)]} { set basis $::env($var) }
    if {$basis eq "" || [file pathtype $basis] ne "absolute"} {
        set basis [file join [heim] {*}$vorgabe]
    }
    return [file join $basis $app]
}
set konfig [xdgOrdner XDG_CONFIG_HOME .config meineapp]
file mkdir $konfig
```

According to the specification, a relative value is invalid and is
ignored. `beispiele/xdg-ordner.tcl` contains the four variants and ran
in the container under 8.6.14 and 9.0.4 with the same result, also
with `XDG_CONFIG_HOME=relativ`: `/root/.config/meineapp`.

The Windows equivalent is `APPDATA`, the macOS equivalent
`~/Library/Application Support`. A program for all three first asks
`tcl_platform(os)` and then the respective source.

---

## User directories: Documents and Desktop

The names of the visible folders in the home directory are
**localized**. On a German desktop the folder is called `Dokumente`,
not `Documents`, and the desktop `Schreibtisch`. The mapping is in
[`~/.config/user-dirs.dirs`]{.index}; the tool `xdg-user-dir` reads it
(`serie-linux`, howto 05):

```tcl
exec {*}[auto_execok xdg-user-dir] DOCUMENTS
exec {*}[auto_execok xdg-user-dir] DESKTOP
exec {*}[auto_execok xdg-user-dir] DOWNLOAD
```

`xdg-user-dir` belongs to the Debian package `xdg-user-dirs`. It is
missing in the container; howto 05 fails there.
`beispiele/xdg-ordner.tcl` falls back to `HOME` in this case.
Hard-coding a folder like `~/Documents` is the most common mistake of
this section.

---

## File system

Unix attributes, no drive letters (`serie-linux`, howto 09):

```tcl
file volumes                          ;# /
file attributes $f                    ;# -group -owner -permissions
file attributes $f -permissions 00644
```

Under Tcl 9, `file volumes` additionally returns `//zipfs:/`
(container check: `//zipfs:/ /`). Code that takes
`[lindex [file volumes] 0]` for the root gets zipfs under 9. `/tmp`
has the sticky bit, permissions `1777`. The format of the permission
value differs between 8.6 and 9, see [Which Tcl?](030-welches-tcl.md).

`file nativename` returns the same path on Linux. Case matters:
`Daten.txt` and `daten.txt` are two files. This sets Linux apart from
macOS (APFS in the default setting) and from Windows.

---

## Summary

- `HOME` is set. Paths with `file join`.
- Tilde: resolved everywhere under 8.6, no longer under 9.
  `file normalize ~` returns a path in the current directory under 9.
  For both versions, `$env(HOME)`.
- XDG: variable or default, own subdirectory, ignore relative values.
- User directories are localized, via `xdg-user-dir`.
- `file volumes` also contains `//zipfs:/` under 9.

---

*Next chapter: [Search paths](050-suchpfade.md)*
