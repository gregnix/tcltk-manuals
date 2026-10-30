# Building Blocks for Applications

Seventeen small modules that an application needs around its actual task:
log and events, checking and calculating, environment and deployment,
output in the terminal and on the page. All are pure Tcl without Tk and
are part of the umbrella `tclutils`. Platform-dependent are
`tuappinfo`, `tusysinfo`, `tudeploy`, `tuexe`, `tuopen` and `tuterm`; `tuzipfs`
needs Tcl 9 for most commands.

| Group | Modules |
|---|---|
| Log and events | `tulog`, `tuevent`, `turegistry` |
| Checking and calculating | `tuvalidate`, `tulist`, `tumath`, `tunumany` |
| Environment and deployment | `tuappinfo`, `tusysinfo`, `tuedid`, `tudeploy`, `tuexe`, `tuopen`, `tuzipfs` |
| Output | `tuterm`, `tupagespec`, `tulayout` |

The modules report unknown options and options without a value in
different ways: through `::tclutils::common::parseOptions` with
`{TCLUTILS COMMON OPTION <opt>}` or with a code of their own. Each
section names the code.

---

## tulog

[tulog]{.index} is a log with four levels. A logger is a command; the
levels `info` and `error` are subcommands and therefore do not hide any
Tcl commands.

```tcl
::tclutils::tulog::new ?option wert ...?        ;# -> Logger-Befehl
$log debug|info|warn|error nachricht
$log log stufe nachricht
$log setLevel stufe
$log level
$log destroy
::tclutils::tulog::assert ausdruck ?nachricht?
```

| Option | Default | Effect |
|---|---|---|
| `-channel` | `stderr` | channel for the output |
| `-level` | `info` | lowest level that is written |
| `-name` | `""` | name after the level |
| `-timestamp` | `1` | timestamp `%Y-%m-%dT%H:%M:%S`, local time |

The levels rise in the order `debug`, `info`, `warn`, `error`. A
message appears if its level is at least that of the logger. Each line
has the form `ZEIT [STUFE] name: nachricht`; without a timestamp,
`ZEIT ` is dropped, without a name the line reads `[STUFE]: nachricht`.
The channel is flushed after each line.

`new` returns the command name `::tclutils::tulog::logger<n>`. The
subcommands for writing, `setLevel` and `destroy` return `""`, `level`
returns the current level. After `destroy` the command no longer
exists.

```tcl
package require tclutils::tulog
set log [::tclutils::tulog::new -name app -channel stdout \
    -timestamp 0]
$log info "Start"
$log debug "unterdrückt"
$log warn "Platte fast voll"
$log setLevel debug
$log level                                   ;# -> debug
$log destroy
```

Output on `stdout`:

```text
[INFO] app: Start
[WARN] app: Platte fast voll
```

`assert` evaluates the expression with `expr` in the caller's context.
If it is false, it fails with `{TCLUTILS TULOG ASSERT}`; the message is
the given message or `assertion failed: <ausdruck>`.

```tcl
set n 3
::tclutils::tulog::assert {$n > 2}           ;# -> (leer)
catch {::tclutils::tulog::assert {$n > 5}} m
set m                          ;# -> assertion failed: $n > 5
```

| Case | Code |
|---|---|
| unknown level for `-level`, `log`, `setLevel` | `{TCLUTILS TULOG LEVEL}` |
| `-timestamp` not boolean | `{TCLUTILS COMMON BOOLEAN -timestamp}` |
| unknown option for `new` | `{TCLUTILS COMMON OPTION <opt>}` |
| unknown subcommand, wrong number of arguments | without `-errorcode` |
| assertion false | `{TCLUTILS TULOG ASSERT}` |

`new` checks all options before it creates the logger; after an error
no logger is left behind. `new` does not check `-channel`. A channel that does not exist only shows up
at the first output: `can not find channel named "…"` with
`{TCL LOOKUP CHANNEL …}`.

---

## tuevent

[tuevent]{.index} is an event bus following the publish/subscribe
pattern. Each bus is a token; subscribers are command prefixes.

| Command | Effect | Return value |
|---|---|---|
| `create` | new bus | token `tuevent<n>` |
| `subscribe bus ereignis handler` | register a handler; the same handler only once | `""` |
| `unsubscribe bus ereignis handler` | unregister a handler; if it is missing, nothing happens | `""` |
| `emit bus ereignis ?arg ...?` | call the handlers | number of handlers called |
| `handlers bus ereignis` | registered handlers | list in order of registration |
| `events bus` | events with handlers | sorted list |
| `clear bus ?ereignis?` | delete the handlers of one event or of all | `""` |
| `destroy bus` | delete the bus with all registrations | `""` |

`emit` calls each handler at global level, with the arguments appended,
in the order of registration. An error in a handler aborts `emit` and
goes to the caller; the remaining handlers then do not run. A token
that `create` did not return or that `destroy` has deleted gives
`{TCLUTILS TUEVENT BUS}` with
`unknown event bus: "<token>"`.

```tcl
package require tclutils::tuevent
set bus [::tclutils::tuevent::create]
set log {}
proc merke {id} { lappend ::log $id }
::tclutils::tuevent::subscribe $bus saved merke
::tclutils::tuevent::subscribe $bus saved merke
::tclutils::tuevent::emit $bus saved 42      ;# -> 1
set log                                      ;# -> 42
::tclutils::tuevent::emit $bus closed        ;# -> 0
::tclutils::tuevent::events $bus             ;# -> saved
::tclutils::tuevent::destroy $bus
```

---

## turegistry

[turegistry]{.index} stores values under keys, for example database
connections or services that several parts of an application need. Each
registry is a token.

| Command | Effect | Return value |
|---|---|---|
| `create` | new registry | token `turegistry<n>` |
| `put reg schlüssel wert` | store a value, replace the old one | the value |
| `get reg schlüssel ?vorgabe?` | read a value | value or default |
| `has reg schlüssel` | key present? | `1` or `0` |
| `keys reg ?muster?` | keys, filtered with `string match` | sorted list |
| `remove reg schlüssel` | delete a key | `1` if it was present, otherwise `0` |
| `destroy reg` | delete the registry | `""` |

`get` without a default fails on a missing key with
`{TCLUTILS TUREGISTRY KEY}`, message
`registry key not set: "<schlüssel>"`. An empty default `{}` counts as
a default. An unknown token gives `{TCLUTILS TUREGISTRY REG}`.

```tcl
package require tclutils::turegistry
set reg [::tclutils::turegistry::create]
::tclutils::turegistry::put $reg db conn1    ;# -> conn1
::tclutils::turegistry::put $reg db.timeout 30
::tclutils::turegistry::get $reg db          ;# -> conn1
::tclutils::turegistry::get $reg cache leer  ;# -> leer
::tclutils::turegistry::keys $reg db.*       ;# -> db.timeout
::tclutils::turegistry::remove $reg db       ;# -> 1
::tclutils::turegistry::has $reg db          ;# -> 0
::tclutils::turegistry::destroy $reg
```

More than one default value for `get` is a call error without
`-errorcode`, but only if the key is missing. If it is set, `get`
returns the value and ignores the surplus arguments.

---

## tuvalidate

[tuvalidate]{.index} contains checks that return `1` or `0`. They do
not fail on the value being checked; errors occur only for wrong
arguments. The checks for e-mail and URL recognize the usual form; they
are not complete RFC checks.

