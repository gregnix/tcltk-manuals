# exec, xdg-open, processes

## Introduction

On Linux, `exec` is the tool for everything Tcl cannot do itself:
open files with the matching program, start the browser,
query system values. There is no shell in between. Tcl starts the
program directly, with the arguments as a list. That makes `exec` safe
against spaces and special characters, but shell syntax like `*`, `~`
or `$VAR` has no effect.

---

## Finding a program: auto_execok

[`auto_execok`]{.index} searches for a program in `PATH` and returns the
full path as a list, or an empty string:

```tcl
set p [auto_execok xdg-open]
if {$p eq ""} {
    error "xdg-open fehlt"
}
exec {*}$p $datei &
```

In the container: `auto_execok sh` returns `/usr/bin/sh`, `auto_execok
xdg-open` returns `/usr/bin/xdg-open`, `auto_execok lpstat` an
empty string (no CUPS). The result is a list, hence the `{*}`.
On Windows it can have several elements, on Linux it is one
path.

`auto_execok` remembers every answer in the global array `auto_execs`,
including the empty one. If you install a tool after the program has started,
delete the entry, otherwise the old answer remains:

```tcl
unset -nocomplain ::auto_execs(xdg-open)
```

`auto_reset` also empties the array, but at the same time removes all
commands loaded via `auto_index` (source `auto.tcl` in
Tcl 9.0.4). For this purpose it is too coarse.

---

## Telling exec errors apart

`exec` throws an error in three different cases. Which one
applies is in `errorCode`. Container check, 8.6.14 and 9.0.4
the same:

| Case | Message | `errorCode` |
|------|---------|-------------|
| Program missing | `couldn't execute "gibtsnicht": no such file or directory` | `POSIX ENOENT {no such file or directory}` |
| Exit status not 0 (`false`) | `child process exited abnormally` | `CHILDSTATUS <pid> 1` |
| Output on stderr | the stderr text, here `meldung` | `NONE` |
| Child terminated by signal | `child killed: software termination signal` | `CHILDKILLED <pid> SIGTERM {software termination signal}` |

The third case is the well-known pitfall: a program that runs
successfully but writes a warning to stderr counts as an
error for `exec`. Remedy:

```tcl
exec -ignorestderr programm arg      ;# stderr goes to Tcl's stderr
exec programm arg 2>@1               ;# stderr into the result
exec programm arg 2>/dev/null        ;# discard stderr
```

A pattern for all cases:

```tcl
try {
    set aus [exec -ignorestderr {*}$befehl]
} trap {CHILDSTATUS} {msg opts} {
    set rc [lindex [dict get $opts -errorcode] 2]
    puts "Rückgabewert $rc"
} trap {POSIX ENOENT} {} {
    puts "Programm fehlt"
}
```

---

## In the background and via channels

An `&` at the end starts the program in the background. `exec` does not wait
and returns the process IDs:

```tcl
set pids [exec xdg-open $datei &]
```

For long-running programs whose output you want to read without halting the
user interface, a channel is the right tool:

```tcl
set ch [open |[list ping -c 3 localhost] r]
fconfigure $ch -blocking 0 -encoding utf-8
fileevent $ch readable [list lesen $ch]
proc lesen {ch} {
    if {[gets $ch zeile] >= 0} { .t insert end $zeile\n }
    if {[eof $ch]} {
        fconfigure $ch -blocking 1
        catch {close $ch} fehler
    }
}
```

The `fconfigure -blocking 1` before the `close` makes sure that `close`
reports the child's exit status. Otherwise the channel's encoding follows
`encoding system`, see [Encoding and locale](060-kodierung-und-locale.md).

### The pitfall with your own selection

A blocking `exec` halts the event loop. Usually that is
merely unpleasant. It becomes a deadlock when the child waits for your own
program. Container check: a `wish` selects text in an
entry and then calls `exec xclip -o -selection primary`. `xclip` asks
the owner of the selection, that is, this `wish`. It is stuck in
`exec` and does not answer. Both wait until `timeout` ends the run after
20 seconds. With a channel and `fileevent` as above, the
same call goes through (`beispiele/auswahl-probe.tcl`). More on the
selection in [Mouse, keyboard, clipboard](100-maus-tastatur-zwischenablage.md).

---

## xdg-open: opening a file or address

[`xdg-open`]{.index} is the Linux counterpart to `start` on Windows
and `open` on macOS. It opens a file with the configured
program or an address in the browser (`serie-linux`, howto 07):

```tcl
proc oeffnen {ziel} {
    set p [auto_execok xdg-open]
    if {$p eq ""} { error "xdg-open fehlt (Paket xdg-utils)" }
    exec {*}$p $ziel &
}
oeffnen https://www.tcl-lang.org
oeffnen [file join $env(HOME) bericht.pdf]
```

`xdg-open` belongs to the package `xdg-utils`. It asks the desktop environment
which program is responsible. Under Xfce it passes on to `exo-open`
(see [Xfce from Tcl](120-xfce.md)). The association for a
file type is shown by `xdg-mime query default <MIME-Typ>`.

The `&` is important. Whether `xdg-open` returns immediately or waits until
the opened program ends depends on the desktop environment and on the
program; without `&` the user interface can freeze. Checked with
Tcl 8.6:

| Call | Workstation, Xfce | Container without desktop |
|---|---|---|
| `exec xdg-open /etc/hostname &` | process ID immediately, Mousepad opens | calls LibreOffice and waits |
| `exec xdg-open https://example.org &` | process ID immediately, browser opens | no browser, exit 3 |
| `exec xdg-open /gibtsnicht` | `CHILDSTATUS … 4` | `CHILDSTATUS … 2` |

The exit codes are listed in `xdg-open(1)`: 2 file missing, 3 no program,
4 action failed. Under Xfce, `xdg-open` does not check the file
itself, but passes it on to `exo-open`; its error becomes 4.
Without a desktop session (`xdg-utils` 1.1.3, container) it checks itself
and reports 2. Code should therefore only check for "not 0", not for a specific number. The windows
do not appear in the order of the calls: on the workstation
the browser came before Mousepad, although `/etc/hostname` was opened
first. If you expect a window afterwards, do not wait for a particular order.
The series do not start `xdg-open` under `SERIES_AUTO`.

---

## Process ID and signals

```tcl
pid                       ;# own process ID
pid $ch                   ;# process IDs behind a channel
```

Tcl does not send a signal itself. `exec kill -TERM $p` does. A
Tcl program that is to react to `SIGTERM` needs an extension
(such as `TclX` with `signal`); without one it ends immediately. This has not been
checked.

On Linux every program has `/proc/<pid>/` with `cmdline`, `environ`
and `status`. Whether a process is still alive:

```tcl
file isdirectory /proc/$p
```

---

## Summary

- `auto_execok` before every `exec` of an external program, insert the result with
  `{*}`.
- `errorCode` distinguishes: `POSIX ENOENT`, `CHILDSTATUS`, `NONE` (stderr),
  `CHILDKILLED`.
- `-ignorestderr` for programs that chatter on stderr.
- Long runs via `open |…` with `fileevent`. Never call a program
  blocking that asks your own program.
- `xdg-open` with `&`, package `xdg-utils`.

---

*Next chapter: [X11, window managers and Wayland](080-x11-fenstermanager-wayland.md)*
