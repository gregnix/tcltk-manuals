# 06 — os-release und /proc

```tcl
# /etc/os-release: ID=debian  VERSION_CODENAME=forky
set fh [open /proc/self/comm r]
set comm [string trim [read $fh]]
close $fh
file readlink /proc/self/exe    ;# z.B. /usr/bin/tclsh8.6
```

Distribution nicht aus `uname` raten. Prozessinfo: `/proc/self/`, nicht
Windows-Registry.

## Demo

```bash
tclsh howto/06-os-release.tcl
```