| Command | 1 if |
|---|---|
| `email s` | `lokal@domain.tld`; local part from `A-Z a-z 0-9 . _ % + -`, domain from `A-Z a-z 0-9 . -`, ending at least two ASCII letters |
| `url s` | starts with `http://` or `https://`, no whitespace, the first character after it is not `/ $ . ? #` |
| `ipv4 s` | four groups of 1–3 digits, each at most 255, no leading zero |
| `port s` | decimal digits only, value 1 to 65535 |
| `alpha s` | only `A-Z a-z`, not empty |
| `alnum s` | only `A-Z a-z 0-9`, not empty |
| `numeric s` | `string is double -strict` |
| `integer s` | `string is integer -strict` |
| `length s min max` | `min <= [string length s] <= max` |
| `pattern s re` | `regexp re s` matches |
| `inList s liste` | `s` is an element of the list (exact comparison) |

```tcl
package require tclutils::tuvalidate
::tclutils::tuvalidate::email a@b.com             ;# -> 1
::tclutils::tuvalidate::email "jörg@b.de"    ;# -> 0
::tclutils::tuvalidate::url ftp://tcl.tk/         ;# -> 0
::tclutils::tuvalidate::ipv4 10.0.0.256           ;# -> 0
::tclutils::tuvalidate::ipv4 010.0.0.1            ;# -> 0
::tclutils::tuvalidate::ipv4 0.0.0.0              ;# -> 1
::tclutils::tuvalidate::port 0x50                 ;# -> 0
::tclutils::tuvalidate::port 080                  ;# -> 1
::tclutils::tuvalidate::numeric 1,5               ;# -> 0
::tclutils::tuvalidate::length abc 3 20           ;# -> 1
::tclutils::tuvalidate::pattern 2024-03-15 {^\d{4}-\d\d-\d\d$}
                                                  ;# -> 1
```

`alpha` and `alnum` know only ASCII; for Unicode letters use
`string is alpha`. `ipv4` checks strictly like `inet_pton`: a group
with a leading zero (`010`) gives 0, the group `0` alone is valid.
`port` accepts only the ASCII digits `0` to `9`, without sign, without
whitespace and without `0x`; `0x50` and `" 80"` give 0. Leading zeros
are allowed and count as decimal: `080` is port 80, the same under
Tcl 8.6 and 9.

| Case | Code |
|---|---|
| `length`: `min` or `max` not an integer | `{TCLUTILS TUVALIDATE ARG}` |
| `pattern`: invalid regular expression | `{TCLUTILS TUVALIDATE REGEX}` |

---

## tulist

[tulist]{.index} supplements the list commands of the core. `lreverse`,
`lsort -unique`, `lsearch` and `lmap` remain with the core. `map`,
`filter`, `reduce`, `all` and `any` take a command prefix, not a script
body; it runs at global level with the element appended. Local
variables of the caller are not visible in it; `apply` with parameters
solves this.

| Command | Effect |
|---|---|
| `unique liste` | remove duplicates, the order of first occurrence is kept |
| `flatten liste ?tiefe?` | resolve sublists, default for `tiefe` is 1; `tiefe <= 0` returns the list unchanged |
| `chunk liste größe` | pieces of at most `größe` elements |
| `zip liste ...` | tuples, ends with the shortest list; without a list `{}` |
| `sum liste` | sum, empty list `0` |
| `avg liste` | mean as a floating-point number |
| `min liste`, `max liste` | smallest, largest element by `<` and `>` |
| `reduce liste start cmd` | left fold: `acc = cmd acc element` |
| `map liste cmd` | results of `cmd element` |
| `filter liste cmd` | elements for which `cmd element` is true |
| `all liste cmd`, `any liste cmd` | `1`/`0`; empty list: `all` 1, `any` 0 |
| `take liste n`, `drop liste n` | first `n` elements or the rest; `n <= 0` gives `{}` or the whole list |

```tcl
package require tclutils::tulist
::tclutils::tulist::unique {a b a c b}            ;# -> a b c
::tclutils::tulist::flatten {{1 2} {3 {4 5}}}     ;# -> 1 2 3 {4 5}
::tclutils::tulist::flatten {{1 2} {3 {4 5}}} 2   ;# -> 1 2 3 4 5
::tclutils::tulist::chunk {1 2 3 4 5} 2           ;# -> {1 2} {3 4} 5
::tclutils::tulist::zip {a b c} {1 2}             ;# -> {a 1} {b 2}
::tclutils::tulist::avg {1 2 3 4}                 ;# -> 2.5
::tclutils::tulist::max {b a c}                   ;# -> c
::tclutils::tulist::reduce {1 2 3 4} 0 ::tcl::mathop::+
                                                  ;# -> 10
::tclutils::tulist::map {1 2 3} {apply {{x} {expr {$x*$x}}}}
                                                  ;# -> 1 4 9
::tclutils::tulist::filter {1 2 3 4} {apply {{x} {expr {$x%2==0}}}}
                                                  ;# -> 2 4
::tclutils::tulist::drop {a b c d} 2              ;# -> c d
```

`min` and `max` compare numbers numerically, otherwise as text. `sum`
and `avg` calculate with `expr`; a non-numeric element fails with
`{ARITH DOMAIN {non-numeric string}}`. So does a non-numeric `n` for
`take` and `drop`.

| Case | Code |
|---|---|
| `chunk`: size not a positive integer | `{TCLUTILS TULIST SIZE}` |
| `avg`, `min`, `max` of an empty list | `{TCLUTILS TULIST EMPTY}` |

---

## tumath

[tumath]{.index} supplements `expr` with calculations that are missing
there. `round`, `ceil`, `floor` and `abs` remain with `expr`.

| Command | Return value | Error |
|---|---|---|
| `clamp x lo hi` | `x`, limited to `lo` to `hi` | `lo > hi`: `ARG` |
| `inRange x lo hi` | `1` if `lo <= x <= hi` | – |
| `percent teil ganzes` | `teil / ganzes * 100` as a floating-point number | `ganzes == 0`: `DIVZERO` |
| `sign x` | `-1`, `0` or `1` | – |
| `gcd a b` | greatest common divisor, not negative; `gcd 0 0` is 0 | not integers: `ARG` |
| `lcm a b` | least common multiple; 0 if an argument is 0 | through `gcd` |
| `factorial n` | `n!`, with Tcl's big integers | `n` negative or not an integer: `ARG` |
| `roundTo x stellen` | `round(x * 10**stellen) / 10**stellen`, floating-point number | `stellen` negative or not an integer: `ARG` |

The codes are `{TCLUTILS TUMATH ARG}` and
`{TCLUTILS TUMATH DIVZERO}`.

```tcl
package require tclutils::tumath
::tclutils::tumath::clamp 12 0 10            ;# -> 10
::tclutils::tumath::percent 30 200           ;# -> 15.0
::tclutils::tumath::gcd -24 36               ;# -> 12
::tclutils::tumath::lcm 4 6                  ;# -> 12
::tclutils::tumath::factorial 25   ;# -> 15511210043330985984000000
::tclutils::tumath::roundTo 3.14159 2        ;# -> 3.14
::tclutils::tumath::roundTo 2.5 0            ;# -> 3.0
::tclutils::tumath::roundTo 1.005 2          ;# -> 1.0
```

`roundTo` calculates with floating-point numbers. `1.005 * 100` gives
`100.49999…`, hence `1.0` instead of `1.01`. For amounts with a fixed
number of decimal places, `tunum::format` rounds on the decimal digits,
see
[Characters, Numbers, Dates and Paths](045-zeichen-zahlen-datum.md).

---

## tunumany

