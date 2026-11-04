# Error messages

Messages that occurred during the checks for this book, with cause and
remedy. Unless stated otherwise, identical in the container under
8.6.14 and 9.0.4.

---

## no display name and no $DISPLAY environment variable

```text
application-specific initialization failed: no display name and no $DISPLAY environment variable
```

`DISPLAY` is missing. `wish` then runs the script without Tk and exits
with 0. Remedy: set a display or use `xvfb-run`. In the script, check
`package require Tk` with `catch`. See
[X11, window managers and Wayland](080-x11-fenstermanager-wayland.md).

## couldn't connect to display

```text
application-specific initialization failed: couldn't connect to display ":77"
```

`DISPLAY` is set, but no server answers. Typical after a terminated
Xvfb whose socket was left behind under `/tmp/.X11-unix/`, or with
`ssh` without `-X`.

## couldn't execute … no such file or directory

```text
couldn't execute "gibtsnicht": no such file or directory
```

`exec` does not find the program. `errorCode` is
`POSIX ENOENT {no such file or directory}`. Use `auto_execok` first.

## child process exited abnormally

The child exited with a value other than 0. `errorCode` is
`CHILDSTATUS <pid> <wert>`. Not an error in the program's sense if the
value is an answer (for example `grep` without a match: 1).

## child killed: software termination signal

The child was terminated with `SIGTERM`. `errorCode`:
`CHILDKILLED <pid> SIGTERM {software termination signal}`.

## (text on stderr)

`exec` reports as error text whatever the child wrote to stderr, even
with exit status 0. `errorCode` is `NONE`. Remedy: `-ignorestderr` or
`2>@1`. See [exec, xdg-open, processes](070-exec-und-prozesse.md).

## invalid or incomplete multibyte or wide character

```text
error reading "file5": invalid or incomplete multibyte or wide character
```

Tcl 9 only: a channel with `-encoding utf-8` has read bytes that are
not UTF-8. Tcl 8.6 silently interprets them as Latin-1. See
[Encoding and locale](060-kodierung-und-locale.md).

## unknown or ambiguous subcommand "home"

```text
unknown or ambiguous subcommand "home": must be atime, attributes, …
```

`file home`, `file tildeexpand` and `file tempdir` exist only from
Tcl 9 on. Under 8.6 use `$env(HOME)`.

## unknown or ambiguous subcommand "systray"

```text
unknown or ambiguous subcommand "systray": must be appname, busy, caret, fontchooser, inactive, scaling, useinputmethods, or windowingsystem
```

`tk systray`, `tk sysnotify` and `tk print` exist only from Tk 9 on.

## bad button number "8"

Tk 8.6 only knows buttons 1 to 5 in `bind`. Tk 9 also accepts 6 to 9.

## bad event type or keysym "Super"

There is no modifier `Super`. In `bind` the Super key is called
`Mod4`.

## CLIPBOARD selection doesn't exist or form "STRING" not defined

```text
CLIPBOARD selection doesn't exist or form "STRING" not defined
PRIMARY selection doesn't exist or form "STRING" not defined
```

Nobody owns the selection. For CLIPBOARD: nothing was copied, or the
program that copied has exited. For PRIMARY: nothing is selected.
Always wrap `selection get` and `clipboard get` in `catch`.

## Error: target STRING not available

Message from `xclip` when the owner of the selection is no longer
running. In the container after `wish` has exited.

## Unable to obtain the list of printers

```text
Unable to obtain the list of printers. Command "lpstat" not found. Please install the CUPS package for your system.
```

Tk 9, `::tk::print::cups getprinters` without CUPS. Install the package
`cups-client` or `cups`. Only 9.0.4.

## Failed to execute child process “dbus-launch”

```text
Failed to execute child process “dbus-launch” (No such file or directory)
```

`notify-send` without a session DBus. Exit status 1. In a desktop
session this does not happen; in cron, `ssh` or a container it does.
`tk sysnotify` reports nothing in the same situation.

## Verbindung ist gescheitert

`xfconf-query` without a session DBus (`serie-xfce`, reference; German
message on the author's workstation). Applies to every call.

## SKIP: serie-xfce braucht XFCE

```text
SKIP: serie-xfce braucht XFCE (XDG_CURRENT_DESKTOP=)
```

No Xfce session. The series then checks nothing.

## WARNING: unrecognized options

The Tcl 9 `configure` no longer knows the switch; threads are always on
(`serie-tcltk-bauen`, howto 05). Omit the switch.

## file format not recognized

The linker hits an empty `.o` from an aborted `make`
(`serie-tcltk-bauen`, howto 11). `find . -name '*.o' -size 0 -delete`,
then run `make` again.

## XInput2.h missing

Missing header `X11/extensions/XInput2.h` in the Tk source build,
reported in *Tcl/Tk 9.0 bauen* on Ubuntu 24.04. Package `libxi-dev`.
The building book does not give the exact wording of the message; it
has not been verified here.

## this extension is compiled for Tcl 8.6

```text
% package require sqlite3
this extension is compiled for Tcl 8.6
    while executing
"load /usr/lib/tcltk/sqlite3/libsqlite3.53.4.so"
```

Under Debian's `tclsh9.0` and `tclsh9.1` with `libsqlite3-tcl` up to
3.53.4-2; these versions are built for Tcl 8.6 only. Since 3.54.1-1
the package ships a library for Tcl 9, and the message no longer
appears. Background and a way for older versions in
[Search paths](050-suchpfade.md), section *sqlite3 under Debian's Tcl 9*.

## Keine Berechtigung (permission denied) when installing to /usr/bin

```text
/bin/bash ../tclconfig/install-sh -c  -m 755 ../compat/sqlite3/spaceanal.tcl "/usr/bin/sqlite3_analyzer"
cp: reguläre Datei '/usr/bin/_inst.669779_' kann nicht angelegt werden: Keine Berechtigung
```

A TEA package built against Debian's `tclConfig.sh` adopts the prefix
`/usr`. `make install-binaries` then wants to put programs into
`/usr/bin`. Library and index are already installed at this point.
Remedy: `make install-lib-binaries`.

---

*Next chapter: [Sources](850-anhang-quellen.md)*
