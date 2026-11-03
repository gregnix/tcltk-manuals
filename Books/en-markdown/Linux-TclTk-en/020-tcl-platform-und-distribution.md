# tcl_platform and the distribution

## Introduction

[`tcl_platform`]{.index} tells which operating system Tcl sees. On
Linux and on macOS, `platform` is the same: `unix`. The distinction is
made by `os`. Which distribution is running, `tcl_platform` does not
tell. For that there is [`/etc/os-release`]{.index}.

---

## The keys

```tcl
set ::tcl_platform(platform)   ;# unix
set ::tcl_platform(os)         ;# Linux
set ::tcl_platform(osVersion)  ;# kernel, not distribution
set ::tcl_platform(machine)    ;# x86_64
set ::tcl_platform(user)       ;# user of the process
```

Values from `serie-linux` (Debian forky, Tcl 8.6.18, howto 10) and from
the container check (– = not collected there):

| Key | Debian forky, 8.6.18 | Container, 8.6.14 | Container, 9.0.4 |
|-----------|----------------------|-------------------|------------------|
| `platform` | unix | unix | unix |
| `os` | Linux | Linux | Linux |
| `osVersion` | `7.2.14+deb14-amd64` | `6.18.44-fc-v139` | `6.18.44-fc-v139` |
| `machine` | x86_64 | x86_64 | x86_64 |
| `wordSize` | 8 | 8 | 8 |
| `pointerSize` | – | 8 | 8 |
| `byteOrder` | – | littleEndian | littleEndian |
| `threaded` | 1 (8.6) | 1 | key missing |

Linux code therefore checks:

```tcl
if {$::tcl_platform(os) eq "Linux"} { ... }
```

`platform eq "unix"` also matches macOS (`os` is `Darwin` there) and
the BSDs. For "X11 or not", `tcl_platform` is the wrong witness anyway;
that is told by `tk windowingsystem`, see
[X11, window managers and Wayland](080-x11-fenstermanager-wayland.md).

### threaded under Tcl 9

Tcl 9 is always built with threads. The key [`threaded`]{.index} is
therefore missing. Code that reads it needs `info exists`:

```tcl
set threads [expr {![info exists ::tcl_platform(threaded)]
                   || $::tcl_platform(threaded)}]
```

`serie-tcltk-bauen` (howto 05) confirms this for 9.0.4 on Debian:
`TCL_THREADS=1` in the `tclConfig.sh` of 8.6, no key under 9.0, and
`--enable-threads` is an unknown switch there.

### osVersion is the kernel

`osVersion` is the output of `uname -r` and changes with every kernel
update. On the Debian workstation it was `7.2.14+deb14-amd64` at the
last check (`serie-linux`, howto 10, still lists
`7.1.9+deb14-amd64`), in the container `6.18.44-fc-v139`. The second
value is the kernel of the host, not that of Ubuntu: a container does
not bring its own kernel. A version check for "Debian 13" or
"Ubuntu 24.04" via `osVersion` therefore always goes wrong.

### user is not USER

`tcl_platform(user)` is the name for the effective user ID of the
process. `$env(USER)` is inherited and can be missing or say something
else, for example after `sudo` or in a sandbox. In the container,
started with `env -i`: `tcl_platform(user)` is `root`, `env(USER)` does
not exist. `serie-linux` (howto 03) therefore fails in the container
with "env USER gesetzt", but not on the workstation.

```tcl
set wer $::tcl_platform(user)             ;# always there
set wer2 [expr {[info exists ::env(USER)] ? $::env(USER) : $wer}]
```

---

## Distribution: /etc/os-release

The distribution is in `/etc/os-release`. The file consists of lines
`KEY=value`, values often in quotation marks. It is shell syntax, but
for the usual keys a simple reader is enough:

```tcl
proc osRelease {} {
    set d [dict create]
    foreach datei {/etc/os-release /usr/lib/os-release} {
        if {![file readable $datei]} continue
        set ch [open $datei]
        fconfigure $ch -encoding utf-8
        foreach zeile [split [read $ch] \n] {
            if {[regexp {^([A-Z_]+)=(.*)$} $zeile -> k v]} {
                dict set d $k [string trim $v {"'}]
            }
        }
        close $ch
        break
    }
    return $d
}
set r [osRelease]
puts "[dict get $r ID] [dict getdef $r VERSION_CODENAME -]"
```

`dict getdef` exists from Tcl 8.7 on; under 8.6 check `dict exists`
first. Result (– = not collected):

| Key | Debian workstation | Container |
|-----------|---------------------|-----------|
| `ID` | debian | ubuntu |
| `ID_LIKE` | – | debian |
| `VERSION_ID` | missing | 24.04 |
| `VERSION_CODENAME` | forky | noble |
| `PRETTY_NAME` | Debian GNU/Linux forky/sid | Ubuntu 24.04.5 LTS |

The Debian column comes from `serie-linux` (howto 06: `ID=debian`,
`VERSION_CODENAME=forky`). Ubuntu carries `ID_LIKE=debian`, as the
Debian book writes in the chapter *Debian erkennen*. Debian Testing
does not set `VERSION_ID` (workstation, forky/sid). Code therefore does
not rely on it and takes `VERSION_CODENAME`. To check for "Debian or
derived", read `ID` **and** `ID_LIKE`.

```tcl
set familie [concat [dict getdef $r ID ""] [dict getdef $r ID_LIKE ""]]
if {"debian" in $familie} { ... }
```

Incidentally, in the container `/etc/debian_version` returns
`trixie/sid`, although the system is Ubuntu. Ubuntu takes the file over
from Debian. It is no use for telling Debian from Ubuntu.

---

## The running process: /proc/self

What Windows reads from the registry and macOS from `sysctl` lies in
the [`/proc`]{.index} file system on Linux. `serie-linux` (howto 06):

```tcl
file readlink /proc/self/exe      ;# e.g. /usr/bin/tclsh8.6
set ch [open /proc/self/comm]
set name [string trim [read $ch]]
close $ch
```

`/proc/self/exe` is the resolved path of the interpreter, even if it
was started via a symlink. `info nameofexecutable`, on the other hand,
returns the path under which the interpreter was called. The question
"which Tcl is running here" is the subject of the next chapter.

---

## Summary

- `platform` is `unix` on Linux and macOS. `os` distinguishes: `Linux`.
- `osVersion` is the kernel, in the container that of the host.
- `threaded` is missing under Tcl 9. Use `info exists` before reading.
- `tcl_platform(user)` is reliable, `$env(USER)` is not.
- Distribution from `/etc/os-release`, family via `ID` and `ID_LIKE`.
  `/etc/debian_version` also exists on Ubuntu.

---

*Next chapter: [Which Tcl?](030-welches-tcl.md)*