[tunumany]{.index} is a single entry point for numbers in two
notations. Amounts with thousands separators and currency go to
`tunum::parse`, sizes with an SI or IEC unit (`1.5K`, `2Mi`) to
`tunumfmt::fromHuman`. The two parsers themselves stay separate;
`tunum` is described in the chapter
[Characters, Numbers, Dates and Paths](045-zeichen-zahlen-datum.md).

```tcl
::tclutils::tunumany::parse text ?-default wert? ?-prefer weg?
```

| Option | Default | Effect |
|---|---|---|
| `-default` | `""` | return value if nothing is readable |
| `-prefer` | `auto` | `auto`, `si` or `locale`: which parser is asked first |

With `auto`, `parse` chooses the SI path if the trimmed text is a
number with a point or comma as decimal separator, optional spaces and exactly
one of the letters `K M G T P E Z Y` (also lowercase) with an optional
`i`. Everything else goes to `tunum::parse` with locale `auto`. If the
chosen parser returns nothing, `parse` asks the other one. `parse`
loads both modules only when called; if one is missing, that path is
not available.

```tcl
package require tclutils::tunumany
::tclutils::tunumany::parse "1.234,56"       ;# -> 1234.56
::tclutils::tunumany::parse "1,234.56"       ;# -> 1234.56
::tclutils::tunumany::parse "12 €"      ;# -> 12.0
::tclutils::tunumany::parse 42               ;# -> 42.0
::tclutils::tunumany::parse 1.5K             ;# -> 1500
::tclutils::tunumany::parse 2Mi              ;# -> 2097152
::tclutils::tunumany::parse 2KiB             ;# -> 2048
::tclutils::tunumany::parse "3 G"            ;# -> 3000000000
::tclutils::tunumany::parse 1.5m             ;# -> 1500000
::tclutils::tunumany::parse 1,5K             ;# -> 1500
::tclutils::tunumany::parse 1,500K -default x ;# -> x
::tclutils::tunumany::parse x -default 0     ;# -> 0
```

Lowercase letters stand for the same units: `m` is mega, not milli. A
decimal comma before the unit counts: `1,5K` is 1500 (up to tclutils
0.68.0 the empty string). With exactly three digits after the comma
(`1,500K`) it could also group thousands; `parse` does not read that
form and returns the default. Because the default `""` also stands for
unreadable input, a `-default` that cannot be a number tells the two
cases apart.
Integers without a unit go through `tunum` and come back as
floating-point numbers. An `i` directly after the unit letter makes the
unit an IEC unit, also with a trailing `B`: `2KiB` gives 2048, `2KB`
gives 2000.

| Case | Code |
|---|---|
| unknown option, option without value (`parse 1.5 -default`) | `{TCLUTILS TUNUMANY OPTION}` |
| `-prefer` not `auto`, `si`, `locale` | `{TCLUTILS TUNUMANY PREFER}` |

---

## tuappinfo

[tuappinfo]{.index} collects information about Tcl, the program, the
platform, the environment, search paths and loaded packages in a text
report, for example for an info dialog or an error report to the
developer. The caller handles the display.

```tcl
::tclutils::tuappinfo::trackTm datei
::tclutils::tuappinfo::buildReport ?-title text? ?-anonymize 0|1?
::tclutils::tuappinfo::writeLog datei ?-title text? ?-anonymize 0|1?
```

| Option | Default | Effect |
|---|---|---|
| `-title` | `Application Information` | heading `==== <titel> ====` |
| `-anonymize` | `0` | hide user, host and path information |

`trackTm` records a module file for the last section and returns the
list of all recorded files. `buildReport` returns the report as one
string, `writeLog` writes it as UTF-8 through a temporary file
(`common::replaceFile`) and returns the file name; if writing fails, an
old log stays. Up to 0.2 it wrote in the system encoding.

The report has these sections in this order:

| Section | Content |
|---|---|
| Header | title, `Timestamp:`, `PID:` |
| `--- Tcl / Tk ---` | `info patchlevel`, `tk_patchLevel` (only with Tk; up to 0.2 `tk_version`), `info nameofexecutable`, operating system and version, machine, `Host:` |
| `--- Environment ---` | `USER`, `USERNAME`, `HOME`, `TEMP`, `TMP`, `PATH`, if set |
| `--- auto_path ---` | one entry per line |
| `--- Loaded Packages ---` | each package with its `package provide` version |
| `--- tm::path ---` | `tcl::tm::path list` |
| `--- Loaded TM Modules ---` | the files recorded with `trackTm`, otherwise `(none tracked)` |

Platform-dependent according to the code: `Host:` appears only if the
environment variable `COMPUTERNAME` is set; Windows sets it, under
Linux and macOS the line is usually missing. `USERNAME`, `TEMP` and
`TMP` are typical Windows variables, `USER` and `HOME` typical ones
under Linux and macOS.

`-anonymize 1` replaces:

| Item | Replacement |
|---|---|
| `USER`, `USERNAME` | `<user-xxxxxxxx>` |
| `Host` | `<host-xxxxxxxx>` |
| `HOME` | `<HOME>` |
| `TEMP`, `TMP` | `<TEMP>` |
| `PATH` | `<anonymized>` |
| paths below the home directory | `<HOME>/…` |
| all other paths | `<path>/<letzter Teil>` |
| recorded module files | `<tm-xxxxxxxx>.tm` |

`xxxxxxxx` is a stable, non-cryptographic hash of eight hex digits;
equal names give equal values. The path rule applies to `Executable`
and to each entry in `auto_path` and `tm::path`. The home directory is
`$HOME`, without `HOME` `$USERPROFILE`; a path counts as below it if it
is equal to it or starts with
`<heim>/`. `/usr/share/tcltk` becomes `<path>/tcltk`,
`$HOME/lib/tm` becomes `<HOME>/lib/tm`. Separators appear as `/`;
under Windows `tuappinfo` compares the home directory without regard
to case. `Platform`, `Machine`, the versions and the package list stay
unchanged.

```tcl
package require tclutils::tuappinfo
::tclutils::tuappinfo::trackTm /opt/app/lib/tm/foo-1.0.tm
set r [::tclutils::tuappinfo::buildReport -title "MeineApp 1.0"]
lindex [split $r \n] 0                ;# -> ==== MeineApp 1.0 ====
string match "*(none tracked)*" $r    ;# -> 0
```

The other lines depend on the computer: under Linux, for example,
`Tcl version: 9.0.4`, `Platform: Linux <kernel>`, `HOME: /home/<name>`.

| Case | Code |
|---|---|
| unknown option, option without value | `{TCLUTILS TUAPPINFO OPTION}` |
| `-anonymize` not boolean | `{TCLUTILS TUAPPINFO VALUE}` |

`writeLog` checks the options through `buildReport` before it creates
the file.

---

## tusysinfo

[tusysinfo]{.index} describes the computer: operating system, processor,
memory, model, disks and monitors, on Linux, macOS and Windows.
`tuappinfo` describes the Tcl runtime, `tusysinfo` the machine beneath
it.

```tcl
::tclutils::tusysinfo::collect ?option wert ...?        ;# -> Dict
::tclutils::tusysinfo::report  info ?-title text? ?-anonymize 0|1?
::tclutils::tusysinfo::toJson  info ?-indent n?
```

The module reads files and the registry first and calls a program only
where nothing else has the data. If a program is missing, its fields
stay empty; `collect` does not fail because of it.

