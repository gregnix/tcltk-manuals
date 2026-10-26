# tusettings

## Purpose

[tusettings]{.index} **0.1** stores settings per app as INI in the
platform config directory, plus directories for cache/data/temp and
a recent list. Pure Tcl, no Tk. New in 0.64.0, in the
umbrella since then. The INI is written by `tuini`; it can be read and
changed by hand. The module writes and reads files as UTF-8.

```tcl
package require tclutils::tusettings
set s [::tclutils::tusettings::load meineapp -defaults {
    window {width 800 height 600}
}]
dict set s window width 1024
::tclutils::tusettings::save meineapp $s     ;# -> Pfad der settings.ini
::tclutils::tusettings::recentAdd meineapp /pfad/zur/datei
::tclutils::tusettings::value $s window width ;# -> 1024
```

`save` returns the path, under Linux `$HOME/.config/meineapp/settings.ini`.

The commands live in the namespace `::tclutils::tusettings`. Tcl resolves the short form
`tusettings::load` only inside `namespace eval ::tclutils`;
at global level it aborts with `invalid command name`.

---

## API (short)

| Command | Role |
|---|---|
| `dir kind app ?-create bool?` | config / cache / data / temp |
| `file app ?name?` | `<config>/<name>.ini`, default name `settings` |
| `load app ?-defaults d? ?-name n?` | INI to dict, laid over the defaults |
| `save app settings ?-name n?` | dict to INI (temp file, then rename); returns the path |
| `value settings section key ?default?` | read section/key |
| `recentAdd app path ?-list l? ?-max n?` | path to the top; returns the new list |
| `recentList app ?-list l? ?-existing bool?` | list, newest first |
| `recentRemove app path ?-list l?` / `recentClear app ?-list l?` | delete an entry or the list |

`load` lays the file over `-defaults`; new keys of a later
app version thus get their default. If the file is missing, `load` returns
the defaults. `dir` creates something only with `-create 1`; `save` and
`recentAdd` create the config directory themselves. `-list` (default
`recent`) selects the recent file.

---

## Directories per platform

| kind | Linux / BSD | Windows | macOS |
|---|---|---|---|
| config | `$XDG_CONFIG_HOME` or `~/.config` | `%APPDATA%` | `~/Library/Application Support` |
| cache | `$XDG_CACHE_HOME` or `~/.cache` | `%LOCALAPPDATA%` | `~/Library/Caches` |
| data | `$XDG_DATA_HOME` or `~/.local/share` | `%APPDATA%` | `~/Library/Application Support` |
| temp | `$TMPDIR` or `/tmp` | `%TEMP%` or `%TMP%` | `$TMPDIR` or `/tmp` |

The app name is appended to each directory. Under Windows, without
the environment variables, `<home>/AppData/Roaming` or
`<home>/AppData/Local` (temp: `…/Local/Temp`) apply. macOS is recognized by
`tcl_platform(os)` = `Darwin`.

Without `XDG_*` and `TMPDIR`, under Linux these are `~/.config/meineapp`,
`~/.cache/meineapp`, `~/.local/share/meineapp` and `/tmp/meineapp`.
The columns for Windows and macOS are as written in the code.

---

## Recent list

One text file per list (`<config>/<list>.txt`, one path per line,
UTF-8). `recentAdd` normalizes the path, moves it to the top, removes
an older entry for the same file (under Windows ignoring
case) and keeps `-max` entries (default 10).
`recentList -existing 1` omits files that have disappeared.

---

## Limits and errors

INI cannot hold everything. `save` rejects: values with a line break or
leading/trailing spaces; empty keys, keys with `=`, a line break,
leading/trailing spaces, or starting with `;`, `#`, `[`; section names with
`]` or a line break. The check runs before writing, so the file stays
unchanged. Comments in the file do not survive `save`.

```tcl
try {
    ::tclutils::tusettings::save meineapp {window {title " x"}}
} trap {TCLUTILS TUSETTINGS VALUE} msg {
    puts "abgelehnt: $msg"
}
```

The message reads
`value of window.title: no line breaks or outer blanks in INI`.

| Code | Case |
|---|---|
| `{TCLUTILS TUSETTINGS APP}` | app name empty or with path characters |
| `{TCLUTILS TUSETTINGS KIND}` | `dir` with an unknown kind |
| `{TCLUTILS TUSETTINGS SYNTAX}` | INI file cannot be parsed |
| `{TCLUTILS TUSETTINGS VALUE}` | value, key or section not INI-compatible; `-max` not a positive integer; path with a line break |

Unknown options: `{TCLUTILS COMMON OPTION <opt>}`. On `SYNTAX`
the caller decides whether to fall back to the defaults; the
message names the file and the faulty line, for example
`…/settings.ini: line without '=' : garbage line`.

`tkutils::tkugeometry` stores window geometry through it; details in the
book *tkutils*.

---

## Summary

- INI settings + recent list, platform-typical paths.
- Full namespace `::tclutils::tusettings::…`.
- GUI geometry: book *tkutils*.

---

*Next chapter: [Tasks with tutask](085-tutask.md)*