| System | Sources |
|---|---|
| Linux | `/etc/os-release`, `/proc/cpuinfo`, `/proc/meminfo`, `/sys/class/dmi/id`, `/sys/block`, `/sys/class/drm/*/edid`; no program, no root |
| macOS | `sw_vers`, `uname`, `sysctl`, `system_profiler -json` (a few seconds) |
| Windows | registry (package `registry`) for system, CPU, model and the monitors' EDID; one PowerShell call (CIM) for memory, disks and the active monitors |

| Option | Default | Effect |
|---|---|---|
| `-sections` | all | any of `os cpu memory machine disks displays` |
| `-serials` | `0` | `1`: serial numbers of computer, disks, monitors |
| `-commands` | `1` | `0`: call no program |
| `-timeout` | `10000` | limit in ms per program call |
| `-platform` | this computer | `linux`, `macos`, `windows` |
| `-root` | empty | Linux: read `/etc`, `/proc`, `/sys` below this folder (tests) |

`collect` returns a dict with `platform`, `host` and per section a dict
(`os`, `cpu`, `memory`, `machine`) or a list of dicts (`disks`,
`displays`). Sizes are in bytes. A monitor carries the fields from its
EDID (section `tuedid`), the connector and `present` (1 connected, 0 not
connected). On Windows a monitor without a status counts as not
connected. If PowerShell gives no answer or one that cannot be read, the
dict has a list `warnings` and `report` shows a section "Warnings";
memory, disks and monitor state are then missing instead of empty.

```tcl
package require tclutils::tusysinfo
set i [::tclutils::tusysinfo::collect -sections {os memory}]
lsort [dict keys $i]                  ;# -> host memory os platform
dict get $i os id                     ;# -> debian (depends on the computer)
puts [::tclutils::tusysinfo::report $i -anonymize 1]
```

`report` shows disks in GB as on the label and memory in GiB, `toJson`
writes numbers as numbers. The command line `bin/tusysinfo.tcl` prints
the same, with `--json`, `--serials`, `--anonymize` and `--sections`.

Serial numbers, host names and MAC addresses identify a computer and,
at an office desk, its user. Serial numbers come only with
`-serials 1`, MAC addresses not at all; `report -anonymize 1` hides the
host name and serial numbers.

Further details:

- Linux: only root may read the computer's serial number
  (`product_serial`). Virtual machines often have no DMI data and no
  monitor.
- Windows: the registry keeps every monitor that was ever connected,
  often the same one under several entries (other port, other driver).
  `tusysinfo` lists each EDID once and sets `present` from
  `Get-PnpDevice -Class Monitor`: 1 for status OK, otherwise 0, empty
  without that list. In a remote desktop session the physical monitors
  count as not connected; `report` then writes "(not connected)".
  `WmiMonitorID` reports "not supported" on some computers and is
  therefore not used. Windows 11
  still reports "Windows 10 …" as `ProductName`; from build 22000 on it
  shows Windows 11. SSD or HDD comes from `Get-PhysicalDisk`; an NVMe
  disk counts as SSD.
- Firmware placeholders such as "Default string" or "To be filled by
  O.E.M." are left empty.
- macOS: `system_profiler` takes a few seconds; `-sections {os cpu
  memory}` leaves it out. For a monitor it gives maker, model, product
  code, week and year, but no size; `widthCm`, `heightCm` and
  `diagonal` stay 0. There is one entry per APFS container (`disk3`),
  its volumes in `volumes`; the size is that of the container, a little
  below the drive's.
- Linux: `disks` shows the devices, not loop devices, RAM disks and
  device mapper volumes (LVM, LUKS); RAID (`md*`) stays. Debian
  testing/sid has no `VERSION_ID`; `version` then comes from
  `/etc/debian_version`, e.g. `forky/sid`.
- Checked on a Linux PC with two monitors (Debian sid), a Windows 11
  PC and a Mac mini (Apple Silicon, macOS 27). The tests replay
  recorded output of these computers.

| Case | Code |
|---|---|
| unknown option, option without a value | `{TCLUTILS TUSYSINFO OPTION}` |
| unknown section | `{TCLUTILS TUSYSINFO SECTION}` |
| unknown platform | `{TCLUTILS TUSYSINFO PLATFORM}` |

---

## tuedid

[tuedid]{.index} reads a monitor's EDID block. In it the monitor
describes itself in 128 bytes: manufacturer, product code, serial
number, week and year of manufacture, size in centimetres and the
preferred resolution; text fields carry the model name and a serial
number as text.

```tcl
::tclutils::tuedid::parse    bytes       ;# -> Dict
::tclutils::tuedid::parseHex text        ;# hex digits; spaces and ":" ignored
::tclutils::tuedid::vendor   kürzel      ;# DEL -> Dell
```

On Linux the bytes are in `/sys/class/drm/card*-*/edid`, on Windows in
the registry (`Enum\DISPLAY\…\Device Parameters`, value `EDID`);
`xrandr --verbose` and `ioreg` on macOS print them as hex. `tusysinfo`
reads them itself.

```tcl
package require tclutils::tuedid
set fh [open /sys/class/drm/card0-DP-1/edid rb]
set d [::tclutils::tuedid::parse [read $fh]]
close $fh
dict get $d vendor                    ;# -> Dell
dict get $d diagonal                  ;# -> 27.2 (inches)
dict get $d preferred                 ;# -> width 1920 height 1080 refresh 60.0
```

| Key | Content |
|---|---|
| `valid` | 1 for a correct checksum; a block with a wrong sum is still read |
| `manufacturer`, `vendor` | PNP id (`DEL`) and the name for known ids |
| `productCode`, `serial`, `serialText`, `name` | product code (hex), serial number as a number and as text, model name |
| `week`, `year` | manufacture, 0 when unknown |
| `widthCm`, `heightCm`, `diagonal` | size; 0 for projectors without a size |
| `preferred` | first detailed resolution: `width`, `height`, `refresh` |

Extension blocks (CEA-861, DisplayID) are counted in `extensions`, not
read. Fewer than 128 bytes raise `{TCLUTILS TUEDID SHORT}`, a missing
EDID header `{TCLUTILS TUEDID HEADER}`, text that is not hex
`{TCLUTILS TUEDID HEX}`.

---

## tudeploy

[tudeploy]{.index} finds the module directories and resources that an
application brings along next to itself, adds them to `tcl::tm::path`
and loads packages from them. It knows no particular application;
directories and packages come as arguments. The module is also an
ensemble: `::tclutils::tudeploy roots` and `::tclutils::tudeploy::roots`
are the same call.

```tcl
::tclutils::tudeploy::baseDirs
::tclutils::tudeploy::platformTag
::tclutils::tudeploy::roots ?option wert ...?
::tclutils::tudeploy::addModulePaths ?option wert ...?
::tclutils::tudeploy::require pakete ?option wert ...?
::tclutils::tudeploy::resourceDirs name ?option wert ...?
::tclutils::tudeploy::sourceModule paket ?option wert ...?
```

`baseDirs` returns the directories of the main script (`argv0`) and of
the running program (`info nameofexecutable`), normalized, without
duplicates, only existing ones. `platformTag` returns `<os><bits>`:

| `tcl_platform` | Result |
|---|---|
| `platform` = `windows` | `windows32` or `windows64` |
| `platform` = `unix`, `os` = `Darwin` | `macos32` or `macos64` |
| `platform` = `unix`, any other `os` | `linux32` or `linux64` |

The bits come from `tcl_platform(pointerSize)`. BSD systems therefore
also get `linux…`.

### roots and addModulePaths

| Option | Default | Effect |
|---|---|---|
| `-base` | `[baseDirs]` | base directories |
| `-env` | `{}` | names of environment variables; their values come unchanged at the start |
| `-roots` | `vendor {libs common} libs {lib tm}` | subpaths per base, each as a list of path parts |
| `-parents` | `1` | also search the parent directories of the bases |

`roots` returns the existing directories in this order: first the
values of the `-env` variables that are set and not empty; then, for
each base, each subpath from `-roots`; with `-parents 1` after that the
same for each parent directory. A root directory contains package
folders: `<wurzel>/<paket>/<modul>-<version>.tm` gives
`package require <paket>::<modul>`.

`addModulePaths` takes the same options, calls `tcl::tm::path add` for
each root and returns the roots that are in the module path afterwards,
newly added or already present. If `tcl::tm::path` rejects a directory
because it lies inside one already added or contains one,
`addModulePaths` skips it without an error and leaves it out of the
return value.

```tcl
package require tclutils::tudeploy
::tclutils::tudeploy::platformTag     ;# linux64, windows64, macos64 …
::tclutils::tudeploy::roots -base [list $appdir] -parents 0
```

With `$appdir/vendor` and `$appdir/lib/tm` present, `roots` returns the
list `$appdir/vendor $appdir/lib/tm`.

### require

`require pakete ?option wert ...?` adds the roots and runs
`package require` for each package.

| Option | Default | Effect |
|---|---|---|
| `-tmadd` | `1` | call `addModulePaths` with the remaining options first |
| `-fail` | `0` | fail on missing packages instead of returning `0` |
| `-base`, `-env`, `-roots`, `-parents` | as for `roots` | passed to `addModulePaths` |

The return value is `1` if all packages are loaded, otherwise `0`. With
`-fail 1`, `require` fails with `{TCLUTILS TUDEPLOY REQUIRE}`; the
message names the missing packages:
`package(s) not found: foo::nix`. Even with `-tmadd 0`, `require`
checks the options of `roots`; `-tmadd` and `-fail` must be boolean.

```tcl
if {![::tclutils::tudeploy::require {meinlib::kern meinlib::ui}]} {
    error "Module fehlen"
}
```

### resourceDirs

`resourceDirs name ?option wert ...?` returns the existing directories
in which a bundled resource can be located, for example a decoder. Per
base, with `-parents 1` also per parent directory, in this order:

1. `vendor/<name>/<tag>`
2. `vendor/<name>`
3. `vendor/<tag>`
4. `vendor`
5. `bin`
6. the base itself

| Option | Default | Effect |
|---|---|---|
| `-base`, `-env`, `-parents` | as for `roots` | |
| `-tag` | `[platformTag]` | platform folder |

`resourceDirs` does not know `-roots`. An empty name gives
`{TCLUTILS TUDEPLOY USAGE}`. The list fits directly into
`tuexe::find -dirs`:

```tcl
set dirs [::tclutils::tudeploy::resourceDirs webp -env MYAPP_WEBP]
set exe [::tclutils::tuexe::find dwebp -dirs $dirs]
```

### sourceModule

`sourceModule paket ?option wert ...?` loads a package whose `.tm` is
not in the place its name requires, for example a package `qpdf` as
`vendor/qpdf/lib/qpdf-0.2.tm`. A separate entry `vendor/qpdf/lib` in
the module path fails because it lies below `vendor`. `sourceModule`
therefore searches the directories for
`<letzter Namensteil>-<version>.tm`, sorted by version in descending
order, and runs `source` at global level until the package is present.

| Option | Default | Effect |
|---|---|---|
| `-dirs` | `{}` | directories directly; otherwise `roots` with the remaining options |
| `-fail` | `0` | fail on failure instead of returning `0` |
| `-base`, `-env`, `-roots`, `-parents` | as for `roots` | only without `-dirs` |

Return value `1` or `0`; with `-fail 1` `{TCLUTILS TUDEPLOY REQUIRE}`
with `could not source module for package: <paket>`. `sourceModule`
checks the options first; if the package is already loaded after that,
it returns `1` at once. It skips files whose version part is not a
valid version and files whose `source` fails.

```tcl
::tclutils::tudeploy::sourceModule qpdf -env QPDF_TM \
    -roots {{vendor qpdf lib}}
```

| Case | Code |
|---|---|
| unknown option, option without value, argument without `-` | `{TCLUTILS TUDEPLOY OPTION}` |
| `-tmadd`, `-fail` not boolean | `{TCLUTILS TUDEPLOY VALUE}` |
| `resourceDirs` without a name | `{TCLUTILS TUDEPLOY USAGE}` |
| package missing, with `-fail 1` | `{TCLUTILS TUDEPLOY REQUIRE}` |

An application must first make `tclutils` itself loadable before it
can use `tudeploy`. How `tclutils` gets into the module path is
described in the chapter [Installation](020-installation.md).

---

## tuexe

[tuexe]{.index} searches for external programs in bundled directories
and in the `PATH`, trying several names.

```tcl
::tclutils::tuexe::find namen ?-dirs liste? ?-pathfirst 0|1? ?-all 0|1?
::tclutils::tuexe::all namen ?-dirs liste? ?-pathfirst 0|1?
::tclutils::tuexe::exists namen ?-dirs liste? ?-pathfirst 0|1?
```

| Option | Default | Effect |
|---|---|---|
| `-dirs` | `{}` | additional directories |
| `-pathfirst` | `0` | `1`: first `PATH`, then `-dirs` |
| `-all` | `0` | `1`: all matches instead of the first |

`namen` is a name or a list. For each name in turn, `find` first
searches all `-dirs`, then the `PATH` (the other way round with
`-pathfirst 1`), and returns the first match as a normalized path,
otherwise `""`. A later name is tried only if the earlier one is found
nowhere: with `{gs gswin64c}`, a `gs` in the `PATH` wins over a
`gswin64c` in `-dirs`. `all` returns all matches without duplicates in
search order, `exists` returns `1` or `0`.

In the `PATH`, `tuexe` searches with `auto_execok` and takes its first
word. In the `-dirs`, according to the code:

| Platform | Checked |
|---|---|
| Linux, macOS | `<dir>/<name>`; regular file and executable |
| Windows | `<dir>/<name>`, then `<dir>/<name><ext>` for each extension from `PATHEXT` (lowercase), without `PATHEXT` `.exe .com .bat .cmd`; regular file, no check for executability |

```tcl
package require tclutils::tuexe
::tclutils::tuexe::find {gs gswin64c gswin32c}   ;# Pfad oder ""
::tclutils::tuexe::find qpdf -dirs [list $vendorBin]
::tclutils::tuexe::exists gibtsnicht             ;# -> 0
```

Under Linux, `find sh` returns, for example, `/usr/bin/sh`; with an
executable `sh` in `$vendorBin` and `-dirs [list $vendorBin]` its
path, with `-pathfirst 1` in addition `/usr/bin/sh` again.

An unknown option gives `{TCLUTILS TUEXE OPTION}` with
`unknown option '<opt>'`, an option without a value (`find sh -dirs`)
the same code with `option '<opt>' requires a value`.

---

## tuopen

[tuopen]{.index} opens a URL or file with the system's default
program, a file in the editor or a folder in the file manager, and
names the configuration directory of an application.

| Command | Effect | Return value |
|---|---|---|
| `command ziel ?-platform p? ?-os o?` | build the command for opening, do not run it | command list |
| `launch ziel ?-platform p? ?-os o?` | start the command in the background | command list |
| `editCommand ziel ?-editor cmd? ?-platform p? ?-os o?` | build the editor command | command list |
| `edit ziel ?-editor cmd? ?-platform p? ?-os o?` | start the editor | command list |
| `openDir ziel ?-platform p? ?-os o?` | open a folder; if `ziel` is a file, its folder | command list |
| `configDir app ?-platform p? ?-os o?` | configuration directory | path |
| `configFile app datei ?-platform p? ?-os o?` | file in it | path |

| Option | Default | Effect |
|---|---|---|
| `-platform` | `tcl_platform(platform)` | `windows` or other |
| `-os` | `tcl_platform(os)` | if it contains `darwin` (case-insensitive), macOS applies |
| `-editor` | `""` | custom editor command, also several words; takes precedence over everything else |

What is produced per platform according to the code:

| | Windows | macOS | Linux and other Unix |
|---|---|---|---|
| `command`, URL | `rundll32 url.dll,FileProtocolHandler <ziel>` | `open <ziel>` | `xdg-open <ziel>` |
| `command`, otherwise | `cmd.exe /c start "" <ziel>` | `open <ziel>` | `xdg-open <ziel>` |
| `editCommand` | `notepad <ziel>` | `open -e <ziel>` | `$EDITOR <ziel>`, otherwise `xdg-open <ziel>` |
| `configDir` | `%APPDATA%\<app>`, otherwise `%USERPROFILE%\AppData\Roaming\<app>` | `~/Library/Application Support/<app>` | `$XDG_CONFIG_HOME/<app>`, otherwise `~/.config/<app>` |

Under Windows, a target counts as a URL if it starts with a scheme of
at least two characters and `:` (`https:`, `mailto:`); `C:/…` is a
drive. `rundll32` passes the URL on without `cmd.exe`, so an `&` in
the query stays part of the URL. `cmd.exe` would split the command
there.

`$EDITOR` is read as a list; `vim -n` gives `vim -n <ziel>`. The home
directory is `$HOME`, without `HOME` `file normalize ~`.
`configDir` creates nothing. [tusettings](080-tusettings.md) names the
same directory under Linux and macOS and writes INI files into it;
under Windows only the fallback without `APPDATA` differs.

`command`, `editCommand` and `configDir` start nothing; with `-platform`
and `-os` they show the result for each platform:

```tcl
package require tclutils::tuopen
::tclutils::tuopen::command https://tcl.tk/ -platform windows
            ;# -> rundll32 url.dll,FileProtocolHandler https://tcl.tk/
::tclutils::tuopen::command C:/doc/a.pdf -platform windows
                          ;# -> cmd.exe /c start {} C:/doc/a.pdf
::tclutils::tuopen::command a.pdf -platform unix -os Darwin
                          ;# -> open a.pdf
::tclutils::tuopen::editCommand notiz.txt -editor {code -w}
                          ;# -> code -w notiz.txt
::tclutils::tuopen::configDir meineapp -platform unix -os Linux
                          ;# ~/.config/meineapp, mit $HOME aufgelöst
```

`launch`, `edit` and `openDir` run the command with `exec … &` and
return it. `launch` returns as soon as the process has started; it does
not report whether the program can open the file afterwards.

```tcl
::tclutils::tuopen::launch https://tcl.tk/
::tclutils::tuopen::openDir [file join $dir bericht.pdf]
```

| Case | Code |
|---|---|
| `ziel` empty or whitespace only | `{TCLUTILS TUOPEN TARGET}` |
| `app` empty or whitespace only | `{TCLUTILS TUOPEN APP}` |
| `exec` fails, for example without `xdg-open` | `{TCLUTILS TUOPEN LAUNCH}`, `cannot open "<ziel>": …` or `cannot edit …` |
| unknown option | `{TCLUTILS COMMON OPTION <opt>}` |

`namespace export` lists all seven commands; after
`namespace import ::tclutils::tuopen::*` they are available without a
prefix.

---

## tuzipfs

[tuzipfs]{.index} wraps `zipfs` from Tcl 9: mounting and reading ZIP
archives and building standalone programs (zipkits). The package also
loads under Tcl 8.6 and is part of the umbrella. Commands that need
`zipfs` fail there with `{TCLUTILS TUZIPFS UNAVAILABLE}`, message
`zipfs is not available in this Tcl interpreter; Tcl 9 is required`.
`tuzip` reads and writes ZIP files under Tcl 8.6, see
[Text and Files](040-text-und-dateien.md).

| Command | Effect | Tcl 8.6 |
|---|---|---|
| `available` | `1` if the command `zipfs` exists | `0` |
| `requireAvailable` | `1`, otherwise an error | `UNAVAILABLE` |
| `root` | `zipfs root`, that is `//zipfs:/` | `UNAVAILABLE` |
| `mounts` | `zipfs mount`: pairs of mount point and archive | `UNAVAILABLE` |
| `mount archiv ?name?` | mount, returns `//zipfs:/<name>` | `UNAVAILABLE` |
| `unmount punkt` | unmount, returns `punkt` | `UNAVAILABLE` |
| `listFiles punkt ?-glob m? ?-recursive b?` | entries, sorted | `UNAVAILABLE` |
| `find punkt ?…?` | the same as `listFiles` | `UNAVAILABLE` |
| `exists pfad` | `zipfs exists` | `UNAVAILABLE` |
| `readFile pfad` | content as bytes | `UNAVAILABLE` |
| `withMounted archiv var rumpf ?-mount name?` | mount, run the body, unmount | `UNAVAILABLE` |
| `rcopy quelle ziel` | recursive byte copy, returns `ziel` | works |
| `copyStdlib ziel ?-tk b? ?-from q?` | copy `tcl_library` (and `tk_library`) | works |
| `mkimg datei vfs ?…?` | `zipfs mkimg` with checks | `UNAVAILABLE` |
| `buildImage -out datei -vfs dir ?…?` | `copyStdlib`, then `mkimg` | option check and `copyStdlib` work, `mkimg` fails |

### Reading an archive

`mount` without a name generates `tclutils_<pid>_<clicks>`. A missing
archive is reported by `zipfs` itself with `{POSIX ENOENT …}`.

| Option of `listFiles` | Default | Effect |
|---|---|---|
| `-glob` | `*` | pattern against the last name part or the whole path |
| `-recursive` | `1` | `1`: all entries through `zipfs find`; `0`: only the top level through `glob` |

The list also contains directories. With `-recursive 0`, `-glob`
applies only to the top level. `readFile` reads in binary mode; text is
produced with `encoding convertfrom`.

`withMounted` mounts, sets the variable in the caller's context to the
mount point, runs the body there and always unmounts afterwards, also
after an error. The return value is the result of the body.

```tcl
package require tclutils::tuzipfs
if {[::tclutils::tuzipfs::available]} {
    ::tclutils::tuzipfs::withMounted $zip mp {
        set xml [::tclutils::tuzipfs::listFiles $mp -glob *.xml]
        set txt [::tclutils::tuzipfs::readFile $mp/notiz.txt]
    }
}
```

For an archive with `notiz.txt` (content `Hallo`) and `sub/a.xml`, under
Tcl 9 this gives `xml` = `//zipfs:/tclutils_<pid>_<clicks>/sub/a.xml`
and `txt` = `Hallo`; without `-glob` the list would also contain
`…/notiz.txt` and the directory `…/sub`.

### Building a program

`zipfs mkimg` replaces the ZIP archive attached to the basekit. A
basekit from BAWT or Magicsplat carries its standard library in this
archive (`//zipfs:/app/tcl_library`). An image with only the
application loses it and does not start. `copyStdlib` therefore puts it
into the VFS tree beforehand.

`rcopy` copies byte by byte and can also read from a mounted `zipfs`.
It copies files and folders whose name starts with a dot; it skips `.`
and `..`.

| Option of `copyStdlib` | Default | Effect |
|---|---|---|
| `-tk` | `0` | also copy `tk_library` |
| `-from` | `running` | `running`: `info library` and `$::tk_library` of the running interpreter; otherwise a directory with `tcl_library/` (and `tk_library/`), for example the mount point of another basekit |

| Option of `mkimg` | Default | Effect |
|---|---|---|
| `-strip` | the VFS directory | path prefix that is dropped in the archive |
| `-basekit` | running program | template; if not given, the running program must itself be a zipkit |
| `-password` | `""` | password for the archive |

| Option of `buildImage` | Default | Effect |
|---|---|---|
| `-out` | – | output file, required |
| `-vfs` | – | finished VFS tree, required |
| `-basekit` | `""` | passed to `mkimg` |
| `-stdlib` | `none` | `none`, `cli` (only `tcl_library`) or `gui` (with `tk_library`) |
| `-stdlibfrom` | `running` | passed to `copyStdlib -from` |

```tcl
file mkdir app.vfs
file copy meineapp.tcl [file join app.vfs main.tcl]
::tclutils::tuzipfs::buildImage -out meineapp -vfs app.vfs \
    -basekit basekit-tcl -stdlib cli
```

`buildImage` returns the output file. `main.tcl` at the root of the
archive starts when the program is called. Whether the result runs
without an installed Tcl depends on the basekit: only a statically
built one is standalone.

| Case | Code |
|---|---|
| `zipfs` missing | `{TCLUTILS TUZIPFS UNAVAILABLE}` |
| `-tk 1` without `tk_library` | `{TCLUTILS TUZIPFS NOTK}` |
| `-from` without `tcl_library` | `{TCLUTILS TUZIPFS NOSTDLIB}` |
| `mkimg`: VFS not a directory | `{TCLUTILS TUZIPFS NODIR}` |
| `buildImage` without `-out`/`-vfs`, wrong `-stdlib` | `{TCLUTILS TUZIPFS OPTION}` |
| `-recursive`, `-tk` not boolean | `{TCLUTILS COMMON BOOLEAN <opt>}` |
| unknown option | `{TCLUTILS COMMON OPTION <opt>}` |

---

## tuterm

[tuterm]{.index} generates ANSI control sequences (SGR) for font
attributes and colors in the terminal and removes them again.

| Command | Return value |
|---|---|
| `style ?spec ...?` | control sequence; `""` if switched off |
| `wrap text ?spec ...?` | control sequence, text, reset; only the text if switched off |
| `off attr` | sequence for switching off an attribute |
| `names ?was?` | `all` (default): categories; `fg`/`bg`: color names; an attribute: `on off`; `reset` and anything unknown: `{}` |
| `strip text` | text without sequences of the form `ESC [ … m` |
| `enable ?bool?` | read or set the switch; returns the state |
| `auto` | set the switch from `NO_COLOR`; returns the state |
| `enableVT`, `disableVT` | VT mode of the Windows console; `1` on success |

| Spec | Effect |
|---|---|
| `reset` | reset everything |
| `bold` `dim` `italic` `underline` `blink` `reverse` `invisible` `strike` | attribute on |
| `<attr>:on`, `<attr>:off` | attribute on or off |
| `fg:<farbe>`, `bg:<farbe>` | foreground and background; `fgcolor:` and `bgcolor:` are equivalent |

A color is a name (`black` … `white`, `gray`, `bright_black` …
`bright_white`), an index `0` to `255` (256 colors) or `#rrggbb`
(24 bit). `gray` and `bright_black` are the same color. Each spec is a
separate argument; `"fg:red bold"` as one argument is an unknown
color.

```tcl
package require tclutils::tuterm
proc zeige {s} { string map [list \x1b {\e}] $s }
zeige [::tclutils::tuterm::style bold fg:red]   ;# -> \e[1m\e[31m
zeige [::tclutils::tuterm::wrap OK fg:green]    ;# -> \e[32mOK\e[0m
zeige [::tclutils::tuterm::style fg:208 bg:#00aa00]
                          ;# -> \e[38;5;208m\e[48;2;0;170;0m
zeige [::tclutils::tuterm::off underline]       ;# -> \e[24m
::tclutils::tuterm::strip [::tclutils::tuterm::wrap OK bold]
                                                ;# -> OK
::tclutils::tuterm::enable 0                    ;# -> 0
::tclutils::tuterm::wrap OK bold                ;# -> OK
::tclutils::tuterm::enable 1                    ;# -> 1
```

After loading, `tuterm` is switched on, even if `NO_COLOR` is set or
the output goes to a file. Only `auto` evaluates `NO_COLOR`: if the
variable exists, even empty, it switches off, otherwise on. `tuterm`
does not check whether `stdout` is a terminal. When switched off,
`style` does not check the specs; typing errors then go unnoticed.

Platform according to the code: outside Windows, `enableVT` and
`disableVT` return `1` at once. Under Windows they set or clear the bit
`0x0004` in the console mode of `stdout` through the package `twapi`;
if `twapi` is missing or the call fails, they return `0`.

| Case | Code |
|---|---|
| unknown spec or `attr:` with a value other than `on`/`off` | `{TCLUTILS TUTERM STYLE}` |
| unknown color, index outside 0–255 | `{TCLUTILS TUTERM VALUE}` |
| `off` for `reset` or a color category | `{TCLUTILS TUTERM CATEGORY}` |
| `enable` with a non-boolean value | `{TCLUTILS COMMON BOOLEAN bool}` |

`enable` accepts every boolean value of Tcl (`0`/`1`, `yes`/`no`,
`true`/`false`, `on`/`off`) and returns `0` or `1`; after an
error the switch stays unchanged.

---

## tupagespec

[tupagespec]{.index} translates page specifications such as `1-3,5,7-`
into a list of page numbers and a list back into the short form.

```tcl
::tclutils::tupagespec::parse angabe gesamt ?-base 1?
::tclutils::tupagespec::count angabe gesamt
::tclutils::tupagespec::compact seiten
```

| Part | Meaning |
|---|---|
| empty, `all`, `*` | all pages |
| `N` | one page |
| `A-B` | range; `A > B` is swapped |
| `A-` | `A` to `gesamt` |
| `-B` | 1 to `B` |
| `end`, `last` | stands for `gesamt` |

Parts are separated by commas; `parse` ignores whitespace around a
comma and empty parts, case does not matter. Whitespace inside a part
(`1 - 3`) is a syntax error.

| Option | Default | Effect |
|---|---|---|
| `-base` | `1` | `1`: pages from 1; `0`: each number one less |

`parse` returns the pages sorted and without duplicates, `count` their
number (without `-base`). `compact` sorts, removes duplicates and
combines runs into `A-B`; an empty list gives `""`.

```tcl
package require tclutils::tupagespec
::tclutils::tupagespec::parse "1-3,5" 10        ;# -> 1 2 3 5
::tclutils::tupagespec::parse "5-" 8            ;# -> 5 6 7 8
::tclutils::tupagespec::parse "-3" 8            ;# -> 1 2 3
::tclutils::tupagespec::parse "4-last" 6        ;# -> 4 5 6
::tclutils::tupagespec::parse "5-3,1,1" 10      ;# -> 1 3 4 5
::tclutils::tupagespec::parse "2-4" 10 -base 0  ;# -> 1 2 3
::tclutils::tupagespec::count "1-3,5" 10        ;# -> 4
::tclutils::tupagespec::compact {8 7 1 2 2 3}   ;# -> 1-3,7-8
```

| Case | Code |
|---|---|
| part not readable | `{TCLUTILS TUPAGESPEC SYNTAX}`, `invalid page-spec part: '<teil>'` |
| page outside `1..gesamt` | `{TCLUTILS TUPAGESPEC RANGE}`, `page <n> out of range (1..<gesamt>)` |
| unknown option | `{TCLUTILS TUPAGESPEC OPTION}` |
| `-base` not 0 or 1; `gesamt` not a non-negative integer | `{TCLUTILS TUPAGESPEC VALUE}` |

Page 0 and ranges past the end (`8-12` with 10 pages) are
`RANGE` errors, not silent truncations.

Numbers are sequences of the ASCII digits `0` to `9` and always
decimal, also with a leading zero; the same applies under Tcl 8.6 and
9. This also applies to a `gesamt` made of digits only:

```tcl
::tclutils::tupagespec::parse 08 10             ;# -> 8
::tclutils::tupagespec::parse 07-09 10          ;# -> 7 8 9
::tclutils::tupagespec::parse 9-end 010         ;# -> 9 10
```

---

## tulayout

[tulayout]{.index} calculates page layouts in millimeters, origin at
the top left: paper sizes, conversion to pixels, grid and blocks. A
block is a dict; a layout has a sub-dict `blocks` from block ID to
block. The Tk editor for it is described in the book *tkutils*
(`tkulayoutcanvas`).

| Key | Meaning |
|---|---|
| `label` | label |
| `x`, `y`, `w`, `h` | position and size in mm |
| `show` | `1` visible, `0` hidden |
| `lockedY` | `1`: vertical position automatic |

### Page and scale

| Command | Return value |
|---|---|
| `pageSize papier ?ausrichtung?` | `{breite höhe}` in mm |
| `mmToPx mm maßstab` | `mm * maßstab` |
| `pxToMm px maßstab` | `px / maßstab` |
| `snap mm ?-grid 5.0?` | rounded to the grid |
| `fitScale seiteB seiteH sichtB sichtH ?-marginPx 20?` | largest scale at which the page including the margin fits into the view |

`pageSize` knows `a4` (210 × 297), `a5` (148 × 210) and `letter`
(216 × 279), case-insensitive. A custom size in mm is given as a list
`{breite höhe}` or as `BxH` or `BXH`, for example `54x56` or
`80.5X200`; both parts must be positive numbers. `1.2.3x5` is a
`PAPER` error. Only `landscape` swaps width and height; any other value counts as portrait. `fitScale` calculates
`min((sichtB - 2*rand) / seiteB, (sichtH - 2*rand) / seiteH)`.

```tcl
package require tclutils::tulayout
::tclutils::tulayout::pageSize A4 landscape     ;# -> 297 210
::tclutils::tulayout::pageSize 54x56            ;# -> 54 56
::tclutils::tulayout::mmToPx 210 2              ;# -> 420.0
::tclutils::tulayout::snap 12.6                 ;# -> 15.0
::tclutils::tulayout::snap 7 -grid 2            ;# -> 8
::tclutils::tulayout::fitScale 210 297 800 600 -marginPx 0
                                       ;# -> 2.0202020202020203
```

### Blocks

| Command | Effect |
|---|---|
| `defaultBlockKeys` | `x y w h show label lockedY` |
| `isAutoY block` | `1` if `lockedY` is true or `y == 0` |
| `normalizeBlock block ?-defaults d?` | only `label x y w h show lockedY`, missing ones from `d`; `x y w h` as floating-point numbers, `show` as 0/1 |
| `validateBlocks blocks` | normalize and check each block; returns the new dict |
| `ensureBlocks blocks definitionen` | complete blocks with their definitions, create missing ones, check everything |
| `blockOrder blocks ?definitionen?` | IDs: without definitions sorted; with definitions first their order, then the rest |
| `blockRect block ?-height h?` | `{x1 y1 x2 y2}` |
| `mergeBlocks basis vorlage ?-keys k?` | take keys `k` from the template into blocks of the same name in the base |
| `mergeLayout ziel vorlage ?-keys k?` | `mergeBlocks` on `blocks` of two layouts |

The default for `-defaults` is `x 0 y 0 w 40 h 8 show 1`, for `-keys`
`x y w show`. `mergeBlocks` skips blocks of the template that are
missing in the base and takes over values unchanged, without
normalizing them. `blockRect` takes the height from `-height`,
otherwise from the block, otherwise 8.

```tcl
set blocks {
    kopf    {label Kopf x 20 y 30 w 170 h 15 show 1}
    tabelle {label Tabelle x 20 y 0 w 170 h 40 show 1}
}
::tclutils::tulayout::isAutoY [dict get $blocks tabelle]  ;# -> 1
::tclutils::tulayout::blockRect [dict get $blocks kopf]
                                    ;# -> 20.0 30.0 190.0 45.0
set m [::tclutils::tulayout::mergeBlocks $blocks {kopf {x 25 h 99}}]
dict get $m kopf x                                        ;# -> 25
dict get $m kopf h                                        ;# -> 15
::tclutils::tulayout::blockOrder $blocks     ;# -> kopf tabelle
```

`ensureBlocks` completes each existing block with the keys it lacks:
first from its definition, then from the default values of
`-defaults`. A value in the block takes precedence over the definition.
An ID that appears only in the definitions is created from its
definition alone. `blocks` may be empty; then everything comes from the
definitions. `ensureBlocks` checks the result like `validateBlocks`.

```tcl
set e [::tclutils::tulayout::ensureBlocks {kopf {x 20}} \
    {kopf {w 170 h 15} fuss {x 20 y 280 w 170 h 10}}]
dict get $e kopf          ;# -> x 20.0 y 0.0 w 170.0 h 15.0 show 1
dict get $e fuss                ;# -> x 20.0 y 280.0 w 170.0 h 10.0
::tclutils::tulayout::ensureBlocks {} {kopf {w 170 h 15}}
                                        ;# -> kopf {w 170.0 h 15.0}
```

| Case | Code |
|---|---|
| unknown paper, size not readable or not positive | `{TCLUTILS TULAYOUT PAPER}` |
| scale not positive | `{TCLUTILS TULAYOUT SCALE}` |
| grid not positive | `{TCLUTILS TULAYOUT GRID}` |
| unknown option, option without value | `{TCLUTILS TULAYOUT OPTION}` |
| `validateBlocks`: `blocks` empty or not a dict; `ensureBlocks`: `blocks`, definitions or a block not a dict | `{TCLUTILS TULAYOUT BLOCKS}` |
| empty block ID | `{TCLUTILS TULAYOUT BLOCKID}` |
| `x`, `y`, `w`, `h` not a number or negative, `show` not boolean | `{TCLUTILS TULAYOUT VALUE}` |
| layout without `blocks` | `{TCLUTILS TULAYOUT LAYOUT}` |
| view minus twice the margin not positive | `{TCLUTILS TULAYOUT VIEWPORT}` |

The message for `VALUE` names the block and the key, for example
`block 'kopf': bad x 'abc'` or `block 'kopf': height must be >= 0`.
`snap`, `normalizeBlock`, `blockRect`, `mergeBlocks`, `mergeLayout`
and `fitScale` check options in the same way: only the option named
for each is allowed.

---

*Next chapter: [Network and HTTPS](070-netz-und-https.md)*
